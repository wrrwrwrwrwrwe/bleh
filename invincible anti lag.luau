local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Lighting = game:GetService("Lighting")
local LocalPlayer = Players.LocalPlayer
local showPetsEvent = ReplicatedStorage:WaitForChild("rEvents"):WaitForChild("showPetsEvent")
showPetsEvent:FireServer("hidePets")
local savePlayerSizeEvent = ReplicatedStorage:WaitForChild("rEvents"):WaitForChild("savePlayerSizeEvent")
savePlayerSizeEvent:FireServer("showPopupsOption")
Lighting.ClockTime = 0
Lighting.Brightness = 50
local BAD_PARTICLE_KEYWORDS = {
	"breath", "exhale", "pant", "sweat", "air", "fog", "steam"
}
local function isBadParticle(name)
	name = string.lower(name)
	for _, keyword in ipairs(BAD_PARTICLE_KEYWORDS) do
		if string.find(name, keyword, 1, true) then
			return true
		end
	end
	return false
end
local function cleanParticles(character)
	if not character then return end
	for _, obj in ipairs(character:GetDescendants()) do
		if obj:IsA("ParticleEmitter") and isBadParticle(obj.Name) then
			obj:Destroy()
		end
	end
end
local function setup(character)
	cleanParticles(character)
	character.DescendantAdded:Connect(function(desc)
		if desc:IsA("ParticleEmitter") and isBadParticle(desc.Name) then
			task.defer(function()
				if desc and desc.Parent then
					desc:Destroy()
				end
			end)
		end
	end)
end
if LocalPlayer.Character then
	setup(LocalPlayer.Character)
end
LocalPlayer.CharacterAdded:Connect(setup)

local function removeVFX(instance)
	for _, descendant in ipairs(instance:GetDescendants()) do
		if descendant:IsA("ParticleEmitter")
			or descendant:IsA("Beam")
			or descendant:IsA("Trail")
			or descendant:IsA("Fire")
			or descendant:IsA("Smoke")
			or descendant:IsA("Sparkles")
			or descendant:IsA("Explosion")
			or descendant:IsA("PointLight")
			or descendant:IsA("SpotLight")
			or descendant:IsA("SurfaceLight")
		then
			descendant:Destroy()
		end
	end
end

removeVFX(workspace)
removeVFX(game:GetService("Lighting"))
removeVFX(game:GetService("ReplicatedStorage"))
removeVFX(game:GetService("StarterGui"))
removeVFX(game:GetService("StarterPack"))
removeVFX(game:GetService("StarterPlayer"))

workspace.DescendantAdded:Connect(function(descendant)
	if descendant:IsA("ParticleEmitter")
		or descendant:IsA("Beam")
		or descendant:IsA("Trail")
		or descendant:IsA("Fire")
		or descendant:IsA("Smoke")
		or descendant:IsA("Sparkles")
		or descendant:IsA("Explosion")
		or descendant:IsA("PointLight")
		or descendant:IsA("SpotLight")
		or descendant:IsA("SurfaceLight")
	then
		descendant:Destroy()
	end
end)
