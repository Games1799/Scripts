-- Beta version v0.2
local code = getgenv().code
local time = getgenv().time
local TestMode = getgenv().TestMode
local RunService = game:GetService("RunService")
local StarterGui = game:GetService("StarterGui")
local conn
local done = false

task.spawn(function()
while not done do
local remaining = time - tick()
if remaining <= 0 then break end
StarterGui:SetCore("SendNotification",{
Title = "Snaiper",
Text = string.format("Осталось: %.1% сек.",remaining),
Duration = 3
})
task.wait(5)
end
end)

if TestMode then
conn = RunService.RenderStepped:Connect(function()
    if tick() >= time - 0.5 then
        game:GetService("ReplicatedStorage").RedeemCode:InvokeServer(code)
        conn:Disconnect()
        done = true
        warn("snaiper for ".. code .."finished [Beta]")
    end
end)
else
conn = RunService.RenderStepped:Connect(function()
    if tick() >= time time
        game:GetService("ReplicatedStorage").RedeemCode:InvokeServer(code)
        conn:Disconnect()
        done = true
        warn("Snaiper for".. code .."finished")
        end
    end)
end
warn("Snaiper for".. code .."code started")
