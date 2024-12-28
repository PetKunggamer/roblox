repeat task.wait() until game:IsLoaded()
wait(10)
if game.PlaceId == 16379684339 then
local Players = game:GetService('Players')
local lp = Players.LocalPlayer
local char = lp.Character or lp.CharacterAdded:Wait()
local hrp = char:WaitForChild('HumanoidRootPart')
local RS = game:GetService("ReplicatedStorage")
local Remotes = RS:WaitForChild("Remotes")
local StorylineDialogueSkip = Remotes:WaitForChild("Client"):WaitForChild("StorylineDialogueSkip")
local VirtualInputManager = game:GetService('VirtualInputManager')
local GuiService = game:GetService('GuiService')
local Equip = Remotes:WaitForChild("Server"):WaitForChild("Data"):WaitForChild("EquipItem")

local function Get_Mob()
    local dist, mob = math.huge, nil
    for _, v in ipairs(workspace.Objects.Mobs:GetChildren()) do
        if v:IsA("Model") then
            local target = v:FindFirstChild("HumanoidRootPart")
            local hum = v:FindFirstChild("Humanoid")
            if target and hrp and hum and hum.Health > 0 then
                local mag = (hrp.Position - target.Position).Magnitude
                if mag < dist then
                    dist = mag
                    mob = target
                end
            end
        end
    end
    return mob
end

local function Rescue()
    local hrp = game:GetService('Players').LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if hrp then
        for i,v in ipairs(workspace.Objects.MissionItems:GetChildren()) do
            if v:IsA("Model") then
                local target = v:FindFirstChild("HumanoidRootPart")
                if target then
                    local prox = v:FindFirstChild("PickUp")
                    if prox then
                        wait(.125)
                        hrp.CFrame = target.CFrame
                        wait(.235)
                        fireproximityprompt(prox)
                        wait(.2)
                        hrp.CFrame = CFrame.new(-4370, -325, 3574)
                    end
                end
            end
        end
    end
end

local function tp(CF)
    local distance = (hrp.Position - CF.Position).Magnitude
    local duration = distance / getgenv().Speed
    local tweenInfo = TweenInfo.new(
        duration, -- Duration based on distance and speed
        Enum.EasingStyle.Linear -- Linear easing for consistent speed
    )

    -- Add functionality for creating and playing a tween
    local tweenService = game:GetService("TweenService")
    local tween = tweenService:Create(hrp, tweenInfo, {CFrame = CF})
    tween:Play()
    tween.Completed:Wait()
end

local function Kill_Aura(target)
    local hrp = game:GetService('Players').LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    for i,v in ipairs(workspace.Objects.Mobs:GetChildren()) do
        if v:IsA("Model") then
            local target = v:FindFirstChild("HumanoidRootPart")
            if target then
                local hum = v:FindFirstChild("Humanoid")
                if hum then
                    local mag = (hrp.Position - target.Position).magnitude
                    if hum and hum.Health > 0 and mag < 100 then
                        hum.Health = 0
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

local function Mission_Item()
    local hrp = game:GetService('Players').LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if hrp then
        for i,v in ipairs(workspace.Objects.MissionItems:GetChildren()) do
            if v:IsA("MeshPart") then
                local prox = v:FindFirstChild("Collect")
                if prox then
                    hrp.CFrame = v.CFrame
                    wait(.235)
                    fireproximityprompt(prox)
                end
            end
        end
    end
end

local function Replay()
    local Result = game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("Results")
    local ReadyScreen = game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("ReadyScreen")
    if Result and Result.Enabled then
        wait()
        if ReadyScreen and ReadyScreen.Enabled then
            local Frame = ReadyScreen:FindFirstChild("Frame")
            if Frame then
                local Replay_button = Frame:FindFirstChild("Replay")
                if Replay_button then
                    task.wait(.001)
                    GuiService.SelectedCoreObject = Replay_button
                    VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.Return, false, game)
                    VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.Return, false, game)
                end
            end
        end
    end
end

local function Get_Loot()
    local hrp = game:GetService('Players').LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if hrp then
        local chest = nil
        for i,v in ipairs(workspace.Objects.Drops:GetChildren()) do
            if v:IsA("Model") then
                local Root = v:FindFirstChild("Root")
                if Root then
                    local mag = (Root.Position - hrp.Position).magnitude
                    if mag < 50 then
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
    wait(.125)
    Get_Loot()
    if flip_button.Visible then
        task.wait(.001)
        GuiService.SelectedCoreObject = flip_button
        VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.Return, false, game)
        VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.Return, false, game)
    end
end

local function Mugen()
    local RS = game:GetService("ReplicatedStorage")
    Remotes:WaitForChild("Server"):WaitForChild("Combat"):WaitForChild("Skill"):FireServer("Infinity: Mugen")
end

local function God_Mode()
    Remotes:WaitForChild("Server"):WaitForChild("Combat"):WaitForChild("ReverseHeal"):InvokeServer(-100)
end

Equip:InvokeServer("Luck Vial")
Equip:InvokeServer("Wooden Beckoning Cat")
Equip:InvokeServer("White Lotus")

_G.A = not _G.A
print(_G.A)
while _G.A do task.wait()
    StorylineDialogueSkip:FireServer()
    spawn(Auto_Loot)
    local Result = game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("Results")
    local Mission_Item_Check = workspace.Objects.MissionItems
        if Result and Result.Enabled then
            Replay()
        end
        if Mission_Item_Check:FindFirstChild("CursedObject") then
            Mission_Item()
        elseif Mission_Item_Check:FindFirstChild("Civilian") then
            Rescue()
        else
            if Get_Mob() then
                tp(Get_Mob().CFrame * CFrame.new(0,25,0))
                wait(.25)
                Kill_Aura(Get_Mob().Parent.Humanoid)
                wait(.125)
                hrp.CFrame = hrp.CFrame * CFrame.new(0,50,1200)
            end
        end
    end
end
