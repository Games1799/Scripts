-- Beta version v0.7
local RunService = game:GetService("RunService")
local StarterGui = game:GetService("StarterGui")
local conn
local done = false

if getgenv().code then
local code = getgenv().code
else
StarterGui:SetCore("SendNotification",{
Title = "Snaiper eror",
Text = "Ошибка — введите код",
Duration = 3
})
end

if TestMode = getgenv().TestMode then
local TestMode = getgenv().TestMode
else
local TestMode = false
end

if getgenv().time then
local time = getgenv().time
else
StarterGui:SetCore("SendNotification",{
Title = "Snaiper eror",
Text = "Ошибка — введите время",
Duration = 3
})
end

if getgenv().TestMode then
if not getgenv().TestModeTimer then 
local TestModeTime = 0.49 
else 
local TestModeTime = getgenv().TestModeTimer
end
end

local function formatTime(seconds)
    local h = math.floor(seconds / 3600)
    local m = math.floor((seconds % 3600) / 60)
    local s = math.floor(seconds % 60)
    return string.format("%02d:%02d:%02d", h, m, s)
end

task.spawn(function()
while not done do
local remaining = time - os.time()
if remaining <= 0 then break end
StarterGui:SetCore("SendNotification",{
Title = "Snaiper",
Text = string.format("Осталось: %s", formatTime(remaining)),
Duration = 0.9
})
task.wait(1)
end
end)

if TestMode then
conn = RunService.RenderStepped:Connect(function()
    if os.time() >= getgenv().time - TestModeTime and not done then
        done = true
        game:GetService("ReplicatedStorage").RedeemCode:InvokeServer(code)
        conn:Disconnect()
        warn("snaiper for ".. code .." code finished [Beta]")
    end
end)
else
conn = RunService.RenderStepped:Connect(function()
    if os.time() >= getgenv().time and not done then
        done = true
        game:GetService("ReplicatedStorage").RedeemCode:InvokeServer(code)
        conn:Disconnect()
        warn("Snaiper for ".. code .." code finished")
        end
    end)
end
warn("Snaiper for ".. code .." code started")
