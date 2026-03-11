return function(Parent)
    Parent:Button({
        Title = "Remove Grass",
        Desc = "Removes all GrassLine objects from the workspace.",
        Callback = function()
            for _, obj in ipairs(workspace:GetDescendants()) do
                if obj.Name == "GrassLine" then
                    obj:Destroy()
                end
            end
        end,
    })
end
