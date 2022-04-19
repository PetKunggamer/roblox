Clip = false
local speaker = game.Players.LocalPlayer
local function NoclipLoop()
    if Clip == false and speaker.Character ~= nil then
        for _, child in pairs(speaker.Character:GetDescendants()) do
            if child:IsA("BasePart") and child.CanCollide == true then
                child.CanCollide = false
            end
        end
    end
end


Noclipping = game:GetService('RunService').Stepped:connect(NoclipLoop)

function linear_interpolation(object,targetproperty,time)
    local tweenInfo = TweenInfo.new(time/100000,Enum.EasingStyle.Linear,Enum.EasingDirection.In,0,false,0)
    local tweenService = game:GetService("TweenService")
    local tween = tweenService:Create(object, tweenInfo, targetproperty)
    tween:Play()
    tween.Completed:Wait()
    wait()
end


local Char = game.Players.LocalPlayer.Character
local Plr = game.Players.LocalPlayer

function StatEXP()
    local Stat_List = {"Pickpocket_1","Pickpocket_2","Experience_1","Experience_2","Experience_3","Experience_4"}
    for _,EXP in ipairs(Stat_List) do
        local Rep = game:GetService("ReplicatedStorage").Events
        if Rep then
            Rep.GetSkillTree:FireServer(EXP)
        end
    end
end

function checklevel()
    local Level = tonumber(game:GetService("Players").LocalPlayer.PlayerGui.PlayerGUI.ingame.XP.Level.Text:sub(8))
    if Level == 1 or Level <= 100 then
        Quest = ("Giorno Giovanna [Lvl. 90+]")
        Mob = ("Jungle Bandit")
    elseif Level == 100 or Level <= 9e9 then
        Quest = ("Giorno Giovanna [Lvl. 90+]")
        Mob = ("Jungle Bandit")
    end
end


function cancel_Y_Axis_Velocity()
    game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Velocity = Vector3.new(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Velocity.X,0,game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Velocity.Z)
end

function Attack()
    if game:GetService("Players").LocalPlayer.Character then
        game:GetService("Players").LocalPlayer.Character.StandEvents.M1:FireServer()
    end
end


Char.Humanoid.Sit = true



while getgenv().AutoFarm do
    checklevel()
    Char.StandEvents.Jump:FireServer()
    questRev = workspace.Fartinglloll:FindFirstChild(Quest)
    questFinish = workspace.Fartinglloll:FindFirstChild(Quest)
    if questRev or questFinish then
        questFinish.QuestDone:FireServer()
        questRev.Done:FireServer()
    end
    for i,v in ipairs(game:GetService("Workspace").Living:GetChildren()) do
        for i2,v2 in ipairs(game:GetService("Workspace").Living:GetChildren()) do
            if v.Name == Mob and v2.Name == Mob then
                linear_interpolation(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart,{CFrame=CFrame.new(v2.HumanoidRootPart.Position+Vector3.new(0,11,0), v2.HumanoidRootPart.Position)},(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position - v2.HumanoidRootPart.Position).magnitude*100)
                Attack()
            end 
        end
    end
    cancel_Y_Axis_Velocity()
    game:GetService("RunService").Stepped:Wait()
end
