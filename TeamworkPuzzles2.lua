--[[
░██████╗░░█████╗░███╗░░░███╗███████╗░██████╗
██╔════╝░██╔══██╗████╗░████║██╔════╝██╔════╝
██║░░██╗░███████║██╔████╔██║█████╗░░╚█████╗░
██║░░╚██╗██╔══██║██║╚██╔╝██║██╔══╝░░░╚═══██╗
╚██████╔╝██║░░██║██║░╚═╝░██║███████╗██████╔╝
 ░╚═════╝░╚═╝░░╚═╝╚═╝░░░░░╚═╝╚══════╝╚═════╝░
]]--

-- t.me/Games1799
-- t.me/Roblox_free_ugc_2026

local workspace = game:GetService("Workspace")
local char = game.Players.LocalPlayer.Character
if not char then return nil end

local Library = loadstring(Game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wizard"))()
local Window = Library:NewWindow("Teamwork Puzzles 2")
local Section = Window:NewSection("Основное")

Section:CreateButton("Собрать молоко", function()
for _, v in ipairs(workspace.MilkCollection:GetDescendants()) do
if v:IsA("TouchTransmitter") then
char:PivotTo(v.Parent:GetPivot())
firetouchinterest(char.HumanoidRootPart,v.Parent,0)
firetouchinterest(char.HumanoidRootPart,v.Parent,1)
task.wait(1)
end
end
end)
