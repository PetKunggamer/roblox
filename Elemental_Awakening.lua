local Config = {
    WindowName = "Elemental Awakening",
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

local Button1 = Section2:CreateButton("Remove Killbricks", function()
	local Kb = game:GetService("Workspace").Killbricks
    for i,v in ipairs(Kb:GetDescendants()) do
        if v.Name == "TouchInterest" then
           v:Destroy()
        end
    end
end)
Button1:AddToolTip("No more Killbricks")

local Button2 = Section2:CreateButton("Safe Place", function()
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-7175, 1450, 2799)
end)
Button2:AddToolTip("ห้องแม่เซ็น")

Section1:CreateToggle("Auto Farm",nil,function(x)
    getgenv().AutoFarm = x 
local Backpack = game.Players.LocalPlayer.Backpack
local Char = game.Players.LocalPlayer.Character
local plr = game.Players.LocalPlayer


while getgenv().AutoFarm do wait(.5)
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
