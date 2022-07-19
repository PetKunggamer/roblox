local Config = {
    WindowName = "Syn0xz Hub [ Project Slayer 🌊 ]",
	Color = Color3.fromRGB(255,128,64),
	Keybind = Enum.KeyCode.RightShift
}

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/AlexR32/Roblox/main/BracketV3.lua"))()
local Window = Library:CreateWindow(Config, game:GetService("CoreGui"))

local Tab1 = Window:CreateTab("Main")
local Tab2 = Window:CreateTab("UI Settings")

local Section1 = Tab1:CreateSection("Farms")
local Section2 = Tab1:CreateSection("Teleports")
local Section3 = Tab1:CreateSection("Mics.")

local UI_1 = Tab2:CreateSection("Menu")
local UI_2 = Tab2:CreateSection("Background")

local TextBox1 = Section3:CreateTextBox("หายตัวแบบเท่ๆ มอนไม่ตีโคตรตึง\nใส่เลข -1 = ไม่หายตัวมอนไม่ตี\nใส่เลข 1 = หายตัวมอนไม่ตีเหมือนกัน", "ใส่เลข (only)", true, function(Value)
    for i,v in ipairs(game.Players.LocalPlayer.Character:GetDescendants()) do
        local args = {
            [1] = "Change_Transparency",
            [2] = {
                [1] = {
                    [1] = v,
                    [2] = tonumber(Value)
                },
            }
        }
        
        game:GetService("ReplicatedStorage").Remotes.To_Server.Handle_Initiate_S:FireServer(unpack(args))
        end
        wait(1.5)
        local args = {
            [1] = "Change_Transparency",
            [2] = {
                [1] = {
                    [1] = game.Players.LocalPlayer.Character.HumanoidRootPart,
                    [2] = 1
                },
            }
        }
        
        game:GetService("ReplicatedStorage").Remotes.To_Server.Handle_Initiate_S:FireServer(unpack(args))
end)

TextBox1:AddToolTip("ใส่ได้แค่ระหว่าง 0 - 1")

local Label1 = Section1:CreateLabel("Label 1")
Label1:UpdateText("ไม่ทำโว้ย Hehe bob วางไว้ประดับ")


local Label2 = Section2:CreateLabel("Label 2")
Label2:UpdateText("โดนแบนสูงนะน้อง แบบ Instant Banned\nเพาะฉะนู้น อย่ากดถี่นะน้อง")
local Dropdown1 = Section2:CreateDropdown("Select Place to Teleport (High Risk)", {"Kiribating Village","Zapiwara Cave","Butterfly Mansion","Zapiwara Mountain","Ushumaru Village","Waroru Cave","Kabiwaru Village","Abubu Cave","Final Selection","Ouwbayashi Home","Dangerous Woods","Slasher Demon"},function(Name)
	function In()
        local args = {
            [1] = "Enter_Nezuko_Box",
            [2] = game:GetService("Players").LocalPlayer.Character,
            [3] = workspace.KnockedOut:FindFirstChild("Sealed Box")
        }
        
        game:GetService("ReplicatedStorage").Remotes.To_Server_commends:FireServer(unpack(args))
    end

    function Out()
        local args = {
            [1] = "remove_item",
            [2] = game:GetService("ReplicatedStorage").PlayerValues[game.Players.LocalPlayer.Name].carryvictim
        }
        
        game:GetService("ReplicatedStorage").Remotes.To_Server.Handle_Initiate_S:FireServer(unpack(args))
    end
    function On()
        game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = true
    end
    
    function Off()
        game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false
    end

	if Name == "Kiribating Village" then
	    In() wait(1) In() wait(4)
	        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(124, 295, -1625)On()wait(.75)
	    Out()Off()
	elseif Name == "Zapiwara Cave" then
	    In() wait(1) In() wait(4)
	        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(31, 291, -2419)On() wait(.75)
	    Out()Off()
	elseif Name == "Butterfly Mansion" then
	    In() wait(1) In() wait(4)
	        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(2990, 331, -3867)On() wait(.75)
	    Out()Off()
	elseif Name == "Zapiwara Mountain" then
	    In() wait(1) In() wait(4)
	        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-343, 437, -2383)On() wait(.75)
	    Out()Off()
	elseif Name == "Ushumaru Village" then
	    In() wait(1) In() wait(4)
	        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-469, 289, -3331)On() wait(.75)
	    Out()Off()
	elseif Name == "Waroru Cave" then
	    In() wait(1) In() wait(4)
	        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(614, 277, -2464)On() wait(.75)
	    Out()Off()
	elseif Name == "Kabiwaru Village" then
	    In() wait(1) In() wait(4)
	        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1995, 331, -2974)On() wait(.75)
	    Out()Off()
	elseif Name == "Abubu Cave" then
	    In() wait(1) In() wait(4)
	        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1074, 291, -3553)On() wait(.75)
	    Out()Off()
	elseif Name == "Final Selection" then
	    In() wait(1) In() wait(4)
	        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(5158, 381, -2426)On() wait(.75)
	    Out()Off()
	elseif Name == "Ouwbayashi Home" then
	    In() wait(1) In() wait(4)
	        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1337, 331, -4578)On() wait(.75)
	    Out()Off()
	elseif Name == "Dangerous Woods" then
	    In() wait(1) In() wait(4)
	        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(4018, 358, -3955)On() wait(.75)
	    Out()Off()
	elseif Name == "Slasher Demon" then
	    In() wait(1) In() wait(4)
	        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(4337, 358, -4236)On() wait(.75)
	    Out()Off()
	end
end)

Dropdown1:SetOption("Default")

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
