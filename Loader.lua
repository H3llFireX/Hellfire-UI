--// HellfireX Loader
local baseUrl = "https://raw.githubusercontent.com/H3llFireX/Hellfire-UI/main/"

-- Detect executor
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

-- Normalize executor to folder name
executor = executor:lower()
if executor:find("xeno") then
    executor = "Xeno"
elseif executor:find("jjsploit") then
    executor = "JJSploit"
else
    warn("[HellfireX] Unsupported executor: " .. executor)
    return
end

-- Load executor-specific Aimbot
local aimbotURL = baseUrl .. "Scripts/" .. executor .. "/Aimbot.lua"
local okAimbot, errAimbot = pcall(function()
    loadstring(game:HttpGet(aimbotURL))()
end)
warn(okAimbot and "[HellfireX] Aimbot loaded!" or "[HellfireX] Failed to load Aimbot:", errAimbot)

-- Load executor-specific ESP
local espURL = baseUrl .. "Scripts/" .. executor .. "/ESP.lua"
local okESP, errESP = pcall(function()
    loadstring(game:HttpGet(espURL))()
end)
warn(okESP and "[HellfireX] ESP loaded!" or "[HellfireX] Failed to load ESP:", errESP)

-- Load GUI
local guiURL = baseUrl .. "GUI/UI.lua"
local okGUI, errGUI = pcall(function()
    loadstring(game:HttpGet(guiURL))()
end)
warn(okGUI and "[HellfireX] GUI loaded!" or "[HellfireX] Failed to load GUI:", errGUI)
