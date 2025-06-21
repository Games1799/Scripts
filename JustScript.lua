-- By @Games1799 or @Roblox_free_ugc_2025 in Telegram
-- https://t.me/Games1799
-- https://t.me/Roblox_free_ugc_2025

local PlayerGui = gethui and gethui() or player:WaitForChild("PlayerGui")
local StarterGui = gethui and gethui() or player:WaitForChild("StarterGui")
local CoreGui = gethui and gethui() or player:WaitForChild("CoreGui")
local ScreenGui = gethui and gethui() or player:WaitForChild("ScreenGui")

_G.TP = false
_G.HideAll = false

local player = game.Players.LocalPlayer
local humanoid = player.Character:FindFirstChild("Humanoid")
local mouse = player:GetMouse()
mouse.Button1Down:Connect(function()
if not _G.TP then return end
if not player then return end
if humanoid.Sit then return end
if not player.Character then return end 
if not mouse.Target then return end
player.Character:PivotTo(CFrame.new(mouse.Hit.Position + Vector3.new(0, 3, 0)))
end)

spawn(function()
    while task.wait() do
        if _G.HideAll then
            for _, v in pairs(game.Players:GetPlayers()) do
                if v ~= player and v.Character then
                    v.Character:Destroy()
                end
            end
        end
    end
end)

local player = game.Players.LocalPlayer
local hum = player.Character:WaitForChild("HumanoidRootPart")

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wizard"))()

local Window = Library:NewWindow("Just script")

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

Section:CreateButton("???", function()
return nil
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
local pos = hum.position
local copy  = string.format("%f, %f, %f", pos.X, pos.Y, pos.Z)
setclipboard(tostring(copy)) 
end)

Section:CreateButton("Скопировать Teleport", function()
local pos = hum.position
local copy  = string.format("game.Players.LocalPlayer.Character:PivotTo(CFrame.new(Vector3.new(%f, %f, %f)))", pos.X, pos.Y, pos.Z)
setclipboard(tostring(copy)) 
end)

Section:CreateButton("Скопировать TweenService", function()
local pos = hum.position
local copy  = string.format([[local tweenInfo = TweenInfo.new(2)
local goal = {CFrame = CFrame.new("%f, %f, %f")}
local tween = game:GetService("TweenService"):Create(game.Players.LocalPlayer.Character.HumanoidRootPart, tweenInfo, goal)
tween:Play()]], pos.X, pos.Y, pos.Z)
setclipboard(tostring(copy)) 
end)

Section:CreateButton("Скопировать MoveTo", function()
local pos = hum.position
local copy  = string.format([[local hrp = game.Players.LocalPlayer.Character.HumanoidRootPart
local position = "%f, %f, %f"
local humanoid = game.Players.LocalPlayer.Character.Humanoid
humanoid.WalkSpeed = 16
humanoid.JumpPower = 19
humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping, true)
humanoid:MoveTo(position)]], pos.X, pos.Y, pos.Z)
setclipboard(tostring(copy)) 
end)

Section:CreateButton("Скопировать Lerp", function()
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

Section:CreateButton("FireAllTouchinterest", function()
local char = game.Players.LocalPlayer.Character
local hrp = char and char:FindFirstChild("HumanoidRootPart")

for _, v in ipairs(workspace:GetDescendants()) do
    if v:IsA("BasePart") and v:IsDescendantOf(workspace) and v.CanTouch then
        firetouchinterest(hrp, v, 0)
        task.wait(0.1)
        firetouchinterest(hrp, v, 1)
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
