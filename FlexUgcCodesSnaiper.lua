local code = getgenv().code
local time = getgenv().time
local TestMode = getgenv().TestMode
local RunService = game:GetService("RunService")
local Conn
if TestMode then
conn = RunService.RenderStepped:Connect(function()
    if tick() >= time - 0.5 then
        game:GetService("ReplicatedStorage").RedeemCode:InvokeServer(code)
        conn:Disconnect()
    end
end)
else
conn = RunService.RenderStepped:Connect(function()
    if tick() >= time then
        game:GetService("ReplicatedStorage").RedeemCode:InvokeServer(code)
        conn:Disconnect()
    end
end)
end
