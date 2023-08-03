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

-- Function to destroy ESP elements for a specific mob
function DestroyESPMob(Mob_Name)
    if _G.ESPElements and _G.ESPElements[Mob_Name] then
        for _, esp in ipairs(_G.ESPElements[Mob_Name]) do
            esp:Destroy()
        end
        _G.ESPElements[Mob_Name] = nil
    end
end

local DiscordLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/discord"))()
local win = DiscordLib:Window("discord library")
local serv = win:Server("Preview", "")
local tgls = serv:Channel("Main")
local stat = serv:Channel("Helpful Stat")
local tp = serv:Channel("Teleport")

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


tgls:Button(
    "Instant Kill",
    function()
    function Kill()
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
end
Kill()
end)

tgls:Button(
    "Hop Server",
    function()
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

stat:Toggle("Strenght Button Yhai Ned Noi", false, function(bool)
    _G.B = bool
    while _G.B do task.wait()
    local CB = game:GetService("Players").LocalPlayer.PlayerGui.TrainingGui.KeyArea:FindFirstChild("ClickButton")
        if CB then
            CB.Size = UDim2.new(4,5,6,7)
            CB.Position = UDim2.new{-1,-1,-1,-1}
        end
    end
end)


tp:Button(
    "Business Man",
    function()
    local businessMan = workspace.LiveNPCS:FindFirstChild("Business Man")
    if businessMan then
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = businessMan.HumanoidRootPart.CFrame
    else
        Notify("Business Man not found.")
    end
end)

serv:Channel("by Śʏɴ0xž")
