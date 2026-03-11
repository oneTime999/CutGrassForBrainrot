local RepoURL = "https://raw.githubusercontent.com/oneTime999/CutGrassForBrainrot/main/"

return function(Window)
    local Tab = Window:Tab({
        Title = "Farms",
        Icon = "wheat",
    })

    local ZoneFarm = loadstring(game:HttpGet(RepoURL .. "Functions/zonefarm.lua", true))()

    for i = 1, 8 do
        local Section = Tab:Section({
            Title = "Zone " .. i,
        })

        ZoneFarm(Section, i)
    end
end
