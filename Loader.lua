--// Wait until the player is fully loaded into the match
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

repeat task.wait() until LocalPlayer and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
repeat task.wait() until workspace.CurrentCamera

--// Globals
getgenv().AimbotSettings = {
    Enabled = true,
    TriggerKey = "MouseButton2",
    TeamCheck = true,
    WallCheck = true,
    HealthCheck = true
}

getgenv().ESPSettings = {
    Boxes = true,
    HealthBars = true,
    Distance = true,
    TeamCheck = true,
    WallCheck = true,
    HealthCheck = true
}

--// Load Scripts from GitHub
local githubBase = "https://raw.githubusercontent.com/H3llFireX/Hellfire-UI/main/Scripts/"

local function loadRemoteScript(fileName)
    local success, result = pcall(function()
        return game:HttpGet(githubBase .. fileName)
    end)

    if success and result then
        local runSuccess, err = pcall(loadstring(result))
        if not runSuccess then
            warn("[Hellfire Loader] Error executing " .. fileName .. ": " .. tostring(err))
        end
    else
        warn("[Hellfire Loader] Failed to fetch " .. fileName)
    end
end

-- Load Aimbot and ESP
loadRemoteScript("aimbot.lua")
loadRemoteScript("esp.lua")

-- Load UI last
loadRemoteScript("ui.lua")
