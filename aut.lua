print("Version : 1")

function Chest()
    for i,v in ipairs(Workspace:GetChildren()) do
        if v.Name == "Common" or v.Name == "Rare" or v.Name == "Epic" or v.Name == "Legendary" and v.Parent then
            local RP = v:FindFirstChild("RootPart")
            if RP then
                local Proximity = RP:FindFirstChild("ProximityAttachment")
                if Proximity then
                    local Interact = Proximity:FindFirstChild("Interact")
                    if Interact then
                        fireproximityprompt(Interact, 1 , true)
                    end
                end
            end
        end
    end   
end

Chest()

--[[
local Mob = game:GetService("Workspace").Living

for i,v in pairs(Mob:GetChildren()) do
    print(v)
end
]]--
