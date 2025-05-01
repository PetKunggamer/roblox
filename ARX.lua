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
local Player_Data = RS:FindFirstChild('Player_Data')
local plr_name = Player_Data[game.Players.LocalPlayer.Character.Name]
local Collection = plr_name:FindFirstChild('Collection')
local Remote = RS:FindFirstChild("Remote")
local Server = Remote:FindFirstChild("Server")
local OnGame = Server:FindFirstChild('OnGame')
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

local function Egg_Counter()
    pcall(function()
        local Players = game:GetService("Players")
        local CoreGui = game:GetService("CoreGui")

        local player = Players.LocalPlayer

        -- Wait for character to load
        if not player.Character or not player.Character.Parent then
            player.CharacterAdded:Wait()
        end

        -- Clean up old GUI
        if CoreGui:FindFirstChild("ThaiCounterGui") then
            CoreGui.ThaiCounterGui:Destroy()
        end

        -- Create GUI
        local screenGui = Instance.new("ScreenGui")
        screenGui.Name = "ThaiCounterGui"
        screenGui.ResetOnSpawn = false
        screenGui.IgnoreGuiInset = true
        screenGui.Parent = CoreGui

        -- Shadow frame
        local shadow = Instance.new("Frame")
        shadow.Size = UDim2.new(0, 220, 0, 80)
        shadow.Position = UDim2.new(0.5, 4, 0.1, 4)
        shadow.AnchorPoint = Vector2.new(0.5, 0)
        shadow.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
        shadow.BackgroundTransparency = 0.6
        shadow.BorderSizePixel = 0
        shadow.ZIndex = 0
        shadow.Parent = screenGui

        local shadowCorner = Instance.new("UICorner")
        shadowCorner.CornerRadius = UDim.new(0, 20)
        shadowCorner.Parent = shadow

        -- Outer frame
        local outerFrame = Instance.new("Frame")
        outerFrame.Size = UDim2.new(0, 220, 0, 80)
        outerFrame.Position = UDim2.new(0.5, 0, 0.1, 0)
        outerFrame.AnchorPoint = Vector2.new(0.5, 0)
        outerFrame.BackgroundColor3 = Color3.fromRGB(245, 245, 245)
        outerFrame.BackgroundTransparency = 0
        outerFrame.BorderSizePixel = 0
        outerFrame.ZIndex = 1
        outerFrame.Parent = screenGui

        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(0, 20)
        corner.Parent = outerFrame

        -- Label
        local label = Instance.new("TextLabel")
        label.Size = UDim2.new(1, 0, 1, 0)
        label.BackgroundTransparency = 1
        label.Position = UDim2.new(0, 0, 0, 0)
        label.Font = Enum.Font.GothamBold
        label.TextColor3 = Color3.fromRGB(0, 150, 255)
        label.TextStrokeTransparency = 0.8
        label.TextScaled = true
        label.ZIndex = 2
        label.Parent = outerFrame

        -- Set text
        local Player_Data = RS:FindFirstChild('Player_Data')
        if Player_Data then
            local plr_name = Player_Data[game.Players.LocalPlayer.Character.Name]
            if plr_name then
                local Data = plr_name:FindFirstChild('Data')
                if Data then
                    local Egg = Data:FindFirstChild('Egg')
                    if Egg then
                        label.Text = tostring(Egg.Value) .. " Eggs"
                    end
                end
            end
        end
    end)
end

local function Punk_Counter()
    pcall(function()
        local RS = game:GetService('ReplicatedStorage') 
        local Players = game:GetService("Players")
        local CoreGui = game:GetService("CoreGui")

        local player = Players.LocalPlayer

        -- Wait for character to load
        if not player.Character or not player.Character.Parent then
            player.CharacterAdded:Wait()
        end

        -- Clean up old GUI
        if CoreGui:FindFirstChild("MegaCounterGui") then
            CoreGui.MegaCounterGui:Destroy()
        end

        -- Create GUI
        local screenGui = Instance.new("ScreenGui")
        screenGui.Name = "MegaCounterGui"
        screenGui.ResetOnSpawn = false
        screenGui.IgnoreGuiInset = true
        screenGui.Parent = CoreGui

        -- Shadow frame
        local shadow = Instance.new("Frame")
        shadow.Size = UDim2.new(0, 220, 0, 80)
        shadow.Position = UDim2.new(0.5, 4, 0.1, 4)
        shadow.AnchorPoint = Vector2.new(0.5, 0)
        shadow.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
        shadow.BackgroundTransparency = 0.6
        shadow.BorderSizePixel = 0
        shadow.ZIndex = 0
        shadow.Parent = screenGui

        local shadowCorner = Instance.new("UICorner")
        shadowCorner.CornerRadius = UDim.new(0, 20)
        shadowCorner.Parent = shadow

        -- Outer frame
        local outerFrame = Instance.new("Frame")
        outerFrame.Size = UDim2.new(0, 220, 0, 80)
        outerFrame.Position = UDim2.new(0.5, 0, 0.1, 0)
        outerFrame.AnchorPoint = Vector2.new(0.5, 0)
        outerFrame.BackgroundColor3 = Color3.fromRGB(245, 245, 245)
        outerFrame.BackgroundTransparency = 0
        outerFrame.BorderSizePixel = 0
        outerFrame.ZIndex = 1
        outerFrame.Parent = screenGui

        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(0, 20)
        corner.Parent = outerFrame

        -- Label
        local label = Instance.new("TextLabel")
        label.Size = UDim2.new(1, 0, 1, 0)
        label.BackgroundTransparency = 1
        label.Position = UDim2.new(0, 0, 0, 0)
        label.Font = Enum.Font.GothamBold
        label.TextColor3 = Color3.new(1.000000, 0.000000, 0.000000)
        label.TextStrokeTransparency = 0.8
        label.TextScaled = true
        label.ZIndex = 2
        label.Parent = outerFrame

        -- Set text
        local Player_Data = RS:FindFirstChild('Player_Data')
        if Player_Data then
            local plr_name = Player_Data[game.Players.LocalPlayer.Character.Name]
            if plr_name then
                local Items = plr_name:FindFirstChild('Items')
                if Items then
                    local Punk = Items:FindFirstChild('Dr. Megga Punk')
                    if Punk then
                        local Punk_Amount = Punk:FindFirstChild('Amount')
                        if Punk_Amount then
                            label.Text = tostring(Punk_Amount.Value) .. " Punk"
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
    
    local Tab_Egg_Counter = Tabs.Main:AddToggle("Tab_Egg_Counter", {Title = "Egg Counter", Default = false })

    Tab_Egg_Counter:OnChanged(function()
        _G.Auto_Egg_Counter = Options.Tab_Egg_Counter.Value
        while _G.Auto_Egg_Counter do task.wait(.1)
            Egg_Counter()
        end
    end)

    local Tab_Punk_Counter = Tabs.Main:AddToggle("Tab_Punk_Counter", {Title = "Punk Counter", Default = false })

    Tab_Punk_Counter:OnChanged(function()
        _G.Auto_Punk_Counter = Options.Tab_Punk_Counter.Value
        while _G.Auto_Punk_Counter do task.wait(.1)
            Punk_Counter()
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
SaveManager:SetFolder("FluentScriptHub/Anime_Ranger_X")

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
