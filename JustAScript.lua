--[[ All Hubs/Script Are Come From Trustful Sources And If Some Code Aren't Working Please DM ikura0 In discord and report It Lr U Can request What to Add ]]--


--[[ Notification]]--

loadstring(game:HttpGet("https://raw.githubusercontent.com/JustAScripts/Notifier/main/Ping.lua"))()

--[[ Anti AFK ]]--

iku = coroutine.create(function() 
 VirtualUser = game:GetService("VirtualUser")
    game:GetService("Players").LocalPlayer.Idled:Connect(function()
        VirtualUser:CaptureController()
        VirtualUser:ClickButton2(Vector2.new())
    end)
end) 
coroutine.resume(iku)

--[[ Random function ]]--

function ClickDet()
    spawn(function()
        for _, descendant in ipairs(workspace:GetDescendants()) do
            if descendant:IsA("ClickDetector") then
                task.spawn(function()
                    fireclickdetector(descendant)
                end)
            end
        end
    end) 
end

function proxi()
spawn(function()
    for _, descendant in ipairs(workspace:GetDescendants()) do
        if descendant:IsA("ProximityPrompt") then
            fireproximityprompt(descendant)
        end
    end
end) 
end

function CframeGen()
   local pos = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
local o = string.format("%d, %d, %d", pos.X + 0.5, pos.Y + 0.5, pos.Z + 0.5)
getgenv().global = o
setclipboard("game.Players.LocalPlayer.Character:PivotTo(CFrame.new(Vector3.new(".. global .. ")))")
end

function HidePlayer()
    while true do
        for _, player in pairs(game.Players:GetPlayers()) do
            if player ~= game.Players.LocalPlayer and player.Character then
                player.Character:Destroy()
            end
        end
        wait(5)
    end
end

function DelPP()
    for _, v in next, workspace:GetDescendants() do
        if v:IsA("ProximityPrompt") then
            v.HoldDuration = 0
        end
    end
end

function Touchinterest()
    spawn(function()
        for _, descendant in ipairs(workspace:GetDescendants()) do
            if descendant:IsA("TouchTransmitter") and
                    game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character.PrimaryPart then
                task.spawn(function()
                    firetouchinterest(descendant:FindFirstAncestorWhichIsA("Part"),
                        game.Players.LocalPlayer.Character.PrimaryPart, 1)
                    task.wait()
                    firetouchinterest(descendant:FindFirstAncestorWhichIsA("Part"),
                        game.Players.LocalPlayer.Character.PrimaryPart, 0)
                end)
            end
        end
    end)
end

Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wizard"))()

function ThisActuallyCool()
    local currentTime = os.date("*t")
    local hour = currentTime.hour

    if hour >= 6 and hour < 12 then
        return "🌅"
    elseif hour >= 12 and hour < 15 then
        return "☀️🕛"
    elseif hour >= 15 and hour < 18 then
        return "🌞"
    elseif hour >= 18 or hour < 6 then
        return "🌙"
    else
        return "🌄"
    end
end

PhantomForcesWindow = Library:NewWindow("Just A Script " .. ThisActuallyCool())

WeLoveCat = PhantomForcesWindow:NewSection("Script")
--[[ Hub Script ]] --
WeLoveCat:CreateButton("Wyvern", function() loadstring(game:HttpGet("https://raw.githubusercontent.com/wyvernleaker/WYVERN/main/WYVERN.lua",true))()
  Sound(6150774030, 0.1)
Notify("Wyvern Loading.....",3)
  
end)

WeLoveCat:CreateButton("Infinite Yield", function() loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()
if V10 then
  Sound(6150774030, 0.1)
  task.wait(.1)
  Notify("Infinite Yield Loaded", 3)
else
  Notify("Infinite Yield Loaded", 3)
end ;
end) ;

WeLoveCat:CreateButton("RemoteSpy Mobile", function()   loadstring(game:HttpGet("https://raw.githubusercontent.com/REDzHUB/RS/main/SimpleSpyMobile"))()
if V10 then 
  Sound(6150774030, 0.1)
  task.wait(.1)
  Notify("SimpleSpy Loaded", 3)
else
  Notify("SimpleSpy Loaded", 3)
end ;
end) ;

WeLoveCat:CreateButton("Dark Dex New", function()   loadstring(game:HttpGet("https://raw.githubusercontent.com/Babyhamsta/RBLX_Scripts/main/Universal/BypassedDarkDexV3.lua", true))()
if V10 then
  Sound(6150774030, 0.1)
  task.wait(.1)
  Notify("Dex V3 Loaded", 3)
else
  Notify("Dex V3 Loaded", 3)
end ;
end) ;

WeLoveCat:CreateButton("V1 Player Hub", function()  loadstring(game:HttpGet("https://raw.githubusercontent.com/JustAP1ayer/PlayerHubOther/main/PlayerHubIngameUgcLimiteds.lua"))()
if V10 then
  Sound(6150774030, 0.1)
  task.wait(.1)
  Notify("V1 PlayerHub Loaded", 3)
else
  Notify("V1 PlayerHub Loaded", 3)
end ; 
end) ;

WeLoveCat:CreateButton("V2 Player Hub", function() loadstring(game:HttpGet(('https://raw.githubusercontent.com/JustAP1ayer/PlayerHubOther/main/PlayerHubIngameUgcLimitedsV2.lua')))()
  if V10 then
  Sound(6150774030, 0.1)
    task.wait(.1)
    Notify("V2 Player Hub Loaded", 3)
  else
    Notify("V2 Player Hub Loaded", 3)
  end ;
end) ;

WeLoveCat:CreateButton("Hydroxide Mobile", function() 
local owner = "Hosvile"
local branch = "revision"

function webImport(file)
    return loadstring(game:HttpGetAsync(("https://raw.githubusercontent.com/%s/MC-Hydroxide/%s/%s.lua"):format(owner, branch, file)), file .. '.lua')()
end

webImport("init") ;
webImport("ui/main") ;
  if V10 then
  Sound(6150774030, 0.1)
    task.wait(.1)
    Notify("Hydroxide Loaded", 3)
  else
    Notify("Hydroxide Loaded", 3)
  end ;
end) ;

--[[ 2nd Section UGC Script ]]--
local WeLoveCat2 = PhantomForcesWindow:NewSection("UGC")  

--[[ Redblue Lim Clicker ]]--

local ClickingSpeed = 0
local x, y, m = 55, 65.5, 1
local loopActive = false

WeLoveCat2:CreateToggle("Auto Buy", function(value)  
    loopActive = value
    spawn(function()
        while loopActive do 
            if game.CoreGui.PurchasePrompt.ProductPurchaseContainer.Animator:FindFirstChild("Prompt") and
                game.CoreGui.PurchasePrompt.ProductPurchaseContainer.Animator.Prompt:FindFirstChild("AlertContents") and
                game.CoreGui.PurchasePrompt.ProductPurchaseContainer.Animator.Prompt.AlertContents:FindFirstChild("Footer") and
                game.CoreGui.PurchasePrompt.ProductPurchaseContainer.Animator.Prompt.AlertContents.Footer:FindFirstChild("Buttons") and
                game.CoreGui.PurchasePrompt.ProductPurchaseContainer.Animator.Prompt.AlertContents.Footer.Buttons:FindFirstChild("2") and
                game.CoreGui.PurchasePrompt.ProductPurchaseContainer.Animator.Prompt.AlertContents.Footer.Buttons[2]:FindFirstChild("ButtonContent").ButtonMiddleContent and
                game.CoreGui.PurchasePrompt.ProductPurchaseContainer.Animator.Prompt.AlertContents.Footer.Buttons[2]:FindFirstChild("ButtonContent").ButtonMiddleContent:FindFirstChildOfClass("TextLabel") and tonumber(
                game.CoreGui.PurchasePrompt.ProductPurchaseContainer.Animator.Prompt.AlertContents.Footer.Buttons[2]:FindFirstChild("ButtonContent").ButtonMiddleContent:FindFirstChildOfClass("TextLabel").Text) <= tonumber(m) then

                local pos = game.CoreGui.PurchasePrompt.ProductPurchaseContainer.Animator.Prompt.AlertContents.Footer.Buttons[2].AbsolutePosition
                game:GetService("VirtualInputManager"):SendMouseButtonEvent(pos.X + tonumber(x), pos.Y + tonumber(y), 0, true, game, 1)
                wait()
                game:GetService("VirtualInputManager"):SendMouseButtonEvent(pos.X + tonumber(x), pos.Y + tonumber(y), 0, false, game, 1)
                wait(ClickingSpeed)
            else
                wait()
            end
        end
    end)
  if V10 then
    Sound(6150774030, 0.1)
    task.wait(.1)
    Notify("Auto Buy Limited\n" .. tostring(loopActive), 3)
  else
    Notify("Auto Buy Limited\n" .. tostring(loopActive), 3)
  end ;
end) ;

WeLoveCat2:CreateToggle("Auto Close Error", function(value)
    loopActive = value
    spawn(function()
        while loopActive do
            local pp = game.CoreGui.PurchasePrompt.ProductPurchaseContainer.Animator:FindFirstChild("Prompt")
            if pp and pp.AlertContents and pp.AlertContents.Footer and pp.AlertContents.Footer.Buttons and not pp.AlertContents.Footer.Buttons:FindFirstChild("2") then
                if pp.AlertContents.Footer.Buttons:FindFirstChild("1") then
                    local b1 = pp.AlertContents.Footer.Buttons[1].AbsolutePosition
                    game:GetService("VirtualInputManager"):SendMouseButtonEvent(b1.X + 55, b1.Y + 65.5, 0, true, game, 1)
                    wait()
                    game:GetService("VirtualInputManager"):SendMouseButtonEvent(b1.X + 55, b1.Y + 65.5, 0, false, game, 1)
                end
            end
            wait()
        end
    end)
 if V10 then
    Sound(6150774030, 0.1)
    task.wait(.1)
    Notify("Auto Close Error\n" .. tostring(loopActive), 3)
 else
   Notify("Auto Close Error\n" .. tostring(loopActive), 3)
 end ;
end) ;

WeLoveCat2:CreateButton("Cframe Teleport", function() 
    CframeGen()
  if V10 then
    Sound(6150774030, 0.1)
    task.wait(.1)
    Notify("Copied At\n" .. global, 3)
  else
    Notify("Copied At\n" .. global, 3)
  end ;
end) ;


WeLoveCat2:CreateButton("Hide Player Loop", function() 
    HidePlayer()
    if V10 then
    Sound(6150774030, 0.1)
      task.wait(.1)
      Notify("All Player Are now Invisible", 3)
    else
      Notify("All Player Are now Invisible", 3)
    end ;
end) ;

WeLoveCat2:CreateButton("Delete Proximity CD", function() 
    DelPP()
  if V10 then
    Sound(6150774030, 0.1)
    Notify("Proximity Deleted", 3)
  else
    Notify("Proximity Deleted", 3)
  end ;
end) ;

WeLoveCat2:CreateButton("Adonis Checker", function() 
loadstring(game:HttpGet("https://raw.githubusercontent.com/JustAScripts/Favorable/main/AdonisChecker.Lua",true))()
end)

WeLoveCat2:CreateButton("Adonis Bypassed", function()  loadstring(game:HttpGet("https://raw.githubusercontent.com/Pixeluted/adoniscries/main/Source.lua", true))() --[[ AdonisCries Is Famous Adonis Bypasser and The Only working The Catch is it's Ofbuscate But Ton Player used it and nothing Happen or any Bad ]]-- 
  if V10 then
    Sound(6150774030, 0.1)
    task.wait(.1)
    Notify("Bypassed!", 3)
  else
    Notify("Bypassed!", 3)
  end ;
end) ;

--[[ Firing Function 3rd Section ]]--

WeLoveCat3 = PhantomForcesWindow:NewSection("Firing")

WeLoveCat3:CreateButton("Touchinterests", function()
    Touchinterest()
  if V10 then
    Sound(6150774030, 0.1)
    task.wait(.1)
    Notify("Touchinterest Fired", 3)
  else
    Notify("Touchinterest Fired", 3)
  end ;
end) ;

WeLoveCat3:CreateButton("Clickedetector", function()
    ClickDet()
  if V10 then
    Sound(6150774030, 0.1)
    task.wait(.1)
    Notify("Clickedetector Fired", 3)
  else
    Notify("Clickedetector Fired", 3)
  end ;
end) ;

WeLoveCat3:CreateButton("ProximityPrompt", function()
    proxi()
  if V10 then
    Sound(6150774030, 0.1)
    task.wait(.1)
    Notify("ProximityPromt Fired", 3)
  else
    Notift("ProximityPrompt Fired", 3)
  end ;
end) ;

--[[ 4th Section Credit ]]--

cat = PhantomForcesWindow:NewSection("Discord")

cat:CreateButton("Support By Joining", function()
    setclipboard("https://discord.com/invite/7t4j478wG6")
    Sound(6150774030, 0.1)
end) ;

cat:CreateButton("Destroy Gui", function()
    game.CoreGui.WizardLibrary:Destroy()
    Notify("Library Destroy", 3)
    Sound(6150774030, 0.1)
end) ;

cat:CreateToggle("Enabled Sound", function(value)
    getgenv().V10 = value 
end) ;

Notify(" Just A Script ", 3)
