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

if not (game.PlaceId == 99995671928896) then return end

wait(3)

repeat wait() until game:IsLoaded()

local function Notify(text)
    game:GetService("StarterGui"):SetCore("SendNotification",{
    Title = 'Syn0xz Hub',
    Text = text, 
    Duration = 3
    })
end

local function AFK()
    local Afk = game:service'VirtualUser'
    game:service'Players'.LocalPlayer.Idled:connect(function()
    	Afk:CaptureController()
    	Afk:ClickButton2(Vector2.new())
    end)
    Notify('Anti afk loaded')
end

local function Get_Fairy()
    local fairy,part_fairy, prompt_fairy = nil
    local root = game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    for i,v in ipairs(workspace.Alive:GetChildren()) do
        if v:IsA("Model") then
            if v.Name:find("Fairy.") then
                local target = v:FindFirstChild("HumanoidRootPart")
                local master = v:FindFirstChild("Master")
                local prompt = v:FindFirstChild("InteractPrompt")
                if target and prompt and root and not master then
                    fairy = v
                    part_fairy = target
                    prompt_fairy = prompt
                end
            end
        end
    end
    return fairy, part_fairy, prompt_fairy
end

local function Noclip(bool)
    for i,v in ipairs(game.Players.LocalPlayer.Character:GetChildren()) do
        if v:IsA("Part") then
            v.CanCollide = bool
        end
    end
end

local function moveCharacterBySteps(targetCFrame, stepDistance)
    local plr = game.Players.LocalPlayer
    local chr = plr.Character or plr.CharacterAdded:Wait()
    local root = chr and chr:FindFirstChild("HumanoidRootPart")
    
    if not root then
        warn("HumanoidRootPart not found.")
        return
    end
    
    local currentCFrame = root.CFrame
    local direction = (targetCFrame.Position - currentCFrame.Position).unit
    local targetPosition = targetCFrame.Position
    while (currentCFrame.Position - targetPosition).Magnitude > stepDistance do
        Noclip(false)
        currentCFrame = currentCFrame + direction * stepDistance
        root.CFrame = currentCFrame  -- Move the player smoothly
        root.Velocity = Vector3.zero
        task.wait(.01)  -- Adjust for speed control
    end
    if (root.Position - targetPosition).Magnitude <= stepDistance then -- Prevent Teleport When Not Close To Target Position
        Noclip(false)
        root.CFrame = targetCFrame  -- Ensure exact final position
    end
end

--[[
	WARNING: Heads up! This script has not been verified by ScriptBlox. Use at your own risk!
]]
local function webhooks(Name)
    local OSTime = os.time();
    local Time = os.date('!*t', OSTime);
    local Content = '';
    local Embed = {
        title = "Found "..Name;
        color = '99999';
        footer = { text = game.JobId };
        author = {
            name = 'Rune Slayer [ROBLOX]';
            url = 'https://www.roblox.com/games/99995671928896';
        };
        fields = {
            {
                name = 'Username';
                value = game.Players.LocalPlayer.Character.Name;
            }
        };
        timestamp = string.format('%d-%d-%dT%02d:%02d:%02dZ', Time.year, Time.month, Time.day, Time.hour, Time.min, Time.sec);
    };
    (syn and syn.request or http_request) {
        Url = 'https://discord.com/api/webhooks/1344172292267053158/6uC1AwHq4y8Pr13CYPKsYeDOldAn9YprsWQaIGIUSaTn62pJVL7vrnO4CysJL57PkpMc';
        Method = 'POST';
        Headers = {
            ['Content-Type'] = 'application/json';
        };
        Body = game:GetService'HttpService':JSONEncode( { content = Content; embeds = { Embed } } );
    };
end

local waypoints = {
    CFrame.new(866, 240, -956), -- 1
    CFrame.new(866, 140, -956),
    CFrame.new(973, 140, -1019), -- 2
    CFrame.new(1560, 140, -1123), -- 3
    CFrame.new(1871, 140, -1246), -- 4
    CFrame.new(2393, 140, -918), -- 5
    CFrame.new(2696, 140, -1183), -- 6
    CFrame.new(2696, 140, -1183), -- 7
    CFrame.new(2644, 140, -1449), -- 8
    CFrame.new(2548, 140, -1617), -- 10
    CFrame.new(2548, 140, -1617), -- 11
    CFrame.new(2390, 140, -1631), -- 12
    CFrame.new(2256, 140, -1428), -- 14
    CFrame.new(1730, 140, -1261), -- 15
    CFrame.new(1562, 140, -1236), -- 17
    CFrame.new(1554, 140, -1245), -- 18
    CFrame.new(1257, 140, -1332), -- 19
    CFrame.new(788, 140, -1603), -- 21
    CFrame.new(788, 140, -1603), -- 23
    CFrame.new(530, 140, -1378), -- 24
    CFrame.new(530, 140, -1378), -- 26
    CFrame.new(739, 140, -1110), -- 27
    CFrame.new(866, 140, -956), -- 28
    CFrame.new(866, 240, -956) -- 28
}

local function Easy_Fairy()
    local plr = game.Players.LocalPlayer
    local chr = plr.Character or plr.CharacterAdded:Wait()
    local root = chr and chr:FindFirstChild("HumanoidRootPart")
    local found = false
    for _, targetCF in ipairs(waypoints) do
        local Fairy, part, prompt = Get_Fairy()
        if not Fairy then
            found = false
            moveCharacterBySteps(targetCF, 2)  -- Move 2 studs per step
            task.wait(.01)
        else
            if not found then
                found = true
                local CFrame_part = CFrame.new(part.Position.X, 140, part.Position.Z)
                moveCharacterBySteps(CFrame_part, 3)
            end
            if part and root and prompt then
                local CFrame_part = CFrame.new(part.Position.X, 140, part.Position.Z)
                moveCharacterBySteps(part.CFrame, 3)
                task.wait(.35)
                    for i = 1,10 do
                        fireproximityprompt(prompt)
                        task.wait(.01)
                    end
                webhooks(Fairy.Name)
                moveCharacterBySteps(CFrame_part, 3)
            end
        end
    end
end

AFK()
Notify('Fairy Bot : '..tostring(_G.Farm))
while _G.Farm do wait()
    Easy_Fairy()
end

