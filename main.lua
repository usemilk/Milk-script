local ui = loadstring(game:HttpGet("https://raw.githubusercontent.com/usemilk/Milk-script/main/init.lua"))()
local Players, RunService, Camera = game:GetService("Players"), game:GetService("RunService"), workspace.CurrentCamera
local UserInputService = game:GetService("UserInputService")
local LocalPlayer, Mouse = Players.LocalPlayer, Players.LocalPlayer:GetMouse()
local moduleHolder = ui.MainFrame.ScrollFrame.ModuleHolder

local espEnabled, aimbotEnabled, hitboxEnabled = false, false, false
local HITBOX_SIZE, DEFAULT_HITBOX_SIZE = Vector3.new(10, 10, 10), Vector3.new(2, 2, 1)
local highlights = {}

local fovButton = moduleHolder.FOV
local fovSliderDisplay = fovButton.SliderFrame.ValueDisplay
local fovEnabled = false

local speedButton = moduleHolder.Speed
local speedSliderDisplay = speedButton.SliderFrame.ValueDisplay
local speedEnabled = false

local infJumpButton = moduleHolder["Inf Jump"]
local infJumpSliderDisplay = infJumpButton.SliderFrame.ValueDisplay
local infJumpEnabled = false

local defaultWalkSpeed = 16
local defaultFOV = 70
local defaultJumpPower = 50

local fovRadius = 120
local aimSmoothness = 0.2

local function isEnemy(player)
	return player ~= LocalPlayer and player.Team ~= LocalPlayer.Team
end

local function expandHitbox(char)
	local hrp = char:FindFirstChild("HumanoidRootPart")
	if hrp then
		hrp.Size = HITBOX_SIZE
		hrp.CanCollide = false
	end
end

local function resetHitbox(char)
	local hrp = char:FindFirstChild("HumanoidRootPart")
	if hrp then
		hrp.Size = DEFAULT_HITBOX_SIZE
		hrp.CanCollide = false
	end
end

local function applySpeed()
	local hum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
	if hum then
		hum.WalkSpeed = speedEnabled and tonumber(speedSliderDisplay.Text) or defaultWalkSpeed
	end
end

local function applyJumpPower()
	local hum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
	if hum then
		local jp = tonumber(infJumpSliderDisplay.Text)
		if jp then
			hum.JumpPower = infJumpEnabled and jp or defaultJumpPower
		end
	end
end

LocalPlayer.CharacterAdded:Connect(function(char)
	char:WaitForChild("Humanoid")
	if speedEnabled then
		task.wait(0.5)
		applySpeed()
	end
	if infJumpEnabled then
		task.wait(0.5)
		applyJumpPower()
	end
end)

local function setupHighlightForPlayer(plr)
	local function refreshESP()
		if not espEnabled then return end
		local char = plr.Character
		if not char or not char:FindFirstChild("HumanoidRootPart") then return end

		if highlights[plr.UserId] then
			highlights[plr.UserId]:Destroy()
			highlights[plr.UserId] = nil
		end

		local highlight = Instance.new("Highlight")
		highlight.Name = "ESP_Highlight"
		highlight.FillTransparency = 0.5
		highlight.Adornee = char
		highlight.Parent = char
		highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop

		if plr.Team == LocalPlayer.Team then
			highlight.FillColor = Color3.fromRGB(0, 255, 0)
			highlight.OutlineColor = Color3.fromRGB(0, 255, 0)
		else
			highlight.FillColor = Color3.fromRGB(255, 0, 0)
			highlight.OutlineColor = Color3.fromRGB(255, 0, 0)
		end

		highlight.FillTransparency = 0.25
		highlight.OutlineTransparency = 0

		highlights[plr.UserId] = highlight

		local hum = char:FindFirstChildOfClass("Humanoid")
		if hum then
			hum.Died:Once(function()
				if highlights[plr.UserId] then
					highlights[plr.UserId]:Destroy()
					highlights[plr.UserId] = nil
				end
			end)
		end
	end

	if plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
		refreshESP()
	end

	plr.CharacterAdded:Connect(function(char)
		char:WaitForChild("HumanoidRootPart", 3)
		refreshESP()
	end)
end

local function handleCharacter(plr)
	if plr == LocalPlayer then return end
	plr.CharacterAdded:Connect(function(char)
		char:WaitForChild("HumanoidRootPart")
		if hitboxEnabled then
			task.wait(0.2)
			expandHitbox(char)
		end
		setupHighlightForPlayer(plr)
	end)
end

for _, plr in ipairs(Players:GetPlayers()) do handleCharacter(plr) end
Players.PlayerAdded:Connect(handleCharacter)
Players.PlayerRemoving:Connect(function(plr)
	if highlights[plr.UserId] then
		highlights[plr.UserId]:Destroy()
		highlights[plr.UserId] = nil
	end
end)

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
	if espEnabled then
		for _, plr in ipairs(Players:GetPlayers()) do
			setupHighlightForPlayer(plr)
		end
	else
		for _, h in pairs(highlights) do
			if h and h:IsA("Highlight") then h:Destroy() end
		end
		highlights = {}
	end
end)

moduleHolder["Aimbot"].Activated:Connect(function()
	aimbotEnabled = not aimbotEnabled
end)

fovButton.Activated:Connect(function()
	fovEnabled = not fovEnabled
	local val = tonumber(fovSliderDisplay.Text)
	Camera.FieldOfView = fovEnabled and val or defaultFOV
end)

fovSliderDisplay:GetPropertyChangedSignal("Text"):Connect(function()
	if fovEnabled then
		local val = tonumber(fovSliderDisplay.Text)
		if val then Camera.FieldOfView = val end
	end
end)

speedButton.Activated:Connect(function()
	speedEnabled = not speedEnabled
	applySpeed()
end)

speedSliderDisplay:GetPropertyChangedSignal("Text"):Connect(function()
	if speedEnabled then
		applySpeed()
	end
end)

infJumpButton.Activated:Connect(function()
	infJumpEnabled = not infJumpEnabled
	applyJumpPower()
end)

infJumpSliderDisplay:GetPropertyChangedSignal("Text"):Connect(function()
	if infJumpEnabled then
		applyJumpPower()
	end
end)

UserInputService.JumpRequest:Connect(function()
	if infJumpEnabled then
		local char = LocalPlayer.Character
		if char then
			local hum = char:FindFirstChildOfClass("Humanoid")
			if hum then hum:ChangeState(Enum.HumanoidStateType.Jumping) end
		end
	end
end)

local function getClosestTarget()
	local closestTarget = nil
	local shortestDist = fovRadius

	for _, plr in ipairs(Players:GetPlayers()) do
		if isEnemy(plr) and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
			local hum = plr.Character:FindFirstChildOfClass("Humanoid")
			if hum and hum.Health > 0 then
				local hrp = plr.Character:FindFirstChild("HumanoidRootPart")
				local screenPos, onScreen = Camera:WorldToViewportPoint(hrp.Position)

				local direction = (hrp.Position - Camera.CFrame.Position).Unit
				local facing = Camera.CFrame.LookVector:Dot(direction) > 0.5

				if onScreen and facing then
					local mouseDist = (Vector2.new(Mouse.X, Mouse.Y) - Vector2.new(screenPos.X, screenPos.Y)).Magnitude
					if mouseDist < shortestDist then
						shortestDist = mouseDist
						closestTarget = hrp
					end
				end
			end
		end
	end

	return closestTarget
end

RunService.RenderStepped:Connect(function()
	if not aimbotEnabled then return end

	local target = getClosestTarget()
	if target then
		local cameraPos = Camera.CFrame.Position
		local newCFrame = CFrame.new(cameraPos, target.Position)
		Camera.CFrame = Camera.CFrame:Lerp(newCFrame, aimSmoothness)
	end
end)
