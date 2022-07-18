local placeId = game.PlaceId
if placeId == 8349889591 then
    Namek = true
end
	
if Namek then
repeat wait() until game:IsLoaded()
wait(10)

local Username = game.Players.LocalPlayer.Character
local gem = game.Players.LocalPlayer["_stats"]["gem_amount"].Value

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
            name = 'gem_amount';
            value = ' :gem:  '..gem ;
        }
    };
    timestamp = string.format('%d-%d-%dT%02d:%02d:%02dZ', Time.year, Time.month, Time.day, Time.hour, Time.min, Time.sec);
};
(syn and syn.request or http_request) {
    Url = getgenv().webhook;
    Method = 'POST';
    Headers = {
        ['Content-Type'] = 'application/json';
    };
    Body = game:GetService'HttpService':JSONEncode( { content = Content; embeds = { Embed } } );
};
end
