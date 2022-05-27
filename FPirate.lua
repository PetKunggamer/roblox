local Config = {
    WindowName = "Syn0xz Hub [ Floppa Pirate ]",
	Color = Color3.fromRGB(255,128,64),
	Keybind = Enum.KeyCode.RightShift
}

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/AlexR32/Roblox/main/BracketV3.lua"))()
local Window = Library:CreateWindow(Config, game:GetService("CoreGui"))

local Tab1 = Window:CreateTab("Main")
local Tab2 = Window:CreateTab("UI Settings")

local Section1 = Tab1:CreateSection("Farms")
local Section2 = Tab1:CreateSection("Stat Farms")


local UI_1 = Tab2:CreateSection("Menu")
local UI_2 = Tab2:CreateSection("Background")


local Toggle1 = Section2:CreateToggle("Fruit", nil, function(x)
	getgenv().Farm_Fruit = x
	while getgenv().Farm_Fruit do wait()
        for i = 1,10 do
            local args = {
                [1] = "Z",
                [2] = Vector3.new(0,0,0)}
            
            game:GetService("ReplicatedStorage").Remote.MainRemote:FireServer(unpack(args))
        end
    end
end)
Toggle1:AddToolTip("Hold Fruit")

local Weapons = {}
for i,v in ipairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
    if v:IsA("Tool") and not table.find(Weapons,v.Name) then
        table.sort(Weapons)
        table.insert(Weapons,v.Name)
        end
end

local Mobs = {} 
for i,v in ipairs(game:GetService("Workspace").Npc:GetDescendants()) do
    if v:FindFirstChild("HumanoidRootPart") and not table.find(Mobs,v.Name) then
        table.sort(Mobs)
        table.insert(Mobs,v.Name)
        end
end


Section1:CreateDropdown("Select Weapons",Weapons,function(x)
   Weaponpart2 = x
end)

Section1:CreateDropdown("Select Mob",Mobs,function(x)
   Mober = x
end)

Section1:CreateToggle("Auto Farm",nil,function(x)
    Farmer = x 
    while wait() and Farmer do
        for i,v in ipairs(game:GetService("Workspace").Npc:GetDescendants()) do
            if string.find(v.Name,Mober) and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health ~= 0 then
                    repeat 
                        if _G.QuestStart == true then 
                            wait()
                            else
                        task.wait()
                    pcall(function()
                            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(v.HumanoidRootPart.Position + Vector3.new(0,Distance,0),v.HumanoidRootPart.Position)
                    end)
                    end
                    until v:FindFirstChild("Died") or not Farmer or not v:FindFirstChild("Humanoid")
                end
            end
        end
end)

Section1:CreateSlider("Distance",0,-30,-6,false,function(x)
   Distance = x
end)


spawn(function()
    while task.wait() do
        if Farmer then
                pcall(function()    
                            game:GetService("Players").LocalPlayer.Character[Weaponpart2]:Activate()
                    end)
            end
        end
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
