local ui = loadstring(game:HttpGet("https://raw.githubusercontent.com/usemilk/Milk-script/main/init.lua"))()
local Players, RunService, Camera = game:GetService("Players"), game:GetService("RunService"), workspace.CurrentCamera
local UserInputService = game:GetService("UserInputService")
local LocalPlayer, Mouse = Players.LocalPlayer, Players.LocalPlayer:GetMouse()
local moduleHolder = ui.MainFrame.ScrollFrame.ModuleHolder

local espEnabled, aimbotEnabled, hitboxEnabled, triggerbotEnabled = false, false, false, false
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

local triggerbotButton = moduleHolder["Trigger Bot"]

local defaultWalkSpeed = 16
local defaultFOV = 70
local defaultJumpPower = 50

local fovRadius = 180
local aimSmoothness = 0.12
local predictionStrength = 0.8
local headPriority = true

local function isEnemy(player)
	return player ~= LocalPlayer and player.Team ~= LocalPlayer.Team and (player.Team.Name == "Team1" or player.Team.Name == "Team2")
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

triggerbotButton.Activated:Connect(function()
	triggerbotEnabled = not triggerbotEnabled
end)

local function canKillTarget(target)
	if not target or not target.Character then return false end
	local humanoid = target.Character:FindFirstChildOfClass("Humanoid")
	if not humanoid then return false end
	
	local tool = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Tool")
	if not tool then return false end
	
	local damage = 34
	if tool.Name:lower():find("head") then
		damage = 68
	end
	
	return humanoid.Health <= damage
end

local function getTargetUnderCrosshair()
	local camera = workspace.CurrentCamera
	local screenCenter = Vector2.new(camera.ViewportSize.X / 2, camera.ViewportSize.Y / 2)
	local ray = camera:ScreenPointToRay(screenCenter.X, screenCenter.Y)
	
	local raycastParams = RaycastParams.new()
	raycastParams.FilterType = Enum.RaycastFilterType.Blacklist
	raycastParams.FilterDescendantsInstances = {LocalPlayer.Character}
	
	local result = workspace:Raycast(ray.Origin, ray.Direction * 1000, raycastParams)
	
	if result and result.Instance then
		local character = result.Instance.Parent
		local player = Players:GetPlayerFromCharacter(character)
		if player and isEnemy(player) then
			return player
		end
	end
	
	return nil
end

RunService.Heartbeat:Connect(function()
	if not triggerbotEnabled then return end
	
	local target = getTargetUnderCrosshair()
	if target and canKillTarget(target) then
		local tool = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Tool")
		if tool and tool:FindFirstChild("ShootGun") then
			tool.ShootGun:FireServer()
		else
			mouse1click()
		end
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
	local maxDistance = 200
	local maxYDifference = 50
	local bestScore = math.huge

	local localChar = LocalPlayer.Character
	local localHRP = localChar and localChar:FindFirstChild("HumanoidRootPart")

	if not localHRP then return nil end

	for _, plr in ipairs(Players:GetPlayers()) do
		if isEnemy(plr) and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
			local hum = plr.Character:FindFirstChildOfClass("Humanoid")
			if hum and hum.Health > 0 then
				local hrp = plr.Character.HumanoidRootPart
				local distance = (hrp.Position - localHRP.Position).Magnitude
				local yDifference = math.abs(hrp.Position.Y - localHRP.Position.Y)

				if distance <= maxDistance and yDifference <= maxYDifference then
					local targetPos = hrp.Position
					
					if headPriority and plr.Character:FindFirstChild("Head") then
						targetPos = plr.Character.Head.Position
					end
					
					if hum.MoveDirection.Magnitude > 0 then
						local velocity = hrp.Velocity
						targetPos = targetPos + (velocity * predictionStrength * 0.1)
					end

					local screenPos, onScreen = Camera:WorldToViewportPoint(targetPos)
					local direction = (targetPos - Camera.CFrame.Position).Unit
					local facing = Camera.CFrame.LookVector:Dot(direction) > 0.3

					if onScreen and facing then
						local mouseDist = (Vector2.new(Mouse.X, Mouse.Y) - Vector2.new(screenPos.X, screenPos.Y)).Magnitude
						local score = mouseDist + (distance * 0.1)
						
						if score < bestScore then
							bestScore = score
							closestTarget = {position = targetPos, part = headPriority and plr.Character:FindFirstChild("Head") or hrp}
						end
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
		local smoothFactor = aimSmoothness
		
		local distance = (target.position - cameraPos).Magnitude
		if distance < 50 then
			smoothFactor = smoothFactor * 1.4
		elseif distance > 120 then
			smoothFactor = smoothFactor * 0.7
		end
		
		local newCFrame = CFrame.new(cameraPos, target.position)
		Camera.CFrame = Camera.CFrame:Lerp(newCFrame, smoothFactor)
	end
end)
