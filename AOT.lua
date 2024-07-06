repeat task.wait() until game:IsLoaded()
wait(1)
pcall(function()
local PlaceId = game.PlaceId
if PlaceId == 13379349730 or PlaceId == 14638336319 or PlaceId == 14012874501 or PlaceId == 13904207646 or PlaceId == 13379208636 then

_G.Webhook = getgenv().Webhook

local A = game:GetService("CoreGui"):FindFirstChild("unknown")
if A then
    A:Destroy()
end

game:GetService("UserInputService").InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.L then
        if game:GetService("CoreGui"):FindFirstChild("unknown") then
            game:GetService("CoreGui"):FindFirstChild("unknown").Enabled = not game:GetService("CoreGui"):FindFirstChild("unknown").Enabled
        end
    end
end)

function SpamClick(v, add)
    local VirtualInputManager = game:GetService('VirtualInputManager')
    local x = v.AbsolutePosition.X + v.AbsoluteSize.X / 2
    local y = v.AbsolutePosition.Y + v.AbsoluteSize.Y / 2 + (50 + add)
    VirtualInputManager:SendMouseButtonEvent(x, y, 0, true, game, 1)
    wait(.1)
    VirtualInputManager:SendMouseButtonEvent(x, y, 0, false, game, 1)
end

local function Chest_Reward()
    local PlayerGui = game.Players.LocalPlayer:FindFirstChild("PlayerGui")
    if PlayerGui then
        local Interface = PlayerGui:FindFirstChild("Interface")
        if Interface then
            local ChestUI = Interface:FindFirstChild("Chests")
            if ChestUI and ChestUI.Visible then
                return ChestUI
            end
        end
    end
end

local function OpenChest()
if Chest_Reward() then
    local Free = Chest_Reward():FindFirstChild("Free")
    local Finish = Chest_Reward():FindFirstChild("Finish")
    
        if Free.Visible then
            SpamClick(Free, 30) 
            SpamClick(Free, 20) 
            SpamClick(Free, 10) 
            SpamClick(Free, 0) 
            SpamClick(Free, -10)
            SpamClick(Free, -20)
            SpamClick(Free, -30)
        else
            SpamClick(Finish, 30) 
            SpamClick(Finish, 20) 
            SpamClick(Finish, 10) 
            SpamClick(Finish, 0) 
            SpamClick(Finish, -10)
            SpamClick(Finish, -20)
            SpamClick(Finish, -30)
        end
    end
end

local function getRewards()
    _G.Ended = true
    local PlayerGui = game:GetService("Players").LocalPlayer.PlayerGui
    if PlayerGui then
        local Interface = PlayerGui:FindFirstChild("Interface")
        if Interface then
            local Rewards = Interface:FindFirstChild("Rewards")
            if Rewards then
                local Main1 = Rewards:FindFirstChild("Main")
                if Main1 then
                    local Info = Main1:FindFirstChild("Info")
                    if Info and Info.Visible == true then
                        local Main = Info:FindFirstChild("Main")
                        if Main then
                            return Main
                        end
                    end
                end
            end
        end
    end
end
local function GetButton_Text()
    return getRewards():FindFirstChild("Buttons"):FindFirstChild("Retry"):FindFirstChild("Title").Text
end

local function webhooks(url_link)
    local url = url_link
    if getRewards() then
        local function sendMessageEmbed(url, embed)
            local http = game:GetService("HttpService")
            local data = {
                ["embeds"] = { embed }
            }
            local body = http:JSONEncode(data)
            request({
                Url = url,
                Method = "POST",
                Headers = { ["Content-Type"] = "application/json" },
                Body = body
            })
        end
    
        local function getDrop() 
            local Drop = {}
            local Perk = {}
            local Rewards = getRewards()
            local Items = Rewards:FindFirstChild("Items")
            local function getItemQuantity(name)
                return Items:FindFirstChild(name):FindFirstChild("Main"):FindFirstChild("Inner"):FindFirstChild("Quantity").Text
            end
    
            local Gold = getItemQuantity("Gold")
            local XP = getItemQuantity("XP")
            local BP_XP = getItemQuantity("BP_XP")
    
            for _, v in ipairs(Items:GetChildren()) do
                if v:IsA("Frame") then
                    if v.Name == "Gold" then
                        table.insert(Drop, "- GOLD : " .. Gold .. "\n")
                    elseif v.Name == "XP" then
                        table.insert(Drop, "- XP : " .. XP .. "\n")
                    elseif v.Name == "Gems" then
                        table.insert(Drop, "- GEM : " .. GEM .. "\n")
                    elseif v.Name == "BP_XP" then
                        table.insert(Drop, "- Battle Pass : " .. BP_XP .. "\n")
                    elseif v.Name:find("Perk") then
                        table.insert(Drop, "- PERK : " .. v.Name .. "\n")
                    elseif not v.Name:find("Grid") then
                        table.insert(Drop, "- Secret : **" .. v.Name .. "**\n")
                    end
                end
            end
            return table.concat(Drop)
        end
    
        local function getPerk() 
            local Perk = {}
            local Rewards = getRewards()
            local Items = Rewards:FindFirstChild("Items")
            for _, v in ipairs(Items:GetChildren()) do
                if v:IsA("Frame") then
                    if v.Name:find("Perk") then
                        table.insert(Perk, "- PERK : " .. v.Name .. "\n")
                    end
                end
            end
            return table.concat(Perk)
        end
    
        local function PlayerData() 
            local PlayerData = {}
            return table.concat(PlayerData)
        end
    
        local Time = getRewards():WaitForChild("Stats"):WaitForChild("Time_Taken"):WaitForChild("Amount").Text
        local embed = {
            title = "Completed Mission :white_check_mark: ",
            description = ":clock1: Total Time : " .. Time,
            color = 65280, -- green
            fields = {
                { name = ":flushed: Username :", value = game.Players.LocalPlayer.Character.Name },
                { name = "Player Information", value = PlayerData() },
                { name = "Result Drop :", value = getDrop(), inline = true },
                { name = "Perk Drop :", value = getPerk(), inline = true }
            },
            footer = { text = "เวลา : " .. os.date("%H:%M:%S", os.time() + (-1) * 60 * 60) }
        }
    
        sendMessageEmbed(url, embed)
        end
    end

local function Redeem_Code()
    local List = {"LIKES90K", "LIKES100K", "MEMBERS200K"}
    for i, v in ipairs(List) do
        local PlayerGui = game:GetService("Players").LocalPlayer.PlayerGui
        if PlayerGui then
            local Interface = PlayerGui:FindFirstChild("Interface")
            if Interface then
                local Title_Screen = Interface:FindFirstChild("Title_Screen")
                if Title_Screen then
                    local Codes = Title_Screen:FindFirstChild("Codes")
                    if not Codes.Visible then
                        clickUiButton(game:GetService("Players").LocalPlayer.PlayerGui.Interface.Title_Screen.Buttons.Codes, true)
                        clickUiButton(game:GetService("Players").LocalPlayer.PlayerGui.Interface.Title_Screen.Buttons.Codes, false)
                        wait(.5)
                    end
                    if Codes then
                        local Main = Codes:FindFirstChild("Main")
                        if Main then
                            local Code = Main:FindFirstChild("Code")
                            if Code then
                                local Interact = Code:FindFirstChild("Interact")
                                if Interact then
                                    Interact.Text = v
                                    clickUiButton(game:GetService("Players").LocalPlayer.PlayerGui.Interface.Title_Screen.Codes.Main.Redeem, true)
                                    clickUiButton(game:GetService("Players").LocalPlayer.PlayerGui.Interface.Title_Screen.Codes.Main.Redeem, false)
                                    wait(.65)
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end

local function Anti_Grab()
   local VirtualInputManager = game:GetService("VirtualInputManager")
   local PlayerGui = game:GetService("Players").LocalPlayer.PlayerGui
   if PlayerGui then
      local Interface = PlayerGui:FindFirstChild("Interface")
      if Interface then
         local Buttons = Interface:FindFirstChild("Buttons")
         if Buttons then
            for i, Key in ipairs(game:GetService("Players").LocalPlayer.PlayerGui.Interface.Buttons:GetChildren()) do
                VirtualInputManager:SendKeyEvent(true, Enum.KeyCode[Key.Name], false, game)
                VirtualInputManager:SendKeyEvent(false, Enum.KeyCode[Key.Name], false, game)
            end
         end
      end
   end
end

function clickUiButton(v, state)
    local VirtualInputManager = game:GetService('VirtualInputManager')
    VirtualInputManager:SendMouseButtonEvent(v.AbsolutePosition.X + v.AbsoluteSize.X / 2, v.AbsolutePosition.Y + 50, 0, state, game, 1)
end

local function Roll()
    local PlayerGui = game:GetService("Players").LocalPlayer.PlayerGui
    if PlayerGui then
        local Interface = PlayerGui:FindFirstChild("Interface")
        if Interface then
            local Customisation = Interface:FindFirstChild("Customisation")
            if Customisation then
                local Family = Customisation:FindFirstChild("Family")
                if Family then
                    local Buttons_2 = Family:FindFirstChild("Buttons_2")
                    if Buttons_2 then
                        local Roll = Buttons_2:FindFirstChild("Roll")
                        if Roll then
                            SpamClick(Roll, 30) 
                            SpamClick(Roll, 20) 
                            SpamClick(Roll, 10) 
                            SpamClick(Roll, 0) 
                            SpamClick(Roll, -10)
                            SpamClick(Roll, -20)
                            SpamClick(Roll, -30)
                        end
                    end
                end
            end
        end
    end
end

local function Get_Clan()
    local PlayerGui = game:GetService("Players").LocalPlayer.PlayerGui
    if PlayerGui then
        local Interface = PlayerGui:FindFirstChild("Interface")
        if Interface then
            local Customisation = Interface:FindFirstChild("Customisation")
            if Customisation then
                local Family1 = Customisation:FindFirstChild("Family")
                if Family1 then
                    local Family = Family1:FindFirstChild("Family")
                    if Family then
                        local Title = Family:FindFirstChild("Title")
                        if Title then
                            return Title.Text
                        end
                    end
                end
            end
        end
    end
end

local function Finding_Clan()
    local Family = Get_Clan()
    if Family:find("YEAGER") or Family:find("ACKERMAN") or Family:find("REISS") then
        print("Found")
        _G.A = false
    else
        print("Rolled : ", Family)
        Roll()
        wait(3.75)
    end
end

local function Attack_Titan()
    local Objective = game.Workspace.Unclimbable:FindFirstChild("Objective")
    if Objective then
        local Defend_Eren = Objective:FindFirstChild("Defend_Eren")
        if Defend_Eren then
            local Attack_Titan = Defend_Eren:FindFirstChild("Attack_Titan")
            if Attack_Titan then
                local Eren = Attack_Titan:FindFirstChild("HumanoidRootPart")
                if Eren then
                    return Eren
                else
                    return
                end
            end
        end
    end
end

local function Get_Mob()
    local root
    if Attack_Titan() then
        root = Attack_Titan()
    else
        root = game.Players.LocalPlayer.Character.HumanoidRootPart
    end

    local dist, mob = math.huge
    for i, v in ipairs(workspace.Titans:GetChildren()) do
        if v:IsA("Model") and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") then
            local mag = (root.Position - v:FindFirstChild("HumanoidRootPart").Position).magnitude
            if mag < dist then
                local Hitboxes = v:FindFirstChild("Hitboxes")
                if Hitboxes then
                    local Hit = Hitboxes:FindFirstChild("Hit")
                    if Hit then
                        local target = Hit:FindFirstChild("Nape")
                        if target then
                            mob = target
                            dist = mag
                        end
                    end
                end
            end
        end
    end
    return mob
end

local function Check_Sword()
    local plrName = game.Players.LocalPlayer.Character.Name
    local LeftHand = workspace.Characters[plrName]["Rig_"..plrName].LeftHand.Blade_1.Transparency
    local RightHand = workspace.Characters[plrName]["Rig_"..plrName].RightHand.Blade_1.Transparency
    if LeftHand == 1 or RightHand == 1 then
        local VirtualInputManager = game:GetService("VirtualInputManager")
        VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.R, false, game)
        VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.R, false, game)
    end
end

function clickUiButton(v, state)
    local VirtualInputManager = game:GetService('VirtualInputManager')
    local x = v.AbsolutePosition.X + v.AbsoluteSize.X / 2
    local y = v.AbsolutePosition.Y + v.AbsoluteSize.Y / 2 + 50
    VirtualInputManager:SendMouseButtonEvent(x, y, 0, state, game, 1)
end

function clickUiButtonV2(v, state, add)
    local VirtualInputManager = game:GetService('VirtualInputManager')
    local x = v.AbsolutePosition.X + v.AbsoluteSize.X / 2
    local y = v.AbsolutePosition.Y + v.AbsoluteSize.Y / 2 + (50 + add)
    VirtualInputManager:SendMouseButtonEvent(x, y, 0, state, game, 1)
end

local function Retry()
    pcall(function()
    local PlayerGui = game:GetService("Players").LocalPlayer.PlayerGui
        if PlayerGui then
            local Interface = PlayerGui:FindFirstChild("Interface")
            if Interface then
                local Rewards = Interface:FindFirstChild("Rewards")
                if Rewards and Rewards.Visible then
                    local Main1 = Rewards:FindFirstChild("Main")
                    if Main1 then
                        local Info = Main1:FindFirstChild("Info")
                        if Info then
                            local Main = Info:FindFirstChild("Main")
                            if Main then
                                local Buttons = Main:FindFirstChild("Buttons")
                                if Buttons then 
                                    local RetryButton = Buttons:FindFirstChild("Retry")
                                    if RetryButton then
                                        clickUiButton(RetryButton, true) wait(.65)
                                        clickUiButton(RetryButton, false) wait(.65)
                                        clickUiButtonV2(RetryButton, true, -10)  wait(.65) 
                                        clickUiButtonV2(RetryButton, false, -10) wait(.65)
                                        clickUiButtonV2(RetryButton, true, -20)  wait(.65) 
                                        clickUiButtonV2(RetryButton, false, -20) wait(.65)
                                        clickUiButtonV2(RetryButton, true, -30)  wait(.65) 
                                        clickUiButtonV2(RetryButton, false, -30) wait(.65)
                                        clickUiButtonV2(RetryButton, true, -40)  wait(.65) 
                                        clickUiButtonV2(RetryButton, false, -40) wait(.65)     
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end)
end

local function Hit()
    Check_Sword()
    wait(.125)
    local player = game.Players.LocalPlayer
    local screenGui = Instance.new("ScreenGui")
    screenGui.Parent = player:WaitForChild("PlayerGui")

    local screenWidth = screenGui.AbsoluteSize.X
    local screenHeight = screenGui.AbsoluteSize.Y

    local centerX = screenWidth / 2
    local centerY = screenHeight / 2

    game:GetService("VirtualInputManager"):SendMouseButtonEvent(centerX, centerY, 0, true, game, 1)
    wait(0.1)
    game:GetService("VirtualInputManager"):SendMouseButtonEvent(centerX, centerY, 0, false, game, 1)
end   

local function setNoclip(state)
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    for _, part in pairs(character:GetDescendants()) do
        if part:IsA("BasePart") and part.CanCollide then
            part.CanCollide = not state
        end
    end
end

local function Hook(state)
    local VirtualInputManager = game:GetService("VirtualInputManager")
    VirtualInputManager:SendKeyEvent(state, Enum.KeyCode.E, false, game)
    VirtualInputManager:SendKeyEvent(state, Enum.KeyCode.Q, false, game)
end

local function tp(CF)
    local TweenService = game:GetService("TweenService")
    local plr = game.Players.LocalPlayer
    local chr = plr.Character or plr.CharacterAdded:Wait()
    local root = chr:WaitForChild("HumanoidRootPart")
    if chr then
        local root = plr.Character:FindFirstChild("HumanoidRootPart")
        if root then
            _G.Tween = true

            local Lock = Instance.new("BodyVelocity")
            Lock.MaxForce = Vector3.new(9e9,9e9,9e9)
            Lock.Velocity = Vector3.new(0,0,0)
            Lock.Parent = root

            local distance = (root.Position - CF.Position).magnitude
            local duration = distance / getgenv().Speed
            local tweenInfo = TweenInfo.new(
                duration,  -- Duration based on distance and speed
                Enum.EasingStyle.Linear  -- Linear easing for consistent speed
            )

            setNoclip(true)
            
            local tween = TweenService:Create(root, tweenInfo, {CFrame = CF})
            tween:Play()
            wait(.125)
            tween:Cancel()
            setNoclip(false)
            Lock:Destroy()
            root.Velocity = Vector3.new(0,0,0)
        end
    end
end

local function Get_Refill()
    local main = workspace:FindFirstChild("Unclimbable")
    if main then
        local Reloads = main:FindFirstChild("Reloads")
        if Reloads then
            local GasTanks = Reloads:FindFirstChild("GasTanks")
            if GasTanks then
                local Refill = GasTanks:FindFirstChild("Refill")
                if Refill then
                    return Refill
                else
                    return
                end
            end
        end
    end
end

local function Gen_Refill()
    if not Get_Refill() then
        local PlaceId = game.PlaceId
        if PlaceId == 13379349730 then -- [AOT:R] Shiganshina
            tp_refill(CFrame.new(510, 172, 771))
        end
        if PlaceId == 14638336319 then -- [AOT:R] Giant Forest
            tp_refill(CFrame.new(270, 17, -685))
        end
        if PlaceId == 14012874501 then -- [AOT:R] Trost
            tp_refill(CFrame.new(-952, 50, 148))
        end
        if PlaceId == 13904207646 then -- [AOT:R] Trost Outskirts
            tp_refill(CFrame.new(1866, 9, -76))
        end
    end
end

local function Refill()
    if Get_Refill() then 
        local root = game.Players.LocalPlayer.Character.HumanoidRootPart
        Hook(false)
        tp(Get_Refill().CFrame)
        local dist = (root.Position - Get_Refill().Position).magnitude
        if dist < 20 then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = Get_Refill().CFrame
            wait(1)
            root.Velocity = Vector3.new(0,0,0)
            local VirtualInputManager = game:GetService("VirtualInputManager")
            VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.R, false, game)
            VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.R, false, game)
            wait(2.5)
        else
            Gen_Refill()
        end
    end
end

local function Blade()
    local plrName = game.Players.LocalPlayer.Character.Name
    local LeftHand = workspace.Characters[plrName]["Rig_"..plrName].LeftHand.Blade_1.Transparency
    local RightHand = workspace.Characters[plrName]["Rig_"..plrName].RightHand.Blade_1.Transparency
    local Blade = game:GetService("Players").LocalPlayer.PlayerGui.Interface.HUD.Main.Top.Blade.Sets
    if Blade.Text == "0 / 3" and LeftHand == 1 and RightHand == 1 then
        return true
    else
        return false
    end
end

local function Hitbox(x,y,z)
    for i,v in ipairs(workspace.Titans:GetChildren()) do
        if v:IsA("Model") and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") then
            local Hitboxes = v:FindFirstChild("Hitboxes")
            if Hitboxes then
                local Hit = Hitboxes:FindFirstChild("Hit")
                if Hit then
                    local target = Hit:FindFirstChild("Nape")
                    if target then
                        target.Size = Vector3.new(x,y,z)
                    end
                end
            end
        end
    end
end    

local function TP_Titan(toggle)
    _G.Farm = toggle
    if _G.Farm then
        while _G.Farm do
            task.wait()
            print("Starting loop iteration")
            Anti_Grab()
            OpenChest()
            Retry()
            print("After Retry")

            if Blade() then
                print("Blade check passed")
                Refill()
            else
                local mob = Get_Mob()
                local root = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                if mob and root then
                    print("Mob found")
                    Hitbox(300, 1000, 300)
                    tp(mob.CFrame * CFrame.new(0, 70, 60))
                    local root = game.Players.LocalPlayer.Character.HumanoidRootPart
                    local mob_dist = (mob.Position - root.Position).magnitude
                    Hook(false)

                    if mob_dist < 105 then
                        print("Mob within range")
                        Hook(true)
                        spawn(Hit)
                        wait(.125)
                        root.Velocity = Vector3.new(-350, 0, 350)
                        wait(.25)
                    end
                else
                    print("No mob found")
                end
            end

            if GetButton_Text() == "STARTING (5s)" then
                print("Starting in 5s")
                webhooks(_G.Webhook)
                wait(1)
            end
        end
    end
end


spawn(function()
    if _G.Farm then
        wait(360)
        game.Players.LocalPlayer.Character.Humanoid.Health = 0
    end
end)

local plr = game.Players.LocalPlayer
local chr = plr.Character
local root = chr.HumanoidRootPart
local VirtualInputManager = game:GetService("VirtualInputManager")

local library = loadstring(game:HttpGet('https://raw.githubusercontent.com/cueshut/saves/main/criminality%20paste%20ui%20library'))()

-- // Window \\ --
local window = library.new('Syn0xz Hub', 'Syn0xz')

-- // Tabs \\ --
local tab = window.new_tab('rbxassetid://4483345998')

-- // Sections \\ --
local section = tab.new_section('- Main -')

-- // Sector \\ --
local Main = section.new_sector('= Main =', 'Left')
local Misc = section.new_sector('= Misc =', 'Right')

local AutoFarm = Main.element('Toggle', 'Auto Farm (Fast)', false, function(v)
    TP_Titan(v.Toggle)
end) 

local Code = Misc.element('Button', 'Redeem Code', false, function()
    wait(.25)
    Redeem_Code()
end) 

local Finding_Clan = Main.element('Toggle', 'Finding Clan', false, function(v)
    _G.Finding_Clan = v.Toggle
    while _G.Finding_Clan do task.wait()
        Finding_Clan()
    end
end)

local function load()
    if game:GetService("CoreGui"):FindFirstChild("unknown") then
        game:GetService("CoreGui"):FindFirstChild("unknown").Enabled = false
    end
    TP_Titan(getgenv().Auto_Farm)
end

local PlaceId = game.PlaceId
if PlaceId == 13379349730 or PlaceId == 14638336319 or PlaceId == 14012874501 or PlaceId == 13904207646 then
    load()
end
        
end
end)
