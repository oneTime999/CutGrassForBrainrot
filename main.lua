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

Window:Intro({
    Icon   = "zap",
    Title  = "Slow Hub",
    Slogan = "Made by Slow Hub Team",
    Color  = Color3.fromRGB(100, 180, 255),
})

local Tabs = {
    "main",
}

for _, TabName in ipairs(Tabs) do
    loadstring(game:HttpGet(RepoURL .. "Tabs/" .. TabName .. ".lua", true))(Window)
end
