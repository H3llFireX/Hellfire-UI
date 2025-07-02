-- UI.lua (HellfireX UI)

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/H3llFireX/Hellfire-UI/main/Libs/PepsiUILibrary.lua"))()
local Aimbot = getgenv().Aimbot
if not Aimbot then
    warn("[UI] Aimbot not detected — make sure to run the loader first!")
    return
end

local Settings, FOVSettings = Aimbot.Settings, Aimbot.FOVSettings

local MainFrame = Library:CreateWindow({
    Name = "HellfireX",
    Themeable = {
        Image = "", -- Replace with a working rbxassetid or leave blank
        Info = "HellfireX Internal",
        Credit = false
    },
    Theme = [[{
        "__Designer.Settings.ShowHideKey": "Enum.KeyCode.Delete"
    }]]
})

--==[ Aimbot Tab ]==--
local AimbotTab = MainFrame:CreateTab({ Name = "Aimbot" })

local Core = AimbotTab:CreateSection({ Name = "Core Settings" })
Core:AddToggle({
    Name = "Enabled",
    Value = Settings.Enabled,
    Callback = function(v) Settings.Enabled = v end
}).Default = Settings.Enabled
Core:AddToggle({
    Name = "Toggle Mode",
    Value = Settings.Toggle,
    Callback = function(v) Settings.Toggle = v end
}).Default = Settings.Toggle
Core:AddTextbox({
    Name = "Trigger Key",
    Value = Settings.TriggerKey,
    Callback = function(v) Settings.TriggerKey = v end
}).Default = Settings.TriggerKey
Core:AddSlider({
    Name = "Sensitivity",
    Value = Settings.Sensitivity,
    Min = 0,
    Max = 1,
    Decimals = 2,
    Callback = function(v) Settings.Sensitivity = v end
}).Default = Settings.Sensitivity

local Checks = AimbotTab:CreateSection({ Name = "Checks" })
Checks:AddToggle({ Name = "Team Check", Value = Settings.TeamCheck, Callback = function(v) Settings.TeamCheck = v end }).Default = Settings.TeamCheck
Checks:AddToggle({ Name = "Alive Check", Value = Settings.AliveCheck, Callback = function(v) Settings.AliveCheck = v end }).Default = Settings.AliveCheck
Checks:AddToggle({ Name = "Wall Check", Value = Settings.WallCheck, Callback = function(v) Settings.WallCheck = v end }).Default = Settings.WallCheck

local FOV = AimbotTab:CreateSection({ Name = "FOV Settings" })
FOV:AddToggle({ Name = "Show FOV Circle", Value = FOVSettings.Visible, Callback = function(v) FOVSettings.Visible = v end }).Default = FOVSettings.Visible
FOV:AddToggle({ Name = "FOV Enabled", Value = FOVSettings.Enabled, Callback = function(v) FOVSettings.Enabled = v end }).Default = FOVSettings.Enabled
FOV:AddSlider({ Name = "Radius", Value = FOVSettings.Amount, Min = 10, Max = 300, Callback = function(v) FOVSettings.Amount = v end }).Default = FOVSettings.Amount
FOV:AddSlider({ Name = "Thickness", Value = FOVSettings.Thickness, Min = 1, Max = 10, Callback = function(v) FOVSettings.Thickness = v end }).Default = FOVSettings.Thickness
FOV:AddSlider({ Name = "Transparency", Value = FOVSettings.Transparency, Min = 0, Max = 1, Decimals = 2, Callback = function(v) FOVSettings.Transparency = v end }).Default = FOVSettings.Transparency
FOV:AddColorpicker({ Name = "Color", Value = FOVSettings.Color, Callback = function(v) FOVSettings.Color = v end }).Default = FOVSettings.Color
FOV:AddColorpicker({ Name = "Locked Color", Value = FOVSettings.LockedColor, Callback = function(v) FOVSettings.LockedColor = v end }).Default = FOVSettings.LockedColor

--==[ ESP Tab ]==--
getgenv().ESPSettings = getgenv().ESPSettings or {
    Enabled = true,
    ShowNames = true,
    ShowHealth = true,
    ShowBoxes = true,
    ShowDirection = true,
    TeamCheck = true
}
local ESPSettings = getgenv().ESPSettings

local ESPTab = MainFrame:CreateTab({ Name = "ESP" })
local Toggles = ESPTab:CreateSection({ Name = "ESP Toggles" })

Toggles:AddToggle({ Name = "ESP Enabled", Value = ESPSettings.Enabled, Callback = function(v) ESPSettings.Enabled = v end }).Default = ESPSettings.Enabled
Toggles:AddToggle({ Name = "Show Boxes", Value = ESPSettings.ShowBoxes, Callback = function(v) ESPSettings.ShowBoxes = v end }).Default = ESPSettings.ShowBoxes
Toggles:AddToggle({ Name = "Show Names", Value = ESPSettings.ShowNames, Callback = function(v) ESPSettings.ShowNames = v end }).Default = ESPSettings.ShowNames
Toggles:AddToggle({ Name = "Show Health Bar", Value = ESPSettings.ShowHealth, Callback = function(v) ESPSettings.ShowHealth = v end }).Default = ESPSettings.ShowHealth
Toggles:AddToggle({ Name = "Show Tracers", Value = ESPSettings.ShowDirection, Callback = function(v) ESPSettings.ShowDirection = v end }).Default = ESPSettings.ShowDirection
Toggles:AddToggle({ Name = "Team Check", Value = ESPSettings.TeamCheck, Callback = function(v) ESPSettings.TeamCheck = v end }).Default = ESPSettings.TeamCheck

--==[ Utilities Tab ]==--
local Utilities = MainFrame:CreateTab({ Name = "Utilities" })
local UtilitySec = Utilities:CreateSection({ Name = "Client Actions" })

UtilitySec:AddButton({
    Name = "Unload GUI",
    Callback = function()
        Library:Unload()
    end
})
UtilitySec:AddButton({
    Name = "Self Destruct",
    Callback = function()
        for _, obj in pairs(getgenv().ESPContainer or {}) do
            for _, draw in pairs(obj) do
                draw:Remove()
            end
        end
        Library:Unload()
    end
})
UtilitySec:AddTextbox({
    Name = "Toggle Key (GUI)",
    Value = "Enum.KeyCode.Delete",
    Callback = function(v)
        MainFrame:SetToggleKey(v)
    end
}).Default = "Enum.KeyCode.Delete"
