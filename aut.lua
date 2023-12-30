function Chest()
    for i,v in ipairs(Workspace:GetChildren()) do
        if v.Name == "Common" or v.Name == "Rare" or v.Name == "Epic" or v.Name == "Legendary" and v.Parent then
            print(v)
        end
    end   
end

Chest()
