local Config = {
    WindowName = "Syn0xz Hub [ Elemental Awakening ]",
	Color = Color3.fromRGB(255,128,64),
	Keybind = Enum.KeyCode.RightShift
}

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/AlexR32/Roblox/main/BracketV3.lua"))()
local Window = Library:CreateWindow(Config, game:GetService("CoreGui"))

local Tab1 = Window:CreateTab("Main")
local Tab2 = Window:CreateTab("UI Settings")

local Section1 = Tab1:CreateSection("Farms")
local Section2 = Tab1:CreateSection("Teleport")
local Section3 = Tab1:CreateSection("Misc.")
local Section4 = Tab1:CreateSection("Gamepass")
local UI_1 = Tab2:CreateSection("Menu")
local UI_2 = Tab2:CreateSection("Background")


local Button1 = Section4:CreateButton("Instant Spin", function()
	for i,v in ipairs(game:GetService("ReplicatedStorage").Data:GetDescendants()) do
    if v.Name == "InstantSpin" then
        v.Value = true
    end
end
end)
Button1:AddToolTip("กด ON/OFF เอง")


local Button0 = Section2:CreateButton("Safe Place", function()
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(300000, 50020, 300000)
end)
Button1:AddToolTip("ห้องแม่เซ็น")

local Button1 = Section2:CreateButton("The Plains", function()
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1385, 410, 1501)
end)
Button1:AddToolTip("ห้องแม่เซ็น")

local Button2 = Section2:CreateButton("The Monolith", function()
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1699, 261, -479)
end)

local Button3 = Section2:CreateButton("World's Zenith", function()
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1994, 1467, 2112)
end)

local Button4 = Section2:CreateButton("The Origin", function()
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-26465, 1618, 3058)
end)

local Button5 = Section2:CreateButton("Arena", function()
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(2522, 406, 3028)
end)



local Button1 = Section3:CreateButton("Spawn SafePlace", function()
function SpawnPart()
  local Part = Instance.new("Part")
  Part.Name = "SafePlace"
  Part.Material = "Grass"
  Part.Color = Color3.fromRGB(31, 128, 29)
  Part.Position = Vector3.new(300000, 50000, 300000)
  Part.Size = Vector3.new(1000, 10, 1000)
  Part.Anchored = true
  Part.Parent = workspace
end

if game:GetService("Workspace"):FindFirstChild("SafePlace") then
    game:GetService("Workspace").SafePlace:Destroy()
end
SpawnPart();
end)
Button1:AddToolTip("Spawn ห้องแม่เซ็น")

local Button2 = Section3:CreateButton("Remove Killbricks", function()
	local Kb = game:GetService("Workspace").Killbricks
    for i,v in ipairs(Kb:GetDescendants()) do
        if v.Name == "TouchInterest" then
           v:Destroy()
        end
    end
end)
Button2:AddToolTip("No more Killbricks")

local Button3 = Section3:CreateButton("Mod Magic", function()
	local mod = require(game:GetService("ReplicatedStorage").SpellLibrary)
	for i,v in ipairs(game.Players.LocalPlayer.Backpack:GetDescendants()) do
	    mod[v.Name].CastTime = 0
	    mod[v.Name].EndLag = 0
	    mod[v.Name].Range = 1000000
	    
	end
end)
Button3:AddToolTip("Make ยู ร่ายMagic แบบ Coolๆ นะ")


Section1:CreateToggle("Auto Skill",nil,function(x)
    getgenv().AutoSkill = x 
local Backpack = game.Players.LocalPlayer.Backpack
local Char = game.Players.LocalPlayer.Character
local plr = game.Players.LocalPlayer


while getgenv().AutoSkill do wait(.5)
    for i,v1 in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
        if v1:IsA'Tool' then
            v1.Parent = game.Players.LocalPlayer.Backpack;
        end;
    end    
    for i,v in ipairs(Backpack:GetDescendants()) do
            if v:IsA("Tool") and Backpack:FindFirstChild(v.Name) then
                Backpack:FindFirstChild(v.Name).Parent = game.Players.LocalPlayer.Character
                local args = {
                [1] = {
                    [1] = game:GetService("Players").LocalPlayer.Character:FindFirstChild(v.Name),
                    [2] = Vector3.new(2614.71435546875, 343.5958251953125, 2349.52490234375),
                    [3] = Vector3.new(-0.2782159745693207, -9.159542457837233e-08, -0.9605185389518738),
                    [4] = true
                }
            }

            game:GetService("ReplicatedStorage").Events.SpellCast:FireServer(unpack(args))

            local args = {
                [1] = {
                    [1] = game:GetService("Players").LocalPlayer.Character:FindFirstChild(v.Name),
                    [2] = Vector3.new(2733.2138671875, 357.4052429199219, 2607.526611328125)
                }
            }

            game:GetService("ReplicatedStorage").Events.SpellCast:FireServer(unpack(args))
        end
     end
    end
end)

Section1:CreateToggle("Auto Farm [BETA]",nil,function(x)
    getgenv().AutoFarm = x 
function mysplit (inputstr, sep)
        if sep == nil then
                sep = "%s"
        end
        local t={}
        for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
                table.insert(t, str)
        end
        return t
end

while getgenv().AutoFarm do wait()

    if game.Players.LocalPlayer == nil then
       game.Players:GetPropertyChangedSignal("LocalPlayer"):Wait()
    end
    for _,GUI in pairs(game.Players.LocalPlayer.PlayerGui:GetDescendants()) do
	pcall(function()
        if game.Players.LocalPlayer:FindFirstChild("PlayerGui") and GUI:FindFirstChild("Start") then
            local Events = getconnections(GUI:FindFirstChild("Start").PlayButton.MouseButton1Click)
            for i,v in pairs(Events) do
                v:Fire()
            end
        end
        
    end)
        if game.Players.LocalPlayer.Character then
           game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(300000, 50020, 300000)
        end
        
        if GUI:FindFirstChild("StatsGUI") then
            
    pcall(function()
        local manas = mysplit(GUI:FindFirstChild("StatsGUI").MagicEnergyGUI.ME.Text, "/")
        
        if GUI:FindFirstChild("StatsGUI").MagicEnergyGUI.ME.Text == "Label" or tonumber(manas[1]) <= Mana then
            game.Players.LocalPlayer.Character:BreakJoints()
        else
            local Backpack = game.Players.LocalPlayer.Backpack
                for i,v in ipairs(game.Players.LocalPlayer.Backpack:GetDescendants()) do
                    if v:IsA("Tool") and Backpack:FindFirstChild(v.Name) then
                        Backpack:FindFirstChild(v.Name).Parent = game.Players.LocalPlayer.Character
                    local args = {
                    [1] = {
                        [1] = game:GetService("Players").LocalPlayer.Character:FindFirstChild(v.Name),
                        [2] = Vector3.new(0,0,0),
                        [3] = Vector3.new(1e9, -1e9, -1e9),
                        [4] = true
                    }
                }
    
                game:GetService("ReplicatedStorage").Events.SpellCast:FireServer(unpack(args))
    
                local args = {
                    [1] = {
                        [1] = game:GetService("Players").LocalPlayer.Character:FindFirstChild(v.Name),
                        [2] = Vector3.new(0,0,0)
                    }
                }
    
                game:GetService("ReplicatedStorage").Events.SpellCast:FireServer(unpack(args))
                
                    for i,v1 in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
                        if v1:IsA'Tool' then
                            v1.Parent = game.Players.LocalPlayer.Backpack;
                        end
                            end    
                        end
                    end
                end
            end)
        end
    end
    end
end)

local Slider1 = Section1:CreateSlider("Mana น้อยกว่าจะ Reset", 100,1000,nil,true, function(Value)
	Mana = Value
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
