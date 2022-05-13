local placeId = game.PlaceId
if placeId == 8540168650 then
    SUR = true
elseif placeId == 6667701234 then
    FX = true
elseif placeId == 9136292138 then
    GP = true
elseif placeId == 6969185078 then
    EA = true
elseif placeId == 9530846958 then
    EL2 = true
end

if EL2 then
	repeat wait() until game:IsLoaded()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/PetKunggamer/roblox/main/EL2.lua"))()
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


local GC = getconnections or get_signal_cons
local Players = game.Players
	if GC then
		for i,v in pairs(GC(Players.LocalPlayer.Idled)) do
			if v["Disable"] then
				v["Disable"](v)
			elseif v["Disconnect"] then
				v["Disconnect"](v)
			end
		end
		game.StarterGui:SetCore("SendNotification",
            {
                Title = "Syn0xz Hub",
                Text = "Anti-Afk : Enable",
                Duration = 1.5
            })
	else
		game.StarterGui:SetCore("SendNotification",
            {
                Title = "Syn0xz Hub",
                Text = "Anti-Afk : Error with your Exploit",
                Duration = 1.5
            })
	end

