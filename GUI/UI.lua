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
    TeamCheck = true
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

-- Aimbot Tab
local AimbotTab = MainFrame:CreateTab({ Name = "Aimbot" })
local CoreSection = AimbotTab:CreateSection({ Name = "Core Settings" })
CoreSection:AddToggle({ Name = "Enabled", Value = Settings.Enabled, Callback = function(v) Settings.Enabled = v end })
CoreSection:AddToggle({ Name = "Toggle Mode", Value = Settings.Toggle, Callback = function(v) Settings.Toggle = v end })
CoreSection:AddTextbox({ Name = "Trigger Key", Value = Settings.TriggerKey, Callback = function(v) Settings.TriggerKey = v end })
CoreSection:AddSlider({ Name = "Sensitivity", Value = Settings.Sensitivity, Min = 0, Max = 1, Decimals = 2, Callback = function(v) Settings.Sensitivity = v end })

local CheckSection = AimbotTab:CreateSection({ Name = "Targeting Checks" })
CheckSection:AddToggle({ Name = "Team Check", Value = Settings.TeamCheck, Callback = function(v) Settings.TeamCheck = v end })
CheckSection:AddToggle({ Name = "Alive Check", Value = Settings.AliveCheck, Callback = function(v) Settings.AliveCheck = v end })
CheckSection:AddToggle({ Name = "Wall Check", Value = Settings.WallCheck, Callback = function(v) Settings.WallCheck = v end })

local FOVSection = AimbotTab:CreateSection({ Name = "FOV Settings" })
FOVSection:AddToggle({ Name = "Show FOV Circle", Value = FOVSettings.Visible, Callback = function(v) FOVSettings.Visible = v end })
FOVSection:AddToggle({ Name = "Enabled", Value = FOVSettings.Enabled, Callback = function(v) FOVSettings.Enabled = v end })
FOVSection:AddSlider({ Name = "Radius", Value = FOVSettings.Amount, Min = 10, Max = 300, Decimals = 0, Callback = function(v) FOVSettings.Amount = v end })
FOVSection:AddSlider({ Name = "Thickness", Value = FOVSettings.Thickness, Min = 1, Max = 50, Callback = function(v) FOVSettings.Thickness = v end })
FOVSection:AddSlider({ Name = "Transparency", Value = FOVSettings.Transparency, Min = 0, Max = 1, Decimals = 2, Callback = function(v) FOVSettings.Transparency = v end })
FOVSection:AddSlider({ Name = "Sides", Value = FOVSettings.Sides, Min = 3, Max = 60, Callback = function(v) FOVSettings.Sides = v end })
FOVSection:AddToggle({ Name = "Filled Circle", Value = FOVSettings.Filled, Callback = function(v) FOVSettings.Filled = v end })
FOVSection:AddColorpicker({ Name = "Circle Color", Value = FOVSettings.Color, Callback = function(v) FOVSettings.Color = v end })
FOVSection:AddColorpicker({ Name = "Locked Target Color", Value = FOVSettings.LockedColor, Callback = function(v) FOVSettings.LockedColor = v end })

-- ESP Tab
local ESPTab = MainFrame:CreateTab({ Name = "ESP" })
local GeneralSection = ESPTab:CreateSection({ Name = "ESP Toggles" })
GeneralSection:AddToggle({ Name = "ESP Enabled", Value = ESPSettings.Enabled, Callback = function(v) ESPSettings.Enabled = v end })
GeneralSection:AddToggle({ Name = "Show Boxes", Value = ESPSettings.ShowBoxes, Callback = function(v) ESPSettings.ShowBoxes = v end })
GeneralSection:AddToggle({ Name = "Show Names", Value = ESPSettings.ShowNames, Callback = function(v) ESPSettings.ShowNames = v end })
GeneralSection:AddToggle({ Name = "Show Tracer Line", Value = ESPSettings.ShowDirection, Callback = function(v) ESPSettings.ShowDirection = v end })
GeneralSection:AddToggle({ Name = "Team Check", Value = ESPSettings.TeamCheck, Callback = function(v) ESPSettings.TeamCheck = v end })
GeneralSection:AddToggle({ Name = "Show Health Bar", Value = ESPSettings.ShowHealth, Callback = function(v) ESPSettings.ShowHealth = v end })

-- Utilities Tab
local UtilitiesTab = MainFrame:CreateTab({ Name = "Utilities" })
local UtilSection = UtilitiesTab:CreateSection({ Name = "Management" })
UtilSection:AddButton({ Name = "Unload", Callback = function() Library:Unload() end })
UtilSection:AddButton({ Name = "Self Destruct", Callback = function() 
    for _, conn in pairs(getconnections(game:GetService("RunService").RenderStepped)) do
        if typeof(conn.Function) == "function" and debug.getinfo(conn.Function).name == "" then
            conn:Disable()
        end
    end
    Library:Unload()
end })
UtilSection:AddKeybind({
    Name = "Toggle GUI",
    Keybind = Enum.KeyCode.Delete,
    Callback = function()
        Library:Toggle()
    end
})
