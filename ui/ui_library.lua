if _G.UILibraryLoaded then return end
_G.UILibraryLoaded = true

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local colors = {
    primary = Color3.fromRGB(35, 35, 40),
    dark = Color3.fromRGB(20, 20, 22),
    secondary = Color3.fromRGB(28, 28, 32),
    light = Color3.fromRGB(38, 38, 42),
    white = Color3.fromRGB(255, 255, 255),
    gray = Color3.fromRGB(170, 170, 180),
    outline = Color3.fromRGB(50, 50, 55),
    accent = Color3.fromRGB(255, 60, 60)
}

local UILibrary = {}
UILibrary.Colors = colors

local notificationContainer = Instance.new("Frame")
notificationContainer.Name = "NotificationContainer"
notificationContainer.Size = UDim2.new(0, 350, 1, 0)
notificationContainer.Position = UDim2.new(1, -370, 0, 10)
notificationContainer.BackgroundTransparency = 1
notificationContainer.Parent = game.CoreGui

local notificationList = Instance.new("UIListLayout")
notificationList.Padding = UDim.new(0, 10)
notificationList.SortOrder = Enum.SortOrder.LayoutOrder
notificationList.FillDirection = Enum.FillDirection.Vertical
notificationList.HorizontalAlignment = Enum.HorizontalAlignment.Right
notificationList.VerticalAlignment = Enum.VerticalAlignment.Bottom
notificationList.Parent = notificationContainer

local notificationPad = Instance.new("UIPadding")
notificationPad.PaddingRight = UDim.new(0, 10)
notificationPad.PaddingBottom = UDim.new(0, 10)
notificationPad.Parent = notificationContainer

local notificationCount = 0
local activeNotifications = {}

local function sortNotifications()
    table.sort(activeNotifications, function(a, b)
        local aLength = (a.TitleLength or 0) + (a.ContentLength or 0)
        local bLength = (b.TitleLength or 0) + (b.ContentLength or 0)
        return aLength < bLength
    end)
    
    for i, notif in ipairs(activeNotifications) do
        if notif.Frame and notif.Frame.Parent then
            notif.Frame.LayoutOrder = i
        end
    end
end

local function createNotification(...)
    local notificationData = {}
    local args = {...}
    
    if type(args[1]) == "table" then
        notificationData = args[1]
        notificationData.Content = notificationData.Content or "Missing Content"
        notificationData.Type = notificationData.Type or "info"
    else
        notificationData.Content = args[1] or "Missing Content"
        notificationData.Type = args[2] or "info"
        notificationData.Duration = args[3] or nil
        notificationData.Title = nil
    end
    
    notificationCount = notificationCount + 1
    
    local colorMap = {
        warning = Color3.fromRGB(255, 200, 0),
        error = Color3.fromRGB(255, 50, 50),
        info = Color3.fromRGB(100, 150, 255),
        test = Color3.fromRGB(100, 150, 255)
    }
    
    local lineColor = colorMap[notificationData.Type] or colorMap.info
    local content = notificationData.Content
    local title = notificationData.Title
    
    local titleLength = title and #title or 0
    local contentLength = #content
    
    local notification = Instance.new("Frame")
    notification.Name = "Notification_" .. notificationCount
    notification.Size = UDim2.new(0, 340, 0, 0)
    notification.BackgroundColor3 = colors.secondary
    notification.BorderSizePixel = 0
    notification.ZIndex = 100
    
    local notifData = {
        Frame = notification,
        TitleLength = titleLength,
        ContentLength = contentLength
    }
    table.insert(activeNotifications, notifData)
    sortNotifications()
    
    for i, notif in ipairs(activeNotifications) do
        if notif.Frame == notification then
            notification.LayoutOrder = i
            break
        end
    end
    
    notification.Parent = notificationContainer
    
    local notifCorner = Instance.new("UICorner")
    notifCorner.CornerRadius = UDim.new(0, 8)
    notifCorner.Parent = notification
    
    local notifStroke = Instance.new("UIStroke")
    notifStroke.Color = colors.outline
    notifStroke.Thickness = 1
    notifStroke.Parent = notification
    
    local contentFrame = Instance.new("Frame")
    contentFrame.Name = "Content"
    contentFrame.Size = UDim2.new(1, 0, 1, 0)
    contentFrame.BackgroundTransparency = 1
    contentFrame.Parent = notification
    
    local contentPad = Instance.new("UIPadding")
    contentPad.PaddingLeft = UDim.new(0, 12)
    contentPad.PaddingRight = UDim.new(0, 12)
    contentPad.PaddingTop = UDim.new(0, 10)
    contentPad.PaddingBottom = UDim.new(0, 10)
    contentPad.Parent = contentFrame
    
    local titleLabel = nil
    if title then
        titleLabel = Instance.new("TextLabel")
        titleLabel.Size = UDim2.new(1, 0, 0, 0)
        titleLabel.BackgroundTransparency = 1
        titleLabel.Text = title
        titleLabel.TextColor3 = colors.white
        titleLabel.TextSize = 16
        titleLabel.Font = Enum.Font.GothamBold
        titleLabel.TextXAlignment = Enum.TextXAlignment.Left
        titleLabel.TextYAlignment = Enum.TextYAlignment.Top
        titleLabel.TextWrapped = true
        titleLabel.AutomaticSize = Enum.AutomaticSize.Y
        titleLabel.Parent = contentFrame
    end
    
    local messageLabel = Instance.new("TextLabel")
    messageLabel.Size = UDim2.new(1, 0, 0, 0)
    messageLabel.BackgroundTransparency = 1
    messageLabel.Text = content
    messageLabel.TextColor3 = colors.white
    messageLabel.TextSize = 14
    messageLabel.Font = Enum.Font.Gotham
    messageLabel.TextXAlignment = Enum.TextXAlignment.Left
    messageLabel.TextYAlignment = Enum.TextYAlignment.Top
    messageLabel.TextWrapped = true
    messageLabel.AutomaticSize = Enum.AutomaticSize.Y
    messageLabel.Parent = contentFrame
    
    if titleLabel then
        messageLabel.Position = UDim2.new(0, 0, 0, 0)
        messageLabel:GetPropertyChangedSignal("TextBounds"):Connect(function()
            local titleHeight = titleLabel.TextBounds.Y
            messageLabel.Position = UDim2.new(0, 0, 0, titleHeight + 3)
        end)
    end
    
    local indicatorLine = Instance.new("Frame")
    indicatorLine.Name = "IndicatorLine"
    indicatorLine.Size = UDim2.new(0, 0, 0, 3)
    indicatorLine.AnchorPoint = Vector2.new(0.5, 0)
    indicatorLine.BackgroundColor3 = lineColor
    indicatorLine.BorderSizePixel = 0
    indicatorLine.Parent = contentFrame
    
    local lineCorner = Instance.new("UICorner")
    lineCorner.CornerRadius = UDim.new(0, 2)
    lineCorner.Parent = indicatorLine
    
    local function updateSize()
        task.wait()
        local titleWidth = titleLabel and titleLabel.TextBounds.X or 0
        local messageWidth = messageLabel.TextBounds.X
        local maxTextWidth = math.max(titleWidth, messageWidth)
        
        local calculatedWidth = maxTextWidth + 24
        
        local titleHeight = titleLabel and titleLabel.TextBounds.Y or 0
        local titleSpacing = titleLabel and 3 or 0
        local messageHeight = messageLabel.TextBounds.Y
        local spacing = 5
        local totalTextHeight = titleHeight + titleSpacing + messageHeight
        local totalHeight = math.max(30, totalTextHeight + 20 + spacing + 3)
        
        notification.Size = UDim2.new(0, calculatedWidth, 0, totalHeight)
        
        local textBottom = totalTextHeight
        indicatorLine.Position = UDim2.new(0.5, 0, 0, textBottom + spacing)
    end
    
    updateSize()
    if titleLabel then
        titleLabel:GetPropertyChangedSignal("TextBounds"):Connect(updateSize)
    end
    messageLabel:GetPropertyChangedSignal("TextBounds"):Connect(updateSize)
    
    task.spawn(function()
        task.wait(0.1)
        
        local titleWidth = titleLabel and titleLabel.TextBounds.X or 0
        local messageWidth = messageLabel.TextBounds.X
        local maxTextWidth = math.max(titleWidth, messageWidth)
        
        local titleHeight = titleLabel and titleLabel.TextBounds.Y or 0
        local titleSpacing = titleLabel and 3 or 0
        local messageHeight = messageLabel.TextBounds.Y
        local spacing = 5
        local totalTextHeight = titleHeight + titleSpacing + messageHeight
        local bounds = math.max(30, totalTextHeight + 20 + spacing + 3)
        
        local calculatedWidth = maxTextWidth + 24
        
        local finalSize = UDim2.new(0, calculatedWidth, 0, bounds)
        
        notification.Position = UDim2.new(1, 50, 1, 50)
        notification.Size = UDim2.new(0, calculatedWidth, 0, -notificationList.Padding.Offset)
        notification.BackgroundTransparency = 1
        
        if titleLabel then
            titleLabel.TextTransparency = 1
        end
        messageLabel.TextTransparency = 1
        notifStroke.Transparency = 1
        indicatorLine.BackgroundTransparency = 0
        indicatorLine.Size = UDim2.new(0, 0, 0, 3)
        
        notification.Visible = true
        
        TweenService:Create(notification, TweenInfo.new(0.6, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
            Size = finalSize
        }):Play()
        
        task.wait(0.15)
        
        TweenService:Create(notification, TweenInfo.new(0.4, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
            BackgroundTransparency = 0
        }):Play()
        
        if titleLabel then
            TweenService:Create(titleLabel, TweenInfo.new(0.3, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
                TextTransparency = 0
            }):Play()
        end
        
        task.wait(0.05)
        
        TweenService:Create(messageLabel, TweenInfo.new(0.3, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
            TextTransparency = 0
        }):Play()
        
        task.wait(0.05)
        
        TweenService:Create(notifStroke, TweenInfo.new(0.4, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
            Transparency = 0
        }):Play()
        
        task.wait(0.2)
        TweenService:Create(indicatorLine, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Size = UDim2.new(1, -24, 0, 3)
        }):Play()
        
        local waitDuration = notificationData.Duration
        if not waitDuration then
            local textLength = #content + (title and #title or 0)
            waitDuration = math.min(math.max(textLength * 0.1 + 2.5, 3), 10)
        end
        
        task.wait(waitDuration)
        
        TweenService:Create(indicatorLine, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
            Size = UDim2.new(0, 0, 0, 3)
        }):Play()
        
        task.wait(0.2)
        
        TweenService:Create(notification, TweenInfo.new(0.4, Enum.EasingStyle.Exponential, Enum.EasingDirection.In), {
            BackgroundTransparency = 1
        }):Play()
        
        TweenService:Create(notifStroke, TweenInfo.new(0.4, Enum.EasingStyle.Exponential, Enum.EasingDirection.In), {
            Transparency = 1
        }):Play()
        
        if titleLabel then
            TweenService:Create(titleLabel, TweenInfo.new(0.3, Enum.EasingStyle.Exponential, Enum.EasingDirection.In), {
                TextTransparency = 1
            }):Play()
        end
        
        TweenService:Create(messageLabel, TweenInfo.new(0.3, Enum.EasingStyle.Exponential, Enum.EasingDirection.In), {
            TextTransparency = 1
        }):Play()
        
        TweenService:Create(notification, TweenInfo.new(1, Enum.EasingStyle.Exponential, Enum.EasingDirection.In), {
            Size = UDim2.new(0, calculatedWidth, 0, -notificationList.Padding.Offset)
        }):Play()
        
        task.wait(1)
        
        notification.Visible = false
        
        for i, notif in ipairs(activeNotifications) do
            if notif.Frame == notification then
                table.remove(activeNotifications, i)
                break
            end
        end
        sortNotifications()
        
        notification:Destroy()
    end)
    
    return notification
end

_G.notify = function(data, notifType, duration)
    if type(data) == "table" then
        createNotification(data)
    else
        createNotification({Content = data, Type = notifType, Duration = duration})
    end
end

_G.Notification = function(data)
    createNotification(data)
end

function UILibrary:CreateWindow(name, size)
    local gui = Instance.new("ScreenGui")
    gui.Name = name or "CustomGUI"
    gui.ResetOnSpawn = false
    gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    gui.Parent = game.CoreGui
    
    local window = Instance.new("Frame")
    window.Size = size or UDim2.new(0, 600, 0, 400)
    window.Position = UDim2.new(0.5, 0, 0.5, 0)
    window.AnchorPoint = Vector2.new(0.5, 0.5)
    window.BackgroundColor3 = colors.dark
    window.BorderSizePixel = 0
    window.Visible = false
    window.Parent = gui
    
    local windowCorner = Instance.new("UICorner")
    windowCorner.CornerRadius = UDim.new(0, 10)
    windowCorner.Parent = window
    
    local windowStroke = Instance.new("UIStroke")
    windowStroke.Color = colors.outline
    windowStroke.Thickness = 1
    windowStroke.Parent = window
    
    local topbar = Instance.new("Frame")
    topbar.Size = UDim2.new(1, 0, 0, 50)
    topbar.BackgroundColor3 = colors.dark
    topbar.BorderSizePixel = 0
    topbar.Parent = window
    
    local topCorner = Instance.new("UICorner")
    topCorner.CornerRadius = UDim.new(0, 10)
    topCorner.Parent = topbar
    
    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, -100, 1, 0)
    title.Position = UDim2.new(0, 15, 0, 0)
    title.BackgroundTransparency = 1
    title.Text = name or "GUI"
    title.TextColor3 = colors.white
    title.TextSize = 18
    title.Font = Enum.Font.GothamBold
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.Parent = topbar
    
    local minimize = Instance.new("TextButton")
    minimize.Size = UDim2.new(0, 35, 0, 35)
    minimize.Position = UDim2.new(1, -85, 0.5, 0)
    minimize.AnchorPoint = Vector2.new(0, 0.5)
    minimize.BackgroundColor3 = colors.dark
    minimize.BackgroundTransparency = 1
    minimize.BorderSizePixel = 0
    minimize.Text = "−"
    minimize.TextColor3 = colors.white
    minimize.TextSize = 24
    minimize.Font = Enum.Font.GothamBold
    minimize.Parent = topbar
    
    local minimizeCorner = Instance.new("UICorner")
    minimizeCorner.CornerRadius = UDim.new(0, 8)
    minimizeCorner.Parent = minimize
    
    local close = Instance.new("TextButton")
    close.Size = UDim2.new(0, 35, 0, 35)
    close.Position = UDim2.new(1, -45, 0.5, 0)
    close.AnchorPoint = Vector2.new(0, 0.5)
    close.BackgroundColor3 = colors.dark
    close.BackgroundTransparency = 1
    close.BorderSizePixel = 0
    close.Text = "×"
    close.TextColor3 = colors.white
    close.TextSize = 24
    close.Font = Enum.Font.GothamBold
    close.Parent = topbar
    
    local closeCorner = Instance.new("UICorner")
    closeCorner.CornerRadius = UDim.new(0, 8)
    closeCorner.Parent = close
    
    local topSeparator = Instance.new("Frame")
    topSeparator.Name = "TopSeparator"
    topSeparator.Size = UDim2.new(1, 0, 0, 1)
    topSeparator.Position = UDim2.new(0, 0, 0, 50)
    topSeparator.BackgroundColor3 = colors.outline
    topSeparator.BorderSizePixel = 0
    topSeparator.ZIndex = 2
    topSeparator.Parent = window
    
    local sidebar = Instance.new("Frame")
    sidebar.Size = UDim2.new(0, 120, 1, -50)
    sidebar.Position = UDim2.new(0, 0, 0, 50)
    sidebar.BackgroundColor3 = colors.dark
    sidebar.BorderSizePixel = 0
    sidebar.Parent = window
    
    local sidebarCorner = Instance.new("UICorner")
    sidebarCorner.CornerRadius = UDim.new(0, 10)
    sidebarCorner.Parent = sidebar
    
    local sidebarFix = Instance.new("Frame")
    sidebarFix.Size = UDim2.new(0, 10, 0, 10)
    sidebarFix.Position = UDim2.new(1, -10, 1, -10)
    sidebarFix.AnchorPoint = Vector2.new(1, 1)
    sidebarFix.BackgroundColor3 = colors.dark
    sidebarFix.BorderSizePixel = 0
    sidebarFix.ZIndex = 1
    sidebarFix.Parent = sidebar
    
    local sidebarList = Instance.new("UIListLayout")
    sidebarList.Padding = UDim.new(0, 5)
    sidebarList.SortOrder = Enum.SortOrder.LayoutOrder
    sidebarList.Parent = sidebar
    
    local sidebarPad = Instance.new("UIPadding")
    sidebarPad.PaddingLeft = UDim.new(0, 8)
    sidebarPad.PaddingRight = UDim.new(0, 8)
    sidebarPad.PaddingTop = UDim.new(0, 0)
    sidebarPad.PaddingBottom = UDim.new(0, 10)
    sidebarPad.Parent = sidebar
    
    local sideSeparator = Instance.new("Frame")
    sideSeparator.Name = "SideSeparator"
    sideSeparator.Size = UDim2.new(0, 1, 1, -50)
    sideSeparator.Position = UDim2.new(0, 120, 0, 50)
    sideSeparator.BackgroundColor3 = colors.outline
    sideSeparator.BorderSizePixel = 0
    sideSeparator.ZIndex = 2
    sideSeparator.Parent = window
    
    local pages = Instance.new("Frame")
    pages.Size = UDim2.new(1, -140, 1, -70)
    pages.Position = UDim2.new(0, 130, 0, 60)
    pages.BackgroundTransparency = 1
    pages.Parent = window
    
    local tabs = {}
    local currentTab = nil
    local tabOrder = 0
    
    local windowObj = {
        Window = window,
        Topbar = topbar,
        Title = title,
        Minimize = minimize,
        Close = close,
        Sidebar = sidebar,
        Pages = pages,
        Tabs = tabs,
        CurrentTab = currentTab,
        WindowStroke = windowStroke
    }
    
    function windowObj:CreateTab(tabName, icon, addSeparator)
        local page = Instance.new("ScrollingFrame")
        page.Size = UDim2.new(1, 0, 1, 0)
        page.BackgroundTransparency = 1
        page.BorderSizePixel = 0
        page.ScrollBarThickness = 5
        page.ScrollBarImageColor3 = colors.primary
        page.CanvasSize = UDim2.new(0, 0, 0, 0)
        page.AutomaticCanvasSize = Enum.AutomaticSize.Y
        page.Visible = false
        page.Parent = pages
        
        local pageList = Instance.new("UIListLayout")
        pageList.Padding = UDim.new(0, 10)
        pageList.Parent = page
        
        local pagePad = Instance.new("UIPadding")
        pagePad.PaddingLeft = UDim.new(0, 10)
        pagePad.PaddingRight = UDim.new(0, 10)
        pagePad.PaddingTop = UDim.new(0, 10)
        pagePad.PaddingBottom = UDim.new(0, 10)
        pagePad.Parent = page
        
        if addSeparator then
            local separator = Instance.new("Frame")
            separator.Name = "Separator"
            separator.Size = UDim2.new(1, -16, 0, 1)
            separator.BackgroundColor3 = colors.outline
            separator.BorderSizePixel = 0
            separator.LayoutOrder = tabOrder
            separator.Parent = sidebar
            tabOrder = tabOrder + 1
        end
        
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(1, 0, 0, 35)
        btn.BackgroundColor3 = colors.dark
        btn.BorderSizePixel = 0
        btn.Text = ""
        btn.LayoutOrder = tabOrder
        btn.Parent = sidebar
        tabOrder = tabOrder + 1
        
        local btnCorner = Instance.new("UICorner")
        btnCorner.CornerRadius = UDim.new(0, 8)
        btnCorner.Parent = btn
        
        local indicator = Instance.new("Frame")
        indicator.Name = "Indicator"
        indicator.Size = UDim2.new(0, 2, 1, -13)
        indicator.Position = UDim2.new(0, 0, 0, 6.5)
        indicator.BackgroundColor3 = Color3.fromRGB(255, 215, 0)
        indicator.BackgroundTransparency = 1
        indicator.BorderSizePixel = 0
        indicator.Visible = false
        indicator.Parent = btn
        
        local indicatorCorner = Instance.new("UICorner")
        indicatorCorner.CornerRadius = UDim.new(0, 1)
        indicatorCorner.Parent = indicator
        
        local btnIcon = nil
        if icon and icon ~= "" then
            btnIcon = Instance.new("TextLabel")
            btnIcon.Size = UDim2.new(0, 24, 0, 24)
            btnIcon.Position = UDim2.new(0, 10, 0.5, 0)
            btnIcon.AnchorPoint = Vector2.new(0, 0.5)
            btnIcon.BackgroundTransparency = 1
            btnIcon.Text = icon
            btnIcon.TextColor3 = colors.gray
            btnIcon.TextSize = 16
            btnIcon.Parent = btn
        end
        
        local btnLabel = Instance.new("TextLabel")
        if btnIcon then
            btnLabel.Size = UDim2.new(1, -44, 1, 0)
            btnLabel.Position = UDim2.new(0, 40, 0, 0)
        else
            btnLabel.Size = UDim2.new(1, -20, 1, 0)
            btnLabel.Position = UDim2.new(0, 10, 0, 0)
        end
        btnLabel.BackgroundTransparency = 1
        btnLabel.Text = tabName
        btnLabel.TextColor3 = colors.gray
        btnLabel.TextSize = 13
        btnLabel.Font = Enum.Font.Gotham
        btnLabel.TextXAlignment = Enum.TextXAlignment.Left
        btnLabel.TextTruncate = Enum.TextTruncate.AtEnd
        btnLabel.Parent = btn
        
        local originalSize = btn.Size
        tabs[tabName] = {Page = page, Button = btn, Icon = btnIcon, Label = btnLabel, Indicator = indicator, IsSelected = false, OriginalSize = originalSize}
        
        btn.MouseEnter:Connect(function()
            if not tabs[tabName].IsSelected then
                TweenService:Create(btn, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
                    Size = UDim2.new(1, 5, 0, 38),
                    BackgroundColor3 = Color3.fromRGB(
                        math.min(255, colors.dark.R * 255 + 10),
                        math.min(255, colors.dark.G * 255 + 10),
                        math.min(255, colors.dark.B * 255 + 10)
                    )
                }):Play()
                if btnIcon then
                    TweenService:Create(btnIcon, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
                        TextColor3 = Color3.fromRGB(
                            math.min(255, colors.gray.R * 255 + 20),
                            math.min(255, colors.gray.G * 255 + 20),
                            math.min(255, colors.gray.B * 255 + 20)
                        )
                    }):Play()
                end
                TweenService:Create(btnLabel, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
                    TextColor3 = Color3.fromRGB(
                        math.min(255, colors.gray.R * 255 + 20),
                        math.min(255, colors.gray.G * 255 + 20),
                        math.min(255, colors.gray.B * 255 + 20)
                    )
                }):Play()
            end
        end)
        
        btn.MouseLeave:Connect(function()
            if not tabs[tabName].IsSelected then
                TweenService:Create(btn, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
                    Size = originalSize,
                    BackgroundColor3 = colors.dark
                }):Play()
                if btnIcon then
                    TweenService:Create(btnIcon, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
                        TextColor3 = colors.gray
                    }):Play()
                end
                TweenService:Create(btnLabel, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
                    TextColor3 = colors.gray
                }):Play()
            end
        end)
        
        btn.MouseButton1Click:Connect(function()
            for tabName2, tab in pairs(tabs) do
                tab.Page.Visible = false
                if tab.IsSelected then
                    tab.IsSelected = false
                end
                TweenService:Create(tab.Button, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
                    Size = tab.OriginalSize or UDim2.new(1, 0, 0, 35),
                    BackgroundColor3 = colors.dark
                }):Play()
                if tab.Button:FindFirstChildOfClass("UIStroke") then
                    TweenService:Create(tab.Button:FindFirstChildOfClass("UIStroke"), TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
                        Color = colors.outline
                    }):Play()
                end
                if tab.Indicator then
                    TweenService:Create(tab.Indicator, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
                        BackgroundTransparency = 1
                    }):Play()
                    tab.Indicator.Visible = false
                end
                if tab.Icon then
                    TweenService:Create(tab.Icon, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
                        TextColor3 = colors.gray
                    }):Play()
                end
                TweenService:Create(tab.Label, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
                    TextColor3 = colors.gray
                }):Play()
            end
            
            tabs[tabName].IsSelected = true
            
            page.Visible = true
            indicator.Visible = true
            indicator.BackgroundTransparency = 1
            TweenService:Create(btn, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
                BackgroundColor3 = colors.light
            }):Play()
            TweenService:Create(indicator, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
                BackgroundTransparency = 0
            }):Play()
            if btnIcon then
                TweenService:Create(btnIcon, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
                    TextColor3 = colors.white
                }):Play()
            end
            TweenService:Create(btnLabel, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
                TextColor3 = colors.white
            }):Play()
            currentTab = tabName
        end)
        
        return page
    end
    
    function windowObj:MakeButton(parent, text, callback)
        local isInSection = parent and parent.Name == "Content"
        
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(1, 0, 0, 30)
        btn.BackgroundColor3 = colors.secondary
        btn.BorderSizePixel = 0
        btn.Text = ""
        btn.Parent = parent
        
        local btnCorner = Instance.new("UICorner")
        btnCorner.CornerRadius = UDim.new(0, 6)
        btnCorner.Parent = btn
        
        local btnStroke = Instance.new("UIStroke")
        btnStroke.Color = colors.outline
        btnStroke.Thickness = 1
        btnStroke.Transparency = 0
        btnStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
        btnStroke.Parent = btn
        
        local btnLabel = Instance.new("TextLabel")
        btnLabel.Size = UDim2.new(1, 0, 1, 0)
        btnLabel.Position = UDim2.new(0, 0, 0, 0)
        btnLabel.BackgroundTransparency = 1
        btnLabel.Text = text
        btnLabel.TextColor3 = colors.white
        btnLabel.TextSize = 14
        btnLabel.Font = Enum.Font.Gotham
        btnLabel.TextXAlignment = Enum.TextXAlignment.Center
        btnLabel.Parent = btn
        
        btn.MouseEnter:Connect(function()
            local hoverColor = isInSection and Color3.fromRGB(20, 20, 25) or colors.light
            TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = hoverColor}):Play()
        end)
        
        btn.MouseLeave:Connect(function()
            local normalColor = isInSection and colors.dark or colors.secondary
            TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = normalColor}):Play()
        end)
        
        btn.MouseButton1Click:Connect(function()
            if callback then callback() end
        end)
        
        if isInSection then
            local separator = Instance.new("Frame")
            separator.Name = "Separator"
            separator.Size = UDim2.new(1, 0, 0, 1)
            separator.Position = UDim2.new(0, 0, 1, 5)
            separator.AnchorPoint = Vector2.new(0, 1)
            separator.BackgroundColor3 = colors.outline
            separator.BorderSizePixel = 0
            separator.Parent = btn
            
            local function updateSeparator()
                local children = parent:GetChildren()
                local uiElements = {}
                for _, child in ipairs(children) do
                    if (child:IsA("TextButton") or (child:IsA("Frame") and child.Name ~= "Content" and child:FindFirstChildOfClass("UIListLayout") == nil and not child:IsA("TextLabel"))) then
                        table.insert(uiElements, child)
                    end
                end
                separator.Visible = (btn ~= uiElements[#uiElements] and #uiElements > 1)
            end
            
            task.spawn(function()
                task.wait()
                updateSeparator()
            end)
            local layout = parent:FindFirstChildOfClass("UIListLayout")
            if layout then
                layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
                    task.wait()
                    updateSeparator()
                end)
            end
        end
        
        return btn
    end
    
    function windowObj:MakeSlider(parent, text, min, max, default, callback)
        local isInSection = parent and parent.Name == "Content"
        
        local frame = Instance.new("Frame")
        frame.Size = UDim2.new(1, 0, 0, 50)
        frame.BackgroundColor3 = isInSection and colors.dark or colors.secondary
        frame.BorderSizePixel = 0
        frame.Parent = parent
        
        if not isInSection then
            local frameCorner = Instance.new("UICorner")
            frameCorner.CornerRadius = UDim.new(0, 8)
            frameCorner.Parent = frame
            
            local frameStroke = Instance.new("UIStroke")
            frameStroke.Color = colors.outline
            frameStroke.Thickness = 1
            frameStroke.Transparency = 0
            frameStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
            frameStroke.Parent = frame
        end
        
        local label = Instance.new("TextLabel")
        label.Size = UDim2.new(1, -90, 0, 25)
        label.Position = UDim2.new(0, 10, 0, 8)
        label.BackgroundTransparency = 1
        label.Text = text
        label.TextColor3 = colors.white
        label.TextSize = 14
        label.Font = Enum.Font.Gotham
        label.TextXAlignment = Enum.TextXAlignment.Left
        label.Parent = frame
        
        local value = Instance.new("TextLabel")
        value.Size = UDim2.new(0, 70, 0, 25)
        value.Position = UDim2.new(1, -80, 0, 8)
        value.BackgroundTransparency = 1
        value.Text = tostring(default)
        value.TextColor3 = colors.accent
        value.TextSize = 14
        value.Font = Enum.Font.GothamBold
        value.TextXAlignment = Enum.TextXAlignment.Right
        value.Parent = frame
        
        local bar = Instance.new("Frame")
        bar.Size = UDim2.new(1, -20, 0, 6)
        local bottomOffset = (text == "Jump Power") and -12 or -18
        bar.Position = UDim2.new(0, 10, 1, bottomOffset)
        bar.BackgroundColor3 = colors.light
        bar.BorderSizePixel = 0
        bar.Parent = frame
        
        local barCorner = Instance.new("UICorner")
        barCorner.CornerRadius = UDim.new(1, 0)
        barCorner.Parent = bar
        
        local fill = Instance.new("Frame")
        fill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
        fill.BackgroundColor3 = colors.accent
        fill.BorderSizePixel = 0
        fill.Parent = bar
        
        local fillCorner = Instance.new("UICorner")
        fillCorner.CornerRadius = UDim.new(1, 0)
        fillCorner.Parent = fill
        
        local dot = Instance.new("Frame")
        dot.Size = UDim2.new(0, 12, 0, 12)
        dot.Position = UDim2.new((default - min) / (max - min), 0, 0.5, 0)
        dot.AnchorPoint = Vector2.new(0.5, 0.5)
        dot.BackgroundColor3 = colors.white
        dot.BorderSizePixel = 0
        dot.Parent = bar
        
        local dotCorner = Instance.new("UICorner")
        dotCorner.CornerRadius = UDim.new(1, 0)
        dotCorner.Parent = dot
        
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(1, 0, 1, 0)
        btn.BackgroundTransparency = 1
        btn.Text = ""
        btn.Parent = bar
        
        local dragging = false
        local currentVal = default
        
        local function update(input)
            local pos = math.clamp((input.Position.X - bar.AbsolutePosition.X) / bar.AbsoluteSize.X, 0, 1)
            local val = math.floor(min + (max - min) * pos)
            
            if val ~= currentVal then
                currentVal = val
                TweenService:Create(fill, TweenInfo.new(0.1), {Size = UDim2.new(pos, 0, 1, 0)}):Play()
                TweenService:Create(dot, TweenInfo.new(0.1), {Position = UDim2.new(pos, 0, 0.5, 0)}):Play()
                value.Text = tostring(val)
                if callback then callback(val) end
            end
        end
        
        btn.MouseButton1Down:Connect(function()
            dragging = true
        end)
        
        UserInputService.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                dragging = false
            end
        end)
        
        btn.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                dragging = true
                update(input)
            end
        end)
        
        UserInputService.InputChanged:Connect(function(input)
            if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                update(input)
            end
        end)
        
        if isInSection then
            local separator = Instance.new("Frame")
            separator.Name = "Separator"
            separator.Size = UDim2.new(1, 0, 0, 1)
            separator.Position = UDim2.new(0, 0, 1, 5)
            separator.AnchorPoint = Vector2.new(0, 1)
            separator.BackgroundColor3 = colors.outline
            separator.BorderSizePixel = 0
            separator.Parent = frame
            
            local function updateSeparator()
                local children = parent:GetChildren()
                local uiElements = {}
                for _, child in ipairs(children) do
                    if (child:IsA("TextButton") or (child:IsA("Frame") and child.Name ~= "Content" and child:FindFirstChildOfClass("UIListLayout") == nil and not child:IsA("TextLabel"))) then
                        table.insert(uiElements, child)
                    end
                end
                separator.Visible = (frame ~= uiElements[#uiElements] and #uiElements > 1)
            end
            
            task.spawn(function()
                task.wait()
                updateSeparator()
            end)
            local layout = parent:FindFirstChildOfClass("UIListLayout")
            if layout then
                layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
                    task.wait()
                    updateSeparator()
                end)
            end
        end
        
        return frame
    end
    
    function windowObj:CreateSection(parent, name)
        local section = Instance.new("Frame")
        section.Size = UDim2.new(1, 0, 0, 30)
        section.BackgroundColor3 = colors.secondary
        section.BorderSizePixel = 0
        section.Parent = parent
        
        local sectionCorner = Instance.new("UICorner")
        sectionCorner.CornerRadius = UDim.new(0, 6)
        sectionCorner.Parent = section
        
        local sectionStroke = Instance.new("UIStroke")
        sectionStroke.Color = colors.outline
        sectionStroke.Thickness = 1
        sectionStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
        sectionStroke.Parent = section
        
        local header = Instance.new("TextButton")
        header.Size = UDim2.new(1, 0, 0, 30)
        header.BackgroundTransparency = 1
        header.Text = ""
        header.Parent = section
        
        local title = Instance.new("TextLabel")
        title.Size = UDim2.new(1, -20, 1, 0)
        title.Position = UDim2.new(0, 12, 0, 0)
        title.BackgroundTransparency = 1
        title.Text = "Section"
        title.TextColor3 = colors.white
        title.TextSize = 14
        title.Font = Enum.Font.Gotham
        title.TextXAlignment = Enum.TextXAlignment.Left
        title.Parent = header
        
        local headerSeparator = Instance.new("Frame")
        headerSeparator.Name = "HeaderSeparator"
        headerSeparator.Size = UDim2.new(1, 0, 0, 1)
        headerSeparator.Position = UDim2.new(0, 0, 1, 0)
        headerSeparator.AnchorPoint = Vector2.new(0, 1)
        headerSeparator.BackgroundColor3 = colors.outline
        headerSeparator.BorderSizePixel = 0
        headerSeparator.ZIndex = 2
        headerSeparator.Parent = header
        
        local content = Instance.new("Frame")
        content.Name = "Content"
        content.Size = UDim2.new(1, 0, 0, 0)
        content.Position = UDim2.new(0, 0, 0, 30)
        content.BackgroundTransparency = 1
        content.ClipsDescendants = true
        content.Parent = section
        
        local contentList = Instance.new("UIListLayout")
        contentList.Padding = UDim.new(0, 6)
        contentList.SortOrder = Enum.SortOrder.LayoutOrder
        contentList.Parent = content
        
        local contentPad = Instance.new("UIPadding")
        contentPad.PaddingLeft = UDim.new(0, 0)
        contentPad.PaddingRight = UDim.new(0, 0)
        contentPad.PaddingTop = UDim.new(0, 0)
        contentPad.PaddingBottom = UDim.new(0, 0)
        contentPad.Parent = content
        
        local isExpanded = true
        
        local function updateSize()
            local contentSize = contentList.AbsoluteContentSize.Y + 16
            local targetSize = isExpanded and (30 + contentSize) or 30
            local targetContentSize = isExpanded and contentSize or 0
            
            if headerSeparator then
                headerSeparator.Visible = isExpanded
            end
            
            TweenService:Create(section, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
                Size = UDim2.new(1, 0, 0, targetSize)
            }):Play()
            
            TweenService:Create(content, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
                Size = UDim2.new(1, 0, 0, targetContentSize)
            }):Play()
        end
        
        contentList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            if isExpanded then
                updateSize()
            end
        end)
        
        header.MouseButton1Click:Connect(function()
            isExpanded = not isExpanded
            updateSize()
        end)
        
        if isExpanded then
            local contentSize = contentList.AbsoluteContentSize.Y + 16
            section.Size = UDim2.new(1, 0, 0, 30 + contentSize)
            content.Size = UDim2.new(1, 0, 0, contentSize)
            if headerSeparator then
                headerSeparator.Visible = true
            end
        else
            if headerSeparator then
                headerSeparator.Visible = false
            end
        end
        
        return content
    end
    
    function windowObj:MakeToggle(parent, text, default, callback)
        local isInSection = parent and parent.Name == "Content"
        local toggled = default or false
        
        local toggle = Instance.new("TextButton")
        toggle.Size = UDim2.new(1, 0, 0, 30)
        toggle.BackgroundColor3 = isInSection and colors.dark or colors.secondary
        toggle.BorderSizePixel = 0
        toggle.Text = ""
        toggle.Parent = parent
        
        if not isInSection then
            local toggleCorner = Instance.new("UICorner")
            toggleCorner.CornerRadius = UDim.new(0, 8)
            toggleCorner.Parent = toggle
            
            local toggleStroke = Instance.new("UIStroke")
            toggleStroke.Color = colors.outline
            toggleStroke.Thickness = 1
            toggleStroke.Transparency = 0
            toggleStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
            toggleStroke.Parent = toggle
        end
        
        local toggleLabel = Instance.new("TextLabel")
        toggleLabel.Size = UDim2.new(1, -60, 1, 0)
        toggleLabel.Position = UDim2.new(0, 10, 0, 0)
        toggleLabel.BackgroundTransparency = 1
        toggleLabel.Text = text
        toggleLabel.TextColor3 = colors.white
        toggleLabel.TextSize = 14
        toggleLabel.Font = Enum.Font.Gotham
        toggleLabel.TextXAlignment = Enum.TextXAlignment.Left
        toggleLabel.Parent = toggle
        
        local switchTrack = Instance.new("Frame")
        switchTrack.Size = UDim2.new(0, 44, 0, 22)
        switchTrack.Position = UDim2.new(1, -50, 0.5, 0)
        switchTrack.AnchorPoint = Vector2.new(0, 0.5)
        switchTrack.BackgroundColor3 = toggled and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(80, 80, 80)
        switchTrack.BorderSizePixel = 0
        switchTrack.Parent = toggle
        
        local trackCorner = Instance.new("UICorner")
        trackCorner.CornerRadius = UDim.new(0, 11)
        trackCorner.Parent = switchTrack
        
        local switchButton = Instance.new("Frame")
        switchButton.Size = UDim2.new(0, 18, 0, 18)
        switchButton.Position = UDim2.new(toggled and 1 or 0, toggled and -19 or 2, 0.5, 0)
        switchButton.AnchorPoint = Vector2.new(0, 0.5)
        switchButton.BackgroundColor3 = colors.white
        switchButton.BorderSizePixel = 0
        switchButton.Parent = switchTrack
        switchButton.ZIndex = 2
        
        local buttonCorner = Instance.new("UICorner")
        buttonCorner.CornerRadius = UDim.new(1, 0)
        buttonCorner.Parent = switchButton
        
        toggle.MouseEnter:Connect(function()
            local hoverColor = isInSection and Color3.fromRGB(20, 20, 25) or colors.light
            TweenService:Create(toggle, TweenInfo.new(0.2), {BackgroundColor3 = hoverColor}):Play()
        end)
        
        toggle.MouseLeave:Connect(function()
            local normalColor = isInSection and colors.dark or colors.secondary
            TweenService:Create(toggle, TweenInfo.new(0.2), {BackgroundColor3 = normalColor}):Play()
        end)
        
        toggle.MouseButton1Click:Connect(function()
            toggled = not toggled
            
            TweenService:Create(switchButton, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
                Position = UDim2.new(toggled and 1 or 0, toggled and -19 or 2, 0.5, 0)
            }):Play()
            
            TweenService:Create(switchTrack, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
                BackgroundColor3 = toggled and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(80, 80, 80)
            }):Play()
            
            if callback then callback(toggled) end
        end)
        
        if isInSection then
            local separator = Instance.new("Frame")
            separator.Name = "Separator"
            separator.Size = UDim2.new(1, 0, 0, 1)
            separator.Position = UDim2.new(0, 0, 1, 5)
            separator.AnchorPoint = Vector2.new(0, 1)
            separator.BackgroundColor3 = colors.outline
            separator.BorderSizePixel = 0
            separator.Parent = toggle
            
            local function updateSeparator()
                local children = parent:GetChildren()
                local uiElements = {}
                for _, child in ipairs(children) do
                    if (child:IsA("TextButton") or (child:IsA("Frame") and child.Name ~= "Content" and child:FindFirstChildOfClass("UIListLayout") == nil and not child:IsA("TextLabel"))) then
                        table.insert(uiElements, child)
                    end
                end
                separator.Visible = (toggle ~= uiElements[#uiElements] and #uiElements > 1)
            end
            
            task.spawn(function()
                task.wait()
                updateSeparator()
            end)
            local layout = parent:FindFirstChildOfClass("UIListLayout")
            if layout then
                layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
                    task.wait()
                    updateSeparator()
                end)
            end
        end
        
        return toggle
    end
    
    function windowObj:MakeTextInput(parent, name, placeholder, callback)
        local isInSection = parent and parent.Name == "Content"
        
        local frame = Instance.new("Frame")
        frame.Size = UDim2.new(1, 0, 0, 50)
        frame.BackgroundColor3 = colors.secondary
        frame.BorderSizePixel = 0
        frame.Parent = parent
        
        local frameCorner = Instance.new("UICorner")
        frameCorner.CornerRadius = UDim.new(0, 6)
        frameCorner.Parent = frame
        
        local frameStroke = Instance.new("UIStroke")
        frameStroke.Color = colors.outline
        frameStroke.Thickness = 1
        frameStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
        frameStroke.Parent = frame
        
        local label = Instance.new("TextLabel")
        label.Size = UDim2.new(1, -24, 0, 18)
        label.Position = UDim2.new(0, 12, 0, 6)
        label.BackgroundTransparency = 1
        label.Text = name
        label.TextColor3 = colors.white
        label.TextSize = 14
        label.Font = Enum.Font.Gotham
        label.TextXAlignment = Enum.TextXAlignment.Left
        label.Parent = frame
        
        local inputBox = Instance.new("Frame")
        inputBox.Size = UDim2.new(1, -24, 0, 26)
        inputBox.Position = UDim2.new(0, 12, 0, 24)
        inputBox.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
        inputBox.BorderSizePixel = 0
        inputBox.Parent = frame
        
        local inputBoxCorner = Instance.new("UICorner")
        inputBoxCorner.CornerRadius = UDim.new(0, 4)
        inputBoxCorner.Parent = inputBox
        
        local inputBoxStroke = Instance.new("UIStroke")
        inputBoxStroke.Color = colors.outline
        inputBoxStroke.Thickness = 1
        inputBoxStroke.Parent = inputBox
        
        local textBox = Instance.new("TextBox")
        textBox.Size = UDim2.new(1, -10, 1, -6)
        textBox.Position = UDim2.new(0, 5, 0, 3)
        textBox.BackgroundTransparency = 1
        textBox.Text = ""
        textBox.PlaceholderText = placeholder or ""
        textBox.TextColor3 = colors.white
        textBox.PlaceholderColor3 = colors.gray
        textBox.TextSize = 14
        textBox.Font = Enum.Font.Gotham
        textBox.TextXAlignment = Enum.TextXAlignment.Left
        textBox.ClearTextOnFocus = false
        textBox.Parent = inputBox
        
        local isExpanding = false
        
        textBox:GetPropertyChangedSignal("TextBounds"):Connect(function()
            if not textBox:IsFocused() and not isExpanding then
                local textWidth = math.max(150, textBox.TextBounds.X + 20)
                TweenService:Create(inputBox, TweenInfo.new(0.2), {
                    Size = UDim2.new(0, textWidth, 0, 26)
                }):Play()
            end
        end)
        
        textBox.Focused:Connect(function()
            isExpanding = true
            TweenService:Create(inputBox, TweenInfo.new(0.2), {
                Size = UDim2.new(1, -24, 0, 26)
            }):Play()
            task.wait(0.2)
            isExpanding = false
        end)
        
        textBox.FocusLost:Connect(function()
            isExpanding = true
            local textWidth = math.max(150, textBox.TextBounds.X + 20)
            TweenService:Create(inputBox, TweenInfo.new(0.2), {
                Size = UDim2.new(0, textWidth, 0, 26)
            }):Play()
            task.wait(0.2)
            isExpanding = false
            if callback then callback(textBox.Text) end
        end)
        
        if isInSection then
            local separator = Instance.new("Frame")
            separator.Name = "Separator"
            separator.Size = UDim2.new(1, 0, 0, 1)
            separator.Position = UDim2.new(0, 0, 1, 5)
            separator.AnchorPoint = Vector2.new(0, 1)
            separator.BackgroundColor3 = colors.outline
            separator.BorderSizePixel = 0
            separator.Parent = frame
            
            local function updateSeparator()
                local children = parent:GetChildren()
                local uiElements = {}
                for _, child in ipairs(children) do
                    if (child:IsA("TextButton") or (child:IsA("Frame") and child.Name ~= "Content" and child:FindFirstChildOfClass("UIListLayout") == nil and not child:IsA("TextLabel"))) then
                        table.insert(uiElements, child)
                    end
                end
                separator.Visible = (frame ~= uiElements[#uiElements] and #uiElements > 1)
            end
            
            task.spawn(function()
                task.wait()
                updateSeparator()
            end)
            local layout = parent:FindFirstChildOfClass("UIListLayout")
            if layout then
                layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
                    task.wait()
                    updateSeparator()
                end)
            end
        end
        
        return frame
    end
    
    function windowObj:MakeNumberInput(parent, name, placeholder, callback)
        local isInSection = parent and parent.Name == "Content"
        
        local frame = Instance.new("Frame")
        frame.Size = UDim2.new(1, 0, 0, 50)
        frame.BackgroundColor3 = colors.secondary
        frame.BorderSizePixel = 0
        frame.Parent = parent
        
        local label = Instance.new("TextLabel")
        label.Size = UDim2.new(1, -24, 0, 18)
        label.Position = UDim2.new(0, 12, 0, 6)
        label.BackgroundTransparency = 1
        label.Text = name
        label.TextColor3 = colors.white
        label.TextSize = 14
        label.Font = Enum.Font.Gotham
        label.TextXAlignment = Enum.TextXAlignment.Left
        label.Parent = frame
        
        local inputBox = Instance.new("Frame")
        inputBox.Size = UDim2.new(1, -24, 0, 26)
        inputBox.Position = UDim2.new(0, 12, 0, 24)
        inputBox.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
        inputBox.BorderSizePixel = 0
        inputBox.Parent = frame
        
        local inputBoxCorner = Instance.new("UICorner")
        inputBoxCorner.CornerRadius = UDim.new(0, 4)
        inputBoxCorner.Parent = inputBox
        
        local inputBoxStroke = Instance.new("UIStroke")
        inputBoxStroke.Color = colors.outline
        inputBoxStroke.Thickness = 1
        inputBoxStroke.Parent = inputBox
        
        local textBox = Instance.new("TextBox")
        textBox.Size = UDim2.new(1, -8, 1, -4)
        textBox.Position = UDim2.new(0, 4, 0, 2)
        textBox.BackgroundTransparency = 1
        textBox.Text = ""
        textBox.PlaceholderText = placeholder or ""
        textBox.TextColor3 = colors.white
        textBox.PlaceholderColor3 = colors.gray
        textBox.TextSize = 14
        textBox.Font = Enum.Font.Gotham
        textBox.TextXAlignment = Enum.TextXAlignment.Left
        textBox.ClearTextOnFocus = false
        textBox.Parent = inputBox
        
        local isExpanding = false
        
        textBox:GetPropertyChangedSignal("TextBounds"):Connect(function()
            if not textBox:IsFocused() and not isExpanding then
                local textWidth = math.max(150, textBox.TextBounds.X + 20)
                TweenService:Create(inputBox, TweenInfo.new(0.2), {
                    Size = UDim2.new(0, textWidth, 0, 26)
                }):Play()
            end
        end)
        
        textBox.Focused:Connect(function()
            isExpanding = true
            TweenService:Create(inputBox, TweenInfo.new(0.2), {
                Size = UDim2.new(1, -24, 0, 26)
            }):Play()
            task.wait(0.2)
            isExpanding = false
        end)
        
        textBox.FocusLost:Connect(function()
            isExpanding = true
            local textWidth = math.max(150, textBox.TextBounds.X + 20)
            TweenService:Create(inputBox, TweenInfo.new(0.2), {
                Size = UDim2.new(0, textWidth, 0, 26)
            }):Play()
            task.wait(0.2)
            isExpanding = false
            local num = tonumber(textBox.Text)
            if callback then callback(num) end
        end)
        
        if isInSection then
            local separator = Instance.new("Frame")
            separator.Name = "Separator"
            separator.Size = UDim2.new(1, 0, 0, 1)
            separator.Position = UDim2.new(0, 0, 1, 5)
            separator.AnchorPoint = Vector2.new(0, 1)
            separator.BackgroundColor3 = colors.outline
            separator.BorderSizePixel = 0
            separator.Parent = frame
            
            local function updateSeparator()
                local children = parent:GetChildren()
                local uiElements = {}
                for _, child in ipairs(children) do
                    if (child:IsA("TextButton") or (child:IsA("Frame") and child.Name ~= "Content" and child:FindFirstChildOfClass("UIListLayout") == nil and not child:IsA("TextLabel"))) then
                        table.insert(uiElements, child)
                    end
                end
                separator.Visible = (frame ~= uiElements[#uiElements] and #uiElements > 1)
            end
            
            task.spawn(function()
                task.wait()
                updateSeparator()
            end)
            local layout = parent:FindFirstChildOfClass("UIListLayout")
            if layout then
                layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
                    task.wait()
                    updateSeparator()
                end)
            end
        end
        
        return frame
    end
    
    function windowObj:MakeCheckbox(parent, text, description, default, callback)
        local isInSection = parent and parent.Name == "Content"
        local checked = default or false
        
        local frame = Instance.new("Frame")
        frame.Size = UDim2.new(1, 0, 0, description and 40 or 30)
        frame.BackgroundColor3 = colors.secondary
        frame.BorderSizePixel = 0
        frame.Parent = parent
        
        local label = Instance.new("TextLabel")
        label.Size = UDim2.new(1, -50, 0, 20)
        label.Position = UDim2.new(0, 12, 0, 5)
        label.BackgroundTransparency = 1
        label.Text = text
        label.TextColor3 = colors.white
        label.TextSize = 14
        label.Font = Enum.Font.Gotham
        label.TextXAlignment = Enum.TextXAlignment.Left
        label.Parent = frame
        
        local checkbox = Instance.new("TextButton")
        checkbox.Size = UDim2.new(0, 18, 0, 18)
        checkbox.Position = UDim2.new(1, -28, 0.5, 0)
        checkbox.AnchorPoint = Vector2.new(1, 0.5)
        checkbox.BackgroundColor3 = colors.secondary
        checkbox.BorderSizePixel = 0
        checkbox.Text = ""
        checkbox.Parent = frame
        
        local checkboxCorner = Instance.new("UICorner")
        checkboxCorner.CornerRadius = UDim.new(0, 3)
        checkboxCorner.Parent = checkbox
        
        local checkboxStroke = Instance.new("UIStroke")
        checkboxStroke.Color = colors.outline
        checkboxStroke.Thickness = 1
        checkboxStroke.Parent = checkbox
        
        local checkmark = Instance.new("TextLabel")
        checkmark.Size = UDim2.new(1, 0, 1, 0)
        checkmark.BackgroundTransparency = 1
        checkmark.Text = "✓"
        checkmark.TextColor3 = colors.white
        checkmark.TextSize = 14
        checkmark.Font = Enum.Font.GothamBold
        checkmark.TextTransparency = checked and 0 or 1
        checkmark.Parent = checkbox
        
        if description then
            local desc = Instance.new("TextLabel")
            desc.Size = UDim2.new(1, -40, 0, 15)
            desc.Position = UDim2.new(0, 35, 0, 22)
            desc.BackgroundTransparency = 1
            desc.Text = description
            desc.TextColor3 = colors.gray
            desc.TextSize = 12
            desc.Font = Enum.Font.Gotham
            desc.TextXAlignment = Enum.TextXAlignment.Left
            desc.Parent = frame
        end
        
        checkbox.MouseButton1Click:Connect(function()
            checked = not checked
            TweenService:Create(checkmark, TweenInfo.new(0.15), {
                TextTransparency = checked and 0 or 1
            }):Play()
            TweenService:Create(checkbox, TweenInfo.new(0.15), {
                BackgroundColor3 = checked and colors.light or colors.secondary
            }):Play()
            if callback then callback(checked) end
        end)
        
        if isInSection then
            local separator = Instance.new("Frame")
            separator.Name = "Separator"
            separator.Size = UDim2.new(1, 0, 0, 1)
            separator.Position = UDim2.new(0, 0, 1, 5)
            separator.AnchorPoint = Vector2.new(0, 1)
            separator.BackgroundColor3 = colors.outline
            separator.BorderSizePixel = 0
            separator.Parent = frame
            
            local function updateSeparator()
                local children = parent:GetChildren()
                local uiElements = {}
                for _, child in ipairs(children) do
                    if (child:IsA("TextButton") or (child:IsA("Frame") and child.Name ~= "Content" and child:FindFirstChildOfClass("UIListLayout") == nil and not child:IsA("TextLabel"))) then
                        table.insert(uiElements, child)
                    end
                end
                separator.Visible = (frame ~= uiElements[#uiElements] and #uiElements > 1)
            end
            
            task.spawn(function()
                task.wait()
                updateSeparator()
            end)
            local layout = parent:FindFirstChildOfClass("UIListLayout")
            if layout then
                layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
                    task.wait()
                    updateSeparator()
                end)
            end
        end
        
        return frame
    end
    
    return windowObj
end

return UILibrary

