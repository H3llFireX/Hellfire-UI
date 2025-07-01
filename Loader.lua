--// Executor Detection (Robust)
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

--// Normalize to folder-safe name
executor = executor:lower()

local folder
if executor:find("xeno") then
    folder = "Xeno"
elseif executor:find("jjsploit") then
    folder = "JJSploit"
else
    warn("[Loader] Unsupported executor: " .. executor)
end

--// Load executor-specific aimbot (if supported)
local successAimbot = false
if folder then
    local aimbotURL = "https://raw.githubusercontent.com/H3llFireX/Hellfire-UI/main/" .. folder .. "/Aimbot.lua"

    local ok, err = pcall(function()
        loadstring(game:HttpGet(aimbotURL))()
    end)
    successAimbot = ok
    warn(ok and "[Loader] Aimbot loaded successfully" or "[Loader] Aimbot failed: " .. tostring(err))
end

--// Load GUI (independent of executor)
local okGUI, errGUI = pcall(function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/H3llFireX/Hellfire-UI/main/GUI/UI.lua"))()
end)
warn(okGUI and "[Loader] GUI loaded successfully" or "[Loader] GUI failed: " .. tostring(errGUI))
