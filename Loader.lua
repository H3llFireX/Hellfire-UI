-- Executor Detection
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
    warn("[Loader] Unsupported executor detected:", executor)
    return
end

-- Base URL
local baseUrl = "https://raw.githubusercontent.com/H3llFireX/Hellfire-UI/main/"

-- Load Aimbot
local aimbotUrl = baseUrl .. "Scripts/" .. executor .. "/Aimbot.lua"
local ok1, err1 = pcall(function()
    loadstring(game:HttpGet(aimbotUrl))()
end)
warn(ok1 and "[Loader] Aimbot loaded for " .. executor or "[Loader] Aimbot load failed: " .. tostring(err1))

-- Load ESP
local espUrl = baseUrl .. "Scripts/" .. executor .. "/ESP.lua"
local ok2, err2 = pcall(function()
    loadstring(game:HttpGet(espUrl))()
end)
warn(ok2 and "[Loader] ESP loaded for " .. executor or "[Loader] ESP load failed: " .. tostring(err2))

-- Load GUI
local guiUrl = baseUrl .. "GUI/UI.lua"
local ok3, err3 = pcall(function()
    loadstring(game:HttpGet(guiUrl))()
end)
warn(ok3 and "[Loader] GUI loaded successfully" or "[Loader] GUI failed: " .. tostring(err3))
