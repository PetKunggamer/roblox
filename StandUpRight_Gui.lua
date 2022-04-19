local Library = loadstring(game:HttpGet("https://pastebin.com/raw/6W1ZqV53"))()

local w = Library:Window("Chaiwat Hub")

local p = Library:Window("Auto Buy")

local c = Library:Window("Misc")

c:Toggle(
    "Item Farm",
    function(v)
        getgenv().ItemFarm = v
        loadstring(game:HttpGet "https://raw.githubusercontent.com/PetKunggamer/roblox/main/ItemFarm.lua")()
    end
)

c:Toggle(
    "Auto Hamon",
    function(v)
        getgenv().AutoHamon = v
        while getgenv().AutoHamon do
            wait()
            if game.Players.LocalPlayer.Character.SecondaryHandler:FindFirstChild("B") then
                game:GetService("Players").LocalPlayer.Character.SecondaryHandler.B:FireServer(true)
            else
                game.StarterGui:SetCore(
                    "SendNotification",
                    {
                        Title = "เจอควาย ERROR!!",
                        Text = "ไหน Hamon มึงไอสัดไม่มีแล้วกดไอเวร",
                        Icon = "rbxassetid://2263444659",
                        Duration = 5
                    }
                )
                getgenv().AutoHamon = false
            end
        end
    end
)

p:Button(
    "Stand Arrow",
    function()
        function StandArrow()
            game:GetService("ReplicatedStorage").Events.BuyItem:FireServer("MerchantAU", "Option3")
        end
        StandArrow()
    end
)

p:Button(
    "Rokakaka",
    function()
        function Rokaka()
            game:GetService("ReplicatedStorage").Events.BuyItem:FireServer("MerchantAU", "Option1")
        end
        Rokaka()
    end
)

w:Button(
    "Bypass",
    function()
        loadstring(game:HttpGet "https://raw.githubusercontent.com/PetKunggamer/roblox/main/Bypass_NPC.lua")()
        local OldNameCall
        local OldIndex

        OldIndex =
            hookmetamethod(
            game,
            "__index",
            function(...)
                local Args = {...}
                local Self = Args[1]
                local Key = Args[2]
                local vaild, name =
                    pcall(
                    function()
                        return Self
                    end
                )
                if vaild then
                    if Key == "Kick" or Key == "kick" then
                        print("Block Kick(Index)")
                        return function()
                        end
                    end
                end
                if not vaild then
                    print(name)
                end
                return OldIndex(...)
            end
        )
        OldNameCall =
            hookmetamethod(
            game,
            "__namecall",
            function(Self, ...)
                local Args = {...}
                local NamecallMethod = getnamecallmethod()
                local vaild, name =
                    pcall(
                    function()
                        return Self.name
                    end
                )
                if vaild and name then
                    if
                        (NamecallMethod == "Kick" or NamecallMethod == "kick") or
                            (NamecallMethod == "FireServer" and name == "PlayerStandMainHandle") or
                            (NamecallMethod == "FireServer" and name == "SpeedJump")
                     then
                        print("Block Kick(namecall)")
                        return nil
                    else
                        return OldNameCall(Self, ...)
                    end
                end

                return OldNameCall(...)
            end
        )

        game.StarterGui:SetCore(
            "SendNotification",
            {
                Title = "Anti Cheat",
                Text = "Bypass successfully!!",
                Icon = "rbxassetid://57254792",
                Duration = 5
            }
        )
    end
)

w:Toggle(
    "Auto Farm",
    function(v)
        getgenv().AutoFarm = v
        loadstring(game:HttpGet "https://raw.githubusercontent.com/PetKunggamer/roblox/main/AutoFarm.lua")()
    end
)

w:Toggle(
    "Lair Farm",
    function(v)
        getgenv().LairFarm = v

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

        Noclipping = game:GetService("RunService").Stepped:connect(NoclipLoop)

        local Plr = game.Players.LocalPlayer

        function checklevel()
            if game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("PlayerGUI") then
                local Level =
                    tonumber(game:GetService("Players").LocalPlayer.PlayerGui.PlayerGUI.ingame.XP.Level.Text:sub(8))
                if Level == 1 or Level <= 999 then
                    Quest = ("i_stabman [Lvl. 80+]")
                    Mob = ("Boss")
                end
            end
        end

        function cancel_Y_Axis_Velocity()
            if Char then
                if Char:FindFirstChild("HumanoidRootPart") then
                    Char.HumanoidRootPart.Velocity =
                        Vector3.new(Char.HumanoidRootPart.Velocity.X, 0, Char.HumanoidRootPart.Velocity.Z)
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
            for i, v in ipairs(game:GetService("Workspace").Living:GetChildren()) do
                for i2, v2 in ipairs(game:GetService("Workspace").Living:GetChildren()) do
                    if v.Name == Mob and v2.Name == Mob then
                        if Char then
                            if Char:FindFirstChild("HumanoidRootPart") then
                                Char:FindFirstChild("HumanoidRootPart").CFrame =
                                    game:GetService("Workspace").Living:FindFirstChild(Mob).HumanoidRootPart.CFrame
                            end
                        end
                    end
                end
            end
            cancel_Y_Axis_Velocity()
            game:GetService("RunService").Stepped:Wait()
        end
    end
)
