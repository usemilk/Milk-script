local ui = loadstring(game:HttpGet("https://raw.githubusercontent.com/joshy-5/Milk-script/refs/heads/main/ui-init.lua"))()
local Players, RunService, Camera = game:GetService("Players"), game:GetService("RunService"), workspace.CurrentCamera
local Debris = game:GetService("Debris")
local LocalPlayer, Mouse = Players.LocalPlayer, Players.LocalPlayer:GetMouse()
local moduleHolder = ui.MainFrame.ScrollFrame.ModuleHolder

local espEnabled, aimbotEnabled, hitboxEnabled = false, false, false
local HITBOX_SIZE, DEFAULT_HITBOX_SIZE = Vector3.new(10, 10, 10), Vector3.new(2, 2, 1)
local espBoxes = {}

local function isEnemy(plr)
	return plr ~= LocalPlayer and (not plr.Team or not LocalPlayer.Team or plr.Team ~= LocalPlayer.Team)
end

local function expandHitbox(char)
	local hrp = char:FindFirstChild("HumanoidRootPart")
	if hrp then
		hrp.Size = HITBOX_SIZE
		hrp.Transparency = 0.5
		hrp.CanCollide = false
	end
end

local function resetHitbox(char)
	local hrp = char:FindFirstChild("HumanoidRootPart")
	if hrp then
		hrp.Size = DEFAULT_HITBOX_SIZE
		hrp.Transparency = 1
		hrp.CanCollide = false
	end
end

local function handleCharacter(plr)
	if plr == LocalPlayer then return end
	plr.CharacterAdded:Connect(function(char)
		char:WaitForChild("HumanoidRootPart")
		if hitboxEnabled then
			task.wait(0.2)
			expandHitbox(char)
		end
	end)
end

for _, plr in ipairs(Players:GetPlayers()) do handleCharacter(plr) end
Players.PlayerAdded:Connect(handleCharacter)

moduleHolder["Hitbox Expander"].Activated:Connect(function()
	hitboxEnabled = not hitboxEnabled
	for _, plr in ipairs(Players:GetPlayers()) do
		if plr ~= LocalPlayer and plr.Character then
			if hitboxEnabled then
				expandHitbox(plr.Character)
			else
				resetHitbox(plr.Character)
			end
		end
	end
end)

moduleHolder["ESP"].Activated:Connect(function()
	espEnabled = not espEnabled
	if not espEnabled then
		for _, part in pairs(espBoxes) do
			if part and part:IsA("Part") then part:Destroy() end
		end
		espBoxes = {}
	end
end)

moduleHolder["Aimbot"].Activated:Connect(function()
	aimbotEnabled = not aimbotEnabled
end)

local function updateEspBoxes()
	for _, plr in pairs(Players:GetPlayers()) do
		if plr ~= LocalPlayer and isEnemy(plr) and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
			local hrp = plr.Character.HumanoidRootPart
			local box = espBoxes[plr.UserId]

				box = Instance.new("Part")
				box.Anchored = true
				box.CanCollide = false
				box.CastShadow = false
				box.Transparency = 0.5
				box.Color = Color3.fromRGB(255, 0, 0)
				box.Material = Enum.Material.Neon
				box.Name = "ESPBox"
				box.LocalTransparencyModifier = 0
				box.Parent = workspace
				espBoxes[plr.UserId] = box
				Debris:AddItem(box , 0.05)

				local hum = plr.Character:FindFirstChildOfClass("Humanoid")
				if hum then
					hum.Died:Connect(function()
						if espBoxes[plr.UserId] then
							espBoxes[plr.UserId]:Destroy()
							espBoxes[plr.UserId] = nil
						end
					end)
			end

			box.Size = hrp.Size + Vector3.new(0.2, 0.2, 0.2)
			box.CFrame = hrp.CFrame
			box.LocalTransparencyModifier = 0
		else
			if espBoxes[plr.UserId] then
				espBoxes[plr.UserId]:Destroy()
				espBoxes[plr.UserId] = nil
			end
		end
	end
end

RunService.RenderStepped:Connect(function()
	if espEnabled then
		updateEspBoxes()
	end

	if aimbotEnabled then
		local closest, shortestDist = nil, math.huge
		for _, plr in pairs(Players:GetPlayers()) do
			if isEnemy(plr) and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
				local hrp = plr.Character.HumanoidRootPart
				local screenPos, onScreen = Camera:WorldToViewportPoint(hrp.Position)
				if onScreen then
					local distance = (Vector2.new(Mouse.X, Mouse.Y) - Vector2.new(screenPos.X, screenPos.Y)).Magnitude
					if distance < shortestDist then
						closest, shortestDist = hrp, distance
					end
				end
			end
		end

		if closest then
			Camera.CFrame = Camera.CFrame:Lerp(CFrame.new(Camera.CFrame.Position, closest.Position), 0.2)
		end
	end
end)
