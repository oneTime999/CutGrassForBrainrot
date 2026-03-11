local RepoURL = "https://raw.githubusercontent.com/oneTime999/CutGrassForBrainrot/main/"

return function(Window)
    local Tab = Window:Tab({
        Title = "Main",
        Icon = "house",
    })

    local Section = Tab:Section({
        Title = "Island Teleports",
    })

    Section:Paragraph({
        Title = "How to use",
        Desc = "Select the desired island from the dropdown below, then click the Teleport button to teleport to the selected zone.",
    })

    local TeleportZones = loadstring(game:HttpGet(RepoURL .. "Functions/teleportzones.lua", true))()
    TeleportZones(Section)
end
