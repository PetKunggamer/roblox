-- Wait for the game to load
if not game:IsLoaded() then
    game.Loaded:Wait()
end

local player = game.Players.LocalPlayer 
repeat wait() until player.Character and player.Character:FindFirstChild("HumanoidRootPart")



print("Game and HumanoidRootPart are loaded!")



local CoreGui = game:GetService("CoreGui")
for i,v in ipairs(CoreGui:GetChildren()) do
    if v:IsA("ScreenGui") and v.Name == "ScreenGui" then
        v:Destroy()
    end
end

_G.JobId = ""
_G.Skill = ""


local VirtualInputManager = game:GetService("VirtualInputManager")
local camera = workspace.CurrentCamera
local plr = game:GetService("Players").LocalPlayer
local GuiService = game:GetService('GuiService')
local RS = game:GetService("ReplicatedStorage")

local Events = RS:FindFirstChild("Events")
local Skill = Events:FindFirstChild("Skill")


-- Function

local function AFK()
    local Afk = game:service'VirtualUser'
    game:service'Players'.LocalPlayer.Idled:connect(function()
    	Afk:CaptureController()
    	Afk:ClickButton2(Vector2.new())
    end)
end

local function Get_Slot()
    local Name_Slot = ""
    local PlayerGui = plr:FindFirstChild('PlayerGui')
    if PlayerGui then
        local ScreenGui = PlayerGui:FindFirstChild('ScreenGui')
        if ScreenGui then
            local info = ScreenGui:FindFirstChild('info')
            if info then
                local UnitFrame = info:FindFirstChild('UnitFrame')
                if UnitFrame then
                    local NameText = UnitFrame:FindFirstChild('NameText')
                    if NameText then
                        Name_Slot = NameText.Text
                    end
                end
            end
        end
    end
    local CharValue = plr:FindFirstChild("CharValue")
    if CharValue then
        for i,v in CharValue:GetChildren() do
            if v:IsA("Folder") then
                local Units = v:FindFirstChild("Units")
                if Units and Units.Value == Name_Slot then
                    return v
                end
            end
        end
    end
    return ""
end

local function Get_Crate()
    local dist, box = math.huge,nil
    for i,v in workspace.Enemy.Crate:GetChildren() do
        if v:IsA("Model") then
            local Crate = v:FindFirstChild("HumanoidRootPart")
            local root = plr.Character:FindFirstChild("HumanoidRootPart")
            if Crate and root then
                local mag = (Crate.Position - root.Position).Magnitude
                if mag < dist then
                    box = Crate
                    mag = dist
                end
            end
        end
    end
    return box
end

local function Consume_Potion()
    for i,v in workspace.Poition:GetChildren() do
        if v:IsA("Model") then
            local Part = v:FindFirstChild("Part")
            if Part then
                local proximity = Part:FindFirstChild("ChatUI")
                local root = plr.Character:FindFirstChild("HumanoidRootPart")
                if proximity and root then
                    _G.Stop = true
                    root.CFrame = Part.CFrame
                    wait(.1)
                    fireproximityprompt(proximity)
                end
            end
        end
    end
    _G.Stop = false
end

local function Player_HP(Percent)
    local Slot = Get_Slot()
    if Slot then
        local Health = Slot:FindFirstChild("Health")
        local MaxHealth = Slot:FindFirstChild("MaxHealth")
        if Health and MaxHealth and Health.Value and MaxHealth.Value then
            local HP_percent = ((Health.Value/MaxHealth.Value)*100)
            if tonumber(HP_percent) < tonumber(Percent) then
                local root = plr.Character:FindFirstChild("HumanoidRootPart")
                if root then
                    repeat
                        task.wait()
                        local Crate = Get_Crate()
                        if not Crate then return end
                        root.CFrame = Crate.CFrame * CFrame.new(0,0,5)
                        Consume_Potion()
                        -- Update HP after potion
                        if Health and MaxHealth then
                            HP_percent = (Health.Value / MaxHealth.Value) * 100
                        end
                    until HP_percent > 90
                end
            end
        end
    end
end

local function Start()
    local PlayerGui = plr:FindFirstChild('PlayerGui')
    if PlayerGui then
        local RoomUi = PlayerGui:FindFirstChild('RoomUi')
        if RoomUi then
            local Ready = RoomUi:FindFirstChild('Ready')
            if Ready then
                local Frame = Ready:FindFirstChild('Frame')
                if Frame then
                    local StartButton = Frame:FindFirstChild('StartButton')
                    if StartButton then
                        local Butom = StartButton:FindFirstChild("Butom")
                        if Butom then
                            GuiService.SelectedCoreObject = Butom
                            VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.Return, false, game)
                            VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.Return, false, game)
                        end
                    end
                end
            end
        end
    end
end

local function Replay()
    local PlayerGui = plr:FindFirstChild('PlayerGui')
    if PlayerGui then
        local Win = PlayerGui:FindFirstChild('Win')
        if Win then
            local Frame = Win:FindFirstChild('Frame')
            if Frame then
                local progmain = Frame:FindFirstChild('progmain')
                if progmain then
                    local buttons = progmain:FindFirstChild('buttons')
                    if buttons then
                        local replay = buttons:FindFirstChild('replay')
                        if replay then
                            GuiService.SelectedCoreObject = replay
                            VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.Return, false, game)
                            VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.Return, false, game)
                        end
                    end
                end
            end
        end
    end
end

local function Next()
    local PlayerGui = plr:FindFirstChild('PlayerGui')
    if PlayerGui then
        local Win = PlayerGui:FindFirstChild('Win')
        if Win then
            local Frame = Win:FindFirstChild('Frame')
            if Frame then
                local progmain = Frame:FindFirstChild('progmain')
                if progmain then
                    local buttons = progmain:FindFirstChild('buttons')
                    if buttons then
                        local next = buttons:FindFirstChild('next')
                        if next then
                            GuiService.SelectedCoreObject = next
                            VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.Return, false, game)
                            VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.Return, false, game)
                        end
                    end
                end
            end
        end
    end
end

local function GetClosestMob()
    local root = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart")
    if not root then return nil end

    local closestMob = nil
    local closestDist = math.huge

    for _, mobModel in ipairs(workspace.Enemy.Mob:GetChildren()) do
        if mobModel:IsA("Model") then
            local mobHRP = mobModel:FindFirstChild("HumanoidRootPart")
            local Part = mobModel:FindFirstChild("Part")
            if not Part then
                if mobHRP then
                    local distance = (root.Position - mobHRP.Position).Magnitude
                    if distance < closestDist then
                        closestDist = distance
                        closestMob = mobHRP
                    end
                end
            else
                local distance = (root.Position - mobHRP.Position).Magnitude
                if distance < closestDist then
                    closestDist = distance
                    closestMob = Part
                end
            end
        end
    end

    return closestMob, closestDist
end

local function TeleportToAllMobs()
    local root = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart")
    if not root then return end

    local mobs = {}
    for _, mobModel in ipairs(workspace.Enemy.Mob:GetChildren()) do
        if mobModel:IsA("Model") then
            local mobHRP = mobModel:FindFirstChild("HumanoidRootPart")
            if mobHRP then
                table.insert(mobs, mobHRP)
            end
        end
    end

    for _, mobHRP in ipairs(mobs) do
        root.CFrame = mobHRP.CFrame * CFrame.new(0, 10, 5)
        root.Velocity = Vector3.new(0, 0, 0)
        task.wait(0.1)
    end

    if mobs[1] then
        root.CFrame = mobs[1].CFrame * CFrame.new(0, 0, 5)
        root.Velocity = Vector3.new(0, 0, 0)
    end
end

local function AutoSkill()
    local Skill_list = {'Skill1','Skill2','Skill3'}
    for i,v in next,Skill_list do 
        Skill:FireServer(v,0,0,"OnSkill")
        task.wait()
    end
end
local function Hit()
    local screenSize = camera.ViewportSize
    local centerX = screenSize.X / 2
    local centerY = screenSize.Y / 2
    VirtualInputManager:SendMouseButtonEvent(centerX, centerY, 0, true, game, 1)
    wait(0.1)
    VirtualInputManager:SendMouseButtonEvent(centerX, centerY, 0, false, game, 1)
end

local function Farm()
    local closestMob, dist = GetClosestMob()
    if closestMob and dist > 50 then
        task.wait(0.1)
        TeleportToAllMobs()
    else
        local root = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart")
        if root and closestMob then
            root.CFrame = closestMob.CFrame * CFrame.new(0,-2.5,8)
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
    _Start = Window:AddTab({ Title = "Started", Icon = "" }),
    Main = Window:AddTab({ Title = "Main", Icon = "swords" }),
    Misc = Window:AddTab({ Title = "Misc", Icon = "activity" }),
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

    local Tab_Auto_Farm = Tabs.Main:AddToggle("Tab_Auto_Farm", {Title = "Auto Farm", Default = false })

    Tab_Auto_Farm:OnChanged(function()
        _G.Auto_Farm = Options.Tab_Auto_Farm.Value
        while _G.Auto_Farm do task.wait(.01)
            if not _G.Stop then
                Farm()
            end
        end
    end)

    local Tab_Auto_Hit = Tabs.Main:AddToggle("Tab_Auto_Hit", {Title = "Auto Hit", Default = false })

    Tab_Auto_Hit:OnChanged(function()
        _G.Auto_Hit = Options.Tab_Auto_Hit.Value
        while _G.Auto_Hit do task.wait(.01)
            Hit()
        end
    end)

    local Tab_Auto_Skill = Tabs.Main:AddToggle("Tab_Auto_Skill", {Title = "Auto Skill", Default = false })

    Tab_Auto_Skill:OnChanged(function()
        _G.Auto_Skill = Options.Tab_Auto_Skill.Value
        while _G.Auto_Skill do task.wait(.01)
            AutoSkill()
        end
    end)

    local Tab_Auto_Heal = Tabs.Main:AddToggle("Tab_Auto_Heal", {Title = "Auto Heal (When Below 40% HP)", Default = false })

    Tab_Auto_Heal:OnChanged(function()
        _G.Auto_Heal = Options.Tab_Auto_Heal.Value
        while _G.Auto_Heal do task.wait(.01)
            Player_HP(40)
        end
    end)


    -- Misc



    local Tab_Auto_Start = Tabs.Misc:AddToggle("Tab_Auto_Start", {Title = "Auto Start", Default = false })

    Tab_Auto_Start:OnChanged(function()
        _G.Auto_Start = Options.Tab_Auto_Start.Value
        while _G.Auto_Start do task.wait(1)
            Start()
        end
    end)

    local Tab_Auto_Replay = Tabs.Misc:AddToggle("Tab_Auto_Replay", {Title = "Auto Replay", Default = false })

    Tab_Auto_Replay:OnChanged(function()
        _G.Auto_Replay = Options.Tab_Auto_Replay.Value
        while _G.Auto_Replay do task.wait(1)
            Replay()
        end
    end)

    local Tab_Auto_Next = Tabs.Misc:AddToggle("Tab_Auto_Next", {Title = "Auto Replay", Default = false })

    Tab_Auto_Next:OnChanged(function()
        _G.Auto_Next = Options.Tab_Auto_Next.Value
        while _G.Auto_Next do task.wait(1)
            Next()
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
InterfaceManager:SetFolder("Syn0xz Hub")
SaveManager:SetFolder("Syn0xz Hub/FireForce_"..game.Players.LocalPlayer.Character.Name)

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
