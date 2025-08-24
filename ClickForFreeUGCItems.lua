local PlaceId = game.PlaceId
local StarterGui = game:GetService("StarterGui")
local VirtualUser = game:GetService("VirtualUser")

getgenv().hi = {toggle = false}
getgenv().hi1 = {toggle = false}
getgenv().Com = {toggle = false}
getgenv().Cow = {toggle = false}
getgenv().Jun = {toggle = false}
getgenv().Saf = {toggle = false}
getgenv().Cac = {toggle = false}
getgenv().Case1 = {toggle = false}
getgenv().Case2 = {toggle = false}
getgenv().Case3 = {toggle = false}
getgenv().Case4 = {toggle = false}

if PlaceId == 99096766260885 then
local Library = loadstring(Game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wizard"))()

local Window = Library:NewWindow("Click For Free UGC Items")

local Section = Window:NewSection("Основное")

Section:CreateButton("Ввести все коды", function()
    for _, codes in ipairs(game:GetService("Players").LocalPlayer.Codes:GetChildren()) do
    game:GetService("ReplicatedStorage").Remotes.UseCode:FireServer(codes.Name)
        end
end)

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

Section:CreateToggle("Авто спин", function(state)
    task.spawn(function()
        hi1.toggle = state
        while true do
            if not hi1.toggle then return end
            game:GetService("ReplicatedStorage").Remotes.SpinWheel:FireServer()
            task.wait(1)
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

local Section = Window:NewSection("Авто открытие яиц")

Section:CreateToggle("Common Egg (10к)", function(state)
    task.spawn(function()
        Com.toggle = state
        while true do
            if not Com.toggle then return end
local clicks = game:GetService("Players").LocalPlayer.leaderstats.Clicks.Value
            if clicks >= 10000 then 
local args = {
 "Common Egg",
 1,
 {}
}
game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("BuyEgg"):InvokeServer(unpack(args))
end
            task.wait(10)
        end
    end)
end)

Section:CreateToggle("Cow Egg (50к)", function(state)
    task.spawn(function()
        Cow.toggle = state
        while true do
            if not Cow.toggle then return end
local clicks = game:GetService("Players").LocalPlayer.leaderstats.Clicks.Value
            if clicks >= 50000 then 
local args = {
 "Cow Egg",
 1,
 {}
}
game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("BuyEgg"):InvokeServer(unpack(args))
end
            task.wait(10)
        end
    end)
end)

Section:CreateToggle("Jungle Egg (150к)", function(state)
    task.spawn(function()
        Jun.toggle = state
        while true do
            if not Jun.toggle then return end
local clicks = game:GetService("Players").LocalPlayer.leaderstats.Clicks.Value
            if clicks >= 150000 then 
local args = {
 "Jungle Egg",
 1,
 {}
}
game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("BuyEgg"):InvokeServer(unpack(args))
end
            task.wait(10)
        end
    end)
end)

Section:CreateToggle("Safari Egg (500к)", function(state)
    task.spawn(function()
        Saf.toggle = state
        while true do
            if not Saf.toggle then return end
local clicks = game:GetService("Players").LocalPlayer.leaderstats.Clicks.Value
            if clicks >= 500000 then 
local args = {
	"Safari Egg",
	1,
	{}
}
game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("BuyEgg"):InvokeServer(unpack(args))
end
            task.wait(10)
        end
    end)
end)

Section:CreateToggle("Jungle Egg (1.5м)", function(state)
    task.spawn(function()
        Cac.toggle = state
        while true do
            if not Cac.toggle then return end
local clicks = game:GetService("Players").LocalPlayer.leaderstats.Clicks.Value
            if clicks >= 1500000 then 
local args = {
	"Cactus Egg",
	1,
	{}
}
game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("BuyEgg"):InvokeServer(unpack(args))
end
            task.wait(10)
        end
    end)
end)

local Section = Window:NewSection("Авто открытие кейсов")

Section:CreateToggle("Small Vault (25к)", function(state)
    task.spawn(function()
        Case1.toggle = state
        while true do
            if not Case1.toggle then return end
local clicks = game:GetService("Players").LocalPlayer.leaderstats.Clicks.Value
            if clicks >= 25000 then 
game:GetService("ReplicatedStorage").Remotes.OpenCase:FireServer("Small Vault")
end
            task.wait(10)
        end
    end)
end)

Section:CreateToggle("Basic Case (100к)", function(state)
    task.spawn(function()
        Case2.toggle = state
        while true do
            if not Case2.toggle then return end
local clicks = game:GetService("Players").LocalPlayer.leaderstats.Clicks.Value
            if clicks >= 100000 then 
game:GetService("ReplicatedStorage").Remotes.OpenCase:FireServer("Basic Case")
end
            task.wait(10)
        end
    end)
end)

Section:CreateToggle("Big Vault (500к)", function(state)
    task.spawn(function()
        Case3.toggle = state
        while true do
            if not Case3.toggle then return end
local clicks = game:GetService("Players").LocalPlayer.leaderstats.Clicks.Value
            if clicks >= 500000 then 
game:GetService("ReplicatedStorage").Remotes.OpenCase:FireServer("Big Vault")
end
            task.wait(10)
        end
    end)
end)

Section:CreateToggle("Diamond Case (1.5м)", function(state)
    task.spawn(function()
        Case4.toggle = state
        while true do
            if not Case4.toggle then return end
local clicks = game:GetService("Players").LocalPlayer.leaderstats.Clicks.Value
            if clicks >= 1500000 then 
game:GetService("ReplicatedStorage").Remotes.OpenCase:FireServer("Diamond Case")
end
            task.wait(10)
        end
    end)
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
else 
StarterGui:SetCore("SendNotification", {
        Title = "Ошибка!",
        Text = "Этот плейс не подходит для скрипта",
        Duration = 5
    })
end
