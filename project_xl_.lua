local A = game:GetService("CoreGui"):FindFirstChild("unknown")
if A then
    A:Destroy()
end

local LocalPlayer = game:GetService("Players").LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RemoteEvents = ReplicatedStorage:WaitForChild("RemoteEvents")


local library = loadstring(game:HttpGet('https://raw.githubusercontent.com/cueshut/saves/main/criminality%20paste%20ui%20library'))()

-- // Window \\ --
local window = library.new('Syn0xz Hub', 'Syn0xz')

-- // Tabs \\ --
local tab = window.new_tab('rbxassetid://4483345998')

-- // Sections \\ --
local section = tab.new_section('Main')

-- // Sector \\ --
local sector = section.new_sector('- Farming -', 'Left')
local sector1 = section.new_sector('- Misc -', 'Right')
local AutoF = section.new_sector('- Auto Find -', 'Right')

-- // Elements \\ -- (Type, Name, State, Callback)



local toggle = sector.element('Toggle', 'Auto Farm', false, function(v)
    _G.Auto = v.Toggle
    while _G.Auto do task.wait()
        RemoteEvents:WaitForChild("BladeCombatRemote"):FireServer()
        for i,v in ipairs(game:GetService("Workspace").Live:GetChildren()) do
        local hum = v:FindFirstChild("Humanoid")
        local target = v:FindFirstChild("HumanoidRootPart")
            if v.Name == _G.Mob then
                if target and hum then
                    if hum and (hum.Health / hum.MaxHealth * 100) > 0 then
                        local character = game:GetService("Players").LocalPlayer.Character
                        local hrp = character:FindFirstChild("HumanoidRootPart")
                        if character and hrp then
                            hrp.CFrame = target.CFrame * CFrame.new(0,0,5)
                        end
                    end
                end
            end
        end
    end
end)

local toggle_quest = sector.element('Toggle', 'Auto Quest', false, function(v)
    _G.Quest = v.Toggle
    print(_G.Quest)
    while _G.Quest do wait(.25)

        local PlayerGui = LocalPlayer:FindFirstChild("PlayerGui")
        local Quest = ReplicatedStorage:WaitForChild("Quests")
        
        if PlayerGui then
            local Menu = PlayerGui:FindFirstChild("Menu")
            if Menu then
                local Quest = Menu:FindFirstChild("QuestFrame")
                if Quest then
                    if Quest.Visible == false then
                        if _G.Mob == "Demon" then
                            local args = {
                                [1] = game:GetService("ReplicatedStorage"):WaitForChild("Quests"):WaitForChild("Defeat 4 Demons")
                            }
                            
                            game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvents"):WaitForChild("ChangeQuestRemote"):FireServer(unpack(args))
                        end

                        if _G.Mob == "Akatsuki Grunt" then
                            local args = {
                                [1] = game:GetService("ReplicatedStorage"):WaitForChild("Quests"):WaitForChild("Defeat 6 Akatsuki Grunts")
                            }
                            
                            game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvents"):WaitForChild("ChangeQuestRemote"):FireServer(unpack(args))                            
                        end

                        if _G.Mob == "Rahgan's Overseer" then
                            local args = {
                                [1] = game:GetService("ReplicatedStorage"):WaitForChild("Quests"):WaitForChild("Defeat 4 of Rahgan's Overseers")
                            }
                            
                            game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvents"):WaitForChild("ChangeQuestRemote"):FireServer(unpack(args))                            
                        end

                        if _G.Mob == "Agni's Overseer" then
                            local args = {
                                [1] = game:GetService("ReplicatedStorage"):WaitForChild("Quests"):WaitForChild("Defeat 6 of Agni's Overseers")
                            }
                            
                            game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvents"):WaitForChild("ChangeQuestRemote"):FireServer(unpack(args))
                        end

                        if _G.Mob == "Lars' Minion" then
                            local args = {
                                [1] = game:GetService("ReplicatedStorage"):WaitForChild("Quests"):WaitForChild("Defeat 8 of Lars' Minions")
                            }
                            
                            game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvents"):WaitForChild("ChangeQuestRemote"):FireServer(unpack(args))                            
                        end

                        if _G.Mob == "Agni's Minion" then
                            local args = {
                                [1] = game:GetService("ReplicatedStorage"):WaitForChild("Quests"):WaitForChild("Defeat 9 of Agni's Minions")
                            }
                            
                            game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvents"):WaitForChild("ChangeQuestRemote"):FireServer(unpack(args))      
                        end

                        if _G.Mob == "Bandit" then
                            local args = {
                                [1] = game:GetService("ReplicatedStorage"):WaitForChild("Quests"):WaitForChild("Defeat 10 Bandits")
                            }
                            
                            game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvents"):WaitForChild("ChangeQuestRemote"):FireServer(unpack(args)) 
                        end
                    end
                end
            end
        end
    end
end)

local dropdown = sector.element('Dropdown', 'Mob Select', {options = {'Demon', 'Akatsuki Grunt', "Rahgan's Overseer", "Agni's Overseer", "Lars' Minion", "Agni's Minion", "Bandit"}}, function(v)
   print(v.Dropdown)
   _G.Mob = tostring(v.Dropdown)
end)

local toggle = sector.element('Toggle', 'Auto Farm (Boss)', false, function(v)
    _G.Auto = v.Toggle
    while _G.Auto do task.wait()
        RemoteEvents:WaitForChild("BladeCombatRemote"):FireServer()
        for i,v in ipairs(game:GetService("Workspace").Live:GetChildren()) do
        local hum = v:FindFirstChild("Humanoid")
        local target = v:FindFirstChild("HumanoidRootPart")
            if v.Name == _G.Boss then
                if target and hum then
                    if hum and (hum.Health / hum.MaxHealth * 100) > 0 then
                        local character = game:GetService("Players").LocalPlayer.Character
                        local hrp = character:FindFirstChild("HumanoidRootPart")
                        if character and hrp then
                            hrp.CFrame = target.CFrame * CFrame.new(0,0,5)
                        end
                    end
                end
            end
        end
    end
end)

local dropdown = sector.element('Dropdown', 'Boss Select', {options = {'Gojo', 'Shinra'}}, function(v)
   print(v.Dropdown)
   _G.Boss = tostring(v.Dropdown)
end)




local toggle = sector.element('Toggle', 'Auto Farm Zoro', false, function(v)
    _G.Auto_Zoro = v.Toggle
    while _G.Auto_Zoro do task.wait()
        RemoteEvents:WaitForChild("BladeCombatRemote"):FireServer()
        for i,v in ipairs(game:GetService("Workspace").Live:GetChildren()) do
        local hum = v:FindFirstChild("Humanoid")
        local target = v:FindFirstChild("HumanoidRootPart")
            if v.Name == "Zoro (TS)" or v.Name == "Zoro (PTS)" then
                if target and hum then
                    if hum and (hum.Health / hum.MaxHealth * 100) > 0 then
                        local character = game:GetService("Players").LocalPlayer.Character
                        local hrp = character:FindFirstChild("HumanoidRootPart")
                        if character and hrp then
                            hrp.CFrame = target.CFrame * CFrame.new(0,0,5)
                        end
                    end
                end
            end
        end
    end
end)

















local Insatant = sector1.element('Toggle', 'Instant Kill', false, function(v)
   _G.insatant = v.Toggle
    while _G.insatant do task.wait(.125)
        for i,v in ipairs(game:GetService("Workspace").Live:GetChildren()) do
            local hum = v:FindFirstChild("Humanoid")
            if hum then
                if hum and (hum.Health / hum.MaxHealth * 100) < 100 then
                    local head = v:FindFirstChild("Head")
                    if head then
                        head:Destroy()
                    end
                end
            end
        end
    end
end)

local Effect = sector1.element('Toggle', 'Disable Effect', false, function(v)
   _G.Effect = v.Toggle
    while _G.Effect do task.wait()
        for i,v in ipairs(game:GetService("Workspace").Effects:GetChildren()) do
            v:Destroy()
        end
    end
end)

local EquipTool = sector1.element('Toggle', 'Equip Tool', false, function(v)
    _G.Tool = v.Toggle
    while _G.Tool do task.wait(3)
        local Backpack = LocalPlayer:FindFirstChild("Backpack")
        local Character = game:GetService("Players").LocalPlayer.Character
        if Character and Backpack then
            for i,v in ipairs(game:GetService("Players").LocalPlayer.Character:GetChildren()) do
                if not v:IsA("Tool") then
                    for i,v in ipairs(game:GetService("Players").LocalPlayer.Backpack:GetChildren()) do
                        if v:IsA("Tool") then
                            v.Parent = game.Players.LocalPlayer.Character
                        end
                    end
                end
            end   
        end
    end
end)


local Auto_Accessory = AutoF.element('Toggle', 'Auto Accessory', false, function(v)
    _G.Accessory = v.Toggle
    while _G.Accessory do wait(.125)
        if _G.Accessory == true then
        RemoteEvents:WaitForChild("BuyItemRemote"):FireServer("Random Accessory")
            local Backpack = game.Players.LocalPlayer.Backpack
            if Backpack then
                for i, tool in ipairs(Backpack:GetChildren()) do
                    if tool:IsA("Tool") then
                        local BP = tool:FindFirstChild("BagPart")
                        if BP then
                            local OH = BP:FindFirstChild("Overhead")
                            if OH then
                                local Rarity = OH:FindFirstChild("Rarity")
                                if Rarity then
                                    for i2,val in ipairs(_G.WL) do
                                        if Rarity.Text == val then
                                            print("Founded")
                                            _G.Accessory = false
                                        else
                                            print(Rarity.Text)
                                            RemoteEvents:WaitForChild("ClearBagsRemote"):FireServer()
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end)


local Auto_Armor = AutoF.element('Toggle', 'Auto Armor', false, function(v)
    _G.Armor = v.Toggle
    while _G.Armor do wait(.125)
        if _G.Armor == true then
        RemoteEvents:WaitForChild("BuyItemRemote"):FireServer("Random Armor")
            local Backpack = game.Players.LocalPlayer.Backpack
            if Backpack then
                for i, tool in ipairs(Backpack:GetChildren()) do
                    if tool:IsA("Tool") then
                        local BP = tool:FindFirstChild("BagPart")
                        if BP then
                            local OH = BP:FindFirstChild("Overhead")
                            if OH then
                                local Rarity = OH:FindFirstChild("Rarity")
                                if Rarity then
                                    for i2,val in ipairs(_G.WL) do
                                        if Rarity.Text == val then
                                            print("Founded")
                                            _G.Accessory = false
                                        else
                                            print(Rarity.Text)
                                            RemoteEvents:WaitForChild("ClearBagsRemote"):FireServer()
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end)


local Wl_Accessory = AutoF.element('Combo', 'Selected', {options = {'Common', 'Uncommon', 'Rare', 'Legendary'}}, function(v)
    _G.WL = v.Combo
end)
