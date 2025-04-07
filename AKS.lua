-- Wait for the game to load
if not game:IsLoaded() then
    game.Loaded:Wait()
end

-- Wait for LocalPlayer's HumanoidRootPart
local players = game:GetService('Players')
local player = players.LocalPlayer
local playergui = player.PlayerGui

repeat
    wait()
until player.Character and player.Character:FindFirstChild("HumanoidRootPart")

print("Game and HumanoidRootPart are loaded!")

if game.PlaceId ~= 17334984034 then return end

local hub = game:GetService("CoreGui")

for i,v in ipairs(hub:GetChildren()) do
    if v:IsA("ScreenGui") and v.Name == "ScreenGui" then
        v:Destroy()
    end
end

local function AFK()
    _G.Anti_AFK = player.Idled:connect(function()
    _G.Anti_AFK:CaptureController()
    _G.Anti_AFK:ClickButton2(Vector2.new())
    end)
end

local RS = game:GetService("ReplicatedStorage")
local ffrostflame_bridgenet2 = RS:FindFirstChild("ffrostflame_bridgenet2@1.0.0")
local dataRemoteEvent = ffrostflame_bridgenet2:FindFirstChild("dataRemoteEvent")
local plr = game:GetService("Players").LocalPlayer
local TS = game:GetService('TeleportService')

local count_= 0

local function Check_Dungeon()
    if plr then
        local pgui = plr:FindFirstChild('PlayerGui')
        if pgui then
            local Mode = pgui:FindFirstChild('Mode')
            if Mode then
                local Content = Mode:FindFirstChild("Content")
                if Content then 
                    local Dungeon = Content:FindFirstChild('Dungeon')
                    if Dungeon and Dungeon.Visible then
                        return true
                    end
                end
            end
        end
    end
    return
end

local function Check_Mob()
    local folder_mob = nil
    for _,folder in ipairs(workspace._ENEMIES.Server:GetChildren()) do
        if folder:IsA("Folder") then
            if folder.Name == "Dungeon" or folder.Name == "Raid" then
                for i,v in pairs(folder:GetChildren()) do
                    if v:IsA("Folder") and v.Name == tostring(game.Players.LocalPlayer.UserId) and #v:GetChildren() > 0 then
                        folder_mob = v
                    end
                end
            end
        end
    end
    return folder_mob
end

local function Get_Mob()
    Check_Mob()
    local dist,mob = math.huge,nil
    local root = plr.Character:FindFirstChild("HumanoidRootPart")
    if not root then return end
    for __folder,folder_enemy in ipairs(workspace._ENEMIES.Server:GetChildren()) do
        if folder_enemy:IsA("Folder") then
            if Check_Mob() then
                folder_enemy = Check_Mob()
            end
            for i,v in ipairs(folder_enemy:GetChildren()) do
                local HP = v:GetAttribute('HP')
                if HP and HP > 0 then
                    if v:IsA("Part") then
                        local mag = (root.Position - v.Position).magnitude
                        if mag < dist then
                            dist = mag
                            mob = v
                        end
                    end
                end
            end
        end
    end
    return mob
end

local function Retreat()
    dataRemoteEvent:FireServer(unpack({{{"PetSystem", "Retreat", n = 2}, "\2"}}))
end

local function Attack()
    dataRemoteEvent:FireServer(unpack({{{"PetSystem", "Attack", tostring(Get_Mob()), true, n = 133}, "\2"}}))
end

local function Disabled_Effect()
    local wl = {'Damage','Hit'}
    for i,v in ipairs(workspace._IGNORE:GetChildren()) do
        if v:IsA("Model") or v:IsA("Part") then
            if table.find(wl, v.Name) then
                v:Destroy()
            end
        end
    end
end

local function Set_Pets()
    for i,v in ipairs(workspace._PETS[plr.UserId]:GetChildren()) do
        v:SetAttribute('WalkSPD', 75)
        v:SetAttribute('MaxUlt', 0)
        v:SetAttribute('Scale', 2.5)
        v:SetAttribute('Stats', '{"HitDMG":1e9,"AtkSPD":1e9,"WalkSPD":1e9,"UltDMG":1e9}')
    end
end

local function TP_Mob()
    local root = plr.Character:FindFirstChild("HumanoidRootPart")
    if not root then return end
    local target = Get_Mob()
    if target then
        root.CFrame = target.CFrame * CFrame.new(0,3,5)
    end
end

local function PET_MOB()
    local Mob = Get_Mob()
    if not Mob then return end
    for _,folder in ipairs(workspace._PETS:GetChildren()) do
        if folder:IsA("Folder") then
            if folder.Name == tostring(game.Players.LocalPlayer.UserId) then
                for __,pets in ipairs(folder:GetChildren()) do
                    for i,v in ipairs(pets:GetChildren()) do
                        if v:IsA("Model") then
                            local target = v:FindFirstChild("HumanoidRootPart")
                            if target and Mob then
                                local mag = (target.Position - Mob.Position).magnitude
                                if mag > 15 then
                                    target.CFrame = Mob.CFrame
                                end
                            end
                        end
                    end
                end
            end
        end
    end
    for i,v in ipairs(workspace._IGNORE.ShinyModels:GetChildren()) do
        if v:IsA('Model') then
            local target = v:FindFirstChild("HumanoidRootPart")
            if target and Mob then
                local mag = (target.Position - Mob.Position).magnitude
                if mag > 15 then
                    target.CFrame = Mob.CFrame
                end
            end
        end
    end
end

local function SetUp_Attack()
    for i = 1,_G.loop do
        Attack()
        task.wait()
        Retreat()
    end
    Retreat()
    wait(.25)
end

local function Current_World()
    local world = nil
    local map = workspace._MAP
    if map then
        for i,v in ipairs(map:GetChildren()) do
            if v:IsA("Folder") then
                local spawn = v:FindFirstChild('Spawn')
                local another = v:FindFirstChild(plr.UserId)
                if spawn then
                    world = tostring(v)
                elseif another then
                    local spawn_ = another:FindFirstChild('Spawn')
                    if spawn_ then
                        world = tostring(v)
                    end
                end
            end
        end
    end
    return world
end

local function In_Dungeon()
    local current = Current_World()
    if current == 'Dungeon' then
        return true
    end
    return
end

local function In_Raid()
    local current = Current_World()
    if current == 'Raid' then
        return true
    end
    return
end

local function Dungeon_Start()
    if not Check_Dungeon() then
        if In_Raid() then return end
        if In_Dungeon() then return end
        dataRemoteEvent:FireServer(unpack({{{"DungeonSystem", "Create", n = 2}, "\2"}}))
        dataRemoteEvent:FireServer(unpack({{{"DungeonSystem", "SelectMap", "RuinedPrison", n = 3}, "\2"}}))
        dataRemoteEvent:FireServer(unpack({{{"DungeonSystem", "Start", n = 2}, "\2"}}))
        wait(15)
    else
        TP_Mob()
    end
end

local function Click_Damage()
    dataRemoteEvent:FireServer(unpack({{{"PetSystem", "Click", n = 2}, "\2"}}))
end

local function Auto_Egg()
    local current_world = Current_World()
    if current_world == 'Dungeon' then return end
    if current_world == 'Raid' then return end
    if current_world == "4" then
        local pos = CFrame.new(2671, 98, -7507)
        local root = plr.Character:FindFirstChild("HumanoidRootPart")
        local mag = (root.Position - pos.Position).magnitude
        if not (mag > 10) then
            dataRemoteEvent:FireServer(unpack({{{"PetSystem","Open","Cursed Star","All",n = 4},"\2"}}))
        else
            root.CFrame = pos
        end
    else
        dataRemoteEvent:FireServer(unpack({{{"TeleportSystem","To",4,n = 3},"\2"}}))
        wait(3)
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
    Acrylic = false, -- The blur may be detectable, setting this to false disables blur entirely
    Theme = "Darker",
    MinimizeKey = Enum.KeyCode.J -- Used when theres no MinimizeKeybind
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
            Window:Dialog({
                Title = "Copy JobId",
                Content = "",
                Buttons = {
                    {
                        Title = "Copy",
                        Callback = function()
                            setclipboard(tostring(game.JobId))
                        end
                    },
                    {
                        Title = "Cancel",
                        Callback = function()
                            print('no')
                        end
                    }
                }
            })
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


    local Speed_Quest = Tabs.Main:AddSlider("Loop Attack", {
        Title = "Setup for loop",
        Description = "decrease it when lag",
        Default = 100,
        Min = 1,
        Max = 1000,
        Rounding = 0,
        Callback = function(Value)
            _G.loop = Value
        end
    })
    
    local Auto_Farm = Tabs.Main:AddToggle("Auto_Farm", {
        Title = "Auto Farm",
        Default = false
    })

    Auto_Farm:OnChanged(function()
        _G.AutoFarm = Options.Auto_Farm.Value
        print('_G.AutoFarm : ', _G.AutoFarm)
        while _G.AutoFarm do task.wait()
            SetUp_Attack()
        end
    end)

    local Moded_Pets = Tabs.Main:AddToggle("Moded_Pets", {
        Title = "Mod Pets",
        Default = false
    })

    Moded_Pets:OnChanged(function()
        _G.Mod_Pets = Options.Moded_Pets.Value
        print('_G.Mod_Pets : ', _G.Mod_Pets)
        while _G.Mod_Pets do task.wait()
            Set_Pets()
        end
    end)

    local TP_Mobs = Tabs.Main:AddToggle("TP_Mobs", {
        Title = "TP Mob (Closet)",
        Default = false
    })

    TP_Mobs:OnChanged(function()
        _G.TP_Mob = Options.TP_Mobs.Value
        print('_G.TP_Mob : ', _G.TP_Mob)
        while _G.TP_Mob do task.wait(.25)
            TP_Mob()
        end
    end)

    local MOB_TP = Tabs.Main:AddToggle("MOB_TP", {
        Title = "Pets TP (Closet)",
        Default = false
    })

    MOB_TP:OnChanged(function()
        _G.Mob_TPS = Options.MOB_TP.Value
        print('_G.Mob_TPS : ', _G.Mob_TPS)
        while _G.Mob_TPS do task.wait(.1)
            PET_MOB()
        end
    end)

    local Auto_Eggs = Tabs.Main:AddToggle("Auto_Eggs", {
        Title = "Auto Egg (World 4)",
        Default = false
    })
 
    Auto_Eggs:OnChanged(function()
        _G.Auto_Egg = Options.Auto_Eggs.Value
        print('_G.Auto_Egg : ', _G.Auto_Egg)
        while _G.Auto_Egg do task.wait(.1)
            Auto_Egg()
        end
    end)

    local Damage_Clicker = Tabs.Main:AddToggle("Damage_Clicker", {
        Title = "Clicker Damage",
        Default = false
    })
 
    Damage_Clicker:OnChanged(function()
        _G.Click_Damage = Options.Damage_Clicker.Value
        print('_G.Click_Damage : ', _G.Click_Damage)
        while _G.Click_Damage do task.wait(.1)
            Click_Damage()
        end
    end)

    local Auto_Dun = Tabs.Main:AddToggle("Auto_Dun", {
        Title = "Auto Dungeon",
        Default = false
    })
 
    Auto_Dun:OnChanged(function()
        _G.Auto_Dungeon = Options.Auto_Dun.Value
        print('_G.Auto_Dungeon : ', _G.Auto_Dungeon)
        while _G.Auto_Dungeon do task.wait(.1)
            Dungeon_Start()
        end
    end)







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
InterfaceManager:SetFolder("Fluent_Syn0xzHub")
SaveManager:SetFolder("Fluent_Syn0xzHub/Ghoul_RE")

InterfaceManager:BuildInterfaceSection(Tabs.Settings)
SaveManager:BuildConfigSection(Tabs.Settings)


Window:SelectTab(1)

Fluent:Notify({
    Title = "Syn0xz Hub",
    Content = "The script has been loaded.",
    Duration = 5
})

-- You can use the SaveManager:LoadAutoloadConfig() to load a config
-- which has been marked to be one that auto loads!
SaveManager:LoadAutoloadConfig()
