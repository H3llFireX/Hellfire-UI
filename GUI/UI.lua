-- UI.lua
-- Hellfire UI for Aimbot and ESP

local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/pepsi-deluxe/ui-libs/main/pepsi-ui.lua"))()
local Window = Library:CreateWindow({ Name = "Hellfire", Themeable = {}, Background = "" })

-- Aimbot + ESP environment (must be shared externally)
local Aimbot = getgenv().HellfireAimbot
local ESP = getgenv().HellfireESP

-- Aimbot Tab
local AimbotTab = Window:CreateTab({ Name = "Aimbot" })

local AimbotSettings = AimbotTab:CreateSection({ Name = "Aimbot Settings" })
AimbotSettings:AddToggle({
    Name = "Enabled",
    Value = Aimbot.Settings.Enabled,
    Callback = function(val) Aimbot.Settings.Enabled = val end
}).Default = Aimbot.Settings.Enabled

AimbotSettings:AddDropdown({
    Name = "Target Part",
    List = { "Head", "HumanoidRootPart", "Torso" },
    Value = Aimbot.Settings.TargetPart,
    Callback = function(val) Aimbot.Settings.TargetPart = val end
}).Default = Aimbot.Settings.TargetPart

AimbotSettings:AddSlider({
    Name = "Smoothness",
    Min = 0,
    Max = 1,
    Decimals = 2,
    Value = Aimbot.Settings.Smoothness,
    Callback = function(val) Aimbot.Settings.Smoothness = val end
}).Default = Aimbot.Settings.Smoothness

AimbotSettings:AddSlider({
    Name = "FOV",
    Min = 0,
    Max = 500,
    Value = Aimbot.Settings.FOV,
    Callback = function(val) Aimbot.Settings.FOV = val end
}).Default = Aimbot.Settings.FOV

AimbotSettings:AddColorpicker({
    Name = "FOV Color",
    Value = Aimbot.Settings.FOVColor,
    Callback = function(val) Aimbot.Settings.FOVColor = val end
}).Default = Aimbot.Settings.FOVColor

AimbotSettings:AddToggle({
    Name = "Team Check",
    Value = Aimbot.Settings.TeamCheck,
    Callback = function(val) Aimbot.Settings.TeamCheck = val end
}).Default = Aimbot.Settings.TeamCheck

AimbotSettings:AddToggle({
    Name = "Wall Check",
    Value = Aimbot.Settings.WallCheck,
    Callback = function(val) Aimbot.Settings.WallCheck = val end
}).Default = Aimbot.Settings.WallCheck

AimbotSettings:AddToggle({
    Name = "Health Check",
    Value = Aimbot.Settings.HealthCheck,
    Callback = function(val) Aimbot.Settings.HealthCheck = val end
}).Default = Aimbot.Settings.HealthCheck

-- ESP Tab
local ESPTab = Window:CreateTab({ Name = "ESP" })

local ESPSection = ESPTab:CreateSection({ Name = "ESP Settings" })

ESPSection:AddToggle({
    Name = "Enabled",
    Value = ESP.Settings.Enabled,
    Callback = function(val) ESP.Settings.Enabled = val end
}).Default = ESP.Settings.Enabled

ESPSection:AddToggle({
    Name = "Boxes",
    Value = ESP.Settings.Boxes,
    Callback = function(val) ESP.Settings.Boxes = val end
}).Default = ESP.Settings.Boxes

ESPSection:AddToggle({
    Name = "Health Bars",
    Value = ESP.Settings.HealthBars,
    Callback = function(val) ESP.Settings.HealthBars = val end
}).Default = ESP.Settings.HealthBars

ESPSection:AddToggle({
    Name = "Show Distance",
    Value = ESP.Settings.ShowDistance,
    Callback = function(val) ESP.Settings.ShowDistance = val end
}).Default = ESP.Settings.ShowDistance

ESPSection:AddToggle({
    Name = "Team Check",
    Value = ESP.Settings.TeamCheck,
    Callback = function(val) ESP.Settings.TeamCheck = val end
}).Default = ESP.Settings.TeamCheck

ESPSection:AddToggle({
    Name = "Wall Check",
    Value = ESP.Settings.WallCheck,
    Callback = function(val) ESP.Settings.WallCheck = val end
}).Default = ESP.Settings.WallCheck

ESPSection:AddToggle({
    Name = "Health Check",
    Value = ESP.Settings.HealthCheck,
    Callback = function(val) ESP.Settings.HealthCheck = val end
}).Default = ESP.Settings.HealthCheck
