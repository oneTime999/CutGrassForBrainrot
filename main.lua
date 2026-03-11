local RepoURL = "https://raw.githubusercontent.com/oneTime999/CutGrassForBrainrot/main/"

local WindUI = loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/Footagesus/WindUI/main/dist/main.lua",
    true
))()

local Window = WindUI:CreateWindow({
    Title        = "Slow Hub",
    Icon         = "zap",
    Author       = "Slow Hub Team",
    Folder       = "SlowHub",
    Size         = UDim2.fromOffset(580, 460),
    Transparent  = true,
    Theme        = "Dark",
    SideBarWidth = 200,
})

Window:Browser()
Window:Intro({
    Icon   = "zap",
    Title  = "Slow Hub",
    Slogan = "Made by Slow Hub Team",
    Color  = Color3.fromRGB(100, 180, 255),
})

local TabMain = Window:Tab({
    Name = "Main",
    Icon = "house",
})

TabMain:Section({ Name = "Information" })

TabMain:Paragraph({
    Title   = "Welcome to Slow Hub!",
    Content = "Developed by Slow Hub Team.\nUse the tabs on the side to access the functions.",
})

local TabFarm = Window:Tab({
    Name = "Farm",
    Icon = "wheat",
})

TabFarm:Section({ Name = "Auto Farm" })

TabFarm:Toggle({
    Name    = "Auto Cut Grass",
    Default = false,
    Flag    = "AutoCutGrass",
    Callback = function(Value)
        if Value then
            loadstring(game:HttpGet(RepoURL .. "Functions/AutoCutGrass.lua", true))()
        end
    end,
})

TabFarm:Toggle({
    Name    = "Auto Collect",
    Default = false,
    Flag    = "AutoCollect",
    Callback = function(Value)
        if Value then
            loadstring(game:HttpGet(RepoURL .. "Functions/AutoCollect.lua", true))()
        end
    end,
})

TabFarm:Toggle({
    Name    = "Auto Rebirth",
    Default = false,
    Flag    = "AutoRebirth",
    Callback = function(Value)
        if Value then
            loadstring(game:HttpGet(RepoURL .. "Functions/AutoRebirth.lua", true))()
        end
    end,
})

TabFarm:Button({
    Name = "Load All Farm Functions",
    Callback = function()
        loadstring(game:HttpGet(RepoURL .. "Tabs/Farm.lua", true))()
    end,
})

local TabPlayer = Window:Tab({
    Name = "Player",
    Icon = "user",
})

TabPlayer:Section({ Name = "Movement" })

TabPlayer:Slider({
    Name    = "WalkSpeed",
    Range   = { 16, 500 },
    Default = 16,
    Flag    = "WalkSpeed",
    Callback = function(Value)
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
    end,
})

TabPlayer:Slider({
    Name    = "JumpPower",
    Range   = { 50, 500 },
    Default = 50,
    Flag    = "JumpPower",
    Callback = function(Value)
        game.Players.LocalPlayer.Character.Humanoid.JumpPower = Value
    end,
})

TabPlayer:Toggle({
    Name    = "Infinite Jump",
    Default = false,
    Flag    = "InfJump",
    Callback = function(Value)
        if Value then
            loadstring(game:HttpGet(RepoURL .. "Functions/InfiniteJump.lua", true))()
        end
    end,
})

TabPlayer:Toggle({
    Name    = "NoClip",
    Default = false,
    Flag    = "NoClip",
    Callback = function(Value)
        if Value then
            loadstring(game:HttpGet(RepoURL .. "Functions/NoClip.lua", true))()
        end
    end,
})

TabPlayer:Button({
    Name = "Load Player Functions",
    Callback = function()
        loadstring(game:HttpGet(RepoURL .. "Tabs/Player.lua", true))()
    end,
})

local TabTeleport = Window:Tab({
    Name = "Teleport",
    Icon = "map-pin",
})

TabTeleport:Section({ Name = "Locations" })

TabTeleport:Button({
    Name = "Teleport to Spawn",
    Callback = function()
        loadstring(game:HttpGet(RepoURL .. "Functions/TeleportSpawn.lua", true))()
    end,
})

TabTeleport:Button({
    Name = "Teleport to Farm Zone",
    Callback = function()
        loadstring(game:HttpGet(RepoURL .. "Functions/TeleportFarm.lua", true))()
    end,
})

TabTeleport:Button({
    Name = "Load Teleport Tab",
    Callback = function()
        loadstring(game:HttpGet(RepoURL .. "Tabs/Teleport.lua", true))()
    end,
})

local TabVisual = Window:Tab({
    Name = "Visual",
    Icon = "eye",
})

TabVisual:Section({ Name = "ESP" })

TabVisual:Toggle({
    Name    = "Player ESP",
    Default = false,
    Flag    = "PlayerESP",
    Callback = function(Value)
        if Value then
            loadstring(game:HttpGet(RepoURL .. "Functions/PlayerESP.lua", true))()
        end
    end,
})

TabVisual:Toggle({
    Name    = "Item ESP",
    Default = false,
    Flag    = "ItemESP",
    Callback = function(Value)
        if Value then
            loadstring(game:HttpGet(RepoURL .. "Functions/ItemESP.lua", true))()
        end
    end,
})

TabVisual:Button({
    Name = "Load Visual Tab",
    Callback = function()
        loadstring(game:HttpGet(RepoURL .. "Tabs/Visual.lua", true))()
    end,
})

local TabMisc = Window:Tab({
    Name = "Misc",
    Icon = "settings",
})

TabMisc:Section({ Name = "Extras" })

TabMisc:Button({
    Name = "Anti-AFK",
    Callback = function()
        loadstring(game:HttpGet(RepoURL .. "Functions/AntiAFK.lua", true))()
    end,
})

TabMisc:Button({
    Name = "Load All Functions",
    Callback = function()
        loadstring(game:HttpGet(RepoURL .. "Tabs/Misc.lua", true))()
    end,
})

TabMisc:Paragraph({
    Title   = "Slow Hub",
    Content = "Version: 1.0.0\nMade by: Slow Hub Team\nRepo: github.com/oneTime999/CutGrassForBrainrot",
})
