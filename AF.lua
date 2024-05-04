repeat wait() until game:IsLoaded()

local function notify(Titles,message)
    game:GetService("StarterGui"):SetCore("SendNotification",{
        Title = tostring(Titles),
        Text = tostring(message),
        Icon = "rbxassetid://1234567890"
    })
end

local function Check_Trait(unit)
    if game:GetService("Players").LocalPlayer:FindFirstChild("Units") then
        for i,v in ipairs(game:GetService("Players").LocalPlayer.Units:GetChildren()) do
            if v:IsA("Folder") and v.Name:find(tostring(unit)) then
                local Traits = v:FindFirstChild("Traits")
                if Traits then
                    local traitValue = Traits.Value
                    if traitValue then
                        if traitValue == "Xenith" or traitValue == "Aurora" or traitValue == "Astral" or traitValue == "Golden" or traitValue == "Celestial" or traitValue == "Ethereal" then
			                game:GetService("ReplicatedStorage").Effect.Onepiece.GodOfSky.Thunder:Play()
                            print("Found : ", traitValue)
                            notify("Trait Found : ", tostring(traitValue))
                            _G.Found = true
                            _G.A = false
                        else
                            print("Rolled : ", traitValue)	
			                notify("Trait Rolled : ", tostring(traitValue))
                            game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("TraitRerollToken"):FireServer(tostring(v))
                            wait(.35)
                        end
                    end
                end
            end
        end
    end
end

_G.JobId = game.JobId

local A = game:GetService("CoreGui"):FindFirstChild("unknown")
if A then
    A:Destroy()
end
local function Rejoin(Job)
    local TeleportService = game:GetService("TeleportService")
    local placeId = game.PlaceId
    local jobId = Job

    local success, errorMessage = pcall(function()
        TeleportService:TeleportToPlaceInstance(placeId, jobId, game.Players.LocalPlayer)
    end)

    if not success then
        warn("Rejoin failed:", errorMessage)
    else
        print("Rejoin successful!")
    end
end

local function Redeems()
    repeat wait() until game:IsLoaded()
wait(.45)


local List = {"Release", "AnimeFantasy", "ShadowMonarch", "Tkz", "Sub2AekZaJunior", "Sub2Jetoza", "Sub2Watchpixel", "Visit150k", "SorryForTimeChamber", "Visit250k", "Likes1500", "Visit500k", "Likes2500", "Visit1M", "Likes4000", "Sub2RikTime", "SorryforShutdown1"}

for i,v in ipairs(List) do
    game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("UseCode"):FireServer(v)
end
end
-- // Loadstring \\ --
local library = loadstring(game:HttpGet('https://raw.githubusercontent.com/cueshut/saves/main/criminality%20paste%20ui%20library'))()

-- // Window \\ --
local window = library.new('Syn0xz Hub', 'Syn0xz')

-- // Tabs \\ --
local tab = window.new_tab('rbxassetid://4483345998')

-- // Sections \\ --

local section = tab.new_section('- Main -')

-- // Sector 1 \\ --

local Misc = section.new_sector('= Misc =', 'Left')
local Server = section.new_sector('= Misc =', 'Right')
local Code = section.new_sector('= Code Redeems =')
local Summon = section.new_sector('= Summon =', 'Right')
local Roll = section.new_sector('= Trait Reroll =', 'Left')


local Roll_1 = Roll.element('Toggle', 'Levy', false, function(v)
    _G.Levy = v.Toggle
    while _G.Levy do wait(.15)
        Check_Trait("Levy")
    end
end)

local Roll_2 = Roll.element('Toggle', 'GodOfSky', false, function(v)
    _G.GodOfSky = v.Toggle
    while _G.GodOfSky do wait(.15)
        Check_Trait("GodOfSky")
    end
end)

local Roll_3 = Roll.element('Toggle', 'FireFist', false, function(v)
    _G.FireFist = v.Toggle
    while _G.FireFist do wait(.15)
        Check_Trait("FireFist")
    end
end)

local Roll_4 = Roll.element('Toggle', 'FireFist', false, function(v)
    _G.FireFist = v.Toggle
    while _G.FireFist do wait(.15)
        Check_Trait("Bulme")
    end
end)

local Code = Code.element('Button', 'Redeemed Code', false, function()
    Redeems()
end)

local Roll = Misc.element('Button', 'Roll Data Rejoin', false, function()
    game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("EquipUnit"):FireServer("\255")
    Rejoin(_G.JobId)
end)

local Main = Server.element('Button', 'Join main server', false, function()
    Rejoin(_G.JobId)
end)

local Main = Server.element('Button', 'Join Server Code', false, function()
    Rejoin("b6e9b7db-6d8f-4346-8bf5-7e24ce1a6e24")
end)

local Main = Server.element('Button', 'Join Old Server', false, function()
    Rejoin("e977d5c0-c49e-48fe-b56d-809e049b485d")
end)

local Specical = Summon.element('Button', '10x Special Summon', false, function()
    for i = 1,10 do
        game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("SpecialSummonTenRoll"):FireServer() -- SpecialSummonTenRoll
    end
end)

local Standard = Summon.element('Button', '10x Standard Summon', false, function()
    for i = 1,10 do
        game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("StandardSummonTenRoll"):FireServer() -- StandardSummonTenRoll
    end
end)
