local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local player = Players.LocalPlayer

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/mercymercypeace/Strat/refs/heads/main/ui/ui_library.lua"))()

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "NewLunarisUI"
ScreenGui.Parent = player:WaitForChild("PlayerGui")
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local Frame = Instance.new("Frame")
Frame.Parent = ScreenGui
Frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
Frame.BorderSizePixel = 0
Frame.Position = UDim2.new(0.278367341, 0, 0.310000002, 0)
Frame.Size = UDim2.new(0, 542, 0, 335)

local function addCorner(parent, radius)
	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, radius)
	corner.Parent = parent
end

addCorner(Frame, 8)

local Frame_2 = Instance.new("Frame")
Frame_2.Parent = Frame
Frame_2.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
Frame_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
Frame_2.BorderSizePixel = 0
Frame_2.Position = UDim2.new(0, 0, 0.147465304, 0)
Frame_2.Size = UDim2.new(0, 111, 0, 237)
addCorner(Frame_2, 6)

local Frame_3 = Instance.new("Frame")
Frame_3.Parent = Frame
Frame_3.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Frame_3.BorderColor3 = Color3.fromRGB(0, 0, 0)
Frame_3.BorderSizePixel = 0
Frame_3.Position = UDim2.new(0, 0, 0.147465438, 0)
Frame_3.Size = UDim2.new(0, 542, 0, -1)

local Frame_4 = Instance.new("Frame")
Frame_4.Parent = Frame
Frame_4.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Frame_4.BorderColor3 = Color3.fromRGB(0, 0, 0)
Frame_4.BorderSizePixel = 0
Frame_4.Position = UDim2.new(0.208020031, 0, 0.147465304, 0)
Frame_4.Size = UDim2.new(0, -1, 0, 237)

local X = Instance.new("TextButton")
X.Name = "X"
X.Parent = Frame
X.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
X.BorderColor3 = Color3.fromRGB(33, 33, 33)
X.Position = UDim2.new(0.937727153, 0, 0.034981709, 0)
X.Size = UDim2.new(0, 23, 0, 21)
X.Font = Enum.Font.SourceSans
X.Text = "X"
X.TextColor3 = Color3.fromRGB(255, 255, 255)
X.TextSize = 14.000
addCorner(X, 6)

local TextButton = Instance.new("TextButton")
TextButton.Name = "+-"
TextButton.Parent = Frame
TextButton.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
TextButton.BorderColor3 = Color3.fromRGB(33, 33, 33)
TextButton.Position = UDim2.new(0.882834375, 0, 0.034981709, 0)
TextButton.Size = UDim2.new(0, 23, 0, 21)
TextButton.Font = Enum.Font.SourceSans
TextButton.Text = "+"
TextButton.TextColor3 = Color3.fromRGB(255, 255, 255)
TextButton.TextSize = 14.000
addCorner(TextButton, 6)

local ImageLabel = Instance.new("ImageLabel")
ImageLabel.Parent = Frame
ImageLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
ImageLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
ImageLabel.BorderSizePixel = 0
ImageLabel.Position = UDim2.new(0.017042717, 0, 0.0246015415, 0)
ImageLabel.Size = UDim2.new(0, 25, 0, 25)
ImageLabel.Image = "rbxasset://textures/ui/GuiImagePlaceholder.png"
addCorner(ImageLabel, 8)

local LunarisX = Instance.new("TextLabel")
LunarisX.Name = "LunarisX"
LunarisX.Parent = Frame
LunarisX.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
LunarisX.BackgroundTransparency = 1.000
LunarisX.BorderColor3 = Color3.fromRGB(0, 0, 0)
LunarisX.BorderSizePixel = 0
LunarisX.Position = UDim2.new(0.0567991026, 0, 0.00680302922, 0)
LunarisX.Size = UDim2.new(0, 77, 0, 28)
LunarisX.Font = Enum.Font.FredokaOne
LunarisX.Text = "LunarisX"
LunarisX.TextColor3 = Color3.fromRGB(255, 255, 255)
LunarisX.TextSize = 14.000

local Frame_5 = Instance.new("Frame")
Frame_5.Parent = Frame
Frame_5.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
Frame_5.BorderColor3 = Color3.fromRGB(0, 0, 0)
Frame_5.BorderSizePixel = 0
Frame_5.Position = UDim2.new(0, 0, 0.852535069, 0)
Frame_5.Size = UDim2.new(0, 542, 0, 49)
addCorner(Frame_5, 6)

local Frame_6 = Instance.new("Frame")
Frame_6.Parent = Frame
Frame_6.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Frame_6.BorderColor3 = Color3.fromRGB(0, 0, 0)
Frame_6.BorderSizePixel = 0
Frame_6.Position = UDim2.new(0, 0, 0.147465408, 0)
Frame_6.Size = UDim2.new(0, 542, 0, -1)

local Frame_7 = Instance.new("Frame")
Frame_7.Parent = Frame
Frame_7.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Frame_7.BorderColor3 = Color3.fromRGB(0, 0, 0)
Frame_7.BorderSizePixel = 0
Frame_7.Position = UDim2.new(0, 0, 0.857142746, 0)
Frame_7.Size = UDim2.new(0, 542, 0, -1)

local ImageLabel_2 = Instance.new("ImageLabel")
ImageLabel_2.Parent = Frame
ImageLabel_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
ImageLabel_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
ImageLabel_2.BorderSizePixel = 0
ImageLabel_2.Position = UDim2.new(0.017042717, 0, 0.886091292, 0)
ImageLabel_2.Size = UDim2.new(0, 25, 0, 25)
ImageLabel_2.Image = "rbxasset://textures/ui/GuiImagePlaceholder.png"
addCorner(ImageLabel_2, 8)

local PlayerName = Instance.new("TextLabel")
PlayerName.Name = "PlayerName"
PlayerName.Parent = Frame
PlayerName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
PlayerName.BackgroundTransparency = 1.000
PlayerName.BorderColor3 = Color3.fromRGB(0, 0, 0)
PlayerName.BorderSizePixel = 0
PlayerName.Position = UDim2.new(0.0830455348, 0, 0.882956803, 0)
PlayerName.Size = UDim2.new(0, 77, 0, 28)
PlayerName.Font = Enum.Font.FredokaOne
PlayerName.Text = player.Name
PlayerName.TextColor3 = Color3.fromRGB(255, 255, 255)
PlayerName.TextSize = 14.000

local TextButton_4 = Instance.new("TextButton")
TextButton_4.Name = "-"
TextButton_4.Parent = Frame
TextButton_4.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
TextButton_4.BorderColor3 = Color3.fromRGB(33, 33, 33)
TextButton_4.Position = UDim2.new(0.827483773, 0, 0.034981709, 0)
TextButton_4.Size = UDim2.new(0, 23, 0, 21)
TextButton_4.Font = Enum.Font.SourceSans
TextButton_4.Text = "-"
TextButton_4.TextColor3 = Color3.fromRGB(255, 255, 255)
TextButton_4.TextSize = 14.000
addCorner(TextButton_4, 6)

local ContentArea = Instance.new("Frame")
ContentArea.Name = "ContentArea"
ContentArea.Parent = Frame
ContentArea.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
ContentArea.BackgroundTransparency = 1
ContentArea.BorderSizePixel = 0
ContentArea.Position = UDim2.new(0.208020031, 0, 0.147465438, 0)
ContentArea.Size = UDim2.new(0.791979969, 0, 0.704460084, 0)
ContentArea.ClipsDescendants = true

local oldUIScreenGui = game.CoreGui:FindFirstChild("LunarisX") or player.PlayerGui:FindFirstChild("LunarisX")
if oldUIScreenGui then
	oldUIScreenGui.Enabled = false
end

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

task.spawn(function()
	task.wait(0.3)
	local uiScreenGui = game.CoreGui:FindFirstChild("LunarisX") or player.PlayerGui:FindFirstChild("LunarisX")
	if uiScreenGui then
		local shadow = uiScreenGui:FindFirstChild("Shadow")
		if shadow then
			shadow.Parent = ContentArea
			shadow.Size = UDim2.new(1, 0, 1, 0)
			shadow.Position = UDim2.new(0, 0, 0, 0)
			shadow.AnchorPoint = Vector2.new(0, 0)
			
			local background = shadow:FindFirstChild("Background")
			if background then
				background.BackgroundTransparency = 0
				background.Visible = true
			end
			
			for _, descendant in pairs(shadow:GetDescendants()) do
				if descendant:IsA("Frame") or descendant:IsA("CanvasGroup") or descendant:IsA("TextLabel") or descendant:IsA("TextButton") or descendant:IsA("ScrollingFrame") or descendant:IsA("ImageLabel") or descendant:IsA("ImageButton") then
					if descendant.Transparency then
						descendant.Transparency = 0
					end
					if descendant.TextTransparency then
						descendant.TextTransparency = 0
					end
					if descendant.ImageTransparency then
						descendant.ImageTransparency = 0
					end
					descendant.Visible = true
				end
			end
			
			uiScreenGui.Enabled = false
		end
	end
end)

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
			
			if not HttpService.HttpEnabled then
				Window:Notify({
					Title = "HTTP Disabled",
					Desc = "HTTP services are disabled in this game. Webhooks require HTTP to be enabled.",
					Time = 5,
					Type = "error"
				})
				return
			end
			
			local success, result = pcall(function()
				local data = {
					content = testMessage,
					username = "LunarisX Test"
				}
				local json = HttpService:JSONEncode(data)
				local link = url
				
				local postSuccess, postResult = pcall(function()
					return HttpService:HttpPost(link, json, Enum.HttpContentType.ApplicationJson, false)
				end)
				
				if postSuccess and postResult then
					return {Success = true, StatusCode = 200, Body = postResult}
				end
				
				error("HttpPost failed: " .. tostring(postResult))
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
				if errorMsg:find("disabled") or errorMsg:find("security") or errorMsg:find("PostAsync") or errorMsg:find("RequestAsync") or errorMsg:find("GetAsync") or errorMsg:find("HttpPost") then
					Window:Notify({
						Title = "HTTP Methods Disabled",
						Desc = "All HTTP POST methods are disabled for security. Webhooks cannot be sent from client-side scripts. Use a server-side script instead.",
						Time = 6,
						Type = "error"
					})
				else
					Window:Notify({
						Title = "Error",
						Desc = "Failed to send webhook: " .. errorMsg,
						Time = 5,
						Type = "error"
					})
				end
			end
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

Window:Notify({
	Title = "LunarisX",
	Desc = "all components loaded!",
	Time = 4,
	Type = "normal"
})

local TopBarFrame = Instance.new("Frame")
TopBarFrame.Name = "TopBarFrame"
TopBarFrame.Parent = Frame
TopBarFrame.BackgroundTransparency = 1
TopBarFrame.BorderSizePixel = 0
TopBarFrame.Position = UDim2.new(0, 0, 0, 0)
TopBarFrame.Size = UDim2.new(1, 0, 0, 49)
TopBarFrame.ZIndex = 10
TopBarFrame.Active = true

local dragging = false
local dragStart = nil
local startPosition = nil

TopBarFrame.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		dragging = true
		dragStart = input.Position
		startPosition = Frame.Position
	end
end)

TopBarFrame.InputChanged:Connect(function(input)
	if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
		local delta = input.Position - dragStart
		local newPosition = UDim2.new(
			startPosition.X.Scale,
			startPosition.X.Offset + delta.X,
			startPosition.Y.Scale,
			startPosition.Y.Offset + delta.Y
		)
		Frame.Position = newPosition
	end
end)

TopBarFrame.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		dragging = false
	end
end)

X.MouseButton1Click:Connect(function()
	ScreenGui:Destroy()
	local oldUI = game.CoreGui:FindFirstChild("LunarisX") or player.PlayerGui:FindFirstChild("LunarisX")
	if oldUI then
		oldUI.Enabled = true
		local shadow = oldUI:FindFirstChild("Shadow")
		if shadow then
			shadow.Visible = true
		end
	end
end)

local minimized = false
local originalSize = Frame.Size
local minimizedSize = UDim2.new(0, 542, 0, 49)

local originalImageLabelPos = ImageLabel.Position
local originalLunarisXPos = LunarisX.Position
local originalXPos = X.Position
local originalMinimizePos = TextButton_4.Position
local originalTextButtonPos = TextButton.Position
local originalImageLabel2Pos = ImageLabel_2.Position
local originalPlayerNamePos = PlayerName.Position

TextButton_4.MouseButton1Click:Connect(function()
	if not minimized then
		local frameAbsY = Frame.AbsolutePosition.Y
		local imageLabelY = ImageLabel.AbsolutePosition.Y - frameAbsY
		local lunarisXY = LunarisX.AbsolutePosition.Y - frameAbsY
		local xButtonY = X.AbsolutePosition.Y - frameAbsY
		local minimizeButtonY = TextButton_4.AbsolutePosition.Y - frameAbsY
		local textButtonY = TextButton.AbsolutePosition.Y - frameAbsY
		
		ImageLabel.Position = UDim2.new(ImageLabel.Position.X.Scale, ImageLabel.Position.X.Offset, 0, imageLabelY)
		LunarisX.Position = UDim2.new(LunarisX.Position.X.Scale, LunarisX.Position.X.Offset, 0, lunarisXY)
		X.Position = UDim2.new(X.Position.X.Scale, X.Position.X.Offset, 0, xButtonY)
		TextButton_4.Position = UDim2.new(TextButton_4.Position.X.Scale, TextButton_4.Position.X.Offset, 0, minimizeButtonY)
		TextButton.Position = UDim2.new(TextButton.Position.X.Scale, TextButton.Position.X.Offset, 0, textButtonY)
		
		Frame_2.Visible = false
		Frame_3.Visible = false
		Frame_4.Visible = false
		Frame_6.Visible = false
		Frame_7.Visible = false
		Frame_5.Visible = false
		ImageLabel_2.Visible = false
		PlayerName.Visible = false
		ContentArea.Visible = false
		
		local tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)
		local tween = TweenService:Create(Frame, tweenInfo, {Size = minimizedSize})
		tween:Play()
		tween.Completed:Wait()
		
		minimized = true
		TextButton_4.Text = "+"
	else
		local tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)
		local tween = TweenService:Create(Frame, tweenInfo, {Size = originalSize})
		tween:Play()
		
		Frame_2.Visible = true
		Frame_3.Visible = true
		Frame_4.Visible = true
		Frame_5.Visible = true
		Frame_6.Visible = true
		Frame_7.Visible = true
		ImageLabel_2.Visible = true
		PlayerName.Visible = true
		ContentArea.Visible = true
		
		tween.Completed:Wait()
		
		ImageLabel.Position = originalImageLabelPos
		LunarisX.Position = originalLunarisXPos
		X.Position = originalXPos
		TextButton_4.Position = originalMinimizePos
		TextButton.Position = originalTextButtonPos
		
		minimized = false
		TextButton_4.Text = "-"
	end
end)

return ScreenGui
