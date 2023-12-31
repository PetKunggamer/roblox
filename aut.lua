print("Version fireproxmrmpt")
function Chest()
    for i,v in ipairs(Workspace:GetChildren()) do
        if v.Name == "Common" or v.Name == "Rare" or v.Name == "Epic" or v.Name == "Legendary" and v.Parent then
            local RP = v:FindFirstChild("RootPart")
            if RP then
                local Proximity = RP:FindFirstChild("ProximityAttachment")
                if Proximity then
                    local Interact = Proximity:FindFirstChild("Interact")
                    if Interact then
                        fireproximityprompt(Interact)
                    end
                end
            end
        end
    end   
end

Chest()
