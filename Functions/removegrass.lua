return function(Parent)
    Parent:Button({
        Title = "Remove Grass",
        Desc = "Removes all GrassLine objects from the workspace.",
        Callback = function()
            local function removeGrassLine(parent)
                for _, child in ipairs(parent:GetChildren()) do
                    if not child:IsA("Terrain") and not child:IsA("Camera") then
                        if #child:GetChildren() > 0 then
                            removeGrassLine(child)
                        end
                    end
                    if child.Name == "GrassLine" then
                        child:Destroy()
                    end
                end
            end
            removeGrassLine(workspace)
        end,
    })
end
