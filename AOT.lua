repeat task.wait() until game:IsLoaded()

local PlaceId = game.PlaceId
if PlaceId == 13379349730 or PlaceId == 14638336319 or PlaceId == 14012874501 or PlaceId == 13904207646 then

_G.TP_Titan = getgenv().Auto_Farm
_G.Speed = getgenv().Speed

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
                            clickUiButton(Roll, true)
                            clickUiButton(Roll, false)
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
        wait(5.5)
    end
end

local function Get_Mob()
    local root = game.Players.LocalPlayer.Character.HumanoidRootPart
    local dist, mob = math.huge
    for i,v in ipairs(workspace.Titans:GetChildren()) do
        if v:IsA("Model") and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") then
            local mag = (root.Position - v:FindFirstChild("HumanoidRootPart").Position).magnitude
            if mag < dist then
                local Hitboxes = v:FindFirstChild("Hitboxes")
                if Hitboxes then
                    local Hit = Hitboxes:FindFirstChild("Hit")
                    if Hit then
                        local target = Hit:FindFirstChild("Nape")
                        if target then
                            return target
                        end
                    end
                end
            end
        end
    end
end

local function tp(CF)
local TweenService = game:GetService("TweenService")
local plr = game.Players.LocalPlayer
local chr = plr.Character
local root = chr.HumanoidRootPart
    if chr then
        local root = plr.Character:FindFirstChild("HumanoidRootPart")
        if root then
            local tween =
                TweenService:Create(
                root,
                TweenInfo.new((CF.Position - root.Position).magnitude / _G.Speed),
                {CFrame = CF}
            )
            tween:Play()
            root.Velocity = Vector3.new(0,0,0)
            root.Anchored = true
            wait(.25)
            root.Anchored = false
        end
    end
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

local function Retry()
    local PlayerGui = game:GetService("Players").LocalPlayer.PlayerGui
    if PlayerGui then
        local Interface = PlayerGui:FindFirstChild("Interface")
        if Interface then
            local Rewards = Interface:FindFirstChild("Rewards")
            if Rewards then
                local Main1 = Rewards:FindFirstChild("Main")
                if Main1 then
                    local Info = Main1:FindFirstChild("Info")
                    if Info then
                        local Main = Info:FindFirstChild("Main")
                        if Main then
                            local Buttons = Main:FindFirstChild("Buttons")
                            if Buttons then
                                local Retry = Buttons:FindFirstChild("Retry")
                                if Retry then
                                    clickUiButton(Retry, true)
                                    clickUiButton(Retry, false)
                                end
                            end
                        end 
                    end
                end
            end
        end
    end
end

local function Auto_Retry(toggle)
    _G.Auto_Retry = toggle
    if _G.Auto_Retry then
        while _G.Auto_Retry do wait()
            Retry()
        end
    end
end


local function Hit()
    local VirtualInputManager = game:GetService("VirtualInputManager")
    VirtualInputManager:SendMouseButtonEvent(100, 50, 0, true, game, 1)
    VirtualInputManager:SendMouseButtonEvent(100, 50, 0, false, game, 1)
end

local function Hook(state)
    local VirtualInputManager = game:GetService("VirtualInputManager")
    VirtualInputManager:SendKeyEvent(state, Enum.KeyCode.E, false, game)
    VirtualInputManager:SendKeyEvent(state, Enum.KeyCode.Q, false, game)
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
                end
            end
        end
    end
end

local function Gen_Refill()
    if not Get_Refill() then
        local PlaceId = game.PlaceId
        if PlaceId == 13379349730 then -- [AOT:R] Shiganshina
            tp(CFrame.new(510, 172, 771))
        end
        if PlaceId == 14638336319 then -- [AOT:R] Giant Forest
            tp(CFrame.new(270, 17, -685))
        end
        if PlaceId == 14012874501 then -- [AOT:R] Trost
            tp(CFrame.new(-952, 50, 148))
        end
        if PlaceId == 13904207646 then -- [AOT:R] Trost Outskirts
            tp(CFrame.new(1866, 9, -76))
        end
    end
end

local function Refill()
    if Get_Refill() then 
        tp((Get_Refill().CFrame))
        wait(5)
    else
        Gen_Refill()
    end
end

local function Gas()
    local Blade = game:GetService("Players").LocalPlayer.PlayerGui.Interface.HUD.Main.Top.Blade.Sets
    local Gas = game:GetService("Players").LocalPlayer.PlayerGui.Interface.HUD.Main.Top.Gas.Percentage
    if Blade.Text == "0 / 3" or Gas.Text == "0%" then
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
        while _G.Farm do wait(.125)
            Retry()
            if Gas() then
                Hook(false)
                Refill()
                local VirtualInputManager = game:GetService("VirtualInputManager")
                VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.R, false, game)
                VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.R, false, game)
                wait(3)
            else
                Hit()
                Hitbox(1000,1000,1000)
                Anti_Grab()
                Check_Sword()
                Hook(true)
                if Get_Mob() then 
                    tp(Get_Mob().CFrame * CFrame.new(0,120,0))
                end
            end
        end
    end
end

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
    wait(2)
    TP_Titan(_G.TP_Titan)
end

load()

end
