--[[

    HellFire Hub © 2025

    Author: YourNameHere
    Description: Unified loader for HellFire UI, Aimbot, ESP, and Utility modules.

]]

-- // Cache
local getgenv, loadstring, game, table, Instance = getgenv, loadstring, game, table, Instance

-- // Prevent double loading
if getgenv().HellFireHubLoaded then
    return
end

getgenv().HellFireHubLoaded = true
getgenv().HellFire = {} -- Namespace

-- // Load Modules
loadstring(game:HttpGet("https://your.cdn.net/modules/aimbot.lua"))()
loadstring(game:HttpGet("https://your.cdn.net/modules/esp.lua"))()
loadstring(game:HttpGet("https://your.cdn.net/modules/ui.lua"))()

-- // Load UI Library
local Library = loadstring(game:GetObjects("rbxassetid://7657867786")[1].Source)()

-- // Setup
Library.UnloadCallback = function()
    HellFire.Aimbot.Functions:Exit()
    HellFire.ESP.Functions:Exit()
    getgenv().HellFireHubLoaded = false
end

-- // Create Main Window
local Window = Library:CreateWindow({
    Name = "HellFire Hub",
    Themeable = {
        Image = "7059346386",
        Info = "Built by YourNameHere",
        Credit = false
    },
    Background = "",
    Theme = [[{"__Designer.Colors.topGradient":"3F0C64","__Designer.Colors.section":"C259FB","__Designer.Colors.hoveredOptionBottom":"4819B4","__Designer.Background.ImageAssetID":"rbxassetid://4427304036","__Designer.Colors.selectedOption":"4E149C","__Designer.Colors.unselectedOption":"482271","__Designer.Files.WorkspaceFile":"HellFire","__Designer.Colors.unhoveredOptionTop":"310269","__Designer.Colors.outerBorder":"391D57","__Designer.Background.ImageColor":"69009C","__Designer.Colors.tabText":"B9B9B9","__Designer.Colors.elementBorder":"160B24","__Designer.Background.ImageTransparency":100,"__Designer.Colors.background":"1E1237","__Designer.Colors.innerBorder":"531E79","__Designer.Colors.bottomGradient":"361A60","__Designer.Colors.sectionBackground":"21002C","__Designer.Colors.hoveredOptionTop":"6B10F9","__Designer.Colors.otherElementText":"7B44A8","__Designer.Colors.main":"AB26FF","__Designer.Colors.elementText":"9F7DB5","__Designer.Colors.unhoveredOptionBottom":"3E0088","__Designer.Background.UseBackgroundImage":false}]]
})

-- // Initialize Tabs & Sections
HellFire.UI = {
    Library = Library,
    Window = Window,
    AimbotTab = Window:CreateTab({ Name = "Aimbot" }),
    VisualsTab = Window:CreateTab({ Name = "Visuals" }),
    CrosshairTab = Window:CreateTab({ Name = "Crosshair" }),
    UtilitiesTab = Window:CreateTab({ Name = "Utilities" }),
}

-- // Load Setup Functions (per module)
HellFire.Aimbot.UISetup(HellFire.UI.AimbotTab)
HellFire.ESP.UISetup(HellFire.UI.VisualsTab)
HellFire.UI.SetupUtilityTab(HellFire.UI.UtilitiesTab)

-- // Optional Notification
game.StarterGui:SetCore("SendNotification", {
    Title = "HellFire Hub",
    Text = "Loaded successfully!",
    Duration = 5
})
