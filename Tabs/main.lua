local RepoURL = "https://raw.githubusercontent.com/oneTime999/CutGrassForBrainrot/main/"

return function(Window)
    local Tab = Window:Tab({
        Title = "Main",
        Icon = "house",
    })

    local TeleportSection = Tab:Section({
        Title = "Zone Teleports",
    })

    TeleportSection:Paragraph({
        Title = "How To Use",
        Desc = "Select the desired island from the dropdown below, then click the Teleport button to teleport to the selected zone.",
    })

    local TeleportZones = loadstring(game:HttpGet(RepoURL .. "Functions/teleportzones.lua", true))()
    TeleportZones(TeleportSection)

    local BaseSection = Tab:Section({
        Title = "Teleport to Base",
    })

    BaseSection:Paragraph({
        Title = "How To Use",
        Desc = "Click the TP to Base button to instantly teleport back to your base.",
    })

    local TeleportBase = loadstring(game:HttpGet(RepoURL .. "Functions/teleportbase.lua", true))()
    TeleportBase(BaseSection)

    local GrassSection = Tab:Section({
        Title = "Grass",
    })

    GrassSection:Paragraph({
        Title = "How To Use",
        Desc = "Click the Remove Grass button to destroy all GrassLine objects in the workspace.",
    })

    local RemoveGrass = loadstring(game:HttpGet(RepoURL .. "Functions/removegrass.lua", true))()
    RemoveGrass(GrassSection)
end
