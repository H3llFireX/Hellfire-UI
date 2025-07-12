-- Wait for the game to fully load before executing scripts
if not game:IsLoaded() then
    game.Loaded:Wait()
end

-- Base URL for your universal script folder
local scriptBase = "https://raw.githubusercontent.com/HellfireClient/Hellfire-UI/main/Scripts/"

-- List of scripts to load (you can add more here)
local scriptsToLoad = {
    "aimbot.lua",
    "esp.lua",
    "ui.lua"
}

-- Loop through each script and safely load it
for _, scriptName in ipairs(scriptsToLoad) do
    local success, result = pcall(function()
        return loadstring(game:HttpGet(scriptBase .. scriptName))()
    end)

    if not success then
        warn("[Hellfire Loader] Failed to load:", scriptName, "\nError:", result)
    else
        print("[Hellfire Loader] Loaded:", scriptName)
    end
end
