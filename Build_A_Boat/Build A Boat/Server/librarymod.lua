-- Modern UI Library v3.0
-- Complete with all standard UI elements
-- Themes: Dark, Light, Midnight, Aqua, Neon
-- Elements: Window, Tabs, Button, Label, Toggle, Slider, Dropdown, TextBox, Keybind, ColorPicker

local UILibrary = {}

-- Services
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")

-- Default Configuration
UILibrary.Config = {
    Theme = "Dark", -- Dark, Light, Midnight, Aqua, Neon
    ToggleKey = Enum.KeyCode.RightShift,
    AnimationSpeed = 0.15,
    Transparency = 0.1,
    CornerRadius = 8,
    Shadow = true,
    Font = Enum.Font.GothamMedium,
    TextSize = 14,
    MinWindowSize = Vector2.new(400, 300)
}

-- Theme Colors
UILibrary.Themes = {
    Dark = {
        Main = Color3.fromRGB(41, 74, 122),
        Background = Color3.fromRGB(30, 30, 40),
        Text = Color3.fromRGB(240, 240, 240),
        Accent = Color3.fromRGB(65, 120, 200),
        Secondary = Color3.fromRGB(60, 60, 70),
        Highlight = Color3.fromRGB(80, 140, 220),
        Slider = Color3.fromRGB(70, 130, 210),
        Dropdown = Color3.fromRGB(50, 50, 60)
    },
    Light = {
        Main = Color3.fromRGB(65, 140, 240),
        Background = Color3.fromRGB(240, 240, 245),
        Text = Color3.fromRGB(40, 40, 50),
        Accent = Color3.fromRGB(100, 180, 255),
        Secondary = Color3.fromRGB(220, 220, 230),
        Highlight = Color3.fromRGB(120, 190, 255),
        Slider = Color3.fromRGB(90, 160, 250),
        Dropdown = Color3.fromRGB(200, 200, 210)
    },
    Midnight = {
        Main = Color3.fromRGB(100, 70, 180),
        Background = Color3.fromRGB(20, 20, 30),
        Text = Color3.fromRGB(230, 230, 240),
        Accent = Color3.fromRGB(130, 90, 210),
        Secondary = Color3.fromRGB(40, 35, 60),
        Highlight = Color3.fromRGB(150, 110, 230),
        Slider = Color3.fromRGB(120, 80, 200),
        Dropdown = Color3.fromRGB(35, 30, 50)
    },
    Aqua = {
        Main = Color3.fromRGB(30, 160, 180),
        Background = Color3.fromRGB(25, 35, 45),
        Text = Color3.fromRGB(220, 240, 250),
        Accent = Color3.fromRGB(50, 190, 210),
        Secondary = Color3.fromRGB(35, 55, 70),
        Highlight = Color3.fromRGB(70, 210, 230),
        Slider = Color3.fromRGB(60, 180, 200),
        Dropdown = Color3.fromRGB(30, 50, 65)
    },
    Neon = {
        Main = Color3.fromRGB(200, 40, 200),
        Background = Color3.fromRGB(15, 15, 25),
        Text = Color3.fromRGB(250, 220, 250),
        Accent = Color3.fromRGB(230, 60, 230),
        Secondary = Color3.fromRGB(40, 20, 50),
        Highlight = Color3.fromRGB(255, 80, 255),
        Slider = Color3.fromRGB(220, 50, 220),
        Dropdown = Color3.fromRGB(35, 15, 45)
    }
}

-- Helper Functions
local function ApplyTheme(instance, elementType)
    local theme = UILibrary.Themes[UILibrary.Config.Theme]
    
    if instance:IsA("TextLabel") or instance:IsA("TextButton") or instance:IsA("TextBox") then
        instance.TextColor3 = theme.Text
        instance.Font = UILibrary.Config.Font
        instance.TextSize = UILibrary.Config.TextSize
    end
    
    if instance:IsA("Frame") or instance:IsA("ImageButton") or instance:IsA("TextBox") then
        instance.BackgroundTransparency = elementType == "Window" and 0.05 or UILibrary.Config.Transparency
        instance.BackgroundColor3 = elementType == "Button" and theme.Main 
                                  or elementType == "Secondary" and theme.Secondary
                                  or elementType == "Slider" and theme.Slider
                                  or elementType == "Dropdown" and theme.Dropdown
                                  or theme.Background
        
        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(0, UILibrary.Config.CornerRadius)
        corner.Parent = instance
        
        if UILibrary.Config.Shadow then
            local shadow = Instance.new("UIStroke")
            shadow.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
            shadow.Color = Color3.new(0, 0, 0)
            shadow.Transparency = 0.8
            shadow.Thickness = elementType == "Window" and 2 or 1
            shadow.Parent = instance
        end
    end
end

local function RippleEffect(button, x, y)
    local circle = Instance.new("Frame")
    circle.Name = "Ripple"
    circle.BackgroundColor3 = UILibrary.Themes[UILibrary.Config.Theme].Highlight
    circle.BackgroundTransparency = 0.7
    circle.ZIndex = 1000
    circle.Parent = button
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0.5, 0)
    corner.Parent = circle
    
    local new_x = x - button.AbsolutePosition.X
    local new_y = y - button.AbsolutePosition.Y
    circle.Position = UDim2.new(0, new_x, 0, new_y)
    circle.Size = UDim2.new(0, 0, 0, 0)
    
    local size = math.max(button.AbsoluteSize.X, button.AbsoluteSize.Y) * 1.5
    
    TweenService:Create(circle, TweenInfo.new(0.5), {
        Size = UDim2.new(0, size, 0, size),
        Position = UDim2.new(0.5, -size/2, 0.5, -size/2),
        BackgroundTransparency = 1
    }):Play()
    
    game:GetService("Debris"):AddItem(circle, 0.5)
end

-- Window Class
UILibrary.Window = {}
UILibrary.Window.__index = UILibrary.Window

function UILibrary:CreateWindow(title)
    local window = {}
    setmetatable(window, UILibrary.Window)
    
    -- Create Window Instance
    local windowFrame = Instance.new("Frame")
    windowFrame.Name = title or "Window"
    windowFrame.Size = UDim2.new(0, UILibrary.Config.MinWindowSize.X, 0, UILibrary.Config.MinWindowSize.Y)
    windowFrame.Position = UDim2.new(0.5, -UILibrary.Config.MinWindowSize.X/2, 0.5, -UILibrary.Config.MinWindowSize.Y/2)
    windowFrame.ClipsDescendants = true
    windowFrame.Parent = script.Parent -- Change this to your desired parent
    
    ApplyTheme(windowFrame, "Window")
    
    -- Title Bar
    local titleBar = Instance.new("Frame")
    titleBar.Name = "TitleBar"
    titleBar.Size = UDim2.new(1, 0, 0, 30)
    titleBar.Position = UDim2.new(0, 0, 0, 0)
    titleBar.Parent = windowFrame
    
    ApplyTheme(titleBar, "Secondary")
    
    local titleText = Instance.new("TextLabel")
    titleText.Name = "Title"
    titleText.Text = title or "Window"
    titleText.Size = UDim2.new(1, -40, 1, 0)
    titleText.Position = UDim2.new(0, 10, 0, 0)
    titleText.TextXAlignment = Enum.TextXAlignment.Left
    titleText.Parent = titleBar
    
    ApplyTheme(titleText)
    
    -- Close Button
    local closeButton = Instance.new("TextButton")
    closeButton.Name = "CloseButton"
    closeButton.Text = "X"
    closeButton.Size = UDim2.new(0, 30, 0, 30)
    closeButton.Position = UDim2.new(1, -30, 0, 0)
    closeButton.Parent = titleBar
    
    ApplyTheme(closeButton, "Button")
    
    -- Content Frame
    local contentFrame = Instance.new("Frame")
    contentFrame.Name = "Content"
    contentFrame.Size = UDim2.new(1, -10, 1, -40)
    contentFrame.Position = UDim2.new(0, 5, 0, 35)
    contentFrame.Parent = windowFrame
    
    ApplyTheme(contentFrame)
    
    -- Tab System
    local tabButtons = Instance.new("Frame")
    tabButtons.Name = "TabButtons"
    tabButtons.Size = UDim2.new(1, 0, 0, 30)
    tabButtons.Position = UDim2.new(0, 0, 0, 0)
    tabButtons.Parent = contentFrame
    
    ApplyTheme(tabButtons)
    
    local tabListLayout = Instance.new("UIListLayout")
    tabListLayout.FillDirection = Enum.FillDirection.Horizontal
    tabListLayout.Padding = UDim.new(0, 5)
    tabListLayout.Parent = tabButtons
    
    local tabContent = Instance.new("Frame")
    tabContent.Name = "TabContent"
    tabContent.Size = UDim2.new(1, 0, 1, -35)
    tabContent.Position = UDim2.new(0, 0, 0, 35)
    tabContent.Parent = contentFrame
    
    ApplyTheme(tabContent)
    
    -- Store references
    window.Instance = windowFrame
    window.TitleBar = titleBar
    window.Content = contentFrame
    window.TabButtons = tabButtons
    window.TabContent = tabContent
    window.Tabs = {}
    window.ActiveTab = nil
    
    -- Make window draggable
    local dragging
    local dragInput
    local dragStart
    local startPos
    
    titleBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = windowFrame.Position
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)
    
    titleBar.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            dragInput = input
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            windowFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
    
    -- Close functionality
    closeButton.MouseButton1Click:Connect(function()
        window:Close()
    end)
    
    return window
end

function UILibrary.Window:AddTab(name)
    local tab = {}
    tab.Name = name or "Tab"
    
    -- Tab Button
    local tabButton = Instance.new("TextButton")
    tabButton.Name = name or "TabButton"
    tabButton.Text = name or "Tab"
    tabButton.Size = UDim2.new(0, 80, 1, 0)
    tabButton.Parent = self.TabButtons
    
    ApplyTheme(tabButton, "Secondary")
    
    -- Tab Content
    local tabContent = Instance.new("Frame")
    tabContent.Name = name or "TabContent"
    tabContent.Size = UDim2.new(1, 0, 1, 0)
    tabContent.Position = UDim2.new(0, 0, 0, 0)
    tabContent.Visible = false
    tabContent.Parent = self.TabContent
    
    ApplyTheme(tabContent)
    
    local contentListLayout = Instance.new("UIListLayout")
    contentListLayout.Padding = UDim.new(0, 5)
    contentListLayout.Parent = tabContent
    
    -- Store references
    tab.Button = tabButton
    tab.Content = tabContent
    tab.Elements = {}
    
    -- Tab switching
    tabButton.MouseButton1Click:Connect(function()
        self:SwitchTab(tab)
    end)
    
    table.insert(self.Tabs, tab)
    
    -- Set as active if first tab
    if #self.Tabs == 1 then
        self:SwitchTab(tab)
    end
    
    return tab
end

function UILibrary.Window:SwitchTab(tab)
    if self.ActiveTab then
        self.ActiveTab.Content.Visible = false
        TweenService:Create(self.ActiveTab.Button, TweenInfo.new(UILibrary.Config.AnimationSpeed), {
            BackgroundColor3 = UILibrary.Themes[UILibrary.Config.Theme].Secondary
        }):Play()
    end
    
    self.ActiveTab = tab
    tab.Content.Visible = true
    TweenService:Create(tab.Button, TweenInfo.new(UILibrary.Config.AnimationSpeed), {
        BackgroundColor3 = UILibrary.Themes[UILibrary.Config.Theme].Main
    }):Play()
end

function UILibrary.Window:Close()
    self.Instance:Destroy()
end

-- UI Elements
function UILibrary.Window:AddButton(tab, text, callback)
    local button = Instance.new("TextButton")
    button.Name = text or "Button"
    button.Text = text or "Button"
    button.Size = UDim2.new(1, -10, 0, 30)
    button.Parent = tab.Content
    
    ApplyTheme(button, "Button")
    
    -- Hover effects
    button.MouseEnter:Connect(function()
        TweenService:Create(button, TweenInfo.new(UILibrary.Config.AnimationSpeed), {
            BackgroundColor3 = UILibrary.Themes[UILibrary.Config.Theme].Accent
        }):Play()
    end)
    
    button.MouseLeave:Connect(function()
        TweenService:Create(button, TweenInfo.new(UILibrary.Config.AnimationSpeed), {
            BackgroundColor3 = UILibrary.Themes[UILibrary.Config.Theme].Main
        }):Play()
    end)
    
    -- Click effect
    button.MouseButton1Click:Connect(function()
        RippleEffect(button, UserInputService:GetMouseLocation().X, UserInputService:GetMouseLocation().Y)
        if callback then callback() end
    end)
    
    return button
end

function UILibrary.Window:AddLabel(tab, text)
    local label = Instance.new("TextLabel")
    label.Name = "Label"
    label.Text = text or "Label"
    label.Size = UDim2.new(1, -10, 0, 20)
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = tab.Content
    
    ApplyTheme(label)
    
    return label
end

function UILibrary.Window:AddToggle(tab, text, default, callback)
    local toggleFrame = Instance.new("Frame")
    toggleFrame.Name = "Toggle"
    toggleFrame.Size = UDim2.new(1, -10, 0, 30)
    toggleFrame.BackgroundTransparency = 1
    toggleFrame.Parent = tab.Content
    
    local toggleLabel = Instance.new("TextLabel")
    toggleLabel.Name = "Label"
    toggleLabel.Text = text or "Toggle"
    toggleLabel.Size = UDim2.new(0.7, 0, 1, 0)
    toggleLabel.TextXAlignment = Enum.TextXAlignment.Left
    toggleLabel.Parent = toggleFrame
    
    ApplyTheme(toggleLabel)
    
    local toggleButton = Instance.new("TextButton")
    toggleButton.Name = "ToggleButton"
    toggleButton.Size = UDim2.new(0.3, 0, 1, 0)
    toggleButton.Position = UDim2.new(0.7, 0, 0, 0)
    toggleButton.Text = ""
    toggleButton.Parent = toggleFrame
    
    ApplyTheme(toggleButton, "Secondary")
    
    local toggleState = default or false
    local toggleIndicator = Instance.new("Frame")
    toggleIndicator.Name = "Indicator"
    toggleIndicator.Size = UDim2.new(0.5, 0, 1, -4)
    toggleIndicator.Position = UDim2.new(0, 2, 0, 2)
    toggleIndicator.Parent = toggleButton
    
    ApplyTheme(toggleIndicator, "Button")
    
    local function updateToggle()
        if toggleState then
            TweenService:Create(toggleIndicator, TweenInfo.new(UILibrary.Config.AnimationSpeed), {
                Position = UDim2.new(0.5, -2, 0, 2),
                BackgroundColor3 = UILibrary.Themes[UILibrary.Config.Theme].Accent
            }):Play()
        else
            TweenService:Create(toggleIndicator, TweenInfo.new(UILibrary.Config.AnimationSpeed), {
                Position = UDim2.new(0, 2, 0, 2),
                BackgroundColor3 = UILibrary.Themes[UILibrary.Config.Theme].Main
            }):Play()
        end
    end
    
    toggleButton.MouseButton1Click:Connect(function()
        toggleState = not toggleState
        updateToggle()
        if callback then callback(toggleState) end
    end)
    
    updateToggle()
    
    return {
        Set = function(self, state)
            toggleState = state
            updateToggle()
        end,
        Get = function(self)
            return toggleState
        end
    }
end

function UILibrary.Window:AddSlider(tab, text, min, max, default, callback)
    local sliderFrame = Instance.new("Frame")
    sliderFrame.Name = "Slider"
    sliderFrame.Size = UDim2.new(1, -10, 0, 50)
    sliderFrame.BackgroundTransparency = 1
    sliderFrame.Parent = tab.Content
    
    local sliderLabel = Instance.new("TextLabel")
    sliderLabel.Name = "Label"
    sliderLabel.Text = text or "Slider"
    sliderLabel.Size = UDim2.new(1, 0, 0, 20)
    sliderLabel.TextXAlignment = Enum.TextXAlignment.Left
    sliderLabel.Parent = sliderFrame
    
    ApplyTheme(sliderLabel)
    
    local sliderTrack = Instance.new("Frame")
    sliderTrack.Name = "Track"
    sliderTrack.Size = UDim2.new(1, 0, 0, 10)
    sliderTrack.Position = UDim2.new(0, 0, 0, 25)
    sliderTrack.Parent = sliderFrame
    
    ApplyTheme(sliderTrack, "Slider")
    
    local sliderFill = Instance.new("Frame")
    sliderFill.Name = "Fill"
    sliderFill.Size = UDim2.new(0, 0, 1, 0)
    sliderFill.Parent = sliderTrack
    
    ApplyTheme(sliderFill, "Button")
    
    local sliderValue = Instance.new("TextLabel")
    sliderValue.Name = "Value"
    sliderValue.Text = tostring(default or min)
    sliderValue.Size = UDim2.new(0, 50, 0, 20)
    sliderValue.Position = UDim2.new(1, -50, 0, 0)
    sliderValue.TextXAlignment = Enum.TextXAlignment.Right
    sliderValue.Parent = sliderFrame
    
    ApplyTheme(sliderValue)
    
    min = min or 0
    max = max or 100
    default = math.clamp(default or min, min, max)
    
    local currentValue = default
    local isDragging = false
    
    local function updateSlider(value)
        currentValue = math.clamp(value, min, max)
        local percentage = (currentValue - min) / (max - min)
        sliderFill.Size = UDim2.new(percentage, 0, 1, 0)
        sliderValue.Text = tostring(math.floor(currentValue))
        if callback then callback(currentValue) end
    end
    
    sliderTrack.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            isDragging = true
            local mousePos = UserInputService:GetMouseLocation().X
            local relativePos = mousePos - sliderTrack.AbsolutePosition.X
            local percentage = math.clamp(relativePos / sliderTrack.AbsoluteSize.X, 0, 1)
            updateSlider(min + (max - min) * percentage)
        end
    end)
    
    sliderTrack.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            isDragging = false
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if isDragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local mousePos = UserInputService:GetMouseLocation().X
            local relativePos = mousePos - sliderTrack.AbsolutePosition.X
            local percentage = math.clamp(relativePos / sliderTrack.AbsoluteSize.X, 0, 1)
            updateSlider(min + (max - min) * percentage)
        end
    end)
    
    updateSlider(default)
    
    return {
        Set = function(self, value)
            updateSlider(value)
        end,
        Get = function(self)
            return currentValue
        end
    }
end

function UILibrary.Window:AddTextBox(tab, text, placeholder, callback)
    local textBoxFrame = Instance.new("Frame")
    textBoxFrame.Name = "TextBox"
    textBoxFrame.Size = UDim2.new(1, -10, 0, 30)
    textBoxFrame.BackgroundTransparency = 1
    textBoxFrame.Parent = tab.Content
    
    local textBox = Instance.new("TextBox")
    textBox.Name = "Input"
    textBox.Text = text or ""
    textBox.PlaceholderText = placeholder or "Type here..."
    textBox.Size = UDim2.new(1, 0, 1, 0)
    textBox.TextXAlignment = Enum.TextXAlignment.Left
    textBox.Parent = textBoxFrame
    
    ApplyTheme(textBox)
    
    textBox.FocusLost:Connect(function(enterPressed)
        if enterPressed and callback then
            callback(textBox.Text)
        end
    end)
    
    return textBox
end

function UILibrary.Window:AddDropdown(tab, text, options, callback)
    local dropdownFrame = Instance.new("Frame")
    dropdownFrame.Name = "Dropdown"
    dropdownFrame.Size = UDim2.new(1, -10, 0, 30)
    dropdownFrame.BackgroundTransparency = 1
    dropdownFrame.Parent = tab.Content
    
    local dropdownButton = Instance.new("TextButton")
    dropdownButton.Name = "Button"
    dropdownButton.Text = text or "Select an option"
    dropdownButton.Size = UDim2.new(1, 0, 1, 0)
    dropdownButton.TextXAlignment = Enum.TextXAlignment.Left
    dropdownButton.Parent = dropdownFrame
    
    ApplyTheme(dropdownButton, "Dropdown")
    
    local dropdownIcon = Instance.new("TextLabel")
    dropdownIcon.Name = "Icon"
    dropdownIcon.Text = "▼"
    dropdownIcon.Size = UDim2.new(0, 20, 1, 0)
    dropdownIcon.Position = UDim2.new(1, -20, 0, 0)
    dropdownIcon.Parent = dropdownButton
    
    ApplyTheme(dropdownIcon)
    
    local dropdownList = Instance.new("ScrollingFrame")
    dropdownList.Name = "List"
    dropdownList.Size = UDim2.new(1, 0, 0, 0)
    dropdownList.Position = UDim2.new(0, 0, 1, 5)
    dropdownList.Visible = false
    dropdownList.BackgroundTransparency = 0.05
    dropdownList.ScrollBarThickness = 5
    dropdownList.CanvasSize = UDim2.new(0, 0, 0, 0)
    dropdownList.Parent = dropdownFrame
    
    ApplyTheme(dropdownList, "Dropdown")
    
    local listLayout = Instance.new("UIListLayout")
    listLayout.Parent = dropdownList
    
    local isOpen = false
    local selectedOption = nil
    
    local function updateDropdown()
        if isOpen then
            dropdownList.Visible = true
            local itemCount = #options
            local height = math.min(itemCount * 30, 150)
            dropdownList.Size = UDim2.new(1, 0, 0, height)
            dropdownIcon.Text = "▲"
        else
            dropdownList.Visible = false
            dropdownList.Size = UDim2.new(1, 0, 0, 0)
            dropdownIcon.Text = "▼"
        end
    end
    
    local function selectOption(option)
        selectedOption = option
        dropdownButton.Text = option
        if callback then callback(option) end
        isOpen = false
        updateDropdown()
    end
    
    -- Create options
    for _, option in ipairs(options) do
        local optionButton = Instance.new("TextButton")
        optionButton.Name = option
        optionButton.Text = "  " .. option
        optionButton.Size = UDim2.new(1, 0, 0, 30)
        optionButton.TextXAlignment = Enum.TextXAlignment.Left
        optionButton.Parent = dropdownList
        
        ApplyTheme(optionButton, "Dropdown")
        
        optionButton.MouseButton1Click:Connect(function()
            selectOption(option)
        end)
        
        optionButton.MouseEnter:Connect(function()
            TweenService:Create(optionButton, TweenInfo.new(UILibrary.Config.AnimationSpeed), {
                BackgroundColor3 = UILibrary.Themes[UILibrary.Config.Theme].Highlight
            }):Play()
        end)
        
        optionButton.MouseLeave:Connect(function()
            TweenService:Create(optionButton, TweenInfo.new(UILibrary.Config.AnimationSpeed), {
                BackgroundColor3 = UILibrary.Themes[UILibrary.Config.Theme].Dropdown
            }):Play()
        end)
    end
    
    dropdownList.CanvasSize = UDim2.new(0, 0, 0, #options * 30)
    
    dropdownButton.MouseButton1Click:Connect(function()
        isOpen = not isOpen
        updateDropdown()
    end)
    
    return {
        SetOptions = function(self, newOptions)
            options = newOptions
            for _, child in ipairs(dropdownList:GetChildren()) do
                if child:IsA("TextButton") then
                    child:Destroy()
                end
            end
            
            for _, option in ipairs(newOptions) do
                local optionButton = Instance.new("TextButton")
                optionButton.Name = option
                optionButton.Text = "  " .. option
                optionButton.Size = UDim2.new(1, 0, 0, 30)
                optionButton.TextXAlignment = Enum.TextXAlignment.Left
                optionButton.Parent = dropdownList
                
                ApplyTheme(optionButton, "Dropdown")
                
                optionButton.MouseButton1Click:Connect(function()
                    selectOption(option)
                end)
            end
            
            dropdownList.CanvasSize = UDim2.new(0, 0, 0, #newOptions * 30)
        end,
        Select = function(self, option)
            if table.find(options, option) then
                selectOption(option)
            end
        end,
        GetSelected = function(self)
            return selectedOption
        end
    }
end

function UILibrary.Window:AddKeybind(tab, text, defaultKey, callback)
    local keybindFrame = Instance.new("Frame")
    keybindFrame.Name = "Keybind"
    keybindFrame.Size = UDim2.new(1, -10, 0, 30)
    keybindFrame.BackgroundTransparency = 1
    keybindFrame.Parent = tab.Content
    
    local keybindLabel = Instance.new("TextLabel")
    keybindLabel.Name = "Label"
    keybindLabel.Text = text or "Keybind"
    keybindLabel.Size = UDim2.new(0.7, 0, 1, 0)
    keybindLabel.TextXAlignment = Enum.TextXAlignment.Left
    keybindLabel.Parent = keybindFrame
    
    ApplyTheme(keybindLabel)
    
    local keybindButton = Instance.new("TextButton")
    keybindButton.Name = "Button"
    keybindButton.Text = defaultKey and defaultKey.Name or "None"
    keybindButton.Size = UDim2.new(0.3, 0, 1, 0)
    keybindButton.Position = UDim2.new(0.7, 0, 0, 0)
    keybindButton.Parent = keybindFrame
    
    ApplyTheme(keybindButton, "Secondary")
    
    local currentKey = defaultKey
    local isListening = false
    
    local function setKey(key)
        currentKey = key
        keybindButton.Text = key and key.Name or "None"
        if callback then callback(key) end
    end
    
    keybindButton.MouseButton1Click:Connect(function()
        isListening = true
        keybindButton.Text = "..."
    end)
    
    UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if isListening and not gameProcessed then
            if input.UserInputType == Enum.UserInputType.Keyboard then
                setKey(input.KeyCode)
            elseif input.UserInputType == Enum.UserInputType.MouseButton1 then
                setKey(Enum.KeyCode.MouseButton1)
            elseif input.UserInputType == Enum.UserInputType.MouseButton2 then
                setKey(Enum.KeyCode.MouseButton2)
            end
            isListening = false
        elseif currentKey and input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode == currentKey then
            if callback then callback(currentKey) end
        end
    end)
    
    return {
        SetKey = function(self, key)
            setKey(key)
        end,
        GetKey = function(self)
            return currentKey
        end
    }
end

function UILibrary.Window:AddColorPicker(tab, text, defaultColor, callback)
    local colorPickerFrame = Instance.new("Frame")
    colorPickerFrame.Name = "ColorPicker"
    colorPickerFrame.Size = UDim2.new(1, -10, 0, 150)
    colorPickerFrame.BackgroundTransparency = 1
    colorPickerFrame.Parent = tab.Content
    
    local colorPickerLabel = Instance.new("TextLabel")
    colorPickerLabel.Name = "Label"
    colorPickerLabel.Text = text or "Color Picker"
    colorPickerLabel.Size = UDim2.new(1, 0, 0, 20)
    colorPickerLabel.TextXAlignment = Enum.TextXAlignment.Left
    colorPickerLabel.Parent = colorPickerFrame
    
    ApplyTheme(colorPickerLabel)
    
    local colorPicker = Instance.new("ImageButton")
    colorPicker.Name = "Picker"
    colorPicker.Size = UDim2.new(0, 100, 0, 100)
    colorPicker.Position = UDim2.new(0, 0, 0, 25)
    colorPicker.Image = "rbxassetid://2615689005" -- Color wheel image
    colorPicker.Parent = colorPickerFrame
    
    ApplyTheme(colorPicker)
    
    local saturationPicker = Instance.new("Frame")
    saturationPicker.Name = "Saturation"
    saturationPicker.Size = UDim2.new(0, 20, 0, 100)
    saturationPicker.Position = UDim2.new(0, 110, 0, 25)
    saturationPicker.Parent = colorPickerFrame
    
    ApplyTheme(saturationPicker)
    
    local saturationGradient = Instance.new("UIGradient")
    saturationGradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.new(1, 1, 1)),
        ColorSequenceKeypoint.new(1, Color3.new(0, 0, 0))
    }
    saturationGradient.Rotation = 90
    saturationGradient.Parent = saturationPicker
    
    local colorPreview = Instance.new("Frame")
    colorPreview.Name = "Preview"
    colorPreview.Size = UDim2.new(0, 30, 0, 30)
    colorPreview.Position = UDim2.new(0, 140, 0, 25)
    colorPreview.Parent = colorPickerFrame
    
    ApplyTheme(colorPreview)
    
    local colorCode = Instance.new("TextLabel")
    colorCode.Name = "Code"
    colorCode.Text = "#FFFFFF"
    colorCode.Size = UDim2.new(0, 60, 0, 20)
    colorCode.Position = UDim2.new(0, 140, 0, 60)
    colorCode.TextXAlignment = Enum.TextXAlignment.Left
    colorCode.Parent = colorPickerFrame
    
    ApplyTheme(colorCode)
    
    local hue, saturation, value = 0, 1, 1
    local currentColor = defaultColor or Color3.new(1, 1, 1)
    
    local function updateColor(h, s, v)
        hue = math.clamp(h, 0, 1)
        saturation = math.clamp(s, 0, 1)
        value = math.clamp(v, 0, 1)
        currentColor = Color3.fromHSV(hue, saturation, value)
        colorPreview.BackgroundColor3 = currentColor
        colorCode.Text = "#" .. string.format("%02X%02X%02X", 
            math.floor(currentColor.r * 255), 
            math.floor(currentColor.g * 255), 
            math.floor(currentColor.b * 255))
        if callback then callback(currentColor) end
    end
    
    local function rgbToHsv(color)
        local r, g, b = color.r, color.g, color.b
        local max, min = math.max(r, g, b), math.min(r, g, b)
        local h, s, v
        
        v = max
        
        local d = max - min
        if max == 0 then s = 0 else s = d / max end
        
        if max == min then
            h = 0 -- achromatic
        else
            if max == r then
                h = (g - b) / d
                if g < b then h = h + 6 end
            elseif max == g then
                h = (b - r) / d + 2
            elseif max == b then
                h = (r - g) / d + 4
            end
            h = h / 6
        end
        
        return h, s, v
    end
    
    if defaultColor then
        local h, s, v = rgbToHsv(defaultColor)
        updateColor(h, s, v)
    end
    
    local colorPickerDragging = false
    local saturationDragging = false
    
    colorPicker.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            colorPickerDragging = true
        end
    end)
    
    colorPicker.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            colorPickerDragging = false
        end
    end)
    
    saturationPicker.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            saturationDragging = true
        end
    end)
    
    saturationPicker.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            saturationDragging = false
        end
    end)
    
    RunService.RenderStepped:Connect(function()
        if colorPickerDragging then
            local mousePos = UserInputService:GetMouseLocation()
            local relativePos = Vector2.new(
                (mousePos.X - colorPicker.AbsolutePosition.X) / colorPicker.AbsoluteSize.X,
                (mousePos.Y - colorPicker.AbsolutePosition.Y) / colorPicker.AbsoluteSize.Y
            )
            
            relativePos = Vector2.new(
                math.clamp(relativePos.X, 0, 1),
                math.clamp(relativePos.Y, 0, 1)
            )
            
            updateColor(relativePos.X, 1 - relativePos.Y, value)
        end
        
        if saturationDragging then
            local mousePos = UserInputService:GetMouseLocation()
            local relativePos = (mousePos.Y - saturationPicker.AbsolutePosition.Y) / saturationPicker.AbsoluteSize.Y
            relativePos = math.clamp(relativePos, 0, 1)
            updateColor(hue, saturation, 1 - relativePos)
        end
    end)
    
    return {
        SetColor = function(self, color)
            local h, s, v = rgbToHsv(color)
            updateColor(h, s, v)
        end,
        GetColor = function(self)
            return currentColor
        end
    }
end

return UILibrary
