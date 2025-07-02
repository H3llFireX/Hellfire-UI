-- // Executor Detection
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

if executor:find("xeno") then
    executor = "Xeno"
elseif executor:find("jjsploit") then
    executor = "JJSploit"
else
    warn("[Loader] Unsupported executor:", executor)
    return
end

-- // Load Aimbot Script
local baseUrl = "https://raw.githubusercontent.com/H3llFireX/Hellfire-UI/main/"
local aimbotURL = baseUrl .. "Scripts/" .. executor .. "/Aimbot.lua"
local espURL = baseUrl .. "Scripts/" .. executor .. "/ESP.lua"
local guiURL = baseUrl .. "GUI/UI.lua"

-- // Aimbot
local okAimbot, errAimbot = pcall(function()
    loadstring(game:HttpGet(aimbotURL))()
end)
warn(okAimbot and "[Loader] Aimbot loaded successfully" or "[Loader] Aimbot failed:", errAimbot)

-- // ESP
local okESP, errESP = pcall(function()
    loadstring(game:HttpGet(espURL))()
end)
warn(okESP and "[Loader] ESP loaded successfully" or "[Loader] ESP failed:", errESP)

-- // GUI
local okGUI, errGUI = pcall(function()
    loadstring(game:HttpGet(guiURL))()
end)
warn(okGUI and "[Loader] GUI loaded successfully" or "[Loader] GUI failed:", errGUI)
