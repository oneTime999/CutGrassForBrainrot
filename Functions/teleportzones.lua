local Zones = {
    ["Zone 1"] = Vector3.new(-783.1070556640625, 32.900001525878906, 0.10000000149011612),
    ["Zone 2"] = Vector3.new(-656.1070556640625, 32.900001525878906, 0.10000000149011612),
    ["Zone 3"] = Vector3.new(-493.95355224609375, 32.900001525878906, 0.09999734163284302),
    ["Zone 4"] = Vector3.new(-296.30010986328125, 32.900001525878906, 0.09999734163284302),
    ["Zone 5"] = Vector3.new(-70.8001480102539, 32.900001525878906, 0.09999734163284302),
    ["Zone 6"] = Vector3.new(-70.8001480102539, 32.900001525878906, 0.09999734163284302),
    ["Zone 7"] = Vector3.new(514.6998901367188, 32.900001525878906, 0.09999734163284302),
    ["Zone 8"] = Vector3.new(838.6998901367188, 32.900001525878906, 0.09999734163284302),
}

local ZoneOrder = {
    "Zone 1", "Zone 2", "Zone 3", "Zone 4",
    "Zone 5", "Zone 6", "Zone 7", "Zone 8"
}

local SelectedZone = ZoneOrder[1]

return function(Tab)
    Tab:Section({ Name = "Teleport Zones" })

    Tab:Dropdown({
        Name    = "Select Zone",
        Items   = ZoneOrder,
        Default = ZoneOrder[1],
        Flag    = "SelectedZone",
        Callback = function(Value)
            SelectedZone = Value
        end,
    })

    Tab:Button({
        Name = "Teleport",
        Callback = function()
            local Character = game.Players.LocalPlayer.Character
            if Character and Character:FindFirstChild("HumanoidRootPart") then
                Character.HumanoidRootPart.CFrame = CFrame.new(Zones[SelectedZone])
            end
        end,
    })
end
