--[[
    UILibrary - A Roblox UI Library for Executors
    Compatible with Synapse, Script-Ware, ScriptHub, and other executors
    
    Features:
    - Modern, customizable UI components
    - Tab system with sidebar
    - Sliders, checkboxes, dropdowns, text inputs, buttons
    - Draggable windows
    - Easy to use API
    
    Usage:
        local UI = loadstring(game:HttpGet("YOUR_URL/UILibrary.lua"))()
        local window = UI:CreateWindow("My Script Hub", 600, 400)
        local tab = window:CreateTab("Main", "Main")
        local section = tab:CreateSection("My Section")
        section:AddSlider("Speed", 1, 10, 5, function(value) print(value) end)
]]

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local UILibrary = {}
UILibrary.__index = UILibrary

-- Window class
local Window = {}
Window.__index = Window

-- Tab class
local Tab = {}
Tab.__index = Tab

-- Section class
local Section = {}
Section.__index = Section

-- Create a new window
function UILibrary:CreateWindow(title, width, height)
    width = width or 600
    height = height or 400
    
    local player = Players.LocalPlayer
    local playerGui = player:WaitForChild("PlayerGui")
    
    -- Create main ScreenGui
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "UILibraryWindow"
    screenGui.ResetOnSpawn = false
    screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    screenGui.Parent = playerGui
    
    -- Main Frame
    local mainFrame = Instance.new("Frame")
    mainFrame.Name = "MainFrame"
    mainFrame.Size = UDim2.new(0, width, 0, height)
    mainFrame.Position = UDim2.new(0.5, -width/2, 0.5, -height/2)
    mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    mainFrame.BackgroundTransparency = 0.3
    mainFrame.BorderSizePixel = 0
    mainFrame.Parent = screenGui
    
    local mainCorner = Instance.new("UICorner")
    mainCorner.CornerRadius = UDim.new(0, 8)
    mainCorner.Parent = mainFrame
    
    -- Top Bar
    local topBar = Instance.new("Frame")
    topBar.Name = "TopBar"
    topBar.Size = UDim2.new(1, 0, 0, 40)
    topBar.Position = UDim2.new(0, 0, 0, 0)
    topBar.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    topBar.BackgroundTransparency = 0.2
    topBar.BorderSizePixel = 0
    topBar.Parent = mainFrame
    
    local topBarCorner = Instance.new("UICorner")
    topBarCorner.CornerRadius = UDim.new(0, 8)
    topBarCorner.Parent = topBar
    
    -- Top Bar Title
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Name = "Title"
    titleLabel.Size = UDim2.new(1, -20, 1, 0)
    titleLabel.Position = UDim2.new(0, 10, 0, 0)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = title or "UI Library"
    titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleLabel.TextSize = 18
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.Parent = topBar
    
    -- Minimize Button
    local minimizeButton = Instance.new("TextButton")
    minimizeButton.Name = "MinimizeButton"
    minimizeButton.Size = UDim2.new(0, 30, 0, 30)
    minimizeButton.Position = UDim2.new(1, -70, 0, 5)
    minimizeButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
    minimizeButton.BorderSizePixel = 0
    minimizeButton.Text = "_"
    minimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    minimizeButton.TextSize = 16
    minimizeButton.Font = Enum.Font.GothamBold
    minimizeButton.Parent = topBar
    
    local minimizeCorner = Instance.new("UICorner")
    minimizeCorner.CornerRadius = UDim.new(0, 4)
    minimizeCorner.Parent = minimizeButton
    
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
    
    -- Horizontal Line Separator (on top)
    local horizontalLine = Instance.new("Frame")
    horizontalLine.Name = "HorizontalLine"
    horizontalLine.Size = UDim2.new(1, 0, 0, 2)
    horizontalLine.Position = UDim2.new(0, 0, 0, 40)
    horizontalLine.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    horizontalLine.BorderSizePixel = 0
    horizontalLine.Parent = mainFrame
    
    -- Vertical Line Separator (between sidebar and content)
    local verticalLine = Instance.new("Frame")
    verticalLine.Name = "VerticalLine"
    verticalLine.Size = UDim2.new(0, 2, 1, -42)
    verticalLine.Position = UDim2.new(0, 150, 0, 42)
    verticalLine.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    verticalLine.BorderSizePixel = 0
    verticalLine.Parent = mainFrame
    
    -- Sidebar
    local sidebar = Instance.new("Frame")
    sidebar.Name = "Sidebar"
    sidebar.Size = UDim2.new(0, 150, 1, -42)
    sidebar.Position = UDim2.new(0, 0, 0, 42)
    sidebar.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    sidebar.BackgroundTransparency = 0.3
    sidebar.BorderSizePixel = 0
    sidebar.Parent = mainFrame
    
    -- Content Area
    local contentArea = Instance.new("ScrollingFrame")
    contentArea.Name = "ContentArea"
    contentArea.Size = UDim2.new(1, -152, 1, -42)
    contentArea.Position = UDim2.new(0, 152, 0, 42)
    contentArea.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    contentArea.BackgroundTransparency = 0.3
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
    
    -- Update content area size
    contentList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        contentArea.CanvasSize = UDim2.new(0, 0, 0, contentList.AbsoluteContentSize.Y + 20)
    end)
    
    -- Close button functionality
    closeButton.MouseButton1Click:Connect(function()
        screenGui:Destroy()
    end)
    
    -- Minimize/Maximize functionality
    local isMinimized = false
    local originalSize = mainFrame.Size
    
    local function minimizeWindow()
        isMinimized = true
        originalSize = mainFrame.Size
        
        -- Hide everything except top bar
        sidebar.Visible = false
        contentArea.Visible = false
        if horizontalLine then horizontalLine.Visible = false end
        if verticalLine then verticalLine.Visible = false end
        
        -- Resize window to only show top bar
        mainFrame.Size = UDim2.new(0, width, 0, 40)
    end
    
    local function maximizeWindow()
        isMinimized = false
        
        -- Show everything again
        sidebar.Visible = true
        contentArea.Visible = true
        if horizontalLine then horizontalLine.Visible = true end
        if verticalLine then verticalLine.Visible = true end
        
        -- Restore original size
        mainFrame.Size = originalSize
    end
    
    minimizeButton.MouseButton1Click:Connect(function()
        if isMinimized then
            maximizeWindow()
        else
            minimizeWindow()
        end
    end)
    
    -- Notification system
    local notificationContainer = Instance.new("Frame")
    notificationContainer.Name = "NotificationContainer"
    notificationContainer.Size = UDim2.new(0, 300, 1, 0)
    notificationContainer.Position = UDim2.new(1, -320, 0, 10)
    notificationContainer.BackgroundTransparency = 1
    notificationContainer.Parent = screenGui
    
    local notificationList = Instance.new("UIListLayout")
    notificationList.Padding = UDim.new(0, 10)
    notificationList.SortOrder = Enum.SortOrder.LayoutOrder
    notificationList.HorizontalAlignment = Enum.HorizontalAlignment.Right
    notificationList.VerticalAlignment = Enum.VerticalAlignment.Top
    notificationList.Parent = notificationContainer
    
    local function showNotification(message, notifType, duration)
        notifType = notifType or "info"
        duration = duration or 3
        
        local colors = {
            info = Color3.fromRGB(50, 100, 200),
            success = Color3.fromRGB(50, 200, 50),
            warning = Color3.fromRGB(200, 150, 50),
            error = Color3.fromRGB(200, 50, 50)
        }
        
        local notification = Instance.new("Frame")
        notification.Name = "Notification"
        notification.Size = UDim2.new(0, 300, 0, 0)
        notification.Position = UDim2.new(0, 0, 0, 0)
        notification.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        notification.BorderSizePixel = 0
        notification.Parent = notificationContainer
        
        local notifCorner = Instance.new("UICorner")
        notifCorner.CornerRadius = UDim.new(0, 6)
        notifCorner.Parent = notification
        
        local notifAccent = Instance.new("Frame")
        notifAccent.Name = "Accent"
        notifAccent.Size = UDim2.new(0, 4, 1, 0)
        notifAccent.Position = UDim2.new(0, 0, 0, 0)
        notifAccent.BackgroundColor3 = colors[notifType] or colors.info
        notifAccent.BorderSizePixel = 0
        notifAccent.Parent = notification
        
        local notifAccentCorner = Instance.new("UICorner")
        notifAccentCorner.CornerRadius = UDim.new(0, 6)
        notifAccentCorner.Parent = notifAccent
        
        local notifText = Instance.new("TextLabel")
        notifText.Name = "Text"
        notifText.Size = UDim2.new(1, -20, 0, 0)
        notifText.Position = UDim2.new(0, 10, 0, 10)
        notifText.BackgroundTransparency = 1
        notifText.Text = message
        notifText.TextColor3 = Color3.fromRGB(255, 255, 255)
        notifText.TextSize = 12
        notifText.Font = Enum.Font.Gotham
        notifText.TextWrapped = true
        notifText.TextXAlignment = Enum.TextXAlignment.Left
        notifText.Parent = notification
        
        local textSize = game:GetService("TextService"):GetTextSize(message, 12, Enum.Font.Gotham, Vector2.new(280, 1000))
        notification.Size = UDim2.new(0, 300, 0, textSize.Y + 20)
        
        notification.BackgroundTransparency = 1
        TweenService:Create(notification, TweenInfo.new(0.3), {BackgroundTransparency = 0}):Play()
        
        task.wait(duration)
        
        TweenService:Create(notification, TweenInfo.new(0.3), {BackgroundTransparency = 1, Size = UDim2.new(0, 300, 0, 0)}):Play()
        task.wait(0.3)
        notification:Destroy()
    end
    
    local window = setmetatable({
        _screenGui = screenGui,
        _mainFrame = mainFrame,
        _sidebar = sidebar,
        _contentArea = contentArea,
        _tabs = tabs,
        _currentTab = currentTab,
        _contentList = contentList,
        _horizontalLine = horizontalLine,
        _verticalLine = verticalLine,
        _isMinimized = false,
        _minimize = minimizeWindow,
        _maximize = maximizeWindow,
        _showNotification = showNotification
    }, Window)
    
    return window
end

-- Minimize window
function Window:Minimize()
    if self._minimize then
        self._minimize()
        self._isMinimized = true
    end
end

-- Maximize window
function Window:Maximize()
    if self._maximize then
        self._maximize()
        self._isMinimized = false
    end
end

-- Show notification
function Window:ShowNotification(message, notifType, duration)
    if self._showNotification then
        self._showNotification(message, notifType, duration)
    end
end

-- Create a tab
function Window:CreateTab(name, displayName)
    displayName = displayName or name
    
    local tabs = self._tabs
    local sidebar = self._sidebar
    local contentArea = self._contentArea
    local currentTab = self._currentTab
    
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
    
    local tabData = {
        button = tabButton,
        frame = tabFrame,
        list = tabList,
        indicator = indicatorLine
    }
    
    tabs[name] = tabData
    
    tabButton.MouseButton1Click:Connect(function()
        if self._currentTab then
            self._currentTab.button.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
            self._currentTab.button.TextColor3 = Color3.fromRGB(200, 200, 200)
            self._currentTab.frame.Visible = false
            if self._currentTab.indicator then
                self._currentTab.indicator.Visible = false
            end
        end
        
        self._currentTab = tabData
        tabData.button.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
        tabData.button.TextColor3 = Color3.fromRGB(255, 255, 255)
        tabData.frame.Visible = true
        if tabData.indicator then
            tabData.indicator.Visible = true
        end
    end)
    
    -- Set as default if first tab
    if tabCount == 0 then
        self._currentTab = tabData
        tabData.button.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
        tabData.button.TextColor3 = Color3.fromRGB(255, 255, 255)
        tabData.frame.Visible = true
        if tabData.indicator then
            tabData.indicator.Visible = true
        end
    end
    
    local tab = setmetatable({
        _frame = tabFrame,
        _list = tabList
    }, Tab)
    
    return tab
end

-- Create announcement tab
function Window:CreateAnnouncementTab(name, displayName)
    displayName = displayName or name
    
    local tabs = self._tabs
    local sidebar = self._sidebar
    local contentArea = self._contentArea
    local currentTab = self._currentTab
    
    -- Count existing tabs
    local tabCount = 0
    for _ in pairs(tabs) do
        tabCount = tabCount + 1
    end
    
    local tabButton = Instance.new("TextButton")
    tabButton.Name = name .. "Tab"
    tabButton.Size = UDim2.new(1, -10, 0, 40)
    tabButton.Position = UDim2.new(0, 5, 0, tabCount * 45 + 5)
    tabButton.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    tabButton.BackgroundTransparency = 0.3
    tabButton.BorderSizePixel = 0
    tabButton.Text = displayName
    tabButton.TextColor3 = Color3.fromRGB(200, 200, 200)
    tabButton.TextSize = 14
    tabButton.Font = Enum.Font.Gotham
    tabButton.Parent = sidebar
    
    local tabCorner = Instance.new("UICorner")
    tabCorner.CornerRadius = UDim.new(0, 6)
    tabCorner.Parent = tabButton
    
    -- Purple line indicator for selected tab
    local indicatorLine = Instance.new("Frame")
    indicatorLine.Name = "Indicator"
    indicatorLine.Size = UDim2.new(0, 3, 1, -10)
    indicatorLine.Position = UDim2.new(0, 0, 0, 5)
    indicatorLine.BackgroundColor3 = Color3.fromRGB(138, 43, 226) -- Purple
    indicatorLine.BorderSizePixel = 0
    indicatorLine.Visible = false
    indicatorLine.Parent = tabButton
    
    local indicatorCorner = Instance.new("UICorner")
    indicatorCorner.CornerRadius = UDim.new(0, 2)
    indicatorCorner.Parent = indicatorLine
    
    local tabFrame = Instance.new("Frame")
    tabFrame.Name = name .. "Content"
    tabFrame.Size = UDim2.new(1, 0, 1, 0)
    tabFrame.BackgroundTransparency = 1
    tabFrame.Visible = false
    tabFrame.Parent = contentArea
    
    -- Announcement scrollable area
    local announcementScroll = Instance.new("ScrollingFrame")
    announcementScroll.Name = "AnnouncementScroll"
    announcementScroll.Size = UDim2.new(1, -20, 1, -20)
    announcementScroll.Position = UDim2.new(0, 10, 0, 10)
    announcementScroll.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    announcementScroll.BackgroundTransparency = 0.3
    announcementScroll.BorderSizePixel = 0
    announcementScroll.ScrollBarThickness = 6
    announcementScroll.ScrollBarImageColor3 = Color3.fromRGB(100, 100, 100)
    announcementScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
    announcementScroll.Parent = tabFrame
    
    local announcementCorner = Instance.new("UICorner")
    announcementCorner.CornerRadius = UDim.new(0, 6)
    announcementCorner.Parent = announcementScroll
    
    local announcementList = Instance.new("UIListLayout")
    announcementList.Padding = UDim.new(0, 15)
    announcementList.SortOrder = Enum.SortOrder.LayoutOrder
    announcementList.Parent = announcementScroll
    
    announcementList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        announcementScroll.CanvasSize = UDim2.new(0, 0, 0, announcementList.AbsoluteContentSize.Y + 20)
    end)
    
    local tabData = {
        button = tabButton,
        frame = tabFrame,
        scroll = announcementScroll,
        list = announcementList,
        indicator = indicatorLine
    }
    
    tabs[name] = tabData
    
    tabButton.MouseButton1Click:Connect(function()
        if self._currentTab then
            self._currentTab.button.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
            self._currentTab.button.TextColor3 = Color3.fromRGB(200, 200, 200)
            self._currentTab.frame.Visible = false
            if self._currentTab.indicator then
                self._currentTab.indicator.Visible = false
            end
        end
        
        self._currentTab = tabData
        tabData.button.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
        tabData.button.TextColor3 = Color3.fromRGB(255, 255, 255)
        tabData.frame.Visible = true
        if tabData.indicator then
            tabData.indicator.Visible = true
        end
    end)
    
    -- Set as default if first tab
    if tabCount == 0 then
        self._currentTab = tabData
        tabData.button.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
        tabData.button.TextColor3 = Color3.fromRGB(255, 255, 255)
        tabData.frame.Visible = true
        if tabData.indicator then
            tabData.indicator.Visible = true
        end
    end
    
    local announcementTab = setmetatable({
        _frame = tabFrame,
        _scroll = announcementScroll,
        _list = announcementList,
        AddAnnouncement = function(self, title, content, date)
            local announcementFrame = Instance.new("Frame")
            announcementFrame.Name = "Announcement"
            announcementFrame.Size = UDim2.new(1, -20, 0, 0)
            announcementFrame.Position = UDim2.new(0, 10, 0, 0)
            announcementFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            announcementFrame.BackgroundTransparency = 0.3
            announcementFrame.BorderSizePixel = 0
            announcementFrame.Parent = self._scroll
            
            local announcementCorner = Instance.new("UICorner")
            announcementCorner.CornerRadius = UDim.new(0, 6)
            announcementCorner.Parent = announcementFrame
            
            local announcementTitle = Instance.new("TextLabel")
            announcementTitle.Name = "Title"
            announcementTitle.Size = UDim2.new(1, -20, 0, 30)
            announcementTitle.Position = UDim2.new(0, 10, 0, 10)
            announcementTitle.BackgroundTransparency = 1
            announcementTitle.Text = title or "Announcement"
            announcementTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
            announcementTitle.TextSize = 16
            announcementTitle.Font = Enum.Font.GothamBold
            announcementTitle.TextXAlignment = Enum.TextXAlignment.Left
            announcementTitle.Parent = announcementFrame
            
            local announcementDate = Instance.new("TextLabel")
            announcementDate.Name = "Date"
            announcementDate.Size = UDim2.new(1, -20, 0, 20)
            announcementDate.Position = UDim2.new(0, 10, 0, 40)
            announcementDate.BackgroundTransparency = 1
            announcementDate.Text = date or ""
            announcementDate.TextColor3 = Color3.fromRGB(150, 150, 150)
            announcementDate.TextSize = 12
            announcementDate.Font = Enum.Font.Gotham
            announcementDate.TextXAlignment = Enum.TextXAlignment.Left
            announcementDate.Parent = announcementFrame
            
            local announcementContent = Instance.new("TextLabel")
            announcementContent.Name = "Content"
            announcementContent.Size = UDim2.new(1, -20, 0, 0)
            announcementContent.Position = UDim2.new(0, 10, 0, 65)
            announcementContent.BackgroundTransparency = 1
            announcementContent.Text = content or ""
            announcementContent.TextColor3 = Color3.fromRGB(200, 200, 200)
            announcementContent.TextSize = 14
            announcementContent.Font = Enum.Font.Gotham
            announcementContent.TextXAlignment = Enum.TextXAlignment.Left
            announcementContent.TextWrapped = true
            announcementContent.Parent = announcementFrame
            
            local textSize = game:GetService("TextService"):GetTextSize(content or "", 14, Enum.Font.Gotham, Vector2.new(announcementScroll.AbsoluteSize.X - 40, 1000))
            announcementFrame.Size = UDim2.new(1, -20, 0, textSize.Y + 80)
            announcementContent.Size = UDim2.new(1, -20, 0, textSize.Y)
            
            return announcementFrame
        end
    }, {})
    
    return announcementTab
end

-- Create a section
function Tab:CreateSection(title)
    local section = Instance.new("Frame")
    section.Name = title .. "Section"
    section.Size = UDim2.new(1, -20, 0, 0)
    section.Position = UDim2.new(0, 10, 0, 0)
    section.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    section.BackgroundTransparency = 0.3
    section.BorderSizePixel = 0
    section.Parent = self._frame
    
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
    
    local sectionObj = setmetatable({
        _frame = section,
        _list = sectionList
    }, Section)
    
    return sectionObj
end

-- Add slider
function Section:AddSlider(name, min, max, default, callback)
    default = default or min
    min = min or 0
    max = max or 100
    
    local sliderFrame = Instance.new("Frame")
    sliderFrame.Name = name .. "Slider"
    sliderFrame.Size = UDim2.new(1, -20, 0, 60)
    sliderFrame.Position = UDim2.new(0, 10, 0, 0)
    sliderFrame.BackgroundTransparency = 1
    sliderFrame.Parent = self._frame
    
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

-- Add multi-option (checkboxes)
function Section:AddMultiOption(name, options, callback)
    local optionFrame = Instance.new("Frame")
    optionFrame.Name = name .. "MultiOption"
    optionFrame.Size = UDim2.new(1, -20, 0, 0)
    optionFrame.Position = UDim2.new(0, 10, 0, 0)
    optionFrame.BackgroundTransparency = 1
    optionFrame.Parent = self._frame
    
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

-- Add select (dropdown)
function Section:AddSelect(name, options, default, callback)
    local selectFrame = Instance.new("Frame")
    selectFrame.Name = name .. "Select"
    selectFrame.Size = UDim2.new(1, -20, 0, 35)
    selectFrame.Position = UDim2.new(0, 10, 0, 0)
    selectFrame.BackgroundTransparency = 1
    selectFrame.Parent = self._frame
    
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

-- Add text input
function Section:AddTextInput(name, placeholder, callback)
    local textFrame = Instance.new("Frame")
    textFrame.Name = name .. "TextInput"
    textFrame.Size = UDim2.new(1, -20, 0, 50)
    textFrame.Position = UDim2.new(0, 10, 0, 0)
    textFrame.BackgroundTransparency = 1
    textFrame.Parent = self._frame
    
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

-- Add button
function Section:AddButton(name, callback)
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
    button.Parent = self._frame
    
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

-- Add toggle switch
function Section:AddToggle(name, default, callback)
    default = default or false
    
    local toggleFrame = Instance.new("Frame")
    toggleFrame.Name = name .. "Toggle"
    toggleFrame.Size = UDim2.new(1, -20, 0, 30)
    toggleFrame.Position = UDim2.new(0, 10, 0, 0)
    toggleFrame.BackgroundTransparency = 1
    toggleFrame.Parent = self._frame
    
    local toggleLabel = Instance.new("TextLabel")
    toggleLabel.Name = "Label"
    toggleLabel.Size = UDim2.new(1, -50, 1, 0)
    toggleLabel.Position = UDim2.new(0, 0, 0, 0)
    toggleLabel.BackgroundTransparency = 1
    toggleLabel.Text = name
    toggleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    toggleLabel.TextSize = 14
    toggleLabel.Font = Enum.Font.Gotham
    toggleLabel.TextXAlignment = Enum.TextXAlignment.Left
    toggleLabel.Parent = toggleFrame
    
    local toggleButton = Instance.new("TextButton")
    toggleButton.Name = "Toggle"
    toggleButton.Size = UDim2.new(0, 40, 0, 20)
    toggleButton.Position = UDim2.new(1, -40, 0, 5)
    toggleButton.BackgroundColor3 = default and Color3.fromRGB(50, 100, 200) or Color3.fromRGB(50, 50, 50)
    toggleButton.BorderSizePixel = 0
    toggleButton.Text = ""
    toggleButton.Parent = toggleFrame
    
    local toggleCorner = Instance.new("UICorner")
    toggleCorner.CornerRadius = UDim.new(0, 10)
    toggleCorner.Parent = toggleButton
    
    local toggleDot = Instance.new("Frame")
    toggleDot.Name = "Dot"
    toggleDot.Size = UDim2.new(0, 14, 0, 14)
    toggleDot.Position = default and UDim2.new(1, -17, 0.5, -7) or UDim2.new(0, 3, 0.5, -7)
    toggleDot.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    toggleDot.BorderSizePixel = 0
    toggleDot.Parent = toggleButton
    
    local toggleDotCorner = Instance.new("UICorner")
    toggleDotCorner.CornerRadius = UDim.new(0, 7)
    toggleDotCorner.Parent = toggleDot
    
    local currentState = default
    
    local function setState(state)
        currentState = state
        if state then
            TweenService:Create(toggleButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(50, 100, 200)}):Play()
            TweenService:Create(toggleDot, TweenInfo.new(0.2), {Position = UDim2.new(1, -17, 0.5, -7)}):Play()
        else
            TweenService:Create(toggleButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(50, 50, 50)}):Play()
            TweenService:Create(toggleDot, TweenInfo.new(0.2), {Position = UDim2.new(0, 3, 0.5, -7)}):Play()
        end
        if callback then
            callback(state)
        end
    end
    
    toggleButton.MouseButton1Click:Connect(function()
        setState(not currentState)
    end)
    
    local toggleObj = {
        SetState = setState,
        GetState = function() return currentState end,
        _button = toggleButton,
        _dot = toggleDot
    }
    
    return toggleObj
end

-- Add keybind
function Section:AddKeybind(name, defaultKey, callback)
    local keybindFrame = Instance.new("Frame")
    keybindFrame.Name = name .. "Keybind"
    keybindFrame.Size = UDim2.new(1, -20, 0, 30)
    keybindFrame.Position = UDim2.new(0, 10, 0, 0)
    keybindFrame.BackgroundTransparency = 1
    keybindFrame.Parent = self._frame
    
    local keybindLabel = Instance.new("TextLabel")
    keybindLabel.Name = "Label"
    keybindLabel.Size = UDim2.new(1, -100, 1, 0)
    keybindLabel.Position = UDim2.new(0, 0, 0, 0)
    keybindLabel.BackgroundTransparency = 1
    keybindLabel.Text = name
    keybindLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    keybindLabel.TextSize = 14
    keybindLabel.Font = Enum.Font.Gotham
    keybindLabel.TextXAlignment = Enum.TextXAlignment.Left
    keybindLabel.Parent = keybindFrame
    
    local keybindButton = Instance.new("TextButton")
    keybindButton.Name = "Keybind"
    keybindButton.Size = UDim2.new(0, 90, 0, 25)
    keybindButton.Position = UDim2.new(1, -90, 0, 2.5)
    keybindButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    keybindButton.BorderSizePixel = 0
    keybindButton.Text = defaultKey and tostring(defaultKey) or "Click to bind"
    keybindButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    keybindButton.TextSize = 12
    keybindButton.Font = Enum.Font.Gotham
    keybindButton.Parent = keybindFrame
    
    local keybindCorner = Instance.new("UICorner")
    keybindCorner.CornerRadius = UDim.new(0, 4)
    keybindCorner.Parent = keybindButton
    
    local currentKey = defaultKey
    local isBinding = false
    
    local function getKeyName(keyCode)
        if keyCode == Enum.KeyCode.Unknown then return "None" end
        local keyName = tostring(keyCode):gsub("Enum.KeyCode.", "")
        return keyName
    end
    
    local function setKey(keyCode)
        currentKey = keyCode
        keybindButton.Text = getKeyName(keyCode)
        keybindButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        isBinding = false
        if callback then
            callback(keyCode)
        end
    end
    
    keybindButton.MouseButton1Click:Connect(function()
        if not isBinding then
            isBinding = true
            keybindButton.Text = "Press key..."
            keybindButton.BackgroundColor3 = Color3.fromRGB(50, 100, 200)
            
            local connection
            connection = UserInputService.InputBegan:Connect(function(input, gameProcessed)
                if gameProcessed then return end
                
                if input.UserInputType == Enum.UserInputType.Keyboard then
                    setKey(input.KeyCode)
                    connection:Disconnect()
                elseif input.UserInputType == Enum.UserInputType.MouseButton1 or 
                       input.UserInputType == Enum.UserInputType.MouseButton2 or
                       input.UserInputType == Enum.UserInputType.MouseButton3 then
                    setKey(input.UserInputType)
                    connection:Disconnect()
                end
            end)
        end
    end)
    
    local keybindObj = {
        SetKey = setKey,
        GetKey = function() return currentKey end,
        _button = keybindButton
    }
    
    return keybindObj
end

-- Add label
function Section:AddLabel(text, options)
    options = options or {}
    local textColor = options.TextColor3 or Color3.fromRGB(255, 255, 255)
    local textSize = options.TextSize or 14
    local font = options.Font or Enum.Font.Gotham
    
    local labelFrame = Instance.new("Frame")
    labelFrame.Name = "Label"
    labelFrame.Size = UDim2.new(1, -20, 0, 25)
    labelFrame.Position = UDim2.new(0, 10, 0, 0)
    labelFrame.BackgroundTransparency = 1
    labelFrame.Parent = self._frame
    
    local label = Instance.new("TextLabel")
    label.Name = "Text"
    label.Size = UDim2.new(1, 0, 1, 0)
    label.Position = UDim2.new(0, 0, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = text or ""
    label.TextColor3 = textColor
    label.TextSize = textSize
    label.Font = font
    label.TextXAlignment = options.TextXAlignment or Enum.TextXAlignment.Left
    label.TextWrapped = options.TextWrapped or false
    label.Parent = labelFrame
    
    local labelObj = {
        SetText = function(newText)
            label.Text = newText
        end,
        GetText = function()
            return label.Text
        end,
        _label = label
    }
    
    return labelObj
end

-- Add divider
function Section:AddDivider(text)
    local dividerFrame = Instance.new("Frame")
    dividerFrame.Name = "Divider"
    dividerFrame.Size = UDim2.new(1, -20, 0, text and 30 or 15)
    dividerFrame.Position = UDim2.new(0, 10, 0, 0)
    dividerFrame.BackgroundTransparency = 1
    dividerFrame.Parent = self._frame
    
    local dividerLine = Instance.new("Frame")
    dividerLine.Name = "Line"
    dividerLine.Size = UDim2.new(1, 0, 0, 1)
    dividerLine.Position = UDim2.new(0, 0, 0, text and 15 or 7)
    dividerLine.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    dividerLine.BorderSizePixel = 0
    dividerLine.Parent = dividerFrame
    
    if text then
        local dividerLabel = Instance.new("TextLabel")
        dividerLabel.Name = "Label"
        dividerLabel.Size = UDim2.new(0, 0, 0, 20)
        dividerLabel.Position = UDim2.new(0.5, 0, 0, 5)
        dividerLabel.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
        dividerLabel.BorderSizePixel = 0
        dividerLabel.Text = text
        dividerLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
        dividerLabel.TextSize = 12
        dividerLabel.Font = Enum.Font.Gotham
        dividerLabel.Parent = dividerFrame
        
        local textSize = game:GetService("TextService"):GetTextSize(text, 12, Enum.Font.Gotham, Vector2.new(1000, 20))
        dividerLabel.Size = UDim2.new(0, textSize.X + 10, 0, 20)
        dividerLabel.Position = UDim2.new(0.5, -(textSize.X + 10) / 2, 0, 5)
    end
    
    return dividerFrame
end

-- Tooltip helper function
function UILibrary:AddTooltip(element, text)
    local tooltip = nil
    local tooltipFrame = nil
    
    element.MouseEnter:Connect(function()
        if tooltipFrame then
            tooltipFrame:Destroy()
        end
        
        tooltipFrame = Instance.new("Frame")
        tooltipFrame.Name = "Tooltip"
        tooltipFrame.Size = UDim2.new(0, 0, 0, 0)
        tooltipFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
        tooltipFrame.BorderSizePixel = 0
        tooltipFrame.ZIndex = 100
        tooltipFrame.Parent = element.Parent
        
        local tooltipCorner = Instance.new("UICorner")
        tooltipCorner.CornerRadius = UDim.new(0, 4)
        tooltipCorner.Parent = tooltipFrame
        
        local tooltipText = Instance.new("TextLabel")
        tooltipText.Name = "Text"
        tooltipText.Size = UDim2.new(1, -10, 1, -10)
        tooltipText.Position = UDim2.new(0, 5, 0, 5)
        tooltipText.BackgroundTransparency = 1
        tooltipText.Text = text
        tooltipText.TextColor3 = Color3.fromRGB(255, 255, 255)
        tooltipText.TextSize = 12
        tooltipText.Font = Enum.Font.Gotham
        tooltipText.TextWrapped = true
        tooltipText.Parent = tooltipFrame
        
        local textSize = game:GetService("TextService"):GetTextSize(text, 12, Enum.Font.Gotham, Vector2.new(200, 1000))
        tooltipFrame.Size = UDim2.new(0, math.min(textSize.X + 10, 200), 0, textSize.Y + 10)
        
        local mousePos = UserInputService:GetMouseLocation()
        tooltipFrame.Position = UDim2.new(0, mousePos.X + 10, 0, mousePos.Y + 10)
    end)
    
    element.MouseLeave:Connect(function()
        if tooltipFrame then
            tooltipFrame:Destroy()
            tooltipFrame = nil
        end
    end)
end

return UILibrary

