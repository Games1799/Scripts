local TpTool = Instance.new("Tool")
TpTool.RequiresHandle = false
TpTool.TextureId = "rbxassetid://6723742952"
TpTool.Parent = game.Players.LocalPlayer:FindFirstChildOfClass("Backpack")

local mouse = game.Players.LocalPlayer:GetMouse()
TpTool.Activated:Connect(function()
  local root = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
  if not root then 
    return 
  end
  if not mouse.Target then 
    return 
  end
  root.CFrame = CFrame.new(mouse.Hit.Position + Vector3.new(0,3,0))
end)
