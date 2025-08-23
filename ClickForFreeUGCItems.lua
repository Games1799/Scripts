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
