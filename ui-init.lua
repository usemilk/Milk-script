local _StarterGui = game:GetService("StarterGui")
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")

local currentValue
local dragging

local gui = Instance.new("ScreenGui")
gui.Name = "MilkGUI"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.Parent = Players.LocalPlayer:WaitForChild("PlayerGui")

local toggleButton = Instance.new("ImageButton")
toggleButton.Name = "ToggleButton"
toggleButton.Size = UDim2.new(0, 60, 0, 60)
toggleButton.Position = UDim2.new(1, -80, 0.5, -30)
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
toggleStroke.Thickness = 3
toggleStroke.Transparency = 0.3

local toggleGlow = Instance.new("ImageLabel")
toggleGlow.Name = "ToggleGlow"
toggleGlow.Image = "rbxassetid://118502805264275"
toggleGlow.Size = UDim2.new(0, 80, 0, 80)
toggleGlow.Position = UDim2.new(0.5, -40, 0.5, -40)
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
mainFrame.Size = UDim2.new(0, 400, 0, 650) 
mainFrame.Position = UDim2.new(0.5, -200, 0.5, -300) 
mainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
mainFrame.BackgroundTransparency = 0.05
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Visible = true
mainFrame.Parent = gui

local mainCorner = Instance.new("UICorner", mainFrame)
mainCorner.CornerRadius = UDim.new(0, 20)

local mainStroke = Instance.new("UIStroke", mainFrame)
mainStroke.Color = Color3.fromRGB(100, 150, 255)
mainStroke.Thickness = 2
mainStroke.Transparency = 0.4

local gradient = Instance.new("Frame")
gradient.Name = "GradientOverlay"
gradient.Size = UDim2.new(1, 0, 1, 0)
gradient.BackgroundTransparency = 0.1
gradient.BorderSizePixel = 0
gradient.Parent = mainFrame

local gradientCorner = Instance.new("UICorner", gradient)
gradientCorner.CornerRadius = UDim.new(0, 20)

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
shadow.Size = UDim2.new(1, 60, 1, 60)
shadow.Position = UDim2.new(0, -30, 0, -30)
shadow.BackgroundTransparency = 1
shadow.ZIndex = -1
shadow.Parent = mainFrame

local titleFrame = Instance.new("Frame")
titleFrame.Name = "TitleFrame"
titleFrame.Size = UDim2.new(1, 0, 0, 80)
titleFrame.BackgroundTransparency = 1
titleFrame.Parent = mainFrame

local titleContainer = Instance.new("Frame")
titleContainer.Name = "TitleContainer"
titleContainer.Size = UDim2.new(0, 180, 0, 50)
titleContainer.Position = UDim2.new(0.5, -90, 0.5, -25)
titleContainer.BackgroundTransparency = 1
titleContainer.Parent = titleFrame

local logo = Instance.new("ImageLabel")
logo.Name = "Logo"
logo.Image = "rbxassetid://118502805264275"
logo.Size = UDim2.new(0, 40, 0, 40)
logo.Position = UDim2.new(0, 0, 0.5, -20)
logo.BackgroundTransparency = 1
logo.ScaleType = Enum.ScaleType.Fit
logo.Parent = titleContainer

local logoGlow = Instance.new("ImageLabel")
logoGlow.Name = "LogoGlow"
logoGlow.Image = "rbxassetid://118502805264275"
logoGlow.Size = UDim2.new(0, 50, 0, 50)
logoGlow.Position = UDim2.new(0, -5, 0.5, -25)
logoGlow.BackgroundTransparency = 1
logoGlow.ImageTransparency = 0.7
logoGlow.ImageColor3 = Color3.fromRGB(140, 200, 255)
logoGlow.ScaleType = Enum.ScaleType.Fit
logoGlow.ZIndex = -1
logoGlow.Parent = titleContainer

local title = Instance.new("TextLabel")
title.Name = "Title"
title.Text = "MILK"
title.Size = UDim2.new(0, 120, 1, 0)
title.Position = UDim2.new(0, 60, 0, 0)
title.BackgroundTransparency = 1
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 28
title.TextStrokeTransparency = 0.6
title.TextStrokeColor3 = Color3.fromRGB(140, 200, 255)
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = titleContainer

local subtitle = Instance.new("TextLabel")
subtitle.Name = "Subtitle"
subtitle.Text = "Premium Gaming Experience • v2.0"
subtitle.Size = UDim2.new(1, 0, 0, 20)
subtitle.Position = UDim2.new(0, 0, 0, 80)
subtitle.BackgroundTransparency = 1
subtitle.TextColor3 = Color3.fromRGB(180, 200, 240)
subtitle.Font = Enum.Font.Gotham
subtitle.TextSize = 12
subtitle.Parent = mainFrame

local divider = Instance.new("Frame")
divider.Name = "Divider"
divider.Size = UDim2.new(0.85, 0, 0, 2)
divider.Position = UDim2.new(0.075, 0, 0, 105)
divider.BackgroundColor3 = Color3.fromRGB(100, 150, 255)
divider.BackgroundTransparency = 0.5
divider.BorderSizePixel = 0
divider.Parent = mainFrame

local dividerGradient = Instance.new("UIGradient", divider)
dividerGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(100, 150, 255)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(140, 200, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(100, 150, 255))
})

local scrollFrame = Instance.new("ScrollingFrame")
scrollFrame.Name = "ScrollFrame"
scrollFrame.Position = UDim2.new(0, 20, 0, 125)
        scrollFrame.Size = UDim2.new(1, -40, 0, 375) 
scrollFrame.BackgroundTransparency = 1
scrollFrame.ScrollBarThickness = 8
scrollFrame.ScrollBarImageColor3 = Color3.fromRGB(100, 150, 255)
scrollFrame.ScrollBarImageTransparency = 0.3
scrollFrame.BorderSizePixel = 0
scrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
scrollFrame.ClipsDescendants = true
scrollFrame.Parent = mainFrame

local scrollCorner = Instance.new("UICorner", scrollFrame)
scrollCorner.CornerRadius = UDim.new(0, 10)

local moduleHolder = Instance.new("Frame")
moduleHolder.Name = "ModuleHolder"
moduleHolder.Position = UDim2.new(0, 0, 0, 5) 
moduleHolder.Size = UDim2.new(1, -20, 1, 0) 
moduleHolder.BackgroundTransparency = 1
moduleHolder.Parent = scrollFrame

local listLayout = Instance.new("UIListLayout")
listLayout.Padding = UDim.new(0, 12)
listLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
listLayout.SortOrder = Enum.SortOrder.LayoutOrder
listLayout.Parent = moduleHolder

listLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    scrollFrame.CanvasSize = UDim2.new(0, 0, 0, listLayout.AbsoluteContentSize.Y + 15)
end)

local function createSlider(parent, minValue, maxValue, defaultValue, color, title)
    local sliderFrame = Instance.new("Frame")
    sliderFrame.Name = "SliderFrame"
    sliderFrame.Size = UDim2.new(1, 0, 0, 80)
    sliderFrame.Position = UDim2.new(0, 0, 0, 50) 
    sliderFrame.BackgroundTransparency = 1
    sliderFrame.Visible = false
    sliderFrame.ClipsDescendants = true 
    sliderFrame.Parent = parent

    local sliderTitle = Instance.new("TextLabel")
    sliderTitle.Name = "SliderTitle"
    sliderTitle.Size = UDim2.new(1, -40, 0, 20)
    sliderTitle.Position = UDim2.new(0, 20, 0, 5)
    sliderTitle.BackgroundTransparency = 1
    sliderTitle.Text = title or "Value"
    sliderTitle.TextColor3 = Color3.fromRGB(220, 220, 240)
    sliderTitle.Font = Enum.Font.GothamMedium
    sliderTitle.TextSize = 13
    sliderTitle.TextXAlignment = Enum.TextXAlignment.Left
    sliderTitle.Parent = sliderFrame

    local valueDisplay = Instance.new("TextLabel")
    valueDisplay.Name = "ValueDisplay"
    valueDisplay.Size = UDim2.new(0, 60, 0, 20)
    valueDisplay.Position = UDim2.new(1, -80, 0, 5)
    valueDisplay.BackgroundColor3 = Color3.fromRGB(25, 25, 40)
    valueDisplay.BackgroundTransparency = 0.2
    valueDisplay.BorderSizePixel = 0
    valueDisplay.Text = tostring(defaultValue)
    valueDisplay.TextColor3 = color
    valueDisplay.Font = Enum.Font.GothamBold
    valueDisplay.TextSize = 12
    valueDisplay.TextXAlignment = Enum.TextXAlignment.Center
    valueDisplay.Parent = sliderFrame

    local valueCorner = Instance.new("UICorner", valueDisplay)
    valueCorner.CornerRadius = UDim.new(0, 6)

    local valueStroke = Instance.new("UIStroke", valueDisplay)
    valueStroke.Color = color
    valueStroke.Thickness = 1.5
    valueStroke.Transparency = 0.5

    local sliderBackground = Instance.new("Frame")
    sliderBackground.Name = "Background"
    sliderBackground.Size = UDim2.new(1, -40, 0, 8)
    sliderBackground.Position = UDim2.new(0, 20, 0, 35) 
    sliderBackground.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
    sliderBackground.BorderSizePixel = 0
    sliderBackground.Parent = sliderFrame

    local sliderCorner = Instance.new("UICorner", sliderBackground)
    sliderCorner.CornerRadius = UDim.new(1, 0)

    local backgroundStroke = Instance.new("UIStroke", sliderBackground)
    backgroundStroke.Color = Color3.fromRGB(50, 50, 70)
    backgroundStroke.Thickness = 1
    backgroundStroke.Transparency = 0.7

    local sliderFill = Instance.new("Frame")
    sliderFill.Name = "Fill"
    sliderFill.Size = UDim2.new((defaultValue - minValue) / (maxValue - minValue), 0, 1, 0)
    sliderFill.BackgroundColor3 = color
    sliderFill.BorderSizePixel = 0
    sliderFill.Parent = sliderBackground

    local fillCorner = Instance.new("UICorner", sliderFill)
    fillCorner.CornerRadius = UDim.new(1, 0)

    local sliderButton = Instance.new("TextButton")
    sliderButton.Name = "Button"
    sliderButton.Size = UDim2.new(0, 20, 0, 20)
    sliderButton.Position = UDim2.new((defaultValue - minValue) / (maxValue - minValue), -10, 0.5, -10)
    sliderButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    sliderButton.AutoButtonColor = false
    sliderButton.Text = ""
    sliderButton.BorderSizePixel = 0
    sliderButton.Parent = sliderBackground

    local buttonCorner = Instance.new("UICorner", sliderButton)
    buttonCorner.CornerRadius = UDim.new(1, 0)

    local buttonStroke = Instance.new("UIStroke", sliderButton)
    buttonStroke.Color = color
    buttonStroke.Thickness = 3
    buttonStroke.Transparency = 0.2

    local buttonGlow = Instance.new("Frame")
    buttonGlow.Name = "ButtonGlow"
    buttonGlow.Size = UDim2.new(0, 26, 0, 26)
    buttonGlow.Position = UDim2.new(0.5, -13, 0.5, -13)
    buttonGlow.BackgroundColor3 = color
    buttonGlow.BackgroundTransparency = 0.8
    buttonGlow.BorderSizePixel = 0
    buttonGlow.ZIndex = -1
    buttonGlow.Parent = sliderButton

    local glowCorner = Instance.new("UICorner", buttonGlow)
    glowCorner.CornerRadius = UDim.new(1, 0)


    sliderButton.MouseButton1Down:Connect(function()
        dragging = true
        TweenService:Create(buttonGlow, TweenInfo.new(0.1), {BackgroundTransparency = 0.6}):Play()
        TweenService:Create(sliderButton, TweenInfo.new(0.1), {Size = UDim2.new(0, 24, 0, 24)}):Play()
    end)

    UIS.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
            TweenService:Create(buttonGlow, TweenInfo.new(0.2), {BackgroundTransparency = 0.8}):Play()
            TweenService:Create(sliderButton, TweenInfo.new(0.2), {Size = UDim2.new(0, 20, 0, 20)}):Play()
        end
    end)

    sliderButton.MouseEnter:Connect(function()
        TweenService:Create(buttonStroke, TweenInfo.new(0.2), {Transparency = 0}):Play()
        TweenService:Create(buttonGlow, TweenInfo.new(0.2), {BackgroundTransparency = 0.7}):Play()
    end)

    sliderButton.MouseLeave:Connect(function()
        if not dragging then
            TweenService:Create(buttonStroke, TweenInfo.new(0.2), {Transparency = 0.2}):Play()
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
            TweenService:Create(sliderButton, TweenInfo.new(0.1), {Position = UDim2.new(relativeX, -10, 0.5, -10)}):Play()
            
            TweenService:Create(valueDisplay, TweenInfo.new(0.1), {BackgroundTransparency = 0}):Play()
            wait(0.1)
            TweenService:Create(valueDisplay, TweenInfo.new(0.2), {BackgroundTransparency = 0.2}):Play()
        end
    end

    UIS.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            updateValue(input.Position.X)
        end
    end)

    return sliderFrame
end

local function createModuleButton(data)
    local button = Instance.new("TextButton")
    button.Name = data.name
    button.Size = UDim2.new(0, 350, 0, 40) 
    button.BackgroundColor3 = Color3.fromRGB(25, 25, 40)
    button.BackgroundTransparency = 0.3
    button.AutoButtonColor = false
    button.Text = ""
    button.BorderSizePixel = 0
    button.Parent = moduleHolder

    local buttonCorner = Instance.new("UICorner", button)
    buttonCorner.CornerRadius = UDim.new(0, 12)

    local buttonStroke = Instance.new("UIStroke", button)
    buttonStroke.Color = data.color
    buttonStroke.Thickness = 2
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
    highlightCorner.CornerRadius = UDim.new(0, 12)

    local icon = Instance.new("ImageLabel")
    icon.Name = "Icon"
    icon.Size = UDim2.new(0, 20, 0, 20) 
    icon.Position = UDim2.new(0, 15, 0, 10) 
    icon.BackgroundTransparency = 1
    icon.Image = "rbxassetid://118502805264275"
    icon.ImageColor3 = data.color
    icon.ScaleType = Enum.ScaleType.Fit
    icon.ZIndex = 10 
    icon.Parent = button

    local iconGlow = Instance.new("ImageLabel")
    iconGlow.Name = "IconGlow"
    iconGlow.Image = "rbxassetid://118502805264275"
    iconGlow.Size = UDim2.new(0, 26, 0, 26) 
    iconGlow.Position = UDim2.new(0.5, -13, 0.5, -13)
    iconGlow.BackgroundTransparency = 1
    iconGlow.ImageTransparency = 0.8
    iconGlow.ImageColor3 = data.color
    iconGlow.ScaleType = Enum.ScaleType.Fit
    iconGlow.ZIndex = -1
    iconGlow.Parent = icon

    local moduleTitle = Instance.new("TextLabel")
    moduleTitle.Name = "ModuleTitle"
    moduleTitle.Size = UDim2.new(1, -120, 0, 40) 
    moduleTitle.Position = UDim2.new(0, 45, 0, 0) 
    moduleTitle.BackgroundTransparency = 1
    moduleTitle.Text = data.name
    moduleTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
    moduleTitle.Font = Enum.Font.GothamMedium
    moduleTitle.TextSize = 14 
    moduleTitle.TextXAlignment = Enum.TextXAlignment.Left
    moduleTitle.TextYAlignment = Enum.TextYAlignment.Center
    moduleTitle.ZIndex = 10 
    moduleTitle.Parent = button

    local toggle = Instance.new("Frame")
    toggle.Name = "Toggle"
    toggle.Size = UDim2.new(0, 32, 0, 18) 
    toggle.Position = UDim2.new(1, -45, 0, 11) 
    toggle.BackgroundColor3 = Color3.fromRGB(35, 35, 50)
    toggle.BorderSizePixel = 0
    toggle.ZIndex = 10 
    toggle.Parent = button

    local toggleCorner = Instance.new("UICorner", toggle)
    toggleCorner.CornerRadius = UDim.new(1, 0)

    local toggleStroke = Instance.new("UIStroke", toggle)
    toggleStroke.Color = Color3.fromRGB(60, 60, 80)
    toggleStroke.Thickness = 1.5
    toggleStroke.Transparency = 0.6

    local toggleSwitch = Instance.new("Frame")
    toggleSwitch.Name = "Switch"
    toggleSwitch.Size = UDim2.new(0, 14, 0, 14) 
    toggleSwitch.Position = UDim2.new(0, 2, 0.5, -7)
    toggleSwitch.BackgroundColor3 = Color3.fromRGB(140, 140, 160)
    toggleSwitch.BorderSizePixel = 0
    toggleSwitch.Parent = toggle

    local switchCorner = Instance.new("UICorner", toggleSwitch)
    switchCorner.CornerRadius = UDim.new(1, 0)

    local switchGlow = Instance.new("Frame")
    switchGlow.Name = "SwitchGlow"
    switchGlow.Size = UDim2.new(0, 18, 0, 18) 
    switchGlow.Position = UDim2.new(0.5, -9, 0.5, -9)
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
        slider = createSlider(button, 40, 100, 70, data.color, "Field of View")
    elseif data.name == "Inf Jump" then
        slider = createSlider(button, 1, 75, 50, data.color, "Jump Power")
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
                Position = UDim2.new(1, -16, 0.5, -7), 
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
                TweenService:Create(button, tweenInfo, {Size = UDim2.new(0, 350, 0, 110)}):Play() 
                spawn(function()
                    wait(0.35) 
                    scrollFrame.CanvasSize = UDim2.new(0, 0, 0, listLayout.AbsoluteContentSize.Y + 15)
                end)
            end
        else
            TweenService:Create(toggleSwitch, tweenInfo, {
                Position = UDim2.new(0, 2, 0.5, -7), 
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
                TweenService:Create(button, tweenInfo, {Size = UDim2.new(0, 350, 0, 40)}):Play() 
                spawn(function()
                    wait(0.35) 
                    scrollFrame.CanvasSize = UDim2.new(0, 0, 0, listLayout.AbsoluteContentSize.Y + 15)
                end)
            end
        end
        
        if not slider then
            TweenService:Create(button, TweenInfo.new(0.1), {Size = UDim2.new(0, 345, 0, 37)}):Play()
            wait(0.1)
            TweenService:Create(button, TweenInfo.new(0.2), {Size = UDim2.new(0, 350, 0, 40)}):Play()
        end
    end)
    
    return button
end

local moduleData = {
    {name = "ESP", color = Color3.fromRGB(255, 200, 120)},
    {name = "Hitbox Expander", color = Color3.fromRGB(120, 255, 200)},
    {name = "Inf Jump", color = Color3.fromRGB(255, 120, 200)},
    {name = "Speed", color = Color3.fromRGB(120, 180, 255)},
    {name = "FOV", color = Color3.fromRGB(200, 120, 255)},
}

for i, data in ipairs(moduleData) do
    local moduleButton = createModuleButton(data)
    moduleButton.LayoutOrder = i
end

local isOpen = true

local function toggleUI()
    isOpen = not isOpen
    
    local mainTweenInfo = TweenInfo.new(0.6, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
    local buttonTweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
    
    if isOpen then
        mainFrame.Visible = true
        local tween = TweenService:Create(mainFrame, mainTweenInfo, {
            Position = UDim2.new(0.5, -200, 0.5, -300), 
            BackgroundTransparency = 0.05,
            Size = UDim2.new(0, 400, 0, 600) 
        })
        tween:Play()
        
        TweenService:Create(gradient, mainTweenInfo, {BackgroundTransparency = 0.1}):Play()
        TweenService:Create(mainStroke, mainTweenInfo, {Transparency = 0.4}):Play()
    else
        local tween = TweenService:Create(mainFrame, mainTweenInfo, {
            Position = UDim2.new(0.5, -200, 1.3, 0), 
            BackgroundTransparency = 1,
            Size = UDim2.new(0, 400, 0, 550) 
        })
        tween:Play()
        
        TweenService:Create(gradient, mainTweenInfo, {BackgroundTransparency = 1}):Play()
        TweenService:Create(mainStroke, mainTweenInfo, {Transparency = 1}):Play()
        
        tween.Completed:Connect(function()
            mainFrame.Visible = false
        end)
    end
    
    local scaleDown = TweenService:Create(toggleButton, buttonTweenInfo, {
        Size = UDim2.new(0, 50, 0, 50),
        BackgroundTransparency = 0.2
    })
    local scaleBack = TweenService:Create(toggleButton, buttonTweenInfo, {
        Size = UDim2.new(0, 60, 0, 60),
        BackgroundTransparency = 0.1
    })
    
    scaleDown:Play()
    scaleDown.Completed:Connect(function()
        scaleBack:Play()
    end)
    
    TweenService:Create(toggleGlow, TweenInfo.new(0.3), {
        ImageTransparency = isOpen and 0.7 or 0.5,
        Size = isOpen and UDim2.new(0, 80, 0, 80) or UDim2.new(0, 90, 0, 90)
    }):Play()
end

toggleButton.MouseButton1Click:Connect(toggleUI)

toggleButton.MouseEnter:Connect(function()
    TweenService:Create(toggleButton, TweenInfo.new(0.3, Enum.EasingStyle.Back), {
        Size = UDim2.new(0, 70, 0, 70)
    }):Play()
    TweenService:Create(toggleStroke, TweenInfo.new(0.2), {Transparency = 0.1}):Play()
    TweenService:Create(toggleGlow, TweenInfo.new(0.2), {
        ImageTransparency = 0.5,
        Size = UDim2.new(0, 90, 0, 90)
    }):Play()
end)

toggleButton.MouseLeave:Connect(function()
    TweenService:Create(toggleButton, TweenInfo.new(0.3, Enum.EasingStyle.Back), {
        Size = UDim2.new(0, 60, 0, 60)
    }):Play()
    TweenService:Create(toggleStroke, TweenInfo.new(0.2), {Transparency = 0.3}):Play()
    TweenService:Create(toggleGlow, TweenInfo.new(0.2), {
        ImageTransparency = 0.7,
        Size = UDim2.new(0, 80, 0, 80)
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
    local original = UDim2.new(0.5, -200, 0.5, -300) 
    RunService.Heartbeat:Connect(function(dt)
        if isOpen and mainFrame.Visible then
            t += dt
            local x = math.sin(t * 0.5) * 2
            local y = math.cos(t * 0.4) * 1.5
            local rotation = math.sin(t * 0.3) * 0.5
            
            mainFrame.Position = UDim2.new(original.X.Scale, original.X.Offset + x, original.Y.Scale, original.Y.Offset + y)
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
        
        local sizeVariation = 5 + (pulse * 3)
        toggleGlow.Size = UDim2.new(0, 80 + sizeVariation, 0, 80 + sizeVariation)
        toggleGlow.Position = UDim2.new(0.5, -(40 + sizeVariation/2), 0.5, -(40 + sizeVariation/2))
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

return gui
