local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/H3llFireX/Hellfire-UI/main/Libs/PepsiUILibrary.lua"))()
local Aimbot = getgenv().Aimbot
if not Aimbot then
    warn("[UI] Aimbot not detected — make sure to run the loader first!")
    return
end

local Settings, FOVSettings, Functions = Aimbot.Settings, Aimbot.FOVSettings, Aimbot.Functions
local ESPSettings = getgenv().ESPSettings or {
    Enabled = true,
    ShowNames = true,
    ShowHealth = true,
    ShowBoxes = true,
    ShowDirection = true,
    TeamCheck = true,
}
getgenv().ESPSettings = ESPSettings

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

--// Aimbot Tab
local AimbotTab = MainFrame:CreateTab({ Name = "Aimbot" })

local Core = AimbotTab:CreateSection({ Name = "Core Settings" })
Core:AddToggle({ Name = "Enabled", Value = Settings.Enabled, Callback = function(v) Settings.Enabled = v end }).Default = Settings.Enabled
Core:AddToggle({ Name = "Toggle Mode", Value = Settings.Toggle, Callback = function(v) Settings.Toggle = v end }).Default = Settings.Toggle
Core:AddTextbox({ Name = "Trigger Key", Value = Settings.TriggerKey, Callback = function(v) Settings.TriggerKey = v end }).Default = Settings.TriggerKey
Core:AddSlider({ Name = "Sensitivity", Value = Settings.Sensitivity, Min = 0, Max = 1, Decimals = 2, Callback = function(v) Settings.Sensitivity = v end }).Default = Settings.Sensitivity

local Checks = AimbotTab:CreateSection({ Name = "Targeting Checks" })
Checks:AddToggle({ Name = "Team Check", Value = Settings.TeamCheck, Callback = function(v) Settings.TeamCheck = v end }).Default = Settings.TeamCheck
Checks:AddToggle({ Name = "Alive Check", Value = Settings.AliveCheck, Callback = function(v) Settings.AliveCheck = v end }).Default = Settings.AliveCheck
Checks:AddToggle({ Name = "Wall Check", Value = Settings.WallCheck, Callback = function(v) Settings.WallCheck = v end }).Default = Settings.WallCheck

local FOV = AimbotTab:CreateSection({ Name = "FOV Settings" })
FOV:AddToggle({ Name = "Show FOV Circle", Value = FOVSettings.Visible, Callback = function(v) FOVSettings.Visible = v end }).Default = FOVSettings.Visible
FOV:AddToggle({ Name = "Enabled", Value = FOVSettings.Enabled, Callback = function(v) FOVSettings.Enabled = v end }).Default = FOVSettings.Enabled
FOV:AddSlider({ Name = "Radius", Value = FOVSettings.Amount, Min = 10, Max = 300, Decimals = 0, Callback = function(v) FOVSettings.Amount = v end }).Default = FOVSettings.Amount
FOV:AddSlider({ Name = "Thickness", Value = FOVSettings.Thickness, Min = 1, Max = 50, Callback = function(v) FOVSettings.Thickness = v end }).Default = FOVSettings.Thickness
FOV:AddSlider({ Name = "Transparency", Value = FOVSettings.Transparency, Min = 0, Max = 1, Decimals = 2, Callback = function(v) FOVSettings.Transparency = v end }).Default = FOVSettings.Transparency
FOV:AddSlider({ Name = "Sides", Value = FOVSettings.Sides, Min = 3, Max = 60, Callback = function(v) FOVSettings.Sides = v end }).Default = FOVSettings.Sides
FOV:AddToggle({ Name = "Filled Circle", Value = FOVSettings.Filled, Callback = function(v) FOVSettings.Filled = v end }).Default = FOVSettings.Filled
FOV:AddColorpicker({ Name = "Circle Color", Value = FOVSettings.Color, Callback = function(v) FOVSettings.Color = v end }).Default = FOVSettings.Color
FOV:AddColorpicker({ Name = "Locked Target Color", Value = FOVSettings.LockedColor, Callback = function(v) FOVSettings.LockedColor = v end }).Default = FOVSettings.LockedColor

--// Functions Tab
local FunctionsTab = MainFrame:CreateTab({ Name = "Functions" })
local FuncSection = FunctionsTab:CreateSection({ Name = "Aimbot Functions" })
FuncSection:AddButton({ Name = "Reset Settings", Callback = function() Functions.ResetSettings(); Library.ResetAll() end })
FuncSection:AddButton({ Name = "Restart", Callback = Functions.Restart })
FuncSection:AddButton({ Name = "Exit", Callback = function() Functions.Exit(); Library.Unload() end })

--// ESP Tab
local ESPTab = MainFrame:CreateTab({ Name = "ESP" })
local Options = ESPTab:CreateSection({ Name = "Options" })

Options:AddToggle({ Name = "Enabled", Value = ESPSettings.Enabled, Callback = function(val) ESPSettings.Enabled = val end }).Default = ESPSettings.Enabled
Options:AddToggle({ Name = "Show Names", Value = ESPSettings.ShowNames, Callback = function(val) ESPSettings.ShowNames = val end }).Default = ESPSettings.ShowNames
Options:AddToggle({ Name = "Show Health Bars", Value = ESPSettings.ShowHealth, Callback = function(val) ESPSettings.ShowHealth = val end }).Default = ESPSettings.ShowHealth
Options:AddToggle({ Name = "Show Boxes", Value = ESPSettings.ShowBoxes, Callback = function(val) ESPSettings.ShowBoxes = val end }).Default = ESPSettings.ShowBoxes
Options:AddToggle({ Name = "Show Direction Line", Value = ESPSettings.ShowDirection, Callback = function(val) ESPSettings.ShowDirection = val end }).Default = ESPSettings.ShowDirection
Options:AddToggle({ Name = "Team Check", Value = ESPSettings.TeamCheck, Callback = function(val) ESPSettings.TeamCheck = val end }).Default = ESPSettings.TeamCheck
