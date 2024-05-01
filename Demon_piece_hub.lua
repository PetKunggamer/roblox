repeat wait() until game:IsLoaded()

local A = game:GetService("CoreGui"):FindFirstChild("unknown")
if A then
    A:Destroy()
end
    
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local plr = game.Players.LocalPlayer
local chr = plr.Character
local root = chr.HumanoidRootPart


local function notify(Titles,message)
    game:GetService("StarterGui"):SetCore("SendNotification",{
    	Title = tostring(Titles),
    	Text = tostring(message),
    	Icon = "rbxassetid://1234567890"
    })
end

local function Combat()
    local Players = game.Players
    local Backpack = Players.LocalPlayer.Backpack
    local Character = Players.LocalPlayer.Character
    
    for i,v in ipairs(Backpack:GetChildren()) do
        if v:IsA("Tool") and (v.Name == "Combat" or v.Name == "Black Leg" or v.Name == "Electro") then
            v.Parent = Character
            break
        end
        
        local current = Character:FindFirstChildOfClass("Tool")
        if current then
            local args = {
                [1] = "Combat",
                [2] = 0.275,
                [3] = "left",
                [4] = 0.275,
                [5] = current.Name
            }
    
            game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("ServerMove"):FireServer(unpack(args))
        end
    end
end

local function Sword()
    local Sword_List = { "Axe-Hand", "Captain's Rapier", "Dark Blade", "Forest Nymphs", "Golden Hook", "Golden Staff", "Holy Book", "Iron Mace", "Jitte", "Katana", "Longsword", "Pipe", "Sandai", "Scimitar Daggers", "Shark Saw", "Shusui", "Skyborne Lance", "Tidebreaker", "Warrior's Spear", "Wooden Staff"
}
    local Players = game.Players
    local Backpack = Players.LocalPlayer.Backpack
    local Character = Players.LocalPlayer.Character
    

    for i,v in ipairs(Backpack:GetChildren()) do
        for _,tool in ipairs(Sword_List) do 
            if v:IsA("Tool") and (v.Name == tool) then
                v.Parent = Character
                break
            end
        end
    end
        
    local current_sword = Character:FindFirstChildOfClass("Tool")
    if current_sword then
        local args = {
            [1] = "SwordCombat",
            [2] = 0.38866666666666666,
            [3] = "three",
            [4] = 0.38866666666666666,
            [5] = current_sword
        }
        
        game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("ServerMove"):FireServer(unpack(args))
        
    end
end

local function Chest()
    local root = game.Players.LocalPlayer.Character.HumanoidRootPart
    for _, v in ipairs(workspace.ChestSpawns:GetDescendants()) do
        if v:IsA("Model") and v.Name:find("Chest") then
            local KeyHole = v:FindFirstChild("KeyHole")
            if KeyHole and KeyHole.Transparency == 0 then
                local Press = v:FindFirstChild("PressPart")
                if Press then
                    local cdk = Press:FindFirstChild("ClickDetector")
                    if cdk then
                        root.CFrame = Press.CFrame
                        wait(.222)
                        fireclickdetector(cdk)
                    end     
                end
            end
        end
    end
end

local function Kuma()
    pcall(function()
    local plr = game.Players.LocalPlayer
    local chr = plr.Character
    local root = chr:FindFirstChild("HumanoidRootPart")
        if root then
            for i,v in ipairs(workspace.NPC.Fight:GetChildren()) do
                if v:IsA("Folder") then
                    local Kuma = v:FindFirstChild("Kuma The Tyrant")
                    if Kuma then
                        local target = Kuma:FindFirstChild("HumanoidRootPart")
                        if Kuma and not target then
                            root.CFrame = CFrame.new(-11343, 2266, 16595)
                        end
                        if target and root then
                            if _G.PawBarrage then
                                root.CFrame = target.CFrame * CFrame.new(0,60,0) * CFrame.Angles(math.rad(270), math.rad(0), math.rad(0))
                                root.Velocity = Vector3.new(0,0,0)
                            else
                                root.CFrame = target.CFrame * CFrame.new(0,5,5)
                                root.Velocity = Vector3.new(0,0,0)        
                            end
                        end
                    end
                end
            end
        end
    end)
end

local function teleport(Spot)

    game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("ServerMove"):FireServer("SpearheadRush")
    
    local root = game.Players.LocalPlayer.Character.HumanoidRootPart
    if Spot == "Shell Town (1 - 25 levels)" then
        root.CFrame = CFrame.new(-4651, 139, 669)
    end
    if Spot == "Windmill Village (1 - 35 levels)" then
        root.CFrame = CFrame.new(194, 271, -676)
    end
    if Spot == "Orange Town (35 - 60 levels)" then
        root.CFrame = CFrame.new(-2194, 68, -2629)
    end
    if Spot == "Jungle (60 - 100 levels)" then
        root.CFrame = CFrame.new(-1408, 134, 1993)
    end
    if Spot == "Baratie (100 - 150 levels)" then
        root.CFrame = CFrame.new(2178, 155, 1619)
    end
    if Spot == "Sandora (150 - 240 levels)" then
        root.CFrame = CFrame.new(-6621, 282, -4242)
    end
    if Spot == "Arlong Park (240 - 315 levels)" then
        root.CFrame = CFrame.new(-2041, 64, -6024)
    end
    if Spot == "Skypiea (315 - 600 levels)" then
        root.CFrame = CFrame.new(5574, 1329, -9452)
    end
    if Spot == "Colosseum" then
        root.CFrame = CFrame.new(5152, 158, -135)
    end
    if Spot == "Louge Town" then
        root.CFrame = CFrame.new(2302, 108, -3311)
    end
    if Spot == "Abandoned Territory" then
        root.CFrame = CFrame.new(6543, 245, -3938)
    end
    root.Anchored = true
    wait(.25)
    root.Anchored = false
end

local function Chest_Farm()
    if not _G.Farm_Seabeast then
        local list = {
            CFrame.new(-4651, 155, 669),
            CFrame.new(194, 285, -676),
            CFrame.new(-2194, 85, -2629),
            CFrame.new(-1408, 150, 1993),
            CFrame.new(2178, 170, 1619),
            CFrame.new(-6621, 295, -4242),
            CFrame.new(-2041, 80, -6024),
            CFrame.new(5574, 1345, -9452),
            CFrame.new(5152, 175, -135),
            CFrame.new(2302, 125, -3311),
            CFrame.new(3327, 2220, -11504),
            CFrame.new(6543, 245, -3938)
        }
        for i, v in ipairs(list) do
            if root and _G.Auto_Chest_Farm then
                root.CFrame = v
                root.Anchored = true
                wait(2.5)
                root.Anchored = false
                wait(.25)
                Chest()
            end
        end
    end
end

local function EquipAllAccessory()
    for i,v in ipairs(game:GetService("ReplicatedStorage").PlayerData[game.Players.LocalPlayer.UserId]:FindFirstChild("Accessories"):GetChildren()) do
        if v:IsA("BoolValue") and v.Value == true then
            local args = {
                [1] = "AccessoryEquips",
                [3] = v.Name,
                [4] = true
            }
        
            game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("ServerMove"):FireServer(unpack(args))
            wait(1.25)
        end
    end
end

local function Kuma_Idiot()
    for i,v in ipairs(workspace.NPC.Fight.Kuma:GetChildren()) do
        if v:IsA("Model") then
            local hum = v:FindFirstChild("Humanoid")
            if v.Name == "Kuma The Tyrant" and hum then
                hum.WalkSpeed = 0
                hum.HipHeight = -15
                hum.Sit = true
            end
        end
    end
end

local function Gacha()
    game:GetService("ReplicatedStorage").Remotes.ToServer.GachaR:FireServer()
end

local function Skill(Name)
    local args = {
    [1] = tostring(Name),
    [2] = 0
    }
    game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("ServerMove"):FireServer(unpack(args))
end

local function AutoBuff()
    Skill("Holy Book Please")
end

local function GetBoat()
    for i,v in ipairs(workspace.Map.Boats:GetChildren()) do
        if v:IsA("Model") and v:FindFirstChild("Vehicle_Seat") then
            return v
        end
    end
end

local function FreezeBoat(state1, state2)
    if GetBoat() then
        for i,v in ipairs(GetBoat():GetChildren()) do
            if v:IsA("MeshPart") then
                v.Anchored = state1
                v.CanCollide = state2
            end
        end
    end
end

local function Safe_Mode(percentage)
    local plr_health = (game.Players.LocalPlayer.Character.Humanoid.Health / game.Players.LocalPlayer.Character.Humanoid.MaxHealth) * 100
    if plr_health < percentage then
        _G.Safe_Mode = true
        local oldpos = root.CFrame
        root.CFrame = root.CFrame * CFrame.new(0,1500,0)
        root.Anchored = true
        root.Velocity = Vector3.new(0,0,0)
        wait(.25)
        local safe = Instance.new("Part")
        safe.Name = "Safe Place"
        safe.Size = Vector3.new(20,5,20)
        safe.Anchored = true
        safe.Parent = game.Workspace
        safe.CFrame = root.CFrame * CFrame.new(0,-50,0)
        root.Anchored = false
        for i = 10, 1, -1 do
            local scaleFactor = i / 10
            safe.Size = Vector3.new(20 * scaleFactor, 1, 20 * scaleFactor)
            wait(1)
        end
        _G.Safe_Mode = false
        safe:Destroy()
        root.CFrame = oldpos
    end
end

local function GetSeaBeast()
    for i,v in ipairs(workspace.NPC.Fight.SeaDragon:GetChildren()) do
        if v:IsA("Model") and v:FindFirstChild("Humanoid") then
            return v
        end
    end
end

local function Farm_SB()
    if not _G.Safe_Mode then
        if GetSeaBeast() and root then
            _G.Farm_Seabeast = true
            root.Velocity = Vector3.new(0,0,0)
            if not GetSeaBeast():FindFirstChild("HumanoidRootPart") then 
                root.CFrame = _G.Seabeast_Ship
            else
                root.CFrame = GetSeaBeast().HumanoidRootPart.CFrame * CFrame.new(0,10,5)
            end
        else
            if not GetSeaBeast() or GetSeaBeast().Humanoid.Health < 0 then
                _G.Farm_Seabeast = false
            end
        end
    end
end

local function Disabled_Effect()
    for i,v in ipairs(workspace.Debree:GetChildren()) do
        v:Destroy()
    end
end

local function PawBarrage()
    local args = {
        [1] = "PawBarrage",
        [3] = true,
        [4] = Vector3.new(0,0,0)
    }
    
    game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("ServerMove"):FireServer(unpack(args))
end

local function Delete_Stand_Ship()
    if game.Workspace:FindFirstChild("Stand_Ship") then
        game.Workspace:FindFirstChild("Stand_Ship"):Destroy()
    end
end

local function Stand_Ship()

    if game.Workspace:FindFirstChild("Stand_Ship") then
        game.Workspace:FindFirstChild("Stand_Ship"):Destroy()
    end
    
    local base = Instance.new("Part")
    base.Size = Vector3.new(2048, 50, 2048)
    base.Anchored = true
    base.Name = "Stand_Ship"
    base.Parent = game.Workspace
    base.CFrame = GetBoat().Vehicle_Seat.CFrame * CFrame.new(0,-53.5,0)
end

local function Spawn_Kuma()
    local button = workspace.Map["S.A.D Laboratory #127"]["S.A.D Laboratory #127"].MicroChipComputer["Meshes/pc_Cube.037"]
    if button then
        local oldpos = root.CFrame
        root.CFrame = button.CFrame
        wait(.5)
        fireproximityprompt(button.ProximityPrompt)
        root.CFrame = oldpos
    else
        root.CFrame = CFrame.new(-11252, 2069, 17398)
        root.Anchored = true
        wait(2)
        root.Anchored = false
    end
end

local function Kill_Kuma()
    local mob = workspace.NPC.Fight.Kuma:FindFirstChild("Kuma The Tyrant")
    if mob then
        local hum = mob:FindFirstChild("Humanoid") 
        if hum then
            hum.Health = nil
            hum.RigType = "R15"
            wait(1)
            hum.RigType = "R6" 
        end
    end
end

local function Farm_Boss()
    local root = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    local mobs = {
        
        {"Morgan", workspace.NPC.Fight.Shells, CFrame.new(-4904, 250, 756)}, -- Morgan - Shelltown
        {"Reiner", workspace.NPC.Fight.Reiner, CFrame.new(194, 270, -676)}, -- Bandit Leader - Windwill
        {"Buggy", workspace.NPC.Fight.Buggy, CFrame.new(-2194, 70, -2629)}, -- Buggy - Orange Town
        {"King Abu", workspace.NPC.Fight.Gorillas, CFrame.new(-1815, 53, 2332)}, -- King Abu - Jungle
        {"Sand Dragon", workspace.NPC.Fight.Dragon, CFrame.new(-7338, 342, -4530)}, -- Sand Dragon - Sandora
        {"Desert King", workspace.NPC.Fight.Croc, CFrame.new(-7338, 342, -4530)}, -- Desert King - Sandora
        {"Arlong", workspace.NPC.Fight.Fishmen, CFrame.new(-2268, 84, -6161)}, -- Arlong - Arlong Park
        {"Guard Captain", workspace.NPC.Fight.SkyNpcs, CFrame.new(6130, 1947, -8593)}, -- Guard Captain - Skypiea Island
        {"Thunder God", workspace.NPC.Fight.Enel, CFrame.new(3488, 2065, -11348)} -- Thunder God - Golden City
    }
    
    for _, mobData in ipairs(mobs) do
        local mobName, mobLocation, position = mobData[1], mobData[2], mobData[3]
        local mob = mobLocation:FindFirstChild(mobName)
        if mob and root then
            local target = mob:FindFirstChild("HumanoidRootPart")
            if target then
                _G.Farming = true
                local root = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                if root and _G.PawBarrage and _G.Farming then
                    root.CFrame = target.CFrame * CFrame.new(0, 45, 0) * CFrame.Angles(math.rad(270), math.rad(0), math.rad(0))
                else
                    root.CFrame = target.CFrame * CFrame.new(0, 0, 5)
                end
                else
                    root.CFrame = position
            end
            else
            _G.Farming = false
        end
    end
end

local function Auto_Haki()
    local vim = game:GetService('VirtualInputManager')
    if not game.Players.LocalPlayer.Character:FindFirstChild("Armament") then
        game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("ServerMove"):FireServer("Armament",0,true)
    end
    if not game.Players.LocalPlayer.Character:FindFirstChild("KenHaki") then
        vim:SendKeyEvent(false, Enum.KeyCode.T, false, nil)
    end
end

local function Check_Level()
    return game:GetService("ReplicatedStorage").PlayerData[game.Players.LocalPlayer.UserId].Level.Value
end

local function CheckQuest()
    local playerGui = game.Players.LocalPlayer.PlayerGui
    if playerGui:FindFirstChild("Quests") then
        return playerGui.Quests.Enabled
    end
    return false
end

local function GetQuest(NPC)
    local args = {
        [1] = NPC
    }
    game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("ToServer"):WaitForChild("Quest"):FireServer(unpack(args))
end

local function Level_Farm()
    local root = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if not root then
        return
    end

    local mobs = {
        {"Bandit", workspace.NPC.Fight:FindFirstChild("Bandits"), CFrame.new(232, 100, -1110), workspace.NPC.Talk.Woppa, 1, 14}, -- Level 15
        {"Reiner's Subordinate", workspace.NPC.Fight:FindFirstChild("Reiner"), CFrame.new(80, 210, -760), workspace.NPC.Talk.Boss, 15, 34}, -- Level 30
        {"Orange Pirate", workspace.NPC.Fight:FindFirstChild("Buggy"), CFrame.new(-2071, 58, -2485), workspace.NPC.Talk.Unrio, 35, 59}, 
        {"Monkey", workspace.NPC.Fight:FindFirstChild("Gorillas"), CFrame.new(-1210, 90, 2037), workspace.NPC.Talk.Zet, 60, 99}, -- Level 60
        {"Angry Chef", workspace.NPC.Fight:FindFirstChild("Baratie"), CFrame.new(2018, 64, 1619), workspace.NPC.Talk.Dyna, 100, 124}, -- Level 100
        {"Krieg Pirate", workspace.NPC.Fight:FindFirstChild("Baratie"), CFrame.new(2022, 64, 1626), workspace.NPC.Talk.Viz, 125, 149}, -- Level 125
        {"Sand Pirate", workspace.NPC.Fight:FindFirstChild("Sandora"), CFrame.new(-6531, 116, -4571), workspace.NPC.Talk.Cellierin, 150, 174}, -- Level 150
        {"Desert Brigand", workspace.NPC.Fight:FindFirstChild("Sandora"), CFrame.new(-6531, 116, -4571), workspace.NPC.Talk.Wise, 175, 249}, -- Level 175
        {"Fishman", workspace.NPC.Fight:FindFirstChild("Fishmen"), CFrame.new(-1674, 73, -6263), workspace.NPC.Talk.Bope, 250, 264}, -- Level 250
        {"Graverobber", workspace.NPC.Fight:FindFirstChild("Fishmen"), CFrame.new(-1674, 73, -6263), workspace.NPC.Talk.Zeno, 265, 314}, -- Level 265
        {"Sky Soldier", workspace.NPC.Fight:FindFirstChild("SkyNpcs"), CFrame.new(4464, 762, -8351), workspace.NPC.Talk.Ima, 315, 364}, -- Level 315
        {"Divine Guardian", workspace.NPC.Fight:FindFirstChild("SkyNpcs"), CFrame.new(5132, 1235, -9164), workspace.NPC.Talk.Sofen, 365, 9999} -- Level 315

    }

    for _, mobData in ipairs(mobs) do
        local mobName, mobLocation, position, NPC_Quest, level_quest, next_quest_level = unpack(mobData)
        if Check_Level() >= level_quest and Check_Level() <= next_quest_level then
            if mobLocation then
                local mob = mobLocation:FindFirstChild(tostring(mobName))
                if mob then
                    Auto_Haki()
                    local target = mob:FindFirstChild("HumanoidRootPart")
                    if target then
                        if CheckQuest() then
                            if _G.PawBarrage then
                                root.CFrame = target.CFrame * CFrame.new(0, 45, 0) * CFrame.Angles(math.rad(270), math.rad(0), math.rad(0))
                            else
                                Combat()
                                root.CFrame = target.CFrame * CFrame.new(0, 0, 5)
                            end
                        else
                            if not NPC_Quest:FindFirstChild("HumanoidRootPart") then
                                root.CFrame = position
                            else
                                root.CFrame = NPC_Quest:FindFirstChild("HumanoidRootPart").CFrame
                                GetQuest(NPC_Quest:FindFirstChild("Info"))
                            end
                        end
                    else
                        root.CFrame = position
                    end
                else
                    root.CFrame = position
                end
            else
                root.CFrame = position
            end
        end
    end
end

local function Check_Boss()
    local Boss_List = {"Morgan", "Reiner", "Buggy", "King Abu", "Sand Dragon", "Desert King", "Arlong", "Guard Captain", "Thunder God"}
    for _,v in ipairs(Workspace.NPC.Fight:GetDescendants()) do
        if v:IsA("Model") and v:FindFirstChild("Humanoid") then
            for _,bossName in ipairs(Boss_List) do
                if v.Name == bossName then
                    return v
                end
            end
        end
    end
end

local function HandleBoss(boss)
local boss = Check_Boss()
    if boss then
        _G.Found = true
        local root = Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if root then
            Combat()
            root.CFrame = boss.HumanoidRootPart.CFrame * CFrame.new(0, 0.25, 5)
        end
    else
        _G.Found = false
    end
end

local function MovePlayer()
    local positions = {
        CFrame.new(-4698, 91, 979),
        CFrame.new(194, 270, -676),
        CFrame.new(-1815, 53, 2332),
        CFrame.new(-7338, 342, -4530),
        CFrame.new(-7338, 342, -4530),
        CFrame.new(-2268, 84, -6161),
        CFrame.new(6130, 1947, -8593),
        CFrame.new(3488, 2065, -11348)
    }

    for _, position in ipairs(positions) do
        if _G.Boss_Farm then
            local boss = Check_Boss()
            if boss then
                HandleBoss(boss)
            else
                local root = Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                if root then
                    wait(15)
                    root.CFrame = position
                end
            end
        end
    end
end

-- // Loadstring \\ --
local library = loadstring(game:HttpGet('https://raw.githubusercontent.com/cueshut/saves/main/criminality%20paste%20ui%20library'))()

-- // Window \\ --
local window = library.new('Syn0xz Hub', 'Syn0xz')

-- // Tabs \\ --
local tab = window.new_tab('rbxassetid://4483345998')

-- // Sections \\ --
local section = tab.new_section('- Main -')
local section2 = tab.new_section('- Misc -')
local section3 = tab.new_section('- Kaitan -')


-- // Sector 1 \\ --

local Farm = section.new_sector('= Farm =', 'Left')
local Raid = section.new_sector('= Raid Boss =', 'Right')
local Seabeast = section.new_sector('= Sea beast =', 'Left')
local Accessory = section.new_sector('= Accessory =', 'Right')


-- // Sector 2 \\ --

local Misc = section2.new_sector('= Misc =', 'Left')
local TP = section2.new_sector('= Teleport =', 'Right')
local Style = section2.new_sector('= Fighting Style =', 'Left')


-- // Sector 3 \\ --

local Level = section3.new_sector('= Farm =', 'Left')
local Boss = section3.new_sector('= Boss Farm =', 'Right')



local Combat = Farm.element('Toggle', 'Combat Hit', false, function(v)
    _G.Combat = v.Toggle
    while _G.Combat do task.wait()
        Combat()
    end
end)

local Sword = Farm.element('Toggle', 'Sword Hit', false, function(v)
    _G.Sword = v.Toggle
    while _G.Sword do task.wait()
        Sword()
    end
end) 


local Electro = Style.element('Button', 'Electro (200K Beli)', false, function()
    game:GetService("ReplicatedStorage").Remotes.ToServer.Quest:FireServer(game:GetService("Workspace").NPC.Talk.Carrot.Info)
end) 

local BlackLeg = Style.element('Button', 'Black Leg (150K Beli)', false, function()
    game:GetService("ReplicatedStorage").Remotes.ToServer.Quest:FireServer(game:GetService("Workspace").NPC.Talk.Sanji.Info)
end) 

local Combat = Style.element('Button', 'Combat (1K Beli)', false, function()
    game:GetService("ReplicatedStorage").Remotes.ToServer.Quest:FireServer(game:GetService("Workspace").NPC.Talk.Khabib.Info)
end) 

local TP1 = TP.element('Button', 'Shell Town (1 - 25 levels)', false, function()
    teleport('Shell Town (1 - 25 levels)')
end) 

local TP2 = TP.element('Button', 'Windmill Village (1 - 35 levels)', false, function()
    teleport('Windmill Village (1 - 35 levels)')
end) 

local TP3 = TP.element('Button', 'Orange Town (35 - 60 levels)', false, function()
    teleport('Orange Town (35 - 60 levels)')
end) 

local TP4 = TP.element('Button', 'Jungle (60 - 100 levels)', false, function()
    teleport('Jungle (60 - 100 levels)')
end) 

local TP5 = TP.element('Button', 'Baratie (100 - 150 levels)', false, function()
    teleport('Baratie (100 - 150 levels)')
end) 

local TP6 = TP.element('Button', 'Sandora (150 - 240 levels)', false, function()
    teleport('Sandora (150 - 240 levels)')
end) 

local TP7 = TP.element('Button', 'Arlong Park (240 - 315 levels)', false, function()
    teleport('Arlong Park (240 - 315 levels)')
end) 

local TP8 = TP.element('Button', 'Skypiea (315 - 600 levels)', false, function()
    teleport('Skypiea (315 - 600 levels)')
end) 

local TP9 = TP.element('Button', 'Colosseum', false, function()
    teleport('Colosseum')
end) 

local TP10 = TP.element('Button', 'Louge Town', false, function()
    teleport('Louge Town')
end) 

local TP11 = TP.element('Button', 'Abandoned Territory', false, function()
    teleport('Abandoned Territory')
end) 

local Boss_Farm = Boss.element('Toggle', 'Boss Farm', false, function(v)
    _G.Boss_Farm = v.Toggle
    while _G.Boss_Farm do task.wait()
        MovePlayer()
    end
end)

local Level = Level.element('Toggle', 'Level Farm', false, function(v)
    _G.Level_Farm = v.Toggle
    while _G.Level_Farm do task.wait()
        Level_Farm()
    end
end) 

local Gacha = Misc.element('Toggle', 'Gacha', false, function(v)
    _G.Gacha = v.Toggle
    while _G.Gacha do task.wait()
        Gacha()
        wait(300)
    end
end) 

local AutoBuff = Misc.element('Toggle', 'Auto Buff', false, function(v)
    _G.AutoBuff = v.Toggle
    while _G.AutoBuff do task.wait()
        AutoBuff()
        wait(30)
    end
end) 

local AutoHaki = Misc.element('Toggle', 'Auto Haki', false, function(v)
    _G.AutoHaki = v.Toggle
    while _G.AutoHaki do task.wait()
        Auto_Haki()
    end
end) 

local FreezeBoat = Seabeast.element('Toggle', 'Freeze Boat', false, function(v)
    _G.FreezeBoat = v.Toggle
    while _G.FreezeBoat do task.wait()
        if _G.FreezeBoat then
            FreezeBoat(true,false)
        else
            FreezeBoat(false,true)
        end
    end
end) 

local Auto_Chest = Farm.element('Toggle', 'Auto Chest Farm', false, function(v)
    _G.Auto_Chest_Farm = v.Toggle
    while _G.Auto_Chest_Farm do task.wait()
        Chest_Farm()
    end
end) 

local Boss_Farm = Farm.element('Toggle', 'Auto Boss Farm', false, function(v)
    _G.Boss_Farm = v.Toggle
    while _G.Boss_Farm do task.wait()
        Farm_Boss()
    end
end) 

local Paw_Barrage = Misc.element('Toggle', 'Spam Paw Barrage (Paw Fruit)', false, function(v)
    _G.PawBarrage = v.Toggle
    while _G.PawBarrage do task.wait()
        PawBarrage()
    end
end) 

local Kuma_Farm = Raid.element('Toggle', 'Kuma Farm', false, function(v)
    _G.Kuma_Farm = v.Toggle
    while _G.Kuma_Farm do task.wait()
        Kuma()
    end
end) 

local Kuma_Idiot = Raid.element('Toggle', 'Kuma Idiot', false, function(v)
    _G.Kuma_Idiot = v.Toggle
    while _G.Kuma_Idiot do task.wait()
        Kuma_Idiot()
    end
end) 

local Disabled_Effect = Misc.element('Toggle', 'Disabled Effect', false, function(v)
    _G.Disabled_Effect = v.Toggle
    while _G.Disabled_Effect do task.wait()
        Disabled_Effect()
    end
end) 

local EquipAllAccessory = Accessory.element('Button', 'Equip All Accessory', false, function()
    EquipAllAccessory()
end) 

local Farm_SB = Seabeast.element('Toggle', 'Auto Farm Sea Beast', false, function(v)
    _G.Farm_SB = v.Toggle
    while _G.Farm_SB do task.wait()
        Farm_SB()
    end
end) 

local Slider_SafeMode = Seabeast.element('Slider', 'Health%', {default = {min = 1, max = 101, default = 50}}, function(v)
    _G.Health = v.Slider
end)

local SafeMode = Seabeast.element('Toggle', 'Safe Mode', false, function(v)
    _G.SafeMode = v.Toggle
    while _G.SafeMode do task.wait()
        Safe_Mode(_G.Health)
    end
end) 

local UnSet = Seabeast.element('Button', 'Delete Seabeast Ship', false, function()
    Delete_Stand_Ship()
end) 

local Set = Seabeast.element('Button', 'Set Seabeast Ship', false, function()
    Stand_Ship()
end) 

local Load = Seabeast.element('Button', 'Check Seabeast Ship', false, function()
    if game.Workspace:FindFirstChild("Stand_Ship") then
        root.CFrame = game.Workspace:FindFirstChild("Stand_Ship").CFrame * CFrame.new(0,40,0)
    else
        notify("Seabeast Ship","Not Found")
    end
end) 

local Spawn_Kuma = Raid.element('Button', 'Spawn Kuma', false, function()
    Spawn_Kuma()
end) 

local Kill_Kuma = Raid.element('Button', 'Kill Kuma', false, function()
    Kill_Kuma()
end)
