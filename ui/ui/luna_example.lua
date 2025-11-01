local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local ToggleButton = Instance.new("ScreenGui")
ToggleButton.Name = "Toggle"
ToggleButton.ResetOnSpawn = false
ToggleButton.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

if gethui then
    ToggleButton.Parent = gethui()
elseif syn and syn.protect_gui then
    syn.protect_gui(ToggleButton)
    ToggleButton.Parent = game.CoreGui
else
    ToggleButton.Parent = game.CoreGui
end

local DragButton = Instance.new("ImageButton")
DragButton.Name = "dragbutton"
DragButton.Size = UDim2.new(0, 60, 0, 60)
DragButton.Position = UDim2.new(0, 20, 0.5, -30)
DragButton.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
DragButton.BorderSizePixel = 0
DragButton.Image = "rbxassetid://83759238826509"
DragButton.ScaleType = Enum.ScaleType.Fit
DragButton.ImageTransparency = 0
DragButton.Parent = ToggleButton

local Corner = Instance.new("UICorner")
Corner.CornerRadius = UDim.new(0, 18)
Corner.Parent = DragButton

local Stroke = Instance.new("UIStroke")
Stroke.Color = Color3.fromRGB(100, 100, 255)
Stroke.Thickness = 2
Stroke.Transparency = 0.5
Stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
Stroke.Parent = DragButton

local Shadow = Instance.new("ImageLabel")
Shadow.Name = "Shadow"
Shadow.Size = UDim2.new(1, 20, 1, 20)
Shadow.Position = UDim2.new(0.5, 0, 0.5, 0)
Shadow.AnchorPoint = Vector2.new(0.5, 0.5)
Shadow.BackgroundTransparency = 1
Shadow.Image = "rbxassetid://16300778179"
Shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
Shadow.ImageTransparency = 0.6
Shadow.ZIndex = 0
Shadow.Parent = DragButton

local isDragging = false
local dragInput
local dragStart
local startPos
local hasMoved = false

local function updateInput(input)
    local luna = input.Position - dragStart
    if luna.Magnitude > 5 then
        hasMoved = true
    end
    DragButton.Position = UDim2.new(
        startPos.X.Scale,
        startPos.X.Offset + luna.X,
        startPos.Y.Scale,
        startPos.Y.Offset + luna.Y
    )
end

DragButton.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        isDragging = true
        hasMoved = false
        dragStart = input.Position
        startPos = DragButton.Position
        
        TweenService:Create(DragButton, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
            Size = UDim2.new(0, 55, 0, 55)
        }):Play()
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                isDragging = false
                TweenService:Create(DragButton, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
                    Size = UDim2.new(0, 60, 0, 60)
                }):Play()
            end
        end)
    end
end)

DragButton.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and isDragging then
        updateInput(input)
    end
end)

DragButton.MouseEnter:Connect(function()
    TweenService:Create(Stroke, TweenInfo.new(0.2), {Transparency = 0.2}):Play()
    TweenService:Create(DragButton, TweenInfo.new(0.2), {Size = UDim2.new(0, 65, 0, 65)}):Play()
end)

DragButton.MouseLeave:Connect(function()
    if not isDragging then
        TweenService:Create(Stroke, TweenInfo.new(0.2), {Transparency = 0.5}):Play()
        TweenService:Create(DragButton, TweenInfo.new(0.2), {Size = UDim2.new(0, 60, 0, 60)}):Play()
    end
end)

local Luna = loadstring(game:HttpGet("https://raw.nebulasoftworks.xyz/luna", true))()

local Window = Luna:CreateWindow({
    Name = "LunarisX",
    Subtitle = "example123",
    LogoID = "6031097225",
    LoadingEnabled = true,
    LoadingTitle = "loading blah blah blah..",
    LoadingSubtitle = "wait a sec",
    ConfigSettings = {
        RootFolder = nil,
        ConfigFolder = "LunarisX"
    },
    KeySystem = false,
    KeySettings = {
        Title = "key thing",
        Subtitle = "get the damn key",
        Note = "example",
        SaveKey = true,
        Key = {"ExampleKey123"},
        SecondAction = {
            Enabled = true,
            Type = "Discord",
            Parameter = "exampleserver"
        }
    }
})

local MainTab = Window:CreateTab({
    Name = "Main",
    Icon = "home",
    ImageSource = "Material",
    ShowTitle = true
})

local PlayerTab = Window:CreateTab({
    Name = "Player",
    Icon = "account_circle",
    ImageSource = "Material",
    ShowTitle = true
})

local VisualsTab = Window:CreateTab({
    Name = "Visuals",
    Icon = "visibility",
    ImageSource = "Material",
    ShowTitle = true
})

local SettingsTab = Window:CreateTab({
    Name = "Settings",
    Icon = "settings",
    ImageSource = "Material",
    ShowTitle = true
})

MainTab:CreateSection("Welcome")

MainTab:CreateParagraph({
    Title = "welcome",
    Text = "cool stuff"
})

MainTab:CreateLabel({
    Text = "epic",
    Style = 2
})

MainTab:CreateSection("main stuff")

MainTab:CreateButton({
    Name = "click to run script",
    Description = "literally just runs the main thing",
    Callback = function()
        Luna:Notification({
            Title = "it worked yay",
            Icon = "check_circle",
            ImageSource = "Material",
            Content = "sigma"
        })
        print("finally runs lmao")
    end
})

MainTab:CreateToggle({
    Name = "auto farm",
    Description = "just an example stuff",
    CurrentValue = false,
    Callback = function(Value)
        print("auto farm is:", Value)
    end
}, "AutoFarm")

MainTab:CreateToggle({
    Name = "anti afk",
    Description = "also an example",
    CurrentValue = false,
    Callback = function(Value)
        print("anti afk:", Value)
    end
}, "AntiAFK")

PlayerTab:CreateSection("movement")

PlayerTab:CreateSlider({
    Name = "walk speed",
    Range = {16, 200},
    Increment = 1,
    CurrentValue = 16,
    Callback = function(Value)
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
    end
}, "WalkSpeed")

PlayerTab:CreateSlider({
    Name = "jump power",
    Range = {50, 500},
    Increment = 5,
    CurrentValue = 50,
    Callback = function(Value)
        game.Players.LocalPlayer.Character.Humanoid.JumpPower = Value
    end
}, "JumpPower")

PlayerTab:CreateSection("misc")

PlayerTab:CreateToggle({
    Name = "infinite jump",
    Description = "u can just keep jumping lol",
    CurrentValue = false,
    Callback = function(Value)
        print("infinite jump:", Value)
    end
}, "InfiniteJump")

PlayerTab:CreateToggle({
    Name = "noclip",
    Description = "walk thru walls its op",
    CurrentValue = false,
    Callback = function(Value)
        print("noclip:", Value)
    end
}, "NoClip")

PlayerTab:CreateButton({
    Name = "reset",
    Description = "resets ur character if u get stuck or something",
    Callback = function()
        game.Players.LocalPlayer.Character.Humanoid.Health = 0
    end
})

VisualsTab:CreateSection("esp settings")

VisualsTab:CreateToggle({
    Name = "player esp",
    Description = "see players thru walls",
    CurrentValue = false,
    Callback = function(Value)
        print("player esp:", Value)
    end
}, "PlayerESP")

VisualsTab:CreateToggle({
    Name = "name esp",
    Description = "shows names above players",
    CurrentValue = false,
    Callback = function(Value)
        print("name esp:", Value)
    end
}, "NameESP")

VisualsTab:CreateToggle({
    Name = "distance esp",
    Description = "shows how far away ppl are",
    CurrentValue = false,
    Callback = function(Value)
        print("distance esp:", Value)
    end
}, "DistanceESP")

VisualsTab:CreateSection("esp colors")

VisualsTab:CreateColorPicker({
    Name = "ally color",
    Color = Color3.fromRGB(0, 255, 0),
    Callback = function(Value)
        print("ally color:", Value)
    end
}, "AllyColor")

VisualsTab:CreateColorPicker({
    Name = "enemy color",
    Color = Color3.fromRGB(255, 0, 0),
    Callback = function(Value)
        print("enemy color:", Value)
    end
}, "EnemyColor")

VisualsTab:CreateSection("other visual stuff")

VisualsTab:CreateToggle({
    Name = "fullbright",
    Description = "makes everything bright so u can see better",
    CurrentValue = false,
    Callback = function(Value)
        print("fullbright:", Value)
    end
}, "Fullbright")

VisualsTab:CreateSlider({
    Name = "FOV",
    Range = {70, 120},
    Increment = 1,
    CurrentValue = 70,
    Callback = function(Value)
        workspace.CurrentCamera.FieldOfView = Value
    end
}, "FOV")

SettingsTab:CreateSection("ui settings")

SettingsTab:CreateDropdown({
    Name = "ui theme",
    Description = "change the colors of the ui",
    Options = {"Default", "Purple", "Blue", "Red", "Green"},
    CurrentOption = {"Default"},
    MultipleOptions = false,
    Callback = function(Option)
        print("theme changed to:", Option)
    end
}, "Theme")

SettingsTab:CreateInput({
    Name = "username",
    Description = "type ur username here",
    PlaceholderText = "ur name",
    CurrentValue = "",
    Numeric = false,
    MaxCharacters = 20,
    Enter = false,
    Callback = function(Text)
        print("username:", Text)
    end
}, "Username")

SettingsTab:CreateSection("keybinds")

SettingsTab:CreateBind({
    Name = "toggle ui",
    Description = "press this to hide/show the ui",
    CurrentBind = "RightShift",
    HoldToInteract = false,
    Callback = function(Value)
        print("toggled the ui")
    end
}, "ToggleUI")

SettingsTab:CreateSection("notifications")

SettingsTab:CreateButton({
    Name = "test notification",
    Description = "click to test the notification thing",
    Callback = function()
        Luna:Notification({
            Title = "yo",
            Icon = "notifications",
            ImageSource = "Material",
            Content = "this is just a test notification lol"
        })
    end
})

SettingsTab:CreateSection("configs")

SettingsTab:CreateLabel({
    Text = "luna has configs built in which is nice",
    Style = 2
})

SettingsTab:CreateParagraph({
    Title = "config stuff",
    Text = "so basically luna saves ur settings automatically which is sick. just use the config tab to save and load stuff. u can even make it auto load when u start the script"
})

SettingsTab:CreateButton({
    Name = "make config tab",
    Description = "makes a tab where u can save and load configs",
    Callback = function()
        local ConfigTab = Window:CreateTab({
            Name = "Config",
            Icon = "save",
            ImageSource = "Material",
            ShowTitle = true
        })
        ConfigTab:BuildConfigSection()
    end
})

SettingsTab:CreateButton({
    Name = "make theme tab",
    Description = "makes a tab to customize the colors",
    Callback = function()
        local ThemeTab = Window:CreateTab({
            Name = "Theme",
            Icon = "palette",
            ImageSource = "Material",
            ShowTitle = true
        })
        ThemeTab:BuildThemeSection()
    end
})

Window:CreateHomeTab()

Luna:LoadAutoloadConfig()

Luna:Notification({
    Title = "loaded!",
    Icon = "check_circle",
    ImageSource = "Material",
    Content = "the script is loaded now enjoy :)"
})

local isUIVisible = true
local LunaUI = game:GetService("CoreGui"):FindFirstChild("Luna") or (gethui and gethui():FindFirstChild("Luna"))

DragButton.MouseButton1Click:Connect(function()
    if not hasMoved and LunaUI then
        isUIVisible = not isUIVisible
        LunaUI.Enabled = isUIVisible
        
        local targetColor = isUIVisible and Color3.fromRGB(100, 100, 255) or Color3.fromRGB(255, 100, 100)
        TweenService:Create(Stroke, TweenInfo.new(0.3), {Color = targetColor}):Play()
        
        TweenService:Create(DragButton, TweenInfo.new(0.15), {Rotation = 360}):Play()
        wait(0.15)
        DragButton.Rotation = 0
    end
end)

print("===========================================")
print("script loaded successfully")
print("YAHHHH")
print("===========================================")
