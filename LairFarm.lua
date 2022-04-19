
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



local Plr = game.Players.LocalPlayer


function checklevel()
    if game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("PlayerGUI") then
        local Level = tonumber(game:GetService("Players").LocalPlayer.PlayerGui.PlayerGUI.ingame.XP.Level.Text:sub(8))
        if Level == 1 or Level <= 999 then
            Quest = ("i_stabman [Lvl. 80+]")
            Mob = ("Boss")
        end
    end
end

function cancel_Y_Axis_Velocity()
    if Char then
        if Char:FindFirstChild("HumanoidRootPart") then
            Char.HumanoidRootPart.Velocity = Vector3.new(Char.HumanoidRootPart.Velocity.X,0,Char.HumanoidRootPart.Velocity.Z)
        end
    end
end


while getgenv().LairFarm do
    
    Char = game.Players.LocalPlayer.Character
    checklevel()
    
    questRev = workspace.Fartinglloll:FindFirstChild(Quest)
    questFinish = workspace.Fartinglloll:FindFirstChild(Quest)
    if questRev or questFinish then
      --  questFinish.QuestDone:FireServer()
        questRev.Done:FireServer()
    end
    for i,v in ipairs(game:GetService("Workspace").Living:GetChildren()) do
        for i2,v2 in ipairs(game:GetService("Workspace").Living:GetChildren()) do
            if v.Name == Mob and v2.Name == Mob then
                if Char then
                    if Char:FindFirstChild("HumanoidRootPart") then
                        Char:FindFirstChild("HumanoidRootPart").CFrame = game:GetService("Workspace").Living:FindFirstChild(Mob).HumanoidRootPart.CFrame
                    end
                end 
            end
        end
    end
    cancel_Y_Axis_Velocity()
    game:GetService("RunService").Stepped:Wait()
end


