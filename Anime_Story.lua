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
local Section2 = Tab1:CreateSection("Misc.")

local UI_1 = Tab2:CreateSection("Menu")
local UI_2 = Tab2:CreateSection("Background")


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


local Button1 = Section2:CreateButton("Inf Jump", function()
    
    game:GetService("UserInputService").JumpRequest:connect(function()
    game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass('Humanoid'):ChangeState("Jumping")
end)

end)

local Toggle1 = Section2:CreateToggle("Speed", nil, function(x)
	getgenv().Speed_Hack = x
	while getgenv().Speed_Hack do wait()
	game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = WS
	end
end)


local Slider1 = Section2:CreateSlider("Speed", 0,100,nil,false, function(x)
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
