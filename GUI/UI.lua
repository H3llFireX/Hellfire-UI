-- UI.lua

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/H3llFireX/Hellfire-UI/main/Libs/PepsiUILibrary.lua"))()

local Aimbot = getgenv().Aimbot
if not Aimbot then
    warn("[UI] Aimbot not detected — make sure to run the loader first!")
    return
end

local Settings = Aimbot.Settings
local FOVSettings = Aimbot.FOVSettings
local Functions = Aimbot.Functions

--// Setup Window
local MainFrame = Library:CreateWindow({
    Name = "HellfireX",
    Themeable = {
        Image = "", -- Image background optional
        Info = "HellfireX — Custom Aimbot + ESP",
        Credit = false
    },
    Background = "",
    Theme = {
        ["__Designer.Settings.ShowHideKey"] = Enum.KeyCode.Delete
    }
})

--// Aimbot Tab
local AimbotTab = MainFrame:CreateTab({ Name = "Aimbot" })

local Core = AimbotTab:CreateSection({ Name = "Core Settings" })
Core:AddToggle({ Name = "Enabled", Value = Settings.Enabled, Callback = function(v) Settings.Enabled = v end }).Default = Settings.Enabled
Core:AddToggle({ Name = "Toggle Mode", Value = Settings.Toggle, Callback = function(v) Settings.Toggle = v end }).Default = Settings.Toggle
Core:AddTextbox({ Name = "Trigger Key", Value = Settings.TriggerKey, Callback = function(v) Settings.TriggerKey = v end }).Default = Settings.TriggerKey
Core:AddSlider({ Name = "Sensitivity", Value = Settings.Sensitivity, Min = 0, Max = 1, Decimals = 2, Callback = function(v) Settings.Sensitivity = v end }).Default = Settings.Sensitivity

local Checks = AimbotTab:CreateSection({ Name = "Checks" })
Checks:AddToggle({ Name = "Team Check", Value = Settings.TeamCheck, Callback = function(v) Settings.TeamCheck = v end }).Default = Settings.TeamCheck
Checks:AddToggle({ Name = "Alive Check", Value = Settings.AliveCheck, Callback = function(v) Settings.AliveCheck = v end }).Default = Settings.AliveCheck
Checks:AddToggle({ Name = "Wall Check", Value = Settings.WallCheck, Callback = function(v) Settings.WallCheck = v end }).Default = Settings.WallCheck

local FOV = AimbotTab:CreateSection({ Name = "FOV" })
FOV:AddToggle({ Name = "Show FOV", Value = FOVSettings.Visible, Callback = function(v) FOVSettings.Visible = v end }).Default = FOVSettings.Visible
FOV:AddToggle({ Name = "Enabled", Value = FOVSettings.Enabled, Callback = function(v) FOVSettings.Enabled = v end }).Default = FOVSettings.Enabled
FOV:AddSlider({ Name = "Radius", Value = FOVSettings.Amount, Min = 10, Max = 300, Callback = function(v) FOVSettings.Amount = v end }).Default = FOVSettings.Amount
FOV:AddSlider({ Name = "Thickness", Value = FOVSettings.Thickness, Min = 1, Max = 10, Callback = function(v) FOVSettings.Thickness = v end }).Default = FOVSettings.Thickness
FOV:AddSlider({ Name = "Transparency", Value = FOVSettings.Transparency, Min = 0, Max = 1, Decimals = 2, Callback = function(v) FOVSettings.Transparency = v end }).Default = FOVSettings.Transparency
FOV:AddSlider({ Name = "Sides", Value = FOVSettings.Sides, Min = 3, Max = 60, Callback = function(v) FOVSettings.Sides = v end }).Default = FOVSettings.Sides
FOV:AddToggle({ Name = "Filled Circle", Value = FOVSettings.Filled, Callback = function(v) FOVSettings.Filled = v end }).Default = FOVSettings.Filled
FOV:AddColorpicker({ Name = "Circle Color", Value = FOVSettings.Color, Callback = function(v) FOVSettings.Color = v end }).Default = FOVSettings.Color
FOV:AddColorpicker({ Name = "Locked Target Color", Value = FOVSettings.LockedColor, Callback = function(v) FOVSettings.LockedColor = v end }).Default = FOVSettings.LockedColor

--// ESP Tab
local ESPTab = MainFrame:CreateTab({ Name = "ESP" })

local ESPSettings = getgenv().ESPSettings or {
    Enabled = true,
    ShowNames = true,
    ShowHealth = true,
    ShowBoxes = true,
    ShowDirection = true,
    TeamCheck = true
}
getgenv().ESPSettings = ESPSettings

local ESP = ESPTab:CreateSection({ Name = "ESP Options" })
ESP:AddToggle({ Name = "Enabled", Value = ESPSettings.Enabled, Callback = function(v) ESPSettings.Enabled = v end }).Default = ESPSettings.Enabled
ESP:AddToggle({ Name = "Show Boxes", Value = ESPSettings.ShowBoxes, Callback = function(v) ESPSettings.ShowBoxes = v end }).Default = ESPSettings.ShowBoxes
ESP:AddToggle({ Name = "Show Names", Value = ESPSettings.ShowNames, Callback = function(v) ESPSettings.ShowNames = v end }).Default = ESPSettings.ShowNames
ESP:AddToggle({ Name = "Show Direction", Value = ESPSettings.ShowDirection, Callback = function(v) ESPSettings.ShowDirection = v end }).Default = ESPSettings.ShowDirection
ESP:AddToggle({ Name = "Show Healthbar", Value = ESPSettings.ShowHealth, Callback = function(v) ESPSettings.ShowHealth = v end }).Default = ESPSettings.ShowHealth
ESP:AddToggle({ Name = "Team Check", Value = ESPSettings.TeamCheck, Callback = function(v) ESPSettings.TeamCheck = v end }).Default = ESPSettings.TeamCheck

--// Utilities Tab
local UtilTab = MainFrame:CreateTab({ Name = "Utilities" })
local Util = UtilTab:CreateSection({ Name = "Core Utilities" })

Util:AddButton({ Name = "Unload", Callback = function()
    Library.Unload()
end })

Util:AddButton({ Name = "Self Destruct", Callback = function()
    Library.Unload()
    for i, v in pairs(getgc(true)) do
        if typeof(v) == "function" and islclosure(v) then
            pcall(function()
                debug.setconstant(v, 1, nil)
            end)
        end
    end
end })

Util:AddTextbox({
    Name = "GUI Toggle Key",
    Value = "Delete",
    Callback = function(v)
        MainFrame.Settings.ShowHideKey = Enum.KeyCode[v] or Enum.KeyCode.Delete
    end
})
