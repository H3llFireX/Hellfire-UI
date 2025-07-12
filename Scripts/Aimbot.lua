-- HellFire Aimbot (Universal)
-- Made for use with HellFireAPI (Velocity)

-- Configuration
local Settings = {
    Enabled = true,
    TeamCheck = true,
    WallCheck = true,
    HealthCheck = true,
    FieldOfView = 120,
    TriggerKey = Enum.KeyCode.E,
    AimPart = "Head",
    Smoothness = 0.15
}

-- Services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Camera = workspace.CurrentCamera

-- Variables
local LocalPlayer = Players.LocalPlayer
local Holding = false

-- Functions
local function IsValidTarget(player)
    if not player.Character or not player.Character:FindFirstChild(Settings.AimPart) then return false end
    if Settings.HealthCheck then
        local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
        if not humanoid or humanoid.Health <= 0 then return false end
    end
    if Settings.TeamCheck and player.Team == LocalPlayer.Team then return false end
    if Settings.WallCheck then
        local origin = Camera.CFrame.Position
        local part = player.Character[Settings.AimPart]
        local _, onScreen = Camera:WorldToViewportPoint(part.Position)
        if not onScreen then return false end

        local rayParams = RaycastParams.new()
        rayParams.FilterType = Enum.RaycastFilterType.Blacklist
        rayParams.FilterDescendantsInstances = {LocalPlayer.Character, player.Character}
        local result = workspace:Raycast(origin, (part.Position - origin), rayParams)
        if result and result.Instance and not player.Character:IsAncestorOf(result.Instance) then
            return false
        end
    end
    return true
end

local function GetClosestTarget()
    local closest = nil
    local shortest = Settings.FieldOfView

    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and IsValidTarget(player) then
            local part = player.Character[Settings.AimPart]
            local screenPos, onScreen = Camera:WorldToViewportPoint(part.Position)
            if onScreen then
                local mousePos = UserInputService:GetMouseLocation()
                local dist = (Vector2.new(screenPos.X, screenPos.Y) - Vector2.new(mousePos.X, mousePos.Y)).Magnitude
                if dist < shortest then
                    shortest = dist
                    closest = part
                end
            end
        end
    end

    return closest
end

-- Aimbot Logic
UserInputService.InputBegan:Connect(function(input, gpe)
    if gpe then return end
    if input.KeyCode == Settings.TriggerKey then
        Holding = true
    end
end)

UserInputService.InputEnded:Connect(function(input, gpe)
    if input.KeyCode == Settings.TriggerKey then
        Holding = false
    end
end)

RunService.RenderStepped:Connect(function()
    if not Settings.Enabled or not Holding then return end
    local target = GetClosestTarget()
    if target then
        local camCF = Camera.CFrame.Position
        local direction = (target.Position - camCF).Unit
        local newCF = CFrame.new(camCF, camCF + direction)
        Camera.CFrame = Camera.CFrame:Lerp(newCF, Settings.Smoothness)
    end
end)
