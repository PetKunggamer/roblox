repeat wait() until game:IsLoaded()

local A = game:GetService("CoreGui"):FindFirstChild("unknown")
if A then
    A:Destroy()
end
    
local plr = game.Players.LocalPlayer
local chr = plr.Character
local root = chr.HumanoidRootPart

local function notify(Titles,message)
    game:GetService("StarterGui"):SetCore("SendNotification",{
    	Title = tostring(Titles), -- Required
    	Text = tostring(message), -- Required
    	Icon = "rbxassetid://1234567890" -- Optional
    })
end

local function Combat()
    local args = {
        [1] = "Combat",
        [2] = 0.275,
        [3] = "left",
        [4] = 0.275,
        [5] = "Electro"
    }
    
    game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("ServerMove"):FireServer(unpack(args))
end

local function Sword()
    local args = {
        [1] = "SwordCombat",
        [2] = 0.4,
        [3] = "three",
        [4] = 0.4,
        [5] = game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Tool")
    }
    
    game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("ServerMove"):FireServer(unpack(args))
end

local function HolyBook()
    local args = {
        [1] = "SwordCombat",
        [2] = 0.283,
        [3] = "two",
        [4] = 0.283,
        [5] = game:GetService("Players").LocalPlayer.Character:FindFirstChild("Holy BookM")
    }
    
    game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("ServerMove"):FireServer(unpack(args))    
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

local function teleport(Spot)
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

local function Rm_Accessory()
    for i,v in ipairs(game.Players.LocalPlayer.Character:GetChildren()) do
        if v:IsA("Model") and v.Name:find("M") then
            v:Destroy()
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
            local scaleFactor = i / 10 -- Scale factor (0.1 to 1)
            safe.Size = Vector3.new(20 * scaleFactor, 1, 20 * scaleFactor)
            wait(1) -- Optional: Add a delay between each count
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

-- // Loadstring \\ --
local library = loadstring(game:HttpGet('https://raw.githubusercontent.com/cueshut/saves/main/criminality%20paste%20ui%20library'))()

-- // Window \\ --
local window = library.new('Syn0xz Hub', 'Syn0xz')

-- // Tabs \\ --
local tab = window.new_tab('rbxassetid://4483345998')

-- // Sections \\ --
local section = tab.new_section('- Main -')


-- // Sector \\ --

local Farm = section.new_sector('= Farm =', 'Left')
local TP = section.new_sector('= Teleport =', 'Right')
local Misc = section.new_sector('= Misc =', 'Right')
local Accessory = section.new_sector('= Accessory =', 'Right')
local Seabeast = section.new_sector('= Sea beast =', 'Left')


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

local HolyBook = Farm.element('Toggle', 'HolyBook Hit', false, function(v)
    _G.HolyBook = v.Toggle
    while _G.HolyBook do task.wait()
        HolyBook()
    end
end) 


local dropdown = TP.element('Dropdown', 'Select to teleport', {options = {'Shell Town (1 - 25 levels)','Windmill Village (1 - 35 levels)', 'Orange Town (35 - 60 levels)', 'Jungle (60 - 100 levels)', 'Baratie (100 - 150 levels)','Sandora (150 - 240 levels)','Arlong Park (240 - 315 levels)','Skypiea (315 - 600 levels)','Colosseum','Louge Town','Abandoned Territory'}}, function(v)
    teleport(v.Dropdown)
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

local FreezeBoat = Misc.element('Toggle', 'Freeze Boat', false, function(v)
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

local Paw_Barrage = Farm.element('Toggle', 'Spam Paw Barrage (Paw Fruit)', false, function(v)
    _G.PawBarrage = v.Toggle
    while _G.PawBarrage do task.wait()
        PawBarrage()
    end
end) 

local Kuma_Idiot = Misc.element('Toggle', 'Kuma Idiot', false, function(v)
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

local Rm_Accessory = Accessory.element('Toggle', 'Remove Accessory', false, function(v)
    _G.Rm_Accessory = v.Toggle
    while _G.Rm_Accessory do task.wait()
        Rm_Accessory()
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
