-- Load Pepsi UI Library
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/H3llFireX/Hellfire-UI/main/Libs/PepsiUILibrary.lua"))()

-- Create Window with Delete key toggle
local MainFrame = Library:CreateWindow({
    Name = "HellfireX",
    Themeable = {
        Image = "rbxassetid://7059346386",
        Info = "Once you enter the fire, there's no turning back",
        Credit = false
    },
    Background = "",
    Theme = [[{
        "__Designer.Settings.ShowHideKey": "Enum.KeyCode.Delete",
        "__Designer.Colors.topGradient": "1B242F",
        "__Designer.Colors.bottomGradient": "202B42",
        "__Designer.Colors.background": "11182A",
        "__Designer.Colors.main": "23A0FF",
        "__Designer.Colors.sectionBackground": "0E141C",
        "__Designer.Colors.elementText": "7692B8",
        "__Designer.Colors.tabText": "C9DFF1"
    }]]
})

-- Create Tabs
local AimTab = MainFrame:CreateTab({ Name = "Aimbot" })
local CheckTab = MainFrame:CreateTab({ Name = "Checks" })
local FOVTab = MainFrame:CreateTab({ Name = "FOV" })

-- Aimbot Tab Controls
do
    local section = AimTab:CreateSection({ Name = "Core" })
    section:AddToggle({
        Name = "Aimbot Enabled",
        Value = getgenv().Aimbot.Settings.Enabled,
        Callback = function(v) getgenv().Aimbot.Settings.Enabled = v end
    })
    section:AddToggle({
        Name = "Toggle Mode",
        Value = getgenv().Aimbot.Settings.Toggle,
        Callback = function(v) getgenv().Aimbot.Settings.Toggle = v end
    })
    section:AddTextbox({
        Name = "Trigger Key",
        Value = getgenv().Aimbot.Settings.TriggerKey,
        Callback = function(v) getgenv().Aimbot.Settings.TriggerKey = v end
    })
    section:AddSlider({
        Name = "Sensitivity",
        Value = getgenv().Aimbot.Settings.Sensitivity,
        Min = 0, Max = 1, Decimals = 2,
        Callback = function(v) getgenv().Aimbot.Settings.Sensitivity = v end
    })
end

-- Checks Tab Controls
do
    local section = CheckTab:CreateSection({ Name = "Validation" })
    section:AddToggle({
        Name = "TeamCheck",
        Value = getgenv().Aimbot.Settings.TeamCheck,
        Callback = function(v) getgenv().Aimbot.Settings.TeamCheck = v end
    })
    section:AddToggle({
        Name = "AliveCheck",
        Value = getgenv().Aimbot.Settings.AliveCheck,
        Callback = function(v) getgenv().Aimbot.Settings.AliveCheck = v end
    })
    section:AddToggle({
        Name = "WallCheck",
        Value = getgenv().Aimbot.Settings.WallCheck,
        Callback = function(v) getgenv().Aimbot.Settings.WallCheck = v end
    })
end

-- FOV Tab Controls
do
    local section = FOVTab:CreateSection({ Name = "FOV Settings" })
    section:AddToggle({
        Name = "Show FOV Circle",
        Value = getgenv().Aimbot.FOVSettings.Visible,
        Callback = function(v) getgenv().Aimbot.FOVSettings.Visible = v end
    })
    section:AddSlider({
        Name = "FOV Radius",
        Value = getgenv().Aimbot.FOVSettings.Amount,
        Min = 10, Max = 300, Decimals = 0,
        Callback = function(v) getgenv().Aimbot.FOVSettings.Amount = v end
    })
    section:AddColorpicker({
        Name = "Circle Color",
        Value = GetColor(getgenv().Aimbot.FOVSettings.Color),
        Callback = function(v)
            getgenv().Aimbot.FOVSettings.Color = 
                string.format("%d, %d, %d", v.R * 255, v.G * 255, v.B * 255)
        end
    })
end

-- Finally: Load the underlying aimbot logic
loadstring(game:HttpGet("https://raw.githubusercontent.com/H3llFireX/Hellfire-UI/main/Scripts/Aimbot.lua"))()
