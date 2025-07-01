--// Preloader to wait until game is fully ready (beyond menu)
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local StarterGui = game:GetService("StarterGui")

repeat task.wait() until game:IsLoaded()
repeat task.wait() until Players.LocalPlayer and Players.LocalPlayer.Character and Players.LocalPlayer.Character:FindFirstChild("Humanoid")
repeat task.wait() until workspace.CurrentCamera

task.wait(2) -- Small delay to ensure everything is initialized

--// Optional: Notify user (remove if undesired)
pcall(function()
    StarterGui:SetCore("SendNotification", {
        Title = "HellfireX",
        Text = "Game Ready. Executing Aimbot...",
        Duration = 3
    })
end)

-- Load GUI and Aimbot
loadstring(game:HttpGet("https://raw.githubusercontent.com/H3llFireX/Hellfire-UI/main/GUI/UI.lua"))()
loadstring(game:HttpGet("https://raw.githubusercontent.com/H3llFireX/Hellfire-UI/main/Scripts/Aimbot.lua"))()
