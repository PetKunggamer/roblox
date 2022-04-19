local npc_name_to_Model = {}
for _,npcmodel in pairs(game:GetService("Workspace").Fartinglloll:GetChildren()) do
    if npcmodel:FindFirstChild("Head") then
        if npcmodel.Head:FindFirstChild("Main") then
            npc_name_to_Model[npcmodel.Head.Main.Text.Text:gsub("\n","")] = npcmodel
        end
    end
end
function customtostring(obj)
    if typeof(ModelName) == "Instance" then
        return obj.Name .. "("..obj.ClassName..")"
    else
        return tostring(obj)
    end
end
for ModelName,Model in pairs(npc_name_to_Model) do
    if typeof(ModelName) == "string" then
        Model.Name = ModelName
    else
        print("Type Not Match", typeof(ModelName), customtostring(ModelName))
    end
end

