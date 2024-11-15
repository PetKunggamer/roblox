local A = game:GetService("CoreGui"):FindFirstChild("unknown")

if A then
    A:Destroy()
end


--[[

    ███████╗██╗░░░██╗███╗░░██╗░█████╗░████████╗██╗░█████╗░███╗░░██╗
    ██╔════╝██║░░░██║████╗░██║██╔══██╗╚══██╔══╝██║██╔══██╗████╗░██║
    █████╗░░██║░░░██║██╔██╗██║██║░░╚═╝░░░██║░░░██║██║░░██║██╔██╗██║
    ██╔══╝░░██║░░░██║██║╚████║██║░░██╗░░░██║░░░██║██║░░██║██║╚████║
    ██║░░░░░╚██████╔╝██║░╚███║╚█████╔╝░░░██║░░░██║╚█████╔╝██║░╚███║
    ╚═╝░░░░░░╚═════╝░╚═╝░░╚══╝░╚════╝░░░░╚═╝░░░╚═╝░╚════╝░╚═╝░░╚══╝

]]--

local char = game.Players.LocalPlayer.Character
local hrp = char:FindFirstChild("HumanoidRootPart")


local function Get_Map()
    for i,v in ipairs(workspace.Client.Maps:GetChildren()) do
        return v
    end
    return nil
end

local function Get_World()
    for i,v in ipairs(workspace.Server.Enemies:GetChildren()) do
        if v:IsA("Folder") and v.Name == Get_Map().Name then
            return v
        end
    end
    return nil
end

local function Notify(title,text,dura)
    game:GetService("StarterGui"):SetCore("SendNotification",{
    Title = title,
    Text = text, 
    Duration = dura
    })
end

local function Get_Mob()
    local dist, nearestMob = math.huge
    for _, folder in ipairs({Get_World(), workspace.Server.Trial.Enemies.Easy}) do
        for _, mob in ipairs(folder:GetChildren()) do
            if mob:IsA("Part") then
                if not hrp then return end
                local mag = (mob.Position - hrp.Position).magnitude
                if mag < dist and mag < 1000 then
                    dist = mag
                    nearestMob = mob
                end
            end
        end
    end
    return nearestMob
end

local function Get_Pet()
    local Pet = {}
    for i,v in ipairs(workspace.Server.Pets:GetChildren()) do
        if v:IsA("Model") and v.Name:find(char.Name) then
            table.insert(Pet,v)
        end
    end
    return Pet
end

local function to_target()
    for i,v in ipairs(Get_Pet()) do
        local target = Get_Mob()
        local hrp_pet = v:FindFirstChild("HumanoidRootPart")
        if target and hrp_pet then
            local mag = (target.Position - hrp_pet.Position).magnitude
            if mag > 10 then
                hrp_pet.CFrame = target.CFrame
                -- hrp.CFrame = target.CFrame * CFrame.new(0,10,0)
            end
        end
    end
end

local function Attack()
    to_target()
    for i,v in ipairs(Get_Pet()) do
        local args = {
            [1] = "General",
            [2] = "Pets",
            [3] = "Attack",
            [4] = v.Name:sub(#char.Name+4),
            [5] = Get_Mob()
        }

        game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Bridge"):FireServer(unpack(args))
    end
end

local function Get_Coin()
    for i,v in ipairs(workspace.Client.Drops:GetChildren()) do
        if v:IsA("Part") then
            v.Transparency = 0
            v.CFrame = hrp.CFrame
        end
    end
end

local function Check_Door()
    local old_doorpos = CFrame.new(-8832.51953, 57, -3682)
    local door = workspace.Server.Trial.Lobby:FindFirstChild('Easy_Door')
    if door and not (door.CFrame == old_doorpos) then
        return true
    end
    return
end

local function Join_Trial()
    local val = workspace.Server.Trial.Lobby.Easy_Screen.Frame:FindFirstChild("Value")
    if val.Text == "00:00" or val.Text == "00:01" or Check_Door() then
        local args = {
            [1] = "Enemies",
            [2] = "Trial_Easy",
            [3] = "Join"
        }

        game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Bridge"):FireServer(unpack(args))
    end
end

local function Egg()
local args = {
    [1] = "General",
    [2] = "Stars",
    [3] = "Multi",
    [4] = tostring(Get_World().Name),
    [5] = "Coins"
}

game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Bridge"):FireServer(unpack(args))
end

local function Create_WayPoint(name, pos)
    local waypoint = workspace:FindFirstChild(name)
    if waypoint then
        waypoint:Destroy()
    end

    local part = Instance.new("Part")
    part.Name = name
    part.Parent = workspace
    part.Material = 'ForceField'
    part.CanCollide = false
    part.Color = Color3.fromRGB(255,0,0)
    part.Anchored = true
    part.CFrame = pos
end

local function Get_Waypoint()
    local W1 = workspace:FindFirstChild('W1')
    local W2 = workspace:FindFirstChild('W2')
    if W1 and W2 then
        return {W1, W2}
    end
    return nil
end

local function Get_Near_SetMob()
    local nearestMob = Get_Mob()
    if not nearestMob then 
        print("No nearest mob found.")
        return nil 
    end

    local secondNearestMob = nil
    local minDist = math.huge

    for _, folder in ipairs({Get_World(), workspace.Server.Trial.Enemies.Easy}) do
        for _, mob in ipairs(folder:GetChildren()) do
            if mob:IsA("Part") and mob ~= nearestMob then
                local dist = (mob.Position - hrp.Position).magnitude
                if dist < minDist and dist < 1000 then
                    minDist = dist
                    secondNearestMob = mob
                end
            end
        end
    end
    return secondNearestMob
end


local function Reset_Waypoint(WayPoint)
    local W1,W2 = WayPoint[1], WayPoint[2]
    if W1 then
        W1:Destroy()
    end
   if W2 then
        W2:Destroy()
    end
end

local function Get_Waypoint_CFarm()
    local mob = workspace:FindFirstChild('Mob')
    local secound_mob = Get_Near_SetMob()
    if not mob then
        Notify('Custom Farm', 'Set Mob Part missing.', 1)
    end

    if mob and secound_mob then
        return {mob, secound_mob}
    end
    return nil
end

local function Get_Waypoint_CFarm()
    local mob = workspace:FindFirstChild('Mob')
    local secound_mob = Get_Near_SetMob()
    if not mob then
        Notify('Custom Farm', 'Set Mob Part missing.', 1)
    end

    if mob and secound_mob then
        return {mob, secound_mob}
    end
    return nil
end

local function Stack(WayPoint)
     local W1, W2 = WayPoint[1], WayPoint[2] -- Unpack the table
    if not W1 then
        Notify('Stack Damage Function','Part 1 Missing',1.5)
    end
    if not W2 then
        Notify('Stack Damage Function','Part 2 Missing',1.5)
    end
    if W1 and W2 then
        for i = 1, 100 do
            hrp.CFrame = W1.CFrame
            task.wait()
            hrp.CFrame = W2.CFrame
            task.wait()
        end
        hrp.CFrame = W1.CFrame
        hrp.Velocity = Vector3.new(0,0,0)
    end
end

local function Time_Teller()
    local Trial = workspace.Server.Trial.Lobby.Easy_Screen.Frame.Value
    local Time_list = {'30:00','25:00','20:00','15:00','10:00','05:00','04:00','03:00','02:00','01:00','00:30','00:20','00:10','00:09', '00:08', '00:07', '00:06', '00:05', '00:04', '00:03', '00:02', '00:01'}
    for i,Time in ipairs(Time_list) do
        if Trial.Text == Time then
            Notify('Trial Time', 'Time Remaining : '.. Trial.Text, 1)
        end
        print('Time Remaining : '.. Trial.Text)
        wait(1.125)
    end
    return nil
end

local function Get_All_World()
    local World = {}
    for i,v in ipairs(workspace.Client.Portals:GetChildren()) do
        table.insert(World, v.Name)
    end
    return World
end

local function Teleport_World(World)
    local args = {
        [1] = "General",
        [2] = "Teleport",
        [3] = "Teleport",
        [4] = World
    }

    game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Bridge"):FireServer(unpack(args))
end


local function Save_UI()
    local UI = game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild('UI')
    local Star = game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild('Star')
    if Star and Star.Enabled then
        Star.Enabled = false
        UI.Enabled = true
    end
end

local function Farm_MS()
    local mob = Get_Mob(workspace:FindFirstChild('Mob'))
    local mob_sec = Get_Near_SetMob()
    local oldppos = hrp.CFrame
    if mob then
        local respawn = mob:FindFirstChild("RespawnHUD")
        if respawn and respawn.Enabled then
            local Status = respawn:FindFirstChild("Status")
            if Status then
                local Frame = Status:FindFirstChild("Frame")
                if Frame then
                    local val = Frame:FindFirstChild("Value")
                    if val.Text == "0s" then
                        wait(1)
                        for i = 1,50 do
                            hrp.CFrame = mob.CFrame
                            task.wait()
                            hrp.CFrame = mob_sec.CFrame
                            task.wait()
                        end
                        task.wait(.225)
                        hrp.CFrame = oldppos
                    end
                end
            end
        end
    end
end

local function Move_to_mob(mob)
    if not hrp then return end
    to_target()
    hrp.CFrame = mob.CFrame
    hrp.Velocity = Vector3.new(0,0,0)
end

local function Get_Mob_Trial()
    local mob = nil
    for i, v in ipairs(workspace.Server.Trial.Enemies.Easy:GetChildren()) do
        local Health = v:GetAttribute("Health")
        if Health and Health > 0 then
            mob = v
        end
    end
    return mob
end

local function Farm_Trial()
    local mob = Get_Mob_Trial()
    local mob_sec = Get_Near_SetMob()
    if mob and mob_sec then
        Move_to_mob(mob)
    end
end

local function Farm_Trial_Fast()
    local mob = Get_Mob_Trial()
    local mob_sec = Get_Near_SetMob()
    if mob and mob_sec then
        if not hrp then return end
        for i = 1,30 do
            hrp.CFrame = mob.CFrame
            task.wait()
            hrp.CFrame = mob_sec.CFrame
            task.wait()
        end
        to_target()
        hrp.CFrame = mob.CFrame
        hrp.Velocity = Vector3.new(0,0,0)
        wait(10)
    end
end

local function Passives_UI(state)
local frame = game:GetService("Players").LocalPlayer.PlayerGui.UI.Frames:FindFirstChild('Passives')
    if frame then
        if not state then
            frame.Visible = true
            frame.Position = UDim2.new(0.5, 0, 1.6, 0)
        else
            frame.Position = UDim2.new(0.5, 0, 0.5, 0)
        end
    end
end

local function Daily_Quest()
    local Quest_Ticket = game:GetService("Players").LocalPlayer.PlayerGui.UI.HUD:FindFirstChild("Ticket_Quest")
    if Quest_Ticket and not Quest_Ticket.Visible then 
        game:GetService("ReplicatedStorage").Remotes.Bridge:FireServer("General","Quests","Tickets")
    else
        game:GetService("ReplicatedStorage").Remotes.Bridge:FireServer("General","Quests","TicketsClaim")
    end
end

local function GetMob_Quest()
    local Quest = game:GetService("Players").LocalPlayer.PlayerGui.UI.HUD:FindFirstChild("Quests")
    if Quest and Quest.Visible then
        local Description = Quest:FindFirstChild('Description')
        if Description then
            -- Extract the mob type from the Description
            local mobType = string.match(Description.Text, "Defeat %d+ ([%w%s]+)'s")
            if mobType then
                -- Try to match against "Ebito" and "Ebito Evolution" mobs
                for i, v in ipairs(Get_World():GetChildren()) do
                    if v:IsA('Part') then
                        -- Check if the mob matches the mob type
                        if string.find(v.Name, mobType) then
                            local hp = v:GetAttribute('Health')
                            if hp and hp > 0 then
                                return v  -- Return the mob if it has health and matches
                            end
                        end
                    end
                end
            end
        end
    end
    return nil  -- If no valid mob is found
end

local function Remote_Quest(State,Quest)
    local args = {
        [1] = "General",
        [2] = "Quests",
        [3] = State,
        [4] = tostring((Get_Map().Name)),
        [5] = Quest
    }

    game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Bridge"):FireServer(unpack(args))
end


local function Get_Module_Quest()
    for i,v in ipairs(game:GetService("Players").LocalPlayer.PlayerScripts.StarX.UserInterface.Scripts.Dialog.Info:GetChildren()) do
        if v:IsA('ModuleScript') then
            local Map = string.gsub(Get_Map().Name, "%s+", "")  -- Remove all spaces (whitespace)
            if Map then
                if string.find(v.Name, 'EximiusX_'..Map) then
                    return v
                end
            end
        end
    end
    return
end

local function Get_Quest()
    local Quest = game:GetService("Players").LocalPlayer.PlayerGui.UI.HUD:FindFirstChild("Quests")
    if Quest then
        local Completed = Quest:FindFirstChild("Completed")
        for i,v in ipairs(Get_Module_Quest():GetChildren()) do
            if Quest.Visible and Completed.Visible then
                Remote_Quest('Claim', v.Name)
            elseif not Quest.Visible then
                Remote_Quest('Accept', v.Name)
            end
        end
    end
end



local mob_list = {} -- Table to keep track of stacked mobs by unique ID

local function Auto_Quest()
    Get_Quest()
    local mob = GetMob_Quest()            -- Get the current quest mob
    local near_mob = Get_Near_SetMob()     -- Get a nearby mob
    if mob and near_mob then
        local ID = mob:GetAttribute('ID')      -- Get the unique ID attribute of the mob
        local HP = mob:GetAttribute('Health')  -- Get the Health attribute of the mob
        if ID and HP then
            if not (HP == 0) then
                print(#mob_list)
                if not mob_list[2] then
                    Move_to_mob(mob)
                    table.insert(mob_list, ID)
                    Stack({mob, near_mob})
                else
                    Move_to_mob(mob)
                end
            else
                table.clear(mob_list)
            end
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

local library = loadstring(game:HttpGet('https://raw.githubusercontent.com/cueshut/saves/main/criminality%20paste%20ui%20library'))()

-- // Window \\ --
local window = library.new('Syn0xz Hub', 'Syn0xz')

-- // Tabs \\ --
local tab = window.new_tab('rbxassetid://4483345998')

-- // Sections \\ --
local section = tab.new_section('- Main -')


-- // Sector \\ --
local Farm = section.new_sector('Farming', 'Left')
local Trial = section.new_sector('Trial', 'Left')
local C_Farm = section.new_sector('Custom Farm', 'Left')
local Misc = section.new_sector('Misc', 'Right') 
local Dmg: any = section.new_sector('Damage Stacking', 'Right') 
local UI_OPEN = section.new_sector('UI Opening', 'Right') 





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

local Auto_Quest = Farm.element('Toggle', 'Auto Quest', false, function(v)
    _G.Auto_Quest = v.Toggle
    while _G.Auto_Quest do task.wait()
        Auto_Quest()
    end 
end) 





--[[

    ████████╗██╗███╗░░░███╗███████╗  ████████╗██████╗░██╗░█████╗░██╗░░░░░
    ╚══██╔══╝██║████╗░████║██╔════╝  ╚══██╔══╝██╔══██╗██║██╔══██╗██║░░░░░
    ░░░██║░░░██║██╔████╔██║█████╗░░  ░░░██║░░░██████╔╝██║███████║██║░░░░░
    ░░░██║░░░██║██║╚██╔╝██║██╔══╝░░  ░░░██║░░░██╔══██╗██║██╔══██║██║░░░░░
    ░░░██║░░░██║██║░╚═╝░██║███████╗  ░░░██║░░░██║░░██║██║██║░░██║███████╗
    ░░░╚═╝░░░╚═╝╚═╝░░░░░╚═╝╚══════╝  ░░░╚═╝░░░╚═╝░░╚═╝╚═╝╚═╝░░╚═╝╚══════╝
]]--

local Farm_Trial = Trial.element('Toggle', 'Auto Farm Trial (Normal)', false, function(v)
    _G.Farm_Trial = v.Toggle
    while _G.Farm_Trial do task.wait()
        Farm_Trial()
    end
end)

local Farm_Trial_Fast = Trial.element('Toggle', 'Auto Farm Trial (Fast)', false, function(v)
    _G.Farm_Trial_Fast = v.Toggle
    while _G.Farm_Trial_Fast do task.wait()
        Farm_Trial_Fast()
    end
end) 

local Trial_Teller = Trial.element('Toggle', 'Trial Alert Time', false, function(v)
    _G.Time_Teller = v.Toggle
    while _G.Time_Teller do task.wait()
        Time_Teller()
    end
end) 

local Trial = Trial.element('Toggle', 'Auto Join Trial', false, function(v)
    _G.Trial = v.Toggle
    while _G.Trial do task.wait()
        Join_Trial()
    end
end) 



















--[[

    ███╗░░░███╗██╗░██████╗░█████╗░
    ████╗░████║██║██╔════╝██╔══██╗
    ██╔████╔██║██║╚█████╗░██║░░╚═╝
    ██║╚██╔╝██║██║░╚═══██╗██║░░██╗
    ██║░╚═╝░██║██║██████╔╝╚█████╔╝
    ╚═╝░░░░░╚═╝╚═╝╚═════╝░░╚════╝░
]]--

local Auto_Daily_Quest = Misc.element('Toggle', 'Auto Daily Quest', false, function(v)
    _G.Auto_Daily = v.Toggle
    while _G.Auto_Daily do task.wait()
        Daily_Quest()
        wait(60)
    end
end) 

local Attack = Misc.element('Toggle', 'Auto Attack', false, function(v)
    _G.Trial = v.Toggle
    while _G.Trial do task.wait()
        Attack()
    end
end) 

local Auto_Coin = Misc.element('Toggle', 'Auto Bring Coin', false, function(v)
    _G.Auto_Coin = v.Toggle
    while _G.Auto_Coin do task.wait()
        Get_Coin()
    end
end) 

local Egg = Misc.element('Toggle', 'Auto Egg', false, function(v)
    _G.Egg = v.Toggle
    while _G.Egg do task.wait()
        Egg()
    end
end) 

local Save_UI = Misc.element('Toggle', 'No Open Egg Animation', false, function(v)
    _G.Save_UI = v.Toggle
    while _G.Save_UI do task.wait()
        Save_UI()
    end
end) 

local Teleport_World = Misc.element('Dropdown', 'Teleport World', {options = Get_All_World()}, function(v)
   Teleport_World(v.Dropdown)
end)










--[[
    
    ██████╗░░█████╗░███╗░░░███╗░█████╗░░██████╗░███████╗
    ██╔══██╗██╔══██╗████╗░████║██╔══██╗██╔════╝░██╔════╝
    ██║░░██║███████║██╔████╔██║███████║██║░░██╗░█████╗░░
    ██║░░██║██╔══██║██║╚██╔╝██║██╔══██║██║░░╚██╗██╔══╝░░
    ██████╔╝██║░░██║██║░╚═╝░██║██║░░██║╚██████╔╝███████╗
    ╚═════╝░╚═╝░░╚═╝╚═╝░░░░░╚═╝╚═╝░░╚═╝░╚═════╝░╚══════╝

    ░██████╗████████╗░█████╗░░█████╗░██╗░░██╗
    ██╔════╝╚══██╔══╝██╔══██╗██╔══██╗██║░██╔╝
    ╚█████╗░░░░██║░░░███████║██║░░╚═╝█████═╝░
    ░╚═══██╗░░░██║░░░██╔══██║██║░░██╗██╔═██╗░
    ██████╔╝░░░██║░░░██║░░██║╚█████╔╝██║░╚██╗
    ╚═════╝░░░░╚═╝░░░╚═╝░░╚═╝░╚════╝░╚═╝░░╚═╝
]]


local W1 = Dmg.element('Button', 'Create Waypoint 1', nil, function()
    Create_WayPoint('W1', hrp.CFrame)
    Notify('Damage Stacking', 'Created Waypoint 1', 1)
end)

local W2 = Dmg.element('Button', 'Create Waypoint 2', nil, function()
    Create_WayPoint('W2', hrp.CFrame)
    Notify('Damage Stacking', 'Created Waypoint 2', 1)
end)

local Start = Dmg.element('Button', 'Start', nil, function()
    Stack(Get_Waypoint())
end)

local Reset_Waypoint = Dmg.element('Button', 'Reset Waypoint', nil, function()
    Reset_Waypoint(Get_Waypoint())
end)








--[[


    ░█████╗░██╗░░░██╗░██████╗████████╗░█████╗░███╗░░░███╗
    ██╔══██╗██║░░░██║██╔════╝╚══██╔══╝██╔══██╗████╗░████║
    ██║░░╚═╝██║░░░██║╚█████╗░░░░██║░░░██║░░██║██╔████╔██║
    ██║░░██╗██║░░░██║░╚═══██╗░░░██║░░░██║░░██║██║╚██╔╝██║
    ╚█████╔╝╚██████╔╝██████╔╝░░░██║░░░╚█████╔╝██║░╚═╝░██║
    ░╚════╝░░╚═════╝░╚═════╝░░░░╚═╝░░░░╚════╝░╚═╝░░░░░╚═╝

    ███████╗░█████╗░██████╗░███╗░░░███╗
    ██╔════╝██╔══██╗██╔══██╗████╗░████║
    █████╗░░███████║██████╔╝██╔████╔██║
    ██╔══╝░░██╔══██║██╔══██╗██║╚██╔╝██║
    ██║░░░░░██║░░██║██║░░██║██║░╚═╝░██║
    ╚═╝░░░░░╚═╝░░╚═╝╚═╝░░╚═╝╚═╝░░░░░╚═╝
    
]]--



local Farm_MS = C_Farm.element('Toggle', 'Auto Farm Set Mob', false, function(v)
    _G.Farm_MS = v.Toggle
    while _G.Farm_MS do task.wait()
        Farm_MS()
    end
end) 

local mob_set = C_Farm.element('Button', 'Set Mob', nil, function()
    local mob = Get_Mob()
    if mob then
        Create_WayPoint('Mob', mob.CFrame)
        Notify('Custom Farm', "Created Waypoint " .. mob.Name, 1)
    else
        Notify('Custom Farm', "No nearby mob found", 1)
    end
end)

local Start = C_Farm.element('Button', 'Start', nil, function()
    Stack(Get_Waypoint_CFarm())
end)


--[[


██╗░░░██╗██╗  ░█████╗░██████╗░███████╗███╗░░██╗
██║░░░██║██║  ██╔══██╗██╔══██╗██╔════╝████╗░██║
██║░░░██║██║  ██║░░██║██████╔╝█████╗░░██╔██╗██║
██║░░░██║██║  ██║░░██║██╔═══╝░██╔══╝░░██║╚████║
╚██████╔╝██║  ╚█████╔╝██║░░░░░███████╗██║░╚███║
░╚═════╝░╚═╝  ░╚════╝░╚═╝░░░░░╚══════╝╚═╝░░╚══╝
]]--



local Passive_UI = UI_OPEN.element('Toggle', 'Passive Reroll', false, function(v)
    Passives_UI(v.Toggle)
end) 
