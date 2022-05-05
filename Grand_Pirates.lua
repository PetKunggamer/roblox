local Config = {
    WindowName = "Grand Pirates",
	Color = Color3.fromRGB(255,128,64),
	Keybind = Enum.KeyCode.RightShift
}

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/AlexR32/Roblox/main/BracketV3.lua"))()
local Window = Library:CreateWindow(Config, game:GetService("CoreGui"))

local Tab1 = Window:CreateTab("Main")
local Tab2 = Window:CreateTab("UI Settings")

local Section1 = Tab1:CreateSection("Farms")
local Section2 = Tab1:CreateSection("Misc.")
local Section3 = Tab2:CreateSection("Menu")
local Section4 = Tab2:CreateSection("Background")

local Mobs = {} 
for i,v in ipairs(game.Workspace["Non-Player Characters"].Enemies:GetChildren()) do
    if v:FindFirstChild("HumanoidRootPart") and not table.find(Mobs,v.Name) then
        table.sort(Mobs)
        table.insert(Mobs,v.Name)
        end
end
local Quests = {}
for i,v in ipairs(game.Workspace["Non-Player Characters"].Quests:GetDescendants()) do
    if v:FindFirstChild("HumanoidRootPart") and not table.find(Quests,v.Name) then
        table.sort(Quests)
        table.insert(Quests,v.Name)
        end
end
local Weapons = {}
for i,v in ipairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
    if v:IsA("Tool") and not table.find(Weapons,v.Name) then
        table.sort(Weapons)
        table.insert(Weapons,v.Name)
        end
end
local Islands = {}
for i,v in ipairs(game.Workspace.IgnoreList.SpawnPoints:GetChildren()) do
    if not table.find(Islands,v.Name) then
        table.sort(Islands)
        table.insert(Islands,v.Name)
        end
end

local Shops = {}
for i,v in ipairs(game.Workspace["Non-Player Characters"].Shops:GetDescendants()) do
    if v:FindFirstChild("HumanoidRootPart") and not table.find(Shops,v.Name) then
        table.sort(Shops)
        table.insert(Shops,v.Name)
        end
end

Section1:CreateDropdown("เลือกมอนเตอร์",Mobs,function(x)
   Mober = x
end)

Section1:CreateDropdown("เลือกเควส",Quests,function(x)
   Quester = x
end)

Section1:CreateDropdown("เลือกอาวุธ",Weapons,function(x)
   Weaponpart2 = x
end)
Distance = -6
Section1:CreateSlider("ระยะห่าง",0,-10,-6,false,function(x)
   Distance = x
end)

Section1:CreateToggle("Auto Farm",nil,function(x)
    Farmer = x 
    while wait() and Farmer do
        for i,v in ipairs(game.Workspace["Non-Player Characters"].Enemies:GetChildren()) do
            if string.find(v.Name,Mober) and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health ~= 0 then
                    repeat 
                        if _G.QuestStart == true then 
                            wait()
                            else
                        task.wait()
                        pcall(function()
                            if game.Players.LocalPlayer.Backpack:FindFirstChild(Weaponpart2) then
                                game.Players.LocalPlayer.Backpack:FindFirstChild(Weaponpart2).Parent = game.Players.LocalPlayer.Character
                                end
                            end)
                    pcall(function()
                            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(v.HumanoidRootPart.Position + Vector3.new(0,Distance,0),v.HumanoidRootPart.Position)
                    end)
                    end
                    until v:FindFirstChild("Died") or not Farmer or not v:FindFirstChild("Humanoid")
                end
            end
        end
end)


_G.QuestStart = false
Section1:CreateToggle("Auto Quest",nil,function(x)
    Questtest = x 
    while wait(1) and Questtest do
        if game.Players.LocalPlayer.PlayerGui:FindFirstChild("QUEST") then
        for i,v in ipairs(game.Players.LocalPlayer.PlayerGui.QUEST:GetChildren()) do
            if v.Name == "QuestFrame" and v.Visible == false then
                _G.QuestStart = true
                wait(0.5)
            for g,e in ipairs(game.Workspace["Non-Player Characters"].Quests:GetDescendants()) do
            if e.Name == Quester then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = e.HumanoidRootPart.CFrame
                end
            end
            game:GetService("Players").LocalPlayer.Build.Remotes.ServerRequest:FireServer("SetQuest",Quester)
            _G.QuestStart = false
            end
        end
    end
end
end)

Section2:CreateDropdown("Teleport to a Quest",Quests,function(x)
    for i,v in ipairs(game.Workspace["Non-Player Characters"].Quests:GetDescendants()) do
        if v.Name == x and v:FindFirstChild("HumanoidRootPart") then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame
            end
        end
end)

Section2:CreateDropdown("Teleport to a Island",Islands,function(x)
    for i,v in ipairs(game.Workspace.IgnoreList.SpawnPoints:GetChildren()) do
        if v.Name == x then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.CFrame
            end
        end
end)

Section2:CreateDropdown("Teleport to a Shop",Shops,function(x)
    for i,v in ipairs(game.Workspace["Non-Player Characters"].Shops:GetDescendants()) do
        if v.Name == x then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame
            end
        end
end)

Section2:CreateToggle("Auto Buso",nil,function(x)
    Buso = x 
    while wait(0.2) and Buso do
            if not game.Players.LocalPlayer.Character:FindFirstChild("Busoshoku") then
                    game:GetService("Players").LocalPlayer.Build.Remotes.ServerRequest:FireServer("Busoshoku")
                end
            end
    end)


local Button2 = Section2:CreateButton("Anti Melee", function()
	game.Players.LocalPlayer.Character.Fruit:Destroy()
end)
Button2:AddToolTip("เหมือน Logia แต่ก็ไม่ใช่กูก้ไม่รู้")


spawn(function()
    while task.wait() do
        if Farmer then
                     pcall(function()    
                            game:GetService("Players").LocalPlayer.Build.Remotes.ServerCallback:InvokeServer("CombatVariations",Weaponpart2.."Combat")
                     end)
                pcall(function()    
                            game:GetService("Players").LocalPlayer.Character[Weaponpart2]:Activate()
                    end)
            end
        end
end)


local Toggle3 = Section3:CreateToggle("UI Toggle", nil, function(State)
	Window:Toggle(State)
end)
Toggle3:CreateKeybind(tostring(Config.Keybind):gsub("Enum.KeyCode.", ""), function(Key)
	Config.Keybind = Enum.KeyCode[Key]
end)
Toggle3:SetState(true)

local Colorpicker3 = Section3:CreateColorpicker("UI Color", function(Color)
	Window:ChangeColor(Color)
end)
Colorpicker3:UpdateColor(Config.Color)

-- credits to jan for patterns
local Dropdown3 = Section4:CreateDropdown("Image", {"Default","Hearts","Abstract","Hexagon","Circles","Lace With Flowers","Floral"}, function(Name)
	if Name == "Default" then
		Window:SetBackground("2151741365")
	elseif Name == "Hearts" then
		Window:SetBackground("6073763717")
	elseif Name == "Abstract" then
		Window:SetBackground("6073743871")
	elseif Name == "Hexagon" then
		Window:SetBackground("6073628839")
	elseif Name == "Circles" then
		Window:SetBackground("6071579801")
	elseif Name == "Lace With Flowers" then
		Window:SetBackground("6071575925")
	elseif Name == "Floral" then
		Window:SetBackground("5553946656")
	end
end)
Dropdown3:SetOption("Default")

local Colorpicker4 = Section4:CreateColorpicker("Color", function(Color)
	Window:SetBackgroundColor(Color)
end)
Colorpicker4:UpdateColor(Color3.new(1,1,1))

local Slider3 = Section4:CreateSlider("Transparency",0,1,nil,false, function(Value)
	Window:SetBackgroundTransparency(Value)
end)
Slider3:SetValue(0)

local Slider4 = Section4:CreateSlider("Tile Scale",0,1,nil,false, function(Value)
	Window:SetTileScale(Value)
end)
Slider4:SetValue(0.5)

local OldNameCall
local OldIndex

OldIndex = hookmetamethod(game, "__index", function(...)
    local Args = {...}
    local Self = Args[1]
    local Key = Args[2]
    local vaild,name = pcall(function()
        return Self
    end)
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
end)
OldNameCall = hookmetamethod(game, "__namecall", function(Self, ...)
    local Args = {...}
    local NamecallMethod = getnamecallmethod()
    local vaild,name = pcall(function()
        return Self.name
    end)
    if vaild and name then
        if (NamecallMethod == "Kick" or NamecallMethod == "kick") or (NamecallMethod == "FireServer" and name == "PlayerStandMainHandle") then
            print("Block Kick(namecall)")
            return nil
        else
            return OldNameCall(Self,...)
        end
    end

    return OldNameCall(...)
end)
