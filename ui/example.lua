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
	
	local isRecording = false
	local actionLog = {}
	local hookEnabled = false
	local originalNamecall = nil
	local mt = nil
	local currentWave = 1
	
	local function getCurrentWave()
		local ReplicatedStorage = game:GetService("ReplicatedStorage")
		local success, wave = pcall(function()
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
	
	local function UpdateRecorderLog()
		local logMessages = {}
		local waveActions = {}
		
		for _, action in ipairs(actionLog) do
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
	
	local function formatLuaLog()
		local lines = {}
		local waveActions = {}
		
		for _, v in ipairs(actionLog) do
			if not waveActions[v.wave] then
				waveActions[v.wave] = {}
			end
			table.insert(waveActions[v.wave], v)
		end
		
		local sortedWaves = {}
		for wave, _ in pairs(waveActions) do
			table.insert(sortedWaves, wave)
		end
		table.sort(sortedWaves)
		
		for _, wave in ipairs(sortedWaves) do
			local actions = waveActions[wave]
			table.insert(lines, string.format("-- Wave %d", wave))
			for _, v in ipairs(actions) do
				if v.type == "place" then
					if v.waited then
						local cost = getTowerCost(v.name)
						table.insert(lines, string.format('waitForMoney(%d) -- %s', cost, v.name))
						table.insert(lines, string.format('place(%.3f, %.3f, %.3f, "%s")', 
							v.pos[1], v.pos[2], v.pos[3], v.name))
					else
						table.insert(lines, string.format('place(%.3f, %.3f, %.3f, "%s")', 
							v.pos[1], v.pos[2], v.pos[3], v.name))
					end
				elseif v.type == "upgrade" then
					local level = v.level or 1
					local path = v.path or "Left"
					if v.waited then
						local cost = getUpgradeCost(level)
						table.insert(lines, string.format('waitForMoney(%d) -- upgrade to lvl %d (%s)', cost, level, path))
						if path == "Right" then
							table.insert(lines, string.format('upgradeRight(%.3f, %.3f, %.3f, %d)', 
								v.pos[1], v.pos[2], v.pos[3], level))
						else
							table.insert(lines, string.format('upgrade(%.3f, %.3f, %.3f, %d)', 
								v.pos[1], v.pos[2], v.pos[3], level))
						end
					else
						if path == "Right" then
							table.insert(lines, string.format('upgradeRight(%.3f, %.3f, %.3f, %d)', 
								v.pos[1], v.pos[2], v.pos[3], level))
						else
							table.insert(lines, string.format('upgrade(%.3f, %.3f, %.3f, %d)', 
								v.pos[1], v.pos[2], v.pos[3], level))
						end
					end
				elseif v.type == "ability" then
					table.insert(lines, string.format('ability(%.3f, %.3f, %.3f, "%s")', 
						v.pos[1], v.pos[2], v.pos[3], v.ability or "Unknown"))
				elseif v.type == "skip" then
					table.insert(lines, string.format('skip() -- Wave %d', v.wave))
				end
			end
		end
		return table.concat(lines, "\n")
	end
	
	local RecorderToggle = MacroTab:Toggle({
		Title = "Start Recording",
		Desc = "Enable to start recording tower actions",
		Value = false,
		Callback = function(v)
			isRecording = v
			
			if v then
				if not hookEnabled then
					local ReplicatedStorage = game:GetService("ReplicatedStorage")
					local remoteFunction = ReplicatedStorage:WaitForChild("RemoteFunction", 10)
					
					if remoteFunction then
						currentWave = getCurrentWave()
						
						task.spawn(function()
							local ReplicatedStorage = game:GetService("ReplicatedStorage")
							local gameWave = ReplicatedStorage:WaitForChild("GameWave", 10)
							if gameWave then
								gameWave:GetPropertyChangedSignal("Value"):Connect(function()
									if isRecording then
										currentWave = tonumber(gameWave.Value) or currentWave
									end
								end)
							end
						end)
						
						mt = getrawmetatable(game)
						originalNamecall = mt.__namecall
						setreadonly(mt, false)
						
						mt.__namecall = newcclosure(function(self, ...)
							if type(isRecording) ~= "boolean" or not isRecording then
								return originalNamecall(self, ...)
							end
							
							local method = getnamecallmethod()
							if method ~= "FireServer" and method ~= "InvokeServer" then
								return originalNamecall(self, ...)
							end
							
							if self ~= remoteFunction then
								return originalNamecall(self, ...)
							end
							
							local args = {...}
							
							local timestamp = os.date("%H:%M:%S")
							local wave = getCurrentWave()
							if wave > 0 then
								currentWave = wave
							end
							
							local isPlaceAction = false
							local cashBefore = 0
							
							if args[1] == "Troops" and args[2] == "Place" then
								isPlaceAction = true
								cashBefore = getCash()
							end
							
							local result = originalNamecall(self, ...)
							
							if isPlaceAction then
								task.spawn(function()
									pcall(function()
										local pos = nil
										local towerName = nil
										
										local successExtract = pcall(function()
											if typeof(args[3]) == "table" and args[3].Position then
												local position = args[3].Position
												if typeof(position) == "Vector3" then
													pos = position
												end
											end
											if args[4] ~= nil then
												towerName = tostring(args[4])
											end
										end)
										
										if successExtract and pos and towerName then
											task.wait(0.2)
											local cashAfter = getCash()
											local cost = getTowerCost(towerName)
											local actualCost = cashBefore - cashAfter
											
											if actualCost > 0 then
												learnTowerCost(towerName, actualCost)
												cost = actualCost
											end
											
											local waited = cashBefore < cost
											
											if waited and cost > 0 then
												table.insert(actionLog, {
													type = "place",
													pos = {pos.X, pos.Y, pos.Z},
													name = towerName,
													wave = currentWave,
													timestamp = timestamp,
													waited = true,
													cost = cost
												})
											else
												table.insert(actionLog, {
													type = "place",
													pos = {pos.X, pos.Y, pos.Z},
													name = towerName,
													wave = currentWave,
													timestamp = timestamp,
													waited = false,
													cost = cost
												})
											end
											UpdateRecorderLog()
										end
									end)
								end)
							end
							
							if isPlaceAction then
								return result
							end
							
							if args[1] == "Troops" and args[2] == "Upgrade" and typeof(args[4]) == "table" and args[4].Troop then
								local tower = args[4].Troop
								local upgradePath = args[4].Path
								if not upgradePath then
									local successPath, pathValue = pcall(function()
										return args[4].Path or args[4].path or args[4].UpgradePath
									end)
									if successPath and pathValue then
										upgradePath = pathValue
									end
								end
								local cashBefore = getCash()
								local result = originalNamecall(self, ...)
								
								task.spawn(function()
									pcall(function()
										if tower and tower.Parent then
											local successRoot, root = pcall(function()
												return tower:FindFirstChild("HumanoidRootPart") or tower:FindFirstChildWhichIsA("BasePart")
											end)
											
											if successRoot and root then
												local level = 1
												local path = upgradePath or "Left"
												
												local successUpgrades, upgradeInfo = pcall(function()
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
																	if string.find(string.lower(upgradeName), "left") or string.find(string.lower(upgradeName), "l") then
																		leftPathCount = leftPathCount + 1
																	elseif string.find(string.lower(upgradeName), "right") or string.find(string.lower(upgradeName), "r") then
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
													return {level = level, path = path}
												end)
												
												if not successUpgrades then
													local successLevel, towerLevel = pcall(function()
														return tower:GetAttribute("Level") or (tower:FindFirstChild("Level") and tower.Level.Value) or 1
													end)
													if successLevel and towerLevel then
														level = tonumber(towerLevel) or 1
													end
												else
													level = upgradeInfo.level
													path = upgradeInfo.path
												end
												
												task.wait(0.2)
												local cashAfter = getCash()
												local actualCost = cashBefore - cashAfter
												
												local cost = getUpgradeCost(level)
												if actualCost > 0 then
													cost = actualCost
												end
												
												local waited = cashBefore < cost
												
												if waited then
													table.insert(actionLog, {
														type = "upgrade",
														pos = {root.Position.X, root.Position.Y, root.Position.Z},
														wave = currentWave,
														level = level,
														path = path,
														timestamp = timestamp,
														waited = true,
														cost = cost
													})
												else
													table.insert(actionLog, {
														type = "upgrade",
														pos = {root.Position.X, root.Position.Y, root.Position.Z},
														wave = currentWave,
														level = level,
														path = path,
														timestamp = timestamp,
														waited = false,
														cost = cost
													})
												end
												UpdateRecorderLog()
											end
										end
									end)
								end)
								
								return result
							end
							
							if args[1] == "Troops" and args[2] == "Ability" and typeof(args[4]) == "table" and args[4].Troop then
								local tower = args[4].Troop
								local abilityName = args[4].Name
								if not abilityName then
									local successAbility, nameValue = pcall(function()
										return args[4].Name or args[4].name or args[4].AbilityName or args[4].Ability
									end)
									if successAbility and nameValue then
										abilityName = nameValue
									end
								end
								local result = originalNamecall(self, ...)
								
								task.spawn(function()
									pcall(function()
										if tower and tower.Parent then
											local successAbilityRoot, root = pcall(function()
												return tower:FindFirstChild("HumanoidRootPart") or tower:FindFirstChildWhichIsA("BasePart")
											end)
											
											if successAbilityRoot and root then
												if not abilityName or abilityName == "Unknown" then
													local successTowerName, detectedName = pcall(function()
														if tower and tower.Parent then
															local towerReplicator = tower:FindFirstChild("TowerReplicator")
															if towerReplicator then
																local abilities = towerReplicator:FindFirstChild("Abilities")
																if abilities then
																	local abilityList = {}
																	for _, ability in pairs(abilities:GetChildren()) do
																		local name = nil
																		if ability:IsA("StringValue") then
																			name = ability.Value
																		elseif ability:IsA("ObjectValue") then
																			name = ability.Name
																		elseif ability:IsA("BoolValue") or ability:IsA("NumberValue") or ability:IsA("IntValue") then
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
																			for _, abilityData in pairs(abilitiesData:GetChildren()) do
																				local cooldown = abilityData:FindFirstChild("Cooldown") or abilityData:FindFirstChild("cooldown")
																				if cooldown and (cooldown:IsA("NumberValue") or cooldown:IsA("IntValue")) then
																					if cooldown.Value > 0 then
																						return abilityData.Name
																					end
																				end
																			end
																		end
																		
																		return abilityList[1]
																	end
																end
															end
														end
														return nil
													end)
													if successTowerName and detectedName then
														abilityName = detectedName
													end
												end
												
												table.insert(actionLog, {
													type = "ability",
													pos = {root.Position.X, root.Position.Y, root.Position.Z},
													wave = currentWave,
													ability = abilityName or "Unknown",
													timestamp = timestamp
												})
												UpdateRecorderLog()
											end
										end
									end)
								end)
								
								return result
							end
							
							if args[1] == "Voting" and args[2] == "Skip" then
								local result = originalNamecall(self, ...)
								
								task.spawn(function()
									pcall(function()
										table.insert(actionLog, {
											type = "skip",
											wave = currentWave,
											timestamp = timestamp
										})
										UpdateRecorderLog()
									end)
								end)
								
								return result
							end
							
							return originalNamecall(self, ...)
						end)
						
						hookEnabled = true
			
			Window:Notify({
							Title = "Recorder",
							Desc = "Recording started!",
							Time = 2,
				Type = "normal"
			})
						
						RecorderToggle:SetTitle("Stop Recording")
						RecorderToggle:SetDesc("Disable to stop recording")
					else
						Window:Notify({
							Title = "Error",
							Desc = "Failed to find RemoteFunction",
							Time = 3,
							Type = "error"
						})
						isRecording = false
						RecorderToggle:SetValue(false)
					end
				end
			else
				if hookEnabled and mt and originalNamecall then
					mt.__namecall = originalNamecall
					setreadonly(mt, true)
					hookEnabled = false
				end
				
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
			actionLog = {}
			UpdateRecorderLog()
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
			local luaText = formatLuaLog()
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
