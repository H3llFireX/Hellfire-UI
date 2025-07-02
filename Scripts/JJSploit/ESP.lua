-- Scripts/JJSploit/ESP.lua

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
        for _, esp in pairs(ESPContainer) do
            for _, obj in pairs(esp) do
                obj.Visible = false
            end
        end
        return
    end

    for _, player in pairs(Players:GetPlayers()) do
        if player == LocalPlayer then continue end

        local character = player.Character
        local humanoid = character and character:FindFirstChildOfClass("Humanoid")
        local hrp = character and character:FindFirstChild("HumanoidRootPart")

        if not character or not humanoid or not hrp or humanoid.Health <= 0 then
            ClearESP(player)
            continue
        end

        if ESPSettings.TeamCheck and player.Team == LocalPlayer.Team then
            ClearESP(player)
            continue
        end

        local screenPos, onScreen = Camera:WorldToViewportPoint(hrp.Position)
        if not onScreen or screenPos.Z < 0 then
            ClearESP(player)
            continue
        end

        -- Calculate 2D box
        local topOffset = Vector3.new(0, 3, 0)
        local bottomOffset = Vector3.new(0, -3, 0)
        local top = Camera:WorldToViewportPoint(hrp.Position + topOffset)
        local bottom = Camera:WorldToViewportPoint(hrp.Position + bottomOffset)
        local height = math.abs(top.Y - bottom.Y)
        local width = height / 2
        local boxPos = Vector2.new(screenPos.X - width / 2, screenPos.Y - height / 2)

        if not ESPContainer[player] then
            ESPContainer[player] = CreateESPObjects()
        end

        local esp = ESPContainer[player]

        -- Box
        if ESPSettings.ShowBoxes then
            esp.Box.Size = Vector2.new(width, height)
            esp.Box.Position = boxPos
            esp.Box.Visible = true
        else
            esp.Box.Visible = false
        end

        -- Health Bar
        if ESPSettings.ShowHealth then
            local healthRatio = math.clamp(humanoid.Health / humanoid.MaxHealth, 0, 1)
            local barHeight = height * healthRatio
            esp.HealthBar.Size = Vector2.new(3, barHeight)
            esp.HealthBar.Position = Vector2.new(boxPos.X - 5, boxPos.Y + (height - barHeight))
            esp.HealthBar.Visible = true
        else
            esp.HealthBar.Visible = false
        end

        -- Name
        if ESPSettings.ShowNames then
            esp.Name.Text = player.DisplayName
            esp.Name.Position = Vector2.new(screenPos.X, boxPos.Y - 15)
            esp.Name.Visible = true
        else
            esp.Name.Visible = false
        end

        -- Direction Line
        if ESPSettings.ShowDirection then
            local forward = hrp.CFrame.LookVector * 3
            local dirWorld = hrp.Position + forward
            local dirScreen, onScreen2 = Camera:WorldToViewportPoint(dirWorld)
            esp.Direction.From = Vector2.new(screenPos.X, screenPos.Y)
            esp.Direction.To = Vector2.new(dirScreen.X, dirScreen.Y)
            esp.Direction.Visible = onScreen2
        else
            esp.Direction.Visible = false
        end
    end
end)

--// CLEANUP
Players.PlayerRemoving:Connect(RemoveESP)
