-- Script Hub for Roblox Auto Farm
-- Created with tabs, sidebar, and example controls
-- Compatible with executors (Synapse, Script-Ware, ScriptHub, etc.)
-- 
-- Usage: Inject this script into any Roblox game
-- All settings are stored in getgenv().ScriptHubConfig
-- Access from other scripts: getgenv().ScriptHubConfig.Speed, etc.

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

-- Initialize getgenv if it doesn't exist (for storing config)
-- getgenv() is provided by executors (Synapse, Script-Ware, etc.), fallback to _G if not available
local env = _G
-- Runtime check for getgenv (executors provide this function)
local getgenvCheck = _G.getgenv or (function()
    local f = loadstring("return getgenv")
    return f and f()
end)()
if getgenvCheck and type(getgenvCheck) == "function" then
    local ok, result = pcall(getgenvCheck)
    if ok then
        env = result
    end
end

local ScriptHubConfig = env.ScriptHubConfig or {
    Speed = 5,
    FarmMode = "Normal",
    TargetName = "",
    AutoFarm = false,
    AutoCollect = false,
    AutoSell = false
}
env.ScriptHubConfig = ScriptHubConfig

-- Helper function to update both local and global config
local function updateConfig(key, value)
    ScriptHubConfig[key] = value
    env.ScriptHubConfig[key] = value
end

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Create main ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "ScriptHub"
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.Parent = playerGui

-- Main Frame
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 600, 0, 400)
mainFrame.Position = UDim2.new(0.5, -300, 0.5, -200)
mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui

-- Corner radius
local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 8)
mainCorner.Parent = mainFrame

-- Top Bar
local topBar = Instance.new("Frame")
topBar.Name = "TopBar"
topBar.Size = UDim2.new(1, 0, 0, 40)
topBar.Position = UDim2.new(0, 0, 0, 0)
topBar.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
topBar.BorderSizePixel = 0
topBar.Parent = mainFrame

local topBarCorner = Instance.new("UICorner")
topBarCorner.CornerRadius = UDim.new(0, 8)
topBarCorner.Parent = topBar

-- Top Bar Title
local title = Instance.new("TextLabel")
title.Name = "Title"
title.Size = UDim2.new(1, -20, 1, 0)
title.Position = UDim2.new(0, 10, 0, 0)
title.BackgroundTransparency = 1
title.Text = "Script Hub"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextSize = 18
title.Font = Enum.Font.GothamBold
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = topBar

-- Close Button
local closeButton = Instance.new("TextButton")
closeButton.Name = "CloseButton"
closeButton.Size = UDim2.new(0, 30, 0, 30)
closeButton.Position = UDim2.new(1, -35, 0, 5)
closeButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
closeButton.BorderSizePixel = 0
closeButton.Text = "X"
closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
closeButton.TextSize = 16
closeButton.Font = Enum.Font.GothamBold
closeButton.Parent = topBar

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 4)
closeCorner.Parent = closeButton

-- Vertical Line Separator
local verticalLine = Instance.new("Frame")
verticalLine.Name = "VerticalLine"
verticalLine.Size = UDim2.new(0, 2, 1, -40)
verticalLine.Position = UDim2.new(0, 150, 0, 40)
verticalLine.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
verticalLine.BorderSizePixel = 0
verticalLine.Parent = mainFrame

-- Sidebar
local sidebar = Instance.new("Frame")
sidebar.Name = "Sidebar"
sidebar.Size = UDim2.new(0, 150, 1, -40)
sidebar.Position = UDim2.new(0, 0, 0, 40)
sidebar.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
sidebar.BorderSizePixel = 0
sidebar.Parent = mainFrame

-- Content Area
local contentArea = Instance.new("ScrollingFrame")
contentArea.Name = "ContentArea"
contentArea.Size = UDim2.new(1, -152, 1, -40)
contentArea.Position = UDim2.new(0, 152, 0, 40)
contentArea.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
contentArea.BorderSizePixel = 0
contentArea.ScrollBarThickness = 6
contentArea.ScrollBarImageColor3 = Color3.fromRGB(100, 100, 100)
contentArea.CanvasSize = UDim2.new(0, 0, 0, 0)
contentArea.Parent = mainFrame

local contentList = Instance.new("UIListLayout")
contentList.Padding = UDim.new(0, 10)
contentList.SortOrder = Enum.SortOrder.LayoutOrder
contentList.Parent = contentArea

-- Tab System
local tabs = {}
local currentTab = nil

local function createTab(name, displayName)
    local tabButton = Instance.new("TextButton")
    tabButton.Name = name .. "Tab"
    tabButton.Size = UDim2.new(1, -10, 0, 40)
    tabButton.Position = UDim2.new(0, 5, 0, #tabs * 45 + 5)
    tabButton.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    tabButton.BorderSizePixel = 0
    tabButton.Text = displayName
    tabButton.TextColor3 = Color3.fromRGB(200, 200, 200)
    tabButton.TextSize = 14
    tabButton.Font = Enum.Font.Gotham
    tabButton.Parent = sidebar
    
    local tabCorner = Instance.new("UICorner")
    tabCorner.CornerRadius = UDim.new(0, 6)
    tabCorner.Parent = tabButton
    
    local tabFrame = Instance.new("Frame")
    tabFrame.Name = name .. "Content"
    tabFrame.Size = UDim2.new(1, 0, 0, 0)
    tabFrame.BackgroundTransparency = 1
    tabFrame.Visible = false
    tabFrame.Parent = contentArea
    
    local tabList = Instance.new("UIListLayout")
    tabList.Padding = UDim.new(0, 15)
    tabList.SortOrder = Enum.SortOrder.LayoutOrder
    tabList.Parent = tabFrame
    
    tabs[name] = {
        button = tabButton,
        frame = tabFrame,
        list = tabList
    }
    
    tabButton.MouseButton1Click:Connect(function()
        if currentTab then
            currentTab.button.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
            currentTab.button.TextColor3 = Color3.fromRGB(200, 200, 200)
            currentTab.frame.Visible = false
        end
        
        currentTab = tabs[name]
        currentTab.button.BackgroundColor3 = Color3.fromRGB(50, 100, 200)
        currentTab.button.TextColor3 = Color3.fromRGB(255, 255, 255)
        currentTab.frame.Visible = true
    end)
    
    return tabFrame
end

-- Create Tabs
local mainTab = createTab("Main", "Main")
local settingsTab = createTab("Settings", "Settings")

-- Set Main as default
currentTab = tabs["Main"]
tabs["Main"].button.BackgroundColor3 = Color3.fromRGB(50, 100, 200)
tabs["Main"].button.TextColor3 = Color3.fromRGB(255, 255, 255)
tabs["Main"].frame.Visible = true

-- Helper function to create sections
local function createSection(parent, title)
    local section = Instance.new("Frame")
    section.Name = title .. "Section"
    section.Size = UDim2.new(1, -20, 0, 0)
    section.Position = UDim2.new(0, 10, 0, 0)
    section.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    section.BorderSizePixel = 0
    section.Parent = parent
    
    local sectionCorner = Instance.new("UICorner")
    sectionCorner.CornerRadius = UDim.new(0, 6)
    sectionCorner.Parent = section
    
    local sectionTitle = Instance.new("TextLabel")
    sectionTitle.Name = "Title"
    sectionTitle.Size = UDim2.new(1, -20, 0, 30)
    sectionTitle.Position = UDim2.new(0, 10, 0, 5)
    sectionTitle.BackgroundTransparency = 1
    sectionTitle.Text = title
    sectionTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
    sectionTitle.TextSize = 16
    sectionTitle.Font = Enum.Font.GothamBold
    sectionTitle.TextXAlignment = Enum.TextXAlignment.Left
    sectionTitle.Parent = section
    
    local sectionList = Instance.new("UIListLayout")
    sectionList.Padding = UDim.new(0, 10)
    sectionList.SortOrder = Enum.SortOrder.LayoutOrder
    sectionList.Parent = section
    
    sectionList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        section.Size = UDim2.new(1, -20, 0, sectionList.AbsoluteContentSize.Y + 20)
    end)
    
    return section
end

-- Helper function to create slider
local function createSlider(parent, name, min, max, default, callback)
    local sliderFrame = Instance.new("Frame")
    sliderFrame.Name = name .. "Slider"
    sliderFrame.Size = UDim2.new(1, -20, 0, 60)
    sliderFrame.Position = UDim2.new(0, 10, 0, 0)
    sliderFrame.BackgroundTransparency = 1
    sliderFrame.Parent = parent
    
    local sliderLabel = Instance.new("TextLabel")
    sliderLabel.Name = "Label"
    sliderLabel.Size = UDim2.new(1, 0, 0, 20)
    sliderLabel.Position = UDim2.new(0, 0, 0, 0)
    sliderLabel.BackgroundTransparency = 1
    sliderLabel.Text = name .. ": " .. default
    sliderLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    sliderLabel.TextSize = 14
    sliderLabel.Font = Enum.Font.Gotham
    sliderLabel.TextXAlignment = Enum.TextXAlignment.Left
    sliderLabel.Parent = sliderFrame
    
    local sliderTrack = Instance.new("Frame")
    sliderTrack.Name = "Track"
    sliderTrack.Size = UDim2.new(1, 0, 0, 6)
    sliderTrack.Position = UDim2.new(0, 0, 0, 30)
    sliderTrack.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    sliderTrack.BorderSizePixel = 0
    sliderTrack.Parent = sliderFrame
    
    local sliderTrackCorner = Instance.new("UICorner")
    sliderTrackCorner.CornerRadius = UDim.new(0, 3)
    sliderTrackCorner.Parent = sliderTrack
    
    local sliderFill = Instance.new("Frame")
    sliderFill.Name = "Fill"
    sliderFill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
    sliderFill.Position = UDim2.new(0, 0, 0, 0)
    sliderFill.BackgroundColor3 = Color3.fromRGB(50, 100, 200)
    sliderFill.BorderSizePixel = 0
    sliderFill.Parent = sliderTrack
    
    local sliderFillCorner = Instance.new("UICorner")
    sliderFillCorner.CornerRadius = UDim.new(0, 3)
    sliderFillCorner.Parent = sliderFill
    
    local sliderButton = Instance.new("TextButton")
    sliderButton.Name = "Button"
    sliderButton.Size = UDim2.new(0, 20, 0, 20)
    sliderButton.Position = UDim2.new((default - min) / (max - min), -10, 0.5, -10)
    sliderButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    sliderButton.BorderSizePixel = 0
    sliderButton.Text = ""
    sliderButton.Parent = sliderTrack
    
    local sliderButtonCorner = Instance.new("UICorner")
    sliderButtonCorner.CornerRadius = UDim.new(0, 10)
    sliderButtonCorner.Parent = sliderButton
    
    local dragging = false
    local currentValue = default
    
    sliderButton.MouseButton1Down:Connect(function()
        dragging = true
    end)
    
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local mousePos = UserInputService:GetMouseLocation()
            local trackPos = sliderTrack.AbsolutePosition
            local trackSize = sliderTrack.AbsoluteSize
            local relativeX = math.clamp((mousePos.X - trackPos.X) / trackSize.X, 0, 1)
            currentValue = math.floor(min + (max - min) * relativeX)
            
            sliderFill.Size = UDim2.new(relativeX, 0, 1, 0)
            sliderButton.Position = UDim2.new(relativeX, -10, 0.5, -10)
            sliderLabel.Text = name .. ": " .. currentValue
            
            if callback then
                callback(currentValue)
            end
        end
    end)
    
    return sliderFrame
end

-- Helper function to create multi-option (checkboxes)
local function createMultiOption(parent, name, options, callback)
    local optionFrame = Instance.new("Frame")
    optionFrame.Name = name .. "MultiOption"
    optionFrame.Size = UDim2.new(1, -20, 0, 0)
    optionFrame.Position = UDim2.new(0, 10, 0, 0)
    optionFrame.BackgroundTransparency = 1
    optionFrame.Parent = parent
    
    local optionLabel = Instance.new("TextLabel")
    optionLabel.Name = "Label"
    optionLabel.Size = UDim2.new(1, 0, 0, 20)
    optionLabel.Position = UDim2.new(0, 0, 0, 0)
    optionLabel.BackgroundTransparency = 1
    optionLabel.Text = name
    optionLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    optionLabel.TextSize = 14
    optionLabel.Font = Enum.Font.GothamBold
    optionLabel.TextXAlignment = Enum.TextXAlignment.Left
    optionLabel.Parent = optionFrame
    
    local optionList = Instance.new("UIListLayout")
    optionList.Padding = UDim.new(0, 8)
    optionList.SortOrder = Enum.SortOrder.LayoutOrder
    optionList.Parent = optionFrame
    
    local selectedOptions = {}
    
    for i, option in ipairs(options) do
        local checkboxFrame = Instance.new("Frame")
        checkboxFrame.Name = option .. "Checkbox"
        checkboxFrame.Size = UDim2.new(1, 0, 0, 25)
        checkboxFrame.Position = UDim2.new(0, 0, 0, 25 + (i - 1) * 33)
        checkboxFrame.BackgroundTransparency = 1
        checkboxFrame.Parent = optionFrame
        
        local checkbox = Instance.new("TextButton")
        checkbox.Name = "Checkbox"
        checkbox.Size = UDim2.new(0, 20, 0, 20)
        checkbox.Position = UDim2.new(0, 0, 0, 2.5)
        checkbox.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        checkbox.BorderSizePixel = 2
        checkbox.BorderColor3 = Color3.fromRGB(100, 100, 100)
        checkbox.Text = ""
        checkbox.Parent = checkboxFrame
        
        local checkboxCorner = Instance.new("UICorner")
        checkboxCorner.CornerRadius = UDim.new(0, 4)
        checkboxCorner.Parent = checkbox
        
        local checkboxLabel = Instance.new("TextLabel")
        checkboxLabel.Name = "Label"
        checkboxLabel.Size = UDim2.new(1, -30, 1, 0)
        checkboxLabel.Position = UDim2.new(0, 30, 0, 0)
        checkboxLabel.BackgroundTransparency = 1
        checkboxLabel.Text = option
        checkboxLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        checkboxLabel.TextSize = 12
        checkboxLabel.Font = Enum.Font.Gotham
        checkboxLabel.TextXAlignment = Enum.TextXAlignment.Left
        checkboxLabel.Parent = checkboxFrame
        
        checkbox.MouseButton1Click:Connect(function()
            selectedOptions[option] = not selectedOptions[option]
            if selectedOptions[option] then
                checkbox.BackgroundColor3 = Color3.fromRGB(50, 100, 200)
                checkbox.BorderColor3 = Color3.fromRGB(50, 100, 200)
            else
                checkbox.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
                checkbox.BorderColor3 = Color3.fromRGB(100, 100, 100)
            end
            
            if callback then
                callback(selectedOptions)
            end
        end)
    end
    
    optionList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        optionFrame.Size = UDim2.new(1, -20, 0, optionList.AbsoluteContentSize.Y + 25)
    end)
    
    return optionFrame
end

-- Helper function to create select (dropdown)
local function createSelect(parent, name, options, default, callback)
    local selectFrame = Instance.new("Frame")
    selectFrame.Name = name .. "Select"
    selectFrame.Size = UDim2.new(1, -20, 0, 35)
    selectFrame.Position = UDim2.new(0, 10, 0, 0)
    selectFrame.BackgroundTransparency = 1
    selectFrame.Parent = parent
    
    local selectLabel = Instance.new("TextLabel")
    selectLabel.Name = "Label"
    selectLabel.Size = UDim2.new(1, 0, 0, 20)
    selectLabel.Position = UDim2.new(0, 0, 0, 0)
    selectLabel.BackgroundTransparency = 1
    selectLabel.Text = name
    selectLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    selectLabel.TextSize = 14
    selectLabel.Font = Enum.Font.GothamBold
    selectLabel.TextXAlignment = Enum.TextXAlignment.Left
    selectLabel.Parent = selectFrame
    
    local selectButton = Instance.new("TextButton")
    selectButton.Name = "Button"
    selectButton.Size = UDim2.new(1, 0, 0, 30)
    selectButton.Position = UDim2.new(0, 0, 0, 20)
    selectButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    selectButton.BorderSizePixel = 0
    selectButton.Text = default or "Select..."
    selectButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    selectButton.TextSize = 12
    selectButton.Font = Enum.Font.Gotham
    selectButton.Parent = selectFrame
    
    local selectCorner = Instance.new("UICorner")
    selectCorner.CornerRadius = UDim.new(0, 4)
    selectCorner.Parent = selectButton
    
    local dropdown = Instance.new("Frame")
    dropdown.Name = "Dropdown"
    dropdown.Size = UDim2.new(1, 0, 0, 0)
    dropdown.Position = UDim2.new(0, 0, 0, 50)
    dropdown.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    dropdown.BorderSizePixel = 0
    dropdown.Visible = false
    dropdown.Parent = selectFrame
    
    local dropdownCorner = Instance.new("UICorner")
    dropdownCorner.CornerRadius = UDim.new(0, 4)
    dropdownCorner.Parent = dropdown
    
    local dropdownList = Instance.new("UIListLayout")
    dropdownList.Padding = UDim.new(0, 2)
    dropdownList.SortOrder = Enum.SortOrder.LayoutOrder
    dropdownList.Parent = dropdown
    
    local isOpen = false
    
    for i, option in ipairs(options) do
        local optionButton = Instance.new("TextButton")
        optionButton.Name = option
        optionButton.Size = UDim2.new(1, -10, 0, 25)
        optionButton.Position = UDim2.new(0, 5, 0, (i - 1) * 27)
        optionButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        optionButton.BorderSizePixel = 0
        optionButton.Text = option
        optionButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        optionButton.TextSize = 12
        optionButton.Font = Enum.Font.Gotham
        optionButton.Parent = dropdown
        
        optionButton.MouseButton1Click:Connect(function()
            selectButton.Text = option
            dropdown.Visible = false
            isOpen = false
            if callback then
                callback(option)
            end
        end)
    end
    
    dropdownList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        dropdown.Size = UDim2.new(1, 0, 0, dropdownList.AbsoluteContentSize.Y + 10)
    end)
    
    selectButton.MouseButton1Click:Connect(function()
        isOpen = not isOpen
        dropdown.Visible = isOpen
    end)
    
    return selectFrame
end

-- Helper function to create text input
local function createTextInput(parent, name, placeholder, callback)
    local textFrame = Instance.new("Frame")
    textFrame.Name = name .. "TextInput"
    textFrame.Size = UDim2.new(1, -20, 0, 50)
    textFrame.Position = UDim2.new(0, 10, 0, 0)
    textFrame.BackgroundTransparency = 1
    textFrame.Parent = parent
    
    local textLabel = Instance.new("TextLabel")
    textLabel.Name = "Label"
    textLabel.Size = UDim2.new(1, 0, 0, 20)
    textLabel.Position = UDim2.new(0, 0, 0, 0)
    textLabel.BackgroundTransparency = 1
    textLabel.Text = name
    textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    textLabel.TextSize = 14
    textLabel.Font = Enum.Font.GothamBold
    textLabel.TextXAlignment = Enum.TextXAlignment.Left
    textLabel.Parent = textFrame
    
    local textBox = Instance.new("TextBox")
    textBox.Name = "TextBox"
    textBox.Size = UDim2.new(1, 0, 0, 30)
    textBox.Position = UDim2.new(0, 0, 0, 20)
    textBox.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    textBox.BorderSizePixel = 0
    textBox.Text = ""
    textBox.PlaceholderText = placeholder or "Enter text..."
    textBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    textBox.PlaceholderColor3 = Color3.fromRGB(150, 150, 150)
    textBox.TextSize = 12
    textBox.Font = Enum.Font.Gotham
    textBox.ClearTextOnFocus = false
    textBox.Parent = textFrame
    
    local textCorner = Instance.new("UICorner")
    textCorner.CornerRadius = UDim.new(0, 4)
    textCorner.Parent = textBox
    
    textBox.FocusLost:Connect(function(enterPressed)
        if callback then
            callback(textBox.Text, enterPressed)
        end
    end)
    
    return textFrame
end

-- Helper function to create button
local function createButton(parent, name, callback)
    local button = Instance.new("TextButton")
    button.Name = name .. "Button"
    button.Size = UDim2.new(1, -20, 0, 35)
    button.Position = UDim2.new(0, 10, 0, 0)
    button.BackgroundColor3 = Color3.fromRGB(50, 100, 200)
    button.BorderSizePixel = 0
    button.Text = name
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.TextSize = 14
    button.Font = Enum.Font.GothamBold
    button.Parent = parent
    
    local buttonCorner = Instance.new("UICorner")
    buttonCorner.CornerRadius = UDim.new(0, 6)
    buttonCorner.Parent = button
    
    button.MouseButton1Click:Connect(function()
        if callback then
            callback()
        end
    end)
    
    button.MouseEnter:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(60, 120, 220)}):Play()
    end)
    
    button.MouseLeave:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(50, 100, 200)}):Play()
    end)
    
    return button
end

-- Update content area size
contentList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    contentArea.CanvasSize = UDim2.new(0, 0, 0, contentList.AbsoluteContentSize.Y + 20)
end)

-- Add example controls to Main tab
local mainSection = createSection(mainTab, "Example Controls")

createSlider(mainSection, "Example Slider", 0, 100, 50, function(value)
    updateConfig("ExampleSlider", value)
    print("Slider value:", value)
end)

createMultiOption(mainSection, "Example Multi Options", {"Option 1", "Option 2", "Option 3", "Option 4"}, function(selected)
    updateConfig("ExampleMultiOptions", selected)
    print("Selected options:", selected)
end)

createSelect(mainSection, "Example Select", {"Option A", "Option B", "Option C", "Option D"}, "Option A", function(selected)
    updateConfig("ExampleSelect", selected)
    print("Selected:", selected)
end)

createTextInput(mainSection, "Example Text", "Enter text here...", function(text, enterPressed)
    updateConfig("ExampleText", text)
    print("Text entered:", text)
end)

createButton(mainSection, "Example Button", function()
    print("Button clicked!")
    -- Add your auto farm logic here
    -- Example: getgenv().ScriptHubConfig.AutoFarm = true
end)

-- Add example controls to Settings tab
local settingsSection = createSection(settingsTab, "Settings")

createSlider(settingsSection, "Speed", 1, 10, 5, function(value)
    updateConfig("Speed", value)
    print("Speed set to:", value)
end)

createMultiOption(settingsSection, "Features", {"Auto Farm", "Auto Collect", "Auto Sell"}, function(selected)
    updateConfig("Features", selected)
    -- Store individual feature states for easy access
    updateConfig("AutoFarm", selected["Auto Farm"] or false)
    updateConfig("AutoCollect", selected["Auto Collect"] or false)
    updateConfig("AutoSell", selected["Auto Sell"] or false)
    print("Features:", selected)
end)

createSelect(settingsSection, "Farm Mode", {"Normal", "Fast", "Ultra"}, "Normal", function(selected)
    updateConfig("FarmMode", selected)
    print("Farm mode:", selected)
end)

createTextInput(settingsSection, "Target Name", "Enter target name...", function(text, enterPressed)
    updateConfig("TargetName", text)
    print("Target:", text)
end)

createButton(settingsSection, "Save Settings", function()
    print("Settings saved!")
    -- Settings are automatically saved to getgenv().ScriptHubConfig
    -- Other scripts can access them like: getgenv().ScriptHubConfig.Speed
end)

-- Close button functionality
closeButton.MouseButton1Click:Connect(function()
    screenGui:Destroy()
end)

-- Make window draggable
local dragging = false
local dragStart = nil
local startPos = nil

topBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = mainFrame.Position
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

print("Script Hub loaded successfully!")

