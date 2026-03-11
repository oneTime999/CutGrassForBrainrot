return function(Parent)
    Parent:Button({
        Title = "Teleport to My Base",
        Desc = "Teleports you to your base in the map.",
        Callback = function()
            local Player = game.Players.LocalPlayer
            local Character = Player.Character
            local Bases = workspace:FindFirstChild("Bases")

            if not Bases then return end
            if not Character or not Character:FindFirstChild("HumanoidRootPart") then return end

            local Base = Bases:FindFirstChild(Player.Name)
            if not Base then return end

            local PrimaryPart = Base.PrimaryPart or Base:FindFirstChildWhichIsA("BasePart")
            if not PrimaryPart then return end

            Character.HumanoidRootPart.CFrame = PrimaryPart.CFrame + Vector3.new(0, 5, 0)
        end,
    })
end
