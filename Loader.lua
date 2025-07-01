-- 1. Load core aimbot logic first
local ok1, err1 = pcall(function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/H3llFireX/Hellfire-UI/main/Scripts/Aimbot.lua"))()
end)
warn(ok1 and "[Loader] Aimbot loaded successfully" or "[Loader] Aimbot failed:", err1)

-- 2. Then load the GUI to control aimbot settings
local ok2, err2 = pcall(function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/H3llFireX/Hellfire-UI/main/GUI/UI.lua"))()
end)
warn(ok2 and "[Loader] GUI loaded successfully" or "[Loader] GUI failed:", err2)
