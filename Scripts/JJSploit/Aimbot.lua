-- Simple Aimbot for JJSploit (no Drawing API, just mouse movement)

-- Settings
local aimbotEnabled = true
local teamCheck = true
local aimPart = "Head"
local sensitivity = 0.15
local triggerKey = Enum.KeyCode.E

-- Services
local players = game:GetService("Players")
local runService = game:GetService("RunService")
local uis = game:GetService("UserInputService")
local camera = workspace.CurrentCamera
local localPlayer = players.LocalPlayer
local mouse = localPlayer:GetMouse()

-- Functions
local function getClosestPlayer()
    local closestPlayer = nil
    local shortestDistance = math.huge

    for _, player in pairs(players:GetPlayers()) do
        if player ~= localPlayer and player.Character and player.Character:FindFirstChild(aimPart) then
            if teamCheck and player.Team == localPlayer.Team then
                continue
            end

            local pos, onScreen = camera:WorldToViewportPoint(player.Character[aimPart].Position)
            if onScreen then
                local distance = (Vector2.new(mouse.X, mouse.Y) - Vector2.new(pos.X, pos.Y)).Magnitude
                if distance < shortestDistance then
                    shortestDistance = distance
                    closestPlayer = player
                end
            end
        end
    end

    return closestPlayer
end

-- Main Loop
runService.RenderStepped:Connect(function()
    if not aimbotEnabled then return end
    if not uis:IsKeyDown(triggerKey) then return end

    local target = getClosestPlayer()
    if target and target.Character and target.Character:FindFirstChild(aimPart) then
        local aimPosition = camera:WorldToViewportPoint(target.Character[aimPart].Position)
        mousemoverel((aimPosition.X - mouse.X) * sensitivity, (aimPosition.Y - mouse.Y) * sensitivity)
    end
end)
