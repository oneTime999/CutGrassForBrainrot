local RepoURL = "https://raw.githubusercontent.com/oneTime999/CutGrassForBrainrot/main/"

return function(Window)
    local Tab = Window:Tab({
        Name = "Main",
        Icon = "house",
    })

    Tab:Section({ Name = "Island Teleports" })

    Tab:Paragraph({
        Title   = "How to use",
        Content = "Select the desired island from the dropdown below, then click the Teleport button to teleport to the selected zone.",
    })

    local TeleportZones = loadstring(game:HttpGet(RepoURL .. "Functions/teleportzones.lua", true))()
    TeleportZones(Tab)
end
