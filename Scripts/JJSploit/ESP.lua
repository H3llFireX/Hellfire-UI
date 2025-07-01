-- Scripts/JJSploit/ESP.lua

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

local ESPSettings = {
    Enabled = true,
    ShowNames = true,
    ShowHealth = true,
    ShowBoxes = true,
    ShowDirection = true,
    TeamCheck = true,
}

local function IsPlayerVisible(player)
    if ESPSettings.TeamCheck and player.Team == LocalPlayer.Team then return false end
    return player.Character and player.Character:FindFirstChild("HumanoidRootPart") and player.Character:FindFirstChildOfClass("Humanoid")
end

local function CreateDrawingObject(type, props)
    local obj = Drawing.new(type)
    for prop, value in pairs(props) do
        obj[prop] = value
    end
    return obj
end

local function CreateESPObjects()
    return {
        Box = CreateDrawingObject("Square", {Thickness = 1, Transparency = 1, Filled = false, Color = Color3.new(1, 1, 1)}),
        HealthBar = CreateDrawingObject("Square", {Thickness = 1, Transparency = 1, Filled = true, Color = Color3.new(0, 1, 0)}),
        Name = CreateDrawingObject("Text", {Size = 13, Color = Color3.new(1, 1, 1), Center = true, Outline = true, Visible = false}),
        Direction = CreateDrawingObject("Line", {Thickness = 2, Transparency = 1, Color = Color3.new(1, 1, 0)}),
    }
end

local ESPContainer = {}

RunService.RenderStepped:Connect(function()
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and IsPlayerVisible(player) then
            local char = player.Character
            local hrp = char:FindFirstChild("HumanoidRootPart")
            local head = char:FindFirstChild("Head")
            local humanoid = char:FindFirstChildOfClass("Humanoid")

            if hrp and head and humanoid and humanoid.Health > 0 then
                local vector, onScreen = Camera:WorldToViewportPoint(hrp.Position)
                local size = Vector3.new(4, 6, 0) * 3
                local topLeft = Camera:WorldToViewportPoint(hrp.Position + Vector3.new(-size.X, size.Y, 0))
                local bottomRight = Camera:WorldToViewportPoint(hrp.Position + Vector3.new(size.X, -size.Y, 0))

                if not ESPContainer[player] then
                    ESPContainer[player] = CreateESPObjects()
                end

                local esp = ESPContainer[player]

                -- Box
                if ESPSettings.ShowBoxes and onScreen then
                    esp.Box.Size = Vector2.new(math.abs(bottomRight.X - topLeft.X), math.abs(bottomRight.Y - topLeft.Y))
                    esp.Box.Position = Vector2.new(topLeft.X, topLeft.Y)
                    esp.Box.Visible = true
                else
                    esp.Box.Visible = false
                end

                -- HealthBar
                if ESPSettings.ShowHealth and onScreen then
                    local healthRatio = math.clamp(humanoid.Health / humanoid.MaxHealth, 0, 1)
                    local barHeight = math.abs(bottomRight.Y - topLeft.Y)
                    esp.HealthBar.Size = Vector2.new(3, barHeight * healthRatio)
                    esp.HealthBar.Position = Vector2.new(topLeft.X - 6, topLeft.Y + (barHeight * (1 - healthRatio)))
                    esp.HealthBar.Visible = true
                else
                    esp.HealthBar.Visible = false
                end

                -- Name
                if ESPSettings.ShowNames and onScreen then
                    esp.Name.Text = player.DisplayName
                    esp.Name.Position = Vector2.new(topLeft.X + (esp.Box.Size.X / 2), topLeft.Y - 15)
                    esp.Name.Visible = true
                else
                    esp.Name.Visible = false
                end

                -- Direction line
                if ESPSettings.ShowDirection and onScreen then
                    local forward = hrp.CFrame.LookVector * 3
                    local dirWorld = hrp.Position + forward
                    local dirScreen, onScreen2 = Camera:WorldToViewportPoint(dirWorld)

                    esp.Direction.From = Vector2.new(vector.X, vector.Y)
                    esp.Direction.To = Vector2.new(dirScreen.X, dirScreen.Y)
                    esp.Direction.Visible = onScreen2
                else
                    esp.Direction.Visible = false
                end
            end
        elseif ESPContainer[player] then
            for _, obj in pairs(ESPContainer[player]) do
                obj.Visible = false
            end
        end
    end
end)
