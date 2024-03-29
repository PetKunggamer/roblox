-- New example script written by wally
-- You can suggest changes with a pull request or something

local repo = 'https://raw.githubusercontent.com/wally-rblx/LinoriaLib/main/'

local Library = loadstring(game:HttpGet(repo .. 'Library.lua'))()
local ThemeManager = loadstring(game:HttpGet(repo .. 'addons/ThemeManager.lua'))()
local SaveManager = loadstring(game:HttpGet(repo .. 'addons/SaveManager.lua'))()

local Window = Library:CreateWindow({
    -- Set Center to true if you want the menu to appear in the center
    -- Set AutoShow to true if you want the menu to appear when it is created
    -- Position and Size are also valid options here
    -- but you do not need to define them unless you are changing them :)

    Title = 'Syn0xz Hub [Pilgrammed]',
    Center = true, 
    AutoShow = true,
})

-- You do not have to set your tabs & groups up this way, just a prefrence.
local Tabs = {
    -- Creates a new tab titled Main
    Main = Window:AddTab('Main'), 
    ['UI Settings'] = Window:AddTab('UI Settings'),
}

-- Groupbox and Tabbox inherit the same functions
-- except Tabboxes you have to call the functions on a tab (Tabbox:AddTab(name))


local Main_box = Tabs.Main:AddLeftGroupbox('Farming')


Main_box:AddToggle('MyToggle', {
    Text = 'Semi God',
    Default = false, -- Default value (true / false)
})


Toggles.MyToggle:OnChanged(function()
    -- here we get our toggle object & then get its value
    _G.Roll = Toggles.MyToggle.Value
    
    while _G.Roll do wait()
        game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Roll"):FireServer()
    end
end)

Toggles.MyToggle:SetValue(false)

Main_box:AddSlider('Distance', {
    Text = 'Distance',

    Default = 0,
    Min = 0,
    Max = 30,
    Rounding = 1,

    Compact = false, -- If set to true, then it will hide the label
})

Options.Distance:OnChanged(function()
    Distance = Options.Distance.Value
end)

Options.Distance:SetValue(8)

Main_box:AddLabel('TP Mob (ฺBack)'):AddKeyPicker('KeyPicker', {

    Default = 'G', -- String as the name of the keybind (MB1, MB2 for mouse buttons)  
    SyncToggleState = false, 

    Mode = 'Toggle', -- Modes: Always, Toggle, Hold

    Text = 'TP Mob ฺBack', -- Text to display in the keybind menu
    NoUI = false, -- Set to true if you want to hide from the Keybind menu,
})


function back_mob()
    local Char = game.Players.LocalPlayer.Character
    local hrp = Char:FindFirstChild("HumanoidRootPart")
    local mob = game:GetService("Workspace").Mobs
    for i, v in ipairs(mob:GetDescendants()) do
        if v:IsA("Model") then
            local target_humanoid = v:FindFirstChildOfClass("Humanoid")
            if target_humanoid then
                if target_humanoid.Health > 0 then
                    if hrp then
                        local target = v:FindFirstChild("HumanoidRootPart")
                        if target and v.Name ~= "Test Dummy" and v.Name ~= "Mech Dummy" and v.Name ~= "Mini Thief"  and v.Name ~= "Elite Defender" then
                            if (v.HumanoidRootPart.Position - hrp.Position).magnitude < 50 then
                                hrp.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0, 0, Distance)
                                hrp.Velocity = Vector3.new(0, 0, 0)
                                local Ch = game:GetService("Players").LocalPlayer.Character
                                for i,v in ipairs(Ch:GetDescendants()) do
                                    if v:IsA("Tool") then
                                        local Slash = v:FindFirstChild("Slash")
                                        if Slash then
                                            Slash:FireServer(1)
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end


task.spawn(function()
    while true do wait()
        local state = Options.KeyPicker:GetState()
        if state then
            back_mob()
        end
        if Library.Unloaded then break end
    end
end)

local Main_box = Tabs.Main:AddLeftGroupbox('The Bank')

Main_box:AddToggle('Deposit', {
    Text = 'Auto Deposit',
    Default = false,
})


Toggles.Deposit:OnChanged(function()
    _G.Deposit = Toggles.Deposit.Value
    
    while _G.Deposit do wait()
        game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Bank"):InvokeServer(true,1)
    end
end)

Toggles.Deposit:SetValue(false)


local MyButton = Main_box:AddButton('Deposit All', function()
    game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Bank"):InvokeServer(true,1)
end)

local MyButton2 = MyButton:AddButton('Withdraw All', function()
    game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Bank"):InvokeServer(false,1)
end)

local MyButton3 = Main_box:AddButton('Bank', function()
        game:GetService("Players").LocalPlayer.PlayerGui.ScreenGui.Bank.Visible = true
end)


Options.KeyPicker:SetValue({ 'Y', 'Toggle' }) -- Sets keybind to MB2, mode to Hold

local Mining = Tabs.Main:AddLeftGroupbox('Ore TP')

Mining:AddDropdown('MyDropdown', {
    Values = {nil, 'Tin', 'Zinc', 'Copper', 'Sulfur', 'Iron', 'Demetal', 'Mithril', 'Sapphire', 'Ruby', 'Emerald', 'Diamond'},
    Default = 1, -- number index of the value / string
    Multi = false, -- true / false, allows multiple choices to be selected

    Text = '',
})

Options.MyDropdown:OnChanged(function()
    function Ore_TP(Ore)
        local Ores = game:GetService("Workspace").Ores
        for i,v in ipairs(Ores:GetDescendants()) do
            if v.Name == Ore then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.CFrame
            end
        end
    end
    Ore_TP(Options.MyDropdown.Value)
end)





local Main_box = Tabs.Main:AddRightGroupbox('Misc')

local MyButton2 = Main_box:AddButton('Equipment', function()
    for i,v in ipairs(game:GetService("Workspace").Map.CloudCity:GetDescendants()) do
        if v:IsA("ProximityPrompt") then
            fireproximityprompt(v)
        end
    end
end)

local MyButton3 = MyButton2:AddButton('Reforge', function()
    fireproximityprompt(game:GetService("Workspace").NPCs["Tilly"].HumanoidRootPart.DialogClick)
end)

local MyButton = Main_box:AddButton('Mirror', function()

local Mirror = game:GetService("Workspace").Mirrors
for i,v in ipairs(Mirror:GetDescendants()) do
    if v:IsA("ProximityPrompt") then
        fireproximityprompt(v)
    end
end
    fireproximityprompt(game:GetService("Workspace").Mirrors.Prairie:GetChildren()[3].ProximityPrompt)
end)

local Camera = MyButton:AddButton('Camera', function()
    function Camera()
    local sc = (debug and debug.setconstant) or setconstant
    local gc = (debug and debug.getconstants) or getconstants
    if not sc or not getgc or not gc then
        return notify(
            "Incompatible Exploit",
            "Your exploit does not support this command (missing setconstant or getconstants or getgc)"
        )
    end
    local pop = game.Players.LocalPlayer.PlayerScripts.PlayerModule.CameraModule.ZoomController.Popper
    for _, v in pairs(getgc()) do
        if type(v) == "function" and getfenv(v).script == pop then
            for i, v1 in pairs(gc(v)) do
                if tonumber(v1) == .25 then
                    sc(v, i, 0)
                elseif tonumber(v1) == 0 then
                end
            end
        end
    end
    game.Players.LocalPlayer.CameraMaxZoomDistance = 1e9
end

Camera()

end)


local Race = Tabs.Main:AddRightGroupbox('Race')

local MyButton = Race:AddButton('Ice Imp', function()
    game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Skill"):FireServer("Reaper")
    game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Skill"):FireServer("Ice")
end)

local MyButton1 = MyButton:AddButton('Vampire', function()
    game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Skill"):FireServer("Reaper")
    game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Skill"):FireServer("Vampire")
end)

local Gem_Quest = Tabs.Main:AddRightGroupbox('Farming Gem')

local NPC = Gem_Quest:AddButton('Get Quest', function()
    fireproximityprompt(game:GetService("Workspace").NPCs["Scampi"].HumanoidRootPart.DialogClick)
end)

local MyButton1 = Gem_Quest:AddButton('The Patris', function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-3179, 35, -4474)
end)

local MyButton2 = MyButton1:AddButton('King Sandpod', function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(158, -20, -2250)
end)

local MyButton3 = Gem_Quest:AddButton('Granny', function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1357, 25, -3522)
end)

local MyButton4 = MyButton3:AddButton('Big Fish', function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-374, -27, -2585)
end)

Library:SetWatermarkVisibility(false)

-- Sets the watermark text
Library:SetWatermark('Chaiwat On Top')

Library.KeybindFrame.Visible = true; -- todo: add a function for this

Library:OnUnload(function()
    print('Unloaded!')
    Library.Unloaded = true
end)

-- UI Settings
local MenuGroup = Tabs['UI Settings']:AddLeftGroupbox('Menu')

-- I set NoUI so it does not show up in the keybinds menu
MenuGroup:AddButton('Unload', function() Library:Unload() end) 
MenuGroup:AddLabel('Menu bind'):AddKeyPicker('MenuKeybind', { Default = 'Insert', NoUI = true, Text = 'Menu keybind' }) 

Library.ToggleKeybind = Options.MenuKeybind -- Allows you to have a custom keybind for the menu

-- Addons:
-- SaveManager (Allows you to have a configuration system)
-- ThemeManager (Allows you to have a menu theme system)

-- Hand the library over to our managers
ThemeManager:SetLibrary(Library)
SaveManager:SetLibrary(Library)

-- Ignore keys that are used by ThemeManager. 
-- (we dont want configs to save themes, do we?)
SaveManager:IgnoreThemeSettings() 

-- Adds our MenuKeybind to the ignore list 
-- (do you want each config to have a different menu key? probably not.)
SaveManager:SetIgnoreIndexes({ 'MenuKeybind' }) 

-- use case for doing it this way: 
-- a script hub could have themes in a global folder
-- and game configs in a separate folder per game
ThemeManager:SetFolder('MyScriptHub')
SaveManager:SetFolder('MyScriptHub/specific-game')

-- Builds our config menu on the right side of our tab
SaveManager:BuildConfigSection(Tabs['UI Settings']) 

-- Builds our theme menu (with plenty of built in themes) on the left side
-- NOTE: you can also call ThemeManager:ApplyToGroupbox to add it to a specific groupbox
ThemeManager:ApplyToTab(Tabs['UI Settings'])

-- You can use the SaveManager:LoadAutoloadConfig() to load a config 
-- which has been marked to be one that auto loads!
