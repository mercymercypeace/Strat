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
    Settings:Section({Title = "Theme"})
    local ThemeDropdown = Settings:Dropdown({
        Title = "Theme",
        Desc = "change ui theme",
        List = {"Dark", "Amethyst", "Dark Glass"},
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
	MacroTab:Section({Title = "Macro Configuration"})
	
	local MacroUrlInput = MacroTab:Textbox({
		Title = "Macro URL",
		Desc = "enter the raw link to your macro script",
		Placeholder = "https://api.junkie-development.de/api/v1/luascripts/...",
		Value = getgenv().LunarisX.MarcoUrl or "",
		ClearTextOnFocus = false,
		Callback = function(text)
			getgenv().LunarisX.MarcoUrl = text
			if text ~= "" then
				Window:Notify({
					Title = "Macro URL",
					Desc = "Macro URL saved!",
					Time = 3,
					Type = "normal"
				})
			end
		end
	})
	
	MacroTab:Section({Title = "Wave Settings"})
	local AtWaveInput = MacroTab:Textbox({
		Title = "At Wave",
		Desc = "set the wave number (1-50)",
		Placeholder = "1",
		Value = tostring(getgenv().LunarisX.AtWave or 1),
		ClearTextOnFocus = false,
		Callback = function(text)
			local waveNum = tonumber(text)
			if waveNum and waveNum >= 1 and waveNum <= 50 then
				getgenv().LunarisX.AtWave = waveNum
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
	
	MacroTab:Section({Title = "Tower Settings"})
	local SellAllTowerToggle = MacroTab:Toggle({
		Title = "Sell All Tower",
		Desc = "toggle to sell all towers",
		Value = getgenv().LunarisX.SellAllTower or false,
		Callback = function(v)
			getgenv().LunarisX.SellAllTower = v
		end
	})
	
	MacroTab:Section({Title = "Run Macro"})
	MacroTab:Button({
		Title = "Run",
		Desc = "run the macro script with current settings",
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
					Desc = "Macro script started!",
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
                            
                            task.wait(0.1)
                            local announcements = Window:GetAnnouncements()
                            for id, message in pairs(announcements) do
                                Window:AddAnnouncementToUI(message)
                            end
                            
                            break
                        end
                    end
                end
            end
        end
    end)
end

Window:Line()

local UpdateTab = Window:Tab({Title = "Update", Icon = "settings"}) do
    UpdateTab:Section({Title = "Check for Updates"})
    UpdateTab:Button({
        Title = "Check Updates",
        Desc = "check for latest version",
        Callback = function()
            Window:Notify({
                Title = "Update Check",
                Desc = "You are on the latest version!",
                Time = 3,
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
