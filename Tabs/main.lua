local RepoURL = "https://raw.githubusercontent.com/oneTime999/CutGrassForBrainrot/main/"

return function(Window)
    local Tab = Window:Tab({
        Title = "Main",
        Icon = "house",
    })

    local TeleportSection = Tab:Section({
        Title = "Island Teleports",
    })

    TeleportSection:Paragraph({
        Title = "How to use",
        Desc = "Select the desired island from the dropdown below, then click the Teleport button to teleport to the selected zone.",
    })

    local TeleportZones = loadstring(game:HttpGet(RepoURL .. "Functions/teleportzones.lua", true))()
    TeleportZones(TeleportSection)

    local GrassSection = Tab:Section({
        Title = "Grass",
    })

    GrassSection:Paragraph({
        Title = "How to use",
        Desc = "Click the Remove Grass button to destroy all GrassLine objects in the workspace.",
    })

    GrassSection:Button({
        Title = "Remove Grass",
        Callback = function()
            loadstring(game:HttpGet(RepoURL .. "Functions/removegrass.lua", true))()
        end,
    })
end
