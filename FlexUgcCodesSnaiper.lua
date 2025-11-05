-- Beta version v0.7
local RunService = game:GetService("RunService")
local StarterGui = game:GetService("StarterGui")
local conn
local done = false

local code = getgenv().code
if not code or code == " " then
StarterGui:SetCore("SendNotification",{
Title = "Snaiper error",
Text = "Ошибка — введите код",
Duration = 3
})
return
end

local time = getgenv().time
if not time then
StarterGui:SetCore("SendNotification",{
Title = "Snaiper error",
Text = "Ошибка — введите время",
Duration = 3
})
return
end

local TestMode = getgenv().TestMode or false
local TestModeTime = getgenv().TestModeTimer or 0.49

local function formatTime(seconds)
    local h = math.floor(seconds / 3600)
    local m = math.floor((seconds % 3600) / 60)
    local s = math.floor(seconds % 60)
    return string.format("%02d:%02d:%02d", h, m, s)
end

task.spawn(function()
while not done do
local remaining = time - tick()
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
    if tick() >= getgenv().time - TestModeTime and not done then
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
