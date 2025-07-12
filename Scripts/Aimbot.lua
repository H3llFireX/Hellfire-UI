--// Universal Aimbot Script (HellFire Edition)

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

local Holding = false

--// Settings
local Settings = {
    TriggerKey = Enum.UserInputType.MouseButton2, -- Right mouse button
    AimbotEnabled = true,
    TeamCheck = true,
    WallCheck = true,
    HealthCheck = true,
    LockPart = "Head",
    Smoothness = 0.15,
    AimRadius = 150
}

--// Helper Functions
local function IsVisible(target)
    local origin = workspace.CurrentCamera.CFrame.Position
    local direction = (target.Position - origin).Unit * 500
    local raycastParams = RaycastParams.new()
    raycastParams.FilterDescendantsInstances = {LocalPlayer.Character, target.Parent}
    raycastParams.FilterType = Enum.RaycastFilterType.Blacklist
    local result = workspace:Raycast(origin, direction, raycastParams)
    return not result or result.Instance:IsDescendantOf(target.Parent)
end

local function IsOnSameTeam(player)
    return player.Team == LocalPlayer.Team
end

local function GetCharacter(player)
    if not player.Character then return nil end
    local hrp = player.Character:FindFirstChild("HumanoidRootPart")
    local hum = player.Character:FindFirstChildOfClass("Humanoid")
    if not hrp or not hum or hum.Health <= 0 then return nil end
    return player.Character
end

local function GetClosestPlayer()
    local closest, closestDist = nil, Settings.AimRadius
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            if Settings.TeamCheck and IsOnSameTeam(player) then continue end
            local character = GetCharacter(player)
            if not character then continue end
            local part = character:FindFirstChild(Settings.LockPart)
            if not part then continue end
            if Settings.HealthCheck and character:FindFirstChildOfClass("Humanoid").Health <= 0 then continue end
            if Settings.WallCheck and not IsVisible(part) then continue end

            local screenPos, onScreen = workspace.CurrentCamera:WorldToViewportPoint(part.Position)
            if not onScreen then continue end

            local distance = (Vector2.new(screenPos.X, screenPos.Y) - UserInputService:GetMouseLocation()).Magnitude
            if distance < closestDist then
                closest = part
                closestDist = distance
            end
        end
    end
    return closest
end

--// Aimbot Logic
RunService.RenderStepped:Connect(function()
    if not Settings.AimbotEnabled or not Holding then return end
    local target = GetClosestPlayer()
    if target then
        local cam = workspace.CurrentCamera
        local targetPos = cam:WorldToScreenPoint(target.Position)
        local mousePos = UserInputService:GetMouseLocation()
        local newPos = Vector2.new(
            mousePos.X + (targetPos.X - mousePos.X) * Settings.Smoothness,
            mousePos.Y + (targetPos.Y - mousePos.Y) * Settings.Smoothness
        )
        mousemoverel(newPos.X - mousePos.X, newPos.Y - mousePos.Y)
    end
end)

--// Input Detection
UserInputService.InputBegan:Connect(function(input, gpe)
    if gpe then return end
    if input.UserInputType == Settings.TriggerKey then
        Holding = true
    end
end)

UserInputService.InputEnded:Connect(function(input, gpe)
    if input.UserInputType == Settings.TriggerKey then
        Holding = false
    end
end)
