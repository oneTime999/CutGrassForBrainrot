return function(Parent, ZoneIndex)
    local ZoneName = "Lava_" .. ZoneIndex
    local SelectedBrainrot = nil

    local function getSpawnZone()
        return workspace:FindFirstChild("Zones")
            and workspace.Zones:FindFirstChild(ZoneName)
            and workspace.Zones[ZoneName]:FindFirstChild("SpawnZone")
    end

    local function getBrainrots()
        local list = {}
        local SpawnZone = getSpawnZone()

        if SpawnZone then
            for _, obj in ipairs(SpawnZone:GetChildren()) do
                if obj:IsA("Model") then
                    table.insert(list, obj.Name)
                end
            end
        end

        if #list == 0 then
            table.insert(list, "No Brainrots Found")
        end

        return list
    end

    local Dropdown = Parent:Dropdown({
        Title = "Zone " .. ZoneIndex .. " - Select Brainrot",
        Values = getBrainrots(),
        Value = getBrainrots()[1],
        Multi = false,
        Callback = function(Value)
            SelectedBrainrot = Value
        end,
    })

    Parent:Button({
        Title = "Refresh List",
        Desc = "Refresh the brainrot list for Zone " .. ZoneIndex,
        Callback = function()
            Dropdown:Refresh(getBrainrots())
        end,
    })

    Parent:Button({
        Title = "Teleport to Brainrot",
        Desc = "Teleport to the selected brainrot in Zone " .. ZoneIndex,
        Callback = function()
            if not SelectedBrainrot or SelectedBrainrot == "No Brainrots Found" then return end

            local SpawnZone = getSpawnZone()
            if not SpawnZone then return end

            local Target = SpawnZone:FindFirstChild(SelectedBrainrot)
            if not Target then return end

            local Part = Target.PrimaryPart or Target:FindFirstChildWhichIsA("BasePart")
            if not Part then return end

            local Character = game.Players.LocalPlayer.Character
            if Character and Character:FindFirstChild("HumanoidRootPart") then
                Character.HumanoidRootPart.CFrame = Part.CFrame + Vector3.new(0, 5, 0)
            end
        end,
    })
end
