local A = game:GetService("CoreGui"):FindFirstChild("unknown")
local afk = game:GetService("CoreGui"):FindFirstChild("thisoneissocoldww")

if A then
    A:Destroy()
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
local char = lp.Character
local root = char:FindFirstChild("HumanoidRootPart")
local RS = game:GetService("ReplicatedStorage")
local S_S = RS:WaitForChild("Remotes"):WaitForChild("Server"):WaitForChild("Server")
local VirtualInputManager = game:GetService("VirtualInputManager")

local function Notify(text, dura)
    game:GetService("StarterGui"):SetCore("SendNotification",{
    Title = 'Syn0xz Hub',
    Text = text, 
    Duration = dura or 5
    })
end

local function AFK()
    Notify( 'Anti afk loaded', 2)
    loadstring(game:HttpGet("https://raw.githubusercontent.com/evxncodes/mainroblox/main/anti-afk", true))()
end

local function low_fps(num)
    if iswindowactive() then
        setfpscap(1000) 
    else 
        setfpscap(num) 
    end
end


local function Get_Glasses()
    local Visuals = workspace.World.Visuals:GetChildren()
    for i,v in ipairs(Visuals) do
        if v:IsA("MeshPart") then
            local Proximity = v:FindFirstChild("ProximityPrompt")
            if Proximity then
                fireproximityprompt(Proximity)
            end
        end
    end
end

local function Arai()
    S_S:FireServer("Quest","Arai")
    wait(.65)
    Get_Glasses()
    VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.E, false, game) wait()
    VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.E, false, game)
end

local function Auto_Attack()
    S_S:FireServer("Swing",1,"Fist")
end

local function Skill(Skill)
    local args = {
        [1] = tostring(Skill),
        [2] = "Shoot"
    }

    S_S:FireServer(unpack(args))
end

local function Get_Mob()
    local dist, mob, mob_target = math.huge
    local player = game:GetService("Players").LocalPlayer
    local root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")

    if not root then return nil, nil end

    for _, group in ipairs(workspace.World.Alive.Mobs:GetChildren()) do
        if group:IsA("Folder") then -- Ensure it's a folder like "CageBoxers"
            for _, config in ipairs(group:GetChildren()) do
                if config:IsA("Configuration") then
                    local v = config:FindFirstChildOfClass("Model") -- Directly get the Model
                    if v then
                        local target = v:FindFirstChild("HumanoidRootPart")
                        local hum = v:FindFirstChildOfClass("Humanoid")

                        if target and hum and hum.Health > 0 then
                            local mag = (target.Position - root.Position).Magnitude
                            if mag < dist then
                                mob = v
                                mob_target = target
                                dist = mag
                            end
                        end
                    end
                end
            end
        end
    end

    return mob, mob_target
end

local function To_Nearmob()
    local mob, target = Get_Mob()
    if root and mob and target then
        root.CFrame = target.CFrame * CFrame.new(0,7,0) * CFrame.Angles(-90, 0, 0)
        root.Velocity = Vector3.new(0,0,0)
        Auto_Attack()
    end
end

local function EDisabled()
    local effect = {'cantbereal','Orbie','speedline','Twister2','Hitbox','Projectile','Spike','Slash'}
    local visuals = workspace.World.Visuals:GetChildren()
    for i,v in ipairs(visuals) do
        if table.find(effect, v.Name) then
            v:Destroy()
        end
    end
end

local function EPDisalbed()
    local effect = {'duststuff'}
    local root = game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart"):GetChildren()
    for i,v in ipairs(root) do
        if table.find(effect, v.Name) then
            v:Destroy()
        end
    end
end

local function NoStun()
    local effect = {'Swinging'}
    local root = char:GetChildren()
    for i,v in ipairs(root) do
        if table.find(effect, v.Name) then
            v:Destroy()
        end
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
local Leveling = section.new_sector('Level', 'Left')


local TP = section.new_sector('Teleport', 'Right')
local FPS = section.new_sector('Low FPS', 'Right')





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

local To_Nearmob = Farm.element('Toggle', 'Farm (Nearest)', false, function(v)
    _G.To_Nearmob = v.Toggle
    while _G.To_Nearmob do task.wait()
        To_Nearmob()
    end
end)

local Auto_Attack = Farm.element('Toggle', 'Auto Attack', false, function(v)
    _G.Auto_Attack = v.Toggle
    while _G.Auto_Attack do task.wait()
        Auto_Attack()
    end
end)

local SearingBlow = Farm.element('Toggle', 'Auto Skill (SearingBlow)', false, function(v)
    _G.SearingBlow = v.Toggle
    while _G.SearingBlow do task.wait()
        Skill("SearingBlow")
    end
end)

local SeveringRift = Farm.element('Toggle', 'Auto Skill (SeveringRift)', false, function(v)
    _G.SeveringRift = v.Toggle
    while _G.SeveringRift do task.wait()
        Skill("SeveringRift")
    end
end)

local Effect_disabled = Misc.element('Toggle', 'Effect Disabled', false, function(v)
    _G.EDisabled = v.Toggle
    while _G.EDisabled do task.wait()
        EDisabled()
        EPDisalbed()
    end
end)

local No_Stun = Misc.element('Toggle', 'No Stun', false, function(v)
    _G.No_Stun = v.Toggle
    while _G.No_Stun do task.wait()
        NoStun()
    end
end)

local No_Stun = Misc.element('Button', 'Respawn Character', false, function()
    S_S:FireServer("RespawnCharacter")
end)

local Auto_Leveling = Leveling.element('Toggle', 'Auto Leveling', false, function(v)
    _G.Auto_Leveling = v.Toggle
    while _G.Auto_Leveling do task.wait(0.01)
        Arai()
    end
end)
--[[

    ████████╗███████╗██╗░░░░░███████╗██████╗░░█████╗░██████╗░████████╗
    ╚══██╔══╝██╔════╝██║░░░░░██╔════╝██╔══██╗██╔══██╗██╔══██╗╚══██╔══╝
    ░░░██║░░░█████╗░░██║░░░░░█████╗░░██████╔╝██║░░██║██████╔╝░░░██║░░░
    ░░░██║░░░██╔══╝░░██║░░░░░██╔══╝░░██╔═══╝░██║░░██║██╔══██╗░░░██║░░░
    ░░░██║░░░███████╗███████╗███████╗██║░░░░░╚█████╔╝██║░░██║░░░██║░░░
    ░░░╚═╝░░░╚══════╝╚══════╝╚══════╝╚═╝░░░░░░╚════╝░╚═╝░░╚═╝░░░╚═╝░░░
]]--


local Sendai = TP.element('Button', 'Sendai School', false, function()
    root.CFrame = CFrame.new(-199, -270, -9110)
end) 

local JJK_School = TP.element('Button', 'Jujutsu School', false, function()
    root.CFrame = CFrame.new(-851, -210, -4441)
end) 

local Exam_Sorcerers = TP.element('Button', 'Exam Sorcerers', false, function()
    local oldpos = root.CFrame
    root.CFrame = CFrame.new(-881, -254, -4441)
    wait(1)
    root.CFrame = oldpos
end) 


--[[

    ███████╗██████╗░░██████╗  ░█████╗░░█████╗░███╗░░██╗████████╗██████╗░░█████╗░██╗░░░░░
    ██╔════╝██╔══██╗██╔════╝  ██╔══██╗██╔══██╗████╗░██║╚══██╔══╝██╔══██╗██╔══██╗██║░░░░░
    █████╗░░██████╔╝╚█████╗░  ██║░░╚═╝██║░░██║██╔██╗██║░░░██║░░░██████╔╝██║░░██║██║░░░░░
    ██╔══╝░░██╔═══╝░░╚═══██╗  ██║░░██╗██║░░██║██║╚████║░░░██║░░░██╔══██╗██║░░██║██║░░░░░
    ██║░░░░░██║░░░░░██████╔╝  ╚█████╔╝╚█████╔╝██║░╚███║░░░██║░░░██║░░██║╚█████╔╝███████╗
    ╚═╝░░░░░╚═╝░░░░░╚═════╝░  ░╚════╝░░╚════╝░╚═╝░░╚══╝░░░╚═╝░░░╚═╝░░╚═╝░╚════╝░╚══════╝
]]--


local FPS_12 = FPS.element('Toggle', 'FPS 12', false, function(v)
    _G.FPS_12 = v.Toggle
    while _G.FPS_12 do task.wait()
        low_fps(12)
    end
end)

local FPS_24 = FPS.element('Toggle', 'FPS 24', false, function(v)
    _G.FPS_24 = v.Toggle
    while _G.FPS_24 do task.wait()
        low_fps(24)
    end
end)


Notify('Hub is loaded')
AFK()
