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

AimbotTab:AddToggle({
    Name = "Enabled",
    Value = Settings.Enabled,
    Callback = function(v) Settings.Enabled = v end
}).Default = Settings.Enabled

AimbotTab:AddToggle({
    Name = "Toggle Mode",
    Value = Settings.Toggle,
    Callback = function(v) Settings.Toggle = v end
}).Default = Settings.Toggle

AimbotTab:AddTextbox({
    Name = "Trigger Key",
    Value = Settings.TriggerKey,
    Callback = function(v) Settings.TriggerKey = v end
}).Default = Settings.TriggerKey

AimbotTab:AddSlider({
    Name = "Sensitivity",
    Value = Settings.Sensitivity,
    Min = 0,
    Max = 1,
    Decimals = 2,
    Callback = function(v) Settings.Sensitivity = v end
}).Default = Settings.Sensitivity

AimbotTab:AddToggle({
    Name = "Team Check",
    Value = Settings.TeamCheck,
    Callback = function(v) Settings.TeamCheck = v end
}).Default = Settings.TeamCheck

AimbotTab:AddToggle({
    Name = "Alive Check",
    Value = Settings.AliveCheck,
    Callback = function(v) Settings.AliveCheck = v end
}).Default = Settings.AliveCheck

AimbotTab:AddToggle({
    Name = "Wall Check",
    Value = Settings.WallCheck,
    Callback = function(v) Settings.WallCheck = v end
}).Default = Settings.WallCheck

AimbotTab:AddToggle({
    Name = "Show FOV Circle",
    Value = FOVSettings.Visible,
    Callback = function(v) FOVSettings.Visible = v end
}).Default = FOVSettings.Visible

AimbotTab:AddToggle({
    Name = "FOV Enabled",
    Value = FOVSettings.Enabled,
    Callback = function(v) FOVSettings.Enabled = v end
}).Default = FOVSettings.Enabled

AimbotTab:AddSlider({
    Name = "FOV Radius",
    Value = FOVSettings.Amount,
    Min = 10,
    Max = 300,
    Callback = function(v) FOVSettings.Amount = v end
}).Default = FOVSettings.Amount

AimbotTab:AddSlider({
    Name = "FOV Thickness",
    Value = FOVSettings.Thickness,
    Min = 1,
    Max = 50,
    Callback = function(v) FOVSettings.Thickness = v end
}).Default = FOVSettings.Thickness

AimbotTab:AddSlider({
    Name = "FOV Transparency",
    Value = FOVSettings.Transparency,
    Min = 0,
    Max = 1,
    Decimals = 2,
    Callback = function(v) FOVSettings.Transparency = v end
}).Default = FOVSettings.Transparency

AimbotTab:AddSlider({
    Name = "FOV Sides",
    Value = FOVSettings.Sides,
    Min = 3,
    Max = 60,
    Callback = function(v) FOVSettings.Sides = v end
}).Default = FOVSettings.Sides

AimbotTab:AddToggle({
    Name = "FOV Filled",
    Value = FOVSettings.Filled,
    Callback = function(v) FOVSettings.Filled = v end
}).Default = FOVSettings.Filled

AimbotTab:AddColorpicker({
    Name = "FOV Color",
    Value = FOVSettings.Color,
    Callback = function(v) FOVSettings.Color = v end
}).Default = FOVSettings.Color

AimbotTab:AddColorpicker({
    Name = "Locked Target Color",
    Value = FOVSettings.LockedColor,
    Callback = function(v) FOVSettings.LockedColor = v end
}).Default = FOVSettings.LockedColor

--// ESP Tab
local ESPTab = MainFrame:CreateTab({ Name = "ESP" })

ESPTab:AddToggle({
    Name = "Enabled",
    Value = ESPSettings.Enabled,
    Callback = function(val) ESPSettings.Enabled = val end
}).Default = ESPSettings.Enabled

ESPTab:AddToggle({
    Name = "Show Names",
    Value = ESPSettings.ShowNames,
    Callback = function(val) ESPSettings.ShowNames = val end
}).Default = ESPSettings.ShowNames

ESPTab:AddToggle({
    Name = "Show Health Bars",
    Value = ESPSettings.ShowHealth,
    Callback = function(val) ESPSettings.ShowHealth = val end
}).Default = ESPSettings.ShowHealth

ESPTab:AddToggle({
    Name = "Show Boxes",
    Value = ESPSettings.ShowBoxes,
    Callback = function(val) ESPSettings.ShowBoxes = val end
}).Default = ESPSettings.ShowBoxes

ESPTab:AddToggle({
    Name = "Show Direction Line",
    Value = ESPSettings.ShowDirection,
    Callback = function(val) ESPSettings.ShowDirection = val end
}).Default = ESPSettings.ShowDirection

ESPTab:AddToggle({
    Name = "Team Check",
    Value = ESPSettings.TeamCheck,
    Callback = function(val) ESPSettings.TeamCheck = val end
}).Default = ESPSettings.TeamCheck

--// Functions Tab
local FunctionsTab = MainFrame:CreateTab({ Name = "Functions" })

FunctionsTab:AddButton({
    Name = "Reset Settings",
    Callback = function()
        Functions.ResetSettings()
        Library.ResetAll()
    end
})

FunctionsTab:AddButton({
    Name = "Restart",
    Callback = Functions.Restart
})

FunctionsTab:AddButton({
    Name = "Exit",
    Callback = function()
        Functions.Exit()
        Library.Unload()
    end
})
