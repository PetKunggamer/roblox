local Library = loadstring(game:HttpGet("https://pastebin.com/raw/6W1ZqV53"))()

local m = Library:Window("Chaiwat Hub")
local t = Library:Window("Teleport")
local c = Library:Window("Misc")


c:Button("Check Boss",function()
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
            Duration = Duration or 20.5,
            Callback = bindablefunc,
            Button1 = Button1,
            Button2 = Button2
        }
    )
end

local mob = game:GetService("Workspace").Characters["Kirei Kotomine"]
if mob.Humanoid.Health >= 1 then
    create_notification(
    "Checking Boss",
    "Kirei Kotomine",
    nil,
    function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(3547, 20, -857)
    end,
    "Teleport",
    "No"
)
    else
        game.StarterGui:SetCore("SendNotification",    
        {
                Title = "Checking Boss",
                Text = "Not Found",
                Duration = 1.5
            })
end
end)


c:Button("Anti afk",function()
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
                Title = "Chaiwat Hub",
                Text = "Antiafk : On",
                Duration = 1.5
            })
	else
		game.StarterGui:SetCore("SendNotification",
            {
                Title = "Chaiwat Hub",
                Text = "Your exploit not support",
                Duration = 1.5
            })
	end
end)

t:Button("Park",function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-36, 150, -1160)
end)


t:Button("Storage",function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-86, 150, -614)
end)

m:Toggle("Item Farm",function(v)
getgenv().ItemFarm = v
    while getgenv().ItemFarm do wait()
        local ItemFolder = game:GetService("Workspace").Items
            for i,v in ipairs(ItemFolder:GetDescendants()) do
                if v.ClassName == "Tool" and v:FindFirstChild("Handle") then
                  v.Handle.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
                end
            end
        end
end)
        
        game.StarterGui:SetCore("SendNotification",
            {
                Title = "Chaiwat Hub",
                Text = "Thank For Using!!",
                Duration = 1.5
            })
