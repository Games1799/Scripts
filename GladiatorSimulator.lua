local Library = loadstring(Game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wizard"))()
local Window = Library:NewWindow("Gladiator Simulator")
local Section = Window:NewSection("Main")

getgenv().AutoFight = false
getgenv().AutoFightAttack = false
getgenv().AutoSpin = false

Section:CreateToggle("Auto Train", function(state)
getgenv().AutoFight = state
while getgenv().AutoFight and task.wait() do
game:GetService("ReplicatedStorage").Packages["_Index"]["sleitnick_knit@1.4.7"].knit.Services.GameService.RE.PlayerAttackStart:FireServer()
end
end)

Section:CreateToggle("Auto Fight", function(state)
getgenv().AutoFightAttack = state
while getgenv().AutoFightAttack and task.wait() do
game:GetService("ReplicatedStorage").Packages["_Index"]["sleitnick_knit@1.4.7"].knit.Services.GameService.RF.RequestPlayerFightModeAttack:InvokeServer()
end
end)

Section:CreateToggle("Auto Spin", function(state)
getgenv().AutoSpin = state
while getgenv().AutoSpin and task.wait(1) do
game:GetService("ReplicatedStorage").Packages["_Index"]["sleitnick_knit@1.4.7"].knit.Services.GameService.RF.RequestWheelSpin:InvokeServer(1)
end
end)
