--// Preventing Multiple Processes
pcall(function()
	getgenv().Aimbot.Functions:Exit()
end)

--// Environment
getgenv().Aimbot = {}
local Environment = getgenv().Aimbot

--// Services
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local HttpService = game:GetService("HttpService")
local TweenService = game:GetService("TweenService")
local StarterGui = game:GetService("StarterGui")
local Players = game:GetService("Players")
local Camera = game:GetService("Workspace").CurrentCamera

--// Variables
local LocalPlayer = Players.LocalPlayer
local Title = "HellfireX"
local FileNames = {"Aimbot", "Configuration.json", "Drawing.json"}
local Typing, Running, Animation, RequiredDistance, ServiceConnections = false, false, nil, 2000, {}

--// Settings
Environment.Settings = {
	SendNotifications = true,
	SaveSettings = true,
	ReloadOnTeleport = true,
	Enabled = true,
	TeamCheck = false,
	AliveCheck = true,
	WallCheck = true,
	Sensitivity = 0,
	ThirdPerson = false,
	ThirdPersonSensitivity = 3,
	TriggerKey = "MouseButton2",
	Toggle = false,
	LockPart = "Head"
}

Environment.FOVSettings = {
	Enabled = true,
	Visible = true,
	Amount = 90,
	Color = "255, 255, 255",
	LockedColor = "255, 70, 70",
	Transparency = 0.5,
	Sides = 60,
	Thickness = 1,
	Filled = false
}

Environment.FOVCircle = Drawing.new("Circle")
Environment.Locked = nil

--// Utility Functions
local function GetColor(Color)
	local R = tonumber(string.match(Color, "([%d]+)[%s]*,[%s]*[%d]+[%s]*,[%s]*[%d]+"))
	local G = tonumber(string.match(Color, "[%d]+[%s]*,[%s]*([%d]+)[%s]*,[%s]*[%d]+"))
	local B = tonumber(string.match(Color, "[%d]+[%s]*,[%s]*[%d]+[%s]*,[%s]*([%d]+)"))
	return Color3.fromRGB(R, G, B)
end

local function SendNotification(TitleArg, DescriptionArg, DurationArg)
	if Environment.Settings.SendNotifications then
		StarterGui:SetCore("SendNotification", {
			Title = TitleArg,
			Text = DescriptionArg,
			Duration = DurationArg
		})
	end
end

--// Targeting Logic
local function GetClosestPlayer()
	if not Environment.Locked then
		RequiredDistance = Environment.FOVSettings.Enabled and Environment.FOVSettings.Amount or 2000

		for _, v in next, Players:GetPlayers() do
			if v ~= LocalPlayer then
				local char = v.Character
				local part = char and char:FindFirstChild(Environment.Settings.LockPart)
				local humanoid = char and char:FindFirstChildOfClass("Humanoid")

				if char and part and humanoid then
					if Environment.Settings.TeamCheck and v.Team == LocalPlayer.Team then continue end
					if Environment.Settings.AliveCheck and humanoid.Health <= 0 then continue end
					if char:FindFirstChildOfClass("ForceField") or char:GetAttribute("SpawnProtected") then continue end
					if Environment.Settings.WallCheck and #(Camera:GetPartsObscuringTarget({part.Position}, char:GetDescendants())) > 0 then continue end

					local vector, onScreen = Camera:WorldToViewportPoint(part.Position)
					local dist = (Vector2.new(UserInputService:GetMouseLocation().X, UserInputService:GetMouseLocation().Y) - Vector2.new(vector.X, vector.Y)).Magnitude

					if dist < RequiredDistance and onScreen then
						RequiredDistance = dist
						Environment.Locked = v
					end
				end
			end
		end
	elseif (Vector2.new(UserInputService:GetMouseLocation().X, UserInputService:GetMouseLocation().Y) - Vector2.new(Camera:WorldToViewportPoint(Environment.Locked.Character[Environment.Settings.LockPart].Position).X, Camera:WorldToViewportPoint(Environment.Locked.Character[Environment.Settings.LockPart].Position).Y)).Magnitude > RequiredDistance then
		Environment.Locked = nil
		if Animation then Animation:Cancel() end
		Environment.FOVCircle.Color = GetColor(Environment.FOVSettings.Color)
	end
end

--// Core Aimbot Loop
local function Load()
	ServiceConnections.RenderSteppedConnection = RunService.RenderStepped:Connect(function()
		if Environment.FOVSettings.Enabled and Environment.Settings.Enabled then
			Environment.FOVCircle.Position = Vector2.new(UserInputService:GetMouseLocation().X, UserInputService:GetMouseLocation().Y)
			Environment.FOVCircle.Radius = Environment.FOVSettings.Amount
			Environment.FOVCircle.Thickness = Environment.FOVSettings.Thickness
			Environment.FOVCircle.Filled = Environment.FOVSettings.Filled
			Environment.FOVCircle.NumSides = Environment.FOVSettings.Sides
			Environment.FOVCircle.Color = GetColor(Environment.FOVSettings.Color)
			Environment.FOVCircle.Transparency = Environment.FOVSettings.Transparency
			Environment.FOVCircle.Visible = Environment.FOVSettings.Visible
		else
			Environment.FOVCircle.Visible = false
		end

		if Running and Environment.Settings.Enabled then
			GetClosestPlayer()

			if Environment.Settings.ThirdPerson then
				local vector = Camera:WorldToViewportPoint(Environment.Locked.Character[Environment.Settings.LockPart].Position)
				mousemoverel((vector.X - UserInputService:GetMouseLocation().X) * Environment.Settings.ThirdPersonSensitivity, (vector.Y - UserInputService:GetMouseLocation().Y) * Environment.Settings.ThirdPersonSensitivity)
			else
				if Environment.Settings.Sensitivity > 0 then
					Animation = TweenService:Create(Camera, TweenInfo.new(Environment.Settings.Sensitivity, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {CFrame = CFrame.new(Camera.CFrame.Position, Environment.Locked.Character[Environment.Settings.LockPart].Position)})
					Animation:Play()
				else
					Camera.CFrame = CFrame.new(Camera.CFrame.Position, Environment.Locked.Character[Environment.Settings.LockPart].Position)
				end
			end

			Environment.FOVCircle.Color = GetColor(Environment.FOVSettings.LockedColor)
		end
	end)

	ServiceConnections.InputBeganConnection = UserInputService.InputBegan:Connect(function(Input)
		if not UserInputService:GetFocusedTextBox() then
			pcall(function()
				if Input.UserInputType == Enum.UserInputType[Environment.Settings.TriggerKey] or Input.KeyCode == Enum.KeyCode[Environment.Settings.TriggerKey] then
					if Environment.Settings.Toggle then
						Running = not Running
						if not Running then
							Environment.Locked = nil
							if Animation then Animation:Cancel() end
							Environment.FOVCircle.Color = GetColor(Environment.FOVSettings.Color)
						end
					else
						Running = true
					end
				end
			end)
		end
	end)

	ServiceConnections.InputEndedConnection = UserInputService.InputEnded:Connect(function(Input)
		if not Environment.Settings.Toggle then
			if Input.UserInputType == Enum.UserInputType[Environment.Settings.TriggerKey] or Input.KeyCode == Enum.KeyCode[Environment.Settings.TriggerKey] then
				Running = false
				Environment.Locked = nil
				if Animation then Animation:Cancel() end
				Environment.FOVCircle.Color = GetColor(Environment.FOVSettings.Color)
			end
		end
	end)
end

--// Load + Startup
Load()
SendNotification(Title, "Once you enter the fire, there's no turning back", 5)
