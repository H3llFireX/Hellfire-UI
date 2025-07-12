--// Dependencies
local UserInputService = game:GetService("UserInputService")
local Library = loadstring(game:HttpGet("https://pastebin.com/raw/3eG25KZZ"))() -- Replace with your actual UI library URL

--// UI Table
local GUI = {}
local UIVisible = true

--// Window
local MainWindow = Library:CreateWindow({
	Name = "Hellfire",
	Themeable = {
		Image = "7059346386",
		Info = "Made by Hellfire",
		Credit = false
	},
	Background = "",
	Theme = [[{"__Designer.Colors.topGradient":"3F0C64","__Designer.Colors.section":"C259FB"}]]
})

GUI.MainWindow = MainWindow

--// Aimbot Tab
local AimbotTab = MainWindow:CreateTab({ Name = "Aimbot" })
local AimbotSection = AimbotTab:CreateSection({ Name = "Aimbot Settings" })

AimbotSection:AddToggle({
	Name = "Enabled",
	Callback = function(Value)
		getgenv().AimbotSettings.Enabled = Value
	end
})

AimbotSection:AddToggle({
	Name = "Team Check",
	Callback = function(Value)
		getgenv().AimbotSettings.TeamCheck = Value
	end
})

AimbotSection:AddToggle({
	Name = "Wall Check",
	Callback = function(Value)
		getgenv().AimbotSettings.WallCheck = Value
	end
})

AimbotSection:AddToggle({
	Name = "Health Check",
	Callback = function(Value)
		getgenv().AimbotSettings.HealthCheck = Value
	end
})

AimbotSection:AddTextbox({
	Name = "Trigger Key",
	Value = "MouseButton2",
	Callback = function(New)
		getgenv().AimbotSettings.TriggerKey = New
	end
})

--// ESP Tab
local ESPTab = MainWindow:CreateTab({ Name = "ESP" })
local ESPSection = ESPTab:CreateSection({ Name = "ESP Settings" })

ESPSection:AddToggle({
	Name = "Boxes",
	Callback = function(Value)
		getgenv().ESPSettings.Boxes = Value
	end
})

ESPSection:AddToggle({
	Name = "Health Bars",
	Callback = function(Value)
		getgenv().ESPSettings.HealthBars = Value
	end
})

ESPSection:AddToggle({
	Name = "Distance",
	Callback = function(Value)
		getgenv().ESPSettings.Distance = Value
	end
})

ESPSection:AddToggle({
	Name = "Team Check",
	Callback = function(Value)
		getgenv().ESPSettings.TeamCheck = Value
	end
})

ESPSection:AddToggle({
	Name = "Wall Check",
	Callback = function(Value)
		getgenv().ESPSettings.WallCheck = Value
	end
})

ESPSection:AddToggle({
	Name = "Health Check",
	Callback = function(Value)
		getgenv().ESPSettings.HealthCheck = Value
	end
})

--// Settings Tab
local SettingsTab = MainWindow:CreateTab({ Name = "Settings" })
local SettingsSection = SettingsTab:CreateSection({ Name = "UI Options" })

SettingsSection:AddButton({
	Name = "Unload",
	Callback = function()
		Library:Unload()
	end
})

SettingsSection:AddButton({
	Name = "Self Destruct",
	Callback = function()
		if Library then Library:Unload() end
		script:Destroy()
	end
})

--// GUI Hide Toggle with Delete key
UserInputService.InputBegan:Connect(function(input, processed)
	if not processed and input.KeyCode == Enum.KeyCode.Delete then
		UIVisible = not UIVisible
		MainWindow:SetVisibility(UIVisible)
	end
end)

return GUI
