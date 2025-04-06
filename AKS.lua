local players = game:GetService('Players')
local player = players.LocalPlayer
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
    local args = {
        [1] = {
            [1] = {
                [1] = "PetSystem",
                [2] = "Retreat",
                ["n"] = 2
            },
            [2] = "\2"
        }
    }

    dataRemoteEvent:FireServer(unpack(args))
end

local function Attack()
    local args = {
        [1] = {
            [1] = {
                [1] = "PetSystem",
                [2] = "Attack",
                [3] = tostring(Get_Mob()),
                [4] = true,
                ["n"] = 133
            },
            [2] = "\2"
        }
    }

    dataRemoteEvent:FireServer(unpack(args))
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
                                if mag > 30 then
                                    target.CFrame = Mob.CFrame
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end

local function SetUp_Attack()
    for i = 1,300 do
        Attack()
        task.wait()
        Retreat()
    end
    Retreat()
    wait(.25)
end


_G.A = not _G.A
print(_G.A)
while _G.A do task.wait()
    SetUp_Attack()
end
