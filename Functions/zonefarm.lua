return function(Parent, ZoneIndex)
    local ZoneName = "Lava_" .. ZoneIndex
    local SelectedBrainrot = nil
    local AutoInteractLoop = false
    local AutoFarmLoop = false
    local AutoCollectLoop = false
    local NoclipEnabled = false

    -- Função auxiliar para pegar o SpawnZone
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

    -- Dropdown para selecionar Brainrot
    local Dropdown = Parent:Dropdown({
        Title = "Zone " .. ZoneIndex .. " - Select Brainrot",
        Values = getBrainrots(),
        Value = getBrainrots()[1],
        Multi = false,
        Callback = function(Value)
            SelectedBrainrot = Value
        end,
    })

    -- Botão Refresh
    Parent:Button({
        Title = "Refresh List",
        Desc = "Refresh the brainrot list for Zone " .. ZoneIndex,
        Callback = function()
            local newList = getBrainrots()
            Dropdown:Refresh(newList)
        end,
    })

    -- Teleporte para o Brainrot selecionado
    Parent:Button({
        Title = "Teleport to Brainrot",
        Desc = "Teleport to the selected brainrot in Zone " .. ZoneIndex,
        Callback = function()
            if not SelectedBrainrot or SelectedBrainrot == "No Brainrots Found" then 
                warn("Nenhum brainrot selecionado!")
                return 
            end

            local SpawnZone = getSpawnZone()
            if not SpawnZone then return end

            local Target = SpawnZone:FindFirstChild(SelectedBrainrot)
            if not Target then 
                warn("Brainrot não encontrado no workspace!")
                return 
            end

            local Part = Target.PrimaryPart or Target:FindFirstChildWhichIsA("BasePart")
            if not Part then return end

            local Character = game.Players.LocalPlayer.Character
            if Character and Character:FindFirstChild("HumanoidRootPart") then
                Character.HumanoidRootPart.CFrame = Part.CFrame + Vector3.new(0, 5, 0)
            end
        end,
    })

    -- AUTO INTERACT - Interage rapidamente com o brainrot (clica/usa proximidade)
    Parent:Toggle({
        Title = "Auto Interact",
        Desc = "Interage automaticamente com o Brainrot mais próximo (spam de E/Click)",
        Default = false,
        Callback = function(Value)
            AutoInteractLoop = Value
            if Value then
                task.spawn(function()
                    while AutoInteractLoop do
                        local player = game.Players.LocalPlayer
                        local char = player.Character
                        if not char then task.wait(0.1) continue end

                        local hrp = char:FindFirstChild("HumanoidRootPart")
                        if not hrp then task.wait(0.1) continue end

                        -- Procura o brainrot mais próximo
                        local SpawnZone = getSpawnZone()
                        if not SpawnZone then task.wait(0.5) continue end

                        local closestDist = math.huge
                        local closestBrainrot = nil

                        for _, obj in ipairs(SpawnZone:GetChildren()) do
                            if obj:IsA("Model") then
                                local part = obj.PrimaryPart or obj:FindFirstChildWhichIsA("BasePart")
                                if part then
                                    local dist = (hrp.Position - part.Position).Magnitude
                                    if dist < closestDist and dist < 50 then -- só interage se estiver perto (50 studs)
                                        closestDist = dist
                                        closestBrainrot = obj
                                    end
                                end
                            end
                        end

                        -- Métodos de interação comuns em jogos Roblox
                        if closestBrainrot and closestDist < 10 then
                            -- Método 1: FireProximityPrompt (mais comum)
                            for _, child in ipairs(closestBrainrot:GetDescendants()) do
                                if child:IsA("ProximityPrompt") then
                                    fireproximityprompt(child, 0) -- 0 = não espera hold
                                    break
                                end
                            end

                            -- Método 2: ClickDetector
                            for _, child in ipairs(closestBrainrot:GetDescendants()) do
                                if child:IsA("ClickDetector") then
                                    fireclickdetector(child)
                                    break
                                end
                            end

                            -- Método 3: RemoteEvent (alguns jogos usam)
                            -- Verifica se tem algum evento de coleta
                            local collectEvent = closestBrainrot:FindFirstChild("Collect") 
                                or closestBrainrot:FindFirstChild("Interact")
                            if collectEvent and collectEvent:IsA("RemoteEvent") then
                                collectEvent:FireServer()
                            end
                        end

                        task.wait(0.1) -- spam rápido mas não lag
                    end
                end)
            end
        end,
    })

    -- AUTO FARM - Teleporta entre todos os brainrots automaticamente
    Parent:Toggle({
        Title = "Auto Farm Zone",
        Desc = "Teleporta automaticamente entre todos os brainrots da zona",
        Default = false,
        Callback = function(Value)
            AutoFarmLoop = Value
            if Value then
                task.spawn(function()
                    while AutoFarmLoop do
                        local SpawnZone = getSpawnZone()
                        if not SpawnZone then task.wait(1) continue end

                        local brainrots = {}
                        for _, obj in ipairs(SpawnZone:GetChildren()) do
                            if obj:IsA("Model") then
                                table.insert(brainrots, obj)
                            end
                        end

                        for _, brainrot in ipairs(brainrots) do
                            if not AutoFarmLoop then break end
                            
                            local part = brainrot.PrimaryPart or brainrot:FindFirstChildWhichIsA("BasePart")
                            if part then
                                local char = game.Players.LocalPlayer.Character
                                if char and char:FindFirstChild("HumanoidRootPart") then
                                    -- Teleporta
                                    char.HumanoidRootPart.CFrame = part.CFrame + Vector3.new(0, 3, 0)
                                    
                                    -- Espera um pouco para carregar/coisar
                                    task.wait(0.5)
                                    
                                    -- Tenta interagir automaticamente
                                    for _, child in ipairs(brainrot:GetDescendants()) do
                                        if child:IsA("ProximityPrompt") then
                                            fireproximityprompt(child, 0)
                                            break
                                        elseif child:IsA("ClickDetector") then
                                            fireclickdetector(child)
                                            break
                                        end
                                    end
                                    
                                    task.wait(1) -- tempo entre cada brainrot
                                end
                            end
                        end
                        
                        task.wait(0.5) -- espera antes de reiniciar o loop
                    end
                end)
            end
        end,
    })

    -- AUTO COLLECT - Coleta drops automaticamente (partículas/itens no chão)
    Parent:Toggle({
        Title = "Auto Collect Drops",
        Desc = "Puxa todos os drops/itens do chão para você automaticamente",
        Default = false,
        Callback = function(Value)
            AutoCollectLoop = Value
            if Value then
                task.spawn(function()
                    while AutoCollectLoop do
                        local char = game.Players.LocalPlayer.Character
                        if not char then task.wait(0.1) continue end
                        
                        local hrp = char:FindFirstChild("HumanoidRootPart")
                        if not hrp then task.wait(0.1) continue end

                        -- Procura por itens/drops comuns no workspace
                        local dropsFolder = workspace:FindFirstChild("Drops") 
                            or workspace:FindFirstChild("Items")
                            or workspace

                        for _, item in ipairs(dropsFolder:GetDescendants()) do
                            if item:IsA("BasePart") and item.Name:lower():match("drop") 
                                or item.Name:lower():match("coin") 
                                or item.Name:lower():match("item") then
                                
                                local dist = (hrp.Position - item.Position).Magnitude
                                if dist < 100 then -- só pega se estiver num raio de 100 studs
                                    -- Traz o item até o player
                                    if item:FindFirstChild("BodyPosition") then
                                        item.BodyPosition:Destroy()
                                    end
                                    
                                    -- Método 1: CFrame direto
                                    item.CFrame = hrp.CFrame
                                    
                                    -- Método 2: Se tiver TouchInterest, toca nele
                                    local touch = item:FindFirstChild("TouchInterest")
                                    if touch then
                                        firetouchinterest(hrp, item, 0)
                                        firetouchinterest(hrp, item, 1)
                                    end
                                end
                            end
                        end

                        task.wait(0.1)
                    end
                end)
            end
        end,
    })

    -- NOCLIP - Atravessa paredes (útil para farmar mais rápido)
    Parent:Toggle({
        Title = "Noclip",
        Desc = "Atravessa paredes e obstáculos",
        Default = false,
        Callback = function(Value)
            NoclipEnabled = Value
            local player = game.Players.LocalPlayer
            
            if Value then
                task.spawn(function()
                    while NoclipEnabled do
                        local char = player.Character
                        if char then
                            for _, part in ipairs(char:GetDescendants()) do
                                if part:IsA("BasePart") then
                                    part.CanCollide = false
                                end
                            end
                        end
                        task.wait(0.1)
                    end
                    
                    -- Restaura colisão quando desliga
                    local char = player.Character
                    if char then
                        for _, part in ipairs(char:GetDescendants()) do
                            if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
                                part.CanCollide = true
                            end
                        end
                    end
                end)
            end
        end,
    })

    -- ESP - Mostra onde estão todos os brainrots através das paredes
    Parent:Button({
        Title = "ESP Brainrots",
        Desc = "Mostra localização de todos os brainrots na zona",
        Callback = function()
            local SpawnZone = getSpawnZone()
            if not SpawnZone then return end

            for _, obj in ipairs(SpawnZone:GetChildren()) do
                if obj:IsA("Model") then
                    local part = obj.PrimaryPart or obj:FindFirstChildWhichIsA("BasePart")
                    if part and not part:FindFirstChild("ESP_Highlight") then
                        -- Cria highlight (contorno)
                        local highlight = Instance.new("Highlight")
                        highlight.Name = "ESP_Highlight"
                        highlight.FillColor = Color3.fromRGB(255, 0, 0)
                        highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
                        highlight.FillTransparency = 0.5
                        highlight.Parent = part
                        
                        -- Cria BillboardGui com nome
                        local billboard = Instance.new("BillboardGui")
                        billboard.Name = "ESP_Name"
                        billboard.Size = UDim2.new(0, 100, 0, 50)
                        billboard.AlwaysOnTop = true
                        billboard.StudsOffset = Vector3.new(0, 3, 0)
                        billboard.Parent = part
                        
                        local textLabel = Instance.new("TextLabel")
                        textLabel.Size = UDim2.new(1, 0, 1, 0)
                        textLabel.BackgroundTransparency = 1
                        textLabel.Text = obj.Name
                        textLabel.TextColor3 = Color3.fromRGB(255, 255, 0)
                        textLabel.TextStrokeTransparency = 0
                        textLabel.TextScaled = true
                        textLabel.Parent = billboard
                    end
                end
            end
        end,
    })

    -- Remove ESP
    Parent:Button({
        Title = "Remove ESP",
        Desc = "Remove os destaques dos brainrots",
        Callback = function()
            local SpawnZone = getSpawnZone()
            if not SpawnZone then return end

            for _, obj in ipairs(SpawnZone:GetDescendants()) do
                if obj:IsA("Highlight") and obj.Name == "ESP_Highlight" then
                    obj:Destroy()
                end
                if obj:IsA("BillboardGui") and obj.Name == "ESP_Name" then
                    obj:Destroy()
                end
            end
        end,
    })

    -- BRING ALL - Traz todos os brainrots até você (pode não funcionar em jogos com anti-cheat forte)
    Parent:Button({
        Title = "Bring All (Risky)",
        Desc = "Tenta trazer todos os brainrots até você (pode kickar)",
        Callback = function()
            local SpawnZone = getSpawnZone()
            if not SpawnZone then return end

            local hrp = game.Players.LocalPlayer.Character 
                and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            if not hrp then return end

            for _, obj in ipairs(SpawnZone:GetChildren()) do
                if obj:IsA("Model") then
                    local part = obj.PrimaryPart or obj:FindFirstChildWhichIsA("BasePart")
                    if part and part:IsA("BasePart") then
                        -- Tenta setar CFrame (só funciona se o jogo não tiver proteção)
                        pcall(function()
                            part.CFrame = hrp.CFrame + Vector3.new(math.random(-5, 5), 0, math.random(-5, 5))
                        end)
                    end
                end
            end
        end,
    })
end
