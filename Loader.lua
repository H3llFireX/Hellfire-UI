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

--// Load Scripts
local scriptsFolder = "Hellfire-UI/Scripts"

local function safeLoad(fileName)
    local path = scriptsFolder .. "/" .. fileName
    if isfile and isfile(path) then
        local src = readfile(path)
        local success, result = pcall(loadstring, src)
        if success and result then
            local ok, err = pcall(result)
            if not ok then
                warn("[Hellfire Loader] Error running " .. fileName .. ": " .. tostring(err))
            end
        else
            warn("[Hellfire Loader] Failed to compile " .. fileName)
        end
    else
        warn("[Hellfire Loader] Missing file: " .. path)
    end
end

-- Load Aimbot and ESP
safeLoad("aimbot.lua")
safeLoad("esp.lua")

-- Load UI last to bind settings
safeLoad("ui.lua")
