-- Scripts/JJSploit/ESP.lua (2D ESP with proper screen-edge hiding)

getgenv().ESPSettings = getgenv().ESPSettings or {
    Enabled = true,
    ShowNames = true,
    ShowHealth = true,
    ShowBoxes = true,
    ShowDirection = true,
    TeamCheck = true
}

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer
local ESPSettings = getgenv().ESPSettings

local Drawings = {}

local function NewDrawing(type, props)
    local obj = Drawing.new(type)
    for prop, val in pairs(props) do
        obj[prop] = val
    end
    return obj
end

local function ClearDrawings(player)
    if Drawings[player] then
        for _, obj in pairs(Drawings[player]) do
            obj:Remove()
        end
        Drawings[player] = nil
    end
end

local function SetupDrawings(player)
    if not Drawings[player] then
        Drawings[player] = {
            Box = NewDrawing("Square", {Thickness = 1, Color = Color3.new(1, 0, 0), Filled = false, Visible = false}),
            Tracer = NewDrawing("Line", {Thickness = 1, Color = Color3.new(1, 0, 0), Visible = false}),
            Name = NewDrawing("Text", {Size = 16, Center = true, Outline = true, Color = Color3.new(1,1,1), Visible = false}),
        }
    end
end

--// Main render loop
RunService.RenderStepped:Connect(function()
    if not ESPSettings.Enabled then
        for _, tbl in pairs(Drawings) do
            for _, obj in pairs(tbl) do
                obj.Visible = false
            end
        end
        return
    end

    for _, player in ipairs(Players:GetPlayers()) do
        if player == LocalPlayer then continue end

        local character = player.Character
        local hrp = character and character:FindFirstChild("HumanoidRootPart")
        local humanoid = character and character:FindFirstChildOfClass("Humanoid")
        if not hrp or not humanoid or humanoid.Health <= 0 then
            ClearDrawings(player)
            continue
        end

        if ESPSettings.TeamCheck and player.Team == LocalPlayer.Team then
            ClearDrawings(player)
            continue
        end

        local screenPos, onScreen = Camera:WorldToViewportPoint(hrp.Position)
        if not onScreen or screenPos.Z < 0 then
            if Drawings[player] then
                for _, obj in pairs(Drawings[player]) do
                    obj.Visible = false
                end
            end
            continue
        end

        SetupDrawings(player)
        local esp = Drawings[player]

        local boxWidth = 50
        local boxHeight = 100
        local topLeft = Vector2.new(screenPos.X - boxWidth / 2, screenPos.Y - boxHeight / 2)

        -- Box
        if ESPSettings.ShowBoxes then
            esp.Box.Position = topLeft
            esp.Box.Size = Vector2.new(boxWidth, boxHeight)
            esp.Box.Visible = true
        else
            esp.Box.Visible = false
        end

        -- Tracer
        if ESPSettings.ShowDirection then
            esp.Tracer.From = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y)
            esp.Tracer.To = Vector2.new(screenPos.X, screenPos.Y)
            esp.Tracer.Visible = true
        else
            esp.Tracer.Visible = false
        end

        -- Name
        if ESPSettings.ShowNames then
            esp.Name.Text = player.DisplayName
            esp.Name.Position = Vector2.new(screenPos.X, topLeft.Y - 18)
            esp.Name.Visible = true
        else
            esp.Name.Visible = false
        end
    end
end)

-- Cleanup
Players.PlayerRemoving:Connect(ClearDrawings)
