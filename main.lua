
local plr = game.Players.LocalPlayer.Name

local Mercury = loadstring(game:HttpGet("https://raw.githubusercontent.com/deeeity/mercury-lib/master/src.lua"))()



local GUI = Mercury:Create{
    Name = "The Group Hub",
    Size = UDim2.fromOffset(600, 400),
    Theme = Mercury.Themes.Dark,
  Link = "https://github.com/deeeity/mercury-lib"
}

GUI:Notification{
	Title = "Alert",
	Text = "You are logged in as"..plr.."!",
	Duration = 3,
	Callback = function() end
}

local Tab = GUI:Tab{
	Name = "Main",
	Icon = "rbxassetid://8569322835"
}

Tab:Button{
	Name = "Fly {X}",
	Description = nil,
	Callback = function() 
local plr = game.Players.LocalPlayer
local mouse = plr:GetMouse()
local Humanoid = game.Players.LocalPlayer.Character.Humanoid or game.Players.LocalPlayer.Character.humanoid  

		localplayer = plr
		
		if workspace:FindFirstChild("Core") then
			workspace.Core:Destroy()
		end
		
		local Core = Instance.new("Part")
		Core.Name = "Core"
		Core.Size = Vector3.new(0.05, 0.05, 0.05)

		spawn(function()
			Core.Parent = workspace
			local Weld = Instance.new("Weld", Core)
			Weld.Part0 = Core
			Weld.Part1 = localplayer.Character.LowerTorso
			Weld.C0 = CFrame.new(0, 0, 0)
		end)
		
		workspace:WaitForChild("Core")
		
		local torso = workspace.Core
		flying = true
		local speed=10
		local keys={a=false,d=false,w=false,s=false} 
		local e1
		local e2
		local function start()
			local pos = Instance.new("BodyPosition",torso)
			local gyro = Instance.new("BodyGyro",torso)
			pos.Name="EPIXPOS"
			pos.maxForce = Vector3.new(math.huge, math.huge, math.huge)
			pos.position = torso.Position
			gyro.maxTorque = Vector3.new(9e9, 9e9, 9e9) 
			gyro.cframe = torso.CFrame
			repeat
				wait()
				Humanoid.PlatformStand=true
				local new=gyro.cframe - gyro.cframe.p + pos.position
				if not keys.w and not keys.s and not keys.a and not keys.d then
					speed=5
				end
				if keys.w then 
					new = new + workspace.CurrentCamera.CoordinateFrame.lookVector * speed
					speed=speed+0
				end
				if keys.s then 
					new = new - workspace.CurrentCamera.CoordinateFrame.lookVector * speed
					speed=speed+0
				end
				if keys.d then 
					new = new * CFrame.new(speed,0,0)
					speed=speed+0
				end
				if keys.a then 
					new = new * CFrame.new(-speed,0,0)
					speed=speed+0
				end
				if speed>10 then
					speed=5
				end
				pos.position=new.p
				if keys.w then
					gyro.cframe = workspace.CurrentCamera.CoordinateFrame*CFrame.Angles(-math.rad(speed*0),0,0)
				elseif keys.s then
					gyro.cframe = workspace.CurrentCamera.CoordinateFrame*CFrame.Angles(math.rad(speed*0),0,0)
				else
					gyro.cframe = workspace.CurrentCamera.CoordinateFrame
				end
			until flying == false
			if gyro then gyro:Destroy() end
			if pos then pos:Destroy() end
			flying=false
			Humanoid.PlatformStand=false
			speed=10
		end
		e1=mouse.KeyDown:connect(function(key)
			if not torso or not torso.Parent then flying=false e1:disconnect() e2:disconnect() return end
			if key=="w" then
				keys.w=true
			elseif key=="s" then
				keys.s=true
			elseif key=="a" then
				keys.a=true
			elseif key=="d" then
				keys.d=true
			elseif key=="x" then
				if flying==true then
					flying=false
				else
					flying=true
					start()
				end
			end
		end)
		e2=mouse.KeyUp:connect(function(key)
			if key=="w" then
				keys.w=false
			elseif key=="s" then
				keys.s=false
			elseif key=="a" then
				keys.a=false
			elseif key=="d" then
				keys.d=false
			end
		end)
		start()
  end
    }

	Tab:Button{
	Name = "Aimlock {Q}",
	Description = nil,
	Callback = function()
local CC = game:GetService"Workspace".CurrentCamera
    local Plr
    local enabled = falseWD
    local accomidationfactor =  0.1377
    local mouse = game.Players.LocalPlayer:GetMouse()
    local placemarker = Instance.new("Part", game.Workspace)

    function makemarker(Parent, Adornee, Color, Size, Size2)
        local e = Instance.new("BillboardGui", Parent)
        e.Name = "PP"
        e.Adornee = Adornee
        e.Size = UDim2.new(Size, Size2, Size, Size2)
        e.AlwaysOnTop = true
        local a = Instance.new("Frame", e)
        a.Size = UDim2.new(1, 0, 1, 0)
        a.BackgroundTransparency = 0
        a.BackgroundColor3 = Color
        local g = Instance.new("UICorner", a)
        g.CornerRadius = UDim.new(50, 50)
        return(e)
    end

    
    local data = game.Players:GetPlayers()
    function noob(player)
        local character
        repeat wait() until player.Character
        local handler = makemarker(guimain, player.Character:WaitForChild("HumanoidRootPart"), Color3.fromRGB(107, 184, 255), 0.3, 3)
        handler.Name = player.Name
        player.CharacterAdded:connect(function(Char) handler.Adornee = Char:WaitForChild("HumanoidRootPart") end)


        spawn(function()
            while wait() do
                if player.Character then
                    TextLabel.Text = player.Name..tostring(player:WaitForChild("leaderstats").Wanted.Value).." | "..tostring(math.floor(player.Character:WaitForChild("Humanoid").Health))
                end
            end
        end)
    end

    for i = 1, #data do
        if data[i] ~= game.Players.LocalPlayer then
            noob(data[i])
        end
    end

    game.Players.PlayerAdded:connect(function(Player)
        noob(Player)
    end)

    spawn(function()
        placemarker.Anchored = true
        placemarker.CanCollide = false
        placemarker.Size = Vector3.new(8, 8, 8)
        placemarker.Transparency = 0.75
        makemarker(placemarker, placemarker, Color3.fromRGB(255, 0, 0), 0.40, 0)
    end)    

mouse.KeyDown:Connect(function(k)
    if k ~= "q" then return end
    if enabled then
        enabled = false
        guimain[Plr.Name].Frame.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    else
        enabled = true 
        Plr = getClosestPlayerToCursor()
        guimain[Plr.Name].Frame.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    end    
end)

    function getClosestPlayerToCursor()
        local closestPlayer
        local shortestDistance = math.huge

        for i, v in pairs(game.Players:GetPlayers()) do
            if v ~= game.Players.LocalPlayer and v.Character and v.Character:FindFirstChild("Humanoid") and v.Character.Humanoid.Health ~= 0 and v.Character:FindFirstChild("HumanoidRootPart") then
                local pos = CC:WorldToViewportPoint(v.Character.PrimaryPart.Position)
                local magnitude = (Vector2.new(pos.X, pos.Y) - Vector2.new(mouse.X, mouse.Y)).magnitude
                if magnitude < shortestDistance then
                    closestPlayer = v
                    shortestDistance = magnitude
                end
            end
        end
        return closestPlayer
    end

    game:GetService"RunService".Stepped:connect(function()
        if enabled and Plr.Character and Plr.Character:FindFirstChild("HumanoidRootPart") then
            placemarker.CFrame = CFrame.new(Plr.Character.HumanoidRootPart.Position+(Plr.Character.HumanoidRootPart.Velocity*accomidationfactor))
        else
            placemarker.CFrame = CFrame.new(0, 9999, 0)
        end
    end)

    local mt = getrawmetatable(game)
    local old = mt.__namecall
    setreadonly(mt, false)
    mt.__namecall = newcclosure(function(...)
        local args = {...}
        if enabled and getnamecallmethod() == "FireServer" and args[2] == "UpdateMousePos" then
            args[3] = Plr.Character.HumanoidRootPart.Position+(Plr.Character.HumanoidRootPart.Velocity*accomidationfactor)
            return old(unpack(args))
        end
        return old(...)
    end)
end
	}



Tab:Button{
	Name = "Trash talk {J}",
	Description = nil,
	Callback = function()
  local words = {
    'You play like your paralysed',
    'Sleep Well',
    'im not locking ur just bad',
    'kid im not locking ur just bad',
    'sad',
    'sonned',
    'you looked tired',
    'Imagine dying',
    'ezzz',
    'Im getting bored this is too easy',
    'The Group Hub On Top',
}

local player = game.Players.LocalPlayer
local keybind = 'j'

local event = game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest

player:GetMouse().KeyDown:connect(function(key)
    if key == keybind then
        event:FireServer(words[math.random(#words)], "All")
    end
end) 
  end
}

Tab:Button{
	Name = "Teleport to Revolver",
	Description = nil,
	Callback = function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-673.597778, 47.2757416, -146.78067, 0.0163797997, 1.94381027e-08, -0.99986583, 2.94266851e-08, 1, 1.99227781e-08, 0.99986583, -2.9749069e-08, 0.0163797997)
  end
}

Tab:Button{
	Name = "Animation Pack",
	Description = nil,
	Callback = function()
  

for _, v in next, game:GetService("CoreGui"):GetChildren() do
    if (v.Name:match("Animation")) then
        v:Destroy()
    end
end

local Folder = Instance.new('Folder', game:GetService("Workspace"))
Folder.Name = ("Animation")

local LeanAnimation = Instance.new("Animation", Folder)
LeanAnimation.Name = "LeanAnimation"
LeanAnimation.AnimationId = "rbxassetid://3152375249"

local LayAnimation = Instance.new("Animation", Folder)
LayAnimation.Name = "LayAnimation"
LayAnimation.AnimationId = "rbxassetid://3152378852"

local Dance1Animation = Instance.new("Animation", Folder)
Dance1Animation.Name = "Dance1Animation"
Dance1Animation.AnimationId = "rbxassetid://3189773368"

local Dance2Animation = Instance.new("Animation", Folder)
Dance2Animation.Name = "Dance2Animation"
Dance2Animation.AnimationId = "rbxassetid://3189776546"

local GreetAnimation = Instance.new("Animation", Folder)
GreetAnimation.Name = "GreetAnimation"
GreetAnimation.AnimationId = "rbxassetid://3189777795"

local ChestPumpAnimation = Instance.new("Animation", Folder)
ChestPumpAnimation.Name = "ChestPumpAnimation"
ChestPumpAnimation.AnimationId = "rbxassetid://3189779152"

local PrayingAnimation = Instance.new("Animation", Folder)
PrayingAnimation.Name = "PrayingAnimation"
PrayingAnimation.AnimationId = "rbxassetid://3487719500"

if game.PlaceId == 2788229376 then
    function AnimationPack(Character)
        Character:WaitForChild'HumanoidRootPart'
        local Animation = Instance.new("ScreenGui")
        local AnimationPack = Instance.new("TextButton")
        local CloseButton = Instance.new("TextButton")
        local ScrollingFrame = Instance.new("ScrollingFrame")
        local ChestPumpButton = Instance.new("TextButton")
        local Dance1Button = Instance.new("TextButton")
        local Dance2Button = Instance.new("TextButton")
        local LayButton = Instance.new("TextButton")
        local GreetButton = Instance.new("TextButton")
        local LeanButton = Instance.new("TextButton")
        local PrayingButton = Instance.new("TextButton")

        Animation.Name = "Animation"
        Animation.Parent = game.CoreGui
        Animation.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

        AnimationPack.Name = "AnimationPack"
        AnimationPack.Parent = Animation
        AnimationPack.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        AnimationPack.BorderSizePixel = 0
        AnimationPack.Position = UDim2.new(0, 0, 0.5, 0)
        AnimationPack.Size = UDim2.new(0, 100, 0, 20)
        AnimationPack.Visible = false
        AnimationPack.Font = Enum.Font.SourceSansBold
        AnimationPack.Text = "Animations"
        AnimationPack.TextColor3 = Color3.fromRGB(0, 0, 0)
        AnimationPack.TextSize = 18.000

        CloseButton.Name = "CloseButton"
        CloseButton.Parent = AnimationPack
        CloseButton.BackgroundColor3 = Color3.fromRGB(255, 112, 112)
        CloseButton.Position = UDim2.new(0, 0, 0, 97)
        CloseButton.Size = UDim2.new(0, 120, 0, 25)
        CloseButton.Visible = false
        CloseButton.Font = Enum.Font.SourceSansBold
        CloseButton.Text = "CLOSE"
        CloseButton.TextColor3 = Color3.fromRGB(0, 0, 0)
        CloseButton.TextSize = 30.000

        ScrollingFrame.Parent = AnimationPack
        ScrollingFrame.Active = true
        ScrollingFrame.AnchorPoint = Vector2.new(0.5, 0.5)
        ScrollingFrame.BackgroundColor3 = Color3.fromRGB(102, 102, 102)
        ScrollingFrame.Position = UDim2.new(0, 60, 0, 0)
        ScrollingFrame.Size = UDim2.new(0, 120, 0, 195)
        ScrollingFrame.Visible = false
        ScrollingFrame.CanvasSize = UDim2.new(0, 0, 1, 200)

        ChestPumpButton.Name = "ChestPumpButton"
        ChestPumpButton.Parent = ScrollingFrame
        ChestPumpButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        ChestPumpButton.Position = UDim2.new(0, 0, 0.727272749, 0)
        ChestPumpButton.Size = UDim2.new(1, 0, 0, 30)
        ChestPumpButton.Font = Enum.Font.GothamBlack
        ChestPumpButton.Text = "Chest Pump"
        ChestPumpButton.TextColor3 = Color3.fromRGB(0, 0, 0)
        ChestPumpButton.TextSize = 12.000
        ChestPumpButton.TextWrapped = true

        Dance1Button.Name = "Dance1Button"
        Dance1Button.Parent = ScrollingFrame
        Dance1Button.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Dance1Button.Position = UDim2.new(0, 0, 0.290909111, 0)
        Dance1Button.Size = UDim2.new(1, 0, 0, 30)
        Dance1Button.Font = Enum.Font.GothamBlack
        Dance1Button.Text = "Dance1"
        Dance1Button.TextColor3 = Color3.fromRGB(0, 0, 0)
        Dance1Button.TextSize = 12.000
        Dance1Button.TextWrapped = true

        Dance2Button.Name = "Dance2Button"
        Dance2Button.Parent = ScrollingFrame
        Dance2Button.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Dance2Button.Position = UDim2.new(0, 0, 0.436363667, 0)
        Dance2Button.Size = UDim2.new(1, 0, 0, 30)
        Dance2Button.Font = Enum.Font.GothamBlack
        Dance2Button.Text = "Dance2"
        Dance2Button.TextColor3 = Color3.fromRGB(0, 0, 0)
        Dance2Button.TextSize = 12.000
        Dance2Button.TextWrapped = true

        LayButton.Name = "LayButton"
        LayButton.Parent = ScrollingFrame
        LayButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        LayButton.Position = UDim2.new(0, 0, 0.145454556, 0)
        LayButton.Size = UDim2.new(1, 0, 0, 30)
        LayButton.Font = Enum.Font.GothamBlack
        LayButton.Text = "Lay"
        LayButton.TextColor3 = Color3.fromRGB(0, 0, 0)
        LayButton.TextSize = 12.000
        LayButton.TextWrapped = true

        GreetButton.Name = "GreetButton"
        GreetButton.Parent = ScrollingFrame
        GreetButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        GreetButton.Position = UDim2.new(0, 0, 0.581818223, 0)
        GreetButton.Size = UDim2.new(1, 0, 0, 30)
        GreetButton.Font = Enum.Font.GothamBlack
        GreetButton.Text = "Greet"
        GreetButton.TextColor3 = Color3.fromRGB(0, 0, 0)
        GreetButton.TextSize = 12.000
        GreetButton.TextWrapped = true

        LeanButton.Name = "LeanButton"
        LeanButton.Parent = ScrollingFrame
        LeanButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        LeanButton.Size = UDim2.new(1, 0, 0, 30)
        LeanButton.Font = Enum.Font.GothamBlack
        LeanButton.Text = "Lean"
        LeanButton.TextColor3 = Color3.fromRGB(0, 0, 0)
        LeanButton.TextSize = 12.000
        LeanButton.TextWrapped = true

        PrayingButton.Name = "PrayingButton"
        PrayingButton.Parent = ScrollingFrame
        PrayingButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        PrayingButton.Position = UDim2.new(5.96046448e-08, 0, 0.872727275, 0)
        PrayingButton.Size = UDim2.new(1, 0, 0, 30)
        PrayingButton.Font = Enum.Font.GothamBlack
        PrayingButton.Text = "Praying"
        PrayingButton.TextColor3 = Color3.fromRGB(0, 0, 0)
        PrayingButton.TextSize = 12.000
        PrayingButton.TextWrapped = true

        wait(1)

        local AnimationPack = game:GetService("CoreGui").Animation.AnimationPack
        local ScrollingFrame = AnimationPack.ScrollingFrame
        local CloseButton = AnimationPack.CloseButton

        AnimationPack.Visible = true

        local Lean = game:GetService("Players").LocalPlayer.Character.Humanoid:LoadAnimation(LeanAnimation)

        local Lay = game:GetService("Players").LocalPlayer.Character.Humanoid:LoadAnimation(LayAnimation)

        local Dance1 = game:GetService("Players").LocalPlayer.Character.Humanoid:LoadAnimation(Dance1Animation)

        local Dance2 = game:GetService("Players").LocalPlayer.Character.Humanoid:LoadAnimation(Dance2Animation)

        local Greet = game:GetService("Players").LocalPlayer.Character.Humanoid:LoadAnimation(GreetAnimation)

        local ChestPump = game:GetService("Players").LocalPlayer.Character.Humanoid:LoadAnimation(ChestPumpAnimation)

        local Praying = game:GetService("Players").LocalPlayer.Character.Humanoid:LoadAnimation(PrayingAnimation)

        function Stop()
            Lay:Stop()
            Lean:Stop()
            Dance1:Stop()
            Dance2:Stop()
            Greet:Stop()
            ChestPump:Stop()
            Praying:Stop()
        end

        local LeanTextButton = ScrollingFrame.LeanButton
        local LayTextButton = ScrollingFrame.LayButton
        local Dance1TextButton = ScrollingFrame.Dance1Button
        local Dance2TextButton = ScrollingFrame.Dance2Button
        local GreetTextButton = ScrollingFrame.GreetButton
        local ChestPumpTextButton = ScrollingFrame.ChestPumpButton
        local PrayingTextButton = ScrollingFrame.PrayingButton

        AnimationPack.MouseButton1Click:Connect(function()
            if ScrollingFrame.Visible == false then
                ScrollingFrame.Visible = true
                CloseButton.Visible = true
            end
        end)
        CloseButton.MouseButton1Click:Connect(function()
            if ScrollingFrame.Visible == true then
                ScrollingFrame.Visible = false
                CloseButton.Visible = false
            end
        end)
        LeanTextButton.MouseButton1Click:Connect(function()
            Stop()
            Lean:Play()
        end)
        LayTextButton.MouseButton1Click:Connect(function()
            Stop()
            Lay:Play()
        end)
        Dance1TextButton.MouseButton1Click:Connect(function()
            Stop()
            Dance1:Play()
        end)
        Dance2TextButton.MouseButton1Click:Connect(function()
            Stop()
            Dance2:Play()
        end)
        GreetTextButton.MouseButton1Click:Connect(function()
            Stop()
            Greet:Play()
        end)
        ChestPumpTextButton.MouseButton1Click:Connect(function()
            Stop()
            ChestPump:Play()
        end)
        PrayingTextButton.MouseButton1Click:Connect(function()
            Stop()
            Praying:Play()
        end)

        game:GetService("Players").LocalPlayer.Character.Humanoid.Running:Connect(function()
            Stop()
        end)
        game:GetService("Players").LocalPlayer.CharacterAdded:Connect(function()
            game.CoreGui.Animation:Destroy()
        end)
    end
    AnimationPack(game.Players.LocalPlayer.Character)
    game.Players.LocalPlayer.CharacterAdded:Connect(AnimationPack)
    end
  end
}

Tab:Button{
	Name = "Headless",
	Description = nil,
	Callback = function()
game.Players.LocalPlayer.Character.Head.Size = Vector3.new(0,0, 0)
    game.Players.LocalPlayer.Character.Head.Size = Vector3.new(0,0, 0)
    game.Players.LocalPlayer.Character.Head.Massless = true
    game.Players.LocalPlayer.Character.Head.Massless = true
  end
}

Tab:Button{
	Name = "Korblox",
	Description = nil,
	Callback = function()
  local ply = game.Players.LocalPlayer
        local chr = ply.Character
        chr.RightLowerLeg.MeshId = "902942093"
        chr.RightLowerLeg.Transparency = "1"
        chr.RightUpperLeg.MeshId = "http://www.roblox.com/asset/?id=902942096"
        chr.RightUpperLeg.TextureID = "http://roblox.com/asset/?id=902843398"
        chr.RightFoot.MeshId = "902942089"
        chr.RightFoot.Transparency = "1"
  end
}

Tab:Button{
	Name = "Zombie Animation",
	Description = nil,
	Callback = function()
  while true do
local Animate = game.Players.LocalPlayer.Character.Animate
Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=616163682"
game.Players.LocalPlayer.Character.Humanoid.Jump = false
wait(1)
end
  end
}

Tab:Button{
	Name = "Cartoony Animation",
	Description = nil,
	Callback = function() 
  while true do
local Animate = game.Players.LocalPlayer.Character.Animate
Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=837009922"
game.Players.LocalPlayer.Character.Humanoid.Jump = false
wait(1)
end
  end
}

Tab:Button{
	Name = "Face Changer",
	Description = nil,
	Callback = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Fuz1on1/FL-Hub-Scripts/main/Face%20Changer"))()
  end
}

Tab:Button{
  Name = "Target GUI",
  Description = nil,
  Callback = function ()
loadstring(game:HttpGet("https://raw.githubusercontent.com/GS21Official/DH-VictimMenu-Script/main/Dh%20VictimMenu%3A%20Script"))()
end
}

Tab:Button{
  Name = "Fps boost",
  Description = nil,
  Callback = function ()
-- Made by RIP#6666
_G.Settings = {
    Players = {
        ["Ignore Me"] = true, -- Ignore your Character
        ["Ignore Others"] = true -- Ignore other Characters
    },
    Meshes = {
        Destroy = false, -- Destroy Meshes
        LowDetail = true -- Low detail meshes (NOT SURE IT DOES ANYTHING)
    },
    Images = {
        Invisible = true, -- Invisible Images
        LowDetail = false, -- Low detail images (NOT SURE IT DOES ANYTHING)
        Destroy = false, -- Destroy Images
    },
    ["No Particles"] = true, -- Disables all ParticleEmitter, Trail, Smoke, Fire and Sparkles
    ["No Camera Effects"] = true, -- Disables all PostEffect's (Camera/Lighting Effects)
    ["No Explosions"] = true, -- Makes Explosion's invisible
    ["No Clothes"] = true, -- Removes Clothing from the game
    ["Low Water Graphics"] = true, -- Removes Water Quality
    ["No Shadows"] = true, -- Remove Shadows
    ["Low Rendering"] = true, -- Lower Rendering
    ["Low Quality Parts"] = true -- Lower quality parts
}
loadstring(game:HttpGet("https://raw.githubusercontent.com/CasperFlyModz/discord.gg-rips/main/FPSBooster.lua"))()
end
}

Tab:Button{
	Name = "Chat Bypass",
	Description = nil,
	Callback = function()
  loadstring(game:HttpGet("https://the-shed.xyz/roblox/scripts/ChatBypass", true))()
  end
}