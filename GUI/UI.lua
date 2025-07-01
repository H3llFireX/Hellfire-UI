
--// Cache

local loadstring, game, getgenv, setclipboard = loadstring, game, getgenv, setclipboard

--// Loaded check

if getgenv().Aimbot then return end

--// Load HellfireX (Raw)

loadstring(game:HttpGet("https://raw.githubusercontent.com/HellfireX/Aimbot-V2/main/Resources/Scripts/Raw%20Main.lua"))()

--// Variables

local Aimbot = getgenv().Aimbot
local Settings, FOVSettings, Functions = Aimbot.Settings, Aimbot.FOVSettings, Aimbot.Functions

local Library = loadstring(game:GetObjects("rbxassetid://7657867786")[1].Source)() -- Pepsi's UI Library

local Parts = {"Head", "HumanoidRootPart", "Torso", "Left Arm", "Right Arm", "Left Leg", "Right Leg", "LeftHand", "RightHand", "LeftLowerArm", "RightLowerArm", "LeftUpperArm", "RightUpperArm", "LeftFoot", "LeftLowerLeg", "UpperTorso", "LeftUpperLeg", "RightFoot", "RightLowerLeg", "LowerTorso", "RightUpperLeg"}

--// Frame

Library.UnloadCallback = Functions.Exit

local MainFrame = Library:CreateWindow({
	Name = "HellfireX",
	Themeable = {
		Image = "7059346386",
		Info = "HellfireX GUI\nPowered by Pepsi's UI Library",
		Credit = false
	},
	Background = "",
	Theme = [[{"__Designer.Colors.section":"ADC7FF","__Designer.Colors.topGradient":"1B242F","__Designer.Settings.ShowHideKey":"Enum.KeyCode.RightShift","__Designer.Colors.otherElementText":"54637D","__Designer.Colors.hoveredOptionBottom":"38667D","__Designer.Background.ImageAssetID":"","__Designer.Colors.unhoveredOptionTop":"407495","__Designer.Colors.innerBorder":"2C4168","__Designer.Colors.unselectedOption":"4E6EA0","__Designer.Background.UseBackgroundImage":true,"__Designer.Files.WorkspaceFile":"HellfireX","__Designer.Colors.main":"23A0FF","__Designer.Colors.outerBorder":"162943","__Designer.Background.ImageColor":"FFFFFF","__Designer.Colors.tabText":"C9DFF1","__Designer.Colors.elementBorder":"111D26","__Designer.Colors.sectionBackground":"0E141C","__Designer.Colors.selectedOption":"558AC2","__Designer.Colors.background":"11182A","__Designer.Colors.bottomGradient":"202B42","__Designer.Background.ImageTransparency":95,"__Designer.Colors.hoveredOptionTop":"4885A0","__Designer.Colors.elementText":"7692B8","__Designer.Colors.unhoveredOptionBottom":"5471C4"}]]
})

--// Tabs

local SettingsTab = MainFrame:CreateTab({ Name = "Settings" })
local FOVSettingsTab = MainFrame:CreateTab({ Name = "FOV Settings" })
local FunctionsTab = MainFrame:CreateTab({ Name = "Functions" })

-- Continue with sections/controls as per original message
