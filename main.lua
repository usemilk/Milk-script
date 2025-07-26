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
local infJumpEnabled = false

local defaultWalkSpeed = 16
local defaultFOV = 70
local defaultJumpPower = 50

local maxAimDistance = 500
local aimSmoothness = 0.08
local predictionStrength = 1.2
local headPriority = true

local function isEnemy(player)
	return player ~= LocalPlayer and player.Team ~= LocalPlayer.Team
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
		hum.JumpPower = infJumpEnabled and 50 or defaultJumpPower
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
		highlight.FillTransparency = 0.25
		highlight.OutlineTransparency = 0
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
end)

local size = 8
local color = BrickColor.new("Really blue")

RunService.RenderStepped:Connect(function()
	if hitboxEnabled then
		for _, player in pairs(Players:GetPlayers()) do
			if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
				local hrp = player.Character.HumanoidRootPart
				hrp.Size = Vector3.new(size, size, size)
				hrp.Transparency = 0.7
				hrp.BrickColor = color
				hrp.Material = Enum.Material.Neon
				hrp.CanCollide = false
			end
		end
	else
		for _, player in pairs(Players:GetPlayers()) do
			if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
				local hrp = player.Character.HumanoidRootPart
				hrp.Size = DEFAULT_HITBOX_SIZE
				hrp.Transparency = 0
				hrp.BrickColor = BrickColor.new("Medium stone grey")
				hrp.Material = Enum.Material.Plastic
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
	local shortestDistance = maxAimDistance
	
	local localChar = LocalPlayer.Character
	local localHRP = localChar and localChar:FindFirstChild("HumanoidRootPart")
	
	if not localHRP then return nil end
	
	for _, plr in ipairs(Players:GetPlayers()) do
		if isEnemy(plr) and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
			local hum = plr.Character:FindFirstChildOfClass("Humanoid")
			if hum and hum.Health > 0 then
				local hrp = plr.Character.HumanoidRootPart
				local distance = (hrp.Position - localHRP.Position).Magnitude
				
				if distance <= maxAimDistance and distance < shortestDistance then
					local targetPart = headPriority and plr.Character:FindFirstChild("Head") or hrp
					if targetPart then
						local targetPos = targetPart.Position
						
						if hum.MoveDirection.Magnitude > 0 then
							local velocity = hrp.Velocity
							local timeToTarget = distance / 500
							targetPos = targetPos + (velocity * predictionStrength * timeToTarget)
						end
						
						shortestDistance = distance
						closestTarget = {position = targetPos, part = targetPart, player = plr}
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
		local distance = (target.position - cameraPos).Magnitude
		
		local dynamicSmoothness = aimSmoothness
		if distance < 75 then
			dynamicSmoothness = dynamicSmoothness * 1.8
		elseif distance > 150 then
			dynamicSmoothness = dynamicSmoothness * 0.6
		end
		
		local targetCFrame = CFrame.new(cameraPos, target.position)
		Camera.CFrame = Camera.CFrame:Lerp(targetCFrame, dynamicSmoothness)
	end
end)
