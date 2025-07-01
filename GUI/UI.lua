-- GUI/UI.lua

-- Load Pepsi UI Library
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/H3llFireX/Hellfire-UI/main/Libs/PepsiUILibrary.lua"))()

-- Create Main Window
local Window = Library:CreateWindow({
    Name = "HellfireX",
    Themeable = {
        Image = "",
        Info = "Private Build - Internal Testing",
        Credit = false
    },
    Background = "",
    Theme = [[{"__Designer.Colors.section":"FF6666","__Designer.Colors.topGradient":"1F1F1F","__Designer.Settings.ShowHideKey":"Enum.KeyCode.RightShift","__Designer.Colors.main":"FF0000","__Designer.Colors.background":"0A0A0A"}]]
})

-- Tabs
local AimbotTab = Window:CreateTab({ Name = "Aimbot" })
local FOVTab = Window:CreateTab({ Name = "FOV" })
local MiscTab = Window:CreateTab({ Name = "Misc" })

-- Aimbot Settings Section
local AimbotSection = AimbotTab:CreateSection({ Name = "Settings" })

AimbotSection:AddToggle({
    Name = "Enabled",
    Value = true,
    Callback = function(v) getgenv().Aimbot.Settings.Enabled = v end
})

AimbotSection:AddToggle({
    Name = "Team Check",
    Value = false,
    Callback = function(v) getgenv().Aimbot.Settings.TeamCheck = v end
})

AimbotSection:AddToggle({
    Name = "Wall Check",
    Value = true,
    Callback = function(v) getgenv().Aimbot.Settings.WallCheck = v end
})

AimbotSection:AddToggle({
    Name = "Alive Check",
    Value = true,
    Callback = function(v) getgenv().Aimbot.Settings.AliveCheck = v end
})

AimbotSection:AddSlider({
    Name = "Sensitivity",
    Min = 0,
    Max = 1,
    Decimals = 2,
    Value = 0,
    Callback = function(v) getgenv().Aimbot.Settings.Sensitivity = v end
})

AimbotSection:AddTextbox({
    Name = "Hotkey",
    Value = "MouseButton2",
    Callback = function(v) getgenv().Aimbot.Settings.TriggerKey = v end
})

-- FOV Settings Section
local FOVSection = FOVTab:CreateSection({ Name = "FOV Settings" })

FOVSection:AddToggle({
    Name = "Visible",
    Value = true,
    Callback = function(v) getgenv().Aimbot.FOVSettings.Visible = v end
})

FOVSection:AddSlider({
    Name = "Amount",
    Min = 10,
    Max = 300,
    Value = 90,
    Callback = function(v) getgenv().Aimbot.FOVSettings.Amount = v end
})

FOVSection:AddColorpicker({
    Name = "Color",
    Value = Color3.fromRGB(255, 255, 255),
    Callback = function(v) getgenv().Aimbot.FOVSettings.Color = string.format("%d, %d, %d", v.R * 255, v.G * 255, v.B * 255) end
})

FOVSection:AddColorpicker({
    Name = "Locked Color",
    Value = Color3.fromRGB(255, 70, 70),
    Callback = function(v) getgenv().Aimbot.FOVSettings.LockedColor = string.format("%d, %d, %d", v.R * 255, v.G * 255, v.B * 255) end
})

-- Misc Section
local MiscSection = MiscTab:CreateSection({ Name = "Functions" })

MiscSection:AddButton({
    Name = "Restart Aimbot",
    Callback = function()
        getgenv().Aimbot.Functions:Restart()
    end
})

MiscSection:AddButton({
    Name = "Exit Aimbot",
    Callback = function()
        getgenv().Aimbot.Functions:Exit()
    end
})
