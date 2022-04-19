function Bypass()

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



local OldNameCall
local OldIndex

OldIndex = hookmetamethod(game, "__index", function(...)
    local Args = {...}
    local Self = Args[1]
    local Key = Args[2]
    local vaild,name = pcall(function()
        return Self
    end)
    if vaild then
        if Key == "Kick" or Key == "kick" then
            print("Block Kick(Index)")
            return function()
            end
        end
    end
    if not vaild then
        print(name)
    end
    return OldIndex(...)
end)
OldNameCall = hookmetamethod(game, "__namecall", function(Self, ...)
    local Args = {...}
    local NamecallMethod = getnamecallmethod()
    local vaild,name = pcall(function()
        return Self.name
    end)
    if vaild and name then
        if (NamecallMethod == "Kick" or NamecallMethod == "kick") or (NamecallMethod == "FireServer" and name == "PlayerStandMainHandle") or (NamecallMethod == "FireServer" and name == "SpeedJump") then                                                         
            print("Block Kick(namecall)")
            return nil
        else
            return OldNameCall(Self,...)
        end
    end

    return OldNameCall(...)
end)

end