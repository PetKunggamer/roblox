local A = game:GetService("CoreGui")
local afk = game:GetService("CoreGui"):FindFirstChild("thisoneissocoldww")

if A then
    for i,v in ipairs(A:GetChildren()) do
        if v.Name:find("unknown") then
            v:Destroy()
        end
    end
end

if afk then
    afk:Destroy()
end

--[[

    ███████╗██╗░░░██╗███╗░░██╗░█████╗░████████╗██╗░█████╗░███╗░░██╗
    ██╔════╝██║░░░██║████╗░██║██╔══██╗╚══██╔══╝██║██╔══██╗████╗░██║
    █████╗░░██║░░░██║██╔██╗██║██║░░╚═╝░░░██║░░░██║██║░░██║██╔██╗██║
    ██╔══╝░░██║░░░██║██║╚████║██║░░██╗░░░██║░░░██║██║░░██║██║╚████║
    ██║░░░░░╚██████╔╝██║░╚███║╚█████╔╝░░░██║░░░██║╚█████╔╝██║░╚███║
    ╚═╝░░░░░░╚═════╝░╚═╝░░╚══╝░╚════╝░░░░╚═╝░░░╚═╝░╚════╝░╚═╝░░╚══╝

]]--

local lp = game.Players.LocalPlayer
local char = lp.Character or lp.CharacterAdded:Wait()
local root = char:WaitForChild("HumanoidRootPart")
local RS = game:GetService("ReplicatedStorage")
local VIM = game:GetService("VirtualInputManager")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local function Notify(text)
    game:GetService("StarterGui"):SetCore("SendNotification",{
    Title = 'Syn0xz Hub',
    Text = text, 
    Duration = 3
    })
end

local function AFK()
    local Afk = game:service'VirtualUser'
    game:service'Players'.LocalPlayer.Idled:connect(function()
    	Afk:CaptureController()
    	Afk:ClickButton2(Vector2.new())
    end)
    Notify('Anti afk loaded')
end

local function low_fps(num)
    if iswindowactive() then
        setfpscap(144) 
    else 
        setfpscap(num) 
    end
end

-- Function below

local function BypassTP()
    local ColosseumEntrance = workspace.InvisibleParts.ColosseumEntrance
    local root = game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if root then
        local oldpos = root.CFrame
        fireproximityprompt(ColosseumEntrance.InteractPrompt)
        wait(.25)
        root.CFrame = oldpos
    end
end

local function TO_CFrame(CFrame)
    local root = game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    BypassTP()
    wait(.125)
    if root then
        root.CFrame = CFrame
    end
end

local function GetMob()
    local lp = game.Players.LocalPlayer
    local char = lp.Character or lp.CharacterAdded:Wait()
    local root = char:WaitForChild("HumanoidRootPart")
    local mob = {}
    for i, v in ipairs(workspace.Alive:GetChildren()) do
        if v:IsA("Model") and v.Name ~= char.Name then
            local target = v:FindFirstChild("HumanoidRootPart")
            local master = v:FindFirstChild("Master")
            if target and root and not master then
                local mag = (target.Position - root.Position).Magnitude
                if mag < 100 then
                    table.insert(mob, v)
                end
            end
        end
    end
    return mob
end

local function Put()
    local mobList = GetMob()
    for i, v in ipairs(mobList) do
        local root = v:FindFirstChild("HumanoidRootPart")
        local hum = v:FindFirstChild("Humanoid")
        if root and hum then
            local ESP = root:FindFirstChild("ESP")
            if not ESP then
                local billboard = Instance.new("BillboardGui")
                billboard.Name = "ESP"
                billboard.Adornee = root
                billboard.Size = UDim2.new(2, 0, 2, 0)
                billboard.StudsOffset = Vector3.new(0, 3, 0)
                billboard.AlwaysOnTop = true

                local Health_Mob = Instance.new("TextLabel")
                Health_Mob.Size = UDim2.new(1, 0, 1, 0)
                Health_Mob.BackgroundTransparency = 1
                Health_Mob.TextColor3 = Color3.fromRGB(255, 0, 0) -- Red text
                Health_Mob.TextScaled = true
                Health_Mob.Name = "Health_Mob"
                Health_Mob.Font = Enum.Font.SourceSansBold


                local Posture_Mob = Instance.new("TextLabel")
                Posture_Mob.Size = UDim2.new(1, 0, 1, 0)
                Posture_Mob.Position = UDim2.new(0, 0, .6, 0)
                Posture_Mob.BackgroundTransparency = 1
                Posture_Mob.TextColor3 = Color3.new(0.941176, 1.000000, 0.117647) -- Red text
                Posture_Mob.TextScaled = true
                Posture_Mob.Name = "Posture_Mob"
                Posture_Mob.Font = Enum.Font.SourceSansBold

                Health_Mob.Parent = billboard
                Posture_Mob.Parent = billboard
                billboard.Parent = root
            end
        end
    end
end

local function UpdateESP()
    local lp = game.Players.LocalPlayer
    local char = lp.Character or lp.CharacterAdded:Wait()
    local root = char:WaitForChild("HumanoidRootPart")
    for i,v in ipairs(workspace.Alive:GetChildren()) do
        local hum = v:FindFirstChild("Humanoid")
        local rootPart = v:FindFirstChild("HumanoidRootPart")
        local Boolvalue = v:FindFirstChild("BoolValues")
        if hum and rootPart and Boolvalue then
            local ESP = rootPart:FindFirstChild("ESP")
            local Posture = Boolvalue:FindFirstChild("Posture")
            local distance = (root.Position - rootPart.Position).Magnitude
            local Posture_Percent = (Posture.Value / Posture.MaxValue) * 100
            
            -- If ESP exists and mob is out of range, remove it
            if ESP and distance > 100 then
                ESP:Destroy()
            elseif ESP then
                ESP.Health_Mob.Text = math.floor(hum.Health) -- Update health
                ESP.Posture_Mob.Text = math.floor(Posture_Percent).."%"
            end
        end
    end
end

local function Void(part)
    if not part:FindFirstChild("Void") then
        local void = Instance.new("BodyPosition")
        void.MaxForce = Vector3.new(0,1e9,0)
        void.Position = Vector3.new(0,-10000,0)
        void.Name = "Void"
        void.Parent = part
    end
end

local function Instant()
    local lp = game.Players.LocalPlayer
    local char = lp.Character or lp.CharacterAdded:Wait()
    local root = char:FindFirstChild("HumanoidRootPart")
    for i,v in ipairs(workspace.Alive:GetChildren()) do
        if v:IsA("Model") then
            -- v.Name:find("Drogar.") or v.Name:find("Lycanthar.")
            if v.Name ~= char.Name then
                local target = v:FindFirstChild("HumanoidRootPart")
                local hum = v:FindFirstChild("Humanoid")
                local master = v:FindFirstChild("Master")
                if target and root and hum and ((hum.Health / hum.MaxHealth) * 100) < 90 and not master then
                    local mag = (root.Position - target.Position).magnitude
                    if mag < 100 then
                        --if isnetworkowner(target) then
                            hum.Health = -math.huge
                            --Void(target)
                        -- end
                    end
                end
            end
        end
    end
end

local function No_Stun()
    local lp = game.Players.LocalPlayer
    local char = lp.Character or lp.CharacterAdded:Wait()
    local blacklist = 
    {'CantRoll','IsRolling','CantRun','ActionSignal','CanFeint','M1CoolDown','Swinging',
    'UsingAbility','ParrySignal','SetRagdoll','RollCD','Stun','FeintCD','Ragdolled','StopAutoRotate',
    'FootPrintCD','','RagDolled','CheckingDebris','RunningAttackCD',
    'ChargingAttack','CustomShiftLock','SkillActivated','Sliding','TeleportCD'
    }
    for i,v in ipairs(char:GetChildren()) do
        if table.find(blacklist, v.Name) then
            v:Destroy()
        end
    end
end

local function Get_Bed()
    local bed, part = nil
    for i,v in ipairs(workspace.Map:GetChildren()) do
        if v:IsA("Model") then
            if v.Name == "Bed" then
                local prompt = v:FindFirstChild("InteractPrompt")
                local SleepPart = v:FindFirstChild("SleepPart")
                if prompt and SleepPart then
                    bed = prompt
                    part = SleepPart
                end
            end
        end
    end
    return bed, part
end

local function Sleep()
    local bed, part = Get_Bed()
    if bed and part then
        local oldpos = root.CFrame
        TO_CFrame(part.CFrame)
        fireproximityprompt(bed)
        wait(.5)
        root.CFrame = oldpos
    end
end

local function Interact(name)
    local npc = workspace.Effects.NPCS:FindFirstChild(name)
    local prompt = npc:FindFirstChild("InteractPrompt")
    if prompt then
        fireproximityprompt(prompt)
    end
end

local function Remote(args)
    local Network = require(game:GetService("ReplicatedStorage").Modules.Network)
    Network.connect('MasterEvent', 'FireServer', game.Players.LocalPlayer.Character, {
        Config = args
    })
end

local function Dialogue(msg)
    local lp = game.Players.LocalPlayer
    local char = lp.Character or lp.CharacterAdded:Wait()
    if char then
        char:WaitForChild("CharacterHandler").Input.Events.DialogueEvent:FireServer(msg)
    end
end

local function Get_Boss()
    local lp = game.Players.LocalPlayer
    local char = lp.Character or lp.CharacterAdded:Wait()
    local root = char:WaitForChild("HumanoidRootPart")
    local mob = nil
    for i,v in ipairs(workspace.Alive:GetChildren()) do
        if v:IsA("Model") then
            if v.Name:find("Drogar.") or v.Name:find("Lycanthar.") and v.Name ~= char.Name then
                local target = v:FindFirstChild("HumanoidRootPart")
                if target and root then
                    mob = v
                end
            end
        end
    end
    return mob
end

local function Equip()
    local lp = game.Players.LocalPlayer
    local char = lp.Character or lp.CharacterAdded:Wait()
    if char then
        local sword = char:FindFirstChild("sword")
        if not sword then
            Remote('EquipWeapon')
        end
    end
end


local function Respawn()
    local GuiService = game:GetService('GuiService')
    local VirtualInputManager = game:GetService('VirtualInputManager')
    for i,v in ipairs(game:GetService("Players").LocalPlayer.PlayerGui.InfoOverlays:GetChildren()) do
        if v:IsA("ImageLabel") then
            local MF = v:FindFirstChild("MainFrame")
            if MF then
                local BF = MF:FindFirstChild("ButtonFrame")
                if BF then
                    local Confirm = BF:FindFirstChild("ConfirmButton")
                    if Confirm then
                        task.wait(.125)
                        GuiService.SelectedCoreObject = Confirm
                        VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.Return, false, game)
                        VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.Return, false, game)
                    end
                end
            end
        end
    end
end

function GetPlayer(distanceLimit)
    local aliveFolder = workspace:FindFirstChild("Alive")
    local localPlayer = game.Players.LocalPlayer
    local character = localPlayer and localPlayer.Character

    if character and aliveFolder then
        local myPosition = character:GetPrimaryPartCFrame().Position

        for _, obj in pairs(aliveFolder:GetChildren()) do
            local player = game.Players:GetPlayerFromCharacter(obj)
            if player and player ~= localPlayer then
                local char = player.Character
                if char and char.PrimaryPart then
                    local distance = (char.PrimaryPart.Position - myPosition).Magnitude
                    if distance <= distanceLimit then
                        return true -- Found a player within the distance
                    end
                end
            end
        end
    end
    return false -- No player found within the distance
end

local function Check_Weight()
    local lp = game.Players.LocalPlayer
    local char = lp.Character or lp.CharacterAdded:Wait()
    if char then
        local BoolValues = char:FindFirstChild("BoolValues")
        if BoolValues then
            local Weight = BoolValues:FindFirstChild("Weight")
            local MaxWeight = BoolValues:FindFirstChild("MaxWeight")
            if Weight and MaxWeight then
                if Weight.Value >= (MaxWeight.Value-5) then
                    return true
                end
            end
        end
    end
    return false
end

local function AutoBoss(msg)
    local lp = game.Players.LocalPlayer
    local char = lp.Character or lp.CharacterAdded:Wait()
    local root = char:WaitForChild("HumanoidRootPart")
    local hum = char:WaitForChild("Humanoid")
    if not GetPlayer(400) then
        if not Check_Weight() then 
            if root then
                local boss = Get_Boss()
                if boss then
                    local target = boss:FindFirstChild("HumanoidRootPart")
                    if target then
                        Equip()
                        root.CFrame = target.CFrame * CFrame.new(0,5,8)
                        root.Velocity = Vector3.zero
                        Remote("Button1Down")
                        task.wait(.01)
                    end
                else
                    task.wait(0.1)
                    TO_CFrame(CFrame.new(937, -217, 1683))
                    Interact("Drakonar") task.wait(0.01)
                    Dialogue(msg)
                end
                if hum.Health == 0 then
                    Respawn()
                    wait(2.5)
                end
            end
        end
    else
        root.CFrame = root.CFrame * CFrame.new(0,-100,0)
        task.wait(.1)
        hum.Health = 0
        _G.Drogar = false
        _G.Lycan = false
    end
end


--[[

    ██╗░░░██╗██╗      ███████╗░█████╗░███╗░░██╗███████╗
    ██║░░░██║██║      ╚════██║██╔══██╗████╗░██║██╔════╝
    ██║░░░██║██║      ░░███╔═╝██║░░██║██╔██╗██║█████╗░░
    ██║░░░██║██║      ██╔══╝░░██║░░██║██║╚████║██╔══╝░░
    ╚██████╔╝██║      ███████╗╚█████╔╝██║░╚███║███████╗
    ░╚═════╝░╚═╝      ╚══════╝░╚════╝░╚═╝░░╚══╝╚══════╝

]]--

Notify('Function Loaded')
Notify('Loading Hub...')

local library = loadstring(game:HttpGet('https://raw.githubusercontent.com/cueshut/saves/main/criminality%20paste%20ui%20library'))()

-- // Window \\ --
local window = library.new('Syn0xz Hub', 'Syn0xz')

-- // Tabs \\ --
local tab = window.new_tab('rbxassetid://4483345998')

-- // Sections \\ --
local section = tab.new_section('- Main -')


-- // Sector \\ --
local Farm = section.new_sector('Farming', 'Left')
local Misc = section.new_sector('Misc', 'Left')
local TP = section.new_sector('Teleport', 'Right')





--[[

    ███████╗██╗░░░░░███████╗███╗░░░███╗███████╗███╗░░██╗████████╗
    ██╔════╝██║░░░░░██╔════╝████╗░████║██╔════╝████╗░██║╚══██╔══╝
    █████╗░░██║░░░░░█████╗░░██╔████╔██║█████╗░░██╔██╗██║░░░██║░░░
    ██╔══╝░░██║░░░░░██╔══╝░░██║╚██╔╝██║██╔══╝░░██║╚████║░░░██║░░░
    ███████╗███████╗███████╗██║░╚═╝░██║███████╗██║░╚███║░░░██║░░░
    ╚══════╝╚══════╝╚══════╝╚═╝░░░░░╚═╝╚══════╝╚═╝░░╚══╝░░░╚═╝░░░
]]--


--[[

    ███████╗░█████╗░██████╗░███╗░░░███╗
    ██╔════╝██╔══██╗██╔══██╗████╗░████║
    █████╗░░███████║██████╔╝██╔████╔██║
    ██╔══╝░░██╔══██║██╔══██╗██║╚██╔╝██║
    ██║░░░░░██║░░██║██║░░██║██║░╚═╝░██║
    ╚═╝░░░░░╚═╝░░╚═╝╚═╝░░╚═╝╚═╝░░░░░╚═╝
]]--


local Lycan = Farm.element('Toggle', 'Auto BOSS (Lycan)', false, function(v)
    _G.Lycan = v.Toggle
    while _G.Lycan do task.wait()
        AutoBoss("Challenge The Champion Of The Colosseum, Lycanthar.")
    end
end)

local Boss = Farm.element('Toggle', 'Auto BOSS (Drogar)', false, function(v)
    _G.Drogar = v.Toggle
    while _G.Drogar do task.wait()
        AutoBoss("Challenge The Demon Claw, Drogar.")
    end
end)

local Respawn = Farm.element('Toggle', 'Auto Respawn', false, function(v)
    _G.Respawn = v.Toggle
    while _G.Respawn do task.wait(1)
        Respawn()
    end
end)

local BypassTP = Misc.element('Button', 'Bypass TP', false, function()
    BypassTP()
end)

local BypassTP = Misc.element('Button', 'Sleep', false, function()
    Sleep()
end)

local God_Mode = Misc.element('Toggle', 'God Mode', false, function(v)
    _G.God_Mode = v.Toggle
    while _G.God_Mode do task.wait(0.01)
        Remote("Roll")
    end
end)

local Instant = Misc.element('Toggle', 'Instant Kill', false, function(v)
    _G.Instant = v.Toggle
    while _G.Instant do task.wait(0.01)
        Instant()
    end
end)

local No_Stun = Misc.element('Toggle', 'No Stun', false, function(v)
    _G.No_Stun = v.Toggle
    while _G.No_Stun do task.wait(0.01)
        No_Stun()
    end
end)

local Health = Misc.element('Toggle', 'Show Health', false, function(v)
    _G.ESP = v.Toggle
    while _G.ESP do task.wait(0.01)
        Put()
        UpdateESP()
    end
end)

local Bahlgar = TP.element('Button', 'Bahlgar', false, function()
    TO_CFrame(CFrame.new(-899, 260, -1007))
end) 

local Wildness = TP.element('Button', 'Wildness', false, function()
    TO_CFrame(CFrame.new(622, 241, 526))
end) 

local Wildness = TP.element('Button', 'Ashenshire', false, function()
    TO_CFrame(CFrame.new(1059, 278, -1150))
end) 

local Wildness = TP.element('Button', 'Colosseum', false, function()
    TO_CFrame(CFrame.new(912, -197, 1693))
end) 

local Wildness = TP.element('Button', 'Spider Cave', false, function()
    TO_CFrame(CFrame.new(2043, -434, -335))
end) 


Notify('Hub is loaded')
AFK()
