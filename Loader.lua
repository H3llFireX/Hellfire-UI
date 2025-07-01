--// Executor Detection
local executor = identifyexecutor and identifyexecutor() or "Unknown"
local successAimbot = false

--// Load Correct Aimbot Based on Executor
local aimbotURL
if executor:find("Xeno") then
    aimbotURL = "https://raw.githubusercontent.com/H3llFireX/Hellfire-UI/main/Executors/Xeno/Aimbot.lua"
elseif executor:find("JJSploit") then
    aimbotURL = "https://raw.githubusercontent.com/H3llFireX/Hellfire-UI/main/Executors/JJSploit/Aimbot.lua"
else
    warn("[Loader] Unsupported executor: " .. executor)
end

--// Load Aimbot (if supported executor)
if aimbotURL then
    local ok, err = pcall(function()
        loadstring(game:HttpGet(aimbotURL))()
    end)
    successAimbot = ok
    warn(ok and "[Loader] Aimbot loaded successfully" or "[Loader] Aimbot failed: " .. tostring(err))
end

--// Load GUI (always loads regardless of executor)
local okGUI, errGUI = pcall(function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/H3llFireX/Hellfire-UI/main/GUI/UI.lua"))()
end)
warn(okGUI and "[Loader] GUI loaded successfully" or "[Loader] GUI failed: " .. tostring(errGUI))
