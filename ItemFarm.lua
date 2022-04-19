function TP(Object)
            local tweenService, tweenInfo = game:GetService("TweenService"), TweenInfo.new((game.Players.LocalPlayer.Character.HumanoidRootPart.Position - Object).magnitude/600,Enum.EasingStyle.Linear,Enum.EasingDirection.In,0,false,0)
            local tween = tweenService:Create(game:GetService("Players")["LocalPlayer"].Character.HumanoidRootPart, tweenInfo, {CFrame = CFrame.new(Object)})
            local speaker = game.Players.LocalPlayer
            local Noclipping = game:GetService('RunService').Stepped:connect(NoclipLoop)
            tween:Play()
            tween.Completed:Wait()
            Noclipping:Disconnect()
end

while ItemFarm do Wait()
        for i,v in ipairs(game:GetService("Workspace").Items:GetDescendants()) do
            if v.ClassName == "Tool" and v:FindFirstChild("Handle") then
                game.Players.LocalPlayer.Character.Humanoid.Sit = true
                TP(v.Handle.Position);
            end
end
end