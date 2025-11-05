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

if not getgenv().LunarisX then
	getgenv().LunarisX = {
		SellAllTower = false,
		AtWave = 1,
		MarcoUrl = ""
	}
end

-- Global config storage for UI elements
local ConfigStorage = {
	MacroUrlInput = nil,
	AtWaveInput = nil,
	SellAllTowerToggle = nil,
	WebhookUrlInput = nil,
	UIToggleKeybind = nil
}

local MacroTab = Window:Tab({Title = "Macro", Icon = "code"}) do
	MacroTab:Section({Title = "Auto farm"})
	
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
	ConfigStorage.MacroUrlInput = MacroUrlInput
	
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
	ConfigStorage.AtWaveInput = AtWaveInput
	
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
	ConfigStorage.SellAllTowerToggle = SellAllTowerToggle
	
	MacroTab:Button({
		Title = "Run Macro",
		Desc = "run the macro script with auto farm and sell all towers at wave",
		Callback = function()
			local macroUrl = getgenv().LunarisX.MarcoUrl or ""
			local atWave = getgenv().LunarisX.AtWave or 1
			local sellAllTower = getgenv().LunarisX.SellAllTower or false
			
			macroUrl = string.gsub(macroUrl, "^%s+", "")
			macroUrl = string.gsub(macroUrl, "%s+$", "")
			
			if macroUrl == "" or macroUrl == nil or string.len(macroUrl) == 0 then
				Window:Notify({
					Title = "Error",
					Desc = "Please enter a Macro URL first!",
					Time = 3,
					Type = "error"
				})
				return
			end
			
			if not string.find(macroUrl, "http") then
				Window:Notify({
					Title = "Error",
					Desc = "Invalid Macro URL! Please enter a valid URL.",
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
				getgenv().LunarisX = {
					SellAllTower = sellAllTower,
					AtWave = atWave,
					MarcoUrl = macroUrl
				}
				loadstring(game:HttpGet("https://api.junkie-development.de/api/v1/luascripts/public/563d9f1ab1ca207f7d8cfa7cfe82e94a1482d82c7962da52ce473c981b084220/download"))()
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
	
	MacroTab:Section({Title = "Recorder"})
	
	local RecorderLogBox = MacroTab:Code({
		Title = "Recorder Log",
		Code = "-- Recorder Log\n-- Ready to start recording..."
	})
	
	local Recorder = {
		IsRecording = false,
		ActionLog = {},
		HookEnabled = false,
		OriginalNamecall = nil,
		MetaTable = nil,
		CurrentWave = 1,
		RemoteFunction = nil,
		TowersList = {},
		TowerCount = 0,
		SecondMili = 0
	}
	
	local function getCurrentWave()
		local ReplicatedStorage = game:GetService("ReplicatedStorage")
		local Players = game:GetService("Players")
		local LocalPlayer = Players.LocalPlayer
		
		local success, wave = pcall(function()
			-- Try to get from PlayerGui
			if LocalPlayer then
				local playerGui = LocalPlayer:FindFirstChild("PlayerGui")
				if playerGui then
					local gameTopDisplay = playerGui:FindFirstChild("ReactGameTopGameDisplay")
					if gameTopDisplay then
						local waveFrame = gameTopDisplay:FindFirstChild("Frame")
						if waveFrame then
							local waveContainer = waveFrame:FindFirstChild("wave")
							if waveContainer then
								local valueLabel = waveContainer:FindFirstChild("container")
								if valueLabel then
									local value = valueLabel:FindFirstChild("value")
									if value and value.Text then
										return tonumber(value.Text) or 1
									end
								end
							end
						end
					end
				end
			end
			
			-- Fallback to ReplicatedStorage
			local gameWave = ReplicatedStorage:FindFirstChild("GameWave")
			if gameWave then
				return tonumber(gameWave.Value) or 1
			end
			local timer = ReplicatedStorage:FindFirstChild("Timer")
			if timer then
				return math.floor(timer.Value / 60) + 1
			end
			return 1
		end)
		return success and wave or 1
	end
	
	local function ConvertTimer(number)
		return math.floor(number / 60), number % 60
	end
	
	local function GetTimer()
		local ReplicatedStorage = game:GetService("ReplicatedStorage")
		local Players = game:GetService("Players")
		local LocalPlayer = Players.LocalPlayer
		
		local wave = getCurrentWave()
		local minutes = 0
		local seconds = 0
		local timerCheck = false
		
		pcall(function()
			-- Try to get timer from State
			local state = ReplicatedStorage:FindFirstChild("State")
			if state then
				local timer = state:FindFirstChild("Timer")
				if timer then
					local timeValue = timer:FindFirstChild("Time")
					if timeValue then
						minutes, seconds = ConvertTimer(timeValue.Value)
						timerCheck = timeValue.Value <= 5
					end
				end
			end
		end)
		
		return {wave, minutes, seconds + Recorder.SecondMili, tostring(timerCheck)}
	end
	
	local function getCash()
		local Players = game:GetService("Players")
		local player = Players.LocalPlayer
		local success, cashLabel = pcall(function()
			return player:WaitForChild("PlayerGui", 1)
				:WaitForChild("ReactUniversalHotbar", 1)
				:WaitForChild("Frame", 1)
				:WaitForChild("values", 1)
				:WaitForChild("cash", 1)
				:WaitForChild("amount", 1)
		end)
		
		if success and cashLabel then
			local rawText = cashLabel.Text or ""
			local cleaned = rawText:gsub("[^%d%-]", "")
			return tonumber(cleaned) or 0
		end
		return 0
	end
	
	local learnedTowerCosts = {}
	
	local function findTowerCostInGame(towerName)
		local ReplicatedStorage = game:GetService("ReplicatedStorage")
		
		local possiblePaths = {
			"Towers",
			"TowerData",
			"GameData",
			"Data",
			"TowerCatalog",
			"TowerInfo"
		}
		
		for _, pathName in ipairs(possiblePaths) do
			local folder = ReplicatedStorage:FindFirstChild(pathName)
			if folder then
				local towerData = folder:FindFirstChild(towerName)
				if towerData then
					if towerData:IsA("ModuleScript") then
						local success, module = pcall(function()
							return require(towerData)
						end)
						if success and type(module) == "table" then
							if module.Cost then
								return tonumber(module.Cost) or 0
							elseif module.Price then
								return tonumber(module.Price) or 0
							elseif module.BaseCost then
								return tonumber(module.BaseCost) or 0
							end
						end
					elseif towerData:IsA("Configuration") or towerData:IsA("BoolValue") or towerData:IsA("IntValue") or towerData:IsA("NumberValue") then
						local cost = towerData:GetAttribute("Cost") or towerData:GetAttribute("Price") or towerData:GetAttribute("BaseCost")
						if cost then
							return tonumber(cost) or 0
						end
					end
				end
				
				for _, child in ipairs(folder:GetChildren()) do
					if child:IsA("ModuleScript") then
						local success, module = pcall(function()
							return require(child)
						end)
						if success and type(module) == "table" then
							local name = module.Name or module.TowerName or child.Name
							if name and string.lower(tostring(name)) == string.lower(towerName) then
								if module.Cost then
									return tonumber(module.Cost) or 0
								elseif module.Price then
									return tonumber(module.Price) or 0
								elseif module.BaseCost then
									return tonumber(module.BaseCost) or 0
								end
							end
						end
					end
				end
			end
		end
		
		return nil
	end
	
	local function getTowerCost(towerName)
		if learnedTowerCosts[towerName] then
			return learnedTowerCosts[towerName]
		end
		
		local cost = findTowerCostInGame(towerName)
		if cost and cost > 0 then
			learnedTowerCosts[towerName] = cost
			return cost
		end
		
		return 0
	end
	
	local function learnTowerCost(towerName, cost)
		if cost and cost > 0 then
			learnedTowerCosts[towerName] = cost
		end
	end
	
	local function getUpgradeCost(level)
		local upgradeCosts = {
			[1] = 100,
			[2] = 200,
			[3] = 300,
			[4] = 400,
			[5] = 500,
		}
		return upgradeCosts[level] or (level * 100)
	end
	
	function Recorder:UpdateLog()
		local logMessages = {}
		local waveActions = {}
		
		for _, action in ipairs(self.ActionLog) do
			if not waveActions[action.wave] then
				waveActions[action.wave] = {}
			end
			table.insert(waveActions[action.wave], action)
		end
		
		local sortedWaves = {}
		for wave, _ in pairs(waveActions) do
			table.insert(sortedWaves, wave)
		end
		table.sort(sortedWaves)
		
		for _, wave in ipairs(sortedWaves) do
			local actions = waveActions[wave]
			local waveLine = string.format("Wave %d:", wave)
			local actionList = {}
			
			for _, action in ipairs(actions) do
				if action.type == "place" then
					if action.waited then
						table.insert(actionList, string.format("wait for money, place %s", action.name))
					else
						table.insert(actionList, string.format("place %s", action.name))
					end
				elseif action.type == "upgrade" then
					local level = action.level or 1
					local path = action.path or "Left"
					local pathText = ""
					if path == "Right" then
						pathText = " (Right)"
					elseif path == "Left" then
						pathText = " (Left)"
					end
					if action.waited then
						table.insert(actionList, string.format("wait for money, upgrade to lvl %d%s", level, pathText))
					else
						table.insert(actionList, string.format("upgrade to lvl %d%s", level, pathText))
					end
				elseif action.type == "ability" then
					local abilityName = action.ability or "Unknown"
					table.insert(actionList, string.format("use ability: %s", tostring(abilityName)))
				elseif action.type == "skip" then
					table.insert(actionList, "skip wave")
				end
			end
			
			if #actionList > 0 then
				waveLine = waveLine .. " " .. table.concat(actionList, ", ")
				table.insert(logMessages, waveLine)
			end
		end
		
		if #logMessages == 0 then
			RecorderLogBox:SetCode("-- Recorder Log\n-- No actions recorded yet...")
		else
			RecorderLogBox:SetCode(table.concat(logMessages, "\n"))
		end
	end
	
	function Recorder:FormatLuaLog()
		local lines = {}
		
		-- Format timer for TDS format
		local function formatTimer(timer)
			if not timer or type(timer) ~= "table" or #timer < 4 then
				return "0, 0, 0, \"false\""
			end
			return string.format("%d, %d, %.1f, %s", timer[1] or 0, timer[2] or 0, timer[3] or 0, timer[4] or "\"false\"")
		end
		
		-- Format ability data
		local function formatAbilityData(data)
			if not data or type(data) ~= "table" then
				return "{}"
			end
			local formatted = {}
			for key, value in pairs(data) do
				if key == "directionCFrame" then
					table.insert(formatted, string.format('["%s"] = CFrame.new(%s)', key, tostring(value)))
				elseif key == "position" then
					table.insert(formatted, string.format('["%s"] = Vector3.new(%s)', key, tostring(value)))
				else
					table.insert(formatted, string.format('["%s"] = %s', key, tostring(value)))
				end
			end
			return "{" .. table.concat(formatted, ", ") .. "}"
		end
		
		for _, v in ipairs(self.ActionLog) do
			local timerStr = formatTimer(v.timer)
			
			if v.type == "place" then
				local rotX, rotY, rotZ = 0, 0, 0
				if v.rotation then
					rotX, rotY, rotZ = v.rotation[1] or 0, v.rotation[2] or 0, v.rotation[3] or 0
				end
				table.insert(lines, string.format('TDS:Place("%s", %.3f, %.3f, %.3f, {%s}, %.3f, %.3f, %.3f)', 
					v.name, v.pos[1], v.pos[2], v.pos[3], timerStr, rotX, rotY, rotZ))
			elseif v.type == "upgrade" then
				local path = v.path or "Left"
				table.insert(lines, string.format('TDS:Upgrade(%d, {%s}, "%s")', 
					v.towerId or 0, timerStr, path))
			elseif v.type == "sell" then
				table.insert(lines, string.format('TDS:Sell(%d, {%s})', 
					v.towerId or 0, timerStr))
			elseif v.type == "target" then
				table.insert(lines, string.format('TDS:Target(%d, "%s", {%s})', 
					v.towerId or 0, v.target or "First", timerStr))
			elseif v.type == "ability" then
				local abilityData = formatAbilityData(v.abilityData)
				table.insert(lines, string.format('TDS:Ability(%d, "%s", {%s}, %s)', 
					v.towerId or 0, v.ability or "Unknown", timerStr, abilityData))
			elseif v.type == "option" then
				table.insert(lines, string.format('TDS:Option(%d, "%s", "%s", {%s})', 
					v.towerId or 0, v.optionName or "", tostring(v.value or ""), timerStr))
			elseif v.type == "skip" then
				table.insert(lines, string.format('TDS:Skip({%s})', timerStr))
			end
		end
		
		return table.concat(lines, "\n")
	end
	
	function Recorder:Start()
		if self.HookEnabled then
			return
		end
		
		local ReplicatedStorage = game:GetService("ReplicatedStorage")
		local remoteFunction = ReplicatedStorage:WaitForChild("RemoteFunction", 10)
		
		if not remoteFunction then
			Window:Notify({
				Title = "Error",
				Desc = "Failed to find RemoteFunction",
				Time = 3,
				Type = "error"
			})
			return false
		end
		
		self.RemoteFunction = remoteFunction
		self.CurrentWave = getCurrentWave()
		self.IsRecording = true
		self.TowerCount = 0
		self.TowersList = {}
		
		-- Initialize timer tracking
		task.spawn(function()
			local state = ReplicatedStorage:FindFirstChild("State")
			if state then
				local timer = state:FindFirstChild("Timer")
				if timer then
					local timeValue = timer:FindFirstChild("Time")
					if timeValue then
						timeValue:GetPropertyChangedSignal("Value"):Connect(function()
							Recorder.SecondMili = 0
							for i = 1, 9 do
								task.wait(0.09)
								Recorder.SecondMili = Recorder.SecondMili + 0.1
							end
						end)
					end
				end
			end
		end)
		
		task.spawn(function()
			local gameWave = ReplicatedStorage:WaitForChild("GameWave", 10)
			if gameWave then
				gameWave:GetPropertyChangedSignal("Value"):Connect(function()
					if self.IsRecording then
						self.CurrentWave = tonumber(gameWave.Value) or self.CurrentWave
					end
				end)
			end
		end)
		
		self.MetaTable = getrawmetatable(game)
		self.OriginalNamecall = self.MetaTable.__namecall
		setreadonly(self.MetaTable, false)
		
		self.MetaTable.__namecall = newcclosure(function(self, ...)
			local rec = Recorder
			
			if not rec.IsRecording or not rec.HookEnabled then
				return rec.OriginalNamecall(self, ...)
			end
			
			local method = getnamecallmethod()
			if method ~= "FireServer" and method ~= "InvokeServer" then
				return rec.OriginalNamecall(self, ...)
			end
			
			if self ~= rec.RemoteFunction then
				return rec.OriginalNamecall(self, ...)
			end
			
			local args = {...}
			local actionType = nil
			local cashBefore = 0
			
			local firstArg = args[1]
			local secondArg = args[2]
			
			if firstArg == "Troops" then
				if secondArg == "Place" then
					actionType = "place"
					cashBefore = getCash()
				elseif secondArg == "Upgrade" then
					actionType = "upgrade"
					cashBefore = getCash()
				elseif secondArg == "Sell" then
					actionType = "sell"
					cashBefore = getCash()
				elseif secondArg == "Ability" then
					actionType = "ability"
				elseif secondArg == "Target" then
					actionType = "target"
				elseif secondArg == "Option" then
					actionType = "option"
				end
			elseif firstArg == "Voting" and secondArg == "Skip" then
				actionType = "skip"
			end
			
			local result = rec.OriginalNamecall(self, ...)
			
			if actionType then
				task.spawn(function()
					pcall(function()
						local timestamp = os.date("%H:%M:%S")
						local wave = rec.CurrentWave
						
						if actionType == "place" then
							rec:LogPlace(args, cashBefore, wave, timestamp, result)
						elseif actionType == "upgrade" then
							rec:LogUpgrade(args, cashBefore, wave, timestamp, result)
						elseif actionType == "sell" then
							rec:LogSell(args, cashBefore, wave, timestamp, result)
						elseif actionType == "ability" then
							rec:LogAbility(args, wave, timestamp, result)
						elseif actionType == "target" then
							rec:LogTarget(args, cashBefore, wave, timestamp, result)
						elseif actionType == "option" then
							rec:LogOption(args, cashBefore, wave, timestamp, result)
						elseif actionType == "skip" then
							rec:LogSkip(wave, timestamp)
						end
					end)
				end)
			end
			
			return result
		end)
		
		self.HookEnabled = true
		return true
	end
	
	function Recorder:Stop()
		if not self.HookEnabled then
			return
		end
		
		if self.MetaTable and self.OriginalNamecall then
			self.MetaTable.__namecall = self.OriginalNamecall
			setreadonly(self.MetaTable, true)
		end
		
		self.HookEnabled = false
		self.IsRecording = false
	end
	
	function Recorder:LogPlace(args, cashBefore, wave, timestamp, remoteResult)
		task.wait(0.1)
		
		local pos = nil
		local rotation = nil
		local towerName = nil
		local towerInstance = nil
		
		local success = pcall(function()
			if typeof(args[3]) == "table" then
				if args[3].Position then
					pos = args[3].Position
				end
				if args[3].Rotation then
					rotation = args[3].Rotation
				end
			end
			if args[4] ~= nil then
				towerName = tostring(args[4])
			end
			-- Try to get tower instance from remote result
			if remoteResult and typeof(remoteResult) == "Instance" then
				towerInstance = remoteResult
			end
		end)
		
		if not success or not pos or not towerName then
			return
		end
		
		task.wait(0.2)
		local cashAfter = getCash()
		local cost = getTowerCost(towerName)
		local actualCost = cashBefore - cashAfter
		
		if actualCost > 0 then
			learnTowerCost(towerName, actualCost)
			cost = actualCost
		end
		
		local waited = cashBefore < cost
		
		-- Track tower with ID
		Recorder.TowerCount = Recorder.TowerCount + 1
		local towerId = Recorder.TowerCount
		
		-- Store tower instance if available
		if towerInstance then
			towerInstance.Name = tostring(towerId)
			Recorder.TowersList[towerId] = {
				TowerName = towerName,
				Instance = towerInstance,
				Position = pos,
				Rotation = rotation or CFrame.new()
			}
		end
		
		-- Extract rotation angles if available
		local rotX, rotY, rotZ = 0, 0, 0
		if rotation then
			rotX, rotY, rotZ = rotation:ToEulerAnglesYXZ()
		end
		
		local timer = GetTimer()
		
		table.insert(self.ActionLog, {
			type = "place",
			pos = {pos.X, pos.Y, pos.Z},
			rotation = {rotX, rotY, rotZ},
			name = towerName,
			towerId = towerId,
			wave = wave,
			timestamp = timestamp,
			timer = timer,
			waited = waited,
			cost = cost
		})
		
		self:UpdateLog()
	end
	
	function Recorder:LogUpgrade(args, cashBefore, wave, timestamp, remoteResult)
		local tower = nil
		local upgradePath = nil
		local towerId = nil
		
		local success = pcall(function()
			if typeof(args[4]) == "table" then
				tower = args[4].Troop
				upgradePath = args[4].Path or args[4].path or args[4].UpgradePath
				if tower then
					-- Try to get tower ID from name
					towerId = tonumber(tower.Name) or nil
				end
			end
		end)
		
		if not success or not tower or not tower.Parent then
			return
		end
		
		task.wait(0.3)
		
		local root = nil
		local level = 1
		local path = upgradePath or "Left"
		
		local successData = pcall(function()
			root = tower:FindFirstChild("HumanoidRootPart") or tower:FindFirstChildWhichIsA("BasePart")
			
			if root then
				local upgrades = tower:FindFirstChild("Upgrades")
				if upgrades then
					local upgradeCount = 0
					local leftPathCount = 0
					local rightPathCount = 0
					
					for _, upgrade in pairs(upgrades:GetChildren()) do
						if upgrade:IsA("Folder") or upgrade:IsA("StringValue") or upgrade:IsA("BoolValue") or upgrade:IsA("NumberValue") then
							upgradeCount = upgradeCount + 1
							local upgradeName = tostring(upgrade.Name)
							local upgradeNum = tonumber(upgradeName)
							
							if upgradeNum then
								if upgradeNum % 2 == 0 or upgradeNum == 0 then
									rightPathCount = rightPathCount + 1
								else
									leftPathCount = leftPathCount + 1
								end
							else
								local lowerName = string.lower(upgradeName)
								if string.find(lowerName, "left") or string.find(lowerName, "l") then
									leftPathCount = leftPathCount + 1
								elseif string.find(lowerName, "right") or string.find(lowerName, "r") then
									rightPathCount = rightPathCount + 1
								end
							end
						end
					end
					
					if upgradeCount > 0 then
						level = upgradeCount
						if rightPathCount > leftPathCount then
							path = "Right"
						elseif leftPathCount > rightPathCount then
							path = "Left"
						end
					end
				end
			end
		end)
		
		if not successData or not root then
			return
		end
		
		-- If tower ID not found, try to find it by matching position
		if not towerId then
			for id, towerData in pairs(Recorder.TowersList) do
				if towerData.Instance == tower then
					towerId = id
					break
				end
			end
		end
		
		local cashAfter = getCash()
		local actualCost = cashBefore - cashAfter
		local cost = getUpgradeCost(level)
		
		if actualCost > 0 then
			cost = actualCost
		end
		
		local waited = cashBefore < cost
		local timer = GetTimer()
		
		table.insert(self.ActionLog, {
			type = "upgrade",
			towerId = towerId,
			pos = {root.Position.X, root.Position.Y, root.Position.Z},
			wave = wave,
			level = level,
			path = path,
			timestamp = timestamp,
			timer = timer,
			waited = waited,
			cost = cost,
			success = remoteResult == true
		})
		
		self:UpdateLog()
	end
	
	function Recorder:LogSell(args, cashBefore, wave, timestamp, remoteResult)
		local tower = nil
		local towerId = nil
		
		local success = pcall(function()
			if typeof(args[3]) == "table" and args[3].Troop then
				tower = args[3].Troop
				towerId = tonumber(tower.Name) or nil
			end
		end)
		
		if not success or not tower then
			return
		end
		
		-- Find tower ID if not found
		if not towerId then
			for id, towerData in pairs(Recorder.TowersList) do
				if towerData.Instance == tower then
					towerId = id
					break
				end
			end
		end
		
		local timer = GetTimer()
		
		table.insert(self.ActionLog, {
			type = "sell",
			towerId = towerId,
			wave = wave,
			timestamp = timestamp,
			timer = timer,
			success = remoteResult == true or (remoteResult and not tower:FindFirstChild("HumanoidRootPart"))
		})
		
		-- Remove from towers list if sold successfully
		if towerId and Recorder.TowersList[towerId] then
			Recorder.TowersList[towerId] = nil
		end
		
		self:UpdateLog()
	end
	
	function Recorder:LogTarget(args, cashBefore, wave, timestamp, remoteResult)
		local tower = nil
		local target = nil
		local towerId = nil
		
		local success = pcall(function()
			if typeof(args[4]) == "table" then
				tower = args[4].Troop
				target = args[4].Target
				if tower then
					towerId = tonumber(tower.Name) or nil
				end
			end
		end)
		
		if not success or not tower then
			return
		end
		
		-- Find tower ID if not found
		if not towerId then
			for id, towerData in pairs(Recorder.TowersList) do
				if towerData.Instance == tower then
					towerId = id
					break
				end
			end
		end
		
		local timer = GetTimer()
		
		table.insert(self.ActionLog, {
			type = "target",
			towerId = towerId,
			target = target,
			wave = wave,
			timestamp = timestamp,
			timer = timer,
			success = remoteResult == true
		})
		
		self:UpdateLog()
	end
	
	function Recorder:LogOption(args, cashBefore, wave, timestamp, remoteResult)
		local tower = nil
		local optionName = nil
		local value = nil
		local towerId = nil
		
		local success = pcall(function()
			if typeof(args[4]) == "table" then
				tower = args[4].Troop
				optionName = args[4].Name
				value = args[4].Value
				if tower then
					towerId = tonumber(tower.Name) or nil
				end
			end
		end)
		
		if not success or not tower then
			return
		end
		
		-- Find tower ID if not found
		if not towerId then
			for id, towerData in pairs(Recorder.TowersList) do
				if towerData.Instance == tower then
					towerId = id
					break
				end
			end
		end
		
		local timer = GetTimer()
		
		table.insert(self.ActionLog, {
			type = "option",
			towerId = towerId,
			optionName = optionName,
			value = value,
			wave = wave,
			timestamp = timestamp,
			timer = timer,
			success = remoteResult == true
		})
		
		self:UpdateLog()
	end
	
	function Recorder:LogAbility(args, wave, timestamp, remoteResult)
		local tower = nil
		local abilityName = nil
		local towerId = nil
		local abilityData = nil
		
		local success = pcall(function()
			if typeof(args[4]) == "table" then
				tower = args[4].Troop
				abilityName = args[4].Name or args[4].name or args[4].AbilityName or args[4].Ability
				abilityData = args[4].Data
				if tower then
					towerId = tonumber(tower.Name) or nil
				end
			end
		end)
		
		if not success or not tower or not tower.Parent then
			return
		end
		
		-- Find tower ID if not found
		if not towerId then
			for id, towerData in pairs(Recorder.TowersList) do
				if towerData.Instance == tower then
					towerId = id
					break
				end
			end
		end
		
		task.wait(0.1)
		
		local root = nil
		local successRoot = pcall(function()
			root = tower:FindFirstChild("HumanoidRootPart") or tower:FindFirstChildWhichIsA("BasePart")
		end)
		
		if not successRoot or not root then
			return
		end
		
		if not abilityName or abilityName == "Unknown" then
			local successDetect = pcall(function()
				local towerReplicator = tower:FindFirstChild("TowerReplicator")
				if towerReplicator then
					local abilities = towerReplicator:FindFirstChild("Abilities")
					if abilities then
						local abilityList = {}
						for _, ability in pairs(abilities:GetChildren()) do
							local name = nil
							if ability:IsA("StringValue") then
								name = ability.Value
							elseif ability:IsA("ObjectValue") or ability:IsA("BoolValue") or ability:IsA("NumberValue") or ability:IsA("IntValue") then
								name = ability.Name
							elseif ability.Name then
								name = ability.Name
							end
							if name and name ~= "" then
								table.insert(abilityList, name)
							end
						end
						
						if #abilityList > 0 then
							local abilitiesData = towerReplicator:FindFirstChild("AbilitiesData")
							if abilitiesData then
								for _, abilityDataItem in pairs(abilitiesData:GetChildren()) do
									local cooldown = abilityDataItem:FindFirstChild("Cooldown") or abilityDataItem:FindFirstChild("cooldown")
									if cooldown and (cooldown:IsA("NumberValue") or cooldown:IsA("IntValue")) then
										if cooldown.Value > 0 then
											abilityName = abilityDataItem.Name
											break
										end
									end
								end
							end
							
							if not abilityName or abilityName == "Unknown" then
								abilityName = abilityList[1]
							end
						end
					end
				end
			end)
		end
		
		local timer = GetTimer()
		
		table.insert(self.ActionLog, {
			type = "ability",
			towerId = towerId,
			pos = {root.Position.X, root.Position.Y, root.Position.Z},
			wave = wave,
			ability = abilityName or "Unknown",
			abilityData = abilityData,
			timestamp = timestamp,
			timer = timer,
			success = remoteResult == true
		})
		
		self:UpdateLog()
	end
	
	function Recorder:LogSkip(wave, timestamp)
		local timer = GetTimer()
		
		table.insert(self.ActionLog, {
			type = "skip",
			wave = wave,
			timestamp = timestamp,
			timer = timer
		})
		
		self:UpdateLog()
	end
	
	local RecorderToggle = MacroTab:Toggle({
		Title = "Start Recording",
		Desc = "Enable to start recording tower actions",
		Value = false,
		Callback = function(v)
			if v then
				if Recorder:Start() then
					Window:Notify({
						Title = "Recorder",
						Desc = "Recording started!",
						Time = 2,
						Type = "normal"
					})
					RecorderToggle:SetTitle("Stop Recording")
					RecorderToggle:SetDesc("Disable to stop recording")
				else
					RecorderToggle:SetValue(false)
				end
			else
				Recorder:Stop()
				Window:Notify({
					Title = "Recorder",
					Desc = "Recording stopped!",
					Time = 2,
					Type = "normal"
				})
				RecorderToggle:SetTitle("Start Recording")
				RecorderToggle:SetDesc("Enable to start recording tower actions")
			end
		end
	})
	
	MacroTab:Button({
		Title = "Clear Log",
		Desc = "Clear the recorder log",
		Callback = function()
			Recorder.ActionLog = {}
			Recorder:UpdateLog()
			Window:Notify({
				Title = "Recorder",
				Desc = "Log cleared!",
				Time = 2,
				Type = "normal"
			})
		end
	})
	
	MacroTab:Button({
		Title = "Copy Script",
		Desc = "Copy the recorded script to clipboard",
		Callback = function()
			local luaText = Recorder:FormatLuaLog()
			if luaText and #luaText > 0 then
				if setclipboard then
					setclipboard(luaText)
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
					Desc = "No actions recorded yet!",
					Time = 3,
					Type = "error"
				})
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
if not getgenv().LunarisXWebhook then
	getgenv().LunarisXWebhook = {
		Url = ""
	}
end

local WebhookTab = Window:Tab({Title = "Webhook", Icon = randomIcon}) do
    local url = getgenv().LunarisXWebhook.Url or ""
    
    WebhookTab:Section({Title = "Webhook Configuration"})
    local WebhookUrlInput = WebhookTab:Textbox({
        Title = "Discord Webhook URL",
        Desc = "enter your discord webhook url",
        Placeholder = "https://discord.com/api/webhooks/...",
        Value = url,
        ClearTextOnFocus = false,
        Callback = function(text)
            url = text
            getgenv().LunarisXWebhook.Url = text
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
    ConfigStorage.WebhookUrlInput = WebhookUrlInput
    
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
                            
                            if tabButton:IsA("GuiButton") then
                                tabButton.Activated:Connect(function()
                                    task.wait(0.2)
                                    loadSavedAnnouncements()
                                end)
                            elseif tabButton:IsA("TextButton") or tabButton:IsA("ImageButton") then
                            tabButton.MouseButton1Click:Connect(function()
                                task.wait(0.2)
                                loadSavedAnnouncements()
                            end)
                            end
                            
                            -- Optimized announcement polling system
                            local announcementUrl = "https://getlunarisx.cc/announce/recieve"
                            local HttpService = game:GetService("HttpService")
                            local lastMessage = nil
                            local receivedMessages = {}
                            
                            task.spawn(function()
                                while task.wait(2) do
                                    local success, response = pcall(function()
                                        return game:HttpGet(announcementUrl)
                                    end)
                                    
                                    if success and response then
                                        -- Check if the response is JSON or plain text
                                        local msg = response
                                        if response:sub(1, 1) == "{" then
                                            local decoded = HttpService:JSONDecode(response)
                                            msg = decoded.message or decoded.text or decoded.announcement or response
                                        end
                                        
                                        -- Only process if message changed and not already received
                                        if msg and msg ~= lastMessage and not receivedMessages[msg] then
                                            lastMessage = msg
                                            receivedMessages[msg] = true
                                            
                                            -- Add to UI
                                            if Window.AddAnnouncementToUI then
                                                Window:AddAnnouncementToUI(msg)
                                            end
                                            
                                            -- Show notification
                                            Window:Notify({
                                                Title = "Announcement",
                                                Desc = msg,
                                                Time = 10,
                                                Type = "normal"
                                            })
                                            
                                            -- Save to file
                                            if readfile and writefile then
                                                task.spawn(function()
                                                    local Players = game:GetService("Players")
                                                    local localPlayer = Players.LocalPlayer
                                                    if localPlayer then
                                                        local client_id = tostring(localPlayer.UserId)
                                                        local saveFilePath = "LunarisX_Announcements_" .. client_id .. ".json"
                                                        
                                                        local success2, fileData = pcall(function()
                                                            return readfile(saveFilePath)
                                                        end)
                                                        
                                                        local savedData = {}
                                                        if success2 and fileData and fileData ~= "" then
                                                            local success3, decoded = pcall(function()
                                                                return HttpService:JSONDecode(fileData)
                                                            end)
                                                            if success3 and decoded and type(decoded.Announcements) == "table" then
                                                                savedData = decoded
                                                            end
                                                        end
                                                        
                                                        if not savedData.Announcements then
                                                            savedData.Announcements = {}
                                                        end
                                                        
                                                        local newId = tostring(#savedData.Announcements + 1)
                                                        savedData.Announcements[newId] = msg
                                                        
                                                        pcall(function()
                                                            writefile(saveFilePath, HttpService:JSONEncode(savedData))
                                                        end)
                                                    end
                                                end)
                                            end
                                        end
                                    else
                                        warn("[Announcement Error]", response)
                                    end
                                end
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
                            
                            local function addLogEntry(text)
                                if not logScrollingFrame then return end
                                
                                local logFrame = Instance.new("Frame")
                                local UICorner = Instance.new("UICorner")
                                local UIPadding = Instance.new("UIPadding")
                                local MessageLabel = Instance.new("TextLabel")
                                
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
                                MessageLabel.Size = UDim2.new(1, 0, 0, 0)
                                MessageLabel.Font = Enum.Font.Gotham
                                MessageLabel.Text = text
                                MessageLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
                                MessageLabel.TextSize = 12
                                MessageLabel.TextWrapped = true
                                MessageLabel.TextXAlignment = Enum.TextXAlignment.Left
                                MessageLabel.TextYAlignment = Enum.TextYAlignment.Top
                                MessageLabel.AutomaticSize = Enum.AutomaticSize.Y
                            end
                            
                            addLogEntry("Added Macro")
                            addLogEntry("Added Keybind Setting Fixed the ui glitched")
                            addLogEntry("Added Record (Testing)")

                            
                            break
                        end
                    end
                end
            end
        end
    end)
end

Window:Line()

local Settings = Window:Tab({Title = "Settings", Icon = "wrench"}) do
    Settings:Section({Title = "UI Settings"})
    
    local currentKeybind = Window:GetUIToggleKeybind() or Enum.KeyCode.LeftControl
    local UIToggleKeybind = Settings:Keybind({
        Title = "UI Toggle Keybind",
        Desc = "press to change the keybind for opening/closing the ui",
        Key = currentKeybind,
        Callback = function(key)
            if Window.SetUIToggleKeybind then
                local oldKeybind = Window:GetUIToggleKeybind()
                if oldKeybind ~= key then
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
    ConfigStorage.UIToggleKeybind = UIToggleKeybind
    
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
    
    Settings:Section({Title = "Config Management"})
    
    local function SaveConfig()
        if not writefile then
            Window:Notify({
                Title = "Error",
                Desc = "File system not available",
                Time = 3,
                Type = "error"
            })
            return false
        end
        
        local success, result = pcall(function()
            local HttpService = game:GetService("HttpService")
            
            local configData = {
                Macro = {
                    MarcoUrl = getgenv().LunarisX.MarcoUrl or "",
                    AtWave = getgenv().LunarisX.AtWave or 1,
                    SellAllTower = getgenv().LunarisX.SellAllTower or false
                },
                Webhook = {
                    Url = getgenv().LunarisXWebhook.Url or ""
                },
                UI = {
                    UIToggleKeybind = tostring(Window:GetUIToggleKeybind() or Enum.KeyCode.LeftControl)
                }
            }
            
            local jsonData = HttpService:JSONEncode(configData)
            writefile("LunarisX_Config.json", jsonData)
            return true
        end)
        
        if success then
            Window:Notify({
                Title = "Success",
                Desc = "Config saved successfully!",
                Time = 3,
                Type = "normal"
            })
            return true
        else
            Window:Notify({
                Title = "Error",
                Desc = "Failed to save config: " .. tostring(result),
                Time = 5,
                Type = "error"
            })
            return false
        end
    end
    
    local function LoadConfig()
        if not readfile then
            Window:Notify({
                Title = "Error",
                Desc = "File system not available",
                Time = 3,
                Type = "error"
            })
            return false
        end
        
        local success, fileData = pcall(function()
            return readfile("LunarisX_Config.json")
        end)
        
        if not success or not fileData or fileData == "" then
            Window:Notify({
                Title = "Error",
                Desc = "Config file not found",
                Time = 3,
                Type = "error"
            })
            return false
        end
        
        local HttpService = game:GetService("HttpService")
        local success2, configData = pcall(function()
            return HttpService:JSONDecode(fileData)
        end)
        
        if not success2 or not configData then
            Window:Notify({
                Title = "Error",
                Desc = "Failed to parse config file",
                Time = 3,
                Type = "error"
            })
            return false
        end
        
        -- Load Macro settings
        if configData.Macro then
            if configData.Macro.MarcoUrl ~= nil then
                getgenv().LunarisX.MarcoUrl = configData.Macro.MarcoUrl
                if ConfigStorage.MacroUrlInput and ConfigStorage.MacroUrlInput.SetValue then
                    ConfigStorage.MacroUrlInput:SetValue(configData.Macro.MarcoUrl)
                end
            end
            if configData.Macro.AtWave ~= nil then
                getgenv().LunarisX.AtWave = configData.Macro.AtWave
                if ConfigStorage.AtWaveInput and ConfigStorage.AtWaveInput.SetValue then
                    ConfigStorage.AtWaveInput:SetValue(tostring(configData.Macro.AtWave))
                end
            end
            if configData.Macro.SellAllTower ~= nil then
                getgenv().LunarisX.SellAllTower = configData.Macro.SellAllTower
                if ConfigStorage.SellAllTowerToggle and ConfigStorage.SellAllTowerToggle.SetValue then
                    ConfigStorage.SellAllTowerToggle:SetValue(configData.Macro.SellAllTower)
                end
            end
            
            -- Also update the Macro.json file
            if writefile then
                pcall(function()
                    local saveData = {
                        MarcoUrl = getgenv().LunarisX.MarcoUrl or "",
                        AtWave = getgenv().LunarisX.AtWave or 1,
                        SellAllTower = getgenv().LunarisX.SellAllTower or false
                    }
                    writefile("LunarisX_Macro.json", HttpService:JSONEncode(saveData))
                end)
            end
        end
        
        -- Load Webhook settings
        if configData.Webhook then
            if configData.Webhook.Url ~= nil then
                getgenv().LunarisXWebhook.Url = configData.Webhook.Url
                if ConfigStorage.WebhookUrlInput and ConfigStorage.WebhookUrlInput.SetValue then
                    ConfigStorage.WebhookUrlInput:SetValue(configData.Webhook.Url)
                end
            end
        end
        
        -- Load UI settings
        if configData.UI then
            if configData.UI.UIToggleKeybind then
                local keyCodeName = configData.UI.UIToggleKeybind:gsub("Enum.KeyCode.", "")
                local newKeybind = Enum.KeyCode[keyCodeName]
                if newKeybind and Window.SetUIToggleKeybind then
                    Window:SetUIToggleKeybind(newKeybind)
                    if ConfigStorage.UIToggleKeybind and ConfigStorage.UIToggleKeybind.SetKey then
                        ConfigStorage.UIToggleKeybind:SetKey(newKeybind)
                    end
                    
                    -- Also update the UIKeybind.json file
                    if writefile then
                        pcall(function()
                            local saveData = {
                                UIToggleKeybind = tostring(newKeybind)
                            }
                            writefile("LunarisX_UIKeybind.json", HttpService:JSONEncode(saveData))
                        end)
                    end
                end
            end
        end
        
        Window:Notify({
            Title = "Success",
            Desc = "Config loaded successfully!",
            Time = 3,
            Type = "normal"
        })
        return true
    end
    
    Settings:Button({
        Title = "Save Config",
        Desc = "save all current settings to config file",
        Callback = function()
            SaveConfig()
        end
    })
    
    Settings:Button({
        Title = "Load Config",
        Desc = "load all settings from config file",
        Callback = function()
            LoadConfig()
        end
    })
    
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

Window:Notify({
    Title = "LunarisX",
    Desc = "all components loaded!",
    Time = 4,
    Type = "normal"
})
