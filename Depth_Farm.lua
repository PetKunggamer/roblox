repeat
    wait(3)
until game:IsLoaded()

getgenv().JobId = "91f0a1f3-4c46-4448-b7e5-bd1ad0c8df74"

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local placeId = game.PlaceId
function GetJobId()
    local url =
        "https://discord.com/api/webhooks/1076888046856843276/JMjnuV7EFp6-RiXYdgzsplGOSu_htdCKx7A2ryeDmwexiabk5xcvr1q0bJrDQ4u1q0av"
    local data = {
        ["content"] = nil,
        ["embeds"] = {
            {
                ["title"] = "**Depth Farm**",
                ["description"] = "Username: " ..
                    game.Players.LocalPlayer.Name .. " Job Server is `" .. game.JobId .. "`",
                ["type"] = "rich",
                ["color"] = tonumber(0x7269da),
                ["image"] = {
                    ["url"] = "http://www.roblox.com/Thumbs/Avatar.ashx?x=150&y=150&Format=Png&username=" ..
                        tostring(game:GetService("Players").LocalPlayer.Name)
                }
            }
        }
    }
    local newdata = game:GetService("HttpService"):JSONEncode(data)

    local headers = {
        ["content-type"] = "application/json"
    }
    request = http_request or request or HttpPost or syn.request
    local abcdef = {Url = url, Body = newdata, Method = "POST", Headers = headers}
    request(abcdef)
end

function create_notification(Title, Text, Duration, Callback, Button1, Button2)
    local bindablefunc = Instance.new("BindableFunction")
    bindablefunc.OnInvoke = function(button)
        if button == Button1 then
            Callback()
        else
            print(button)
        end
    end
    game.StarterGui:SetCore(
        "SendNotification",
        {
            Title = Title,
            Text = Text,
            Duration = Duration or math.huge,
            Callback = bindablefunc,
            Button1 = Button1,
            Button2 = Button2
        }
    )
end

function CheckLoading()
    _G.LoadingGui = not _G.LoadingGui
    while _G.LoadingGui do
        wait(1)
        local PlayerGui = game:GetService("Players").LocalPlayer.PlayerGui
        local LoadingGui = PlayerGui:FindFirstChild("LoadingGui")
        if PlayerGui then
            LoadingGui = PlayerGui:FindFirstChild("LoadingGui")
            if LoadingGui then
                local VirtualInputManager = game:GetService("VirtualInputManager")
                VirtualInputManager:SendMouseButtonEvent(0, 500, 0, true, game, 1)
            else
                _G.LoadingGui = false
            end
        else
            break
        end
    end
end

function Character_Create()
    local LocalPlayer = game:GetService("Players").LocalPlayer
    local PlayerGui = LocalPlayer:FindFirstChild("PlayerGui")

    if PlayerGui then
        local CharacterCreator = PlayerGui:FindFirstChild("CharacterCreator")
        if CharacterCreator then
            local Points = PlayerGui.CharacterCreator.Windows.Attributes.AttrSheet.Points
            if Points then
                local CheckPoint = string.match(Points.Text, "%d+")

                if tonumber(CheckPoint) <= 0 then
                    local ReplicatedStorage = game:GetService("ReplicatedStorage")
                    local FinishCreation =
                        ReplicatedStorage:WaitForChild("Requests"):WaitForChild("CharacterCreator"):WaitForChild(
                        "FinishCreation"
                    )
                    FinishCreation:InvokeServer()
                    wait(2.5)
                    game:GetService("TeleportService"):Teleport(10495850838, LocalPlayer)
                else
                    local Stat = {"Strength", "Fortitude", "Agility", "Intelligence", "Willpower", "Charisma"}
                    for i, v in pairs(Stat) do
                        game:GetService("ReplicatedStorage"):WaitForChild("Requests"):WaitForChild("IncreaseAttribute"):InvokeServer(
                            v
                        )
                    end
                end
            end
        end
    end
end

function The_End()
    local NPC = game:GetService("Workspace").NPCs
    local hrp = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart
    local VirtualInputManager = game:GetService("VirtualInputManager")
    local Self = NPC:FindFirstChild("Self")
    if hrp then
        if Self then
            local Self_hrp = Self:FindFirstChild("HumanoidRootPart")
            if Self_hrp then
                local Dist = (Self.HumanoidRootPart.Position - hrp.Position).magnitude
                if Dist < 400 then
                    while true do
                        hrp.CFrame = Self.HumanoidRootPart.CFrame * CFrame.new(0, 3, 0)
                        fireproximityprompt(game:GetService("Workspace").NPCs.Self.InteractPrompt)
                        VirtualInputManager:SendKeyEvent(true, "One", false, game)
                    end
                else
                    print("Out Of Range")
                end
            else
                hrp.CFrame = CFrame.new(2683, -2246, 1733)
            end
        end
    end
end

if placeId == 10138901829 then
    local ReplicatedStorage = game:GetService("ReplicatedStorage")

    ReplicatedStorage:WaitForChild("Requests"):WaitForChild("StartMenu"):WaitForChild("Start"):FireServer(
        "A",
        {["PrivateTest"] = false}
    )

    wait(1.73)
    game:GetService("TeleportService"):Teleport(10371908957, LocalPlayer)
elseif placeId == 10371908957 then
    while true do
        wait(.55)
        CheckLoading()
        JobId_ = getgenv().JobId
        Character_Create()
    end
elseif placeId == 10495850838 then
    CheckLoading()
    print("CheckLoading is done..")
    wait(1)
    print("The_End is running...")
    if game.JobId == JobId then
        print("Match JobId")
        create_notification(
            "Server Notification",
            "Copy JobId from Discord",
            nil,
            function()
                GetJobId()
            end,
            "Get JobId",
            "No"
        )

        create_notification(
            "Depth Farm",
            "Stop or continue",
            nil,
            function()
                _G.The_End = false
            end,
            "Stop",
            "Continue"
        )
        _G.The_End = not _G.The_End
        while _G.The_End do
            pcall(
                function()
                    wait(.25)
                    The_End()
                end
            )
        end
    else
        print("Changer Server")
        game:GetService("TeleportService"):TeleportToPlaceInstance(10495850838, JobId, game.Players.LocalPlayer)
    end
end
