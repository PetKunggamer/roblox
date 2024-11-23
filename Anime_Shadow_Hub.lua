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
local current_mob = nil
local Egg = nil

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

local function AFK()
    Notify('Syn0xz Hub', 'Anti afk loaded', 3)
    loadstring(game:HttpGet("https://raw.githubusercontent.com/evxncodes/mainroblox/main/anti-afk", true))()
end

local function Get_Mob()
    local dist, nearestMob = math.huge
    for _, folder in ipairs({Get_World(), workspace.Server.Trial.Enemies.Easy, workspace.Server.Trial.Enemies.Dungeon}) do
        for _, mob in ipairs(folder:GetChildren()) do
            if mob:IsA("Part") then
                if not hrp then return end
                local mag = (mob.Position - hrp.Position).magnitude
                if mag < dist and mag < 1000 then
                    local hp = mob:GetAttribute('Health')
                    if hp and hp > 0 then
                        dist = mag
                        nearestMob = mob
                    end
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

local function Join_Trial(Screen, Name)
    local val = Screen
    if val and val.Text == "00:00" or val.Text == "00:01" or Check_Door() then
        local args = {
            [1] = "Enemies",
            [2] = Name,
            [3] = "Join"
        }

        game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Bridge"):FireServer(unpack(args))
    end
end


local function Open_Egg()
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
        return nil 
    end

    local secondNearestMob = nil
    local minDist = math.huge

    for _, folder in ipairs({Get_World(), workspace.Server.Trial.Enemies.Easy, workspace.Server.Trial.Enemies.Dungeon}) do
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

local function Stack(WayPoint)
    local W1, W2 = WayPoint[1], WayPoint[2] -- Unpack the table
    local oldpos = hrp.CFrame
    if not W1 then
        Notify('Stack Damage Function','Part 1 Missing',1.5)
    end
    if not W2 then
        Notify('Stack Damage Function','Part 2 Missing',1.5)
    end
    if W1 and W2 then
        for i = 1, 100 do
            hrp.CFrame = W1.CFrame
            Attack()
            task.wait()
            hrp.CFrame = W2.CFrame
            Attack()
            task.wait()
        end
        hrp.CFrame = oldpos
        hrp.Velocity = Vector3.new(0,0,0)
    end
end

local function Time_Teller(Trial)
    local Trial = workspace.Server.Trial.Lobby:FindFirstChild(Trial).Frame.Value
    local Time_list = {'30:00','25:00','20:00','15:00','10:00','05:00','04:00','03:00','02:00','01:00','00:30','00:20','00:10','00:09', '00:08', '00:07', '00:06', '00:05', '00:04', '00:03', '00:02', '00:01'}
    for i,Time in ipairs(Time_list) do
        if Trial.Text == Time then
            --Notify('Trial Time', 'Time Remaining : '.. Trial.Text, 1)
            ---wait(1)
        end
    end
    return Trial.Text
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
    local mob = workspace:FindFirstChild('Mob')
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
    if mob then
        hrp.CFrame = mob.CFrame
        hrp.Velocity = Vector3.new(0,0,0)
    end
end

local function Get_Mob_Trial()
    local mob = nil
    local highest = 0
    for i, v in ipairs(workspace.Server.Trial.Enemies.Easy:GetChildren()) do
        local MaxHP = v:GetAttribute("MaxHealth")
        if MaxHP and MaxHP > highest then
            highest = MaxHP  -- Compare against MaxHealth
            mob = v          -- Update to the mob with the highest MaxHealth
        end
    end
    return mob
end

local function Get_Dungeon_Mob()
    local mob = nil
    local highest = 0
    for i, v in ipairs(workspace.Server.Trial.Enemies.Dungeon:GetChildren()) do
        local MaxHP = v:GetAttribute("MaxHealth")
        if MaxHP and MaxHP > highest then
            highest = MaxHP  -- Compare against MaxHealth
            mob = v          -- Update to the mob with the highest MaxHealth
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
    local near = Get_Near_SetMob()
    -- Check if the current mob is valid and alive
    if current_mob and current_mob.Parent and current_mob:GetAttribute("Health") > 0 then
        if not _G.Stack then
            _G.Stack = true
            Stack({Get_Mob_Trial(), near})
        end
        Move_to_mob(current_mob)
        wait()
        Move_to_mob(Get_Mob_Trial())
    else
        -- If the current mob is dead or invalid, reset and find a new one
        wait(.25)
        _G.Stack = false
        current_mob = Get_Mob_Trial()
    end
end

local function Open_UI(state,UI)
local frame = game:GetService("Players").LocalPlayer.PlayerGui.UI.Frames:FindFirstChild(UI)
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
                                return v
                            end
                        end
                    end
                end
            end
        end
    end
    return
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

local function Auto_Quest()
    local near = Get_Near_SetMob()
    if current_mob and near then
        if current_mob:GetAttribute('Health') == 0 then
            current_mob = nil
            Stack({GetMob_Quest(),near})
        else
            Move_to_mob(current_mob)
        end
    elseif not current_mob then
        current_mob = GetMob_Quest()
        Stack({current_mob,near})
        if current_mob then
            Move_to_mob(current_mob)
        end
    end
end

local function Dungeon_Farm()
    local mob = Get_Dungeon_Mob()
    local mob_sec = Get_Near_SetMob()
    if mob and mob_sec then
        Move_to_mob(mob)
    end
end

local function Dungeon_Fast()
    local near = Get_Near_SetMob()

    -- Check if the current mob is valid and alive
    if current_mob and current_mob.Parent and current_mob:GetAttribute("Health") > 0 then
        if not _G.Stack then
            _G.Stack = true
            Stack({Get_Dungeon_Mob(), near})
        end
        Move_to_mob(current_mob)
        wait()
        Move_to_mob(Get_Dungeon_Mob())
    else
        -- If the current mob is dead or invalid, reset and find a new one
        wait(.25)
        _G.Stack = false
        current_mob = Get_Dungeon_Mob()
    end
end

local function Safe_Part()
    local platform = workspace:FindFirstChild('Platform')
    if (not platform) then
        local Safe = Instance.new('Part')
        Safe.Name = 'Platform'
        Safe.Transparency = 1
        Safe.Anchored = true
        Safe.Size = Vector3.new(2,0.2,1.5)
        Safe.Parent = workspace
    else
        platform.CFrame = hrp.CFrame * CFrame.new(0,-3.099999,0)
    end
end

local function Auto_Chest()
    local list = {'Dragon Chest','Beginner Chest','Potions Chest','Artefacts Chest'}
        for i,v in pairs(list) do
        local args = {
            [1] = "General",
            [2] = "Chests",
            [3] = "Open",
            [4] = v
        }
        
        game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Bridge"):FireServer(unpack(args))
        end
    game:GetService("Players").LocalPlayer.PlayerGui.Rewards.Enabled = false
end

local function Notification(State)
    if State then
        game:GetService("Players").LocalPlayer.PlayerGui.UI.HUD.Notifications.Visible = false
    else
        game:GetService("Players").LocalPlayer.PlayerGui.UI.HUD.Notifications.Visible = true
    end
end

local function Get_Egg()
    local Egg = {}
    for _, folder in ipairs(workspace.Server.Stars:GetChildren()) do
        if folder:IsA('Folder') then
            table.insert(Egg, folder.Name)
        end
    end
    return Egg
end

local function Egg_Select(Egg)
    -- Loop through all children (folders) of workspace.Server.Stars
    for _, folder in ipairs(workspace.Server.Stars:GetChildren()) do
        -- Check if the folder name matches the provided Egg
        if folder:IsA('Folder') and folder.Name == Egg then
            -- Look for the 'Coins' child within the folder
            local coins = folder:FindFirstChild('Coins')
            if coins then
                return {folder,coins}
            end
        end
    end
    return nil -- Return nil if no match is found
end

local function move_to_egg(Select)
    local World, Egg = Select[1], Select[2]
    if World then
        if (Get_Map().Name == World.Name) then
            local Cloth = Egg:FindFirstChild('Cloth')
            if Cloth then
                hrp.CFrame = Cloth.CFrame * CFrame.new(0,1,-5)
            end
        else
            Teleport_World(tostring(World))
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


local Library = loadstring(game:HttpGet('https://raw.githubusercontent.com/VisualRoblox/Roblox/main/UI-Libraries/Visual%20UI%20Library/Source.lua'))()

local Window = Library:CreateWindow('Syn0xz Hub', 'Anime Shadow', 'Syn0xz Hub', 'rbxassetid://10618928818', false, 'VisualUIConfigs', 'Default')

local Tab_Main = Window:CreateTab('Main', true, 'rbxassetid://3926305904', Vector2.new(524, 44), Vector2.new(36, 36))
local Tab_Egg = Window:CreateTab('Egg', false, 'rbxassetid://3926305904', Vector2.new(524, 44), Vector2.new(36, 36))
local Tab_Trial = Window:CreateTab('Time Trial', false, 'rbxassetid://3926305904', Vector2.new(524, 44), Vector2.new(36, 36))
local Tab_DStack = Window:CreateTab('Damage Stack', false, 'rbxassetid://3926305904', Vector2.new(524, 44), Vector2.new(36, 36))
local Tab_UI_Open = Window:CreateTab('UI Opening', false, 'rbxassetid://3926305904', Vector2.new(524, 44), Vector2.new(36, 36))


local Main = Tab_Main:CreateSection('Main Tab')
local Egg_TAB = Tab_Egg:CreateSection('Egg Tab')
local Trial = Tab_Trial:CreateSection('Time Trial Tab')
local D_Stack = Tab_DStack:CreateSection('Damage Stack Tab')
local UI = Tab_UI_Open:CreateSection('UI Opening Tab')


--[[

    ███████╗░█████╗░██████╗░███╗░░░███╗
    ██╔════╝██╔══██╗██╔══██╗████╗░████║
    █████╗░░███████║██████╔╝██╔████╔██║
    ██╔══╝░░██╔══██║██╔══██╗██║╚██╔╝██║
    ██║░░░░░██║░░██║██║░░██║██║░╚═╝░██║
    ╚═╝░░░░░╚═╝░░╚═╝╚═╝░░╚═╝╚═╝░░░░░╚═╝
]]--

local Label_Basic = Main:CreateLabel('Auto Quest (World)')

local Auto_Quest = Main:CreateToggle('Auto Quest', false, Color3.fromRGB(0, 125, 255), 0.25, function(bool)
    _G.Get_Quest = bool
    while _G.Get_Quest do task.wait()
        Get_Quest()
    end 
end)

local TP_Mob_Quest = Main:CreateToggle('TP Mob Quest', false, Color3.fromRGB(0, 125, 255), 0.25, function(bool)
    _G.Auto_Quest = bool
    while _G.Auto_Quest do task.wait()
        Auto_Quest()
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


local Label_Misc = Main:CreateLabel('Misc')


local Auto_Chest = Main:CreateToggle('Auto Chest', false, Color3.fromRGB(0, 125, 255), 0.25, function(bool)
    _G.Auto_Chest = bool
    while _G.Auto_Chest do task.wait(.125)
        Auto_Chest()
    end
end)

local Auto_Daily_Quest = Main:CreateToggle('Auto Daily Quest', false, Color3.fromRGB(0, 125, 255), 0.25, function(bool)
    _G.Auto_Daily = bool
    while _G.Auto_Daily do task.wait()
        Daily_Quest()
        wait(60)
    end
end)

local Attack = Main:CreateToggle('Auto Attack', false, Color3.fromRGB(0, 125, 255), 0.25, function(bool)
    _G.Attack = bool
    while _G.Attack do task.wait()
        Attack()
    end
end)

local Auto_Coin = Main:CreateToggle('Bring Coins', false, Color3.fromRGB(0, 125, 255), 0.25, function(bool)
    _G.Auto_Coin = bool
    while _G.Auto_Coin do task.wait()
        Get_Coin()
    end
end)

local Notification = Main:CreateToggle('NO Notification', false, Color3.fromRGB(0, 125, 255), 0.25, function(bool)
    Notification(bool)
end)

local Safe_Part = Main:CreateToggle('Safe Platform', false, Color3.fromRGB(0, 125, 255), 0.25, function(bool)
    _G.Safe_Part = bool
    while _G.Safe_Part do task.wait()
        Safe_Part()
    end
end)

--[[

    ███████╗░██████╗░░██████╗░  ████████╗░█████╗░██████╗░
    ██╔════╝██╔════╝░██╔════╝░  ╚══██╔══╝██╔══██╗██╔══██╗
    █████╗░░██║░░██╗░██║░░██╗░  ░░░██║░░░███████║██████╦╝
    ██╔══╝░░██║░░╚██╗██║░░╚██╗  ░░░██║░░░██╔══██║██╔══██╗
    ███████╗╚██████╔╝╚██████╔╝  ░░░██║░░░██║░░██║██████╦╝
    ╚══════╝░╚═════╝░░╚═════╝░  ░░░╚═╝░░░╚═╝░░╚═╝╚═════╝░
]]--

local Label_Egg_Opening = Egg_TAB:CreateLabel('Egg Opening')

local Auto_Egg = Egg_TAB:CreateToggle('Auto Open Egg', false, Color3.fromRGB(0, 125, 255), 0.25, function(bool)
    _G.Auto_Egg = bool
    while _G.Auto_Egg do wait(.125)
        Open_Egg()
    end
end)

local Auto_Egg = Egg_TAB:CreateToggle('No Egg Animation', false, Color3.fromRGB(0, 125, 255), 0.25, function(bool)
    _G.Save_UI = bool
    while _G.Save_UI do task.wait(.125)
        Save_UI()
    end
end)


local Egg_ = Egg_TAB:CreateDropdown('Egg Select', Get_Egg(), nil, 0.25, function(Value)
    Egg = Value
end)

local TP_EGG = Egg_TAB:CreateToggle('AUTO TP TO EGG WHEN FREE', false, Color3.fromRGB(0, 125, 255), 0.25, function(bool)
    _G.to_egg = bool
    while _G.to_egg do task.wait(.125)
        local Trial = game:GetService("Players").LocalPlayer.PlayerGui.UI.HUD:FindFirstChild("Trial")
        if not Trial.Visible then
            move_to_egg(Egg_Select(Egg))
        end
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

local Label_Trial = Trial:CreateLabel('Time Remaining')

local Trial_Easy_Time = Trial:CreateParagraph('Trial Easy', '00:00')
local Trial_Dungeon_Time = Trial:CreateParagraph('Trial Dungeon', '00:00')

local Safe_Part = Trial:CreateToggle('Time Alert', false, Color3.fromRGB(0, 125, 255), 0.25, function(bool)
    _G.Alert_Time = bool
    while _G.Alert_Time do wait(.75)
        Trial_Easy_Time:UpdateParagraph('Easy Trial', Time_Teller('Easy_Screen'))
        Trial_Dungeon_Time:UpdateParagraph('Dungeon Trial', Time_Teller('Dungeon_Screen'))
    end
end)

--[[
    
    ███████╗░█████╗░░██████╗██╗░░░██╗  ████████╗██████╗░██╗░█████╗░██╗░░░░░
    ██╔════╝██╔══██╗██╔════╝╚██╗░██╔╝  ╚══██╔══╝██╔══██╗██║██╔══██╗██║░░░░░
    █████╗░░███████║╚█████╗░░╚████╔╝░  ░░░██║░░░██████╔╝██║███████║██║░░░░░
    ██╔══╝░░██╔══██║░╚═══██╗░░╚██╔╝░░  ░░░██║░░░██╔══██╗██║██╔══██║██║░░░░░
    ███████╗██║░░██║██████╔╝░░░██║░░░  ░░░██║░░░██║░░██║██║██║░░██║███████╗
    ╚══════╝╚═╝░░╚═╝╚═════╝░░░░╚═╝░░░  ░░░╚═╝░░░╚═╝░░╚═╝╚═╝╚═╝░░╚═╝╚══════╝
]]--

local Label_Trial_Easy = Trial:CreateLabel('Trial Easy')

local Farm_Trial = Trial:CreateToggle('Auto Farm Trial (Fast)', false, Color3.fromRGB(0, 125, 255), 0.25, function(bool)
    _G.Farm_Trial_Fast = bool
    while _G.Farm_Trial_Fast do task.wait()
        Farm_Trial_Fast()
    end
end)

local Farm_Trial = Trial:CreateToggle('Auto Farm Trial (Normal)', false, Color3.fromRGB(0, 125, 255), 0.25, function(bool)
    _G.Farm_Trial = bool
    while _G.Farm_Trial do task.wait()
        Farm_Trial()
    end
end)


local Join_Trial = Trial:CreateToggle('Auto Join Trial', false, Color3.fromRGB(0, 125, 255), 0.25, function(bool)
    _G.Join_Trial = bool
    while _G.Join_Trial do task.wait()
        Join_Trial(workspace.Server.Trial.Lobby.Easy_Screen.Frame:FindFirstChild("Value"), "Easy_Trial")
    end
end)

--[[

    ██████╗░██╗░░░██╗███╗░░██╗░██████╗░███████╗░█████╗░███╗░░██╗
    ██╔══██╗██║░░░██║████╗░██║██╔════╝░██╔════╝██╔══██╗████╗░██║
    ██║░░██║██║░░░██║██╔██╗██║██║░░██╗░█████╗░░██║░░██║██╔██╗██║
    ██║░░██║██║░░░██║██║╚████║██║░░╚██╗██╔══╝░░██║░░██║██║╚████║
    ██████╔╝╚██████╔╝██║░╚███║╚██████╔╝███████╗╚█████╔╝██║░╚███║
    ╚═════╝░░╚═════╝░╚═╝░░╚══╝░╚═════╝░╚══════╝░╚════╝░╚═╝░░╚══╝
]]--

local Label_Trial_Dungeon = Trial:CreateLabel('Dungeon')

local Dungeon_Fast = Trial:CreateToggle('Auto Farm Dungeon (Fast)', false, Color3.fromRGB(0, 125, 255), 0.25, function(bool)
    _G.Dungeon_Fast = bool
    while _G.Dungeon_Fast do task.wait()
        Dungeon_Fast()
    end
end)

local Dungeon_Farm = Trial:CreateToggle('Auto Farm Dungeon (Normal)', false, Color3.fromRGB(0, 125, 255), 0.25, function(bool)
    _G.Dungeon_Farm = bool
    while _G.Dungeon_Farm do task.wait()
        Dungeon_Farm()
    end
end)


local Join_Dungeon = Trial:CreateToggle('Auto Join Dungeon)', false, Color3.fromRGB(0, 125, 255), 0.25, function(bool)
    _G.Join_Dungeon = bool
    while _G.Join_Dungeon do task.wait()
        Join_Trial(workspace.Server.Trial.Lobby.Dungeon_Screen.Frame:FindFirstChild("Value"), "Trial_Dungeon")
    end
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

local Label_Custom_Farm = D_Stack:CreateLabel('Custom Farm')

local Auto_CFarm = D_Stack:CreateToggle('Auto Farm Set Mob)', false, Color3.fromRGB(0, 125, 255), 0.25, function(bool)
    _G.Auto_CFarm = bool
    while _G.Auto_CFarm do task.wait()
        Farm_MS()
    end
end)

local Set_Mob = D_Stack:CreateButton('Set Mob', function()
    local mob = Get_Mob()
    if mob then
        Create_WayPoint('Mob', mob.CFrame)
        Notify('Custom Farm', "Created Waypoint " .. mob.Name, 1)
    else
        Notify('Custom Farm', "No nearby mob found", 1)
    end
end)

local Start_SetMob = D_Stack:CreateButton('Start', function()
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

local Passives_UI = UI:CreateToggle('Passive Reroll', false, Color3.fromRGB(0, 125, 255), 0.25, function(bool)
    Open_UI(bool, 'Passives')
end)

local Curses_UI = UI:CreateToggle('Cursed', false, Color3.fromRGB(0, 125, 255), 0.25, function(bool)
    Open_UI(bool, 'Curses')
end)

local Merchant_UI = UI:CreateToggle('Merchant', false, Color3.fromRGB(0, 125, 255), 0.25, function(bool)
    Open_UI(bool, 'Merchant')
end)

local Evolve_UI = UI:CreateToggle('Evolve', false, Color3.fromRGB(0, 125, 255), 0.25, function(bool)
    Open_UI(bool, 'Evolve')
end)


Notify('Syn0xz Hub', 'Hub is loaded', 3)
AFK()
