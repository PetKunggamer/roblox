function Chest()
    for i,v in ipairs(Workspace:GetChildren()) do
        local Common = v:FindFirstChild("Common")
        local Rare = v:FindFirstChild("Rare")
        local Epic = v:FindFirstChild("Epic")
        local Legendary = v:FindFirstChild("Legendary")
        if Common or Rare or Epic or Legendary and v.Parent then
            print(v)
        end
    end   
end

Chest()
