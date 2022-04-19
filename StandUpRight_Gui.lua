local Library = loadstring(game:HttpGet("https://pastebin.com/raw/6W1ZqV53"))()

local w = Library:Window("Chaiwat Hub")

local p = Library:Window("Auto Buy")

local c = Library:Window("Item Farm")

c:Toggle("Farm", function(v)
    getgenv().ItemFarm = v
   loadstring(game:HttpGet"https://raw.githubusercontent.com/PetKunggamer/roblox/main/ItemFarm.lua")()
end)


p:Button("Stand Arrow", function()
    function StandArrow()
    game:GetService("ReplicatedStorage").Events.BuyItem:FireServer("MerchantAU","Option3")
    end
    StandArrow()
end)

p:Button("Rokakaka", function()
    function Rokaka()
    game:GetService("ReplicatedStorage").Events.BuyItem:FireServer("MerchantAU","Option1")
    end
    Rokaka()
end)


w:Button("Bypass", function()
   loadstring(game:HttpGet"https://raw.githubusercontent.com/PetKunggamer/roblox/main/Bypass_NPC.lua")()
   loadstring(game:HttpGet"https://github.com/PetKunggamer/roblox/blob/main/BypassStandUR.lua")()
        game.StarterGui:SetCore("SendNotification", {
        Title = "Anti Cheat";
        Text = "Bypass successfully!!";
        Icon = "rbxassetid://57254792";
        Duration = 5;
        
end)

w:Toggle("Auto Farm", function(v)
    getgenv().AutoFarm = v
   loadstring(game:HttpGet"https://raw.githubusercontent.com/PetKunggamer/roblox/main/AutoFarm.lua")()
end)

w:Toggle("Lair Farm", function(v)
    getgenv().Lair_Farm = v
   loadstring(game:HttpGet"https://github.com/PetKunggamer/roblox/blob/main/Lair_Farm.lua")()
end)

