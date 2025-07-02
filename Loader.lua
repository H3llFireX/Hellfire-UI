-- Wait for the game to finish loading
if not game:IsLoaded() then
    game.Loaded:Wait()
end

--==[ Executor Detection ]==--
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
    warn("[Loader] Unsupported executor: " .. executor)
    return
end

--==[ Base Path ]==--
local base = "https://raw.githubusercontent.com/H3llFireX/Hellfire-UI/main/"

--==[ Load Aimbot ]==--
local aimbotUrl = base .. "Scripts/" .. executor .. "/Aimbot.lua"
local okAimbot, errAimbot = pcall(function()
    loadstring(game:HttpGet(aimbotUrl))()
end)
warn(okAimbot and "[Loader] ✅ Aimbot loaded" or "[Loader] ❌ Aimbot failed: " .. tostring(errAimbot))

--==[ Load ESP (JJSploit Only) ]==--
if executor == "JJSploit" then
    local espUrl = base .. "Scripts/JJSploit/ESP.lua"
    local okESP, errESP = pcall(function()
        loadstring(game:HttpGet(espUrl))()
    end)
    warn(okESP and "[Loader] ✅ ESP loaded" or "[Loader] ❌ ESP failed: " .. tostring(errESP))
end

--==[ Load GUI ]==--
local guiUrl = base .. "GUI/UI.lua"
local okGUI, errGUI = pcall(function()
    loadstring(game:HttpGet(guiUrl))()
end)
warn(okGUI and "[Loader] ✅ GUI loaded" or "[Loader] ❌ GUI failed: " .. tostring(errGUI))
