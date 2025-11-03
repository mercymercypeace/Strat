local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local player = Players.LocalPlayer

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "NewLunarisUI"
ScreenGui.Parent = player:WaitForChild("PlayerGui")
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local Frame = Instance.new("Frame")
local Frame_2 = Instance.new("Frame")
local Frame_3 = Instance.new("Frame")
local Frame_4 = Instance.new("Frame")
local X = Instance.new("TextButton")
local TextButton = Instance.new("TextButton")
local ImageLabel = Instance.new("ImageLabel")
local LunarisX = Instance.new("TextLabel")
local TextButton_2 = Instance.new("TextButton")
local Frame_5 = Instance.new("Frame")
local Frame_6 = Instance.new("Frame")
local Frame_7 = Instance.new("Frame")
local ImageLabel_2 = Instance.new("ImageLabel")
local PlayerName = Instance.new("TextLabel")
local TextButton_3 = Instance.new("TextButton")
local TextButton_4 = Instance.new("TextButton")
local TextButton_5 = Instance.new("TextButton")
local TextButton_6 = Instance.new("TextButton")
local TextButton_7 = Instance.new("TextButton")
local TextButton_8 = Instance.new("TextButton")
local TextButton_9 = Instance.new("TextButton")
local TextButton_10 = Instance.new("TextButton")
local TextButton_11 = Instance.new("TextButton")
local TextButton_12 = Instance.new("TextButton")

Frame.Parent = ScreenGui
Frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
Frame.BorderSizePixel = 0
Frame.Position = UDim2.new(0.278367341, 0, 0.310000002, 0)
Frame.Size = UDim2.new(0, 542, 0, 335)

Frame_2.Parent = Frame
Frame_2.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
Frame_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
Frame_2.BorderSizePixel = 0
Frame_2.Position = UDim2.new(0, 0, 0.147465304, 0)
Frame_2.Size = UDim2.new(0, 111, 0, 237)

Frame_3.Parent = Frame
Frame_3.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Frame_3.BorderColor3 = Color3.fromRGB(0, 0, 0)
Frame_3.BorderSizePixel = 0
Frame_3.Position = UDim2.new(0, 0, 0.147465438, 0)
Frame_3.Size = UDim2.new(0, 542, 0, -1)

Frame_4.Parent = Frame
Frame_4.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Frame_4.BorderColor3 = Color3.fromRGB(0, 0, 0)
Frame_4.BorderSizePixel = 0
Frame_4.Position = UDim2.new(0.208020031, 0, 0.147465304, 0)
Frame_4.Size = UDim2.new(0, -1, 0, 237)

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

ImageLabel.Parent = Frame
ImageLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
ImageLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
ImageLabel.BorderSizePixel = 0
ImageLabel.Position = UDim2.new(0.017042717, 0, 0.0246015415, 0)
ImageLabel.Size = UDim2.new(0, 25, 0, 25)
ImageLabel.Image = "rbxasset://textures/ui/GuiImagePlaceholder.png"

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

TextButton_2.Parent = Frame
TextButton_2.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
TextButton_2.BorderColor3 = Color3.fromRGB(5, 5, 5)
TextButton_2.BorderSizePixel = 0
TextButton_2.Position = UDim2.new(0.017042717, 0, 0.175376594, 0)
TextButton_2.Size = UDim2.new(0, 96, 0, 38)
TextButton_2.Font = Enum.Font.SourceSans
TextButton_2.TextColor3 = Color3.fromRGB(255, 255, 255)
TextButton_2.TextSize = 14.000

Frame_5.Parent = Frame
Frame_5.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
Frame_5.BorderColor3 = Color3.fromRGB(0, 0, 0)
Frame_5.BorderSizePixel = 0
Frame_5.Position = UDim2.new(0, 0, 0.852535069, 0)
Frame_5.Size = UDim2.new(0, 542, 0, 49)

Frame_6.Parent = Frame
Frame_6.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Frame_6.BorderColor3 = Color3.fromRGB(0, 0, 0)
Frame_6.BorderSizePixel = 0
Frame_6.Position = UDim2.new(0, 0, 0.147465408, 0)
Frame_6.Size = UDim2.new(0, 542, 0, -1)

Frame_7.Parent = Frame
Frame_7.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Frame_7.BorderColor3 = Color3.fromRGB(0, 0, 0)
Frame_7.BorderSizePixel = 0
Frame_7.Position = UDim2.new(0, 0, 0.857142746, 0)
Frame_7.Size = UDim2.new(0, 542, 0, -1)

ImageLabel_2.Parent = Frame
ImageLabel_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
ImageLabel_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
ImageLabel_2.BorderSizePixel = 0
ImageLabel_2.Position = UDim2.new(0.017042717, 0, 0.886091292, 0)
ImageLabel_2.Size = UDim2.new(0, 25, 0, 25)
ImageLabel_2.Image = "rbxasset://textures/ui/GuiImagePlaceholder.png"

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

TextButton_3.Parent = Frame
TextButton_3.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
TextButton_3.BorderColor3 = Color3.fromRGB(5, 5, 5)
TextButton_3.BorderSizePixel = 0
TextButton_3.Position = UDim2.new(0.017042717, 0, 0.31269002, 0)
TextButton_3.Size = UDim2.new(0, 96, 0, 38)
TextButton_3.Font = Enum.Font.SourceSans
TextButton_3.TextColor3 = Color3.fromRGB(255, 255, 255)
TextButton_3.TextSize = 14.000

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

TextButton_5.Parent = Frame
TextButton_5.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
TextButton_5.BorderColor3 = Color3.fromRGB(5, 5, 5)
TextButton_5.BorderSizePixel = 0
TextButton_5.Position = UDim2.new(0.223684445, 0, 0.175376594, 0)
TextButton_5.Size = UDim2.new(0, 410, 0, 18)
TextButton_5.Font = Enum.Font.SourceSans
TextButton_5.TextColor3 = Color3.fromRGB(255, 255, 255)
TextButton_5.TextSize = 14.000

TextButton_6.Parent = Frame
TextButton_6.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
TextButton_6.BorderColor3 = Color3.fromRGB(5, 5, 5)
TextButton_6.BorderSizePixel = 0
TextButton_6.Position = UDim2.new(0.223684385, 0, 0.258958697, 0)
TextButton_6.Size = UDim2.new(0, 410, 0, 18)
TextButton_6.Font = Enum.Font.SourceSans
TextButton_6.TextColor3 = Color3.fromRGB(255, 255, 255)
TextButton_6.TextSize = 14.000

TextButton_7.Parent = Frame
TextButton_7.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
TextButton_7.BorderColor3 = Color3.fromRGB(5, 5, 5)
TextButton_7.BorderSizePixel = 0
TextButton_7.Position = UDim2.new(0.223684385, 0, 0.342540771, 0)
TextButton_7.Size = UDim2.new(0, 410, 0, 18)
TextButton_7.Font = Enum.Font.SourceSans
TextButton_7.TextColor3 = Color3.fromRGB(255, 255, 255)
TextButton_7.TextSize = 14.000

TextButton_8.Parent = Frame
TextButton_8.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
TextButton_8.BorderColor3 = Color3.fromRGB(5, 5, 5)
TextButton_8.BorderSizePixel = 0
TextButton_8.Position = UDim2.new(0.223684385, 0, 0.593287051, 0)
TextButton_8.Size = UDim2.new(0, 410, 0, 18)
TextButton_8.Font = Enum.Font.SourceSans
TextButton_8.TextColor3 = Color3.fromRGB(255, 255, 255)
TextButton_8.TextSize = 14.000

TextButton_9.Parent = Frame
TextButton_9.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
TextButton_9.BorderColor3 = Color3.fromRGB(5, 5, 5)
TextButton_9.BorderSizePixel = 0
TextButton_9.Position = UDim2.new(0.223684385, 0, 0.509704947, 0)
TextButton_9.Size = UDim2.new(0, 410, 0, 18)
TextButton_9.Font = Enum.Font.SourceSans
TextButton_9.TextColor3 = Color3.fromRGB(255, 255, 255)
TextButton_9.TextSize = 14.000

TextButton_10.Parent = Frame
TextButton_10.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
TextButton_10.BorderColor3 = Color3.fromRGB(5, 5, 5)
TextButton_10.BorderSizePixel = 0
TextButton_10.Position = UDim2.new(0.223684385, 0, 0.426122874, 0)
TextButton_10.Size = UDim2.new(0, 410, 0, 18)
TextButton_10.Font = Enum.Font.SourceSans
TextButton_10.TextColor3 = Color3.fromRGB(255, 255, 255)
TextButton_10.TextSize = 14.000

TextButton_11.Parent = Frame
TextButton_11.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
TextButton_11.BorderColor3 = Color3.fromRGB(5, 5, 5)
TextButton_11.BorderSizePixel = 0
TextButton_11.Position = UDim2.new(0.020732753, 0, 0.718660176, 0)
TextButton_11.Size = UDim2.new(0, 96, 0, 38)
TextButton_11.Font = Enum.Font.SourceSans
TextButton_11.TextColor3 = Color3.fromRGB(255, 255, 255)
TextButton_11.TextSize = 14.000

TextButton_12.Parent = Frame
TextButton_12.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
TextButton_12.BorderColor3 = Color3.fromRGB(5, 5, 5)
TextButton_12.BorderSizePixel = 0
TextButton_12.Position = UDim2.new(0.017042717, 0, 0.56343627, 0)
TextButton_12.Size = UDim2.new(0, 96, 0, 38)
TextButton_12.Font = Enum.Font.SourceSans
TextButton_12.Text = "Old UI"
TextButton_12.TextColor3 = Color3.fromRGB(255, 255, 255)
TextButton_12.TextSize = 14.000

TextButton_12.MouseButton1Click:Connect(function()
	ScreenGui:Destroy()
	local oldUI = game.CoreGui:FindFirstChild("LunarisX") or game.Players.LocalPlayer.PlayerGui:FindFirstChild("LunarisX")
	if oldUI then
		oldUI.Enabled = true
	end
end)

local function addCorner(parent, radius)
	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, radius)
	corner.Parent = parent
end

addCorner(Frame, 8)
addCorner(Frame_2, 6)
addCorner(Frame_5, 6)
addCorner(X, 6)
addCorner(TextButton, 6)
addCorner(TextButton_2, 6)
addCorner(TextButton_3, 6)
addCorner(TextButton_4, 6)
addCorner(TextButton_5, 6)
addCorner(TextButton_6, 6)
addCorner(TextButton_7, 6)
addCorner(TextButton_8, 6)
addCorner(TextButton_9, 6)
addCorner(TextButton_10, 6)
addCorner(TextButton_11, 6)
addCorner(TextButton_12, 6)
addCorner(ImageLabel, 8)
addCorner(ImageLabel_2, 8)

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
	local oldUI = game.CoreGui:FindFirstChild("LunarisX") or game.Players.LocalPlayer.PlayerGui:FindFirstChild("LunarisX")
	if oldUI then
		oldUI.Enabled = true
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
		TextButton_2.Visible = false
		TextButton_3.Visible = false
		TextButton_5.Visible = false
		TextButton_6.Visible = false
		TextButton_7.Visible = false
		TextButton_8.Visible = false
		TextButton_9.Visible = false
		TextButton_10.Visible = false
		TextButton_11.Visible = false
		TextButton_12.Visible = false
		Frame_5.Visible = false
		ImageLabel_2.Visible = false
		PlayerName.Visible = false
		
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
		TextButton_2.Visible = true
		TextButton_3.Visible = true
		TextButton_5.Visible = true
		TextButton_6.Visible = true
		TextButton_7.Visible = true
		TextButton_8.Visible = true
		TextButton_9.Visible = true
		TextButton_10.Visible = true
		TextButton_11.Visible = true
		TextButton_12.Visible = true
		ImageLabel_2.Visible = true
		PlayerName.Visible = true
		
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

