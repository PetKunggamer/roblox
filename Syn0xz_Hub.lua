local placeId = game.PlaceId

local places = {
    [8540168650] = "SUR",
    [6667701234] = "FX",
    [9136292138] = "GP",
    [6969185078] = "EA",
    [9530846958] = "EL2",
    [9516847915] = "FPirate",
    [6152116144] = "PSlayer",
    [6147702473] = "LBA",
    [9417197334] = "Anime_story",
    [6735572261] = "PG",
    [14069122388] = "Type_Soul",
    [14069678431] = "Type_Soul",
    [7390824960] = "FF",
    [16139895491] = "Project_xl",
    [6897167394] = "Demon_Piece",
    [16474126979] = "AF",
    [89438510123061] = "AS",
    [15866483817] = "JJK_Odyssey",
}

local scripts = {
    JJK_Odyssey = "JJK_Odyssey.lua",
    JJK_INF = "Jujutsu_Infinite.lua",
    AS = "Anime_Shadow_Hub.lua",
    AF = "AF.lua",
    Demon_Piece = "Demon_piece_hub.lua",
    Project_xl = "project_xl_.lua",
    FF = "FF.lua",
    Type_Soul = "Type_Soul.lua",
    PG = "PG.lua",
    Anime_story = "Anime_Story.lua",
    LBA = "LBA.lua",
    PSlayer = "PSlayer.lua",
    FPirate = "FPirate.lua",
    EL2 = "EL2.lua",
    EA = "Elemental_Awakening.lua",
    SUR = "StandUpRight_Gui.lua",
    FX = "Fate_Xero.lua",
    GP = "Grand_Pirates.lua",
}

local scriptName = places[placeId]

if scriptName then
    repeat wait() until game:IsLoaded()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/PetKunggamer/roblox/main/" .. scripts[scriptName]))() -- Script for current placeId
end

-- Anti-AFK
local vu = game:GetService("VirtualUser")
game:GetService("Players").LocalPlayer.Idled:connect(function()
    vu:Button2Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
    wait(1)
    vu:Button2Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
end)

print("Anti Kick: Enabled")
