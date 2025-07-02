-- Detect Executor
local executor = "Unknown"

pcall(function()
    if identifyexecutor then
        executor = identifyexecutor()
    elseif getexecutorname then
        executor = getexecutorname()
    elseif syn then
        executor = "Synapse X"
    elseif is_sirhurt_closure then
        executor = "SirHurt"
    elseif isexecutorclosure then
        executor = "Script-Ware"
    elseif KRNL_LOADED then
        executor = "KRNL"
    elseif JJSploit then
        executor = "JJSploit"
    end
end)

executor = executor:lower()

-- Normalize and validate executor
if executor:find("xeno") then
    executor = "Xeno"
elseif executor:find("jjsploit") then
    executor = "JJSploit"
else
    warn("[Loader] Unsupported executor: " .. executor)
    return
end

-- Load Aimbot for the executor
local aimbotURL = "https://raw.githubusercontent.com/H3llFireX/Hellfire-UI/main/Scripts/" .. executor .. "/Aimbot.lua"
local successAimbot, errAimbot = pcall(function()
    loadstring(game:HttpGet(aimbotURL))()
end)
warn(successAimbot and "[Loader] Aimbot loaded for " .. executor or "[Loader] Aimbot failed:", errAimbot)

-- Load GUI
local successGUI, errGUI = pcall(function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/H3llFireX/Hellfire-UI/main/GUI/UI.lua"))()
end)
warn(successGUI and "[Loader] GUI loaded" or "[Loader] GUI failed:", errGUI)

-- Load ESP only for JJSploit
if executor == "JJSploit" then
    local successESP, errESP = pcall(function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/H3llFireX/Hellfire-UI/main/Scripts/JJSploit/ESP.lua"))()
    end)
    warn(successESP and "[Loader] ESP loaded for JJSploit" or "[Loader] ESP failed:", errESP)
else
    warn("[Loader] ESP not supported for this executor: " .. executor)
end
