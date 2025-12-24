--[[
    Example Usage of UILibrary
    This demonstrates how to use the UI Library to create a script hub
    
    To use:
    1. Load the UILibrary first (either from a URL or local file)
    2. Create a window
    3. Add tabs, sections, and controls
    4. Handle callbacks for user interactions
]]

-- Load the UI Library
-- Option 1: Load from GitHub (Recommended)
local UI = loadstring(game:HttpGet("https://raw.githubusercontent.com/mercymercypeace/Strat/refs/heads/main/Rework%20Ui/UILibrary.lua"))()

-- Option 2: Load from local file (if using require or similar)
-- local UI = require(script.Parent.UILibrary)

-- Option 3: If both files are in the same executor workspace, you can use:
-- Note: readfile is executor-specific (Synapse, Script-Ware, etc.)
-- local UI = loadstring(readfile("UILibrary.lua"))() -- Executor-specific function

-- Initialize getgenv for storing config (executor compatibility)
local env = _G
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

local Config = env.ScriptHubConfig or {
    Speed = 5,
    FarmMode = "Normal",
    TargetName = "",
    AutoFarm = false,
    AutoCollect = false,
    AutoSell = false
}
env.ScriptHubConfig = Config

-- Helper function to update config
local function updateConfig(key, value)
    Config[key] = value
    env.ScriptHubConfig[key] = value
end

-- Create the main window
local window = UI:CreateWindow("Script Hub", 600, 400)

-- Create tabs
local mainTab = window:CreateTab("Main", "Main")
local settingsTab = window:CreateTab("Settings", "Settings")
local announcementTab = window:CreateAnnouncementTab("Announcements", "Announcements")

-- Main Tab Content
local mainSection = mainTab:CreateSection("Example Controls")

-- Add a label
local statusLabel = mainSection:AddLabel("Status: Ready", {
    TextColor3 = Color3.fromRGB(50, 200, 50),
    Font = Enum.Font.GothamBold
})

-- Add a divider
mainSection:AddDivider("Controls")

-- Add a toggle switch
local autoFarmToggle = mainSection:AddToggle("Auto Farm", false, function(state)
    updateConfig("AutoFarm", state)
    statusLabel:SetText("Status: " .. (state and "Auto Farm Enabled" or "Auto Farm Disabled"))
    window:ShowNotification(state and "Auto Farm Enabled" or "Auto Farm Disabled", state and "success" or "info", 2)
    print("Auto Farm:", state)
end)

-- Add tooltip to toggle
UI:AddTooltip(autoFarmToggle._button, "Toggle auto farming on/off")

-- Add a keybind
mainSection:AddKeybind("Toggle Key", Enum.KeyCode.F, function(keyCode)
    updateConfig("ToggleKey", keyCode)
    print("Toggle key set to:", keyCode)
    window:ShowNotification("Keybind set to " .. tostring(keyCode):gsub("Enum.KeyCode.", ""), "success", 2)
end)

-- Add a divider with text
mainSection:AddDivider("Settings")

-- Add a slider
mainSection:AddSlider("Example Slider", 0, 100, 50, function(value)
    updateConfig("ExampleSlider", value)
    print("Slider value:", value)
end)

-- Add multi-option checkboxes
mainSection:AddMultiOption("Example Multi Options", {"Option 1", "Option 2", "Option 3", "Option 4"}, function(selected)
    updateConfig("ExampleMultiOptions", selected)
    print("Selected options:", selected)
end)

-- Add a dropdown select
mainSection:AddSelect("Example Select", {"Option A", "Option B", "Option C", "Option D"}, "Option A", function(selected)
    updateConfig("ExampleSelect", selected)
    print("Selected:", selected)
end)

-- Add a text input
mainSection:AddTextInput("Example Text", "Enter text here...", function(text, enterPressed)
    updateConfig("ExampleText", text)
    print("Text entered:", text)
end)

-- Add a button
local exampleButton = mainSection:AddButton("Example Button", function()
    print("Button clicked!")
    window:ShowNotification("Button clicked!", "info", 2)
    -- Add your logic here
end)

-- Add tooltip to button
UI:AddTooltip(exampleButton, "Click this button to perform an action")

-- Settings Tab Content
local settingsSection = settingsTab:CreateSection("Settings")

-- Add label
settingsSection:AddLabel("Configure your settings below:", {
    TextColor3 = Color3.fromRGB(200, 200, 200)
})

settingsSection:AddDivider()

-- Speed slider
settingsSection:AddSlider("Speed", 1, 10, 5, function(value)
    updateConfig("Speed", value)
    print("Speed set to:", value)
    window:ShowNotification("Speed set to " .. value, "info", 1.5)
end)

-- Features checkboxes
settingsSection:AddMultiOption("Features", {"Auto Farm", "Auto Collect", "Auto Sell"}, function(selected)
    updateConfig("Features", selected)
    -- Store individual feature states for easy access
    updateConfig("AutoFarm", selected["Auto Farm"] or false)
    updateConfig("AutoCollect", selected["Auto Collect"] or false)
    updateConfig("AutoSell", selected["Auto Sell"] or false)
    print("Features:", selected)
end)

-- Farm mode dropdown
settingsSection:AddSelect("Farm Mode", {"Normal", "Fast", "Ultra"}, "Normal", function(selected)
    updateConfig("FarmMode", selected)
    print("Farm mode:", selected)
    window:ShowNotification("Farm mode: " .. selected, "success", 2)
end)

-- Target name input
settingsSection:AddTextInput("Target Name", "Enter target name...", function(text, enterPressed)
    updateConfig("TargetName", text)
    print("Target:", text)
end)

settingsSection:AddDivider("Actions")

-- Save settings button
settingsSection:AddButton("Save Settings", function()
    print("Settings saved!")
    print("Current config:", Config)
    window:ShowNotification("Settings saved successfully!", "success", 3)
    -- Settings are automatically saved to getgenv().ScriptHubConfig
    -- Other scripts can access them like: getgenv().ScriptHubConfig.Speed
end)

-- Test notifications button
settingsSection:AddButton("Test Notifications", function()
    window:ShowNotification("This is an info notification", "info", 2)
    task.wait(0.5)
    window:ShowNotification("This is a success notification", "success", 2)
    task.wait(0.5)
    window:ShowNotification("This is a warning notification", "warning", 2)
    task.wait(0.5)
    window:ShowNotification("This is an error notification", "error", 2)
end)

-- You can add more sections to the same tab
local extraSection = mainTab:CreateSection("Extra Controls")

extraSection:AddButton("Start Auto Farm", function()
    if Config.AutoFarm then
        print("Starting auto farm...")
        window:ShowNotification("Auto Farm Started", "success", 2)
        -- Add your auto farm logic here
    else
        print("Please enable Auto Farm in settings first!")
        window:ShowNotification("Please enable Auto Farm first!", "warning", 3)
    end
end)

extraSection:AddButton("Stop Auto Farm", function()
    print("Stopping auto farm...")
    window:ShowNotification("Auto Farm Stopped", "info", 2)
    -- Add your stop logic here
end)

extraSection:AddDivider()

-- Test minimize/maximize
extraSection:AddButton("Minimize Window", function()
    window:Minimize()
end)

extraSection:AddButton("Maximize Window", function()
    window:Maximize()
end)

-- Announcements Tab
-- Add sample announcements (user will provide their own script later)
announcementTab:AddAnnouncement(
    "Welcome to Script Hub",
    "This is a sample announcement. You can add your own announcements using the AddAnnouncement method. The announcement system supports titles, content, and dates.",
    "Today"
)

announcementTab:AddAnnouncement(
    "New Features Added",
    "We've added many new features including toggles, keybinds, labels, dividers, notifications, minimize/maximize, tooltips, and an announcement system!",
    "Recently"
)

announcementTab:AddAnnouncement(
    "How to Use",
    "1. Configure your settings in the Settings tab\n2. Use the Main tab to control your scripts\n3. Check announcements for updates\n4. Use tooltips for help (hover over elements)",
    "Getting Started"
)

print("Script Hub loaded successfully!")
print("Access config from other scripts using: getgenv().ScriptHubConfig")
print("Features: Toggle, Keybind, Label, Divider, Notifications, Minimize/Maximize, Tooltips, Announcements")

