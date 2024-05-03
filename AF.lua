repeat wait() until game:IsLoaded()

_G.JobId = "6b6afd69-2b73-473a-8972-a74ebd906213"

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

local Code = Code.element('Button', 'Roll Data Rejoin', false, function()
    local List = {"Release", "AnsimeFantasy", "ShadowMonarch", "Tkz", "Sub2AekZaJunior", "Sub2Jetoza", "Sub2Watchpixel", "Visit150k", "SorryForTimeChamber", "Visit250k", "Likes1500", "Visit500k", "Likes2500"}

    for i,v in ipairs(List) do
        game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("UseCode"):FireServer(v)
    end
end)

local Roll = Misc.element('Button', 'Roll Data Rejoin', false, function()
    game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("EquipUnit"):FireServer("\255")
    Rejoin(_G.JobId)
end)

local Main = Server.element('Button', 'Join main server', false, function()
    Rejoin(_G.JobId)
end)

local Main = Server.element('Button', 'Join Old Server For COde', false, function()
    Rejoin("27100a69-adf7-4731-9678-e0c7c54d5698")
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
