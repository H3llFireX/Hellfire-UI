--// Executor Detection
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

local folder
if executor:find("xeno") then
    folder = "Xeno"
elseif executor:find("jjsploit") then
    folder = "JJSploit"
else
    warn("[Loader] Unsupported executor:", executor)
    return
end

--// URLs (updated to use Scripts/ folder)
local base = "https://raw.githubusercontent.com/H3llFireX/Hellfire-UI/main/"
local aimbotURL = base .. "Scripts/" .. folder .. "/Aimbot.lua"
local guiURL = base .. "GUI/UI.lua"

--// Load Aimbot
local ok1, err1 = pcall(function()
    loadstring(game:HttpGet(aimbotURL))()
end)
warn(ok1 and "[Loader] Aimbot loaded ✅" or "[Loader] Aimbot failed ❌:", err1)

--// Load GUI
local ok2, err2 = pcall(function()
    loadstring(game:HttpGet(guiURL))()
end)
warn(ok2 and "[Loader] GUI loaded ✅" or "[Loader] GUI failed ❌:", err2)
