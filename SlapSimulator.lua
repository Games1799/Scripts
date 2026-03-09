local discord = loadstring(game:HttpGet("https://raw.githubusercontent.com/Games1799/Scripts/refs/heads/main/DiscordLubary.lua"))()
local win = discord:Window("Slap Simulator")
local serv = win:Server("Slap Simulator", "http://www.roblox.com/asset/?id=6031075938")
local Section = serv:Channel("Main")

getgenv().AutoTrainHand = false
getgenv().AutoClaimGifts = false
getgenv().AutoTrain = false
getgenv().AutoTrainEndurance = false
getgenv().AutoHatchLavaEgg = false
getgenv().AutoFight = false 
getgenv().AntiAfk = false

Section:Toggle("Auto Train", false, function(state)
getgenv().AutoTrain = state
while getgenv().AutoTrain and task.wait() do
for i = 1, 7 do
game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvent"):FireServer({{"\003","Knuckle","Train",tostring(i)}})
end
end
end)

Section:Toggle("Auto Hand Train", false, function(state)
getgenv().AutoTrainHand = state
while getgenv().AutoTrainHand and task.wait() do
game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvent"):FireServer({{"\003","HandGrips","Train"}})
end
end)

Section:Toggle("Auto Endurance Train", false, function(state)
getgenv().AutoTrainEndurance = state
while getgenv().AutoTrainEndurance and task.wait() do
for i = 1, 3 do
game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvent"):FireServer({{"\003","Endurance","Train",tostring(i)}})
end
end
end)

Section:Toggle("Auto Fight Slap", false, function(state)
getgenv().AutoFight = state
while getgenv().AutoFight and task.wait() do
game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvent"):FireServer({{"\003","Fight","Tap"}})
end
end)

Section:Toggle("Auto Claim Gifts", false, function(state)
getgenv().AutoClaimGifts = state
while getgenv().AutoClaimGifts and task.wait(1) do
for i = 1, 15 do
game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvent"):FireServer({{"\003","FreeGifts","Claim",tostring(i)}})
end
end
end) 

Section:Toggle("Auto Hatch Lava Egg", false, function(state) 
getgenv().AutoHatchLavaEgg = state 
while getgenv().AutoHatchLavaEgg and task.wait() do
game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvent"):FireServer({{"\003","Pets","Open","Lava Egg","One"}})
end
end)

local Conn 
Section:Toggle("Anti AFK", false, function(state) 
getgenv().AntiAfk = state
if getgenv().AntiAfk then
Conn = game:GetService("Players").LocalPlayer.Idled:Connect(function()
game:GetService("VirtualUser"):CaptureController()VirtualUser:ClickButton2(Vector2.new())
end)
else
Conn:Disconnect()
end
end)
