-- Wait for the game to load
if not game:IsLoaded() then
    game.Loaded:Wait()
end

-- Wait for LocalPlayer's HumanoidRootPart
local player = game:GetService("Players").LocalPlayer
repeat
    wait()
until player.Character and player.Character:FindFirstChild("HumanoidRootPart")

print("Game and HumanoidRootPart are loaded!")

if not (game.PlaceId == 99995671928896) then return end


local function Get_Boss()
    local Boss = {"Rune Golem.", "Elder Treant.", "Dire Bear.", "Velor Yth Carven", "Mother Spider.","Golden Fairy"} -- List of boss names
    local alive = {}

    for _, v in ipairs(workspace.Alive:GetChildren()) do
        if v:IsA("Model") then
            for _, bossName in ipairs(Boss) do
                if v.Name:find(bossName) then
                    local master = v:FindFirstChild("Master")
                    local target = v:FindFirstChild("HumanoidRootPart")
                    local hum = v:FindFirstChild("Humanoid")
                    if target and hum and hum.Health > 0 and not master then -- Only add if alive
                        table.insert(alive, {Mob = v, Humanoid = hum, Root = target})
                    end
                end
            end
        end
    end

    -- Sort bosses by health (lowest HP first)
    table.sort(alive, function(a, b)
        return a.Humanoid.Health < b.Humanoid.Health
    end)

    return alive
end

local function BypassTP()
    local ColosseumEntrance = workspace.InvisibleParts.ColosseumEntrance
    local root = game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if root then
        local oldpos = root.CFrame
        fireproximityprompt(ColosseumEntrance.InteractPrompt)
        wait(.25)
        root.CFrame = oldpos
    end
end

local function TO_CFrame(CFrame)
    local root = game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    BypassTP()
    wait(.125)
    if root then
        root.CFrame = CFrame
    end
end



-- UI Setup
local player = game.Players.LocalPlayer
local CoreGui = game:GetService("CoreGui")

-- Remove previous UI if it exists
if CoreGui:FindFirstChild("Boss_Remain") then
    CoreGui.Boss_Remain:Destroy()
end

local gui = Instance.new("ScreenGui")
gui.Name = "Boss_Remain"
gui.Parent = CoreGui -- Move UI to CoreGui so it doesn't get removed

-- Main UI container
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 300, 0, 10) -- Auto height
frame.Position = UDim2.new(0, 10, 0.5, 10)
frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
frame.BackgroundTransparency = 0.3
frame.BorderSizePixel = 0
frame.Parent = gui

-- UI Corner for rounded edges
local uicorner = Instance.new("UICorner")
uicorner.CornerRadius = UDim.new(0, 10)
uicorner.Parent = frame

-- UI ListLayout for auto-spacing
local listLayout = Instance.new("UIListLayout")
listLayout.Parent = frame
listLayout.SortOrder = Enum.SortOrder.LayoutOrder
listLayout.Padding = UDim.new(0, 5)

-- Boss UI elements storage
local bossLabels = {}

-- Function to teleport player
local function teleportToBoss(target)
    if target and target.Parent then -- Check if the boss is still valid
        local character = player.Character
        if character and character:FindFirstChild("HumanoidRootPart") then
            TO_CFrame(target.CFrame)
        end
    end
end

-- Function to update UI
local function updateBossUI()
    local aliveBosses = Get_Boss()
    local aliveNames = {}

    -- Store names of currently alive bosses
    for _, boss in ipairs(aliveBosses) do
        aliveNames[boss.Mob.Name] = true
    end

    -- Remove bosses from UI if they are NOT in Get_Boss()
    for name, elements in pairs(bossLabels) do
        if not aliveNames[name] then
            elements.Row:Destroy()
            bossLabels[name] = nil
        end
    end

    -- Update or create new UI for each boss (sorted)
    for i, boss in ipairs(aliveBosses) do
        local name = boss.Mob.Name
        local health = math.floor(boss.Humanoid.Health)
        local target = boss.Root
        
        if not bossLabels[name] then
            -- Row container
            local row = Instance.new("Frame")
            row.Size = UDim2.new(1, -10, 0, 30)
            row.BackgroundTransparency = 1
            row.Parent = frame

            -- Boss Name + HP Label
            local label = Instance.new("TextLabel")
            label.Size = UDim2.new(0.7, 0, 1, 0) -- 70% of row width
            label.TextScaled = false
            label.TextSize = 16
            label.TextXAlignment = Enum.TextXAlignment.Left
            label.TextColor3 = Color3.fromRGB(255, 255, 255)
            label.Font = Enum.Font.GothamBold
            label.BackgroundTransparency = 1
            label.Parent = row

            -- TP Button
            local button = Instance.new("TextButton")
            button.Size = UDim2.new(0.25, 0, 1, 0) -- 25% of row width
            button.Position = UDim2.new(0.75, 0, 0, 0)
            button.Text = "TP"
            button.TextColor3 = Color3.fromRGB(255, 255, 255)
            button.Font = Enum.Font.GothamBold
            button.BackgroundColor3 = Color3.fromRGB(30, 150, 255)
            button.BackgroundTransparency = 0.2
            button.Parent = row

            -- UI Corner for TP Button
            local buttonCorner = Instance.new("UICorner")
            buttonCorner.CornerRadius = UDim.new(0, 5)
            buttonCorner.Parent = button

            -- TP Button click event
            button.MouseButton1Click:Connect(function()
                teleportToBoss(target)
            end)

            -- Store references
            bossLabels[name] = { Label = label, Button = button, Row = row }
        end

        -- Update text
        bossLabels[name].Label.Text = string.format("[%s] - %d HP", name, health)
    end

    -- Auto-resize frame height based on number of bosses
    frame.Size = UDim2.new(0, 300, 0, #aliveBosses * 35 + 10)
end

_G.Boss = not _G.Boss
print(_G.Boss)
while _G.Boss do
    updateBossUI()
    task.wait(0.25)
end

