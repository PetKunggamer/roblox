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
local Section3 = Tab1:CreateSection("Trinket")
local Section4 = Tab1:CreateSection("Quick Join Dungeon")
local Section5 = Tab1:CreateSection("TweenService")
local Section6 = Tab1:CreateSection("NPC")

local UI_1 = Tab2:CreateSection("Menu")
local UI_2 = Tab2:CreateSection("Background")

local Dropdown1 = Section4:CreateDropdown("เลือกดันเจี้ยน", {"Castle Rock","Eeris","Catacomb"}, function(Name)
	if Name == "Castle Rock" then
	    fireclickdetector(game:GetService("Workspace")["The Eagle"].ClickDetector)
	elseif Name == "Eeris" then
	    fireclickdetector(game:GetService("Workspace").EerisOpen.HumanoidRootPart.ClickDetector)
	elseif Name == "Catacomb" then
	    fireclickdetector(game:GetService("Workspace").Map.dungeonThingIdk.trapdoor.ClickDetector)
	end
end)

Dropdown1:SetOption("Default")

local NPC = {}
for i,v in ipairs(game:GetService("Workspace").NPCs.Trainers:GetDescendants()) do
    if v:FindFirstChild("HumanoidRootPart") and not table.find(NPC,v.Name) then
        table.sort(NPC)
        table.insert(NPC,v.Name)
    end
end

Section6:CreateDropdown("พูดคุย NPC",NPC,function(x)
    for i,v in ipairs(game:GetService("Workspace").NPCs.Trainers:GetDescendants()) do
        if v.Name == x and v:FindFirstChild("HumanoidRootPart") then
            fireclickdetector(v.ClickDetector)
            end
        end
end)

Section6:CreateDropdown("เทเลพอร์ตไปที่ NPC",NPC,function(x)
    for i,v in ipairs(game:GetService("Workspace").NPCs.Trainers:GetDescendants()) do
        if v.Name == x and v:FindFirstChild("HumanoidRootPart") then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").Teleports.Teleport1.CFrame
            wait(.35)
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v:FindFirstChild("HumanoidRootPart").CFrame
            end
        end
end)
local Button2
if getconnections and typeof(getconnections) == "function" then
    Button2 = Section2:CreateButton("ปิดฆ่าอิฐ", function()
        for _, part in pairs(workspace.Map.KillBricks:GetChildren()) do
            if part:IsA("BasePart") then
                for _, connection in pairs(getconnections(part.Touched)) do
                    connection:Disable()
                end
                for _, connection in pairs(getconnections(part.TouchEnded)) do
                    connection:Disable()
                end
                wait()
            end
        end
    end)
end
local Button1 = Section2:CreateButton("ประตูลูกตา", function()
    fireclickdetector(game:GetService("Workspace").EYEBALLS.ClickEyes.Eye1.ClickDetector)
    fireclickdetector(game:GetService("Workspace").EYEBALLS.ClickEyes.Eye2.ClickDetector)
    fireclickdetector(game:GetService("Workspace").EYEBALLS.ClickEyes.Eye3.ClickDetector)
end)

local Button5 = Section2:CreateButton("เร่งด่วนล้ม", function()
game:GetService("Players").LocalPlayer.Character.FallDamage.RemoteEvent:FireServer(9999)
end)
Button5:AddToolTip("ปิด Nofall ก่อน")
    
local Toggle1 = Section3:CreateToggle("รับอัตโนมัติ", nil, function(x)

function getrealfolder()
    for _, fd in pairs(workspace:GetChildren()) do
        if #fd:GetChildren() > 1 and fd.Name == "MouseIgnore" then
            for _, p in pairs(fd:GetChildren()) do
                if p.Name:find("{") and p.Name:find("}") then
                    return fd
                end
            end
        end
    end
end
_G.AutoPick = x
while _G.AutoPick do
    local realfd = getrealfolder()
    if realfd then
        for _,p in pairs(realfd:GetChildren()) do
            if p:IsA("Model") and #p:GetChildren() > 0 then
                if (p:GetChildren()[1].Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 50 then
                    local string_1 = "Trinket";
                    local string_2 = p.Name
                    if string_2:find("{") and string_2:find("}") then
                        --game:GetService("ReplicatedStorage").Remotes.RequestPickup
                        local Target = game:GetService("ReplicatedStorage").Remotes.RequestPickup;
                        --printconsole(string.format("%s, %s", string_1, string_2))
                        Target:FireServer(string_1, string_2);
                    end
                end
            end
            game:GetService("RunService").Stepped:Wait()
        end
    else
        for i=1,30 do
            game:GetService("RunService").Stepped:Wait()
        end
    end
end
--function getrealtick()
--    for _,v in pairs(game:GetService("Workspace"):GetChildren())do
--        if v.Name == "MouseIgnore" and #v:GetChildren() > 0 then
--            return v
--        end
--    end
--end
--while _G.AutoPickup do wait()
--    local fd = getrealtick()
--    if fd then
--        for _,v in pairs(fd:GetChildren()) do
--            for _,ckd in pairs(v:GetDescendants()) do
--                if ckd:IsA("ClickDetector") then
--                    fireclickdetector(ckd)
--                end
--            end
--        end
--    end
--end

end)

local Toggle2 = Section3:CreateToggle("รับอัตโนมัติ (เวอร์ชั่น TP)", nil, function(x)
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
local Toggle3 = Section3:CreateToggle("โลงศพอัตโนมัติ", nil, function(x)
    function getdistantfrompart(p)
    return (p.Position - game:GetService("Players").LocalPlayer.Character:GetPrimaryPartCFrame().p).Magnitude
end
function getcaskets(stud)
    local nearcaskets={}
    local counter = 0
    for _,casket in pairs(game:GetService("Workspace").Map.dungeonThingIdk.Caskets:GetChildren()) do
        if getdistantfrompart(casket.casketTOP.Union) <= stud then
            counter = counter + 1
            nearcaskets[counter] = casket
        end
    end
    return nearcaskets
end
function fireproximityprompts(stud)
    local nearcaskets = getcaskets(stud)
    for _,casket in pairs(nearcaskets) do
        for _,proximityprompt in pairs(casket:GetDescendants())do
            if proximityprompt:IsA("ProximityPrompt") then
                fireproximityprompt(proximityprompt,stud)
            end
        end
    end
end


_G.AutiCastket = x
while _G.AutiCastket do wait(.5) 
    
    fireproximityprompts(100)
end
end)

local Toggle1 = Section1:CreateToggle("ความเร็วในการเดิน", nil, function(x)
	getgenv().Speed_Hack = x
	while getgenv().Speed_Hack do wait()
	game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = WS
	end
end)

--[[Toggle1:CreateKeybind("F1", function(Key)
end)
]]
local Toggle2 = Section1:CreateToggle("กระโดดพลังงาน", nil, function(x)
	getgenv().JP_Hack = x
	while getgenv().JP_Hack do wait()
	game.Players.LocalPlayer.Character.Humanoid.JumpPower = JP
	end
end)
--[[
Toggle2:CreateKeybind("F2", function(Key)
end)
]]

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
