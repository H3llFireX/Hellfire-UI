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

-- Normalize executor name
executor = executor:lower()

-- Paths
local base = "https://raw.githubusercontent.com/H3llFireX/Hellfire-UI/main/"
local scriptPath, espPath

-- Aimbot executor-based path
if executor:find("xeno") then
    scriptPath = base .. "Scripts/Xeno/Aimbot.lua"
elseif executor:find("jjsploit") then
    scriptPath = base .. "Scripts/JJSploit/Aimbot.lua"
    espPath = base .. "Scripts/JJSploit/ESP.lua"
else
    warn("[Loader] Unsupported executor: " .. executor)
    return
end

-- Load Aimbot
local ok1, err1 = pcall(function()
    loadstring(game:HttpGet(scriptPath))()
end)
warn(ok1 and "[Loader] Aimbot loaded" or "[Loader] Aimbot failed:", err1)

-- Load ESP (JJSploit only)
if espPath then
    local okESP, errESP = pcall(function()
        loadstring(game:HttpGet(espPath))()
    end)
    warn(okESP and "[Loader] ESP loaded" or "[Loader] ESP failed:", errESP)
end

-- Load GUI
local ok2, err2 = pcall(function()
    loadstring(game:HttpGet(base .. "GUI/UI.lua"))()
end)
warn(ok2 and "[Loader] GUI loaded" or "[Loader] GUI failed:", err2)
