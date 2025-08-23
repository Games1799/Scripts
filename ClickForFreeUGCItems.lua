local StarterGui = game:GetService("StarterGui")
local VirtualUser = game:GetService("VirtualUser")

local Library = loadstring(Game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wizard"))()

local Window = Library:NewWindow("Click For Free UGC Items")

local Section = Window:NewSection("Основное")

Section:CreateButton("Ввести все коды", function()
    for _, codes in ipairs(game:GetService("Players").LocalPlayer.Codes:GetChildren()) do
    game:GetService("ReplicatedStorage").Remotes.UseCode:FireServer(codes.Name)
        end
end)

getgenv().hi = {toggle = false}

Section:CreateToggle("Автокликер", function(state)
    task.spawn(function()
        hi.toggle = state
        while true do
            if not hi.toggle then return end
            game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Click"):FireServer()
            task.wait()
        end
    end)
end)

Section:CreateButton("Анти афк", function()
game:GetService("Players").LocalPlayer.Idled:Connect(function()
    VirtualUser:CaptureController()VirtualUser:ClickButton2(Vector2.new())
end)
StarterGui:SetCore("SendNotification", {
    Title = "Успешно!",
    Text = "Анти афк активирован",
    Duration = 5
})
end)

local Window = Library:NewWindow("Создатель скрипта")

local Section = Window:NewSection("Основное")

Section:CreateButton("Тг канал", function()
    local copy  = "https://t.me/roblox_free_ugc_2025"
setclipboard(tostring(copy))
end)

Section:CreateButton("Юзер в тг", function()
    local copy  = "@Games1799"
setclipboard(tostring(copy))
end)

Section:CreateButton("Скрыть это окно", function()
game:GetService("CoreGui").WizardLibrary.Container["\208\161\208\190\208\183\208\180\208\176\209\130\208\181\208\187\209\140\209\129\208\186\209\128\208\184\208\191\209\130\208\176Window"]:Destroy()
end)
