local placeId = game.PlaceId
if placeId == 8540168650 then
    SUR = true
elseif placeId == 6667701234 then
    FX = true
elseif placeId == 9136292138 then
    GP = true
elseif placeId == 6969185078 then
    EA = true
end

if EA then
	repeat wait() until game:IsLoaded()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/PetKunggamer/roblox/main/Elemental_Awakening.lua"))()
end

    
    
if SUR then
	repeat wait() until game:IsLoaded()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/PetKunggamer/roblox/main/StandUpRight_Gui.lua"))() -- ขี้เกียจทำละ hehe boi
end

if FX then
	repeat wait() until game:IsLoaded()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/PetKunggamer/roblox/main/Fate_Xero.lua"))()
end
    

if GP then
	repeat wait() until game:IsLoaded()
	loadstring(game:HttpGet('https://raw.githubusercontent.com/PetKunggamer/roblox/main/Grand_Pirates.lua'))() -- ขี้เกียจทำล้า hehe boi
end
    
    
    
    
--// Variables

local Players = game:GetService("Players")
local OldNameCall = nil

--// Global Variables

getgenv().SendNotifications = false -- Set to true if you want to get notified regularly.

--// Anti Kick Hook

OldNameCall = hookmetamethod(game, "__namecall", function(Self, ...)
    local NameCallMethod = getnamecallmethod()

    if tostring(string.lower(NameCallMethod)) == "kick" then
        if getgenv().SendNotifications == true then
            game:GetService("StarterGui"):SetCore("SendNotification", {
                Title = "Exunys Developer",
                Text = "You almost got kicked! Successfully prevented.",
                Icon = "rbxassetid://6238540373",
                Duration = 3,
            })
        end
        
        return nil
    end
    
    return OldNameCall(Self, ...)
end)

game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Exunys Developer",
        Text = "Anti-Kick script loaded",
        Icon = "rbxassetid://6238537240",
        Duration = 2,
    })


