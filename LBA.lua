local Config = {
    WindowName = "Syn0xz Hub [ Legendary Bizarre Adventures 🗿 ]",
	Color = Color3.fromRGB(255,128,64),
	Keybind = Enum.KeyCode.RightShift
}

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/AlexR32/Roblox/main/BracketV3.lua"))()
local Window = Library:CreateWindow(Config, game:GetService("CoreGui"))

local Tab1 = Window:CreateTab("Main")
local Tab2 = Window:CreateTab("UI Settings")

local Section1 = Tab1:CreateSection("Main")
local Section2 = Tab1:CreateSection("Teleports.")
local Section3 = Tab1:CreateSection("Farms.")
local Section4 = Tab1:CreateSection("Mics.")

local UI_1 = Tab2:CreateSection("Menu")
local UI_2 = Tab2:CreateSection("Background")

local Dropdown3 = Section2:CreateDropdown("Select to teleports", {
    "Old Wind",
    "Oreo City",
    "Kai Island",
    "Ruffy Island",
    "Demon Slayer Island",
    "Mystery Island",
    "Wolf Kingdom",
    "Captain Roger Island",
    "Beerus Island",
    "Boros Spaceship",
    "Flying Island [PVP ZONE]"
    
},
function(Name)
    local Character = game.Players.LocalPlayer.Character
	if Name == "Old Wind" then
		Character.HumanoidRootPart.CFrame = CFrame.new(-10373, 1879, 2436)
	elseif Name == "Oreo City" then
		Character.HumanoidRootPart.CFrame = CFrame.new(-11571, 1878, 846)
	elseif Name == "Kai Island" then
		Character.HumanoidRootPart.CFrame = CFrame.new(-2799, 2192, -1198)
	elseif Name == "Ruffy Island" then
		Character.HumanoidRootPart.CFrame = CFrame.new(-3258, 1903, 2494)
	elseif Name == "Demon Slayer Island" then
		Character.HumanoidRootPart.CFrame = CFrame.new(-5209, 1880, 4707)
	elseif Name == "Mystery Island" then
		Character.HumanoidRootPart.CFrame = CFrame.new(-7206, 1918, -357)
	elseif Name == "Wolf Kingdom" then
		Character.HumanoidRootPart.CFrame = CFrame.new(-6425, 1878, -5211)
	elseif Name == "Captain Roger Island" then
		Character.HumanoidRootPart.CFrame = CFrame.new(-10637, 1881, -3218)
	elseif Name == "Beerus Island" then
		Character.HumanoidRootPart.CFrame = CFrame.new(-17923, 1912, 6523)
	elseif Name == "Boros Spaceship" then
		Character.HumanoidRootPart.CFrame = CFrame.new(-13456, 2307, 7353)
	elseif Name == "Flying Island [PVP ZONE]" then
		Character.HumanoidRootPart.CFrame = CFrame.new(-7847, 2518, 4886)
	end
end)

Section4:CreateToggle("God Mode",nil,function(x)
    local Character = game.Players.LocalPlayer.Character
    getgenv().God_Mode = x
    while getgenv().God_Mode do wait()
        if Character.Humanoid.Health < 1100 then
            local args = {
                [1] = Character.Humanoid,
                [2] = nil,
                [3] = -1e9999999,
            }
            
            game:GetService("ReplicatedStorage").Damage:FireServer(unpack(args))
        end
    end
end)

Section3:CreateToggle("Item Grab",nil,function(x)
    getgenv().ItemGrab = x
    while getgenv().ItemGrab do wait()
    local Character = game.Players.LocalPlayer.Character
        for i,v in ipairs(game.workspace:GetChildren()) do
            if v:IsA("Tool") 
            and v.Name ~= "Bandages" 
            and v.Name ~= "Rokakaka" 
            and v.Name ~= "Arrow"
            and v.Name ~= "Diamond"
            and v.Name ~= "Ruby"
            and v.Name ~= "LegendaryCoin"
            and v.Name ~= "SteelBall"
            and v.Name ~= "Water"
            and v.Name ~= "GomuGomuNoMi"
            and v.Name ~= "SukeSukeNoMi"
            and v.Name ~= "Soup"
            then
                v.Handle.CFrame = Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 0)
            end
        end
    end
end)
Section4:CreateToggle("Kill Aura",nil,function(x)
    getgenv().KillAura = x
    while getgenv().KillAura do wait(3)
    local Character = game.Players.LocalPlayer.Character

for i,v in ipairs(game.workspace:GetDescendants()) do
    if v:IsA("Model") and v:FindFirstChild("Head") and v ~= Character and v ~= game:GetService("Workspace").Dummy and v ~= game:GetService("Workspace")["Training Dummy"] then
        pcall(function()
            if (Character.Head.Position - v:FindFirstChild("Head").Position).Magnitude < Distance then
                local Target = v
                
                local args = {
                    [1] = Target.Humanoid,
                    [2] = nil,
                    [3] = 1e9,
                }
                
                game:GetService("ReplicatedStorage").Damage:FireServer(unpack(args))
           end
        end)
    end
end
end

end)

Section4:CreateSlider("Distance",0,100,10,false,function(x)
   Distance = x
end)

local Toggle1 = Section1:CreateToggle("Speed_Hack", nil, function(x)
	getgenv().Speed_Hack = x
	while getgenv().Speed_Hack do wait()
	game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = WS
	end
end)

local Toggle2 = Section1:CreateToggle("JumpPower", nil, function(x)
	getgenv().JP_Hack = x
	while getgenv().JP_Hack do wait()
	game.Players.LocalPlayer.Character.Humanoid.JumpPower = JP
	end
end)

local Slider1 = Section1:CreateSlider("ความเร็ว", 0,200,nil,false, function(x)
	WS = x
end)

local Slider1 = Section1:CreateSlider("กระโดดพลังงาน", 0,200,nil,false, function(x)
	JP = x
end)

local Toggle3 = UI_1:CreateToggle("UI Toggle", nil, function(State)
	Window:Toggle(State)
end)
Toggle3:CreateKeybind(tostring(Config.Keybind):gsub("Enum.KeyCode.", ""), function(Key)
	Config.Keybind = Enum.KeyCode[Key]
end)
Toggle3:SetState(true)

local Colorpicker3 = UI_1:CreateColorpicker("UI Color", function(Color)
	Window:ChangeColor(Color)
end)
Colorpicker3:UpdateColor(Config.Color)

-- credits to jan for patterns
local Dropdown3 = UI_2:CreateDropdown("Image", {"Default","Hearts","Abstract","Hexagon","Circles","Lace With Flowers","Floral"}, function(Name)
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

local Colorpicker4 = UI_2:CreateColorpicker("Color", function(Color)
	Window:SetBackgroundColor(Color)
end)
Colorpicker4:UpdateColor(Color3.new(1,1,1))

local Slider3 = UI_2:CreateSlider("Transparency",0,1,nil,false, function(Value)
	Window:SetBackgroundTransparency(Value)
end)
Slider3:SetValue(0)

local Slider4 = UI_2:CreateSlider("Tile Scale",0,1,nil,false, function(Value)
	Window:SetTileScale(Value)
end)
Slider4:SetValue(0.5)
