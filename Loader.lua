-- Hellfire Loader (Universal)

if getgenv().HellfireLoaded then
    return
end

getgenv().HellfireLoaded = true

-- Setup environment
getgenv().HellfireAimbot = {
    Settings = {
        Enabled = true,
        TargetPart = "Head",
        Smoothness = 0.2,
        FOV = 150,
        FOVColor = Color3.fromRGB(255, 0, 0),
        TeamCheck = true,
        WallCheck = true,
        HealthCheck = true,
        TriggerKey = Enum.UserInputType.MouseButton2,
    }
}

getgenv().HellfireESP = {
    Settings = {
        Enabled = true,
        Boxes = true,
        HealthBars = true,
        ShowDistance = true,
        TeamCheck = true,
        WallCheck = true,
        HealthCheck = true,
    }
}

-- Script loader
local function loadScript(name)
    local success, result = pcall(function()
        return loadstring(game:HttpGet("https://raw.githubusercontent.com/H3llFireX/Hellfire-UI/main/Scripts/" .. name .. ".lua"))()
    end)

    if not success then
        warn("[Hellfire Loader] Failed to load:", name, "\n", result)
    end
end

-- Load all modules
loadScript("Aimbot")
loadScript("ESP")
loadScript("UI")
