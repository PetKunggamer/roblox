local Players = game:GetService("Players")
local player = Players.LocalPlayer
local Backpack = player.Backpack
local Stand = player.PlayerGui.PlayerGUI.ingame.Stats.StandName["Name_"].TextLabel
local Attribute = player.PlayerGui.PlayerGUI.ingame.Stats.Stats.Attribute.TextLabel
local StandHumanoid = player.Character.Stand
local GUI = game:GetService("StarterGui")

function EquipTool(tool)
    if player and player.Character then
        local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            local tool = player.Backpack:FindFirstChild(tool)
            if tool then

                humanoid:EquipTool(tool)
            end
        end
    end
end

local Whitelist_Stand = getgenv().Whitelist_Stand or {}
local Whitelist_Attribute = getgenv().Whitelist_Attribute or {}

function Change_Name()
    local Backpack = game.Players.LocalPlayer.Backpack:GetChildren()
    for i,v in ipairs(Backpack) do
        if v.Name == "Charged Arrow" then
          v.Name = "Stand Arrow"
        end
    end
end

function check_Stand()
    local Stand_WL = Whitelist_Stand
    for i,Whitelist in ipairs(Stand_WL) do
        if Stand.Text == Whitelist then
             GUI:SetCore("SendNotification", {
             Title = "You Got Stand"; 
             Text = "Stand : "..Stand.Text.."";
             Duration = 1
            })
            return true
        end
    end
    return false
end

function check_Attribute()
    local Attribute_WL = Whitelist_Attribute
    for _,Whitelist in ipairs(Attribute_WL) do
        if Attribute.Text:sub(12) == Whitelist then
             GUI:SetCore("SendNotification", {
             Title = "You Got Attribute"; 
             Text = ""..Attribute.Text.."";
             Duration = 1
            })
            return true
        end
    end
    return false
end


while getgenv().AutoStand do
    wait(3)
    Change_Name()
    Whitelist_Stand = getgenv().Whitelist_Stand
    Whitelist_Attribute = getgenv().Whitelist_Attribute
    local stand_result = check_Stand()
    local attribute_result = check_Attribute()
    if stand_result or attribute_result then
        _G.A = false
        break
    end
    if Stand.Text == "None" and StandHumanoid then
        EquipTool("Stand Arrow")
        if player.Character:FindFirstChild("Stand Arrow") then
            player.Character["Stand Arrow"].Use:FireServer() 
        end 
    else   
        EquipTool("Rokakaka")
        if player.Character:FindFirstChild("Rokakaka") then
            player.Character.Rokakaka.Use:FireServer()
        end
    end
end
