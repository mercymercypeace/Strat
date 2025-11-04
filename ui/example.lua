local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/mercymercypeace/Strat/refs/heads/main/ui/ui_library.lua"))()

local Window = Library:Window({
    Title = "LunarisX",
    Desc = "best script fr",
    Icon = 127229998224259,
    Theme = "Dark",
    Version = "v1.0.0",
    DiscordLink = "https://discord.gg/ygmYdN2GJY",
    Config = {
        Keybind = Enum.KeyCode.LeftControl,
        Size = UDim2.new(0, 500, 0, 400)
    },
    CloseUIButton = {
        Enabled = true,
        Text = "LunarisX"
    }
})

local Tab = Window:Tab({Title = "Main", Icon = "star"}) do
    Tab:Section({Title = "Enable Feature"})
    Tab:Toggle({
        Title = "Enable Feature",
        Desc = "toggle to enable or disable",
        Value = false,
        Callback = function(v)
            print("toggle:", v)
        end
    })

    Tab:Section({Title = "Run Action"})
    Tab:Button({
        Title = "Run Action",
        Desc = "click to do something",
        Callback = function()
            print("button clicked!")
            Window:Notify({
                Title = "Button",
                Desc = "action done lol",
                Time = 3,
                Type = "normal"
            })
        end
    })

    Tab:Section({Title = "Input Text"})
    Tab:Textbox({
        Title = "Input Text",
        Desc = "type something here",
        Placeholder = "enter value",
        Value = "",
        ClearTextOnFocus = false,
        Callback = function(text)
            print("textbox:", text)
        end
    })

    Tab:Section({Title = "Set Speed"})
    Tab:Slider({
        Title = "Set Speed",
        Min = 0,
        Max = 100,
        Rounding = 0,
        Value = 25,
        Callback = function(val)
            print("slider:", val)
        end
    })

    Tab:Section({Title = "Choose Option"})
    Tab:Dropdown({
        Title = "Choose Option",
        List = {"Option 1", "Option 2", "Option 3"},
        Value = "Option 1",
        Callback = function(choice)
            print("selected:", choice)
        end
    })

    Tab:Section({Title = "Example Code"})
    local CodeBlock = Tab:Code({
        Title = "Example Code",
        Code = "-- this is code\nprint('hello world')"
    })

    task.delay(5, function()
        CodeBlock:SetCode("-- updated!\nprint('new stuff')")
    end)
end

Window:Line()

local Extra = Window:Tab({Title = "Extra", Icon = "tag"}) do
    Extra:Section({Title = "Show Message"})
    Extra:Button({
        Title = "Show Message",
        Desc = "show a popup",
        Callback = function()
            Window:Notify({
                Title = "LunarisX",
                Desc = "everything works!",
                Time = 3,
                Type = "normal"
            })
        end
    })
end

Window:Line()

local Settings = Window:Tab({Title = "Settings", Icon = "wrench"}) do
    Settings:Section({Title = "UI Settings"})
    
    local currentKeybind = Window:GetUIToggleKeybind() or Enum.KeyCode.LeftControl
    local UIToggleKeybind = Settings:Keybind({
        Title = "UI Toggle Keybind",
        Desc = "press to change the keybind for opening/closing the ui",
        Key = currentKeybind,
        Value = false,
        Callback = function(key, value)
            if Window.SetUIToggleKeybind then
                Window:SetUIToggleKeybind(key)
                if writefile then
                    pcall(function()
                        local saveData = {
                            UIToggleKeybind = tostring(key)
                        }
                        local HttpService = game:GetService("HttpService")
                        writefile("LunarisX_UIKeybind.json", HttpService:JSONEncode(saveData))
                    end)
                end
                -- Only show notification if value is true (key was actually set, not just when UI opens)
                if value then
                Window:Notify({
                    Title = "Keybind Changed",
                    Desc = "UI toggle keybind set to: " .. tostring(key):gsub("Enum.KeyCode.", ""),
                    Time = 3,
                    Type = "normal"
                })
                end
            end
        end
    })
    
    task.spawn(function()
        task.wait(0.5)
        if readfile then
            local success, fileData = pcall(function()
                return readfile("LunarisX_UIKeybind.json")
            end)
            
            if success and fileData and fileData ~= "" then
                local HttpService = game:GetService("HttpService")
                local success2, savedData = pcall(function()
                    return HttpService:JSONDecode(fileData)
                end)
                
                if success2 and savedData and savedData.UIToggleKeybind then
                    local keyCodeName = savedData.UIToggleKeybind:gsub("Enum.KeyCode.", "")
                    local newKeybind = Enum.KeyCode[keyCodeName]
                    if newKeybind and Window.SetUIToggleKeybind then
                        Window:SetUIToggleKeybind(newKeybind)
                        if UIToggleKeybind and UIToggleKeybind.SetKey then
                            UIToggleKeybind:SetKey(newKeybind)
                        end
                    end
                end
            end
        end
    end)
    
    Settings:Section({Title = "Theme"})
    local ThemeDropdown = Settings:Dropdown({
        Title = "Theme",
        Desc = "change ui theme",
        List = {"Dark", "Amethyst"},
        Value = "Dark",
        Callback = function(selectedTheme)
            task.spawn(function()
                task.wait(0.1)
                local uiScreenGui = game.CoreGui:FindFirstChild("LunarisX") or game.Players.LocalPlayer.PlayerGui:FindFirstChild("LunarisX")
                if uiScreenGui then
                    local topbar = uiScreenGui:FindFirstChild("Topbar")
                    if topbar then
                        local dropdownValue = topbar:FindFirstChild("DropdownValue_1")
                        if dropdownValue then
                            local textLabel = dropdownValue:FindFirstChild("TextLabelValue_1")
                            if textLabel then
                                for _, dropdownSelect in pairs(uiScreenGui:GetDescendants()) do
                                    if dropdownSelect.Name == "DropdownSelect" and dropdownSelect:IsA("Frame") then
                                        local scrollingFrame = dropdownSelect:FindFirstChild("ScrollingFrame_1")
                                        if scrollingFrame then
                                            for _, item in pairs(scrollingFrame:GetChildren()) do
                                                if item:IsA("Frame") and item:FindFirstChild("TextLabel") then
                                                    if item.TextLabel.Text == selectedTheme then
                                                        item.TextLabel.TextTransparency = 0
                                                        local clickDetector = item:FindFirstChild("Click")
                                                        if clickDetector then
                                                            clickDetector:Fire()
                                                        end
                                                        task.wait(0.1)
                                                        break
                                                    end
                                                end
                                            end
                                            break
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end)
        end
    })
    
    task.spawn(function()
        task.wait(0.3)
        if ThemeDropdown and ThemeDropdown.SetValue then
            local uiScreenGui = game.CoreGui:FindFirstChild("LunarisX") or game.Players.LocalPlayer.PlayerGui:FindFirstChild("LunarisX")
            if uiScreenGui then
                local topbar = uiScreenGui:FindFirstChild("Topbar")
                if topbar then
                    local dropdownValue = topbar:FindFirstChild("DropdownValue_1")
                    if dropdownValue then
                        local textLabel = dropdownValue:FindFirstChild("TextLabelValue_1")
                        if textLabel and textLabel.Text and textLabel.Text ~= "" and textLabel.Text ~= "--" then
                            ThemeDropdown:SetValue(textLabel.Text)
                        end
                    end
                end
            end
        end
    end)
    
    Settings:Section({Title = "Show Message"})
    Settings:Button({
        Title = "Show Message",
        Desc = "display popup",
        Callback = function()
            Window:Notify({
                Title = "LunarisX",
                Desc = "settings page!",
                Time = 3,
                Type = "normal"
            })
        end
    })

    Settings:Section({Title = "Test Notifications"})
    Settings:Button({
        Title = "Error Notification",
        Desc = "show error",
        Callback = function()
            Window:Notify({
                Title = "Error",
                Desc = "something went wrong!",
                Time = 3,
                Type = "error"
            })
        end
    })

    Settings:Button({
        Title = "Warning Notification",
        Desc = "show warning",
        Callback = function()
            Window:Notify({
                Title = "Warning",
                Desc = "be careful!",
                Time = 3,
                Type = "warning"
            })
        end
    })

    Settings:Button({
        Title = "Normal Notification",
        Desc = "show normal",
        Callback = function()
            Window:Notify({
                Title = "Info",
                Desc = "this is a normal notification",
                Time = 3,
                Type = "normal"
            })
        end
    })
end

Window:Line()

if not getgenv().LunarisX then
	getgenv().LunarisX = {
		SellAllTower = false,
		AtWave = 1,
		MarcoUrl = ""
	}
end

local MacroTab = Window:Tab({Title = "Macro", Icon = "code"}) do
	MacroTab:Section({Title = "Auto farm"})
	
	-- Macro URL input
	local MacroUrlInput = MacroTab:Textbox({
		Title = "Macro URL",
		Desc = "enter the raw link to your macro script",
		Placeholder = "https://api.junkie-development.de/api/v1/luascripts/...",
		Value = getgenv().LunarisX.MarcoUrl or "",
		ClearTextOnFocus = false,
		Callback = function(text)
			getgenv().LunarisX.MarcoUrl = text
			if text ~= "" then
				if writefile then
					pcall(function()
						local saveData = {
							MarcoUrl = text,
							AtWave = getgenv().LunarisX.AtWave or 1,
							SellAllTower = getgenv().LunarisX.SellAllTower or false
						}
						local HttpService = game:GetService("HttpService")
						writefile("LunarisX_Macro.json", HttpService:JSONEncode(saveData))
					end)
				end
				Window:Notify({
					Title = "Macro URL",
					Desc = "Macro URL saved!",
					Time = 3,
					Type = "normal"
				})
			end
		end
	})
	
	-- At Wave input (for selling all towers)
	local AtWaveInput = MacroTab:Textbox({
		Title = "At Wave",
		Desc = "set the wave number to sell all towers (1-50)",
		Placeholder = "1",
		Value = tostring(getgenv().LunarisX.AtWave or 1),
		ClearTextOnFocus = false,
		Callback = function(text)
			local waveNum = tonumber(text)
			if waveNum and waveNum >= 1 and waveNum <= 50 then
				getgenv().LunarisX.AtWave = waveNum
				if writefile then
					pcall(function()
						local saveData = {
							MarcoUrl = getgenv().LunarisX.MarcoUrl or "",
							AtWave = waveNum,
							SellAllTower = getgenv().LunarisX.SellAllTower or false
						}
						local HttpService = game:GetService("HttpService")
						writefile("LunarisX_Macro.json", HttpService:JSONEncode(saveData))
					end)
				end
				Window:Notify({
					Title = "Wave Set",
					Desc = "Wave set to " .. waveNum,
					Time = 2,
					Type = "normal"
				})
			else
				Window:Notify({
					Title = "Error",
					Desc = "Please enter a number between 1 and 50",
					Time = 3,
					Type = "error"
				})
			end
		end
	})
	
	-- Sell All Tower toggle
	local SellAllTowerToggle = MacroTab:Toggle({
		Title = "Sell All Tower",
		Desc = "sell all towers at the specified wave",
		Value = getgenv().LunarisX.SellAllTower or false,
		Callback = function(v)
			getgenv().LunarisX.SellAllTower = v
			if writefile then
				pcall(function()
					local saveData = {
						MarcoUrl = getgenv().LunarisX.MarcoUrl or "",
						AtWave = getgenv().LunarisX.AtWave or 1,
						SellAllTower = v
					}
					local HttpService = game:GetService("HttpService")
					writefile("LunarisX_Macro.json", HttpService:JSONEncode(saveData))
				end)
			end
		end
	})
	
	-- Run Macro button
	MacroTab:Button({
		Title = "Run Macro",
		Desc = "run the macro script with auto farm and sell all towers at wave",
		Callback = function()
			local macroUrl = getgenv().LunarisX.MarcoUrl or ""
			local atWave = getgenv().LunarisX.AtWave or 1
			local sellAllTower = getgenv().LunarisX.SellAllTower or false
			
			if macroUrl == "" then
				Window:Notify({
					Title = "Error",
					Desc = "Please enter a Macro URL first!",
					Time = 3,
					Type = "error"
				})
				return
			end
			
			if atWave < 1 or atWave > 50 then
				Window:Notify({
					Title = "Error",
					Desc = "Wave must be between 1 and 50!",
					Time = 3,
					Type = "error"
				})
				return
			end
			
			getgenv().LunarisX = {
				SellAllTower = sellAllTower,
				AtWave = atWave,
				MarcoUrl = macroUrl
			}
			
			local success, result = pcall(function()
				local scriptCode = game:HttpGet(macroUrl, true)
				if scriptCode then
					local wrappedScript = "getgenv().LunarisX = { SellAllTower = " .. tostring(sellAllTower) .. ", AtWave = " .. tostring(atWave) .. ", MarcoUrl = \"" .. macroUrl .. "\" } " .. scriptCode
					loadstring(wrappedScript)()
				else
					error("Failed to load macro script")
				end
			end)
			
			if success then
				Window:Notify({
					Title = "Success",
					Desc = "Macro script started! Auto farm enabled. Will sell all towers at wave " .. atWave .. (sellAllTower and "" or " (disabled)"),
					Time = 3,
					Type = "normal"
				})
			else
				Window:Notify({
					Title = "Error",
					Desc = "Failed to run macro: " .. tostring(result),
					Time = 5,
					Type = "error"
				})
			end
		end
	})
	
	MacroTab:Button({
		Title = "Copy Config",
		Desc = "copy current macro config to clipboard",
		Callback = function()
			local configText = "getgenv().LunarisX = {\n"
			configText = configText .. "    SellAllTower = " .. tostring(getgenv().LunarisX.SellAllTower or false) .. ",\n"
			configText = configText .. "    AtWave = " .. tostring(getgenv().LunarisX.AtWave or 1) .. ",\n"
			configText = configText .. "    MarcoUrl = \"" .. tostring(getgenv().LunarisX.MarcoUrl or "") .. "\"\n"
			configText = configText .. "}"
			
			if setclipboard then
				setclipboard(configText)
				Window:Notify({
					Title = "Copied!",
					Desc = "Macro config copied to clipboard",
					Time = 3,
					Type = "normal"
				})
			else
				Window:Notify({
					Title = "Error",
					Desc = "Clipboard function not available",
					Time = 3,
					Type = "error"
				})
			end
		end
	})
	
	-- Recorder Section
	MacroTab:Section({Title = "Recorder"})
	
	-- Create draggable, expandable log window
	local LogWindowGui = Instance.new("ScreenGui")
	LogWindowGui.Name = "RecorderLogWindow"
	LogWindowGui.ResetOnSpawn = false
	LogWindowGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	LogWindowGui.DisplayOrder = 1000
	LogWindowGui.Parent = game:GetService("CoreGui")
	
	local LogWindow = Instance.new("Frame")
	LogWindow.Name = "LogWindow"
	LogWindow.Parent = LogWindowGui
	LogWindow.BackgroundColor3 = Color3.fromRGB(29, 28, 38)
	LogWindow.BorderSizePixel = 0
	LogWindow.Position = UDim2.new(0.5, -250, 0.5, -150)
	LogWindow.Size = UDim2.new(0, 500, 0, 300)
	LogWindow.Visible = false
	
	local UICorner_Log = Instance.new("UICorner")
	UICorner_Log.CornerRadius = UDim.new(0, 8)
	UICorner_Log.Parent = LogWindow
	
	local UIStroke_Log = Instance.new("UIStroke")
	UIStroke_Log.Parent = LogWindow
	UIStroke_Log.Color = Color3.fromRGB(91, 68, 209)
	UIStroke_Log.Thickness = 2
	
	-- Title bar (draggable)
	local TitleBar = Instance.new("Frame")
	TitleBar.Name = "TitleBar"
	TitleBar.Parent = LogWindow
	TitleBar.BackgroundColor3 = Color3.fromRGB(36, 35, 48)
	TitleBar.BorderSizePixel = 0
	TitleBar.Size = UDim2.new(1, 0, 0, 35)
	
	local UICorner_Title = Instance.new("UICorner")
	UICorner_Title.CornerRadius = UDim.new(0, 8)
	UICorner_Title.Parent = TitleBar
	
	local TitleLabel = Instance.new("TextLabel")
	TitleLabel.Parent = TitleBar
	TitleLabel.BackgroundTransparency = 1
	TitleLabel.Size = UDim2.new(1, -70, 1, 0)
	TitleLabel.Font = Enum.Font.GothamBold
	TitleLabel.Text = "Recorder Log"
	TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	TitleLabel.TextSize = 14
	
	-- Close button
	local CloseButton = Instance.new("TextButton")
	CloseButton.Parent = TitleBar
	CloseButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
	CloseButton.BorderSizePixel = 0
	CloseButton.Position = UDim2.new(1, -30, 0, 5)
	CloseButton.Size = UDim2.new(0, 25, 0, 25)
	CloseButton.Font = Enum.Font.GothamBold
	CloseButton.Text = "×"
	CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
	CloseButton.TextSize = 18
	
	local UICorner_Close = Instance.new("UICorner")
	UICorner_Close.CornerRadius = UDim.new(0, 4)
	UICorner_Close.Parent = CloseButton
	
	-- Minimize/Maximize button
	local ExpandButton = Instance.new("TextButton")
	ExpandButton.Parent = TitleBar
	ExpandButton.BackgroundColor3 = Color3.fromRGB(91, 68, 209)
	ExpandButton.BorderSizePixel = 0
	ExpandButton.Position = UDim2.new(1, -60, 0, 5)
	ExpandButton.Size = UDim2.new(0, 25, 0, 25)
	ExpandButton.Font = Enum.Font.GothamBold
	ExpandButton.Text = "□"
	ExpandButton.TextColor3 = Color3.fromRGB(255, 255, 255)
	ExpandButton.TextSize = 14
	
	local UICorner_Expand = Instance.new("UICorner")
	UICorner_Expand.CornerRadius = UDim.new(0, 4)
	UICorner_Expand.Parent = ExpandButton
	
	-- Content frame
	local ContentFrame = Instance.new("Frame")
	ContentFrame.Name = "ContentFrame"
	ContentFrame.Parent = LogWindow
	ContentFrame.BackgroundColor3 = Color3.fromRGB(24, 24, 31)
	ContentFrame.BorderSizePixel = 0
	ContentFrame.Position = UDim2.new(0, 0, 0, 35)
	ContentFrame.Size = UDim2.new(1, 0, 1, -35)
	
	local UICorner_Content = Instance.new("UICorner")
	UICorner_Content.CornerRadius = UDim.new(0, 8)
	UICorner_Content.Parent = ContentFrame
	
	-- Scrolling frame for log content
	local LogScrollingFrame = Instance.new("ScrollingFrame")
	LogScrollingFrame.Parent = ContentFrame
	LogScrollingFrame.BackgroundTransparency = 1
	LogScrollingFrame.BorderSizePixel = 0
	LogScrollingFrame.Size = UDim2.new(1, -10, 1, -10)
	LogScrollingFrame.Position = UDim2.new(0, 5, 0, 5)
	LogScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
	LogScrollingFrame.ScrollBarThickness = 4
	LogScrollingFrame.ScrollBarImageColor3 = Color3.fromRGB(91, 68, 209)
	
	local LogLayout = Instance.new("UIListLayout")
	LogLayout.Parent = LogScrollingFrame
	LogLayout.SortOrder = Enum.SortOrder.LayoutOrder
	LogLayout.Padding = UDim.new(0, 2)
	
	local LogPadding = Instance.new("UIPadding")
	LogPadding.Parent = LogScrollingFrame
	LogPadding.PaddingLeft = UDim.new(0, 8)
	LogPadding.PaddingRight = UDim.new(0, 8)
	LogPadding.PaddingTop = UDim.new(0, 8)
	LogPadding.PaddingBottom = UDim.new(0, 8)
	
	-- Drag functionality
	local dragging = false
	local dragStart = nil
	local startPos = nil
	
	TitleBar.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			dragging = true
			dragStart = input.Position
			startPos = LogWindow.Position
		end
	end)
	
	game:GetService("UserInputService").InputChanged:Connect(function(input)
		if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
			local delta = input.Position - dragStart
			LogWindow.Position = startPos + UDim2.new(0, delta.X, 0, delta.Y)
		end
	end)
	
	game:GetService("UserInputService").InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			dragging = false
		end
	end)
	
	-- Close button functionality
	CloseButton.MouseButton1Click:Connect(function()
		LogWindow.Visible = false
	end)
	
	-- Expand button functionality
	local isExpanded = false
	local originalSize = LogWindow.Size
	local originalPosition = LogWindow.Position
	ExpandButton.MouseButton1Click:Connect(function()
		isExpanded = not isExpanded
		if isExpanded then
			LogWindow.Size = UDim2.new(0, 800, 0, 600)
			LogWindow.Position = UDim2.new(0.5, -400, 0.5, -300)
			ExpandButton.Text = "▣"
		else
			LogWindow.Size = originalSize
			LogWindow.Position = originalPosition
			ExpandButton.Text = "□"
		end
	end)
	
	-- Update canvas size when content changes
	LogLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		LogScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, LogLayout.AbsoluteContentSize.Y + 16)
	end)
	
	-- Function to add log entries
	local function AddLogEntry(text)
		local LogEntry = Instance.new("TextLabel")
		LogEntry.Parent = LogScrollingFrame
		LogEntry.BackgroundTransparency = 1
		LogEntry.Size = UDim2.new(1, -16, 0, 20)
		LogEntry.Font = Enum.Font.Code
		LogEntry.Text = text
		LogEntry.TextColor3 = Color3.fromRGB(255, 255, 255)
		LogEntry.TextSize = 11
		LogEntry.TextXAlignment = Enum.TextXAlignment.Left
		LogEntry.TextYAlignment = Enum.TextYAlignment.Top
		LogEntry.TextWrapped = true
		LogEntry.AutomaticSize = Enum.AutomaticSize.Y
		
		-- Auto-scroll to bottom
		task.wait()
		LogScrollingFrame.CanvasPosition = Vector2.new(0, LogScrollingFrame.AbsoluteCanvasSize.Y)
	end
	
	-- Recorder Log Box (embedded in tab, but also has separate window)
	local RecorderLogBox = MacroTab:Code({
		Title = "Recorder Log",
		Code = "-- Recorder Log\n-- Ready to start recording...\n-- Click to open log window"
	})
	
	-- Make the code box clickable to open log window
	task.spawn(function()
		task.wait(0.5)
		-- Find the Code element in the UI
		local uiScreenGui = game.CoreGui:FindFirstChild("LunarisX")
		if uiScreenGui then
			local codeFrame = uiScreenGui:FindFirstChild("Real Background", true)
			if codeFrame then
				-- Make it clickable to toggle log window
				codeFrame.InputBegan:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 then
						LogWindow.Visible = not LogWindow.Visible
					end
				end)
			end
		end
	end)
	
	-- Button to toggle log window
	MacroTab:Button({
		Title = "Toggle Log Window",
		Desc = "Open or close the recorder log window",
		Callback = function()
			LogWindow.Visible = not LogWindow.Visible
		end
	})
	
	-- Initialize recorder if not already initialized
	local RecorderModule = nil
	local RecorderLogMessages = {}
	local RecorderRecordToggle = nil
	
	-- Function to update recorder log
	local function UpdateRecorderLog(message)
		if message then
			local timestamp = os.date("%H:%M:%S")
			local logEntry = string.format("[%s] %s", timestamp, tostring(message))
			table.insert(RecorderLogMessages, logEntry)
			
			-- Keep only last 100 log entries
			if #RecorderLogMessages > 100 then
				table.remove(RecorderLogMessages, 1)
			end
			
			-- Update embedded log box
			local logText = table.concat(RecorderLogMessages, "\n")
			RecorderLogBox:SetCode(logText)
			
			-- Add to separate log window
			if LogScrollingFrame then
				AddLogEntry(logEntry)
			end
		end
	end
	
	-- Initialize recorder module
	task.spawn(function()
		RecorderModule = Library:Recorder(Window)
		if RecorderModule then
			UpdateRecorderLog("Recorder module loaded!")
		end
	end)
	
	-- Store reference to the actual recorder's RecordToggle
	local ActualRecorderToggle = nil
	
	-- Try to find the actual recorder toggle after a delay
	task.spawn(function()
		task.wait(1)
		-- The recorder module creates a RecordToggle in its own tab
		-- We'll try to access it through the Window's tab structure
		-- Since we can't directly access it, we'll use a shared state approach
	end)
	
	-- Start/Stop Recorder Toggle
	-- This will control the actual recorder's RecordToggle
	local RecorderToggle = MacroTab:Toggle({
		Title = "Start Recording",
		Desc = "Enable to start recording tower actions",
		Value = false,
		Callback = function(v)
			-- Wait for recorder module to be initialized if needed
			if not RecorderModule then
				RecorderModule = Library:Recorder(Window)
				task.wait(0.3)
			end
			
			-- Set the global IsRecording flag that the recorder checks
			getgenv().RecorderIsRecording = v
			getgenv().MacroRecorderToggleValue = v
			
			if v then
				-- Start recording - initialize the strat file
				-- Call InitializeStratFile if available through RecorderModule
				task.spawn(function()
					-- Wait for recorder module to fully initialize
					task.wait(0.2)
					
					-- Trigger the actual recorder toggle through the sync mechanism
					-- This will call InitializeStratFile and set IsRecording properly
					if RecorderModule and RecorderModule.SetStatus then
						RecorderModule.SetStatus("Recording...")
					end
				end)
				
				UpdateRecorderLog("Recording started!")
				RecorderToggle:SetTitle("Stop Recording")
				RecorderToggle:SetDesc("Disable to stop recording tower actions")
			else
				-- Stop recording
				if RecorderModule and RecorderModule.SetStatus then
					RecorderModule.SetStatus("Stopped")
				end
				
				UpdateRecorderLog("Recording stopped!")
				RecorderToggle:SetTitle("Start Recording")
				RecorderToggle:SetDesc("Enable to start recording tower actions")
			end
		end
	})
	
	-- Clear Log Button
	MacroTab:Button({
		Title = "Clear Log",
		Desc = "Clear the recorder log",
		Callback = function()
			RecorderLogMessages = {}
			RecorderLogBox:SetCode("-- Recorder Log\n-- Ready to start recording...\n-- Click to open log window")
			-- Clear the separate log window
			if LogScrollingFrame then
				for _, child in pairs(LogScrollingFrame:GetChildren()) do
					if child:IsA("TextLabel") then
						child:Destroy()
					end
				end
			end
			-- Don't log this action
		end
	})
	
	-- Copy Script Button
	MacroTab:Button({
		Title = "Copy Script",
		Desc = "Copy the recorded script to clipboard",
		Callback = function()
			local Players = game:GetService("Players")
			local LocalPlayer = Players.LocalPlayer
			local stratFilePath = "StrategiesX/TDS/Recorder/" .. LocalPlayer.Name .. "'s strat.txt"
			
			if readfile and isfile and isfile(stratFilePath) then
				local success, fileContent = pcall(function()
					return readfile(stratFilePath)
				end)
				
				if success and fileContent then
					if setclipboard then
						setclipboard(fileContent)
						-- Don't log this action
			Window:Notify({
							Title = "Success",
							Desc = "Recorded script copied to clipboard!",
							Time = 3,
				Type = "normal"
			})
					else
						Window:Notify({
							Title = "Error",
							Desc = "Clipboard function not available",
							Time = 3,
							Type = "error"
						})
					end
				else
					Window:Notify({
						Title = "Error",
						Desc = "Failed to read recorded script file",
						Time = 3,
						Type = "error"
					})
				end
			else
				-- Try to copy log content as fallback
				local logContent = table.concat(RecorderLogMessages, "\n")
				if logContent and #logContent > 0 then
					if setclipboard then
						setclipboard(logContent)
						Window:Notify({
							Title = "Info",
							Desc = "Log content copied (script file not found)",
							Time = 3,
							Type = "normal"
						})
					end
				else
					Window:Notify({
						Title = "Error",
						Desc = "No recorded script found. Please start recording first!",
						Time = 3,
						Type = "error"
					})
				end
			end
		end
	})
	
	task.spawn(function()
		task.wait(0.5)
		if readfile then
			local success, fileData = pcall(function()
				return readfile("LunarisX_Macro.json")
			end)
			
			if success and fileData and fileData ~= "" then
				local HttpService = game:GetService("HttpService")
				local success2, savedData = pcall(function()
					return HttpService:JSONDecode(fileData)
				end)
				
				if success2 and savedData then
					if savedData.MarcoUrl then
						getgenv().LunarisX.MarcoUrl = savedData.MarcoUrl
						if MacroUrlInput and MacroUrlInput.SetValue then
							MacroUrlInput:SetValue(savedData.MarcoUrl)
						end
					end
					if savedData.AtWave then
						getgenv().LunarisX.AtWave = savedData.AtWave
						if AtWaveInput and AtWaveInput.SetValue then
							AtWaveInput:SetValue(tostring(savedData.AtWave))
						end
					end
					if savedData.SellAllTower ~= nil then
						getgenv().LunarisX.SellAllTower = savedData.SellAllTower
						if SellAllTowerToggle and SellAllTowerToggle.SetValue then
							SellAllTowerToggle:SetValue(savedData.SellAllTower)
						end
					end
				end
			end
		end
	end)
end

Window:Line()

local icons = {"star", "bell", "tag", "wrench", "message", "code", "settings", "home", "user", "heart"}
local randomIcon = icons[math.random(1, #icons)]
local WebhookTab = Window:Tab({Title = "Webhook", Icon = randomIcon}) do
    local url = ""
    
    WebhookTab:Section({Title = "Webhook Configuration"})
    local WebhookUrlInput = WebhookTab:Textbox({
        Title = "Discord Webhook URL",
        Desc = "enter your discord webhook url",
        Placeholder = "https://discord.com/api/webhooks/...",
        Value = "",
        ClearTextOnFocus = false,
        Callback = function(text)
            url = text
            if text ~= "" then
                Window:Notify({
                    Title = "Webhook URL",
                    Desc = "Webhook URL saved!",
                    Time = 3,
                    Type = "normal"
                })
            end
        end
    })
    
    WebhookTab:Section({Title = "Test Webhook"})
    local TestInput = WebhookTab:Textbox({
        Title = "Test Message",
        Desc = "enter a message to test the webhook",
        Placeholder = "type test message here...",
        Value = "",
        ClearTextOnFocus = false,
        Callback = function(testMessage)
            if url == "" then
                Window:Notify({
                    Title = "Error",
                    Desc = "Please enter a webhook URL first!",
                    Time = 3,
                    Type = "error"
                })
                return
            end
            
            if testMessage == "" then
                Window:Notify({
                    Title = "Error",
                    Desc = "Please enter a test message!",
                    Time = 3,
                    Type = "error"
                })
                return
            end
            
            local HttpService = game:GetService("HttpService")
            
            local success, result = pcall(function()
                local data = {
                    content = testMessage,
                    username = "LunarisX Test"
                }
                local json = HttpService:JSONEncode(data)
                
                if http_request then
                    local response = http_request({
                        Url = url,
                        Method = "POST",
                        Headers = {
                            ["Content-Type"] = "application/json"
                        },
                        Body = json
                    })
                    
                    if response and (response.Success or response.StatusCode == 200 or response.StatusCode == 204) then
                        return {Success = true, StatusCode = response.StatusCode or 200}
                    else
                        error("Webhook request failed: " .. tostring(response))
                    end
                elseif request then
                    local response = request({
                        Url = url,
                        Method = "POST",
                        Headers = {
                            ["Content-Type"] = "application/json"
                        },
                        Body = json
                    })
                    
                    if response and (response.Success or response.StatusCode == 200 or response.StatusCode == 204) then
                        return {Success = true, StatusCode = response.StatusCode or 200}
                    else
                        error("Webhook request failed: " .. tostring(response))
                    end
                elseif syn and syn.request then
                    local response = syn.request({
                        Url = url,
                        Method = "POST",
                        Headers = {
                            ["Content-Type"] = "application/json"
                        },
                        Body = json
                    })
                    
                    if response and (response.Success or response.StatusCode == 200 or response.StatusCode == 204) then
                        return {Success = true, StatusCode = response.StatusCode or 200}
                    else
                        error("Webhook request failed: " .. tostring(response))
                    end
                elseif HttpService.HttpEnabled then
                    local postSuccess, postResult = pcall(function()
                        return HttpService:HttpPost(url, json, Enum.HttpContentType.ApplicationJson, false)
                    end)
                    
                    if postSuccess and postResult then
                        return {Success = true, StatusCode = 200, Body = postResult}
                    else
                        error("HttpPost failed: " .. tostring(postResult))
                    end
                else
                    error("No HTTP method available. Make sure you're using a supported exploit.")
                end
            end)
            
            if success then
                Window:Notify({
                    Title = "Success",
                    Desc = "Webhook test sent successfully!",
                    Time = 3,
                    Type = "normal"
                })
            else
                local errorMsg = tostring(result)
                Window:Notify({
                    Title = "Error",
                    Desc = "Failed to send webhook: " .. errorMsg,
                    Time = 5,
                    Type = "error"
                })
            end
        end
    })
end

Window:Line()

local AnnouncementTab = Window:Tab({Title = "Announce", Icon = "bell"}) do
    task.spawn(function()
        task.wait(0.2)
        
        local tabs = Window.List
        for _, tabData in pairs(tabs) do
            if tabData.Page and tabData.Button then
                local tabButton = tabData.Button
                local funcFrame = tabButton:FindFirstChild("Func")
                if funcFrame then
                    local titleLabel = funcFrame:FindFirstChild("Title")
                    if titleLabel and titleLabel.Text == "Announce" then
                        local scrollingFrame = tabData.Page:FindFirstChild("ScrollingFrame")
                        if scrollingFrame then
                            Window.AnnouncementScrollingFrame = scrollingFrame
                            
                            scrollingFrame.Size = UDim2.new(1, 0, 1, 0)
                            scrollingFrame.Position = UDim2.new(0, 0, 0, 0)
                            scrollingFrame.ScrollBarThickness = 4
                            
                            local existingPadding = scrollingFrame:FindFirstChild("UIPadding")
                            if existingPadding then
                                existingPadding:Destroy()
                            end
                            
                            local announcementUIPadding = Instance.new("UIPadding")
                            announcementUIPadding.Parent = scrollingFrame
                            announcementUIPadding.PaddingBottom = UDim.new(0, 10)
                            announcementUIPadding.PaddingLeft = UDim.new(0, 10)
                            announcementUIPadding.PaddingRight = UDim.new(0, 10)
                            announcementUIPadding.PaddingTop = UDim.new(0, 10)
                            
                            local listLayout = scrollingFrame:FindFirstChild("UIListLayout")
                            if listLayout then
                                listLayout.Padding = UDim.new(0, 8)
                                listLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
                                    scrollingFrame.CanvasSize = UDim2.new(0, 0, 0, listLayout.AbsoluteContentSize.Y + 20)
                                end)
                            end
                            
                            local function loadSavedAnnouncements()
                                if readfile then
                                    local Players = game:GetService("Players")
                                    local HttpService = game:GetService("HttpService")
                                    local localPlayer = Players.LocalPlayer
                                    if localPlayer then
                                        local client_id = tostring(localPlayer.UserId)
                                        local saveFilePath = "LunarisX_Announcements_" .. client_id .. ".json"
                                        local success, fileData = pcall(function()
                                            return readfile(saveFilePath)
                                        end)
                                        
                                        if success and fileData and fileData ~= "" then
                                            local success2, savedData = pcall(function()
                                                return HttpService:JSONDecode(fileData)
                                            end)
                                            
                                            if success2 and savedData and type(savedData.Announcements) == "table" then
                                                for _, child in pairs(scrollingFrame:GetChildren()) do
                                                    if child:IsA("Frame") and child.Name == "AnnouncementMessage" then
                                                        child:Destroy()
                                                    end
                                                end
                                                
                                                local sortedIds = {}
                                                for id, _ in pairs(savedData.Announcements) do
                                                    table.insert(sortedIds, tonumber(id) or 0)
                                                end
                                                table.sort(sortedIds)
                                                
                                                for _, id in ipairs(sortedIds) do
                                                    local message = savedData.Announcements[tostring(id)]
                                                    if message then
                                                        Window:AddAnnouncementToUI(message)
                                                    end
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                            
                            task.wait(0.1)
                            loadSavedAnnouncements()
                            
                            tabButton.MouseButton1Click:Connect(function()
                                task.wait(0.2)
                                loadSavedAnnouncements()
                            end)
                            
                            break
                        end
                    end
                end
            end
        end
    end)
end

Window:Line()

local LogTab = Window:Tab({Title = "Log", Icon = "settings"}) do
    task.spawn(function()
        task.wait(0.2)
        
        local tabs = Window.List
        local logScrollingFrame = nil
        
        for _, tabData in pairs(tabs) do
            if tabData.Page and tabData.Button then
                local tabButton = tabData.Button
                local funcFrame = tabButton:FindFirstChild("Func")
                if funcFrame then
                    local titleLabel = funcFrame:FindFirstChild("Title")
                    if titleLabel and titleLabel.Text == "Log" then
                        local scrollingFrame = tabData.Page:FindFirstChild("ScrollingFrame")
                        if scrollingFrame then
                            logScrollingFrame = scrollingFrame
                            scrollingFrame.Size = UDim2.new(1, 0, 1, 0)
                            scrollingFrame.Position = UDim2.new(0, 0, 0, 0)
                            scrollingFrame.ScrollBarThickness = 4
                            
                            local existingPadding = scrollingFrame:FindFirstChild("UIPadding")
                            if existingPadding then
                                existingPadding:Destroy()
                            end
                            
                            local logUIPadding = Instance.new("UIPadding")
                            logUIPadding.Parent = scrollingFrame
                            logUIPadding.PaddingBottom = UDim.new(0, 10)
                            logUIPadding.PaddingLeft = UDim.new(0, 10)
                            logUIPadding.PaddingRight = UDim.new(0, 10)
                            logUIPadding.PaddingTop = UDim.new(0, 10)
                            
                            local listLayout = scrollingFrame:FindFirstChild("UIListLayout")
                            if listLayout then
                                listLayout.Padding = UDim.new(0, 5)
                                listLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
                                    scrollingFrame.CanvasSize = UDim2.new(0, 0, 0, listLayout.AbsoluteContentSize.Y + 20)
                                end)
                            end
                            
                            local function getRelativeDate(entryDate)
                                if not entryDate then
                                    return os.date("%m/%d", os.time())
                                end
                                
                                local currentTime = os.time()
                                local entryTime = entryDate
                                
                                if type(entryDate) == "string" then
                                    if entryDate == "Today" then
                                        entryTime = currentTime
                                    elseif entryDate == "Yesterday" then
                                        entryTime = currentTime - 86400
                                    else
                                        return entryDate
                                    end
                                end
                                
                                local currentDateTable = os.date("*t", currentTime)
                                local entryDateTable = os.date("*t", entryTime)
                                
                                currentDateTable.hour = 0
                                currentDateTable.min = 0
                                currentDateTable.sec = 0
                                currentDateTable.isdst = nil
                                
                                entryDateTable.hour = 0
                                entryDateTable.min = 0
                                entryDateTable.sec = 0
                                entryDateTable.isdst = nil
                                
                                local currentDayStart = os.time(currentDateTable)
                                local entryDayStart = os.time(entryDateTable)
                                
                                local daysDiff = math.floor((currentDayStart - entryDayStart) / 86400)
                                
                                if daysDiff == 0 then
                                    return "Today"
                                elseif daysDiff == 1 then
                                    return "Yesterday"
                                elseif daysDiff == 2 then
                                    return "2 days ago"
                                elseif daysDiff < 7 then
                                    return tostring(daysDiff) .. " days ago"
                                else
                                    return os.date("%m/%d/%y", entryTime)
                                end
                            end
                            
                            local function addLogEntry(text, entryDate)
                                if not logScrollingFrame then return end
                                
                                local displayDate = getRelativeDate(entryDate)
                                
                                local logFrame = Instance.new("Frame")
                                local UICorner = Instance.new("UICorner")
                                local UIPadding = Instance.new("UIPadding")
                                local MessageLabel = Instance.new("TextLabel")
                                local TimeLabel = Instance.new("TextLabel")
                                
                                logFrame.Name = "LogEntry"
                                logFrame.Parent = logScrollingFrame
                                logFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
                                logFrame.BorderSizePixel = 0
                                logFrame.Size = UDim2.new(1, -10, 0, 0)
                                logFrame.AutomaticSize = Enum.AutomaticSize.Y
                                
                                UICorner.Parent = logFrame
                                UICorner.CornerRadius = UDim.new(0, 5)
                                
                                UIPadding.Parent = logFrame
                                UIPadding.PaddingBottom = UDim.new(0, 8)
                                UIPadding.PaddingLeft = UDim.new(0, 10)
                                UIPadding.PaddingRight = UDim.new(0, 10)
                                UIPadding.PaddingTop = UDim.new(0, 8)
                                
                                MessageLabel.Name = "Message"
                                MessageLabel.Parent = logFrame
                                MessageLabel.BackgroundTransparency = 1
                                MessageLabel.Size = UDim2.new(1, -60, 0, 0)
                                MessageLabel.Font = Enum.Font.Gotham
                                MessageLabel.Text = text
                                MessageLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
                                MessageLabel.TextSize = 12
                                MessageLabel.TextWrapped = true
                                MessageLabel.TextXAlignment = Enum.TextXAlignment.Left
                                MessageLabel.TextYAlignment = Enum.TextYAlignment.Top
                                MessageLabel.AutomaticSize = Enum.AutomaticSize.Y
                                
                                TimeLabel.Name = "Time"
                                TimeLabel.Parent = logFrame
                                TimeLabel.AnchorPoint = Vector2.new(1, 0)
                                TimeLabel.BackgroundTransparency = 1
                                TimeLabel.Position = UDim2.new(1, -5, 0, 5)
                                TimeLabel.Size = UDim2.new(0, 80, 0, 10)
                                TimeLabel.Font = Enum.Font.Gotham
                                TimeLabel.Text = displayDate
                                TimeLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
                                TimeLabel.TextTransparency = 0.5
                                TimeLabel.TextSize = 10
                                TimeLabel.TextXAlignment = Enum.TextXAlignment.Right
                            end
                            
                            local todayTime = os.time()
                            local yesterdayTime = os.time() - 86400
                            local twoDaysAgoTime = os.time() - (86400 * 2)
                            
                            addLogEntry("Optimized The Ui", todayTime)
                            addLogEntry("Fixed webhook not working", todayTime)
                            addLogEntry("Annoucement Added YAYY", yesterdayTime)

                            
                            break
                        end
                    end
                end
            end
        end
    end)
end

-- Remote Spy Tab
local RemoteTab = Window:Tab({Title = "Remote", Icon = "satellite"}) do
    RemoteTab:Section({Title = "Remote Spy"})
    
    -- Remote Spy State
    local RemoteSpyEnabled = false
    local RemoteSpyLogs = {} -- Store full log data
    local RemoteSpyLogEntries = {} -- Store formatted log entries
    local MaxLogEntries = 500
    local AutoExecuteEnabled = false
    local FilterText = ""
    local SelectedRemote = nil
    local RemoteCounts = {} -- Track counts for duplicate numbering
    local oldFireServer = nil
    local oldInvokeServer = nil
    
    -- Create log display
    local RemoteSpyLogBox = RemoteTab:Code({
        Title = "Remote Spy Log",
        Code = "-- Remote Spy Log\n-- Enable Remote Spy to start intercepting remotes..."
    })
    
    -- Remote selection dropdown
    local RemoteDropdown = RemoteTab:Dropdown({
        Title = "Select Remote",
        Desc = "Choose a remote to view its logs",
        List = {"All Remotes"},
        Value = "All Remotes",
        Callback = function(selected)
            SelectedRemote = selected
            UpdateRemoteSpyLog()
        end
    })
    
    -- Function to update remote dropdown list
    local function UpdateRemoteDropdown()
        local remoteNames = {}
        local nameCounts = {}
        
        -- Count occurrences of each remote name
        for _, logData in ipairs(RemoteSpyLogs) do
            local remoteName = logData.remoteName
            nameCounts[remoteName] = (nameCounts[remoteName] or 0) + 1
        end
        
        -- Build list with numbering for duplicates
        local seen = {}
        for _, logData in ipairs(RemoteSpyLogs) do
            local remoteName = logData.remoteName
            if not seen[remoteName] then
                seen[remoteName] = true
                if nameCounts[remoteName] > 1 then
                    table.insert(remoteNames, remoteName .. " (" .. nameCounts[remoteName] .. ")")
                else
                    table.insert(remoteNames, remoteName)
                end
            end
        end
        
        -- Update dropdown
        RemoteDropdown:Clear()
        RemoteDropdown:Add("All Remotes")
        for _, name in ipairs(remoteNames) do
            RemoteDropdown:Add(name)
        end
    end
    
    -- Function to update log
    local function UpdateRemoteSpyLog()
        if #RemoteSpyLogEntries == 0 then
            RemoteSpyLogBox:SetCode("-- Remote Spy Log\n-- No remotes intercepted yet...")
            return
        end
        
        local logText = ""
        local displayLogs = {}
        
        if SelectedRemote and SelectedRemote ~= "All Remotes" then
            -- Filter by selected remote
            local remoteName = SelectedRemote:gsub("%s%(%d+%)", "") -- Remove count suffix
            for i, logData in ipairs(RemoteSpyLogs) do
                if logData.remoteName == remoteName then
                    table.insert(displayLogs, RemoteSpyLogEntries[i])
                end
            end
            logText = "-- Remote Spy Log (" .. #displayLogs .. " entries for " .. remoteName .. ")\n\n"
        else
            -- Show all logs
            displayLogs = RemoteSpyLogEntries
            logText = "-- Remote Spy Log (" .. #displayLogs .. " entries)\n\n"
        end
        
        -- Show last 100 entries
        local startIndex = math.max(1, #displayLogs - 99)
        for i = startIndex, #displayLogs do
            logText = logText .. displayLogs[i] .. "\n"
        end
        
        RemoteSpyLogBox:SetCode(logText)
    end
    
    -- Function to format remote data
    local function FormatRemoteData(remoteName, remoteType, args, path)
        local timestamp = os.date("%H:%M:%S")
        local pathStr = path or "Unknown"
        local argsStr = ""
        
        if args and #args > 0 then
            local argsTable = {}
            for i, arg in ipairs(args) do
                local argType = typeof(arg)
                if argType == "string" then
                    table.insert(argsTable, string.format('"%s"', tostring(arg):gsub('"', '\\"')))
                elseif argType == "Instance" then
                    table.insert(argsTable, string.format("Instance: %s", arg.Name))
                elseif argType == "table" then
                    table.insert(argsTable, "table {...}")
                else
                    table.insert(argsTable, tostring(arg))
                end
            end
            argsStr = table.concat(argsTable, ", ")
        else
            argsStr = "(no arguments)"
        end
        
        local formattedLog = string.format("[%s] %s: %s\n   Path: %s\n   Args: %s", 
            timestamp, remoteType, remoteName, pathStr, argsStr)
        
        -- Store full data
        table.insert(RemoteSpyLogs, {
            remoteName = remoteName,
            remoteType = remoteType,
            args = args,
            path = pathStr,
            timestamp = timestamp
        })
        
        -- Store formatted entry
        table.insert(RemoteSpyLogEntries, formattedLog)
        
        -- Trim if needed
        if #RemoteSpyLogs > MaxLogEntries then
            table.remove(RemoteSpyLogs, 1)
            table.remove(RemoteSpyLogEntries, 1)
        end
        
        return formattedLog
    end
    
    -- Enable/Disable Remote Spy Toggle
    local RemoteSpyToggle = RemoteTab:Toggle({
        Title = "Enable Remote Spy",
        Desc = "Start intercepting remote events and functions",
        Value = false,
        Callback = function(v)
            RemoteSpyEnabled = v
            
            if v then
                -- Hook RemoteEvent:FireServer and RemoteFunction:InvokeServer
                local originalNamecall = nil
                originalNamecall = hookmetamethod(game, "__namecall", function(...)
                    local self = (...)
                    local method = getnamecallmethod()
                    local args = {select(2, ...)}
                    
                    if RemoteSpyEnabled and (method == "FireServer" or method == "InvokeServer") then
                        local success, remoteName = pcall(function()
                            return self.Name
                        end)
                        
                        if success then
                            local isRemoteEvent = self:IsA("RemoteEvent")
                            local isRemoteFunction = self:IsA("RemoteFunction")
                            
                            if (isRemoteEvent and method == "FireServer") or (isRemoteFunction and method == "InvokeServer") then
                                local path = self:GetFullName()
                                local remoteType = isRemoteEvent and "RemoteEvent" or "RemoteFunction"
                                
                                -- Check filter
                                if FilterText == "" or string.find(string.lower(remoteName), string.lower(FilterText)) then
                                    FormatRemoteData(remoteName, remoteType, args, path)
                                    UpdateRemoteDropdown()
                                    UpdateRemoteSpyLog()
                                    
                                    -- Auto-execute RemoteFunctions if enabled
                                    if AutoExecuteEnabled and isRemoteFunction and method == "InvokeServer" then
                                        local capturedArgs = {...}
                                        task.spawn(function()
                                            local success, result = pcall(function()
                                                return originalNamecall(unpack(capturedArgs))
                                            end)
                                            if success then
                                                local execLog = string.format("[%s] Auto-executed: %s\n   Result: %s", 
                                                    os.date("%H:%M:%S"), remoteName, tostring(result))
                                                table.insert(RemoteSpyLogEntries, execLog)
                                                table.insert(RemoteSpyLogs, {
                                                    remoteName = remoteName,
                                                    remoteType = "AutoExecute",
                                                    args = {},
                                                    path = "",
                                                    timestamp = os.date("%H:%M:%S")
                                                })
                                                if #RemoteSpyLogs > MaxLogEntries then
                                                    table.remove(RemoteSpyLogs, 1)
                                                    table.remove(RemoteSpyLogEntries, 1)
                                                end
                                                UpdateRemoteDropdown()
                                                UpdateRemoteSpyLog()
                                            end
                                        end)
                                        -- Don't call originalNamecall here since we're auto-executing in the task
                                        return
                                    end
                                end
                            end
                        end
                    end
                    
                    return originalNamecall(...)
                end)
                
                oldFireServer = originalNamecall
                oldInvokeServer = originalNamecall
                
                Window:Notify({
                    Title = "Remote Spy",
                    Desc = "Remote Spy enabled!",
                    Time = 2,
                    Type = "normal"
                })
            else
                Window:Notify({
                    Title = "Remote Spy",
                    Desc = "Remote Spy disabled!",
                    Time = 2,
                    Type = "normal"
                })
            end
        end
    })
    
    -- Auto-Execute Toggle
    local AutoExecuteToggle = RemoteTab:Toggle({
        Title = "Auto-Execute RemoteFunctions",
        Desc = "Automatically execute intercepted RemoteFunctions",
        Value = false,
        Callback = function(v)
            AutoExecuteEnabled = v
        end
    })
    
    -- Filter Textbox
    RemoteTab:Textbox({
        Title = "Filter",
        Desc = "Filter remotes by name (leave empty for all)",
        Placeholder = "Enter remote name to filter...",
        Value = "",
        ClearTextOnFocus = false,
        Callback = function(text)
            FilterText = text
            Window:Notify({
                Title = "Filter",
                Desc = text ~= "" and ("Filter set to: " .. text) or "Filter cleared",
                Time = 2,
                Type = "normal"
            })
        end
    })
    
    -- Clear Log Button
    RemoteTab:Button({
        Title = "Clear Log",
        Desc = "Clear all intercepted remote logs",
        Callback = function()
            RemoteSpyLogs = {}
            RemoteSpyLogEntries = {}
            RemoteDropdown:Clear()
            RemoteDropdown:Add("All Remotes")
            SelectedRemote = "All Remotes"
            RemoteDropdown:SetValue("All Remotes")
            UpdateRemoteSpyLog()
            Window:Notify({
                Title = "Remote Spy",
                Desc = "Log cleared!",
                Time = 2,
                Type = "normal"
            })
        end
    })
    
    -- Max Log Entries Slider
    RemoteTab:Slider({
        Title = "Max Log Entries",
        Desc = "Maximum number of log entries to keep",
        Min = 50,
        Max = 1000,
        Value = 500,
        Callback = function(v)
            MaxLogEntries = math.floor(v)
            -- Trim logs if necessary
            while #RemoteSpyLogs > MaxLogEntries do
                table.remove(RemoteSpyLogs, 1)
            end
            UpdateRemoteSpyLog()
            Window:Notify({
                Title = "Remote Spy",
                Desc = "Max log entries set to: " .. MaxLogEntries,
                Time = 2,
                Type = "normal"
            })
        end
    })
end

Window:Notify({
    Title = "LunarisX",
    Desc = "all components loaded!",
    Time = 4,
    Type = "normal"
})
