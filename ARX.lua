-- Wait for the game to load
if not game:IsLoaded() then
    game.Loaded:Wait()
end

local player = game:GetService('Players').LocalPlayer
repeat
    wait()
until player.Character and player.Character:FindFirstChild("HumanoidRootPart")

print("Game and HumanoidRootPart are loaded!")

local hub = game:GetService("CoreGui")

for i,v in ipairs(hub:GetChildren()) do
    if v:IsA("ScreenGui") and v.Name == "ScreenGui" then
        v:Destroy()
    end
end

_G.JobId = ""
_G.Skill = ""

local plr = game.Players.LocalPlayer
local PlayerGui = plr:FindFirstChild('PlayerGui')

local RS = game:GetService("ReplicatedStorage")
local TS = game:GetService('TeleportService')
local CoreGui = game:GetService("CoreGui")

local Player_Data = RS:FindFirstChild('Player_Data')
local plr_name = Player_Data[game.Players.LocalPlayer.Character.Name]
local Collection = plr_name:FindFirstChild('Collection')
local Remote = RS:FindFirstChild("Remote")
local Server = Remote:FindFirstChild("Server")
local OnGame = Server:FindFirstChild('OnGame')
local PlayRoom = Server:FindFirstChild('PlayRoom')
local Event = PlayRoom:FindFirstChild('Event')


local Voting = OnGame:FindFirstChild('Voting')
local VotePlaying = Voting:FindFirstChild('VotePlaying')
local VoteRetry = Voting:FindFirstChild('VoteRetry')
local VoteNext = Voting:FindFirstChild('VoteNext')

local Units = Server:FindFirstChild("Units")
local Upgrade = Units:FindFirstChild('Upgrade')
local Deployment = Units:FindFirstChild("Deployment")


-- Function

local function AFK()
    local Afk = game:service'VirtualUser'
    game:service'Players'.LocalPlayer.Idled:connect(function()
    	Afk:CaptureController()
    	Afk:ClickButton2(Vector2.new())
    end)
end

local function Get_Unit()
    local Unit = {}
    if PlayerGui then
        local UnitsLoadout = PlayerGui:FindFirstChild('UnitsLoadout')
        if UnitsLoadout then
            local Main = UnitsLoadout:FindFirstChild('Main')
            if Main then
                for i,v in ipairs(Main:GetChildren()) do
                    if v:IsA("TextButton") then
                        local Frame = v:FindFirstChild('Frame')
                        if Frame then
                            local UnitFrame = Frame:FindFirstChild('UnitFrame')
                            if UnitFrame then
                                local Info = UnitFrame:FindFirstChild('Info')
                                if Info then
                                    local Folder = Info:FindFirstChild('Folder')
                                    if Folder then
                                        table.insert(Unit, Folder.Value)
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end
    return Unit
end

local function Spawn_Unit()
    local ignore_spawn_unit = {}
    local Unit_ = Get_Unit()
    local Player_Data = RS:FindFirstChild('Player_Data')
    if Player_Data then
        local plr_name = Player_Data[game.Players.LocalPlayer.Character.Name]
        if plr_name then
            local Collection = plr_name:FindFirstChild('Collection')
            if Collection then
                for i,v in ipairs(Collection:GetChildren()) do
                    if not table.find(ignore_spawn_unit, v.Name) and table.find(Unit_, v) then
                        Deployment:FireServer(v)
                        task.wait(.01)
                    end
                end
            end
        end
    end
end

local function Upgrade_()
    local ignore_upgrade_unit = {}
    local UnitsFolder = plr:FindFirstChild('UnitsFolder')
    if UnitsFolder then
        for i, v in pairs(UnitsFolder:GetChildren()) do
            if not table.find(ignore_upgrade_unit, v.Name) then
                Upgrade:FireServer(v)
                task.wait(.01)
            end
        end
    end
end

local function No_AnimUI()
    for i,v in ipairs(PlayerGui:GetChildren()) do
        if v:IsA("ScreenGui") then
            if v.Name == "GameEndedAnimationUI" then
                v:Destroy()
            end
        end
    end
end

local function NO_Reward_UI()
    local Reward = PlayerGui:FindFirstChild('RewardsUI')
    if Reward and Reward.Enabled then
        Reward.Enabled = false
    end
end

local function Notification()
    local Notification = PlayerGui:FindFirstChild('Notification')
    if Notification then
        return Notification
    end
    return
end

local plr = game.Players.LocalPlayer
local PlayerGui = plr:FindFirstChild('PlayerGui')

local RS = game:GetService("ReplicatedStorage")
local TS = game:GetService('TeleportService')
local Player_Data = RS:FindFirstChild('Player_Data')
local plr_name = Player_Data[game.Players.LocalPlayer.Character.Name]
local Collection = plr_name:FindFirstChild('Collection')
local Remote = RS:FindFirstChild("Remote")
local Server = Remote:FindFirstChild("Server")
local OnGame = Server:FindFirstChild('OnGame')
local PlayRoom = Server:FindFirstChild('PlayRoom')
local Event = PlayRoom:FindFirstChild('Event')


local Voting = OnGame:FindFirstChild('Voting')
local VotePlaying = Voting:FindFirstChild('VotePlaying')
local VoteRetry = Voting:FindFirstChild('VoteRetry')
local VoteNext = Voting:FindFirstChild('VoteNext')

local Units = Server:FindFirstChild("Units")
local Upgrade = Units:FindFirstChild('Upgrade')
local Deployment = Units:FindFirstChild("Deployment")


local function Check_Game()
    local GamePlay = RS:FindFirstChild('Gameplay')
    if GamePlay then
        local Game = GamePlay:FindFirstChild('Game')
        if Game then
            local Challenge = Game:FindFirstChild('Challenge')
            if Challenge then
                local Items = Challenge:FindFirstChild('Items')
                if Items then
                    for i,v in Items:GetChildren() do
                        if v:IsA("BoolValue") then
                            if v.Name:find('Dr. Megga Punk') then
                                return true
                            end
                        end
                    end
                end
            end
        end
    end
    return
end

local function Easter()
    local Building = workspace:FindFirstChild('Building')
    if Building then
        for i,v in workspace.Building:GetChildren() do
            if v:IsA("MeshPart") then
                if v.Name:find("Meshes/egg") then
                    return true
                end
            end
        end
    else
        return true
    end
    return
end

local function Delete_Counter()
for i,v in CoreGui:GetChildren() do
        if v:IsA('ScreenGui') then
            if v.Name:find("UnifiedCounterGui") then
                v:Destroy()
            end
        end
    end
end

local function Show_Counters()
    pcall(function()
        local RS = game:GetService("ReplicatedStorage")
        local Players = game:GetService("Players")

        local player = Players.LocalPlayer

        -- Wait for character to load
        if not player.Character or not player.Character.Parent then
            player.CharacterAdded:Wait()
        end


        -- Remove any old GUI
        Delete_Counter()

        -- Create GUI
        if not _G.Auto_Show_Counters then return end
        local screenGui = Instance.new("ScreenGui")
        screenGui.Name = "UnifiedCounterGui"
        screenGui.ResetOnSpawn = false
        screenGui.IgnoreGuiInset = true
        screenGui.Parent = CoreGui

        -- Main Frame
        local frame = Instance.new("Frame")
        frame.Size = UDim2.new(0, 250, 0.21, 100)
        frame.Position = UDim2.new(0.2, 0, 0.1, 0)
        frame.AnchorPoint = Vector2.new(0.5, 0)
        frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        frame.BorderSizePixel = 0
        frame.ZIndex = 1
        frame.Parent = screenGui

        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(0, 15)
        corner.Parent = frame

        -- UI Layout
        local layout = Instance.new("UIListLayout")
        layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
        layout.VerticalAlignment = Enum.VerticalAlignment.Center
        layout.SortOrder = Enum.SortOrder.LayoutOrder
        layout.Padding = UDim.new(0, 5)
        layout.Parent = frame

        -- Function to add a label inside the same frame
        local function createLabel(text, color)
            local label = Instance.new("TextLabel")
            label.Size = UDim2.new(1, -20, 0, 40)
            label.BackgroundTransparency = 1
            label.Font = Enum.Font.GothamBold
            label.TextColor3 = color
            label.TextStrokeTransparency = 0.6
            label.TextScaled = false
            label.TextSize = 45
            label.Text = text
            label.ZIndex = 2
            label.Parent = frame
        end

        -- Get data and show both in the same frame
        local Player_Data = RS:FindFirstChild("Player_Data")
        if Player_Data then
            local charName = player.Character and player.Character.Name
            local plrData = Player_Data:FindFirstChild(charName)
            if plrData then
                if charName then
                    createLabel(tostring(charName), Color3.new(1.000000, 0.901961, 0.000000))
                end

                local data = plrData:FindFirstChild("Data")
                local egg = data and data:FindFirstChild("Egg")
                if egg then
                    createLabel(tostring(egg.Value) .. " Eggs", Color3.fromRGB(0, 150, 255))
                end

                local items = plrData:FindFirstChild("Items")
                local punk = items and items:FindFirstChild("Dr. Megga Punk")
                local amount = punk and punk:FindFirstChild("Amount")
                if amount then
                    createLabel(tostring(amount.Value) .. " Punk", Color3.fromRGB(255, 60, 60))
                end

                local Easter = Easter()
                if Easter then
                    createLabel('Farm Event', Color3.new(1.000000, 0.466667, 0.760784))
                end

                local Punk = Check_Game()
                if Punk then
                    createLabel('Farm Punk', Color3.new(1.000000, 0.466667, 0.760784))
                end

                local PlayerGui = game:GetService('Players').LocalPlayer.PlayerGui
                local RewardsUI = PlayerGui:FindFirstChild('RewardsUI')
                if RewardsUI then
                    local Main = RewardsUI:FindFirstChild('Main')
                    if Main then
                        local LeftSide = Main:FindFirstChild('LeftSide')
                        if LeftSide then
                            local TotalTime = LeftSide:FindFirstChild('TotalTime')
                            if TotalTime then
                                createLabel('End: '..tostring(TotalTime.Text):sub(16), Color3.new(0.937255, 0.776471, 1.000000))
                            end
                        end
                    end
                end
            end
        end
    end)
end

local priorityList = {
    {name = "Naruto", requiredLevel = 0, priority = 1},
    {name = "Rui", requiredLevel = 3, priority = 2},
    {name = "Carrot:Evo", requiredLevel = 4, priority = 3}
}

-- Sort by priority
table.sort(priorityList, function(a, b)
    return a.priority < b.priority
end)

local function Req_Unit(_Unit, _RequiredLevel)
    local plr = game:GetService('Players').LocalPlayer
    if plr then
        local UnitsFolder = plr:FindFirstChild('UnitsFolder')
        if UnitsFolder then
            local Unit = UnitsFolder:FindFirstChild(_Unit)
            if Unit then
                local Upgrade_F = Unit:FindFirstChild('Upgrade_Folder')
                if Upgrade_F then
                    local Level = Upgrade_F:FindFirstChild('Level')
                    if Level then
                        local currentLevel = tonumber(Level.Value)
                        local requiredLevel = tonumber(_RequiredLevel)
                        -- Only upgrade if the current level is less than the required level
                        if currentLevel < requiredLevel then
                            Upgrade:FireServer(Unit)
                            print("Upgrading", _Unit, "to level", requiredLevel)
                            return false -- Return false to indicate it's still being upgraded
                        else
                            -- Once the level is met, deploy the unit
                            Upgrade:FireServer(Unit)
                            Deployment:FireServer(Collection[_Unit])
                            print("Deploying", _Unit, "at level", currentLevel)
                            return true -- Return true to indicate it's ready for deployment
                        end
                    else
                        print('No Level found for unit', _Unit)
                    end
                end
            end
        end
    end
    return true -- Default to true if no level info is found
end

local function Check_Game()
    local GamePlay = RS:FindFirstChild('Gameplay')
    if GamePlay then
        local Game = GamePlay:FindFirstChild('Game')
        if Game then
            local Challenge = Game:FindFirstChild('Challenge')
            if Challenge then
                local Items = Challenge:FindFirstChild('Items')
                if Items then
                    for i,v in Items:GetChildren() do
                        if v:IsA("BoolValue") then
                            if v.Name:find('Dr. Megga Punk') then
                                return true
                            end
                        end
                    end
                end
            end
        end
    end
    return
end

local function Easter()
    local Building = workspace:FindFirstChild('Building')
    if Building then
        for i,v in workspace.Building:GetChildren() do
            if v:IsA("MeshPart") then
                if v.Name:find("Meshes/egg") then
                    return true
                end
            end
        end
    else
        return true
    end
    return
end

local function Check_Punk_Easter()
    local punk = Check_Game()
    local easter_event = Easter()
    if punk then
        if easter_event then
            Event:FireServer("Create",{CreateChallengeRoom = true})
            Event:FireServer("Start")
        end
    else
        if not easter_event then
            Event:FireServer("Easter-Event")
            Event:FireServer("Start")
        end
    end
end













-- UI

AFK()
local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()

local Window = Fluent:CreateWindow({
    Title = "Syn0xz Hub ",
    SubTitle = "by Chaiwat",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = true, -- The blur may be detectable, setting this to false disables blur entirely
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.LeftControl -- Used when theres no MinimizeKeybind
})

--Fluent provides Lucide Icons https://lucide.dev/icons/ for the tabs, icons are optional
local Tabs = {
    Main = Window:AddTab({ Title = "Main", Icon = "swords" }),
    Server = Window:AddTab({ Title = "Server", Icon = "server" }),
    Settings = Window:AddTab({ Title = "Settings", Icon = "settings" })
}

local Options = Fluent.Options

do
    Tabs.Server:AddParagraph({
        Title = "Join Server Function",
        Content = "Press Copy and Join"
    })
    
        Tabs.Server:AddButton({
        Title = "Copy JobId",
        Description = "",
        Callback = function()
            setclipboard(tostring(game.JobId))
        end
    })

    local Input = Tabs.Server:AddInput("Input", {
        Title = "Join Server",
        Default = "",
        Placeholder = "JobId",
        Numeric = false, -- Only allows numbers
        Finished = false, -- Only calls callback when you press enter
        Callback = function(Value)
            _G.JobId = Value
            if _G.JobId == game.JobId then
                Fluent:Notify({
                    Title = "Syn0xz Hub",
                    Content = "Already in Server",
                    SubContent = "", -- Optional
                    Duration = 3 -- Set to nil to make the notification not disappear
                })
            else
                if #_G.JobId == 36 then 
                    Fluent:Notify({
                        Title = "Syn0xz Hub",
                        Content = "Joning Server",
                        SubContent = "", -- Optional
                        Duration = 3 -- Set to nil to make the notification not disappear
                    })
                    TS:TeleportToPlaceInstance(game.PlaceId, _G.JobId)
                end
            end
        end
    })

    local Tab_Auto_Spawn_Unit = Tabs.Main:AddToggle("Tab_Auto_Spawn_Unit", {Title = "Auto Spawn Unit", Default = false })

    Tab_Auto_Spawn_Unit:OnChanged(function()
        _G.Spawn_Unit = Options.Tab_Auto_Spawn_Unit.Value
        while _G.Spawn_Unit do task.wait(.1)
            Spawn_Unit()
        end
    end)

    local Tab_Auto_Upgrade = Tabs.Main:AddToggle("Tab_Auto_Upgrade", {Title = "Auto Upgrade", Default = false })

    Tab_Auto_Upgrade:OnChanged(function()
        _G.Upgrade_ = Options.Tab_Auto_Upgrade.Value
        while _G.Upgrade_ do task.wait(.1)
            Upgrade_()
        end
    end)

    local Tab_Auto_Vote_Playing = Tabs.Main:AddToggle("Tab_Auto_Vote_Playing", {Title = "Auto Start", Default = false })

    Tab_Auto_Vote_Playing:OnChanged(function()
        _G.VotePlaying = Options.Tab_Auto_Vote_Playing.Value
        while _G.VotePlaying do task.wait(.1)
            VotePlaying:FireServer()
        end
    end)

    local Tab_Auto_VoteRetry = Tabs.Main:AddToggle("Tab_Auto_VoteRetry", {Title = "Auto Retry", Default = false })

    Tab_Auto_VoteRetry:OnChanged(function()
        _G.VoteRetry = Options.Tab_Auto_VoteRetry.Value
        while _G.VoteRetry do task.wait(.1)
            VoteRetry:FireServer()
        end
    end)

    local Tab_Auto_VoteNext = Tabs.Main:AddToggle("Tab_Auto_VoteNext", {Title = "Auto Next", Default = false })

    Tab_Auto_VoteNext:OnChanged(function()
        _G.VoteNext = Options.Tab_Auto_VoteNext.Value
        while _G.VoteNext do task.wait(.1)
            VoteNext:FireServer()
        end
    end)

    local Tab_No_Reward_UI = Tabs.Main:AddToggle("Tab_No_Reward_UI", {Title = "No Reward UI", Default = false })

    Tab_No_Reward_UI:OnChanged(function()
        _G.No_Reward_UI = Options.Tab_No_Reward_UI.Value
        while _G.No_Reward_UI do task.wait(.1)
            NO_Reward_UI()
            No_AnimUI()
        end
    end)

    local Tab_Notification = Tabs.Main:AddToggle("Tab_Notification", {Title = "No Notification", Default = false })

    Tab_Notification:OnChanged(function()
        _G.Notify = Options.Tab_Notification.Value
        if _G.Notify then
            Notification().Enabled = false
        else
            Notification().Enabled = true
        end
    end)
    
    local Tab_Auto_Show_Counters = Tabs.Main:AddToggle("Tab_Auto_Show_Counters", {Title = "Data Counter", Default = false })

    Tab_Auto_Show_Counters:OnChanged(function()
        _G.Auto_Show_Counters = Options.Tab_Auto_Show_Counters.Value
        while _G.Auto_Show_Counters do task.wait(.1)
            Show_Counters()
        end
    end)

    local Tab_Auto_Account_b0bbtt = Tabs.Main:AddToggle("Tab_Auto_Account_b0bbtt", {Title = "Auto b0bbtt", Default = false })

    Tab_Auto_Account_b0bbtt:OnChanged(function()
        _G.b0bbtt = Options.Tab_Auto_Account_b0bbtt.Value
        while _G.b0bbtt do task.wait(.1)
            task.wait(.35)
            -- Iterate through the priority list
            for _, unit in ipairs(priorityList) do
                -- If the unit is upgraded and deployed, move to the next
                if Req_Unit(unit.name, unit.requiredLevel) then
                    print(unit.name, "is deployed. Moving to next unit.")
                end
            end
        end
    end)

    local Tab_Punk_Check = Tabs.Main:AddToggle("Tab_Punk_Check", {Title = "Auto Punk and Easter", Default = false })

    Tab_Punk_Check:OnChanged(function()
        _G.Check_PunkEaster = Options.Tab_Punk_Check.Value
        while _G.Check_PunkEaster do task.wait(1)
            Check_Punk_Easter()
        end
    end)












    -- CLose Function
end


-- Addons:
-- SaveManager (Allows you to have a configuration system)
-- InterfaceManager (Allows you to have a interface managment system)

-- Hand the library over to our managers
SaveManager:SetLibrary(Fluent)
InterfaceManager:SetLibrary(Fluent)

-- Ignore keys that are used by ThemeManager.
-- (we dont want configs to save themes, do we?)
SaveManager:IgnoreThemeSettings()

-- You can add indexes of elements the save manager should ignore
SaveManager:SetIgnoreIndexes({})

-- use case for doing it this way:
-- a script hub could have themes in a global folder
-- and game configs in a separate folder per game
InterfaceManager:SetFolder("FluentScriptHub")
SaveManager:SetFolder("FluentScriptHub/ARX_"..game.Players.LocalPlayer.Character.Name)

InterfaceManager:BuildInterfaceSection(Tabs.Settings)
SaveManager:BuildConfigSection(Tabs.Settings)


Window:SelectTab(1)

Fluent:Notify({
    Title = "Fluent",
    Content = "The script has been loaded.",
    Duration = 8
})

-- You can use the SaveManager:LoadAutoloadConfig() to load a config
-- which has been marked to be one that auto loads!
SaveManager:LoadAutoloadConfig()
return
