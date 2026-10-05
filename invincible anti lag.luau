local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Lighting = game:GetService("Lighting")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local showPetsEvent = ReplicatedStorage:WaitForChild("rEvents"):WaitForChild("showPetsEvent")
showPetsEvent:FireServer("hidePets")
local savePlayerSizeEvent = ReplicatedStorage:WaitForChild("rEvents"):WaitForChild("savePlayerSizeEvent")
savePlayerSizeEvent:FireServer("showPopupsOption")

Lighting.ClockTime = 0
Lighting.Brightness = 50

local function cleanVFX(character)
	if not character then return end
	for _, obj in ipairs(character:GetDescendants()) do
		if obj:IsA("ParticleEmitter") or obj:IsA("Beam") or obj:IsA("Trail") or obj:IsA("Fire") or obj:IsA("Smoke") or obj:IsA("Sparkles") or obj:IsA("PointLight") or obj:IsA("SpotLight") or obj:IsA("SurfaceLight") then
			obj:Destroy()
		end
	end
end

local function setup(character)
	cleanVFX(character)

	character.DescendantAdded:Connect(function(desc)
		if desc:IsA("ParticleEmitter") or desc:IsA("Beam") or desc:IsA("Trail") or desc:IsA("Fire") or desc:IsA("Smoke") or desc:IsA("Sparkles") or desc:IsA("PointLight") or desc:IsA("SpotLight") or desc:IsA("SurfaceLight") then
			task.wait()
			if desc and desc.Parent then
				desc:Destroy()
			end
		end
	end)
end

if LocalPlayer.Character then
	setup(LocalPlayer.Character)
end

LocalPlayer.CharacterAdded:Connect(setup)

RunService.Heartbeat:Connect(function()
	local character = LocalPlayer.Character
	if character then
		cleanVFX(character)
	end
end)
