local Config = {
    WindowName = "Syn0xz Hub [ EPSILON LINEAGE 2]",
	Color = Color3.fromRGB(255,128,64),
	Keybind = Enum.KeyCode.RightShift
}

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/AlexR32/Roblox/main/BracketV3.lua"))()
local Window = Library:CreateWindow(Config, game:GetService("CoreGui"))

local Tab1 = Window:CreateTab("Main")
local Tab2 = Window:CreateTab("UI Settings")

local Section1 = Tab1:CreateSection("Farms")
local Section2 = Tab1:CreateSection("Misc.")
local Section5 = Tab2:CreateSection("Menu")
local Section6 = Tab2:CreateSection("Background")

local Toggle1 = Section2:CreateToggle("Auto PickUp", nil, function(x)
	_G.AutoPickup = x
function getrealtick()
    for _,v in pairs(game:GetService("Workspace"):GetChildren())do
        if v.Name == "MouseIgnore" and #v:GetChildren() > 0 then
            return v
        end
    end
end
while _G.AutoPickup do wait()
    local fd = getrealtick()
    if fd then
        for _,v in pairs(fd:GetChildren()) do
            for _,ckd in pairs(v:GetDescendants()) do
                if ckd:IsA("ClickDetector") then
                    fireclickdetector(ckd)
                     -- game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = ckd.Parent.Parent.CFrame
                end
            end
        end
    end
end

end)

local Toggle2 = Section2:CreateToggle("Auto PickUp (TP Version)", nil, function(x)
	_G.AutoPickup = x
function getrealtick()
    for _,v in pairs(game:GetService("Workspace"):GetChildren())do
        if v.Name == "MouseIgnore" and #v:GetChildren() > 0 then
            return v
        end
    end
end
while _G.AutoPickup do wait()
    local fd = getrealtick()
    if fd then
        for _,v in pairs(fd:GetChildren()) do
            for _,ckd in pairs(v:GetDescendants()) do
                if ckd:IsA("ClickDetector") then
                    fireclickdetector(ckd)
                      game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = ckd.Parent.Parent.CFrame
                end
            end
        end
    end
end

end)

local Toggle1 = Section1:CreateToggle("WalkSpeed", nil, function(x)
	getgenv().Speed_Hack = x
	while getgenv().Speed_Hack do wait()
	game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = WS
	end
end)

--[[Toggle1:CreateKeybind("F1", function(Key)
end)
]]
local Toggle2 = Section1:CreateToggle("JumpPower", nil, function(x)
	getgenv().JP_Hack = x
	while getgenv().JP_Hack do wait()
	game.Players.LocalPlayer.Character.Humanoid.JumpPower = JP
	end
end)
--[[
Toggle2:CreateKeybind("F2", function(Key)
end)
]]

local Slider1 = Section1:CreateSlider("Speed", 0,200,nil,false, function(x)
	WS = x
end)

local Slider1 = Section1:CreateSlider("JumpPower", 0,200,nil,false, function(x)
	JP = x
end)

local Toggle3 = Section5:CreateToggle("UI Toggle", nil, function(State)
	Window:Toggle(State)
end)
Toggle3:CreateKeybind(tostring(Config.Keybind):gsub("Enum.KeyCode.", ""), function(Key)
	Config.Keybind = Enum.KeyCode[Key]
end)
Toggle3:SetState(true)

local Colorpicker3 = Section5:CreateColorpicker("UI Color", function(Color)
	Window:ChangeColor(Color)
end)
Colorpicker3:UpdateColor(Config.Color)

-- credits to jan for patterns
local Dropdown3 = Section6:CreateDropdown("Image", {"Default","Hearts","Abstract","Hexagon","Circles","Lace With Flowers","Floral"}, function(Name)
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

local Colorpicker4 = Section6:CreateColorpicker("Color", function(Color)
	Window:SetBackgroundColor(Color)
end)
Colorpicker4:UpdateColor(Color3.new(1,1,1))

local Slider3 = Section6:CreateSlider("Transparency",0,1,nil,false, function(Value)
	Window:SetBackgroundTransparency(Value)
end)
Slider3:SetValue(0)

local Slider4 = Section6:CreateSlider("Tile Scale",0,1,nil,false, function(Value)
	Window:SetTileScale(Value)
end)
Slider4:SetValue(0.5)
