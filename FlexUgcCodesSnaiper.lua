-- Beta version v0.4
local code = getgenv().code
local time = getgenv().time
local TestMode = getgenv().TestMode
local RunService = game:GetService("RunService")
local StarterGui = game:GetService("StarterGui")
local conn
local done = false

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
Duration = 3
})
task.wait(5)
end
end)

if TestMode then
conn = RunService.RenderStepped:Connect(function()
    if os.time() >= time - 0.5 and not done then
        done = true
        game:GetService("ReplicatedStorage").RedeemCode:InvokeServer(code)
        conn:Disconnect()
        warn("snaiper for ".. code .." code finished [Beta]")
    end
end)
else
conn = RunService.RenderStepped:Connect(function()
    if os.time() >= time and not done then
        done = true
        game:GetService("ReplicatedStorage").RedeemCode:InvokeServer(code)
        conn:Disconnect()
        warn("Snaiper for ".. code .." code finished")
        end
    end)
end
warn("Snaiper for ".. code .." code started")
