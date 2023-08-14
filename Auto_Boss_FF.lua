function Notify(Text)
    game.StarterGui:SetCore("SendNotification", {
    Title = "Syn0xz Hub";
    Text = Text;
    Duration = 5;
})
end

function AntiFall()
    local Character = game:GetService("Players").LocalPlayer.Character
    if Character then
        local hrp = Character:FindFirstChild("HumanoidRootPart")
        if hrp then
            hrp.Velocity = Vector3.new(0,0,0)
        end
    end
end

local function NoclipLoop()
	if game.Players.LocalPlayer.Character ~= nil then
		for _, child in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
			if child:IsA("BasePart") and child.CanCollide == true then
				child.CanCollide = false
			end
		end
	end
end

function tp(CF)
    local TweenService = game:GetService("TweenService")
    local Player = game:GetService("Players").LocalPlayer
    local Humanoid = game:GetService("Players").LocalPlayer.Character:FindFirstChild("Humanoid")
    if Player.Character then
        local HumanoidRootPart = Player.Character:FindFirstChild("HumanoidRootPart")
        if HumanoidRootPart then
            local tween =
                TweenService:Create(
                HumanoidRootPart,
                TweenInfo.new((CF.Position - HumanoidRootPart.Position).magnitude / 110),
                {CFrame = CF}
            )
            tween:Play()
        end
    end
end


function Attack()
    local Character = game:GetService("Players").LocalPlayer.Character
    if Character then
        local FistCombat = Character:FindFirstChild("FistCombat")
        if FistCombat then
            for i = 1, 4 do
                local args = {
                [1] = i,
                [2] = FistCombat,
                [3] = CFrame.new(),
                [4] = true
            }
            game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("CombatEvent"):FireServer(unpack(args))
            end
        end
    end
end

function Instant()
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
                        if v.Name == "VengefulInfernalDemon" then
                            if playerDmg.Value >= 220 then
                                Hum.Health = 0
                            end
                        elseif v.Name == "ShoNPC" then
                            if playerDmg.Value >= 200 then
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

function Hop()
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
end

function Chest()
    for i,v in ipairs(workspace.LiveChests:GetChildren()) do
        if v.Name == "Chest" then
            local ClickPart = v:FindFirstChild("ClickPart")
            if ClickPart then
                local ClickDetector = ClickPart:FindFirstChild("ClickDetector")
                if ClickDetector then
                    fireclickdetector(ClickDetector)
                end
            end
        end
    end
end

function Rejoin()
game:GetService'TeleportService':TeleportToPlaceInstance(game.PlaceId,game.JobId,game:GetService'Players'.LocalPlayer)
end


function clickUiButton(v, state)
local virtualInputManager = game:GetService('VirtualInputManager')
	virtualInputManager:SendMouseButtonEvent(v.AbsolutePosition.X + v.AbsoluteSize.X / 2, v.AbsolutePosition.Y + 50, 0, state, game, 1)
end

function Died()
    for i,v in ipairs(game.Players.LocalPlayer.Character:GetChildren()) do
        if v.Name == "Humanoid" then
            if v.Health < 1 then
                v.Health = 0
            end
        end
    end
end

function Died()
    for i,v in ipairs(workspace.Alive:GetChildren()) do
        local Char = game.Players.LocalPlayer.Character
        if Char then
            if v.Name == Char.Name and Char ~= nil then
                local Hum = v:FindFirstChild("Humanoid")
                if Hum then
                    if Hum.Health < 1 then
                        Hum.Health = 0
                    end
                end
            end
        end
    end
end

function TO_MOB()
for i,v in ipairs(workspace.Alive:GetChildren()) do
    if v.Name == getgenv().Boss and game.Players.LocalPlayer.Character ~= nil then
        local target = v:FindFirstChild("HumanoidRootPart")
        local Char = game.Players.LocalPlayer.Character
        if target then
            if Char then
                tp((target.CFrame));
                end
            end
        end
    end
end

repeat wait() until game:IsLoaded()

for i = 1,3 do
    print(i)
    wait(1)
end

while true do task.wait()
AntiFall()
Died()
    if not workspace.Alive:FindFirstChild(getgenv().Boss) then
        for i = 1,10 do
            Hop()
            Notify("Not Spawn Yet\nServer Hopping")
            wait(10)
        end
        else
            NoclipLoop()
            TO_MOB()
            Attack()
            Instant()
            Chest()
        
    end
end
