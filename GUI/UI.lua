local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/<your-username>/HellfireX-Aimbot/main/Libs/PepsiUILibrary.lua"))()
local Window = Library:CreateWindow({ Name = "HellfireX", Themeable = { Image = "", Info = "Private Dev Build" }})

local SettingsTab = Window:CreateTab({ Name = "Aimbot Settings" })
local Section = SettingsTab:CreateSection({ Name = "Main" })

Section:AddToggle({
    Name = "Aimbot Enabled",
    Value = true,
    Callback = function(v)
        getgenv().Aimbot.Settings.Enabled = v
    end
})

Section:AddDropdown({
    Name = "Lock Part",
    Value = "Head",
    List = { "Head", "HumanoidRootPart" },
    Callback = function(v)
        getgenv().Aimbot.Settings.LockPart = v
    end
})
