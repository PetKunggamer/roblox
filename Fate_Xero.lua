local Library = loadstring(game:HttpGet("https://pastebin.com/raw/6W1ZqV53"))()

local m = Library:Window("Chaiwat Hub")
local t = Library:Window("Teleport")
local c = Library:Window("Misc")


c:Button("Anti AFk",function()
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


t:Button("Storage",function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-86, 145, -614)
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
