local Config = {
    WindowName = "Syn0xz Hub [ Anime Story ]",
	Color = Color3.fromRGB(255,128,64),
	Keybind = Enum.KeyCode.RightShift
}

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/AlexR32/Roblox/main/BracketV3.lua"))()
local Window = Library:CreateWindow(Config, game:GetService("CoreGui"))

local Tab1 = Window:CreateTab("Main")
local Tab2 = Window:CreateTab("UI Settings")

local Section1 = Tab1:CreateSection("Farms")
local Section2 = Tab1:CreateSection("Use Item")
local Section3 = Tab1:CreateSection("Misc.")
local Section4 = Tab1:CreateSection("Sell Item")

local UI_1 = Tab2:CreateSection("Menu")
local UI_2 = Tab2:CreateSection("Background")

local Toggle1 = Section4:CreateToggle("Blessed Gem | 100 Gem", nil, function(x)
    getgenv().Blessed_Gem = x
    while getgenv().Blessed_Gem do wait(.15)
        game:GetService("ReplicatedStorage").Remotes.Sell:FireServer("Blessed Gem")
    end
end)

local Toggle2 = Section4:CreateToggle("Flame Gem | 100 Gem", nil, function(x)
    getgenv().Flame_Gem = x
    while getgenv().Flame_Gem do wait(.15)
        game:GetService("ReplicatedStorage").Remotes.Sell:FireServer("Flame Gem")
    end
end)

local Toggle3 = Section4:CreateToggle("Frost Gem | 100 Gem", nil, function(x)
    getgenv().Frost_Gem = x
    while getgenv().Frost_Gem do wait(.15)
        game:GetService("ReplicatedStorage").Remotes.Sell:FireServer("Frost Gem")
    end
end)

local Toggle4 = Section4:CreateToggle("Thunder Gem | 100 Gem", nil, function(x)
    getgenv().Thunder_Gem = x
    while getgenv().Thunder_Gem do wait(.15)
        game:GetService("ReplicatedStorage").Remotes.Sell:FireServer("Thunder Gem")
    end
end)

local Toggle5 = Section4:CreateToggle("Emerald | 25 Gem", nil, function(x)
    getgenv().Emerald = x
    while getgenv().Emerald do wait(.15)
        game:GetService("ReplicatedStorage").Remotes.Sell:FireServer("Emerald")
    end
end)

local Toggle6 = Section4:CreateToggle("Diamond | 25 Gem", nil, function(x)
    getgenv().Diamond = x
    while getgenv().Diamond do wait(.15)
        game:GetService("ReplicatedStorage").Remotes.Sell:FireServer("Diamond")
    end
end)

local Toggle7 = Section4:CreateToggle("Gold | 100 Coin", nil, function(x)
    getgenv().Gold = x
    while getgenv().Gold do wait(.15)
        game:GetService("ReplicatedStorage").Remotes.Sell:FireServer("Gold")
    end
end)

local Toggle8 = Section4:CreateToggle("Iron | 100 Coin", nil, function(x)
    getgenv().Iron = x
    while getgenv().Iron do wait(.15)
        game:GetService("ReplicatedStorage").Remotes.Sell:FireServer("Iron")
    end
end)






local Toggle1 = Section2:CreateToggle("Magic Gem", nil, function(x)
    getgenv().Use_Magic_Gem = x
    while getgenv().Use_Magic_Gem do wait(.05)
    game:GetService("ReplicatedStorage").Remotes.UseItem:FireServer("Magic Gem")
    end
end)


local Toggle1 = Section1:CreateToggle("Ore Farm", nil, function(x)
    
getgenv().ProximityPrompt_Farm = x
    while getgenv().ProximityPrompt_Farm do wait(.05)
        for i, v in pairs(game:GetService("Workspace"):GetDescendants()) do
            if v:FindFirstChild("ProximityPrompt") then
                fireproximityprompt(v.ProximityPrompt)
            end
        end
    end
end)

Toggle1:AddToolTip("ไปใกล้ๆ Ores แล้วเปิด")








local Button1 = Section3:CreateButton("Inf Jump", function()
    
    game:GetService("UserInputService").JumpRequest:connect(function()
    game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass('Humanoid'):ChangeState("Jumping")
end)

end)

local Toggle1 = Section3:CreateToggle("Speed", nil, function(x)
	getgenv().Speed_Hack = x
	while getgenv().Speed_Hack do wait()
	game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = WS
	end
end)


local Slider1 = Section3:CreateSlider("Speed", 0,100,nil,false, function(x)
	WS = x
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
