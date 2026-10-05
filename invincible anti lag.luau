local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Lighting = game:GetService("Lighting")
local LocalPlayer = Players.LocalPlayer

local showPetsEvent = ReplicatedStorage:WaitForChild("rEvents"):WaitForChild("showPetsEvent")
showPetsEvent:FireServer("hidePets")

local savePlayerSizeEvent = ReplicatedStorage:WaitForChild("rEvents"):WaitForChild("savePlayerSizeEvent")
savePlayerSizeEvent:FireServer("showPopupsOption")

Lighting.ClockTime = 0
Lighting.Brightness = 0
Lighting.Ambient = Color3.fromRGB(20, 20, 30)
Lighting.OutdoorAmbient = Color3.fromRGB(20, 20, 30)

local function cleanParticles(character)
    if not character then return end
    for _, obj in ipairs(character:GetDescendants()) do
        if obj:IsA("ParticleEmitter") then
            local name = string.lower(obj.Name)
            if string.find(name, "breath") or string.find(name, "exhale") or string.find(name, "pant") or string.find(name, "sweat") or string.find(name, "air") or string.find(name, "fog") or string.find(name, "steam") then
                obj:Destroy()
            end
        end
    end
end

local function setup(character)
    cleanParticles(character)
    character.DescendantAdded:Connect(function(desc)
        if desc:IsA("ParticleEmitter") then
            local name = string.lower(desc.Name)
            if string.find(name, "breath") or string.find(name, "exhale") or string.find(name, "pant") or string.find(name, "sweat") or string.find(name, "air") or string.find(name, "fog") or string.find(name, "steam") then
                task.wait()
                if desc and desc.Parent then
                    desc:Destroy()
                end
            end
        end
    end)
end

if LocalPlayer.Character then
    setup(LocalPlayer.Character)
end
LocalPlayer.CharacterAdded:Connect(setup)
