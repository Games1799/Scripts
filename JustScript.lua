-- By @Games1799 or @Roblox_free_ugc_2025 in Telegram
-- https://t.me/Games1799
-- https://t.me/Roblox_free_ugc_2026

local cloneref = cloneref or clone_ref or clonereference or clone_reference or (cache and cache.cloneref) or function(a) -- Fake cloneref 
   return a
end

local setclipboard = setclipboard or toclipboard or setrbxclipboard or set_clipboard or to_clipboard or set_rbx_clipboard or (Clipboard and Clipboard.set) or writeclipboard or write_clipboard or nil
local players = cloneref(game:GetService("Players"))
local CoreGui = cloneref(game:GetService("CoreGui"))
local StarterGui = cloneref(game:GetService("StarterGui"))
local RunService = cloneref(game:GetService("RunService"))
local MarketplaceService = cloneref(game:GetService("MarketplaceService"))
local player = players.LocalPlayer

pcall(function()
   if type(getgenv) ~= "function" then
      function getgenv()
         return _G
      end
   end
end)

getgenv().SignalDelay = 0
getgenv().TP7 = false
getgenv().HideAll = false
getgenv().SignalTrue7 = false

local cache = {}
local hi = false
local hi1 = false
local Id, productInfo

local mouse = player:GetMouse()
mouse.Button1Down:Connect(function()
   if not getgenv().TP7 then return end
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
if getgenv().HideAll then
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

local Library = nil
local Wizard = true
pcall(function()
   Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wizard"))()
end)

if not Library then
   pcall(function()
      Wizard = false
      Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Games1799/Scripts/refs/heads/main/Libary/Wizard.lua"))()
   end)
end

local Window = Library:NewWindow("Just script v2.3 🍁")

local Section = Window:NewSection("Полезные скрипты")

Section:CreateButton("Инфернум", function()
   loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()
end)

Section:CreateButton("Декс", function()
   loadstring(game:HttpGet("https://raw.githubusercontent.com/infyiff/backup/main/dex.lua"))()
end)

Section:CreateButton("Вуверн", function()
   loadstring(Game:HttpGet("https://raw.githubusercontent.com/Games1799/Scripts/refs/heads/main/Wevorn.lua"))()
end)

Section:CreateButton("Ремот спай", function()
   loadstring(game:HttpGet("https://raw.githubusercontent.com/infyiff/backup/main/SimpleSpyV3/main.lua"))()
end)

Section:CreateButton("Ремоут браузер", function()
   loadstring(game:HttpGet("https://raw.githubusercontent.com/Games1799/Scripts/refs/heads/main/RemoteBrowser"))()
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
      getgenv().TP7 = true
   else
      getgenv().TP7 = false
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
      getgenv().HideAll = true
   else
      getgenv().HideAll = false
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

local Section = Window:NewSection("Угс лимитки")
getgenv().Wevorn_AutoClickPurchase_Just = false
getgenv().Wevorn_AutoClickCloseError_Just = false

Section:CreateToggle("Авто кликер покупки", function(state)
   local VirtualInputManager = cloneref(game:GetService("VirtualInputManager"))
   local CoreGui = cloneref(game:GetService("CoreGui"))
   local GuiService = cloneref(game:GetService("GuiService"))
   getgenv().Wevorn_AutoClickPurchase_Just = state
   while getgenv().Wevorn_AutoClickPurchase_Just and task.wait(0.05) do
      task.spawn(function()
         pcall(function()
            for _, v in ipairs(CoreGui.FoundationOverlay:GetDescendants()) do
               if string.find(v.Name, "Buy") and v.Parent.Name == "1" then
                  VirtualInputManager:SendMouseButtonEvent(v.AbsolutePosition.X + v.AbsoluteSize.X * (0.5 - v.AnchorPoint.X), v.AbsolutePosition.Y + v.AbsoluteSize.Y * (0.5 - v.AnchorPoint.Y) + GuiService:GetGuiInset().Y, 0, true, game, 1)
                  VirtualInputManager:SendMouseButtonEvent(v.AbsolutePosition.X + v.AbsoluteSize.X * (0.5 - v.AnchorPoint.X), v.AbsolutePosition.Y + v.AbsoluteSize.Y * (0.5 - v.AnchorPoint.Y) + GuiService:GetGuiInset().Y, 0, false, game, 1)
               end
            end 
         end)
      end)
   end
end)

Section:CreateToggle("Авто закрыть ошибку", function(state)
   local VirtualInputManager = cloneref(game:GetService("VirtualInputManager"))
   local CoreGui = cloneref(game:GetService("CoreGui"))
   local GuiService = cloneref(game:GetService("GuiService"))
   getgenv().Wevorn_AutoClickCloseError_Just = state
   while getgenv().Wevorn_AutoClickCloseError_Just and task.wait(0.05) do
      task.spawn(function()
         pcall(function()
            for _, v in ipairs(CoreGui.FoundationOverlay:GetDescendants()) do
               if v.Name == "1" and not v.FindFirstChild(v, "BuyButton") then
                  VirtualInputManager:SendMouseButtonEvent(v.AbsolutePosition.X + v.AbsoluteSize.X * (0.5 - v.AnchorPoint.X), v.AbsolutePosition.Y + v.AbsoluteSize.Y * (0.5 - v.AnchorPoint.Y) + GuiService:GetGuiInset().Y, 0, true, game, 1)
                  VirtualInputManager:SendMouseButtonEvent(v.AbsolutePosition.X + v.AbsoluteSize.X * (0.5 - v.AnchorPoint.X), v.AbsolutePosition.Y + v.AbsoluteSize.Y * (0.5 - v.AnchorPoint.Y) + GuiService:GetGuiInset().Y, 0, false, game, 1)
               end
            end 
         end)
      end)
   end
end)

local Section = Window:NewSection("Сигналы покупки")

Section:CreateToggle("Сигнал true", function(state7)
getgenv().SignalTrue7 = state7
end)

getgenv().hi2 = {toggle = false}

Section:CreateToggle("Спам сигналами", function(state)
hi2.toggle = state
task.spawn(function()
while hi2.toggle do
task.wait(getgenv().SignalDelay)
if Id then
pcall(function()
local signal = getgenv().SignalTrue7
local productInfo = cache[Id]
if productInfo then
if productInfo.type == "GamePass" then
MarketplaceService:SignalPromptGamePassPurchaseFinished(player, Id, signal)
elseif productInfo.type == "Product" then
MarketplaceService:SignalPromptProductPurchaseFinished(player.UserId, Id, signal)
elseif productInfo.type == "Bundle" then
MarketplaceService:SignalPromptBundlePurchaseFinished(player, Id, signal)
elseif productInfo.type == "Asset" then
MarketplaceService:SignalPromptPurchaseFinished(player, Id, signal)
end
end
end)
end
end
end)
end)

Section:CreateTextbox("Введите id", function(id)
Id = (id)
if not Id then return end
local productInfo = cache[Id]
if not productInfo then
local successPass, passInfo = pcall(MarketplaceService.GetProductInfo, MarketplaceService, Id, Enum.InfoType.GamePass)
if successPass then
productInfo = {type = "GamePass", info = passInfo}
else
local successDev, devInfo = pcall(MarketplaceService.GetProductInfo, MarketplaceService, Id, Enum.InfoType.Product)
if successDev then
productInfo = {type = "Product", info = devInfo}
else
local successBundle, bundleInfo = pcall(MarketplaceService.GetProductInfo, MarketplaceService, Id, Enum.InfoType.Bundle)
if successBundle then
productInfo = {type = "Bundle", info = bundleInfo}
else
local successUGC, ugcInfo = pcall(MarketplaceService.GetProductInfo, MarketplaceService, Id, Enum.InfoType.Asset)
if successUGC then
productInfo = {type = "Asset", info = ugcInfo}
end
end
end
end
if productInfo then
cache[Id] = productInfo
else
StarterGui:SetCore("SendNotification", {
Title = "Ошибка!",
Text = "Ошибка, этот id не существует!",
Button1 = "Ок",
Duration = 5,
})
return
end
_G.productInfo = productInfo
end
end)

Section:CreateTextbox("Интервал сигналов", function(time)
getgenv().SignalDelay = tonumber((time)) or 0
end)

Section:CreateButton("Использовать сигнал", function()
    pcall(function()
        local signal = getgenv().SignalTrue7
        local idUsed = tonumber(Id)
        if not idUsed then return end
        local info = cache[idUsed] or _G.productInfo
        if not info or not info.type then return end
        if info.type == "GamePass" then
            MarketplaceService:SignalPromptGamePassPurchaseFinished(player, idUsed, signal)
        elseif info.type == "Product" then
            MarketplaceService:SignalPromptProductPurchaseFinished(player.UserId, idUsed, signal)
        elseif info.type == "Bundle" then
            MarketplaceService:SignalPromptBundlePurchaseFinished(player, idUsed, signal)
        elseif info.type == "Asset" then
            MarketplaceService:SignalPromptPurchaseFinished(player, idUsed, signal)
        end
    end)
end)

if Wizard then
   local Window = Library:NewWindow("Создатель скрипта")
   local Section = Window:NewSection("Телеграм")

   Section:CreateButton("Телеграм канал", function()local copy  = "https://t.me/roblox_free_ugc_2026"
      setclipboard(tostring(copy))
   end)

   Section:CreateButton("Юзер в тг", function()local copy  = "https://t.me/Games1799"
      setclipboard(tostring(copy))
   end)

   Section:CreateButton("Скрыть это окно", function()
      game:GetService("CoreGui").WizardLibrary.Container["\208\161\208\190\208\183\208\180\208\176\209\130\208\181\208\187\209\140\209\129\208\186\209\128\208\184\208\191\209\130\208\176Window"]:Destroy()
   end)
end

for _, v in pairs(game:GetDescendants()) do
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
