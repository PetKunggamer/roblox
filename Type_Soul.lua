function Notify(Text)
game.StarterGui:SetCore("SendNotification", {
    Title = "Hueco Mundo";
    Text = Text;
    Duration = "300";
    Button1 = "Done!";
})
end

local DiscordLib =
    loadstring(game:HttpGet "https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/discord")()

local win = DiscordLib:Window("discord library")

local serv = win:Server("Preview", "")

local tgls = serv:Channel("ESP and Notify")


tgls:Toggle(
    "Notify Jackal",
    false,
    function(bool)
    print(bool)
    _G.ESP_Jackal = bool
    while _G.ESP_Jackal do wait(.25)
    for __,v in pairs(game.workspace.Entities:GetChildren()) do 
        if v.Name:find("Jackal") then
            if v:FindFirstChild("ESP_Jackal") then
            else
            Notify("Jackal Has Spawned!")
            local BillboardGui = Instance.new("BillboardGui",v)
            BillboardGui.Name = "ESP_Jackal"
            BillboardGui.Size = UDim2.new(10,0, 10,0)
            BillboardGui.AlwaysOnTop = true

            local Frame = Instance.new("Frame",BillboardGui)
            Frame.Size = UDim2.new(1,0, 1,0)
            Frame.BackgroundTransparency = 1
            Frame.BorderSizePixel = 0
            Frame.BackgroundColor3 = Color3.new(0, 255, 0)

            local TextLabel = Instance.new("TextLabel",Frame)
            TextLabel.Size = UDim2.new(2,0,2,0)
            TextLabel.BorderSizePixel = 0
            TextLabel.TextSize = 20
            TextLabel.Text = "Jackal"
            TextLabel.TextColor3 = Color3.new(0, 255, 0)
            TextLabel.BackgroundTransparency = 1
            end
        end
    end

    if not _G.ESP_Jackal then
        for __,v in pairs(game.workspace.Entities:GetDescendants()) do
            if v.Name == "ESP_Jackal" then
                v:Destroy()
            end
        end
    end
end
end)


tgls:Toggle(
    "Notify Fishbone",
    false,
    function(bool)
    print(bool)
    _G.ESP_Fishbone = bool
    while _G.ESP_Fishbone do wait(.25)
    for __,v in pairs(game.workspace.Entities:GetChildren()) do 
        if v.Name:find("Fishbone") then
            if v:FindFirstChild("ESP_Fishbone") then
            else
            Notify("Fishbone Has Spawned!")
            local BillboardGui = Instance.new("BillboardGui",v)
            BillboardGui.Name = "ESP_Fishbone"
            BillboardGui.Size = UDim2.new(10,0, 10,0)
            BillboardGui.AlwaysOnTop = true

            local Frame = Instance.new("Frame",BillboardGui)
            Frame.Size = UDim2.new(1,0, 1,0)
            Frame.BackgroundTransparency = 1
            Frame.BorderSizePixel = 0
            Frame.BackgroundColor3 = Color3.new(0, 255, 0)

            local TextLabel = Instance.new("TextLabel",Frame)
            TextLabel.Size = UDim2.new(2,0,2,0)
            TextLabel.BorderSizePixel = 0
            TextLabel.TextSize = 20
            TextLabel.Text = "Fishbone"
            TextLabel.TextColor3 = Color3.new(0, 255, 0)
            TextLabel.BackgroundTransparency = 1
            end
        end
    end
    if not _G.ESP_Fishbone then
        for __,v in pairs(game.workspace.Entities:GetDescendants()) do
            if v.Name == "ESP_Fishbone" then
                v:Destroy()
            end
        end
    end
end
end)

serv:Channel("by Śʏɴ0xž")

win:Server("Main", "http://www.roblox.com/asset/?id=6031075938")
