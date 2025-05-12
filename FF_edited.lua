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

local plr = game.Players.LocalPlayer
local PlayerGui = plr:FindFirstChild('PlayerGui')
local TS = game:GetService('TeleportService')
local RS = game:GetService("ReplicatedStorage")
local Events = RS:FindFirstChild("Events")
local CombatEvent = Events:FindFirstChild("CombatEvent")


-- Function

local function AFK()
    local Afk = game:service'VirtualUser'
    game:service'Players'.LocalPlayer.Idled:connect(function()
    	Afk:CaptureController()
    	Afk:ClickButton2(Vector2.new())
    end)
end

local function Graffiti()
    for i,v in ipairs(workspace.MissionItems.Graffiti:GetChildren()) do
        if v:IsA("Part") and v.Name:find("Part") then
            local Cd = v:FindFirstChild('ClickDetector')
            if Cd then
                fireclickdetector(Cd)
                task.wait(.01)
            end
        end 
    end
end

local function Hit()
    for i = 1,4 do
        local args = {
        	i,
        	plr.Character:WaitForChild("FistCombat"):WaitForChild("WeaponInfoFolder"):WaitForChild("Toji"),
        	plr.Character.HumanoidRootPart.CFrame,
        	true,
        	plr.Character:WaitForChild("FistCombat"):WaitForChild("WeaponInfoFolder"):WaitForChild("Toji")
        }
        CombatEvent:FireServer(unpack(args))
        task.wait()
    end
end

local function Get_Mob()
    local dist, mob = math.huge, nil
    local root = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart")
    for _, v in ipairs(workspace.Alive:GetChildren()) do
        if v:IsA("Model") and v ~= plr.Character and not game.Players:GetPlayerFromCharacter(v) then
            local target = v:FindFirstChild("HumanoidRootPart")
            local hum = v:FindFirstChild('Humanoid')
            if target and root and hum and hum.Health > 0.1 then
                local mag = (target.Position - root.Position).Magnitude
                if mag < 50 then
                    mob = v
                    dist = mag
                end
            end
        end
    end
    return mob
end

local function Attach()
    local root = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart")
    local mob = Get_Mob()
    if mob then
        local target = mob:FindFirstChild("HumanoidRootPart")
        if target and root then
            root.CFrame = target.CFrame * CFrame.new(0,0,5)
        end
    end
end

local function Instant()
    local root = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart")
    local mob = Get_Mob()
    if mob then
        local target = mob:FindFirstChild("HumanoidRootPart")
        local hum = mob:FindFirstChild("Humanoid")
        if target and root and hum then
            hum.Health = 0
        end
    end
end

local function GetMob_List()
    local mob_table = {}
    local dist, mob = math.huge, nil
    local root = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart")
    for _, v in ipairs(workspace.Alive:GetChildren()) do
        if v:IsA("Model") and v ~= plr.Character and not game.Players:GetPlayerFromCharacter(v) then
            local target = v:FindFirstChild("HumanoidRootPart")
            local hum = v:FindFirstChild('Humanoid')
            if target and root and hum and hum.Health > 0 then
                table.insert(mob_table, v)
            end
        end
    end
    return mob_table
end

local function Put()
    local mobList = GetMob_List()
    for i, v in ipairs(mobList) do
        local root = v:FindFirstChild("HumanoidRootPart")
        local hum = v:FindFirstChild("Humanoid")
        if root and hum then
            local ESP = root:FindFirstChild("ESP")
            if not ESP then
                local billboard = Instance.new("BillboardGui")
                billboard.Name = "ESP"
                billboard.Adornee = root
                billboard.Size = UDim2.new(2, 0, 2, 0)
                billboard.StudsOffset = Vector3.new(0, 3, 0)
                billboard.AlwaysOnTop = true

                local Health_Mob = Instance.new("TextLabel")
                Health_Mob.Size = UDim2.new(1, 0, 1, 0)
                Health_Mob.BackgroundTransparency = 1
                Health_Mob.TextColor3 = Color3.fromRGB(255, 0, 0) -- Red text
                Health_Mob.TextScaled = true
                Health_Mob.Name = "Health_Mob"
                Health_Mob.Font = Enum.Font.SourceSansBold


                Health_Mob.Parent = billboard
                billboard.Parent = root
            end
        end
    end
end

local function UpdateESP()
    local lp = game.Players.LocalPlayer
    local char = lp.Character or lp.CharacterAdded:Wait()
    local root = char:WaitForChild("HumanoidRootPart")
    for i,v in ipairs(workspace.Alive:GetChildren()) do
        local hum = v:FindFirstChild("Humanoid")
        local rootPart = v:FindFirstChild("HumanoidRootPart")
        if root and hum and rootPart then
            local ESP = rootPart:FindFirstChild("ESP")
            local distance = (root.Position - rootPart.Position).Magnitude
            -- If ESP exists and mob is out of range, remove it
            if ESP and distance > 100 then
                ESP:Destroy()
            elseif ESP then
                ESP.Health_Mob.Text = math.floor(hum.Health) -- Update health
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
    Acrylic = true, -- The blur may be detectable, setting this to false disables blur entirely
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.LeftControl -- Used when theres no MinimizeKeybind
})

--Fluent provides Lucide Icons https://lucide.dev/icons/ for the tabs, icons are optional
local Tabs = {
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

    local Tab_Auto_Hit = Tabs.Main:AddToggle("Tab_Auto_Hit", {Title = "Auto Hit", Default = false })

    Tab_Auto_Hit:OnChanged(function()
        _G.Auto_Hit = Options.Tab_Auto_Hit.Value
        while _G.Auto_Hit do task.wait(.01)
            Hit()
        end
    end)

    local Tab_Auto_Attach = Tabs.Main:AddToggle("Tab_Auto_Attach", {Title = "Auto Attach", Default = false })

    Tab_Auto_Attach:OnChanged(function()
        _G.Auto_Attach = Options.Tab_Auto_Attach.Value
        while _G.Auto_Attach do task.wait(.01)
            Attach()
        end
    end)

    local Tab_Auto_Instant = Tabs.Main:AddToggle("Tab_Auto_Instant", {Title = "Auto Instant", Default = false })

    Tab_Auto_Instant:OnChanged(function()
        _G.Auto_Instant = Options.Tab_Auto_Instant.Value
        while _G.Auto_Instant do task.wait(.01)
            Instant()
        end
    end)

    local Tab_ESP_MOB = Tabs.Main:AddToggle("Tab_ESP_MOB", {Title = "ESP HP MOB", Default = false })

    Tab_ESP_MOB:OnChanged(function()
        _G.ESP_MOB = Options.Tab_ESP_MOB.Value
        while _G.ESP_MOB do task.wait(.01)
            Put()
            UpdateESP()
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
SaveManager:SetFolder("FluentScriptHub/FireForce_"..game.Players.LocalPlayer.Character.Name)

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
