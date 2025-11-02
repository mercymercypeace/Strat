if _G.GUILoaded then return end
_G.GUILoaded = true

local HttpService = game:GetService("HttpService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local function loadLibrary()
    local success, result = pcall(function()
        local response = HttpService:GetAsync("https://raw.githubusercontent.com/YOUR_USERNAME/YOUR_REPO/main/ui_library.lua")
        local lib = loadstring(response)()
        return lib
    end)
    
    if success and result then
        return result
    else
        warn("Failed to load UI library:", result)
        return nil
    end
end

local UILibrary = loadLibrary()
if not UILibrary then return end

local colors = UILibrary.Colors

local window = UILibrary:CreateWindow("LunarisX", UDim2.new(0, 600, 0, 400))

local ExampleTab = window:CreateTab("Example", "", false)
local SettingsTab = window:CreateTab("Settings", "", false)

if window.Tabs["Example"] then
    window.Tabs["Example"].Page.Visible = true
    window.Tabs["Example"].Button.BackgroundColor3 = colors.light
    if window.Tabs["Example"].Indicator then
        window.Tabs["Example"].Indicator.Visible = true
        window.Tabs["Example"].Indicator.BackgroundTransparency = 0
    end
    if window.Tabs["Example"].Icon then
        window.Tabs["Example"].Icon.TextColor3 = colors.white
    end
    window.Tabs["Example"].Label.TextColor3 = colors.white
    window.Tabs["Example"].IsSelected = true
end

local gui = window.Window.Parent

local toggle = Instance.new("TextButton")
toggle.Size = UDim2.new(0, 60, 0, 60)
toggle.Position = UDim2.new(0, 20, 0.5, -30)
toggle.BackgroundColor3 = colors.primary
toggle.BorderSizePixel = 0
toggle.Text = ""
toggle.Parent = gui

local toggleCorner = Instance.new("UICorner")
toggleCorner.CornerRadius = UDim.new(0, 15)
toggleCorner.Parent = toggle

local toggleStroke = Instance.new("UIStroke")
toggleStroke.Color = colors.outline
toggleStroke.Thickness = 0.3
toggleStroke.Transparency = 0
toggleStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
toggleStroke.Parent = toggle

local toggleImage = Instance.new("ImageLabel")
toggleImage.Size = UDim2.new(0, 40, 0, 40)
toggleImage.Position = UDim2.new(0.5, 0, 0.5, 0)
toggleImage.AnchorPoint = Vector2.new(0.5, 0.5)
toggleImage.BackgroundTransparency = 1
toggleImage.Image = "rbxassetid://127229998224259"
toggleImage.Parent = toggle

local imageCorner = Instance.new("UICorner")
imageCorner.CornerRadius = UDim.new(0, 12)
imageCorner.Parent = toggleImage

local isOpen = false
local isMinimized = false

local function toggleMinimize()
    if isMinimized then
        isMinimized = false
        TweenService:Create(window.Window, TweenInfo.new(0.4, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
            Size = UDim2.new(0, 600, 0, 400)
        }):Play()
        
        task.wait(0.2)
        for _, child in ipairs(window.Window:GetDescendants()) do
            if child ~= window.Topbar and not child:IsDescendantOf(window.Topbar) then
                if child:IsA("TextLabel") and child.TextTransparency == 1 then
                    TweenService:Create(child, TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                        TextTransparency = 0
                    }):Play()
                elseif child:IsA("Frame") and child.BackgroundTransparency == 1 and child.Name ~= "Content" then
                    TweenService:Create(child, TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                        BackgroundTransparency = 0
                    }):Play()
                elseif child:IsA("UIStroke") and child.Transparency == 1 then
                    TweenService:Create(child, TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                        Transparency = 0
                    }):Play()
                end
            end
        end
    else
        isMinimized = true
        
        for _, child in ipairs(window.Window:GetDescendants()) do
            if child ~= window.Topbar and not child:IsDescendantOf(window.Topbar) then
                if child:IsA("TextLabel") and child.TextTransparency == 0 then
                    TweenService:Create(child, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.In), {
                        TextTransparency = 1
                    }):Play()
                elseif child:IsA("Frame") and child.BackgroundTransparency == 0 and child.Name ~= "Content" then
                    TweenService:Create(child, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.In), {
                        BackgroundTransparency = 1
                    }):Play()
                elseif child:IsA("UIStroke") and child.Transparency == 0 and child.Parent ~= window.Window then
                    TweenService:Create(child, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.In), {
                        Transparency = 1
                    }):Play()
                end
            end
        end
        
        task.wait(0.15)
        
        TweenService:Create(window.Window, TweenInfo.new(0.4, Enum.EasingStyle.Quint, Enum.EasingDirection.In), {
            Size = UDim2.new(0, 600, 0, 50)
        }):Play()
    end
end

local function open()
    if isOpen then return end
    isOpen = true
    window.Window.Visible = true
    window.Window.Size = UDim2.new(0, 0, 0, 0)
    window.Window.BackgroundTransparency = 1
    window.WindowStroke.Transparency = 1
    
    TweenService:Create(toggle, TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
        BackgroundTransparency = 1,
        Size = UDim2.new(0, 0, 0, 0)
    }):Play()
    
    TweenService:Create(toggleImage, TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
        ImageTransparency = 1,
        Size = UDim2.new(0, 0, 0, 0)
    }):Play()
    
    TweenService:Create(toggleStroke, TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
        Transparency = 1
    }):Play()
    
    task.wait(0.15)
    
    TweenService:Create(window.Window, TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
        Size = UDim2.new(0, 600, 0, 400)
    }):Play()
    
    TweenService:Create(window.Window, TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
        BackgroundTransparency = 0
    }):Play()
    
    task.wait(0.15)
    TweenService:Create(window.WindowStroke, TweenInfo.new(0.4, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
        Transparency = 0
    }):Play()
    
    task.wait(0.35)
    toggle.Visible = false
end

local function closeUI()
    if not isOpen then return end
    isOpen = false
    
    local function fadeOutChildren(parent)
        for _, child in ipairs(parent:GetDescendants()) do
            if child:IsA("TextLabel") or child:IsA("TextButton") then
                if child:IsA("TextLabel") and child.TextTransparency ~= 1 then
                    TweenService:Create(child, TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.In), {
                        TextTransparency = 1
                    }):Play()
                elseif child:IsA("TextButton") and child.TextTransparency ~= 1 then
                    TweenService:Create(child, TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.In), {
                        TextTransparency = 1
                    }):Play()
                end
            elseif child:IsA("Frame") and child.BackgroundTransparency ~= 1 and child ~= window.Window then
                local isSeparator = child.Name == "Separator" or child.Name == "HeaderSeparator" or child.Name == "TopSeparator" or child.Name == "SideSeparator"
                if not isSeparator then
                    TweenService:Create(child, TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.In), {
                        BackgroundTransparency = 1
                    }):Play()
                end
            elseif child:IsA("UIStroke") and child.Transparency ~= 1 then
                TweenService:Create(child, TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.In), {
                    Transparency = 1
                }):Play()
            elseif child:IsA("ImageLabel") and child.ImageTransparency ~= 1 then
                TweenService:Create(child, TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.In), {
                    ImageTransparency = 1
                }):Play()
            end
        end
    end
    
    fadeOutChildren(window.Window)
    
    task.wait(0.1)
    
    TweenService:Create(window.Window, TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.In), {
        BackgroundTransparency = 1,
        Size = UDim2.new(0, 0, 0, 0),
        Position = UDim2.new(0.5, 0, 0.5, 0)
    }):Play()
    
    TweenService:Create(window.WindowStroke, TweenInfo.new(0.4, Enum.EasingStyle.Quint, Enum.EasingDirection.In), {
        Transparency = 1
    }):Play()
    
    TweenService:Create(window.Title, TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.In), {
        TextTransparency = 1
    }):Play()
    
    TweenService:Create(window.Close, TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.In), {
        TextTransparency = 1
    }):Play()
    
    TweenService:Create(window.Minimize, TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.In), {
        TextTransparency = 1
    }):Play()
    
    task.wait(0.4)
    
    toggle.Visible = true
    toggle.Size = UDim2.new(0, 0, 0, 0)
    toggle.BackgroundTransparency = 1
    toggleImage.ImageTransparency = 1
    toggleImage.Size = UDim2.new(0, 0, 0, 0)
    toggleStroke.Transparency = 1
    
    TweenService:Create(toggle, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        BackgroundTransparency = 0,
        Size = UDim2.new(0, 60, 0, 60)
    }):Play()
    
    TweenService:Create(toggleImage, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        ImageTransparency = 0,
        Size = UDim2.new(0, 40, 0, 40)
    }):Play()
    
    TweenService:Create(toggleStroke, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Transparency = 0
    }):Play()
    
    task.wait(0.5)
    window.Window.Visible = false
    
    task.spawn(function()
        task.wait(0.1)
        for _, child in ipairs(window.Window:GetDescendants()) do
            if child:IsA("TextLabel") then
                child.TextTransparency = 0
            elseif child:IsA("TextButton") then
                child.TextTransparency = 0
            elseif child:IsA("Frame") and child ~= window.Window then
                child.BackgroundTransparency = child:FindFirstAncestorOfClass("Frame") and 1 or 0
            elseif child:IsA("UIStroke") then
                child.Transparency = 0
            elseif child:IsA("ImageLabel") then
                child.ImageTransparency = 0
            end
        end
    end)
end

window.Minimize.MouseButton1Click:Connect(function()
    toggleMinimize()
end)

window.Close.MouseButton1Click:Connect(function()
    closeUI()
end)

local dragState = false
local dragStart = nil
local startPos = nil
local moved = false

toggle.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragState = true
        moved = false
        dragStart = input.Position
        startPos = toggle.Position
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragState = false
            end
        end)
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragState and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        if delta.Magnitude > 5 then
            moved = true
        end
        toggle.Position = UDim2.new(
            startPos.X.Scale,
            startPos.X.Offset + delta.X,
            startPos.Y.Scale,
            startPos.Y.Offset + delta.Y
        )
    end
end)

toggle.MouseButton1Click:Connect(function()
    if not moved then
        if isOpen then
            closeUI()
        else
            open()
        end
    end
end)

local windowDrag = false
local windowStart = nil
local windowPos = nil
local dragConnection = nil

window.Topbar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        windowDrag = true
        windowStart = input.Position
        windowPos = window.Window.Position
        
        window.Topbar.BackgroundTransparency = 0.05
        
        dragConnection = input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                windowDrag = false
                window.Topbar.BackgroundTransparency = 0
                if dragConnection then
                    dragConnection:Disconnect()
                    dragConnection = nil
                end
            end
        end)
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if windowDrag and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - windowStart
        window.Window.Position = UDim2.new(
            windowPos.X.Scale,
            windowPos.X.Offset + delta.X,
            windowPos.Y.Scale,
            windowPos.Y.Offset + delta.Y
        )
    end
end)

window.Minimize.MouseEnter:Connect(function()
    TweenService:Create(window.Minimize, TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
        TextColor3 = Color3.fromRGB(255, 200, 0),
        Size = UDim2.new(0, 38, 0, 38)
    }):Play()
end)

window.Minimize.MouseLeave:Connect(function()
    TweenService:Create(window.Minimize, TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
        TextColor3 = colors.white,
        Size = UDim2.new(0, 35, 0, 35)
    }):Play()
end)

toggle.MouseEnter:Connect(function()
    TweenService:Create(toggle, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
        Size = UDim2.new(0, 68, 0, 68)
    }):Play()
    TweenService:Create(toggleImage, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
        Size = UDim2.new(0, 45, 0, 45)
    }):Play()
    TweenService:Create(toggle, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
        BackgroundTransparency = 0.1
    }):Play()
end)

toggle.MouseLeave:Connect(function()
    if not dragState then
        TweenService:Create(toggle, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.In), {
            Size = UDim2.new(0, 60, 0, 60)
        }):Play()
        TweenService:Create(toggleImage, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.In), {
            Size = UDim2.new(0, 40, 0, 40)
        }):Play()
        TweenService:Create(toggle, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.In), {
            BackgroundTransparency = 0
        }):Play()
    end
end)

window.Close.MouseEnter:Connect(function()
    TweenService:Create(window.Close, TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
        TextColor3 = Color3.fromRGB(237, 66, 69),
        Size = UDim2.new(0, 38, 0, 38)
    }):Play()
end)

window.Close.MouseLeave:Connect(function()
    TweenService:Create(window.Close, TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
        TextColor3 = colors.white,
        Size = UDim2.new(0, 35, 0, 35)
    }):Play()
end)

local MainSectionContent = window:CreateSection(ExampleTab, "Main")
local mainBtn = window:MakeButton(MainSectionContent, "⭐ Main", function()
    print("Main button clicked!")
end)

local TestingTextSectionContent = window:CreateSection(ExampleTab, "Testing Text")
local testText = Instance.new("TextLabel")
testText.Size = UDim2.new(1, -20, 0, 30)
testText.Position = UDim2.new(0, 10, 0, 0)
testText.BackgroundTransparency = 1
testText.Text = "Hey this text is Golden,Red,Blue"
testText.TextColor3 = colors.white
testText.TextSize = 14
testText.Font = Enum.Font.GothamBold
testText.TextXAlignment = Enum.TextXAlignment.Left
testText.Parent = TestingTextSectionContent

local ButtonSectionContent = window:CreateSection(ExampleTab, "Button")
local testBtn = window:MakeButton(ButtonSectionContent, "Test Button", function()
    print("yipee")
end)

print("GUI Loaded! Click the floating button to open.")

