local Library = loadstring(Game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wizard"))()

local Window = Library:NewWindow("Click For Free UGC Items")

local Section = Window:NewSection("Основное")

Section:CreateButton("Ввести все коды", function()
    local args = {
 "RELEASE"
}
game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("UseCode"):FireServer(unpack(args))
end)

getgenv().hi = {toggle = false}

Section:CreateToggle("Авто кликер", function(state)
    task.spawn(function()
        hi.toggle = state
        while true do
            if not hi.toggle then return end
            game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Click"):FireServer()
            task.wait()
        end
    end)
end)
