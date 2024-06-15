local vu = game:GetService("VirtualUser")
game:GetService("Players").LocalPlayer.Idled:connect(function()
   vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
   wait(1)
   vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
end)

local function Quest(Mob)
    game:GetService("ReplicatedStorage"):WaitForChild("ReplicatedModules"):WaitForChild("KnitPackage"):WaitForChild("Knit"):WaitForChild("Services"):WaitForChild("DialogueService"):WaitForChild("RF"):WaitForChild("CheckDialogue"):InvokeServer("Slayer_Quest",Mob)
end

local function teleport(Spot)
    local root = game.Players.LocalPlayer.Character.HumanoidRootPart
    root.Velocity = Vector3.new(0,0,0)
    if Spot == "Park" then
        root.CFrame = CFrame.new(2060, 974, 337)
    end
    if Spot == "Port" then
        root.CFrame = CFrame.new(2012, 993, 1087)
    end
    if Spot == "Curse" then
        root.CFrame = CFrame.new(1976, 931, -1531)
    end
    if Spot == "Floating Island" then
        root.CFrame = CFrame.new(1209, 1011, -317)
    end

    root.Anchored = true
    wait(.25)
    root.Anchored = false
end

local function Cmdr()
    local Gui = game:GetService("Players").LocalPlayer.PlayerGui
    if Gui then
        local Cmdr = Gui:FindFirstChild("Cmdr")
        if Cmdr then
            Cmdr:Destroy()
        end
    end
end

local function NO_CHESTUI()
    for i,v in ipairs(game:GetService("Players").LocalPlayer.PlayerGui:GetChildren()) do
        if v:IsA("ScreenGui") then
            if v.Name == "UI" then
                local GP = v:FindFirstChild("Gameplay")
                if GP then
                    local CR = GP:FindFirstChild("ChestRoll")
                    if CR then
                        if CR.Visible == true then
                            CR.Visible = false
                        end
                    end
                end
            end
        end
    end
end

local function Effects()
    for i,v in ipairs(Workspace.Effects:GetChildren()) do
        v:Destroy()    
    end
end

local function Skill_E()
    local Skill = {"E","END-E"}
    for i,v in pairs(Skill) do
        local args = {
            [1] = v
        }

        game:GetService("ReplicatedStorage"):WaitForChild("ReplicatedModules"):WaitForChild("KnitPackage"):WaitForChild("Knit"):WaitForChild("Services"):WaitForChild("MoveInputService"):WaitForChild("RF"):WaitForChild("FireInput"):InvokeServer(unpack(args))
    end
end

local function GetChest()
    local Players = game:GetService("Players")
    local Char = Players.LocalPlayer.Character
    local root = Char:FindFirstChild("HumanoidRootPart")
    local dist, chest = math.huge
    for i,v in ipairs(Workspace:GetChildren()) do
        if v:IsA("Model") then
            if v.Name == "Common" or v.Name == "Rare" or v.Name == "Epic" or v.Name == "Legendary" and v.Parent then
                local RP = v:FindFirstChild("RootPart")
                if RP then
                    local mag = (root.Position - RP.Position).magnitude
                    if mag < dist then
                        chest = RP
                    end
                end
            end
        end
    end
    return chest
end

local function GetChest_Interaction()
    local Players = game:GetService("Players")
    local Char = Players.LocalPlayer.Character
    local root = Char:FindFirstChild("HumanoidRootPart")
    local dist, chest = math.huge
    for i,v in ipairs(Workspace:GetChildren()) do
        if v:IsA("Model") then
            if v.Name == "Common" or v.Name == "Rare" or v.Name == "Epic" or v.Name == "Legendary" and v.Parent then
                local RP = v:FindFirstChild("RootPart")
                if RP then
                    local mag = (root.Position - RP.Position).magnitude
                    if mag < dist then
                        local ProximityAttachment = RP:FindFirstChild("ProximityAttachment")
                        if ProximityAttachment then
                            local Interaction = ProximityAttachment:FindFirstChild("Interaction")
                            if Interaction then
                                chest = Interaction
                            end
                        end
                    end
                end
            end
        end
    end
    return chest
end

local function Collect_Chest()
    local Chest = GetChest()
    local root = game.Players.LocalPlayer.Character.HumanoidRootPart
    if Chest then
        local ProximityAttachment = Chest:FindFirstChild("ProximityAttachment")
        if ProximityAttachment then
            local Interaction = ProximityAttachment:FindFirstChild("Interaction")
            if Interaction then
                root.CFrame = Chest.CFrame * CFrame.new(0,-10,0)
                fireproximityprompt(Interaction)
            end
        end
    end
end

local function Collect_Chest_PC()
    local Chest = GetChest()
    local root = game.Players.LocalPlayer.Character.HumanoidRootPart
    if Chest then
        local ProximityAttachment = Chest:FindFirstChild("ProximityAttachment")
        if ProximityAttachment then
            local Interaction = ProximityAttachment:FindFirstChild("Interaction")
            if Interaction then
                root.CFrame = Chest.CFrame * CFrame.new(0,0,0)
                local VirtualInputManager = game:GetService("VirtualInputManager")
                VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.E, false, game)
                VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.E, false, game)
            end
        end
    end
end

local function Instant()
    for _, v in ipairs(game.Workspace.Living:GetChildren()) do
        local root = game.Players.LocalPlayer.Character.HumanoidRootPart
        local target = v:FindFirstChild("HumanoidRootPart")
        local hum = v:FindFirstChild("Humanoid")
        if target and hum and v.Name ~= game.Players.LocalPlayer.Character.Name then
            local dist = (target.Position - root.Position).magnitude
            if dist < 500 then
                if (hum.Health / hum.MaxHealth) * 100 < 99 then
                    hum.Health = 0
                end
            end
        end
    end
end

local function Get_Mob_PC()
    pcall(function()
        for _, v in ipairs(game.Workspace.Living:GetChildren()) do
            local root = game.Players.LocalPlayer.Character.HumanoidRootPart
            local target = v:FindFirstChild("HumanoidRootPart")
            local hum = v:FindFirstChild("Humanoid")
            local Tags = v:FindFirstChild("Tags")
            if target and hum and Tags and v.Name ~= game.Players.LocalPlayer.Character.Name then
                local dist = (target.Position - root.Position).magnitude
                if GetChest_Interaction() then
                    Collect_Chest_PC()
                else
                    if target then
                        if dist < 500 and not GetChest_Interaction() then
                            root.CFrame = target.CFrame * CFrame.new(0, 25, 0) * CFrame.Angles(math.rad(270), math.rad(0), math.rad(0))
                            root.Velocity = Vector3.new(0,0,0)
                            Instant()
                        else
                            CFrame.new(1976, 931, -1531)
                        end
                    end
                end
            end
        end
    end)
end

local function Get_Mob()
    pcall(function()
        for _, v in ipairs(game.Workspace.Living:GetChildren()) do
            local root = game.Players.LocalPlayer.Character.HumanoidRootPart
            local target = v:FindFirstChild("HumanoidRootPart")
            local hum = v:FindFirstChild("Humanoid")
            local Tags = v:FindFirstChild("Tags")
            if target and hum and Tags and v.Name ~= game.Players.LocalPlayer.Character.Name then
                local dist = (target.Position - root.Position).magnitude
                if GetChest_Interaction() then
                    Collect_Chest()
                else
                    if target then
                        if dist < 500 and not GetChest_Interaction() then
                            root.CFrame = target.CFrame * CFrame.new(0, 25, 0) * CFrame.Angles(math.rad(270), math.rad(0), math.rad(0))
                            Instant()
                        else
                            CFrame.new(1976, 931, -1531)
                        end
                    end
                end
            end
        end
    end)
end

game:GetService("UserInputService").InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.L then
        if game:GetService("CoreGui"):FindFirstChild("unknown") then
            game:GetService("CoreGui"):FindFirstChild("unknown").Enabled = not game:GetService("CoreGui"):FindFirstChild("unknown").Enabled
        end
    end
end)

local function GOTO_BM()
    local waypoints = {
        CFrame.new(2027, 1063, -777),
        CFrame.new(960, 1009, -445),
        CFrame.new(2026, 922, 1062),
        CFrame.new(2454, 982, 110)
    }
    

    
    local function findBlackMarket()
        return game:GetService("Workspace").NPCS:FindFirstChild("Black Market")
    end
    
    local function teleportTo(cframe)
        local hrp = game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if hrp then
            hrp.CFrame = cframe
        end
    end
    
    local function clickUiButton(v, state)
        local VirtualInputManager = game:GetService('VirtualInputManager')
        VirtualInputManager:SendMouseButtonEvent(v.AbsolutePosition.X + v.AbsoluteSize.X / 2, v.AbsolutePosition.Y + 50, 0, state, game, 1)
    end
    
    local function interactWithBM()
        local BM = findBlackMarket()
        if BM and BM:FindFirstChild("HumanoidRootPart") then
            teleportTo(BM.HumanoidRootPart.CFrame * CFrame.new(0, 5, 0))
            wait(1)
            fireproximityprompt(BM.HumanoidRootPart:FindFirstChild("Attachment"):FindFirstChild("Interaction"))
    
            -- Click the UI Button
            local Respon = game:GetService("Players").LocalPlayer.PlayerGui.DialogueGUI.Frame.ResponseFrame.Page.ResponseIMG
            clickUiButton(Respon, true)
            clickUiButton(Respon, false)
    
            return true
        end
        return false
    end
    
    local hrp = game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    local oldpos = hrp and hrp.CFrame
    
    if interactWithBM() then
        return
    end
    
    if hrp then
        local foundBM = false
        for _, waypoint in ipairs(waypoints) do
            teleportTo(waypoint)
            wait(0.45)
            if interactWithBM() then
                foundBM = true
                break
            end
        end
        if not foundBM then
            teleportTo(oldpos)
        end
    end    
end

local A = game:GetService("CoreGui"):FindFirstChild("unknown")
if A then
    A:Destroy()
end

Cmdr()
local library = loadstring(game:HttpGet('https://raw.githubusercontent.com/cueshut/saves/main/criminality%20paste%20ui%20library'))()

-- // Window \\ --
local window = library.new('Syn0xz Hub', 'Syn0xz')

-- // Tabs \\ --
local tab = window.new_tab('rbxassetid://4483345998')

-- // Sections \\ --
local section = tab.new_section('- Main -')
local section2 = tab.new_section('- Teleport -')

-- // Sector \\ --
local Main = section.new_sector('= Main =', 'Left')
local Boss_Quest = section.new_sector('= Boss Quest =', 'Left')
local Misc = section.new_sector('= Misc =', 'Right')
local Misc2 = section.new_sector('= Misc 2 =', 'Right')
local Skill = section.new_sector('= Attack =', 'Right')

-- // Sector2 \\ --
local TP = section2.new_sector('= Teleport =', 'Right')

local Auto_Farm = Main.element('Toggle', 'Auto Farm', false, function(v)
    _G.Auto_Farm = v.Toggle
    while _G.Auto_Farm do task.wait()
        Get_Mob()
    end
end) 

local Auto_Farm = Main.element('Toggle', 'Auto Farm (Solara)', false, function(v)
    _G.Auto_Farm = v.Toggle
    while _G.Auto_Farm do task.wait()
        Get_Mob_PC()
    end
end) 

local Skill_E = Skill.element('Toggle', 'Auto Skill E', false, function(v)
    _G.Auto_E = v.Toggle
    while _G.Auto_E do task.wait()
        Skill_E()
    end
end) 

local Instant = Misc.element('Toggle', 'Instant Kill', false, function(v)
    _G.Instant = v.Toggle
    while _G.Instant do wait()
        Instant()
    end
end) 

local Effect = Misc.element('Toggle', 'No Effects', false, function(v)
    _G.Auto_E = v.Toggle
    while _G.Auto_E do wait()
        Effects()
    end
end) 

local NO_CHESTUI = Misc.element('Toggle', 'No ChestUI', false, function(v)
    _G.NO_CHESTUI = v.Toggle
    while _G.NO_CHESTUI do wait()
        NO_CHESTUI()
    end
end) 

local NO_CHESTUI = Boss_Quest.element('Toggle', 'Quest Gojo', false, function(v)
    _G.NO_CHESTUI = v.Toggle
    while _G.NO_CHESTUI do wait()
        Quest("Gojo")
    end
end) 

local Go_Black = Misc2.element('Button', 'TP Black Market', false, function()
    GOTO_BM()
end)

local Roll_10 = Misc2.element('Button', 'Roll_10 Gacha', false, function()
    local args = {
        [1] = 1,
        [2] = "UShards",
        [3] = 10
    }

    game:GetService("ReplicatedStorage"):WaitForChild("ReplicatedModules"):WaitForChild("KnitPackage"):WaitForChild("Knit"):WaitForChild("Services"):WaitForChild("ShopService"):WaitForChild("RF"):WaitForChild("RollBanner"):InvokeServer(unpack(args))
end)

local TP1 = TP.element('Button', 'Park', false, function()
    teleport('Park')
end) 

local TP2 = TP.element('Button', 'Port', false, function()
    teleport('Port')
end) 

local TP3 = TP.element('Button', 'Curse', false, function()
    teleport('Curse')
end) 

local TP4 = TP.element('Button', 'Floating Island', false, function()
    teleport('Floating Island')
end) 
