local function getVers(v)
	if type(v) ~= 'function' then return v + 0.1 else return 0 end
end
local keypress = keypress or syn.keypress
local keyrelease = keyrelease or syn.keyrelease

getgenv().Version = getVers(getgenv().Version)
local version = getgenv().Version
getgenv().Playing = true

local last

print(version)

local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/Skeleton19/Orion/main/source')))()

OrionLib:MakeNotification({
	Name = "Autoplayer",
	Content = "Loading...",
	Image = "rbxassetid://4483345998",
	Time = 5
})

local chances = {0, 0, 0, 0}

local Window = OrionLib:MakeWindow({Name = "Autoplayer", HidePremium = false, SaveConfig = true, ConfigFolder = "Orion"})

--Player Tab--

local PlayerTab = Window:MakeTab({
	Name = "Main",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

local PlayerSection = PlayerTab:AddSection({
	Name = "Chances"
})

PlayerSection:AddSlider({
	Name = "Sick",
	Min = 0,
	Max = 100,
	Default = 0,
	Color = Color3.fromRGB(1,1,1),
	Increment = 1,
	ValueName = "Sick",
	Callback = function(Value)
		chances[1] = Value
	end
})

PlayerSection:AddSlider({
	Name = "Nice",
	Min = 0,
	Max = 100,
	Default = 0,
	Color = Color3.fromRGB(1,1,1),
	Increment = 1,
	ValueName = "Nice",
	Callback = function(Value)
		chances[2] = Value
	end
})

PlayerSection:AddSlider({
	Name = "Awful",
	Min = 0,
	Max = 100,
	Default = 0,
	Color = Color3.fromRGB(1,1,1),
	Increment = 1,
	ValueName = "Awful",
	Callback = function(Value)
		chances[3] = Value
	end
})

PlayerSection:AddSlider({
	Name = "Miss",
	Min = 0,
	Max = 100,
	Default = 0,
	Color = Color3.fromRGB(1,1,1),
	Increment = 1,
	ValueName = "Miss",
	Callback = function(Value)
		chances[4] = Value
	end
})

--Player Tab End--

--Settings Tab--

local SettingsTab = Window:MakeTab({
	Name = "Settings",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

local SettingsSection = SettingsTab:AddSection({
	Name = "Settings"
})

SettingsSection:AddButton({
	Name = "Destroy UI",
	Callback = function()
        OrionLib:Destroy()
  	end    
})

SettingsSection:AddToggle({
	Name = "Turn On/Off",
	Default = true,
	Callback = function(Value)
		print(Value)
        getgenv().Playing = Value
  	end    
})

--Settings End--

OrionLib:Init() --UI Lib End

local player = game.Players.LocalPlayer
local playerGui = player.PlayerGui

local gameUI = playerGui:WaitForChild('GameUI')
local realGameUI = gameUI:WaitForChild('realGameUI')
local notes = realGameUI.Notes:WaitForChild('DadNotes')
local notes1 = realGameUI.Notes:WaitForChild('BFNotes')

local function sum(a)
	local s = 0
	for i,v in pairs(a) do
		s+=v
	end
	return s
end

local function getChances(mod)
	local total = sum(chances)
	local rand = math.random(0, total)
	
	if rand <= chances[1] then
		return -0.03
	elseif rand <= chances[1]+chances[2] then
		return 0.075
	elseif rand <= chances[1]+chances[2]+chances[3] then
		return 0.13
	else
		return nil
	end
	
end

local function notesAdded(child)
	if getgenv().Version ~= version or not getgenv().Playing then return end
	if not child.Parent.Visible then return end
	child:GetPropertyChangedSignal('Position'):Wait()
	local startPos = child.Position
	task.wait(1)
	local distancePerSecond = startPos.Y.Scale - child.Position.Y.Scale
	local t = ((startPos.Y.Scale-0.069) / distancePerSecond) - 1 -0.02 -- 1.05
	local randChance = getChances(distancePerSecond)
	if not randChance then return end
	local realTime = t + randChance
	last = tick()
	if child:IsA("ImageLabel") and child.Image then
	if child.ImageRectSize == Vector2.new(78.5, 77) and child.ImageRectOffset == Vector2.new(925, 0) then
		delay(realTime, function()
			if child.Position.Y.Scale >= 0.069 then
				task.wait((child.Position.Y.Scale-0.069)/distancePerSecond)
			end
			--task.wait((child.Position.Y.Scale/distancePerSecond))
			keypress(0x26) -- Up
			task.wait(5)
			if tick()-last >= 5 then
				keyrelease(0x26) -- Up
			end
		end)
	elseif child.ImageRectSize == Vector2.new(78.5, 77) and child.ImageRectOffset == Vector2.new(925, 77) then
		delay(realTime, function()
			if child.Position.Y.Scale >= 0.069 then
				task.wait((child.Position.Y.Scale-0.069)/distancePerSecond)
			end
			print(child.Position)
			--task.wait((child.Position.Y.Scale/distancePerSecond))
			keypress(0x28) -- Down
			task.wait(5)
			if tick()-last >= 5 then
				keyrelease(0x28)-- Down
			end
		end)
	elseif child.ImageRectSize == Vector2.new(77, 78.5) and child.ImageRectOffset == Vector2.new(315, 116) then
		delay(realTime, function()
			if child.Position.Y.Scale >= 0.069 then
				task.wait((child.Position.Y.Scale-0.069)/distancePerSecond)
			end
			print(child.Position)
			--task.wait((child.Position.Y.Scale/distancePerSecond))
			keypress(0x25) -- Left
			task.wait(5)
			if tick()-last >= 5 then
				keyrelease(0x25) -- Left 
			end
		end)
	elseif child.ImageRectSize == Vector2.new(77, 78.5) and child.ImageRectOffset == Vector2.new(238, 116) then
		delay(realTime, function()
			if child.Position.Y.Scale >= 0.069 then
				task.wait((child.Position.Y.Scale-0.069)/distancePerSecond)
			end
			print(child.Position)
			--task.wait((child.Position.Y.Scale/distancePerSecond))
			keypress(0x27) -- Right
			task.wait(5)
			if tick()-last >= 5 then
				keyrelease(0x27) -- Right
			end
		end)
		 function keypress(key)
 	local input = Instance.new("InputObjectEvent")
  	input.UserInputType = Enum.UserInputType.Keyboard
  	input.KeyCode = Enum.KeyCode[key]
 	game:GetService("UserInputService").InputBegan:Fire(input)
	end
	function keyrelease(key)
  	local input = Instance.new("InputObjectEvent")
  	input.UserInputType = Enum.UserInputType.Keyboard
	input.KeyCode = Enum.KeyCode[key]
	game:GetService("UserInputService").InputEnded:Fire(input)
		end
		end
	end
end

notes.ChildAdded:Connect(notesAdded)
notes1.ChildAdded:Connect(notesAdded)
