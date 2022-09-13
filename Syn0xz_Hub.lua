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
elseif placeId == 9516847915 then
    FPirate = true
elseif placeId == 6152116144 then
    PSlayer = true
elseif placeId == 6147702473 then
    LBA = true
elseif placeId == 9417197334 then
    Anime_story = true
end

if Anime_story then
	repeat wait() until game:IsLoaded()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/PetKunggamer/roblox/main/Anime_Story.lua"))()
end

if LBA then
	repeat wait() until game:IsLoaded()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/PetKunggamer/roblox/main/LBA.lua"))()
end

if PSlayer then
	repeat wait() until game:IsLoaded()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/PetKunggamer/roblox/main/PSlayer.lua"))()
end

if FPirate then
	repeat wait() until game:IsLoaded()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/PetKunggamer/roblox/main/FPirate.lua"))()
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
    

function create_notification(Title,Text,Duration,Callback,Button1,Button2)
    local bindablefunc = Instance.new("BindableFunction")
    bindablefunc.OnInvoke = function(button)
        if button == Button1 then 
            Callback()
        else
            print(button)
        end
    end
    game.StarterGui:SetCore(
        "SendNotification",
        {
            Title = Title,
            Text = Text,
            Duration = Duration or math.huge,
            Callback = bindablefunc,
            Button1 = Button1,
            Button2 = Button2
        }
    )
end

create_notification(
    "Syn0xz Hub",
    "Anti-Afk",
    nil,
    function()
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
    end,
    "Execute",
    "No"
)

