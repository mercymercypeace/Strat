local Luna = loadstring(game:HttpGet("https://raw.nebulasoftworks.xyz/luna", true))()

local Window = Luna:CreateWindow({
    Name = "simple script",
    Subtitle = "v1.0",
    LogoID = nil,
    LoadingEnabled = false,
    ConfigSettings = {
        ConfigFolder = "SimpleHub"
    },
    KeySystem = false
})

local Tab = Window:CreateTab({
    Name = "main",
    Icon = "home",
    ImageSource = "Material",
    ShowTitle = true
})

Tab:CreateSection("cool stuff")

Tab:CreateButton({
    Name = "click me lol",
    Callback = function()
        print("u clicked the button")
        Luna:Notification({
            Title = "nice",
            Icon = "check_circle",
            ImageSource = "Material",
            Content = "button got clicked"
        })
    end
})

Tab:CreateToggle({
    Name = "toggle thing",
    CurrentValue = false,
    Callback = function(Value)
        print("toggle is:", Value)
    end
}, "ExampleToggle")

Tab:CreateSlider({
    Name = "slider",
    Range = {0, 100},
    Increment = 1,
    CurrentValue = 50,
    Callback = function(Value)
        print("slider value:", Value)
    end
}, "ExampleSlider")

Tab:CreateInput({
    Name = "text box",
    PlaceholderText = "type something...",
    Callback = function(Text)
        print("u typed:", Text)
    end
}, "ExampleInput")

Tab:CreateDropdown({
    Name = "dropdown menu",
    Options = {"option 1", "option 2", "option 3"},
    CurrentOption = {"option 1"},
    MultipleOptions = false,
    Callback = function(Option)
        print("u picked:", Option)
    end
}, "ExampleDropdown")

Tab:CreateColorPicker({
    Name = "color picker",
    Color = Color3.fromRGB(255, 0, 0),
    Callback = function(Color)
        print("color:", Color)
    end
}, "ExampleColor")

Luna:LoadAutoloadConfig()
