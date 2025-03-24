-- Wait for the game to load
if not game:IsLoaded() then
    game.Loaded:Wait()
end

-- Wait for LocalPlayer's HumanoidRootPart
local player = game:GetService("Players").LocalPlayer
repeat
    wait()
until player.Character and player.Character:FindFirstChild("HumanoidRootPart")

print("Game and HumanoidRootPart are loaded!")

if game.PlaceId ~= 89413197677760 and game.PlaceId ~= 91797414023830 then return end

local hub = game:GetService("CoreGui")

for i,v in ipairs(hub:GetChildren()) do
    if v:IsA("ScreenGui") and v.Name == "ScreenGui" then
        v:Destroy()
    end
end


_G.JobId = ""
_G.Values = ""
_G.QoL = false
_G.Health_Below = 0


local TS = game:GetService('TeleportService')
local plr = game:GetService("Players")
local lp = plr.LocalPlayer
local char = lp.Character or lp.CharacterAdded:Wait()
local root = char:FindFirstChild("HumanoidRootPart") or char:WaitForChild("HumanoidRootPart")
local VirtualInputManager = game:GetService("VirtualInputManager")
local GuiService = game:GetService('GuiService')





-- Function

local function AFK()
    local Afk = game:service'VirtualUser'
    game:service'Players'.LocalPlayer.Idled:connect(function()
    	Afk:CaptureController()
    	Afk:ClickButton2(Vector2.new())
    end)
end

local function Get_Quest()
    local char = game.Players.LocalPlayer.Character
    local race = char:FindFirstChild("Race")
    if race then
        if race.Value == "Human" then
            for i,v in ipairs(workspace.MissionBoards.CCG.MissionBoard.Holder:GetChildren()) do
                if v:IsA("Part") then
                    local SurfaceGui = v:FindFirstChild("SurfaceGui")
                    local cd = v:FindFirstChild("ClickDetector")
                    if SurfaceGui then
                        local Rating = SurfaceGui:FindFirstChild("Rating")
                        if Rating and table.find(_G.Values, Rating.Text) then
                            fireclickdetector(cd)
                        end
                    end
                end
            end
        else
            for i,v in ipairs(workspace.MissionBoards.Ghoul.MissionBoard.Holder:GetChildren()) do
                if v:IsA("Part") then
                    local SurfaceGui = v:FindFirstChild("SurfaceGui")
                    local cd = v:FindFirstChild("ClickDetector")
                    if SurfaceGui then
                        local Rating = SurfaceGui:FindFirstChild("Rating")
                        if Rating and table.find(_G.Values, Rating.Text) then
                            fireclickdetector(cd)
                        end
                    end
                end
            end
        end
    end
end

local function Auto_Loot()
    pcall(function()
    local plr = game:GetService('Players')
    local playergui = plr.LocalPlayer:FindFirstChild("PlayerGui")
        if playergui then
            local bag = playergui:FindFirstChild("BagGui")
            if bag then
                local frame = bag:FindFirstChild("Frame")
                if frame then
                    local ItemsFrame = frame:FindFirstChild('ItemsFrame')
                    if ItemsFrame then
                        for i,v in ipairs(ItemsFrame:GetChildren()) do
                            if v:IsA("TextButton") then
                                print(v)
                                GuiService.SelectedCoreObject = v
                                VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.Return, false, game) task.wait()
                                VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.Return, false, game)
                            end
                        end
                    end
                end
            end
        end
    end)
end

local function Get_Loot()
    for i,v in ipairs(workspace:GetChildren()) do
        if v:IsA("Model") and v.Name:find("giftbox_blend") then
            local root = game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            local box = v.PrimaryPart
            if root and box then
                local mag = (root.Position - box.Position).magnitude
                if mag < 10 then
                    local cd = v:FindFirstChild("ClickDetector")
                    if cd then
                        fireclickdetector(cd)
                    end
                end
            end
        end
    end
end

local function Instant()
    for i,v in ipairs(workspace.Entities:GetChildren()) do
        if v:IsA("Model") and v.Name ~= char.Name then
            local target = v:FindFirstChild("HumanoidRootPart")
            local hum = v:FindFirstChild("Humanoid")
            local ExpG = v:FindFirstChild("ExpGain")
            local root = game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            if target and root and hum and ExpG then
                local mag = (target.Position - root.Position).magnitude
                if mag < 100 and hum.Health > 0 then
                    local percentage = ((hum.Health / hum.MaxHealth) * 100)
                    if percentage < _G.Health_Below and isnetworkowner(target) then
                        hum.Health = -math.huge
                    end
                end
            end
        end
    end
end

local function Bring_Mob()
    for i,v in ipairs(workspace.Entities:GetChildren()) do
        if v:IsA("Model") and v.Name ~= char.Name then
            local target = v:FindFirstChild("HumanoidRootPart")
            local hum = v:FindFirstChild("Humanoid")
            local root = game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            if target and root and hum then
                local mag = (target.Position - root.Position).magnitude
                if mag < 100 and hum.Health > 0 then
                    if isnetworkowner(target) then
                        target.CFrame = root.CFrame * CFrame.new(0,3,0)
                    end
                end
            end
        end
    end
end

local function webhooks()
    local OSTime = os.time();
    local Time = os.date('!*t', OSTime);
    local Avatar = 'https://cdn.discordapp.com/embed/avatars/4.png';
    local Content = '';
    local Embed = {
        title = game.JobId;
        color = '99999';
        footer = { text = game };
        author = {
            name = 'ROBLOX';
            url = 'https://www.roblox.com/';
        };
        fields = {
            {
                name = game.Players.LocalPlayer.Character.Name;
                value = '';
            }
        };
        timestamp = string.format('%d-%d-%dT%02d:%02d:%02dZ', Time.year, Time.month, Time.day, Time.hour, Time.min, Time.sec);
    };
    (syn and syn.request or http_request) {
        Url = 'https://discord.com/api/webhooks/1353434895514468383/Ghw4U-m6N6V2S5oy6R2oZOcBcykdXbtpsOv5OzFrKI631QejpJjeZ7U7fRMELCBS__Je';
        Method = 'POST';
        Headers = {
            ['Content-Type'] = 'application/json';
        };
        Body = game:GetService'HttpService':JSONEncode( { content = Content; embeds = { Embed } } );
    };
end

local function Noclip()
    local plr = game:GetService("Players").LocalPlayer
    local char = plr.Character
    if char then
        for i,v in ipairs(game.Players.LocalPlayer.Character:GetChildren()) do
            if v:IsA("Part") then
                v.CanCollide = false
            end
        end
        for i,v in ipairs(workspace.FakeHeads:GetChildren()) do
            if v:IsA("Part") then
                if v.Name:find(char.Name) then
                    v.CanCollide = false
                end
            end
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
    Acrylic = false, -- The blur may be detectable, setting this to false disables blur entirely
    Theme = "Darker",
    MinimizeKey = Enum.KeyCode.J -- Used when theres no MinimizeKeybind
})

--Fluent provides Lucide Icons https://lucide.dev/icons/ for the tabs, icons are optional
local Tabs = {
    Main = Window:AddTab({ Title = "Main", Icon = "swords" }),
    Character = Window:AddTab({ Title = "Character", Icon = "user" }),
    Misc = Window:AddTab({ Title = "Misc", Icon = "sun" }),
    QoL = Window:AddTab({ Title = "Quality Of Life", Icon = "briefcase" }),
    Settings = Window:AddTab({ Title = "Settings", Icon = "settings" })
}

local Options = Fluent.Options

do
    local Auto_Quest = Tabs.Main:AddToggle("Auto_Quest", {Title = "Auto Quest", Default = false })

    Auto_Quest:OnChanged(function()
        _G.Auto_Quest = Options.Auto_Quest.Value
        while _G.Auto_Quest do task.wait(.1)
            Get_Quest()
        end
    end)

    local Difficult_Diff = Tabs.Main:AddDropdown("MultiDropdown", {
        Title = "Difficult",
        Description = "Select the difficult.",
        Values = {"Hard","Medium","Easy"},
        Multi = true,
        Default = {"Hard"},
    })

    Difficult_Diff:OnChanged(function(Value)
        _G.Values = {}
        for Value, State in next, Value do
            table.insert(_G.Values, Value)
        end
    end)

    Tabs.Character:AddButton({
        Title = "Reset Character",
        Description = "",
        Callback = function()
            Window:Dialog({
                Title = "Reset Character",
                Content = "Are u sure (not pd server)",
                Buttons = {
                    {
                        Title = "Reset Character",
                        Callback = function()
                            game.Players.LocalPlayer.Character.Humanoid.Health = 0
                        end
                    },
                    {
                        Title = "Cancel",
                        Callback = function()
                            print('Cancel Reset Character')
                        end
                    }
                }
            })
        end
    })

    local Noclip_Func = Tabs.Character:AddToggle("Noclip_Func", {Title = "Noclip", Default = false })

    Noclip_Func:OnChanged(function()
        _G.Noclip = Options.Noclip_Func.Value
        while _G.Noclip do task.wait(.01)
            Noclip()
        end
    end)

    local Instant_Kill = Tabs.Misc:AddToggle("Instant_Kill", {Title = "Auto Instant", Default = false })

    Instant_Kill:OnChanged(function()
        _G.Instant = Options.Instant_Kill.Value
        print(_G.Instant)
        while _G.Instant do task.wait(.1)
            Instant()
        end
    end)

    local Slider = Tabs.Misc:AddSlider("Slider", {
        Title = "HP Below",
        Description = "Set hp mob below",
        Default = 95,
        Min = 0,
        Max = 101,
        Rounding = 0,
        Callback = function(Value)
            _G.Health_Below = Value
        end
    })

    local Get_Loot_Tab = Tabs.Misc:AddToggle("Get_Loot_Tab", {Title = "Auto Get Loot", Default = false })

    Get_Loot_Tab:OnChanged(function()
        _G.Get_Loot = Options.Get_Loot_Tab.Value
        while _G.Get_Loot do task.wait(.1)
            Get_Loot()
        end
    end)

    local Auto_Loot_Tab = Tabs.Misc:AddToggle("Auto_Loot_Tab", {Title = "Auto Loot", Default = false })

    Auto_Loot_Tab:OnChanged(function()
        _G.Auto_Loot = Options.Auto_Loot_Tab.Value
        while _G.Auto_Loot do task.wait(.1)
            Auto_Loot()
        end
    end)

            Tabs.Main:AddButton({
            Title = "Open Inventory",
            Description = "",
            Callback = function()
                Window:Dialog({
                    Title = "Open Inventory",
                    Content = "",
                    Buttons = {
                        {
                            Title = "Open Inventory",
                            Callback = function()
                                local vim = game:GetService('VirtualInputManager')
                                vim:SendKeyEvent(true, Enum.KeyCode.Backquote, false, game)
                                vim:SendKeyEvent(false, Enum.KeyCode.Backquote, false, game)
                            end
                        }
                    }
                })
            end
        })

    local Auto_Bring = Tabs.Misc:AddToggle("Auto_Bring", {Title = "Auto Bring Mob", Default = false })

    Auto_Bring:OnChanged(function()
        _G.Bring_Mob = Options.Auto_Bring.Value
        while _G.Bring_Mob do task.wait()
            Bring_Mob()
        end
    end)


    Tabs.Main:AddParagraph({
        Title = "Join Server Function",
        Content = "Press Copy and Join"
    })
    
        Tabs.Main:AddButton({
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
                        Title = "Send to Server",
                        Callback = function()
                            spawn(webhooks)
                        end
                    }
                }
            })
        end
    })

    local Input = Tabs.Main:AddInput("Input", {
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

    local QoL = Tabs.QoL:AddToggle("QoL", {Title = "QoL Enabled", Default = false })

    QoL:OnChanged(function()
        _G.QoL = Options.QoL.Value
        print('Quality of life toggle : ',_G.QoL)
    end)

    local Inventory = Tabs.QoL:AddKeybind("Keybind", {
        Title = "Inventory",
        Mode = "Toggle", -- Always, Toggle, Hold
        Default = "Tab", -- String as the name of the keybind (MB1, MB2 for mouse buttons)

        -- Occurs when the keybind is clicked, Value is `true`/`false`
        Callback = function(Value)
            local vim = game:GetService('VirtualInputManager')
            if _G.QoL then
                vim:SendKeyEvent(true, Enum.KeyCode.Backquote, false, game) wait()
                vim:SendKeyEvent(false, Enum.KeyCode.Backquote, false, game)
            end
        end
    })
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
    Duration = 8
})

-- You can use the SaveManager:LoadAutoloadConfig() to load a config
-- which has been marked to be one that auto loads!
SaveManager:LoadAutoloadConfig()
