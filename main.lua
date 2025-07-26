local ui = loadstring(game:HttpGet("https://raw.githubusercontent.com/usemilk/Milk-script/main/init.lua"))()
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Camera = workspace.CurrentCamera

local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()
local Modules = ui.MainFrame.ScrollFrame.ModuleHolder

local defaultWalkSpeed, defaultFOV, defaultJumpPower = 16, 70, 50
local fovRadius, aimSmoothness = 120, 0.2
local hitboxSize, normalHitboxSize = Vector3.new(50, 50, 50), Vector3.new(2, 2, 1)

local espOn, aimbotOn, hitboxOn, fovOn, speedOn, jumpOn = false, false, false, false, false, false
local highlights = {}

local fovInput = Modules.FOV.SliderFrame.ValueDisplay
local speedInput = Modules.Speed.SliderFrame.ValueDisplay
local jumpInput = Modules["Inf Jump"].SliderFrame.ValueDisplay

local function applyMovementMods()
	local character = LocalPlayer.Character
	if not character then return end
	local humanoid = character:FindFirstChildOfClass("Humanoid")
	if not humanoid then return end
	humanoid.WalkSpeed = speedOn and tonumber(speedInput.Text) or defaultWalkSpeed
	humanoid.JumpPower = jumpOn and tonumber(jumpInput.Text) or defaultJumpPower
end

LocalPlayer.CharacterAdded:Connect(function()
	task.wait(0.5)
	applyMovementMods()
end)

local function trackPlayer(plr)
	local function applyESP()
		if not espOn then return end
		local char = plr.Character
		if not char or not char:FindFirstChild("HumanoidRootPart") then return end
		if highlights[plr.UserId] then
			highlights[plr.UserId]:Destroy()
		end
		local h = Instance.new("Highlight")
		h.Adornee = char
		h.FillTransparency = 0.25
		h.OutlineTransparency = 0
		h.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
		h.FillColor = plr.Team == LocalPlayer.Team and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 0, 0)
		h.OutlineColor = h.FillColor
		h.Parent = char
		highlights[plr.UserId] = h
	end

	if plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
		applyESP()
	end

	plr.CharacterAdded:Connect(function()
		task.wait(0.1)
		applyESP()
	end)

	plr.CharacterRemoving:Connect(function()
		if highlights[plr.UserId] then
			highlights[plr.UserId]:Destroy()
			highlights[plr.UserId] = nil
		end
	end)
end

for _, plr in ipairs(Players:GetPlayers()) do
	if plr ~= LocalPlayer then
		trackPlayer(plr)
	end
end

Players.PlayerAdded:Connect(function(plr)
	if plr ~= LocalPlayer then
		trackPlayer(plr)
	end
end)

Modules["ESP"].Activated:Connect(function()
	espOn = not espOn
	if espOn then
		for _, plr in ipairs(Players:GetPlayers()) do
			if plr ~= LocalPlayer then
				trackPlayer(plr)
			end
		end
	else
		for _, v in pairs(highlights) do
			if v then v:Destroy() end
		end
		highlights = {}
	end
end)

Modules["Hitbox Expander"].Activated:Connect(function()
	hitboxOn = not hitboxOn
end)

Modules["Aimbot"].Activated:Connect(function()
	aimbotOn = not aimbotOn
end)

Modules["FOV"].Activated:Connect(function()
	fovOn = not fovOn
	local val = tonumber(fovInput.Text)
	Camera.FieldOfView = fovOn and val or defaultFOV
end)

fovInput:GetPropertyChangedSignal("Text"):Connect(function()
	if fovOn then
		local val = tonumber(fovInput.Text)
		if val then Camera.FieldOfView = val end
	end
end)

Modules["Speed"].Activated:Connect(function()
	speedOn = not speedOn
	applyMovementMods()
end)

speedInput:GetPropertyChangedSignal("Text"):Connect(function()
	if speedOn then applyMovementMods() end
end)

Modules["Inf Jump"].Activated:Connect(function()
	jumpOn = not jumpOn
	applyMovementMods()
end)

jumpInput:GetPropertyChangedSignal("Text"):Connect(function()
	if jumpOn then applyMovementMods() end
end)

UserInputService.JumpRequest:Connect(function()
	if not jumpOn then return end
	local char = LocalPlayer.Character
	local hum = char and char:FindFirstChildOfClass("Humanoid")
	if hum then hum:ChangeState(Enum.HumanoidStateType.Jumping) end
end)

RunService.RenderStepped:Connect(function()
	if not hitboxOn then
		for _, p in ipairs(Players:GetPlayers()) do
			if p ~= LocalPlayer and p.Character then
				local hrp = p.Character:FindFirstChild("HumanoidRootPart")
				if hrp then
					hrp.Size = normalHitboxSize
					hrp.Transparency = 0
					hrp.BrickColor = BrickColor.new("Medium stone grey")
					hrp.Material = Enum.Material.Plastic
					local s = hrp:FindFirstChild("DimOutline")
					if s then s:Destroy() end
				end
			end
		end
		return
	end

	for _, p in ipairs(Players:GetPlayers()) do
		if p ~= LocalPlayer and p.Character then
			local hrp = p.Character:FindFirstChild("HumanoidRootPart")
			if hrp then
				hrp.Size = hitboxSize
				hrp.Transparency = 0.6
				hrp.Material = Enum.Material.Neon
				hrp.BrickColor = BrickColor.new("Really blue")
				hrp.CanCollide = false
				if not hrp:FindFirstChild("DimOutline") then
					local outline = Instance.new("SelectionBox")
					outline.Name = "DimOutline"
					outline.Adornee = hrp
					outline.LineThickness = 0.04
					outline.Color3 = Color3.fromRGB(100, 100, 255)
					outline.Transparency = 0.7
					outline.Parent = hrp
				end
			end
		end
	end
end)

local function getClosest()
	local shortest, target = fovRadius, nil
	local origin = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
	if not origin then return nil end
	for _, p in ipairs(Players:GetPlayers()) do
		if p ~= LocalPlayer and p.Team ~= LocalPlayer.Team and p.Character then
			local hrp = p.Character:FindFirstChild("HumanoidRootPart")
			local hum = p.Character:FindFirstChildOfClass("Humanoid")
			if hrp and hum and hum.Health > 0 then
				local dist = (hrp.Position - origin.Position).Magnitude
				local yDiff = math.abs(hrp.Position.Y - origin.Position.Y)
				if dist <= 150 and yDiff <= 40 then
					local pos, onscreen = Camera:WorldToViewportPoint(hrp.Position)
					local screenDiff = (Vector2.new(Mouse.X, Mouse.Y) - Vector2.new(pos.X, pos.Y)).Magnitude
					if onscreen and screenDiff < shortest then
						shortest = screenDiff
						target = hrp
					end
				end
			end
		end
	end
	return target
end

RunService.RenderStepped:Connect(function()
	if not aimbotOn then return end
	local target = getClosest()
	if target then
		local cpos = Camera.CFrame.Position
		local dir = CFrame.new(cpos, target.Position)
		Camera.CFrame = Camera.CFrame:Lerp(dir, aimSmoothness)
	end
end)
