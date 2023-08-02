-- Function to show notifications
function Notify(Text)
    game:GetService("ReplicatedStorage").Assets.Sounds["za water"]:Play()
    game.StarterGui:SetCore("SendNotification", {
        
        Title = "Hueco Mundo",
        Text = Text,
        Duration = 3,
        Button1 = "Done!",
    })
end

-- Function to create ESP for a specific mob
function CreateESP(Mob_Name)
    for __, v in pairs(game.workspace.Entities:GetChildren()) do
        if v.Name:find(Mob_Name) then
            local ESP_DETECTED = v:FindFirstChild(Mob_Name.."_ESP")
            if ESP_DETECTED then
                print("Already added ESP to mob")
            else
                local BillboardGui = Instance.new("BillboardGui", v)
                BillboardGui.Name = Mob_Name.."_ESP"
                BillboardGui.Size = UDim2.new(10, 0, 10, 0)
                BillboardGui.AlwaysOnTop = true

                local Frame = Instance.new("Frame", BillboardGui)
                Frame.Size = UDim2.new(1, 0, 1, 0)
                Frame.BackgroundTransparency = 0.5
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
local tgls = serv:Channel("ESP and Notify")

tgls:Toggle("Notify Jackal", false, function(bool)
    _G.Jackal = bool
    while _G.Jackal do wait()
        if _G.Jackal then
            CreateESP("Jackal")
        else
            DestroyESPMob("Jackal")
        end
    end
end)

tgls:Toggle("Notify Fishbone", false, function(bool)
    _G.Fishbone = bool
    while _G.Fishbone do wait()
        if _G.Fishbone then
            CreateESP("Fishbone")
        else
            DestroyESPMob("Fishbone")
        end
    end
end)

serv:Channel("by Śʏɴ0xž")
win:Server("Main", "http://www.roblox.com/asset/?id=6031075938")
