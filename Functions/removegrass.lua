return function(Parent)
    Parent:Button({
        Title = "Remove Grass",
        Desc = "Removes all GrassLine objects from the workspace.",
        Callback = function()
            local function removeGrassLine(parent)
                for _, child in ipairs(parent:GetChildren()) do
                    if child.Name == "GrassLine" then
                        child:Destroy()
                    end
                    if #child:GetChildren() > 0 then
                        if not child:IsA("Terrain") and not child:IsA("Camera") then
                            removeGrassLine(child)
                        end
                    end
                end
            end
            removeGrassLine(workspace)
        end,
    })
end
