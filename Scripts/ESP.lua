--// ESP Settings
getgenv().ESPSettings = {
    Enabled = true,
    TeamCheck = true,
    HealthCheck = true,
    Color = Color3.fromRGB(255, 0, 0),
    Thickness = 2,
    Transparency = 1,
    Filled = false,
}

--// Services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local CurrentCamera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

--// Cleanup function
local function ClearDrawings(drawings)
    for _, drawing in ipairs(drawings) do
        if drawing and drawing.Remove then
            drawing:Remove()
        end
    end
end

--// Create 2D box
local function CreateBox()
    local box = Drawing.new("Square")
    box.Color = ESPSettings.Color
    box.Thickness = ESPSettings.Thickness
    box.Transparency = ESPSettings.Transparency
    box.Filled = ESPSettings.Filled
    box.Visible = false
    return box
end

--// Player ESPs
local ESPObjects = {}

--// Update loop
RunService.RenderStepped:Connect(function()
    if not ESPSettings.Enabled then
        for _, v in pairs(ESPObjects) do
            v.Visible = false
        end
        return
    end

    for _, player in ipairs(Players:GetPlayers()) do
        if player == LocalPlayer then
            continue
        end

        local character = player.Character
        local hrp = character and character:FindFirstChild("HumanoidRootPart")
        local humanoid = character and character:FindFirstChildOfClass("Humanoid")

        if not hrp then
            warn("No HRP for", player.Name)
            if ESPObjects[player] then
                ESPObjects[player].Visible = false
            end
            continue
        end

        if not humanoid or (ESPSettings.HealthCheck and humanoid.Health <= 0) then
            if ESPObjects[player] then
                ESPObjects[player].Visible = false
            end
            continue
        end

        if ESPSettings.TeamCheck and player.Team == LocalPlayer.Team then
            if ESPObjects[player] then
                ESPObjects[player].Visible = false
            end
            continue
        end

        local pos, onScreen = CurrentCamera:WorldToViewportPoint(hrp.Position)
        if not onScreen then
            if ESPObjects[player] then
                ESPObjects[player].Visible = false
            end
            continue
        end

        local scale = math.clamp(1 / (hrp.Position - CurrentCamera.CFrame.Position).Magnitude * 100, 0.5, 2)
        local boxSize = Vector2.new(40, 60) * scale
        local boxPos = Vector2.new(pos.X - boxSize.X / 2, pos.Y - boxSize.Y / 2)

        if not ESPObjects[player] then
            ESPObjects[player] = CreateBox()
        end

        local box = ESPObjects[player]
        box.Size = boxSize
        box.Position = boxPos
        box.Color = ESPSettings.Color
        box.Thickness = ESPSettings.Thickness
        box.Transparency = ESPSettings.Transparency
        box.Filled = ESPSettings.Filled
        box.Visible = true
    end
end)

--// Cleanup when player leaves
Players.PlayerRemoving:Connect(function(player)
    if ESPObjects[player] then
        ClearDrawings({ESPObjects[player]})
        ESPObjects[player] = nil
    end
end)
