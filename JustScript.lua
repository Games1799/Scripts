-- By @Games1799 or @Roblox_free_ugc_2025 in Telegram
-- https://t.me/Games1799
-- https://t.me/Roblox_free_ugc_2025

local players = game:GetService("Players")
local player = players.LocalPlayer or players:GetPropertyChangedSignal("LocalPlayer"):Wait()
local CoreGui = game:GetService("CoreGui")
local StarterGui = game:GetService("StarterGui")
local RunService = game:GetService("RunService")
local hi = false

local connection
connection = RunService.RenderStepped:Connect(function()
    local wizardLibrary = game:GetService("CoreGui"):FindFirstChild("WizardLibrary")
    if wizardLibrary then
        wizardLibrary.Parent = player.PlayerGui
        wizardLibrary.Parent = gethui()
        connection:Disconnect()
    end
end)

_G.TP = false
_G.HideAll = false

local mouse = player:GetMouse()
mouse.Button1Down:Connect(function()
if not _G.TP then return end
if not player then return end
if not player.Character then return end 
if not mouse.Target then return end
player.Character:PivotTo(CFrame.new(mouse.Hit.Position + Vector3.new(0, 3, 0)))
end)

local HidePlayers = {}

spawn(function()
    while task.wait() do
        for _, v in pairs(game.Players:GetPlayers()) do
            if v ~= player and v.Character then
                if _G.HideAll then
                    if not HidePlayers[v] then
                        HidePlayers[v] = v.Character.Parent
                    end
                    v.Character.Parent = nil
                else
                    if HidePlayers[v] and v.Character.Parent == nil then
                        v.Character.Parent = HidePlayers[v]
                    end
                end
            end
        end
    end
end)

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wizard"))()

local Window = Library:NewWindow("Just script v1.7")

local Section = Window:NewSection("Полезные скрипты")

Section:CreateButton("Инфернум", function()
loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()
end)

Section:CreateButton("Декс", function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/infyiff/backup/main/dex.lua"))()
end)

Section:CreateButton("Вуверн", function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/ckw69/Wyborn/main/wyborn",true))()
end)

Section:CreateButton("Ремот спай", function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/infyiff/backup/main/SimpleSpyV3/main.lua"))()
end)

Section:CreateButton("Ремоут браузер", function()
loadstring(Game:HttpGet("https://raw.githubusercontent.com/Games1799/Scripts/refs/heads/main/RemoteBrowser"))()
end)

Section:CreateButton("Dev Products Purchaser", function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/ckw69/Wyborn/refs/heads/main/Dev%20Product%20Purchase"))()
end)

Section:CreateButton("Адонис байпас", function()
for i, v in pairs(game:GetDescendants()) do
    if v.Name == "__FUNCTION" then
        loadstring(game:HttpGet('https://raw.githubusercontent.com/Pixeluted/adoniscries/main/Source.lua'))()
        hi = true
        break
    end
end

if not hi then
    StarterGui:SetCore("SendNotification", { 
        Title = "Не найдено",
        Text = "Адонис не найден",
        Duration = 5,
    })
        end
end)

Section:CreateButton("???", function()
return nil
end)

local Section = Window:NewSection("Перемещение")

Section:CreateToggle("Телепорт мышкой", function(state)
    if state then
        _G.TP = true
    else
        _G.TP = false
    end
end)

Section:CreateButton("Скопировать координаты", function()
local character = player.Character
if not character then return end 
local hum = player.Character:FindFirstChild("HumanoidRootPart")
if not hum then return end
local pos = hum.position
local copy  = string.format("%f, %f, %f", pos.X, pos.Y, pos.Z)
setclipboard(tostring(copy)) 
end)

Section:CreateButton("Скопировать Teleport", function()
local character = player.Character
if not character then return end 
local hum = player.Character:FindFirstChild("HumanoidRootPart")
if not hum then return end
local pos = hum.position
local copy = string.format("game.Players.LocalPlayer.Character:PivotTo(CFrame.new(Vector3.new(%f, %f, %f)))", pos.X, pos.Y, pos.Z)
setclipboard(tostring(copy)) 
end)

Section:CreateButton("Скопировать TweenService", function()
local character = player.Character
if not character then return end 
local hum = player.Character:FindFirstChild("HumanoidRootPart")
if not hum then return end
local pos = hum.position
local copy = string.format([[local tweenInfo = TweenInfo.new(2)
local goal = {CFrame = CFrame.new(%f, %f, %f)}
local tween = game:GetService("TweenService"):Create(game.Players.LocalPlayer.Character.HumanoidRootPart, tweenInfo, goal)
tween:Play()]], pos.X, pos.Y, pos.Z)
setclipboard(tostring(copy)) 
end)

Section:CreateButton("Скопировать MoveTo", function()
local character = player.Character
if not character then return end 
local hum = player.Character:FindFirstChild("HumanoidRootPart")
if not hum then return end
local pos = hum.position
local copy = string.format([[local hrp = game.Players.LocalPlayer.Character.HumanoidRootPart
local position = "%f, %f, %f"
local humanoid = game.Players.LocalPlayer.Character.Humanoid
humanoid.WalkSpeed = 16
humanoid.JumpPower = 19
humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping, true)
humanoid:MoveTo(position)]], pos.X, pos.Y, pos.Z)
setclipboard(tostring(copy)) 
end)

Section:CreateButton("Скопировать Lerp", function()
local character = player.Character
if not character then return end 
local hum = player.Character:FindFirstChild("HumanoidRootPart")
if not hum then return end
local pos = hum.position
local copy  = string.format([[local hrp = game.Players.LocalPlayer.Character.HumanoidRootPart
local goal = CFrame.new(%f, %f, %f)
for i = 0, 1, 0.05 do
    hrp.CFrame = hrp.CFrame:Lerp(goal, i)
    task.wait()
end]], pos.X, pos.Y, pos.Z)
setclipboard(tostring(copy)) 
end)

local Section = Window:NewSection("Инструменты")

Section:CreateToggle("Скрыть игроков", function(state)
    if state then
        _G.HideAll = true
    else
        _G.HideAll = false
    end
end)

Section:CreateButton("FireProximityPrompt", function()
for _, v in ipairs(workspace:GetDescendants()) do
    if v:IsA("ProximityPrompt") then
        fireproximityprompt(v)
    end
end
end)

Section:CreateButton("HoldDuration 0", function()
for _, v in next, workspace:GetDescendants() do
if v:IsA("ProximityPrompt") then
v.HoldDuration = 0
end
end
end)

Section:CreateButton("FireAllClickDetectors", function()
for _, v in ipairs(workspace:GetDescendants()) do
    if v:IsA("ClickDetector") then
        fireclickdetector(v)
    end
end
end)

Section:CreateButton("KillAura", function()
    local range = 9999999999999
    local player = game:GetService("Players").LocalPlayer

    local connection
    connection = game:GetService("RunService").RenderStepped:Connect(function()
        local players = game.Players:GetPlayers()
        for i = 2, #players do
            local target = players[i].Character
            if target
                and target:FindFirstChild("Humanoid")
                and target.Humanoid.Health > 0
                and target:FindFirstChild("HumanoidRootPart")
                and player:DistanceFromCharacter(target.HumanoidRootPart.Position) <= range
            then
                local tool = player.Character and player.Character:FindFirstChildOfClass("Tool")
                if tool and tool:FindFirstChild("Handle") then
                    tool:Activate()
                    for _, part in ipairs(target:GetChildren()) do
                        if part:IsA("BasePart") then
                            firetouchinterest(tool.Handle, part, 0)
                            firetouchinterest(tool.Handle, part, 1)
                        end
                    end
                end
            end
        end
    end)
end)

Section:CreateButton("FireAllTouchinterest", function()
local player = speaker or game:GetService("Players").LocalPlayer
if not player or not player.Character then return end

local root = player.Character:FindFirstChild("HumanoidRootPart") or player.Character:FindFirstChildWhichIsA("BasePart")
if not root then return end

local function touch(x)
    if not x then return end
    x = x:FindFirstAncestorWhichIsA("Part")
    if not x then return end
    
    if firetouchinterest then
        task.spawn(function()
            firetouchinterest(x, root, 1)
            task.wait()
            firetouchinterest(x, root, 0)
        end)
    end
    x.CFrame = root.CFrame
end

if args and args[1] then
    local name = tostring(args[1])
    for _, descendant in ipairs(workspace:GetDescendants()) do
        if descendant:IsA("TouchTransmitter") then
            if (descendant.Name == name) or (descendant.Parent and descendant.Parent.Name == name) then
                touch(descendant)
            end
        end
    end
else
    for _, descendant in ipairs(workspace:GetDescendants()) do
        if descendant:IsA("TouchTransmitter") then
            touch(descendant)
        end
    end
        end
end)

local Window = Library:NewWindow("Создатель скрипта")

local Section = Window:NewSection("Телеграм")

Section:CreateButton("Телеграм канал", function()local copy  = "https://t.me/roblox_free_ugc_2025"
setclipboard(tostring(copy))
end)

Section:CreateButton("Юзер в тг", function()local copy  = "@Games1799"
setclipboard(tostring(copy))
end)

Section:CreateButton("Скрыть это окно", function()
game:GetService("CoreGui").WizardLibrary.Container["\208\161\208\190\208\183\208\180\208\176\209\130\208\181\208\187\209\140\209\129\208\186\209\128\208\184\208\191\209\130\208\176Window"]:Destroy()
end)

if not _G.Prompt then
    _G.Prompt = true

    while task.wait(1) do
        local purchasePrompt = CoreGui:FindFirstChild("PurchasePromptApp")
        if purchasePrompt then
            local price, image, priceText, imageSrc

            local productPurchase = purchasePrompt:FindFirstChild("ProductPurchaseContainer")
            if productPurchase and productPurchase.Animator:FindFirstChild("ProductPurchaseModal") then
                local alert = productPurchase.Animator.ProductPurchaseModal:FindFirstChild("AlertContents")
                if alert then
                    price = alert.Footer.Buttons["1"].ButtonContent.ButtonMiddleContent.Text
                    image = alert.MiddleContent.Content.ItemIcon
                    priceText = price.Text
                    imageSrc = image.Image
                end
            end

            if not priceText then
                local robuxUpsell = purchasePrompt:FindFirstChild("RobuxUpsellContainer")
                if robuxUpsell and robuxUpsell:FindFirstChild("Prompt") then
                    local children = robuxUpsell.Prompt.Children:GetChildren()
                    if children[8] and children[8]:FindFirstChild("1") then
                        local upsell = children[8]["1"].RobuxUpsellModal.AlertContents.MiddleContent.Content.ProductDetails
                        price = upsell.ItemDetailsFrame.ItemDetails.ItemCost
                        image = upsell.ItemIcon
                        priceText = price.Text
                        imageSrc = image.Image
                    end
                end
            end

            if priceText and imageSrc then
                StarterGui:SetCore("SendNotification", {
                    Title = "Появилось окно покупки!",
                    Text = "Стоимость — "..priceText,
                    Icon = imageSrc,
                    Duration = 5,
                })

                repeat task.wait(1)
                until not (price and price.Parent and image and image.Parent)
            end
        end
    end
end
