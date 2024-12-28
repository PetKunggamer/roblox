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
local char = lp.Character
local hrp = char:FindFirstChild("HumanoidRootPart")
local Current_Level = tonumber(game:GetService("Players").LocalPlayer.PlayerGui.Main.Frame.BottomLeft.Menu.TextLabel.Text)
local Level = tonumber(Current_Level + 1)
local EXP = tonumber((Level*Level) * 48)
local Money = tonumber(Level*100)
local GuiService = game:GetService('GuiService')
local VirtualInputManager = game:GetService('VirtualInputManager')
local RS = game:GetService("ReplicatedStorage")





local function Get_Loot()
    local hrp = game:GetService('Players').LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if hrp then
        local chest = nil
        for i,v in ipairs(workspace.Objects.Drops:GetChildren()) do
            if v:IsA("Model") then
                local Root = v:FindFirstChild("Root")
                if Root then
                    local mag = (Root.Position - hrp.Position).magnitude
                    if mag < 30 then
                        local proximity = v:FindFirstChild("Collect")
                        if proximity then
                            chest = proximity
                        end
                    end
                end
            end
        end
        if chest then
            fireproximityprompt(chest)
        end
    end
end

local function Auto_Loot()
    local flip_button = game:GetService("Players").LocalPlayer.PlayerGui.Loot.Frame:FindFirstChild("Flip")
Get_Loot()
    wait(.125)
    if flip_button.Visible then
        task.wait(.001)
        GuiService.SelectedCoreObject = flip_button
        VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.Return, false, game)
        VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.Return, false, game)
    end
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

local function low_fps(num)
    if iswindowactive() then
        setfpscap(1000) 
    else 
        setfpscap(num) 
    end
end

local function Check_Level()
    local Level = tonumber(game:GetService("Players").LocalPlayer.PlayerGui.Main.Frame.BottomLeft.Menu.TextLabel.Text)
    if Level == 1 or Level < 60 then
        return {
            Location = "Shijo Town Set",
            Grade = "Non Sorcerer",
            Essence = "2"
        }
    elseif Level > 59 and Level < 120 then
        return {
            Location = "Umi Village Set",
            Grade = "Non Sorcerer",
            Essence = "2"
        }
    elseif Level > 119 and Level < 180 then
        return {
            Location = "Numa Temple Set",
            Grade = "Non Sorcerer",
            Essence = "4"
        }
    elseif Level > 179 and Level < 240 then
        return {
            Location = "Kura Camp Set",
            Grade = "Non Sorcerer",
            Essence = "8"
        }
    elseif Level > 240 then
        return {
            Location = "Yuki Fortress Set",
            Grade = "Non Sorcerer",
            Essence = "12"
        }
    end
    return
end

local function Find_Mob_Quest()
    local Current_Level = tonumber(game:GetService("Players").LocalPlayer.PlayerGui.Main.Frame.BottomLeft.Menu.TextLabel.Text)
    local Level = tonumber(Current_Level + 1)
    local mob = nil
    for _, v in ipairs(workspace.Objects.Mobs:GetChildren()) do
        if v:IsA("Model") then
            local target = v:FindFirstChild("HumanoidRootPart")
            if target then
                local healthObj = target:FindFirstChild("Health")
                if healthObj then
                    local mob_level = healthObj:FindFirstChild("Level")
                    if mob_level then
                        if mob_level.Text:sub(6) == tostring(Level) then
                            mob = target
                        end
                    end
                end
            end
        end
    end
    return mob
end

local function Get_Quest()
    local Current_Level = tonumber(game:GetService("Players").LocalPlayer.PlayerGui.Main.Frame.BottomLeft.Menu.TextLabel.Text)
    local Level = tonumber(Current_Level + 1)
    local EXP = tonumber((Level*Level) * 48)
    local Money = tonumber(Level*100)
    local Data = Check_Level()
    local args = {
        [1] = {
            ["type"] = "Kill",
            ["set"] = Data.Location,
            ["rewards"] = {
                ["essence"] = tonumber(Data.Essence),
                ["cash"] = Money,
                ["exp"] = EXP,
                ["chestMeter"] = 75
            },
            ["rewardsText"] = "$"..Money.."| "..EXP.." EXP",
            ["difficulty"] = 10,
            ["title"] = "Syn0xz ",
            ["level"] = Level,
            ["subtitle"] = "Hub",
            ["grade"] = Data.Grade
        }
    }
    game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Server"):WaitForChild("Data"):WaitForChild("AcceptQuest"):InvokeServer(unpack(args))
end

local function Auto_Mission()
    Get_Quest()
    wait(2)
    RS:WaitForChild("Remotes"):WaitForChild("Server"):WaitForChild("Combat"):WaitForChild("Skydive"):FireServer(game:GetService("Players").LocalPlayer.ReplicatedTempData:FindFirstChild("quest"))
    wait(2)
    if Find_Mob_Quest() then
        game:GetService('Players').LocalPlayer.Character:FindFirstChild("HumanoidRootPart").CFrame = Find_Mob_Quest().CFrame * CFrame.new(0,250,0)
    end
    wait(15)
end

local function Instant()
    local hrp = game:GetService('Players').LocalPlayer.Character:WaitForChild("HumanoidRootPart")  -- Ensures the HumanoidRootPart exists
    if hrp then
        local mob, dist = math.huge
        for _, v in ipairs(workspace.Objects.Mobs:GetChildren()) do
            if v:IsA("Model") then
                local target = v:FindFirstChild("HumanoidRootPart")
                if target then
                    local mag = (target.Position - hrp.Position).magnitude
                    local hum = v:FindFirstChild("Humanoid")
                    if hum and mag < 70 and hum.Health > 0 then
                        hum.Health = 0  -- Set health to 0 instead of nil to "kill" the mob
                    end
                end
            end
        end
    end
end

local function Auto_Claim_Chest()
    local Data = Check_Level()
    local args = {
        [1] = Data.Location
    }
    game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Server"):WaitForChild("Data"):WaitForChild("ChestMeterReward"):FireServer(unpack(args))
end

local function Promote()
    local args = {
        [1] = "Clan Head Jujutsu High",
        [2] = "Promote"
    }

    game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Server"):WaitForChild("Dialogue"):WaitForChild("GetResponse"):InvokeServer(unpack(args))
end

local function God_Mode()
    local RS = game:GetService("ReplicatedStorage")
    RS:WaitForChild("Remotes"):WaitForChild("Server"):WaitForChild("Combat"):WaitForChild("Skill"):FireServer("Infinity: Mugen")
    wait(5)
end

local function Kill_Aura()
    local hrp = game:GetService('Players').LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    for i,v in ipairs(workspace.Objects.Mobs:GetChildren()) do
        if v:IsA("Model") then
            local target = v:FindFirstChild("HumanoidRootPart")
            if target then
                local hum = v:FindFirstChild("Humanoid")
                if hum then
                    local mag = (hrp.Position - target.Position).magnitude
                    if mag < 70 then
                        local args = {
                            [1] = 4,
                            [2] = {
                                [1] = hum
                            }
                        }

                        game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Server"):WaitForChild("Combat"):WaitForChild("M1"):FireServer(unpack(args))
                    end
                end
            end
        end
    end
end

local function Spin_1()
local List = {
    "Infinity",
    "Demon Vessel",
    "Star Rage",
    "Gambler Fever",
    "Soul Manipulation",
    "Cursed Queen"
}

local Power_Slot = game:GetService("Players").LocalPlayer.ReplicatedData.innates:FindFirstChild("1")
    if Power_Slot then
        if not table.find(List, Power_Slot.Value) then
            local args = {
                [1] = 1
            }
            local response = game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Server"):WaitForChild("Data"):WaitForChild("InnateSpin"):InvokeServer(unpack(args))
            print(response)
            game:GetService("Players").LocalPlayer.PlayerGui.Customization.Frame.List.Innates["1"].Frame.TextLabel.Text = Power_Slot.Value
            else
            game:GetService("Players").LocalPlayer.PlayerGui.Customization.Frame.List.Innates["1"].Frame.TextLabel.Text = Power_Slot.Value
        end
    end
end

local function Spin_2()
local List = {
    "Infinity",
    "Demon Vessel",
    "Star Rage",
    "Gambler Fever",
    "Soul Manipulation",
    "Cursed Queen"
}

local Power_Slot = game:GetService("Players").LocalPlayer.ReplicatedData.innates:FindFirstChild("2")
    if Power_Slot then
        if not table.find(List, Power_Slot.Value) then
            local args = {
                [1] = 2
            }
            local response = game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Server"):WaitForChild("Data"):WaitForChild("InnateSpin"):InvokeServer(unpack(args))
            print(response)
            game:GetService("Players").LocalPlayer.PlayerGui.Customization.Frame.List.Innates["2"].Frame.TextLabel.Text = Power_Slot.Value
            else
            game:GetService("Players").LocalPlayer.PlayerGui.Customization.Frame.List.Innates["2"].Frame.TextLabel.Text = Power_Slot.Value
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
local Spin = section.new_sector('Spin [Menu]', 'Left')
local Misc = section.new_sector('Misc', 'Right')
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

local Instant = Farm.element('Toggle', 'Auto Instant Mob (Leveling)', false, function(v)
    _G.Instant = v.Toggle
    while _G.Instant do task.wait(.001)
        Instant()
    end
end)

local Auto_Mission = Farm.element('Toggle', 'Auto Mission (Leveling)', false, function(v)
    _G.Auto_Mission = v.Toggle
    while _G.Auto_Mission do task.wait(.001)
        Auto_Mission()
    end
end)

local Kill_Aura = Farm.element('Toggle', 'Kill Aura', false, function(v)
    _G.Kill_Aura = v.Toggle
    while _G.Kill_Aura do task.wait(.001)
        Kill_Aura()
    end
end)


local Spin_Slot1: any = Spin.element('Toggle', 'Spin Slot 1', false, function(v)
    _G.Spin_Slot1 = v.Toggle
    while _G.Spin_Slot1 do task.wait(.001)
        Spin_1()
    end
end)

local Spin_Slot2: any = Spin.element('Toggle', 'Spin Slot 2', false, function(v)
    _G.Spin_Slot2 = v.Toggle
    while _G.Spin_Slot2 do task.wait(.001)
        Spin_2()
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



local Auto_Claim_Chest = Misc.element('Toggle', 'Auto Claim Chest', false, function(v)
    _G.Auto_Claim_Chest = v.Toggle
    while _G.Auto_Claim_Chest do task.wait(.001)
        Auto_Claim_Chest()
    end
end)


local Auto_Loot = Misc.element('Toggle', 'Auto Loot', false, function(v)
    _G.Auto_Loot = v.Toggle
    while _G.Auto_Loot do task.wait(.001)
        Auto_Loot()
    end
end)

local Promote = Misc.element('Toggle', 'Auto Promote', false, function(v)
    _G.Promote = v.Toggle
    while _G.Promote do task.wait(.001)
        Promote()
    end
end)

local God_Mode = Misc.element('Toggle', 'Auto GodMode', false, function(v)
    _G.God_Mode = v.Toggle
    while _G.God_Mode do task.wait(.001)
        God_Mode()
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


local Shop = TP.element('Button', 'Teleport to Lobby', false, function()
    game:GetService('Players').LocalPlayer.Character:FindFirstChild("HumanoidRootPart").CFrame = CFrame.new(-405, 4480, -15612)
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


Notify('Syn0xz Hub', 'Hub is loaded', 3)
AFK()
