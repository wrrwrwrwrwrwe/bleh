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
