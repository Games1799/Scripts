-- By @Games1799 or @Roblox_free_ugc_2025 in Telegram
-- https://t.me/Games1799
-- https://t.me/Roblox_free_ugc_2025

local players = game:GetService("Players")
local player = players.LocalPlayer
local CoreGui = game:GetService("CoreGui")
local StarterGui = game:GetService("StarterGui")
local RunService = game:GetService("RunService")
local MarketplaceService = game:GetService("MarketplaceService")
local hi = false
local hi1 = false

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
    while task.wait(0.1) do
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

local Window = Library:NewWindow("Just script v2.0")

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

Section:CreateButton("Ремоут браузер v3 (бета)", function()
loadstring(Game:HttpGet("https://raw.githubusercontent.com/Games1799/Scripts/refs/heads/main/RemoteBrowserV3_Beta"))()
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
local pos
local char = player.Character
local hum = char and player.Character:FindFirstChild("HumanoidRootPart")
if hum then
pos = hum.position
local copy  = string.format("%f, %f, %f", pos.X, pos.Y, pos.Z)
setclipboard(tostring(copy))
else
local camera = workspace.Camera
if not camera then return end
pos = camera.Focus.Position
local copy  = string.format("%f, %f, %f", pos.X, pos.Y - 1.5, pos.Z)
setclipboard(tostring(copy))
end
end)

Section:CreateButton("Скопировать Teleport", function()
local pos
local char = player.Character
local hum = char and player.Character:FindFirstChild("HumanoidRootPart")
if char and hum then
pos = hum.position
local copy = string.format("game.Players.LocalPlayer.Character:PivotTo(CFrame.new(Vector3.new(%f, %f, %f)))", pos.X, pos.Y, pos.Z)
setclipboard(tostring(copy))
else
local camera = workspace.Camera
if not camera then return end
pos = camera.Focus.Position
local copy = string.format("game.Players.LocalPlayer.Character:PivotTo(CFrame.new(Vector3.new(%f, %f, %f)))", pos.X, pos.Y - 1.5, pos.Z)
setclipboard(tostring(copy))
end
end)

Section:CreateButton("Скопировать TweenService", function()
local pos
local char = player.Character
local hum = char and player.Character:FindFirstChild("HumanoidRootPart")
if char and hum then
pos = hum.position
local copy = string.format([[local tweenInfo = TweenInfo.new(2)
local goal = {CFrame = CFrame.new(%f, %f, %f)}
local tween = game:GetService("TweenService"):Create(game.Players.LocalPlayer.Character.HumanoidRootPart, tweenInfo, goal)
tween:Play()]], pos.X, pos.Y, pos.Z)
setclipboard(tostring(copy))
else
local camera = workspace.Camera
if not camera then return end
pos = camera.Focus.Position
local copy = string.format([[local tweenInfo = TweenInfo.new(2)
local goal = {CFrame = CFrame.new(%f, %f, %f)}
local tween = game:GetService("TweenService"):Create(game.Players.LocalPlayer.Character.HumanoidRootPart, tweenInfo, goal)
tween:Play()]], pos.X, pos.Y - 1.5, pos.Z)
setclipboard(tostring(copy))
end
end)

Section:CreateButton("Скопировать MoveTo", function()
local pos
local char = player.Character
local hum = char and player.Character:FindFirstChild("HumanoidRootPart")
if char and hum then
pos = hum.position
local copy = string.format([[local hrp = game.Players.LocalPlayer.Character.HumanoidRootPart
local position = "%f, %f, %f"
local humanoid = game.Players.LocalPlayer.Character.Humanoid
humanoid.WalkSpeed = 16
humanoid.JumpPower = 19
humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping, true)
humanoid:MoveTo(position)]], pos.X, pos.Y, pos.Z)
setclipboard(tostring(copy))
else
local camera = workspace.Camera
if not camera then return end
pos = camera.Focus.Position
local copy = string.format([[local hrp = game.Players.LocalPlayer.Character.HumanoidRootPart
local position = "%f, %f, %f"
local humanoid = game.Players.LocalPlayer.Character.Humanoid
humanoid.WalkSpeed = 16
humanoid.JumpPower = 19
humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping, true)
humanoid:MoveTo(position)]], pos.X, pos.Y - 1.5, pos.Z)
setclipboard(tostring(copy))
end
end)

Section:CreateButton("Скопировать Lerp", function()
local pos
local char = player.Character
local hum = char and player.Character:FindFirstChild("HumanoidRootPart")
if char and hum then
pos = hum.position
local copy  = string.format([[local hrp = game.Players.LocalPlayer.Character.HumanoidRootPart
local goal = CFrame.new(%f, %f, %f)
for i = 0, 1, 0.05 do
    hrp.CFrame = hrp.CFrame:Lerp(goal, i)
    task.wait()
end]], pos.X, pos.Y, pos.Z)
setclipboard(tostring(copy))
else
local camera = workspace.Camera
if not camera then return end
pos = camera.Focus.Position
local copy  = string.format([[local hrp = game.Players.LocalPlayer.Character.HumanoidRootPart
local goal = CFrame.new(%f, %f, %f)
for i = 0, 1, 0.05 do
    hrp.CFrame = hrp.CFrame:Lerp(goal, i)
    task.wait()
end]], pos.X, pos.Y - 1.5, pos.Z)
setclipboard(tostring(copy))
end
end)

local Section = Window:NewSection("Инструменты")

Section:CreateToggle("Скрыть игроков", function(state)
    if state then
        _G.HideAll = true
    else
        _G.HideAll = false
    end
end)

Section:CreateTextbox("SignalPurchaseFinished (id)", function(id)
local Id = tonumber((id):match("%d+"))
local successPass = pcall(MarketplaceService.GetProductInfo,MarketplaceService, Id,Enum.InfoType.GamePass)
if successPass then
pcall(function()
MarketplaceService:SignalPromptGamePassPurchaseFinished(player, Id, true)
task.wait(0.1)
MarketplaceService:SignalPromptGamePassPurchaseFinished(player.UserId, Id, true) 
task.wait(0.1)
MarketplaceService:SignalPromptGamePassPurchaseFinished(player, Id, false)
task.wait(0.1)
MarketplaceService:SignalPromptGamePassPurchaseFinished(player.UserId, Id, false) 
task.wait(0.1)
MarketplaceService:SignalPromptPurchaseCancelled(player, Id)
task.wait(0.1)
MarketplaceService:SignalPromptPurchaseCancelled(player.UserId, Id) 
task.wait(0.1)
MarketplaceService:SignalPromptPurchaseCompleted(player, Id)
task.wait(0.1)
MarketplaceService:SignalPromptPurchaseCompleted(player.UserId, Id) 
task.wait(0.1)
MarketplaceService:SignalPromptPurchaseFailed(player, Id)
task.wait(0.1)
MarketplaceService:SignalPromptPurchaseFailed(player.UserId, Id)
end)
return
end
local successDev = pcall(MarketplaceService.GetProductInfo,MarketplaceService, Id,Enum.InfoType.Product)
if successDev then
pcall(function()
MarketplaceService:SignalPromptProductPurchaseFinished(player.UserId, Id,true)
task.wait(0.1)
MarketplaceService:SignalPromptProductPurchaseFinished(player, Id, true) 
task.wait(0.1)
MarketplaceService:SignalPromptProductPurchaseFinished(player.UserId, Id, false)
task.wait(0.1)
MarketplaceService:SignalPromptProductPurchaseFinished(player, Id, false) 
task.wait(0.1)
MarketplaceService:SignalPromptPurchaseCancelled(player, Id)
task.wait(0.1)
MarketplaceService:SignalPromptPurchaseCancelled(player.UserId, Id)         
task.wait(0.1)
MarketplaceService:SignalPromptPurchaseCompleted(player, Id)
task.wait(0.1)
MarketplaceService:SignalPromptPurchaseCompleted(player.UserId, Id) 
task.wait(0.1)
MarketplaceService:SignalPromptPurchaseFailed(player, Id)
task.wait(0.1)
MarketplaceService:SignalPromptPurchaseFailed(player.UserId, Id)
end)
return
end
local successBundle = pcall(MarketplaceService.GetProductInfo,MarketplaceService, Id,Enum.InfoType.Bundle)
if successBundle then
pcall(function()
MarketplaceService:SignalPromptBundlePurchaseFinished(player, Id, true)
task.wait(0.1)
MarketplaceService:SignalPromptBundlePurchaseFinished(player.UserId, Id, true)
task.wait(0.1)
MarketplaceService:SignalPromptBundlePurchaseFinished(player, Id, false)
task.wait(0.1)
MarketplaceService:SignalPromptBundlePurchaseFinished(player.UserId, Id, false)
task.wait(0.1)
MarketplaceService:SignalPromptPurchaseCancelled(player, Id)
task.wait(0.1)
MarketplaceService:SignalPromptPurchaseCancelled(player.UserId, Id) 
task.wait(0.1)
MarketplaceService:SignalPromptPurchaseCompleted(player, Id)
task.wait(0.1)
MarketplaceService:SignalPromptPurchaseCompleted(player.UserId, Id) 
task.wait(0.1)
MarketplaceService:SignalPromptPurchaseFailed(player, Id)
task.wait(0.1)
MarketplaceService:SignalPromptPurchaseFailed(player.UserId, Id)
end)
return
end
local successUGC = pcall(MarketplaceService.GetProductInfo, MarketplaceService, Id, Enum.InfoType.Asset)
if successUGC then
pcall(function()
MarketplaceService:SignalPromptPurchaseFinished(player, Id, true)
task.wait(0.1)   
MarketplaceService:SignalPromptPurchaseFinished(player.UserId, Id, true) 
task.wait(0.1)       
MarketplaceService:SignalPromptPurchaseFinished(player, Id, false)
task.wait(0.1)   
MarketplaceService:SignalPromptPurchaseFinished(player.UserId, Id, false)
task.wait(0.1)      
MarketplaceService:SignalPromptPurchaseCancelled(player, Id)
task.wait(0.1)
MarketplaceService:SignalPromptPurchaseCancelled(player.UserId, Id)
task.wait(0.1)   
MarketplaceService:SignalPromptPurchaseCompleted(player, Id)
task.wait(0.1)
MarketplaceService:SignalPromptPurchaseCompleted(player.UserId, Id) 
task.wait(0.1)       
MarketplaceService:SignalPromptPurchaseFailed(player, Id)
task.wait(0.1)
MarketplaceService:SignalPromptPurchaseFailed(player.UserId, Id)
end)
return
end
StarterGui:SetCore("SendNotification", {
Title = "Ошибка!",
Text = "Ошибка, этот id не существует!",
Button1 = "Ок",
Duration = 5,})
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
    local connection = game:GetService("RunService").RenderStepped:Connect(function()
        local players1 = game.Players:GetPlayers()
        for i = 2, #players1 do
            local target = players1[i].Character
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
    local hum = game.Players.LocalPlayer.Character.HumanoidRootPart
    if not hum then return end
    if hum then
    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("TouchTransmitter") then
            local part = obj.Parent
            if part then
                firetouchinterest(part, hum, 1)
                task.wait()
                firetouchinterest(part, hum, 0)
                part.CFrame = hum.CFrame
            end
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

for i, v in pairs(game:GetDescendants()) do
    if v.Name == "__FUNCTION" then
        StarterGui:SetCore("SendNotification", { 
        Title = "Найден адонис!",
        Text = "Проверьте !Buyitem и !Buyasset",
        Button1 = "Ок",
        Duration = 5,
    })
        hi1 = true
        break
    end
end

if not _G.Prompt_ICON1 then
    _G.Prompt_ICON1 = true

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
