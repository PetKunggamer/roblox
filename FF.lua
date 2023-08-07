local DiscordLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/discord"))()
local win = DiscordLib:Window("discord library")
local serv = win:Server("Preview", "")
local tgls = serv:Channel("Main")
local fact = serv:Channel("Factions")
local helpful = serv:Channel("Helpful")
local tp = serv:Channel("Teleport")

function noclip()
    for _,noclip in pairs(game:GetService("Players").LocalPlayer.Character:GetChildren()) do
        if noclip:IsA("MeshPart") or noclip:IsA("Part") then
            noclip.CanCollide = false
        end
    end
end

function clip()
    for _,clip in pairs(game:GetService("Players").LocalPlayer.Character:GetChildren()) do
        if clip:IsA("MeshPart") or clip:IsA("Part") then
            clip.CanCollide = false
        end
    end
end

local TweenService = game:GetService("TweenService")
local Player = game:GetService("Players").LocalPlayer
local Humanoid = game:GetService("Players").LocalPlayer.Character:FindFirstChild("Humanoid")

function tp(CF)
    if Player.Character then
        local HumanoidRootPart = Player.Character:FindFirstChild("HumanoidRootPart")
        if HumanoidRootPart then
            local tween =
                TweenService:Create(
                HumanoidRootPart,
                TweenInfo.new((CF.Position - HumanoidRootPart.Position).magnitude / 120),
                {CFrame = CF}
            )
            tween:Play()
            tween.Completed:wait()
            HumanoidRootPart.Velocity = Vector3.new(0,0,0)
        end
    end
end

function clickUiButton(v, state)
local virtualInputManager = game:GetService('VirtualInputManager')
	virtualInputManager:SendMouseButtonEvent(v.AbsolutePosition.X + v.AbsoluteSize.X / 2, v.AbsolutePosition.Y + 50, 0, state, game, 1)
end

function Notify(Text)
game.StarterGui:SetCore("SendNotification", {
    Title = "Syn0xz Hub";
    Text = Text;
    Duration = "300";
    Button1 = "Done!";
})
end

-- Function to create ESP for a specific mob
function CreateESP(Mob_Name)
    for __, v in pairs(workspace.Alive:GetChildren()) do
        if v.Name:find(Mob_Name) then
            local ESP_DETECTED = v:FindFirstChild(Mob_Name.."_ESP")
            if ESP_DETECTED then
            else
                local BillboardGui = Instance.new("BillboardGui", v)
                BillboardGui.Name = Mob_Name.."_ESP"
                BillboardGui.Size = UDim2.new(10, 0, 10, 0)
                BillboardGui.AlwaysOnTop = true

                local Frame = Instance.new("Frame", BillboardGui)
                Frame.Size = UDim2.new(1, 0, 1, 0)
                Frame.BackgroundTransparency = 1
                Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)

                local TextLabel = Instance.new("TextLabel", Frame)
                TextLabel.Size = UDim2.new(1, 0, 0.5, 0)
                TextLabel.Position = UDim2.new(0, 0, 0.5, 0)
                TextLabel.BackgroundTransparency = 1
                TextLabel.Font = Enum.Font.SourceSansBold
                TextLabel.TextSize = 18
                TextLabel.Text = Mob_Name .. "\nHealth: " .. tostring(v.Humanoid.Health)
                TextLabel.TextColor3 = Color3.new(1, 1, 1)
                TextLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
                TextLabel.TextStrokeTransparency = 0.5

                local function UpdateHealth()
                    TextLabel.Text = Mob_Name .. "\nHealth: " .. tostring(v.Humanoid.Health)
                end

                v.Humanoid.Changed:Connect(UpdateHealth)
                Notify(Mob_Name .. " ESP has been added.")

                -- Store the ESP elements in separate tables based on the mob name
                _G.ESPElements = _G.ESPElements or {}
                _G.ESPElements[Mob_Name] = _G.ESPElements[Mob_Name] or {}
                table.insert(_G.ESPElements[Mob_Name], BillboardGui)
            end
        end
    end
end


function Quest_Thief()
    local Quest = game:GetService("Players").LocalPlayer.PlayerGui.Status:FindFirstChild("NotoficationTimer")
    if not Quest then
        local Crook = workspace.LiveNPCS.Crook
        tp((Crook.HumanoidRootPart))
        fireclickdetector(Crook.ClickPart.ClickDetector)
        else

        local Quest = game:GetService("Players").LocalPlayer.PlayerGui.Status:FindFirstChild("NotoficationTimer")
        if Quest.Visible == true and Quest.Text.Text:match("car") then
            for i,v in ipairs(workspace.MissionItems:GetChildren()) do
                if v.Name:find("CarModel") then
                    fireclickdetector(v.ClickDetector)
                end
            end
        end

        if Quest.Visible == true and Quest.Text.Text:match("graffiti") then
            for i,v in ipairs(workspace.MissionItems.Graffiti:GetChildren()) do
                if v.Name:find("Part") then
                    fireclickdetector(v.ClickDetector)
                end
            end
        end
    end
end

-- Function to destroy ESP elements for a specific mob
function DestroyESPMob(Mob_Name)
    if _G.ESPElements and _G.ESPElements[Mob_Name] then
        for _, esp in ipairs(_G.ESPElements[Mob_Name]) do
            esp:Destroy()
        end
        _G.ESPElements[Mob_Name] = nil
    end
end

tgls:Toggle("Notify Infernal Demon", false, function(bool)
    _G.Infernal = bool
    while _G.Infernal do wait()
        if _G.Infernal then
            CreateESP("Infernal Demon")
        else
            DestroyESPMob("Infernal Demon")
        end
    end
end)

tgls:Toggle("Notify ShoNPC", false, function(bool)
    _G.ShoNPC = bool
    while _G.ShoNPC do wait()
        if _G.ShoNPC then
            CreateESP("ShoNPC")
        else
            DestroyESPMob("ShoNPC")
        end
    end
end)

tgls:Toggle("Auto Instant Kill [BETA]", false, function(bool)
    _G.Instant = bool
    while _G.Instant do wait()
    pcall(function()
    for i,v in ipairs(workspace.Alive:GetChildren()) do
    local target = v:FindFirstChild("HumanoidRootPart")
    if target then
        local dist = game.Players.LocalPlayer:DistanceFromCharacter(target.Position)
        if dist < 40 and v.Name ~= game.Players.LocalPlayer.Character.Name then
            local CombatFolder = v:FindFirstChild("CombatFolder")
            if CombatFolder then
                local playerDmg = CombatFolder:FindFirstChild(game.Players.LocalPlayer.Character.Name)
                if playerDmg then
                    local Hum = v:FindFirstChildOfClass("Humanoid")
                    local Hum_Percent = Hum.Health / Hum.MaxHealth * 100
                    if Hum then
                        if v.Name == "ShoNPC" then
                            if playerDmg.Value >= 200 then
                                print(Hum_Percent)
                                Hum.Health = 0
                            end
                        else
                            if Hum_Percent < 80 then
                                Hum.Health = 0
                            end
                        end
                    end
                end
            end
        end
    end
    end
    end)
    end
end)

tgls:Toggle("Auto Hit [BETA]", false, function(bool)
_G.Aura_hit = bool
    while _G.Aura_hit do wait()
    for i = 1, 4 do
        local args = {
        [1] = i,
        [2] = game:GetService("Players").LocalPlayer.Character.FistCombat,
        [3] = CFrame.new(2970.147705078125, 838.2996215820312, 3388.07568359375, -0.9999902248382568, 1.9033340237228913e-08, -0.004418162629008293, 1.9110876436911894e-08, 1, -1.7507286287354873e-08, 0.004418162629008293, -1.7591549550388663e-08, -0.9999902248382568),
        [4] = true
    }

    game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("CombatEvent"):FireServer(unpack(args))
    end
    end
end)

tgls:Button("Instant Kill",function()
    for i,v in ipairs(workspace.Alive:GetChildren()) do
        local hrp_target = v:FindFirstChild("HumanoidRootPart")
        if hrp_target then
            local dist = game.Players.LocalPlayer:DistanceFromCharacter(hrp_target.Position)
            if dist < 30 and v.Name ~= game.Players.LocalPlayer.Character.Name then
                local hum = v:FindFirstChildOfClass("Humanoid")
                if hum then
                    hum.Health = 0
                end
            end
        end
    end
end)

tgls:Button("Reset Character [Escape From InCombat]",function()
    game.Players.LocalPlayer.Character:BreakJoints()
end)

tgls:Button("Hop Server",function()
    httprequest = (syn and syn.request) or (http and http.request) or http_request or (fluxus and fluxus.request) or request
local HttpService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")
if httprequest then
		local servers = {}
		local req = httprequest({Url = string.format("https://games.roblox.com/v1/games/%d/servers/Public?sortOrder=Desc&limit=100", game.PlaceId)})
		local body = HttpService:JSONDecode(req.Body)
		if body and body.data then
			for i, v in next, body.data do
				if type(v) == "table" and tonumber(v.playing) and tonumber(v.maxPlayers) and v.playing < v.maxPlayers and v.id ~= JobId then
					table.insert(servers, 1, v.id)
				end
			end
		end
		if #servers > 0 then
			TeleportService:TeleportToPlaceInstance(game.PlaceId, servers[math.random(1, #servers)], game.Players.LocalPlayer)
		else
			return notify("Serverhop", "Couldn't find a server.")
		end
	end
end)

tgls:Button("Hop Server [Low Player]",function()
    local Http = game:GetService("HttpService")
    local TPS = game:GetService("TeleportService")
    local Api = "https://games.roblox.com/v1/games/"

    local _place = game.PlaceId
    local _servers = Api.._place.."/servers/Public?sortOrder=Asc&limit=100"
    function ListServers(cursor)
    local Raw = game:HttpGet(_servers .. ((cursor and "&cursor="..cursor) or ""))
        return Http:JSONDecode(Raw)
    end

    local Server, Next; repeat
        local Servers = ListServers(Next)
        Server = Servers.data[1]
        Next = Servers.nextPageCursor
    until Server

    TPS:TeleportToPlaceInstance(_place,Server.id,game.Players.LocalPlayer)
end)

helpful:Toggle("Auto Strength", false, function(bool)

_G.Auto_Strength = bool
while _G.Auto_Strength do task.wait()
    local PlayerGui = game:GetService("Players").LocalPlayer.PlayerGui
        if PlayerGui then
            local TrainingGui = PlayerGui:FindFirstChild("TrainingGui")
            if TrainingGui then
                local KeyArea = TrainingGui:FindFirstChild("KeyArea")
                if KeyArea then
                    local ClickButton = KeyArea:FindFirstChild("ClickButton")
                    if ClickButton then
                        clickUiButton(ClickButton, true)
                        clickUiButton(ClickButton, false)
                        else
                        local TextGUI = game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("TextGUI")
                        if TextGUI then
                            clickUiButton(TextGUI.Frame.Accept, true)
                            else
                            for i,v in ipairs(workspace.Trainings.Strength:GetChildren()) do
                                if v.Name == "StrengthTraining" then
                                    local ClickPart = v:FindFirstChild("ClickPart")
                                    if ClickPart then
                                    if game.Players.LocalPlayer:DistanceFromCharacter(ClickPart.Position) < 10 then
                                        fireclickdetector(ClickPart.ClickDetector)
                                    end
                                end
                            end
                        end
                        end
                    end
                end
            end
        end
    end
end)


helpful:Toggle("Auto Defense", false, function(bool)
    _G.Defense = bool
    while _G.Defense do wait()
    local TextGUI = game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("TextGUI")
    if TextGUI then
        clickUiButton(TextGUI.Frame.Accept, true)
        else
            for i,v in ipairs(workspace.Trainings.Defense:GetChildren()) do
                if v.Name == "DefenseTraining" then
                    local ClickPart = v:FindFirstChild("ClickPart")
                    if ClickPart then
                    if game.Players.LocalPlayer:DistanceFromCharacter(ClickPart.Position) < 10 then
                        fireclickdetector(ClickPart.ClickDetector)
                    end
                end
            end
        end
    end
        for i, v in pairs(game:GetService("Players").LocalPlayer.PlayerGui.TrainingGui.KeyOrder:GetChildren()) do
           if v:IsA("Frame") then
               game:GetService("ReplicatedStorage").Events.TrainingEvent:FireServer("Defense", v.Key.Text)
           end
        end
    end
end)

helpful:Toggle("Auto Press G", false, function(bool)
    _G.Auto_Key_G = bool
    while _G.Auto_Key_G do wait(1)
        game:GetService("VirtualInputManager"):SendKeyEvent(true,"G",false,game)
    end
end)

tp:Button("Business Man Teleport",function()
    local Business_Man = workspace.LiveNPCS:FindFirstChild("Business Man")
    if Business_Man then
        tp((Business_Man.HumanoidRootPart.CFrame))
    else
        Notify("Not Spawn Yet")
    end
end)

tp:Button("Noru Teleport",function()
    local Noru = workspace.LiveNPCS:FindFirstChild("Noru")
    if Noru then
        tp((Noru.HumanoidRootPart.CFrame));
    else
        Notify("Not Spawn Yet")
    end
end)

fact:Toggle("Theif", false, function(bool)
    _G.Theif = bool
    while _G.Theif do task.wait()
    local TextGUI = game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("TextGUI")
        if TextGUI then
            clickUiButton(TextGUI.Frame.Accept, true)
        end
        Quest()
    end
end)

serv:Channel("by Syn0xz")
