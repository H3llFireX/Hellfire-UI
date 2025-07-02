local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/H3llFireX/Hellfire-UI/main/Libs/PepsiUILibrary.lua"))()
local Aimbot = getgenv().Aimbot
if not Aimbot then
    warn("[UI] Aimbot not detected — make sure to run the loader first!")
    return
end

local Settings, FOVSettings, Functions = Aimbot.Settings, Aimbot.FOVSettings, Aimbot.Functions

-- Main GUI Window
local MainFrame = Library:CreateWindow({
    Name = "HellfireX",
    Themeable = {
        Image = "", -- Optional background image
        Info = "Powered by HellfireX",
        Credit = false
    },
    Background = "",
    Theme = [[{
        "__Designer.Settings.ShowHideKey": "Enum.KeyCode.Delete"
    }]]
})

------------------------------------------------------------
-- Aimbot Tab
------------------------------------------------------------
local AimbotTab = MainFrame:CreateTab({ Name = "Aimbot" })

local CoreSection = AimbotTab:CreateSection({ Name = "Core" })
CoreSection:AddToggle({ Name = "Enabled", Value = Settings.Enabled, Callback = function(v) Settings.Enabled = v end }).Default = Settings.Enabled
CoreSection:AddToggle({ Name = "Toggle Mode", Value = Settings.Toggle, Callback = function(v) Settings.Toggle = v end }).Default = Settings.Toggle
CoreSection:AddTextbox({ Name = "Trigger Key", Value = Settings.TriggerKey, Callback = function(v) Settings.TriggerKey = v end }).Default = Settings.TriggerKey
CoreSection:AddSlider({ Name = "Sensitivity", Value = Settings.Sensitivity, Min = 0, Max = 1, Decimals = 2, Callback = function(v) Settings.Sensitivity = v end }).Default = Settings.Sensitivity

local CheckSection = AimbotTab:CreateSection({ Name = "Checks" })
CheckSection:AddToggle({ Name = "Team Check", Value = Settings.TeamCheck, Callback = function(v) Settings.TeamCheck = v end }).Default = Settings.TeamCheck
CheckSection:AddToggle({ Name = "Alive Check", Value = Settings.AliveCheck, Callback = function(v) Settings.AliveCheck = v end }).Default = Settings.AliveCheck
CheckSection:AddToggle({ Name = "Wall Check", Value = Settings.WallCheck, Callback = function(v) Settings.WallCheck = v end }).Default = Settings.WallCheck

local FOVSection = AimbotTab:CreateSection({ Name = "FOV" })
FOVSection:AddToggle({ Name = "Show FOV Circle", Value = FOVSettings.Visible, Callback = function(v) FOVSettings.Visible = v end }).Default = FOVSettings.Visible
FOVSection:AddToggle({ Name = "Enabled", Value = FOVSettings.Enabled, Callback = function(v) FOVSettings.Enabled = v end }).Default = FOVSettings.Enabled
FOVSection:AddSlider({ Name = "Radius", Value = FOVSettings.Amount, Min = 10, Max = 300, Callback = function(v) FOVSettings.Amount = v end }).Default = FOVSettings.Amount
FOVSection:AddSlider({ Name = "Thickness", Value = FOVSettings.Thickness, Min = 1, Max = 10, Callback = function(v) FOVSettings.Thickness = v end }).Default = FOVSettings.Thickness
FOVSection:AddSlider({ Name = "Transparency", Value = FOVSettings.Transparency, Min = 0, Max = 1, Decimals = 2, Callback = function(v) FOVSettings.Transparency = v end }).Default = FOVSettings.Transparency
FOVSection:AddSlider({ Name = "Sides", Value = FOVSettings.Sides, Min = 3, Max = 60, Callback = function(v) FOVSettings.Sides = v end }).Default = FOVSettings.Sides
FOVSection:AddToggle({ Name = "Filled", Value = FOVSettings.Filled, Callback = function(v) FOVSettings.Filled = v end }).Default = FOVSettings.Filled
FOVSection:AddColorpicker({ Name = "Circle Color", Value = FOVSettings.Color, Callback = function(v) FOVSettings.Color = v end }).Default = FOVSettings.Color
FOVSection:AddColorpicker({ Name = "Target Color", Value = FOVSettings.LockedColor, Callback = function(v) FOVSettings.LockedColor = v end }).Default = FOVSettings.LockedColor

------------------------------------------------------------
-- ESP Tab
------------------------------------------------------------
local ESPSettings = getgenv().ESPSettings or {
    Enabled = true,
    ShowNames = true,
    ShowHealth = true,
    ShowBoxes = true,
    ShowDirection = true,
    TeamCheck = true
}
getgenv().ESPSettings = ESPSettings

local ESPTab = MainFrame:CreateTab({ Name = "ESP" })
local ESPSection = ESPTab:CreateSection({ Name = "Visuals" })

ESPSection:AddToggle({ Name = "Enable ESP", Value = ESPSettings.Enabled, Callback = function(v) ESPSettings.Enabled = v end }).Default = ESPSettings.Enabled
ESPSection:AddToggle({ Name = "Show Boxes", Value = ESPSettings.ShowBoxes, Callback = function(v) ESPSettings.ShowBoxes = v end }).Default = ESPSettings.ShowBoxes
ESPSection:AddToggle({ Name = "Show Names", Value = ESPSettings.ShowNames, Callback = function(v) ESPSettings.ShowNames = v end }).Default = ESPSettings.ShowNames
ESPSection:AddToggle({ Name = "Show Tracer", Value = ESPSettings.ShowDirection, Callback = function(v) ESPSettings.ShowDirection = v end }).Default = ESPSettings.ShowDirection
ESPSection:AddToggle({ Name = "Show Health", Value = ESPSettings.ShowHealth, Callback = function(v) ESPSettings.ShowHealth = v end }).Default = ESPSettings.ShowHealth
ESPSection:AddToggle({ Name = "Team Check", Value = ESPSettings.TeamCheck, Callback = function(v) ESPSettings.TeamCheck = v end }).Default = ESPSettings.TeamCheck

------------------------------------------------------------
-- Utilities Tab
------------------------------------------------------------
local UtilitiesTab = MainFrame:CreateTab({ Name = "Utilities" })
local UtilitySection = UtilitiesTab:CreateSection({ Name = "Controls" })

UtilitySection:AddButton({
    Name = "Unload GUI",
    Callback = function()
        Library:Unload()
        warn("[HellfireX] GUI unloaded.")
    end
})

UtilitySection:AddButton({
    Name = "Self Destruct (Kill Script)",
    Callback = function()
        Library:Unload()
        if getgenv then
            getgenv().Aimbot = nil
            getgenv().ESPSettings = nil
        end
        for _, conn in ipairs(getconnections(game:GetService("RunService").RenderStepped)) do
            conn:Disable()
        end
        warn("[HellfireX] Self-destruct completed.")
    end
})

UtilitySection:AddTextbox({
    Name = "Set GUI Toggle Key",
    Value = "Delete",
    Callback = function(val)
        Library.Keybind = Enum.KeyCode[val] or Enum.KeyCode.Delete
    end
}).Default = "Delete"
