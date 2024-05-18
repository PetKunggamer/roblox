function clickUiButton(v, state)
    local virtualInputManager = game:GetService('VirtualInputManager')
    virtualInputManager:SendMouseButtonEvent(v.AbsolutePosition.X + v.AbsoluteSize.X / 2, v.AbsolutePosition.Y + 50, 0, state, game, 1)
end

local function Redeem_Code()
    local List = { "RERELEASE", "FOLLOWERGI999", "FOLLOWJLEAY" }
    for i, v in ipairs(List) do
        local PlayerGui = game:GetService("Players").LocalPlayer.PlayerGui
        if PlayerGui then
            local Interface = PlayerGui:FindFirstChild("Interface")
            if Interface then
                local Title_Screen = Interface:FindFirstChild("Title_Screen")
                if Title_Screen then
                    local Codes = Title_Screen:FindFirstChild("Codes")
                    if not Codes.Visible then
                        clickUiButton(game:GetService("Players").LocalPlayer.PlayerGui.Interface.Title_Screen.Buttons.Codes, true)
                        clickUiButton(game:GetService("Players").LocalPlayer.PlayerGui.Interface.Title_Screen.Buttons.Codes, false)
                        wait(.5)
                    end
                    if Codes then
                        local Main = Codes:FindFirstChild("Main")
                        if Main then
                            local Code = Main:FindFirstChild("Code")
                            if Code then
                                local Interact = Code:FindFirstChild("Interact")
                                if Interact then
                                    Interact.Text = v
                                    clickUiButton(game:GetService("Players").LocalPlayer.PlayerGui.Interface.Title_Screen.Codes.Main.Redeem, true)
                                    clickUiButton(game:GetService("Players").LocalPlayer.PlayerGui.Interface.Title_Screen.Codes.Main.Redeem, false)
                                    wait(.65)
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end

local function Roll()
    local PlayerGui = game:GetService("Players").LocalPlayer.PlayerGui
    if PlayerGui then
        local Interface = PlayerGui:FindFirstChild("Interface")
        if Interface then
            local Customisation = Interface:FindFirstChild("Customisation")
            if Customisation then
                local Family = Customisation:FindFirstChild("Family")
                if Family then
                    local Buttons_2 = Family:FindFirstChild("Buttons_2")
                    if Buttons_2 then
                        local Roll = Buttons_2:FindFirstChild("Roll")
                        if Roll then
                            clickUiButton(Roll, true)
                            clickUiButton(Roll, false)
                        end
                    end
                end
            end
        end
    end
end

local function Get_Clan()
    local PlayerGui = game:GetService("Players").LocalPlayer.PlayerGui
    if PlayerGui then
        local Interface = PlayerGui:FindFirstChild("Interface")
        if Interface then
            local Customisation = Interface:FindFirstChild("Customisation")
            if Customisation then
                local Family1 = Customisation:FindFirstChild("Family")
                if Family1 then
                    local Family = Family1:FindFirstChild("Family")
                    if Family then
                        local Title = Family:FindFirstChild("Title")
                        if Title then
                            return Title.Text
                        end
                    end
                end
            end
        end
    end
end

local function Finding_Clan()
    local Family = Get_Clan()
    if Family:find("YEAGER") or Family:find("ACKERMAN") or Family:find("REISS") then
        print("Found")
        _G.A = false
    else
        print("Rolled : ", Family)
        Roll()
    end
end

local function TP_Titan()
    local virtualInputManager = game:GetService('VirtualInputManager')
    for i,v in ipairs(workspace.Titans:GetChildren()) do
       if v:IsA("Model") and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") then
          local Hitboxes = v:FindFirstChild("Hitboxes")
          if Hitboxes then
             local Hit = Hitboxes:FindFirstChild("Hit")
             if Hit then
                local target = Hit:FindFirstChild("Nape")
                target.Size = Vector3.new(200,200,200)
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = target.CFrame * CFrame.new(0,80,0)
                virtualInputManager:SendMouseButtonEvent(100, 50, 0, true, game, 1)
                virtualInputManager:SendMouseButtonEvent(100, 50, 0, false, game, 1)
             end
          end
       end
    end
 end

 
game:GetService("UserInputService").InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.L then
        if game:GetService("CoreGui"):FindFirstChild("unknown") then
            game:GetService("CoreGui"):FindFirstChild("unknown").Enabled = not game:GetService("CoreGui"):FindFirstChild("unknown").Enabled
        end
    end
end)

local A = game:GetService("CoreGui"):FindFirstChild("unknown")
if A then
    A:Destroy()
end

local TweenService = game:GetService("TweenService")
local plr = game.Players.LocalPlayer
local chr = plr.Character
local root = chr.HumanoidRootPart

local library = loadstring(game:HttpGet('https://raw.githubusercontent.com/cueshut/saves/main/criminality%20paste%20ui%20library'))()

-- // Window \\ --
local window = library.new('Syn0xz Hub', 'Syn0xz')

-- // Tabs \\ --
local tab = window.new_tab('rbxassetid://4483345998')

-- // Sections \\ --
local section = tab.new_section('- Main -')


-- // Sector \\ --
local Main = section.new_sector('= Main =', 'Left')
local Misc = section.new_sector('= Misc =', 'Right')

local AutoFarm = Main.element('Toggle', 'Auto Farm', false, function(v)
    _G.AutoFarm = v.Toggle
    while _G.AutoFarm do task.wait(.175)
        TP_Titan()
    end
end) 


local Code = Misc.element('Button', 'Redeem Code', false, function()
    wait(.25)
    Redeem_Code()
end) 

local Finding_Clan = Main.element('Toggle', 'Finding Clan', false, function(v)
    _G.Finding_Clan = v.Toggle
    while _G.Finding_Clan do task.wait(1)
        Finding_Clan()
    end
end) 




