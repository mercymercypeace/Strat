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

print("===========================================")
print("script loaded successfully")
print("YAHHHH")
print("===========================================")
