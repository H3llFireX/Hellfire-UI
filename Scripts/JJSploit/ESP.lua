--// ENVIRONMENT SETUP
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

local ESPContainer = {}

--// UTILS
local function CreateDrawingObject(type, props)
    local obj = Drawing.new(type)
    for prop, value in pairs(props) do
        obj[prop] = value
    end
    return obj
end

local function CreateESPObjects()
    return {
        Box = CreateDrawingObject("Square", {
            Thickness = 1,
            Transparency = 1,
            Filled = false,
            Color = Color3.new(1, 1, 1),
            Visible = false
        }),
        Name = CreateDrawingObject("Text", {
            Size = 13,
            Color = Color3.new(1, 1, 1),
            Center = true,
            Outline = true,
            Visible = false
        }),
        HealthBar = CreateDrawingObject("Square", {
            Thickness = 1,
            Transparency = 1,
            Filled = true,
            Color = Color3.new(0, 1, 0),
            Visible = false
        }),
        Direction = CreateDrawingObject("Line", {
            Thickness = 2,
            Transparency = 1,
            Color = Color3.new(1, 1, 0),
            Visible = false
        })
    }
end

local function ClearESP(player)
    if ESPContainer[player] then
        for _, obj in pairs(ESPContainer[player]) do
            obj.Visible = false
        end
    end
end

local function RemoveESP(player)
    if ESPContainer[player] then
        for _, obj in pairs(ESPContainer[player]) do
            obj:Remove()
        end
        ESPContainer[player] = nil
    end
end

--// MAIN RENDER LOOP
RunService.RenderStepped:Connect(function()
    if not ESPSettings.Enabled then
        for _, v in pairs(ESPContainer) do
            for _, obj in pairs(v) do
                obj.Visible = false
            end
        end
        return
    end

    for _, player in ipairs(Players:GetPlayers()) do
        if player == LocalPlayer then continue end
        if ESPSettings.TeamCheck and player.Team == LocalPlayer.Team then continue end

        local char = player.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        local hum = char and char:FindFirstChildOfClass("Humanoid")
        if not (char and hrp and hum and hum.Health > 0) then continue end

        local screenPos, onScreen = Camera:WorldToViewportPoint(hrp.Position)
        if not onScreen then
            ClearESP(player)
            continue
        end

        -- Setup drawing objects if missing
        ESPContainer[player] = ESPContainer[player] or CreateESPObjects()
        local esp = ESPContainer[player]

        -- Box math (adjusted for height)
        local height = 60
        local width = 30
        local top = Vector2.new(screenPos.X - width / 2, screenPos.Y - height / 2)

        -- Box
        if ESPSettings.ShowBoxes then
            esp.Box.Position = top
            esp.Box.Size = Vector2.new(width, height)
            esp.Box.Visible = true
        else
            esp.Box.Visible = false
        end

        -- Tracer
        if ESPSettings.ShowDirection then
            esp.Direction.From = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y)
            esp.Direction.To = Vector2.new(screenPos.X, screenPos.Y + height / 2)
            esp.Direction.Visible = true
        else
            esp.Direction.Visible = false
        end

        -- Name
        if ESPSettings.ShowNames then
            esp.Name.Text = player.DisplayName
            esp.Name.Position = Vector2.new(screenPos.X, top.Y - 16)
            esp.Name.Visible = true
        else
            esp.Name.Visible = false
        end

        -- HealthBar
        if ESPSettings.ShowHealth then
            local ratio = math.clamp(hum.Health / hum.MaxHealth, 0, 1)
            esp.HealthBar.Size = Vector2.new(3, height * ratio)
            esp.HealthBar.Position = Vector2.new(top.X - 6, top.Y + (height * (1 - ratio)))
            esp.HealthBar.Visible = true
        else
            esp.HealthBar.Visible = false
        end
    end
end)

--// CLEANUP
Players.PlayerRemoving:Connect(RemoveESP)
