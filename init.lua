local _StarterGui = game:GetService("StarterGui")
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")

local isMobile = UIS.TouchEnabled and not UIS.KeyboardEnabled
local scaleFactor = isMobile and 0.6 or 1
local mainFrameWidth = isMobile and 260 or 400
local mainFrameHeight = isMobile and 390 or 580
local buttonWidth = isMobile and 220 or 350

local exists = Players.LocalPlayer.PlayerGui:FindFirstChild("MilkGUI")
if exists then
    exists:Destroy()
end

local gui = Instance.new("ScreenGui")
gui.Name = "MilkGUI"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.Parent = Players.LocalPlayer:WaitForChild("PlayerGui")

local toggleButton = Instance.new("ImageButton")
toggleButton.Name = "ToggleButton"
toggleButton.Size = UDim2.new(0, 60 * scaleFactor, 0, 60 * scaleFactor)
toggleButton.Position = UDim2.new(1, -80 * scaleFactor, 0.5, -30 * scaleFactor)
toggleButton.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
toggleButton.BackgroundTransparency = 0.1
toggleButton.BorderSizePixel = 0
toggleButton.Image = "rbxassetid://118502805264275"
toggleButton.ScaleType = Enum.ScaleType.Fit
toggleButton.Parent = gui

local toggleCorner = Instance.new("UICorner", toggleButton)
toggleCorner.CornerRadius = UDim.new(1, 0)

local toggleStroke = Instance.new("UIStroke", toggleButton)
toggleStroke.Color = Color3.fromRGB(100, 150, 255)
toggleStroke.Thickness = 3 * scaleFactor
toggleStroke.Transparency = 0.3

local toggleGlow = Instance.new("ImageLabel")
toggleGlow.Name = "ToggleGlow"
toggleGlow.Image = "rbxassetid://118502805264275"
toggleGlow.Size = UDim2.new(0, 80 * scaleFactor, 0, 80 * scaleFactor)
toggleGlow.Position = UDim2.new(0.5, -40 * scaleFactor, 0.5, -40 * scaleFactor)
toggleGlow.BackgroundTransparency = 1
toggleGlow.ImageTransparency = 0.7
toggleGlow.ImageColor3 = Color3.fromRGB(140, 200, 255)
toggleGlow.ScaleType = Enum.ScaleType.Fit
toggleGlow.ZIndex = -1
toggleGlow.Parent = toggleButton

local toggleGlowCorner = Instance.new("UICorner", toggleGlow)
toggleGlowCorner.CornerRadius = UDim.new(1, 0)

local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, mainFrameWidth, 0, mainFrameHeight) 
mainFrame.Position = UDim2.new(0.5, -mainFrameWidth/2, 0.5, -mainFrameHeight/2) 
mainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
mainFrame.BackgroundTransparency = 0.05
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = false
mainFrame.Visible = true
mainFrame.ClipsDescendants = true
mainFrame.Parent = gui

local mainCorner = Instance.new("UICorner", mainFrame)
mainCorner.CornerRadius = UDim.new(0, 20 * scaleFactor)

local mainStroke = Instance.new("UIStroke", mainFrame)
mainStroke.Color = Color3.fromRGB(100, 150, 255)
mainStroke.Thickness = 2 * scaleFactor
mainStroke.Transparency = 0.4

local gradient = Instance.new("Frame")
gradient.Name = "GradientOverlay"
gradient.Size = UDim2.new(1, 0, 1, 0)
gradient.BackgroundTransparency = 0.1
gradient.BorderSizePixel = 0
gradient.Parent = mainFrame

local gradientCorner = Instance.new("UICorner", gradient)
gradientCorner.CornerRadius = UDim.new(0, 20 * scaleFactor)

local gradientColor = Instance.new("UIGradient", gradient)
gradientColor.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(35, 35, 50)),
    ColorSequenceKeypoint.new(0.3, Color3.fromRGB(20, 20, 35)),
    ColorSequenceKeypoint.new(0.7, Color3.fromRGB(15, 15, 25)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(10, 10, 18))
})
gradientColor.Rotation = 145

local shadow = Instance.new("ImageLabel")
shadow.Name = "Shadow"
shadow.Image = "rbxassetid://1316045217"
shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
shadow.ImageTransparency = 0.3
shadow.ScaleType = Enum.ScaleType.Slice
shadow.SliceCenter = Rect.new(10, 10, 118, 118)
shadow.Size = UDim2.new(1, 60 * scaleFactor, 1, 60 * scaleFactor)
shadow.Position = UDim2.new(0, -30 * scaleFactor, 0, -30 * scaleFactor)
shadow.BackgroundTransparency = 1
shadow.ZIndex = -1
shadow.Parent = mainFrame

local titleFrame = Instance.new("Frame")
titleFrame.Name = "TitleFrame"
titleFrame.Size = UDim2.new(1, 0, 0, 80 * scaleFactor)
titleFrame.BackgroundTransparency = 1
titleFrame.ZIndex = 10
titleFrame.Parent = mainFrame

local titleContainer = Instance.new("Frame")
titleContainer.Name = "TitleContainer"
titleContainer.Size = UDim2.new(0, 180 * scaleFactor, 0, 50 * scaleFactor)
titleContainer.Position = UDim2.new(0.5, -90 * scaleFactor, 0.5, -25 * scaleFactor)
titleContainer.BackgroundTransparency = 1
titleContainer.Parent = titleFrame

local logo = Instance.new("ImageLabel")
logo.Name = "Logo"
logo.Image = "rbxassetid://118502805264275"
logo.Size = UDim2.new(0, 40 * scaleFactor, 0, 40 * scaleFactor)
logo.Position = UDim2.new(0, 0, 0.5, -20 * scaleFactor)
logo.BackgroundTransparency = 1
logo.ScaleType = Enum.ScaleType.Fit
logo.Parent = titleContainer

local logoGlow = Instance.new("ImageLabel")
logoGlow.Name = "LogoGlow"
logoGlow.Image = "rbxassetid://118502805264275"
logoGlow.Size = UDim2.new(0, 50 * scaleFactor, 0, 50 * scaleFactor)
logoGlow.Position = UDim2.new(0, -5 * scaleFactor, 0.5, -25 * scaleFactor)
logoGlow.BackgroundTransparency = 1
logoGlow.ImageTransparency = 0.7
logoGlow.ImageColor3 = Color3.fromRGB(140, 200, 255)
logoGlow.ScaleType = Enum.ScaleType.Fit
logoGlow.ZIndex = -1
logoGlow.Parent = titleContainer

local title = Instance.new("TextLabel")
title.Name = "Title"
title.Text = "Milk"
title.Size = UDim2.new(0, 120 * scaleFactor, 1, 0)
title.Position = UDim2.new(0, 60 * scaleFactor, 0, 0)
title.BackgroundTransparency = 1
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 28 * scaleFactor
title.TextStrokeTransparency = 0.6
title.TextStrokeColor3 = Color3.fromRGB(140, 200, 255)
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = titleContainer

local subtitle = Instance.new("TextLabel")
subtitle.Name = "Subtitle"
subtitle.Text = "Premium Gaming Experience • v2.0"
subtitle.Size = UDim2.new(1, 0, 0, 20 * scaleFactor)
subtitle.Position = UDim2.new(0, 0, 0, 80 * scaleFactor)
subtitle.BackgroundTransparency = 1
subtitle.TextColor3 = Color3.fromRGB(180, 200, 240)
subtitle.Font = Enum.Font.Gotham
subtitle.TextSize = 12 * scaleFactor
subtitle.ZIndex = 10
subtitle.Parent = mainFrame

local divider = Instance.new("Frame")
divider.Name = "Divider"
divider.Size = UDim2.new(0.85, 0, 0, 2 * scaleFactor)
divider.Position = UDim2.new(0.075, 0, 0, 105 * scaleFactor)
divider.BackgroundColor3 = Color3.fromRGB(100, 150, 255)
divider.BackgroundTransparency = 0.5
divider.BorderSizePixel = 0
divider.ZIndex = 10
divider.Parent = mainFrame

local dividerGradient = Instance.new("UIGradient", divider)
dividerGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(100, 150, 255)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(140, 200, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(100, 150, 255))
})

local scrollPaddingTop = 120 * scaleFactor
local scrollPaddingBottom = 20 * scaleFactor
local scrollPaddingSides = 20 * scaleFactor

local scrollFrame = Instance.new("ScrollingFrame")
scrollFrame.Name = "ScrollFrame"
scrollFrame.Position = UDim2.new(0, scrollPaddingSides, 0, scrollPaddingTop)
scrollFrame.Size = UDim2.new(1, -scrollPaddingSides * 2, 1, -scrollPaddingTop - scrollPaddingBottom)
scrollFrame.BackgroundTransparency = 1
scrollFrame.ScrollBarThickness = 8 * scaleFactor
scrollFrame.ScrollBarImageColor3 = Color3.fromRGB(100, 150, 255)
scrollFrame.ScrollBarImageTransparency = 0.3
scrollFrame.BorderSizePixel = 0
scrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
scrollFrame.ClipsDescendants = true
scrollFrame.ZIndex = 5
scrollFrame.Parent = mainFrame

local scrollCorner = Instance.new("UICorner", scrollFrame)
scrollCorner.CornerRadius = UDim.new(0, 10 * scaleFactor)

local moduleHolder = Instance.new("Frame")
moduleHolder.Name = "ModuleHolder"
moduleHolder.Position = UDim2.new(0, 0, 0, 5 * scaleFactor) 
moduleHolder.Size = UDim2.new(1, -20 * scaleFactor, 1, 0) 
moduleHolder.BackgroundTransparency = 1
moduleHolder.Parent = scrollFrame

local listLayout = Instance.new("UIListLayout")
listLayout.Padding = UDim.new(0, 12 * scaleFactor)
listLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
listLayout.SortOrder = Enum.SortOrder.LayoutOrder
listLayout.Parent = moduleHolder

listLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    scrollFrame.CanvasSize = UDim2.new(0, 0, 0, listLayout.AbsoluteContentSize.Y + 15 * scaleFactor)
end)

local function createSlider(parent, minValue, maxValue, defaultValue, color, title)
    local sliderFrame = Instance.new("Frame")
    sliderFrame.Name = "SliderFrame"
    sliderFrame.Size = UDim2.new(1, 0, 0, 60 * scaleFactor)
    sliderFrame.Position = UDim2.new(0, 0, 0, 40 * scaleFactor) 
    sliderFrame.BackgroundTransparency = 1
    sliderFrame.Visible = false
    sliderFrame.ClipsDescendants = true 
    sliderFrame.ZIndex = 5
    sliderFrame.Parent = parent

    local sliderTitle = Instance.new("TextLabel")
    sliderTitle.Name = "SliderTitle"
    sliderTitle.Size = UDim2.new(1, -40 * scaleFactor, 0, 18 * scaleFactor)
    sliderTitle.Position = UDim2.new(0, 20 * scaleFactor, 0, 2 * scaleFactor)
    sliderTitle.BackgroundTransparency = 1
    sliderTitle.Text = title or "Value"
    sliderTitle.TextColor3 = Color3.fromRGB(220, 220, 240)
    sliderTitle.Font = Enum.Font.GothamSemibold
    sliderTitle.TextSize = 12 * scaleFactor
    sliderTitle.TextXAlignment = Enum.TextXAlignment.Left
    sliderTitle.ZIndex = 6
    sliderTitle.Parent = sliderFrame

    local valueDisplay = Instance.new("TextLabel")
    valueDisplay.Name = "ValueDisplay"
    valueDisplay.Size = UDim2.new(0, 50 * scaleFactor, 0, 18 * scaleFactor)
    valueDisplay.Position = UDim2.new(1, -70 * scaleFactor, 0, 2 * scaleFactor)
    valueDisplay.BackgroundColor3 = Color3.fromRGB(25, 25, 40)
    valueDisplay.BackgroundTransparency = 0.2
    valueDisplay.BorderSizePixel = 0
    valueDisplay.Text = tostring(defaultValue)
    valueDisplay.TextColor3 = color
    valueDisplay.Font = Enum.Font.GothamBold
    valueDisplay.TextSize = 11 * scaleFactor
    valueDisplay.TextXAlignment = Enum.TextXAlignment.Center
    valueDisplay.ZIndex = 6
    valueDisplay.Parent = sliderFrame

    local valueCorner = Instance.new("UICorner", valueDisplay)
    valueCorner.CornerRadius = UDim.new(0, 5 * scaleFactor)

    local valueStroke = Instance.new("UIStroke", valueDisplay)
    valueStroke.Color = color
    valueStroke.Thickness = 1 * scaleFactor
    valueStroke.Transparency = 0.6

    local sliderBackground = Instance.new("Frame")
    sliderBackground.Name = "Background"
    sliderBackground.Size = UDim2.new(1, -40 * scaleFactor, 0, 6 * scaleFactor)
    sliderBackground.Position = UDim2.new(0, 20 * scaleFactor, 0, 25 * scaleFactor) 
    sliderBackground.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
    sliderBackground.BorderSizePixel = 0
    sliderBackground.ZIndex = 6
    sliderBackground.Parent = sliderFrame

    local sliderCorner = Instance.new("UICorner", sliderBackground)
    sliderCorner.CornerRadius = UDim.new(1, 0)

    local backgroundStroke = Instance.new("UIStroke", sliderBackground)
    backgroundStroke.Color = Color3.fromRGB(50, 50, 70)
    backgroundStroke.Thickness = 1 * scaleFactor
    backgroundStroke.Transparency = 0.7

    local sliderFill = Instance.new("Frame")
    sliderFill.Name = "Fill"
    sliderFill.Size = UDim2.new((defaultValue - minValue) / (maxValue - minValue), 0, 1, 0)
    sliderFill.BackgroundColor3 = color
    sliderFill.BorderSizePixel = 0
    sliderFill.ZIndex = 7
    sliderFill.Parent = sliderBackground

    local fillCorner = Instance.new("UICorner", sliderFill)
    fillCorner.CornerRadius = UDim.new(1, 0)

    local sliderButton = Instance.new("TextButton")
    sliderButton.Name = "Button"
    sliderButton.Size = UDim2.new(0, 16 * scaleFactor, 0, 16 * scaleFactor)
    sliderButton.Position = UDim2.new((defaultValue - minValue) / (maxValue - minValue), -8 * scaleFactor, 0.5, -8 * scaleFactor)
    sliderButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    sliderButton.AutoButtonColor = false
    sliderButton.Text = ""
    sliderButton.BorderSizePixel = 0
    sliderButton.ZIndex = 8
    sliderButton.Parent = sliderBackground

    local buttonCorner = Instance.new("UICorner", sliderButton)
    buttonCorner.CornerRadius = UDim.new(1, 0)

    local buttonStroke = Instance.new("UIStroke", sliderButton)
    buttonStroke.Color = color
    buttonStroke.Thickness = 2 * scaleFactor
    buttonStroke.Transparency = 0.3

    local buttonGlow = Instance.new("Frame")
    buttonGlow.Name = "ButtonGlow"
    buttonGlow.Size = UDim2.new(0, 20 * scaleFactor, 0, 20 * scaleFactor)
    buttonGlow.Position = UDim2.new(0.5, -10 * scaleFactor, 0.5, -10 * scaleFactor)
    buttonGlow.BackgroundColor3 = color
    buttonGlow.BackgroundTransparency = 0.8
    buttonGlow.BorderSizePixel = 0
    buttonGlow.ZIndex = -1
    buttonGlow.Parent = sliderButton

    local glowCorner = Instance.new("UICorner", buttonGlow)
    glowCorner.CornerRadius = UDim.new(1, 0)

    local dragging = false
    local currentValue = defaultValue

    local function startDragging()
        dragging = sliderButton
        TweenService:Create(buttonGlow, TweenInfo.new(0.1), {BackgroundTransparency = 0.6}):Play()
        TweenService:Create(sliderButton, TweenInfo.new(0.1), {Size = UDim2.new(0, 18 * scaleFactor, 0, 18 * scaleFactor)}):Play()
    end

    local function stopDragging()
        if dragging == sliderButton then
            dragging = false
            TweenService:Create(buttonGlow, TweenInfo.new(0.2), {BackgroundTransparency = 0.8}):Play()
            TweenService:Create(sliderButton, TweenInfo.new(0.2), {Size = UDim2.new(0, 16 * scaleFactor, 0, 16 * scaleFactor)}):Play()
        end
    end

    sliderButton.MouseButton1Down:Connect(startDragging)
    
    if isMobile then
        sliderButton.TouchTap:Connect(function(touch)
            startDragging()
        end)
    end

    UIS.InputEnded:Connect(function(input)
        if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then
            stopDragging()
        end
    end)

    sliderButton.MouseEnter:Connect(function()
        TweenService:Create(buttonStroke, TweenInfo.new(0.2), {Transparency = 0}):Play()
        TweenService:Create(buttonGlow, TweenInfo.new(0.2), {BackgroundTransparency = 0.7}):Play()
    end)

    sliderButton.MouseLeave:Connect(function()
        if dragging ~= sliderButton then
            TweenService:Create(buttonStroke, TweenInfo.new(0.2), {Transparency = 0.3}):Play()
            TweenService:Create(buttonGlow, TweenInfo.new(0.2), {BackgroundTransparency = 0.8}):Play()
        end
    end)

    local function updateValue(xPosition)
        local relativeX = math.clamp((xPosition - sliderBackground.AbsolutePosition.X) / sliderBackground.AbsoluteSize.X, 0, 1)
        local value = math.floor(minValue + (maxValue - minValue) * relativeX + 0.5)
        
        if value ~= currentValue then
            currentValue = value
            valueDisplay.Text = tostring(value)
            
            TweenService:Create(sliderFill, TweenInfo.new(0.1), {Size = UDim2.new(relativeX, 0, 1, 0)}):Play()
            TweenService:Create(sliderButton, TweenInfo.new(0.1), {Position = UDim2.new(relativeX, -8 * scaleFactor, 0.5, -8 * scaleFactor)}):Play()
            
            TweenService:Create(valueDisplay, TweenInfo.new(0.1), {BackgroundTransparency = 0}):Play()
            wait(0.1)
            TweenService:Create(valueDisplay, TweenInfo.new(0.2), {BackgroundTransparency = 0.2}):Play()
        end
    end

    UIS.InputChanged:Connect(function(input)
        if dragging == sliderButton then
            local inputPosition
            if input.UserInputType == Enum.UserInputType.MouseMovement then
                inputPosition = input.Position.X
            elseif input.UserInputType == Enum.UserInputType.Touch then
                inputPosition = input.Position.X
            end
            
            if inputPosition then
                updateValue(inputPosition)
            end
        end
    end)

    sliderBackground.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            local inputPosition = input.Position.X
            updateValue(inputPosition)
            startDragging()
        end
    end)

    return sliderFrame
end

local function createModuleButton(data)
    local button = Instance.new("TextButton")
    button.Name = data.name
    button.Size = UDim2.new(0, buttonWidth, 0, 40 * scaleFactor) 
    button.BackgroundColor3 = Color3.fromRGB(25, 25, 40)
    button.BackgroundTransparency = 0.3
    button.AutoButtonColor = false
    button.Text = ""
    button.BorderSizePixel = 0
    button.Parent = moduleHolder

    local buttonCorner = Instance.new("UICorner", button)
    buttonCorner.CornerRadius = UDim.new(0, 12 * scaleFactor)

    local buttonStroke = Instance.new("UIStroke", button)
    buttonStroke.Color = data.color
    buttonStroke.Thickness = 2 * scaleFactor
    buttonStroke.Transparency = 0.5

    local buttonGradient = Instance.new("UIGradient", button)
    buttonGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(35, 35, 55)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(25, 25, 40)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(20, 20, 35))
    })
    buttonGradient.Rotation = 90

    local buttonHighlight = Instance.new("Frame")
    buttonHighlight.Name = "Highlight"
    buttonHighlight.Size = UDim2.new(1, 0, 1, 0)
    buttonHighlight.BackgroundColor3 = data.color
    buttonHighlight.BackgroundTransparency = 0.9
    buttonHighlight.BorderSizePixel = 0
    buttonHighlight.ZIndex = 2
    buttonHighlight.Parent = button

    local highlightCorner = Instance.new("UICorner", buttonHighlight)
    highlightCorner.CornerRadius = UDim.new(0, 12 * scaleFactor)

    local icon = Instance.new("ImageLabel")
    icon.Name = "Icon"
    icon.Size = UDim2.new(0, 20 * scaleFactor, 0, 20 * scaleFactor) 
    icon.Position = UDim2.new(0, 15 * scaleFactor, 0, 10 * scaleFactor) 
    icon.BackgroundTransparency = 1
    icon.Image = "rbxassetid://118502805264275"
    icon.ImageColor3 = data.color
    icon.ScaleType = Enum.ScaleType.Fit
    icon.ZIndex = 10 
    icon.Parent = button

    local iconGlow = Instance.new("ImageLabel")
    iconGlow.Name = "IconGlow"
    iconGlow.Image = "rbxassetid://118502805264275"
    iconGlow.Size = UDim2.new(0, 26 * scaleFactor, 0, 26 * scaleFactor) 
    iconGlow.Position = UDim2.new(0.5, -13 * scaleFactor, 0.5, -13 * scaleFactor)
    iconGlow.BackgroundTransparency = 1
    iconGlow.ImageTransparency = 0.8
    iconGlow.ImageColor3 = data.color
    iconGlow.ScaleType = Enum.ScaleType.Fit
    iconGlow.ZIndex = -1
    iconGlow.Parent = icon

    local moduleTitle = Instance.new("TextLabel")
    moduleTitle.Name = "ModuleTitle"
    moduleTitle.Size = UDim2.new(1, -120 * scaleFactor, 0, 40 * scaleFactor) 
    moduleTitle.Position = UDim2.new(0, 45 * scaleFactor, 0, 0) 
    moduleTitle.BackgroundTransparency = 1
    moduleTitle.Text = data.name
    moduleTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
    moduleTitle.Font = Enum.Font.GothamSemibold
    moduleTitle.TextSize = 14 * scaleFactor 
    moduleTitle.TextXAlignment = Enum.TextXAlignment.Left
    moduleTitle.TextYAlignment = Enum.TextYAlignment.Center
    moduleTitle.ZIndex = 10 
    moduleTitle.Parent = button

    local toggle = Instance.new("Frame")
    toggle.Name = "Toggle"
    toggle.Size = UDim2.new(0, 32 * scaleFactor, 0, 18 * scaleFactor) 
    toggle.Position = UDim2.new(1, -45 * scaleFactor, 0, 11 * scaleFactor) 
    toggle.BackgroundColor3 = Color3.fromRGB(35, 35, 50)
    toggle.BorderSizePixel = 0
    toggle.ZIndex = 10 
    toggle.Parent = button

    local toggleCorner = Instance.new("UICorner", toggle)
    toggleCorner.CornerRadius = UDim.new(1, 0)

    local toggleStroke = Instance.new("UIStroke", toggle)
    toggleStroke.Color = Color3.fromRGB(60, 60, 80)
    toggleStroke.Thickness = 1.5 * scaleFactor
    toggleStroke.Transparency = 0.6

    local toggleSwitch = Instance.new("Frame")
    toggleSwitch.Name = "Switch"
    toggleSwitch.Size = UDim2.new(0, 14 * scaleFactor, 0, 14 * scaleFactor) 
    toggleSwitch.Position = UDim2.new(0, 2 * scaleFactor, 0.5, -7 * scaleFactor)
    toggleSwitch.BackgroundColor3 = Color3.fromRGB(140, 140, 160)
    toggleSwitch.BorderSizePixel = 0
    toggleSwitch.Parent = toggle

    local switchCorner = Instance.new("UICorner", toggleSwitch)
    switchCorner.CornerRadius = UDim.new(1, 0)

    local switchGlow = Instance.new("Frame")
    switchGlow.Name = "SwitchGlow"
    switchGlow.Size = UDim2.new(0, 18 * scaleFactor, 0, 18 * scaleFactor) 
    switchGlow.Position = UDim2.new(0.5, -9 * scaleFactor, 0.5, -9 * scaleFactor)
    switchGlow.BackgroundColor3 = Color3.fromRGB(140, 140, 160)
    switchGlow.BackgroundTransparency = 0.8
    switchGlow.BorderSizePixel = 0
    switchGlow.ZIndex = -1
    switchGlow.Parent = toggleSwitch

    local switchGlowCorner = Instance.new("UICorner", switchGlow)
    switchGlowCorner.CornerRadius = UDim.new(1, 0)

    local slider
    if data.name == "Speed" then
        slider = createSlider(button, 1, 28, 16, data.color, "Walking Speed")
    elseif data.name == "FOV" then
        slider = createSlider(button, 1, 100, 70, data.color, "Field of View")
    elseif data.name == "Inf Jump" then
        slider = createSlider(button, 1, 150, 50, data.color, "Jump Power")
    end

    local isEnabled = false

    button.MouseEnter:Connect(function()
        TweenService:Create(buttonHighlight, TweenInfo.new(0.2), {BackgroundTransparency = 0.8}):Play()
        TweenService:Create(buttonStroke, TweenInfo.new(0.2), {Transparency = 0.2}):Play()
        TweenService:Create(iconGlow, TweenInfo.new(0.2), {ImageTransparency = 0.6}):Play()
    end)

    button.MouseLeave:Connect(function()
        TweenService:Create(buttonHighlight, TweenInfo.new(0.2), {BackgroundTransparency = 0.9}):Play()
        TweenService:Create(buttonStroke, TweenInfo.new(0.2), {Transparency = 0.5}):Play()
        TweenService:Create(iconGlow, TweenInfo.new(0.2), {ImageTransparency = 0.8}):Play()
    end)

    button.MouseButton1Click:Connect(function()
        isEnabled = not isEnabled
        
        local tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
        
        if isEnabled then
            TweenService:Create(toggleSwitch, tweenInfo, {
                Position = UDim2.new(1, -16 * scaleFactor, 0.5, -7 * scaleFactor), 
                BackgroundColor3 = data.color
            }):Play()
            TweenService:Create(toggle, tweenInfo, {
                BackgroundColor3 = Color3.fromRGB(data.color.R * 255 * 0.3, data.color.G * 255 * 0.3, data.color.B * 255 * 0.3)
            }):Play()
            TweenService:Create(toggleStroke, tweenInfo, {
                Color = data.color,
                Transparency = 0.3
            }):Play()
            TweenService:Create(switchGlow, tweenInfo, {
                BackgroundColor3 = data.color,
                BackgroundTransparency = 0.6
            }):Play()
            
            if slider then
                slider.Visible = true
                TweenService:Create(button, tweenInfo, {Size = UDim2.new(0, buttonWidth, 0, 85 * scaleFactor)}):Play() 
                spawn(function()
                    wait(0.35) 
                    scrollFrame.CanvasSize = UDim2.new(0, 0, 0, listLayout.AbsoluteContentSize.Y + 15 * scaleFactor)
                end)
            end
        else
            TweenService:Create(toggleSwitch, tweenInfo, {
                Position = UDim2.new(0, 2 * scaleFactor, 0.5, -7 * scaleFactor), 
                BackgroundColor3 = Color3.fromRGB(140, 140, 160)
            }):Play()
            TweenService:Create(toggle, tweenInfo, {
                BackgroundColor3 = Color3.fromRGB(35, 35, 50)
            }):Play()
            TweenService:Create(toggleStroke, tweenInfo, {
                Color = Color3.fromRGB(60, 60, 80),
                Transparency = 0.6
            }):Play()
            TweenService:Create(switchGlow, tweenInfo, {
                BackgroundColor3 = Color3.fromRGB(140, 140, 160),
                BackgroundTransparency = 0.8
            }):Play()

            if slider then
                slider.Visible = false
                TweenService:Create(button, tweenInfo, {Size = UDim2.new(0, buttonWidth, 0, 40 * scaleFactor)}):Play() 
                spawn(function()
                    wait(0.35) 
                    scrollFrame.CanvasSize = UDim2.new(0, 0, 0, listLayout.AbsoluteContentSize.Y + 15 * scaleFactor)
                end)
            end
        end
        
        if not slider then
            TweenService:Create(button, TweenInfo.new(0.1), {Size = UDim2.new(0, buttonWidth - 5, 0, 37 * scaleFactor)}):Play()
            wait(0.1)
            TweenService:Create(button, TweenInfo.new(0.2), {Size = UDim2.new(0, buttonWidth, 0, 40 * scaleFactor)}):Play()
        end
    end)
    
    return button
end

local moduleData = {
    {name = "ESP", color = Color3.fromRGB(255, 200, 120)},
    {name = "Aimbot", color = Color3.fromRGB(120, 255, 138)},
    {name = "Hitbox Expander", color = Color3.fromRGB(255, 224, 120)},
    {name = "Inf Jump", color = Color3.fromRGB(255, 120, 200)},
    {name = "Speed", color = Color3.fromRGB(120, 180, 255)},
    {name = "FOV", color = Color3.fromRGB(200, 120, 255)},
}

for i, data in ipairs(moduleData) do
    local moduleButton = createModuleButton(data)
    moduleButton.LayoutOrder = i
end

local isOpen = true
local isDraggingGUI = false
local dragStart = nil
local startPos = nil

local basePosition = UDim2.new(0.5, -mainFrameWidth/2, 0.5, -mainFrameHeight/2)

local function makeGUIDraggable()
    titleFrame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            isDraggingGUI = true
            dragStart = input.Position
            startPos = mainFrame.Position
            
            local connection
            connection = input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    isDraggingGUI = false
                    basePosition = mainFrame.Position
                    connection:Disconnect()
                end
            end)
        end
    end)

    UIS.InputChanged:Connect(function(input)
        if isDraggingGUI and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - dragStart
            local newPosition = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
            mainFrame.Position = newPosition
        end
    end)
end

makeGUIDraggable()

local function toggleUI()
    isOpen = not isOpen
    
    local mainTweenInfo = TweenInfo.new(0.6, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
    local buttonTweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
    
    if isOpen then
        mainFrame.Visible = true
        local tween = TweenService:Create(mainFrame, mainTweenInfo, {
            Position = basePosition,
            BackgroundTransparency = 0.05,
            Size = UDim2.new(0, mainFrameWidth, 0, mainFrameHeight) 
        })
        tween:Play()
        
        TweenService:Create(gradient, mainTweenInfo, {BackgroundTransparency = 0.1}):Play()
        TweenService:Create(mainStroke, mainTweenInfo, {Transparency = 0.4}):Play()
    else
        local hiddenPosition = UDim2.new(basePosition.X.Scale, basePosition.X.Offset, 1.3, 0)
        local tween = TweenService:Create(mainFrame, mainTweenInfo, {
            Position = hiddenPosition,
            BackgroundTransparency = 1,
            Size = UDim2.new(0, mainFrameWidth, 0, mainFrameHeight * 0.85) 
        })
        tween:Play()
        
        TweenService:Create(gradient, mainTweenInfo, {BackgroundTransparency = 1}):Play()
        TweenService:Create(mainStroke, mainTweenInfo, {Transparency = 1}):Play()
        
        tween.Completed:Connect(function()
            mainFrame.Visible = false
        end)
    end
    
    local scaleDown = TweenService:Create(toggleButton, buttonTweenInfo, {
        Size = UDim2.new(0, 50 * scaleFactor, 0, 50 * scaleFactor),
        BackgroundTransparency = 0.2
    })
    local scaleBack = TweenService:Create(toggleButton, buttonTweenInfo, {
        Size = UDim2.new(0, 60 * scaleFactor, 0, 60 * scaleFactor),
        BackgroundTransparency = 0.1
    })
    
    scaleDown:Play()
    scaleDown.Completed:Connect(function()
        scaleBack:Play()
    end)
    
    TweenService:Create(toggleGlow, TweenInfo.new(0.3), {
        ImageTransparency = isOpen and 0.7 or 0.5,
        Size = isOpen and UDim2.new(0, 80 * scaleFactor, 0, 80 * scaleFactor) or UDim2.new(0, 90 * scaleFactor, 0, 90 * scaleFactor)
    }):Play()
end

toggleButton.MouseButton1Click:Connect(toggleUI)

toggleButton.MouseEnter:Connect(function()
    TweenService:Create(toggleButton, TweenInfo.new(0.3, Enum.EasingStyle.Back), {
        Size = UDim2.new(0, 70 * scaleFactor, 0, 70 * scaleFactor)
    }):Play()
    TweenService:Create(toggleStroke, TweenInfo.new(0.2), {Transparency = 0.1}):Play()
    TweenService:Create(toggleGlow, TweenInfo.new(0.2), {
        ImageTransparency = 0.5,
        Size = UDim2.new(0, 90 * scaleFactor, 0, 90 * scaleFactor)
    }):Play()
end)

toggleButton.MouseLeave:Connect(function()
    TweenService:Create(toggleButton, TweenInfo.new(0.3, Enum.EasingStyle.Back), {
        Size = UDim2.new(0, 60 * scaleFactor, 0, 60 * scaleFactor)
    }):Play()
    TweenService:Create(toggleStroke, TweenInfo.new(0.2), {Transparency = 0.3}):Play()
    TweenService:Create(toggleGlow, TweenInfo.new(0.2), {
        ImageTransparency = 0.7,
        Size = UDim2.new(0, 80 * scaleFactor, 0, 80 * scaleFactor)
    }):Play()
end)

local logoRotation = TweenService:Create(logo, TweenInfo.new(15, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1), {Rotation = 360})
logoRotation:Play()

local toggleRotation = TweenService:Create(toggleButton, TweenInfo.new(20, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1), {Rotation = 360})
toggleRotation:Play()

local strokeBreath = TweenService:Create(mainStroke, TweenInfo.new(4, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {Transparency = 0.2})
strokeBreath:Play()

local toggleStrokeBreath = TweenService:Create(toggleStroke, TweenInfo.new(3, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {Transparency = 0.1})
toggleStrokeBreath:Play()

spawn(function()
    local t = 0
    RunService.Heartbeat:Connect(function(dt)
        if isOpen and mainFrame.Visible and not isDraggingGUI then
            t += dt
            local x = math.sin(t * 0.5) * 2 * scaleFactor
            local y = math.cos(t * 0.4) * 1.5 * scaleFactor
            local rotation = math.sin(t * 0.3) * 0.5
            
            mainFrame.Position = UDim2.new(basePosition.X.Scale, basePosition.X.Offset + x, basePosition.Y.Scale, basePosition.Y.Offset + y)
            mainFrame.Rotation = rotation
        end
    end)
end)

spawn(function()
    local t = 0
    RunService.Heartbeat:Connect(function(dt)
        t += dt
        local pulse = (math.sin(t * 2) + 1) / 2
        toggleGlow.ImageTransparency = 0.7 + (pulse * 0.2)
        
        local sizeVariation = (5 + (pulse * 3)) * scaleFactor
        toggleGlow.Size = UDim2.new(0, (80 * scaleFactor) + sizeVariation, 0, (80 * scaleFactor) + sizeVariation)
        toggleGlow.Position = UDim2.new(0.5, -((40 * scaleFactor) + sizeVariation/2), 0.5, -((40 * scaleFactor) + sizeVariation/2))
    end)
end)

spawn(function()
    local t = 0
    RunService.Heartbeat:Connect(function(dt)
        t += dt
        dividerGradient.Rotation = (t * 30) % 360
    end)
end)

spawn(function()
    local t = 0
    RunService.Heartbeat:Connect(function(dt)
        if isOpen and mainFrame.Visible then
            t += dt
            gradientColor.Rotation = 145 + math.sin(t * 0.2) * 5
        end
    end)
end)

-- Soggy, Joshy, and Left made this AMAZING ui

return gui
