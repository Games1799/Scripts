local Library = loadstring(Game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wizard"))()

local Window = Library:NewWindow("Gifts Battle!")

local Section = Window:NewSection("Основное")

getgenv().hi = {toggle = false}
getgenv().hi1 = {toggle = false}
getgenv().hi2 = {toggle = false}
getgenv().hi3 = {toggle = false}

Section:CreateToggle("Авто звёзды", function(state)
    task.spawn(function()
        hi.toggle = state
        while true do
            if not hi.toggle then return end
            game:GetService("ReplicatedStorage").Click:FireServer()
            task.wait()
        end
    end)
end)

Section:CreateToggle("Авто апгрейд", function(state)
    task.spawn(function()
        hi1.toggle = state
        while true do
            if not hi1.toggle then return end              game:GetService("ReplicatedStorage").Select:FireServer("Sh","Fast")
            task.wait(0.5)
            game:GetService("ReplicatedStorage").Up:FireServer()
            task.wait(1)
        end
    end)
end)

Section:CreateToggle("Авто спин", function(state)
    task.spawn(function()
        hi2.toggle = state
        while true do
            if not hi2.toggle then return end
             game:GetService("ReplicatedStorage").Spin:FireServer("Sh","Fast")
            task.wait(3)
        end
    end)
end)

Section:CreateToggle("Авто шахта", function(state)
    task.spawn(function()
        hi3.toggle = state
        while true do
            if not hi3.toggle then return end
            game:GetService("ReplicatedStorage").SeM:FireServer(4)
            task.wait(0.2)
            game:GetService("ReplicatedStorage").Select3:FireServer("Gift")
            task.wait(0.3)
            game:GetService("ReplicatedStorage").Play:FireServer("Play")
            task.wait(0.3)
            game:GetService("ReplicatedStorage").Mine:FireServer("m19")
            task.wait(1)
        end
    end)
end)

Section:CreateButton("Анти афк", function()
local VirtualUser = game:GetService("VirtualUser")
game:GetService("Players").LocalPlayer.Idled:Connect(function()
VirtualUser:CaptureController()VirtualUser:ClickButton2(Vector2.new())
end)
game:GetService("StarterGui"):SetCore("SendNotification", { 
        Title = "Успешно!",
        Text = "Анти афк активирован!",
        Button1 = "Ок",
        Duration = 5,
})
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
