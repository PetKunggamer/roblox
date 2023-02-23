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
local PlayerGui = game:GetService("Players").LocalPlayer.PlayerGui
local Gold_check = PlayerGui.ScreenGui.Gold.Gold
local Gold = string.match(Gold_check.Text, "%d+")
print(Gold)

local Main_box = Tabs.Main:AddLeftGroupbox('The Bank')

-- Tabboxes are a tiny bit different, but here's a basic example:
--[[
local TabBox = Tabs.Main:AddLeftTabbox() -- Add Tabbox on left side
local Tab1 = TabBox:AddTab('Tab 1')
local Tab2 = TabBox:AddTab('Tab 2')
-- You can now call AddToggle, etc on the tabs you added to the Tabbox
]]

-- Groupbox:AddToggle
-- Arguments: Index, Options

-- This should print to the console: "My toggle state changed! New value: false"

-- Groupbox:AddButton
-- Arguments: Text, Callback

local MyButton = Main_box:AddButton('Deposit All', function()
        local args = {
        [1] = true,
        [2] = 1
    }
    
    game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Bank"):InvokeServer(unpack(args))
    
end)

-- Button:AddButton
-- Arguments: Text, Callback
-- Adds a sub button to the side of the main button

local MyButton2 = MyButton:AddButton('Withdraw All', function()
        local args = {
        [1] = false,
        [2] = 1
    }
    
    game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Bank"):InvokeServer(unpack(args))
    
end)

local MyButton3 = Main_box:AddButton('Check Bank', function()
    local PlayerGui = game:GetService("Players").LocalPlayer.PlayerGui
    local Gold_check = PlayerGui.ScreenGui.Gold.Gold
    local Gold = string.match(Gold_check.Text, "%d+")

        game:GetService("StarterGui"):SetCore(
        "SendNotification",
        {
            Title = "The Bank",
            Text = tostring(game:GetService("Players").LocalPlayer.PlayerStats.Bank.Value),
            Duration = 5
        }
    )
    
    
end)



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

Options.KeyPicker:OnClick(function()
    print('Keybind clicked!', Options.KeyPicker.Value)
end)

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
                        if target then
                            if (v.HumanoidRootPart.Position - hrp.Position).magnitude < 50 then
                                hrp.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0, 0, Distance)
                                hrp.Velocity = Vector3.new(0, 0, 0)
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
        -- example for checking if a keybind is being pressed
        local state = Options.KeyPicker:GetState()
        if state then
            back_mob()
        end

        if Library.Unloaded then break end
    end
end)

Options.KeyPicker:SetValue({ 'G', 'Toggle' }) -- Sets keybind to MB2, mode to Hold


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
