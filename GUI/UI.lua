local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/H3llFireX/Hellfire-UI/main/Libs/PepsiUILibrary.lua"))()
local Aimbot = getgenv().Aimbot or {}
local ESPSettings = getgenv().ESPSettings or {
    Enabled = true,
    ShowNames = true,
    ShowHealth = true,
    ShowBoxes = true,
    ShowDirection = true,
    TeamCheck = true,
}
getgenv().ESPSettings = ESPSettings

local Settings = Aimbot.Settings or {}
local FOVSettings = Aimbot.FOVSettings or {}
local Functions = Aimbot.Functions or {}

local MainFrame = Library:CreateWindow({
    Name = "HellfireX",
    Themeable = {
        Image = "rbxassetid://7059346386",
        Info = "Once you enter the fire, there's no turning back",
        Credit = false
    },
    Background = "",
    Theme = [[{
        "__Designer.Settings.ShowHideKey": "Enum.KeyCode.Delete"
    }]]
})

-- Aimbot Tab
local AimbotTab = MainFrame:CreateTab({ Name = "Aimbot" })

-- Aimbot Core Settings
local Core = AimbotTab:CreateSection({ Name = "Core Settings" })

Core:AddToggle({ Name = "Enabled", Value = Settings.Enabled, Callback = function(v) Settings.Enabled = v end })
Core:AddToggle({ Name = "Toggle Mode", Value = Settings.Toggle, Callback = function(v) Settings.Toggle = v end })
Core:AddTextbox({ Name = "Trigger Key", Value = Settings.TriggerKey, Callback = function(v) Settings.TriggerKey = v end })
Core:AddSlider({ Name = "Sensitivity", Value = Settings.Sensitivity, Min = 0, Max = 1, Decimals = 2, Callback = function(v) Settings.Sensitivity = v end })

-- Aimbot Checks
local Checks = AimbotTab:CreateSection({ Name = "Checks" })

Checks:AddToggle({ Name = "Team Check", Value = Settings.TeamCheck, Callback = function(v) Settings.TeamCheck = v end })
Checks:AddToggle({ Name = "Alive Check", Value = Settings.AliveCheck, Callback = function(v) Settings.AliveCheck = v end })
Checks:AddToggle({ Name = "Wall Check", Value = Settings.WallCheck, Callback = function(v) Settings.WallCheck = v end })

-- Aimbot FOV
local FOV = AimbotTab:CreateSection({ Name = "FOV Settings" })

FOV:AddToggle({ Name = "Enabled", Value = FOVSettings.Enabled, Callback = function(v) FOVSettings.Enabled = v end })
FOV:AddToggle({ Name = "Show FOV Circle", Value = FOVSettings.Visible, Callback = function(v) FOVSettings.Visible = v end })
FOV:AddSlider({ Name = "Radius", Value = FOVSettings.Amount, Min = 10, Max = 300, Callback = function(v) FOVSettings.Amount = v end })
FOV:AddSlider({ Name = "Thickness", Value = FOVSettings.Thickness, Min = 1, Max = 50, Callback = function(v) FOVSettings.Thickness = v end })
FOV:AddSlider({ Name = "Transparency", Value = FOVSettings.Transparency, Min = 0, Max = 1, Decimals = 2, Callback = function(v) FOVSettings.Transparency = v end })
FOV:AddSlider({ Name = "Sides", Value = FOVSettings.Sides, Min = 3, Max = 60, Callback = function(v) FOVSettings.Sides = v end })
FOV:AddToggle({ Name = "Filled Circle", Value = FOVSettings.Filled, Callback = function(v) FOVSettings.Filled = v end })
FOV:AddColorpicker({ Name = "FOV Color", Value = FOVSettings.Color, Callback = function(v) FOVSettings.Color = v end })
FOV:AddColorpicker({ Name = "Locked Color", Value = FOVSettings.LockedColor, Callback = function(v) FOVSettings.LockedColor = v end })

-- ESP Tab (Basic Setup Only)
local ESPTab = MainFrame:CreateTab({
    Name = "ESP"
})

local ESPSection = ESPTab:CreateSection({
    Name = "Status"
})

ESPSection:AddLabel("ESP is enabled via script.")

-- Functions Tab
local FuncTab = MainFrame:CreateTab({ Name = "Functions" })
local Funcs = FuncTab:CreateSection({ Name = "Actions" })

Funcs:AddButton({ Name = "Reset Settings", Callback = function() if Functions.ResetSettings then Functions.ResetSettings() end Library.ResetAll() end })
Funcs:AddButton({ Name = "Restart", Callback = function() if Functions.Restart then Functions.Restart() end end })
Funcs:AddButton({ Name = "Exit", Callback = function() if Functions.Exit then Functions.Exit() end Library.Unload() end })
