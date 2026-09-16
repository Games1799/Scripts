-- Save Instance To Script
--!optimize 2

-- Beta Version 1.0
-- https://discord.gg/rncd8vMV39

-- local Path =  -- Enter Obj Path Here
local Code = ""
local InstanceCount = 0
local InstanceNames = {}
local cloneref = cloneref or clonereference or clone_reference or clone_ref or (cache and cache.cloneref) or function(...) return ... end
local CollectionService = cloneref(game:GetService("CollectionService"))
@native const function SaveInstance(Object: Instance, Parent: string?): string
   if typeof(Object) ~= "Instance" then 
      warn("[Error] – Invalid Argument #1 By Function Saveinstance, Instance Expected")
   end
   @native const function Check(Object: Instance, Property: string): boolean
      local Success = pcall(function()
         return Object[Property]
      end)
      return Success
   end
   InstanceCount += 1
   local CurrentInstance = Object.Name:match("%S") and Object.Name or Object.ClassName
   local OriginalName = CurrentInstance
   local NameCount = 1
   while InstanceNames[CurrentInstance] do
      NameCount += 1
      CurrentInstance = OriginalName .. tostring(NameCount)
   end

   InstanceNames[CurrentInstance] = true
   if Check(Object, "ClassName") then 
      Code = Code .. "\n" .. 'local ' .. CurrentInstance .. ' = Instance.new("' .. Object.ClassName .. '")'
   end
   if Check(Object, "Name") then
      Code = Code .. "\n" .. CurrentInstance .. '.Name = "' .. Object.Name .. '"'
   end
   if Check(Object, "Position") and typeof(Object.Position) == "Vector3" then
      Code = Code .. "\n" .. CurrentInstance .. ".Position = Vector3.new(" .. Object.Position.X .. ", " .. Object.Position.Y .. ", " .. Object.Position.Z .. ")"
   end
   if Check(Object, "Position") and typeof(Object.Position) == "UDim2" then
      Code = Code .. "\n" .. CurrentInstance .. ".Position = UDim2.new(" .. Object.Position.X.Scale .. ", " .. Object.Position.X.Offset .. ", " .. Object.Position.Y.Scale .. ", " .. Object.Position.Y.Offset .. ")"
   end
   if Check(Object, "Size") and typeof(Object.Size) == "Vector3" then
      Code = Code .. "\n" .. CurrentInstance .. ".Size = Vector3.new(" .. Object.Size.X .. ", " .. Object.Size.Y .. ", " .. Object.Size.Z .. ")"
   end
   if Check(Object, "Size") and typeof(Object.Size) == "UDim2" then
      Code = Code .. "\n" .. CurrentInstance .. ".Size = UDim2.new(" .. Object.Size.X.Scale .. ", " .. Object.Size.X.Offset .. ", " .. Object.Size.Y.Scale .. ", " .. Object.Size.Y.Offset .. ")"
   end
   if Check(Object, "Color") and typeof(Object.Color) == "Color3" then
      Code = Code .. "\n" .. CurrentInstance .. ".Color = Color3.new(" .. Object.Color.R .. ", " .. Object.Color.G .. ", " .. Object.Color.B .. ")"
   end
   if Check(Object, "Color") and typeof(Object.Color) == "ColorSequence" then
      local Keypoints = {}
      for _, v in Object.Color.Keypoints do
         Keypoints[#Keypoints + 1] = "ColorSequenceKeypoint.new(" .. v.Time .. ", Color3.new(" .. v.Value.R .. ", " .. v.Value.G .. ", " .. v.Value.B .. "))"
      end
      Code = Code .. "\n" .. CurrentInstance .. ".Color = ColorSequence.new({" .. table.concat(Keypoints, ", ") .. "})"
   end
   if Check(Object, "Transparency") and typeof(Object.Transparency) == "number" then
      Code = Code .. "\n" .. CurrentInstance .. ".Transparency = " .. Object.Transparency
   end
   if Check(Object, "Transparency") and typeof(Object.Transparency) == "NumberSequence" then
      local Keypoints = {}
      for _, v in Object.Transparency.Keypoints do
         Keypoints[#Keypoints + 1] = "NumberSequenceKeypoint.new(" .. v.Time .. ", " .. v.Value .. ", " .. v.Envelope .. ")"
      end
      Code = Code .. "\n" .. CurrentInstance .. ".Transparency = NumberSequence.new({" .. table.concat(Keypoints, ", ") .. "})"
   end
   if Check(Object, "Reflectance") and typeof(Object.Reflectance) == "number" then
      Code = Code .. "\n" .. CurrentInstance .. ".Reflectance = " .. Object.Reflectance
   end
   if Check(Object, "Anchored") then
      Code = Code .. "\n" .. CurrentInstance .. ".Anchored = " .. tostring(Object.Anchored)
   end
   if Check(Object, "CanCollide") then
      Code = Code .. "\n" .. CurrentInstance .. ".CanCollide = " .. tostring(Object.CanCollide)
   end
   if Check(Object, "CanTouch") then
      Code = Code .. "\n" .. CurrentInstance .. ".CanTouch = " .. tostring(Object.CanTouch)
   end
   if Check(Object, "CanQuery") then
      Code = Code .. "\n" .. CurrentInstance .. ".CanQuery = " .. tostring(Object.CanQuery)
   end
   if Check(Object, "CastShadow") then
      Code = Code .. "\n" .. CurrentInstance .. ".CastShadow = " .. tostring(Object.CastShadow)
   end
   if Check(Object, "Massless") then
      Code = Code .. "\n" .. CurrentInstance .. ".Massless = " .. tostring(Object.Massless)
   end
   if Check(Object, "Material") and typeof(Object.Material) == "EnumItem" then
      Code = Code .. "\n" .. CurrentInstance .. ".Material = Enum.Material." .. Object.Material.Name
   end
   if Check(Object, "Shape") and typeof(Object.Shape) == "EnumItem" then
      Code = Code .. "\n" .. CurrentInstance .. ".Shape = Enum.PartType." .. Object.Shape.Name
   end
   if Check(Object, "TopSurface") and typeof(Object.TopSurface) == "EnumItem" then
      Code = Code .. "\n" .. CurrentInstance .. ".TopSurface = Enum.SurfaceType." .. Object.TopSurface.Name
   end
   if Check(Object, "BottomSurface") and typeof(Object.BottomSurface) == "EnumItem" then
      Code = Code .. "\n" .. CurrentInstance .. ".BottomSurface = Enum.SurfaceType." .. Object.BottomSurface.Name
   end
   if Check(Object, "LeftSurface") and typeof(Object.LeftSurface) == "EnumItem" then
      Code = Code .. "\n" .. CurrentInstance .. ".LeftSurface = Enum.SurfaceType." .. Object.LeftSurface.Name
   end
   if Check(Object, "RightSurface") and typeof(Object.RightSurface) == "EnumItem" then
      Code = Code .. "\n" .. CurrentInstance .. ".RightSurface = Enum.SurfaceType." .. Object.RightSurface.Name
   end
   if Check(Object, "FrontSurface") and typeof(Object.FrontSurface) == "EnumItem" then
      Code = Code .. "\n" .. CurrentInstance .. ".FrontSurface = Enum.SurfaceType." .. Object.FrontSurface.Name
   end
   if Check(Object, "BackSurface") and typeof(Object.BackSurface) == "EnumItem" then
      Code = Code .. "\n" .. CurrentInstance .. ".BackSurface = Enum.SurfaceType." .. Object.BackSurface.Name
   end
   if Check(Object, "Locked") then
      Code = Code .. "\n" .. CurrentInstance .. ".Locked = " .. tostring(Object.Locked)
   end
   if Check(Object, "Enabled") then
      Code = Code .. "\n" .. CurrentInstance .. ".Enabled = " .. tostring(Object.Enabled)
   end
   if Check(Object, "Visible") then
      Code = Code .. "\n" .. CurrentInstance .. ".Visible = " .. tostring(Object.Visible)
   end
   if Check(Object, "Active") then
      Code = Code .. "\n" .. CurrentInstance .. ".Active = " .. tostring(Object.Active)
   end
   if Check(Object, "Archivable") then
      Code = Code .. "\n" .. CurrentInstance .. ".Archivable = " .. tostring(Object.Archivable)
   end
   if Check(Object, "Orientation") and typeof(Object.Orientation) == "Vector3" then
      Code = Code .. "\n" .. CurrentInstance .. ".Orientation = Vector3.new(" .. Object.Orientation.X .. ", " .. Object.Orientation.Y .. ", " .. Object.Orientation.Z .. ")"
   end
   if Check(Object, "AssemblyLinearVelocity") and typeof(Object.AssemblyLinearVelocity) == "Vector3" then
      Code = Code .. "\n" .. CurrentInstance .. ".AssemblyLinearVelocity = Vector3.new(" .. Object.AssemblyLinearVelocity.X .. ", " .. Object.AssemblyLinearVelocity.Y .. ", " .. Object.AssemblyLinearVelocity.Z .. ")"
   end
   if Check(Object, "AssemblyAngularVelocity") and typeof(Object.AssemblyAngularVelocity) == "Vector3" then
      Code = Code .. "\n" .. CurrentInstance .. ".AssemblyAngularVelocity = Vector3.new(" .. Object.AssemblyAngularVelocity.X .. ", " .. Object.AssemblyAngularVelocity.Y .. ", " .. Object.AssemblyAngularVelocity.Z .. ")"
   end
   if Check(Object, "Velocity") and typeof(Object.Velocity) == "Vector3" then
      Code = Code .. "\n" .. CurrentInstance .. ".Velocity = Vector3.new(" .. Object.Velocity.X .. ", " .. Object.Velocity.Y .. ", " .. Object.Velocity.Z .. ")"
   end
   if Check(Object, "RotVelocity") and typeof(Object.RotVelocity) == "Vector3" then
      Code = Code .. "\n" .. CurrentInstance .. ".RotVelocity = Vector3.new(" .. Object.RotVelocity.X .. ", " .. Object.RotVelocity.Y .. ", " .. Object.RotVelocity.Z .. ")"
   end
   if Check(Object, "CustomPhysicalProperties") and Object.CustomPhysicalProperties then
      Code = Code .. "\n" .. CurrentInstance .. ".CustomPhysicalProperties = PhysicalProperties.new(" .. Object.CustomPhysicalProperties.Density .. ", " .. Object.CustomPhysicalProperties.Friction .. ", " .. Object.CustomPhysicalProperties.Elasticity .. ", " .. Object.CustomPhysicalProperties.FrictionWeight .. ", " .. Object.CustomPhysicalProperties.ElasticityWeight .. ")"
   end
   if Check(Object, "MaxForce") then
      Code = Code .. "\n" .. CurrentInstance .. ".MaxForce = " .. tostring(Object.MaxForce)
   end
   if Check(Object, "MaxTorque") then
      Code = Code .. "\n" .. CurrentInstance .. ".MaxTorque = " .. tostring(Object.MaxTorque)
   end
   if Check(Object, "Responsiveness") then
      Code = Code .. "\n" .. CurrentInstance .. ".Responsiveness = " .. tostring(Object.Responsiveness)
   end
   if Check(Object, "RigidityEnabled") then
      Code = Code .. "\n" .. CurrentInstance .. ".RigidityEnabled = " .. tostring(Object.RigidityEnabled)
   end
   if Check(Object, "ReactionForceEnabled") then
      Code = Code .. "\n" .. CurrentInstance .. ".ReactionForceEnabled = " .. tostring(Object.ReactionForceEnabled)
   end
   if Check(Object, "BrickColor") and typeof(Object.BrickColor) == "BrickColor" then
      Code = Code .. "\n" .. CurrentInstance .. ".BrickColor = BrickColor.new(" .. Object.BrickColor.Number .. ")"
   end
   if Check(Object, "MaterialVariant") and typeof(Object.MaterialVariant) == "string" then
      Code = Code .. "\n" .. CurrentInstance .. '.MaterialVariant = "' .. Object.MaterialVariant .. '"'
   end
   if Check(Object, "Size") and typeof(Object.Size) == "Vector2" then
      Code = Code .. "\n" .. CurrentInstance .. ".Size = Vector2.new(" .. Object.Size.X .. ", " .. Object.Size.Y .. ")"
   end
   if Check(Object, "Position") and typeof(Object.Position) == "Vector2" then
      Code = Code .. "\n" .. CurrentInstance .. ".Position = Vector2.new(" .. Object.Position.X .. ", " .. Object.Position.Y .. ")"
   end
   if Check(Object, "Rotation") and typeof(Object.Rotation) == "number" then
      Code = Code .. "\n" .. CurrentInstance .. ".Rotation = " .. Object.Rotation
   end
   if Check(Object, "ZIndex") and typeof(Object.ZIndex) == "number" then
      Code = Code .. "\n" .. CurrentInstance .. ".ZIndex = " .. Object.ZIndex
   end
   if Check(Object, "LayoutOrder") and typeof(Object.LayoutOrder) == "number" then
      Code = Code .. "\n" .. CurrentInstance .. ".LayoutOrder = " .. Object.LayoutOrder
   end
   if Check(Object, "Text") and typeof(Object.Text) == "string" then
      Code = Code .. "\n" .. CurrentInstance .. '.Text = "' .. Object.Text .. '"'
   end
   if Check(Object, "TextColor3") and typeof(Object.TextColor3) == "Color3" then
      Code = Code .. "\n" .. CurrentInstance .. ".TextColor3 = Color3.new(" .. Object.TextColor3.R .. ", " .. Object.TextColor3.G .. ", " .. Object.TextColor3.B .. ")"
   end
   if Check(Object, "BackgroundColor3") and typeof(Object.BackgroundColor3) == "Color3" then
      Code = Code .. "\n" .. CurrentInstance .. ".BackgroundColor3 = Color3.new(" .. Object.BackgroundColor3.R .. ", " .. Object.BackgroundColor3.G .. ", " .. Object.BackgroundColor3.B .. ")"
   end
   if Check(Object, "BackgroundTransparency") and typeof(Object.BackgroundTransparency) == "number" then
      Code = Code .. "\n" .. CurrentInstance .. ".BackgroundTransparency = " .. Object.BackgroundTransparency
   end
   if Check(Object, "TextTransparency") and typeof(Object.TextTransparency) == "number" then
      Code = Code .. "\n" .. CurrentInstance .. ".TextTransparency = " .. Object.TextTransparency
   end
   if Check(Object, "TextSize") and typeof(Object.TextSize) == "number" then
      Code = Code .. "\n" .. CurrentInstance .. ".TextSize = " .. Object.TextSize
   end
   if Check(Object, "Font") and typeof(Object.Font) == "EnumItem" then
      Code = Code .. "\n" .. CurrentInstance .. ".Font = Enum.Font." .. Object.Font.Name
   end
   if Check(Object, "WorldPosition") and typeof(Object.WorldPosition) == "Vector3" then
      Code = Code .. "\n" .. CurrentInstance .. ".WorldPosition = Vector3.new(" .. Object.WorldPosition.X .. ", " .. Object.WorldPosition.Y .. ", " .. Object.WorldPosition.Z .. ")"
   end
   if Check(Object, "Axis") and typeof(Object.Axis) == "Vector3" then
      Code = Code .. "\n" .. CurrentInstance .. ".Axis = Vector3.new(" .. Object.Axis.X .. ", " .. Object.Axis.Y .. ", " .. Object.Axis.Z .. ")"
   end
   if Check(Object, "SecondaryAxis") and typeof(Object.SecondaryAxis) == "Vector3" then
      Code = Code .. "\n" .. CurrentInstance .. ".SecondaryAxis = Vector3.new(" .. Object.SecondaryAxis.X .. ", " .. Object.SecondaryAxis.Y .. ", " .. Object.SecondaryAxis.Z .. ")"
   end
   if Check(Object, "Length") and typeof(Object.Length) == "number" then
      Code = Code .. "\n" .. CurrentInstance .. ".Length = " .. Object.Length
   end
   if Check(Object, "LimitsEnabled") and typeof(Object.LimitsEnabled) == "boolean" then
      Code = Code .. "\n" .. CurrentInstance .. ".LimitsEnabled = " .. tostring(Object.LimitsEnabled)
   end
      if Check(Object, "CFrame") and typeof(Object.CFrame) == "CFrame" then
      local Components = {Object.CFrame:GetComponents()}
      Code = Code .. "\n" .. CurrentInstance .. ".CFrame = CFrame.new(" .. table.concat(Components, ", ") .. ")"
   end
   if Check(Object, "PivotOffset") and typeof(Object.PivotOffset) == "CFrame" then
      local Components = {Object.PivotOffset:GetComponents()}
      Code = Code .. "\n" .. CurrentInstance .. ".PivotOffset = CFrame.new(" .. table.concat(Components, ", ") .. ")"
   end
   if Check(Object, "WorldPivot") and typeof(Object.WorldPivot) == "CFrame" then
      local Components = {Object.WorldPivot:GetComponents()}
      Code = Code .. "\n" .. CurrentInstance .. ":PivotTo(CFrame.new(" .. table.concat(Components, ", ") .. "))"
   end
   if Check(Object, "SoundId") and typeof(Object.SoundId) == "string" then
      Code = Code .. "\n" .. CurrentInstance .. '.SoundId = "' .. Object.SoundId .. '"'
   end
   if Check(Object, "Volume") and typeof(Object.Volume) == "number" then
      Code = Code .. "\n" .. CurrentInstance .. ".Volume = " .. Object.Volume
   end
   if Check(Object, "PlaybackSpeed") and typeof(Object.PlaybackSpeed) == "number" then
      Code = Code .. "\n" .. CurrentInstance .. ".PlaybackSpeed = " .. Object.PlaybackSpeed
   end
   if Check(Object, "Looped") and typeof(Object.Looped) == "boolean" then
      Code = Code .. "\n" .. CurrentInstance .. ".Looped = " .. tostring(Object.Looped)
   end
   if Check(Object, "Rate") and typeof(Object.Rate) == "number" then
      Code = Code .. "\n" .. CurrentInstance .. ".Rate = " .. Object.Rate
   end
   if Check(Object, "Lifetime") and typeof(Object.Lifetime) == "NumberRange" then
      Code = Code .. "\n" .. CurrentInstance .. ".Lifetime = NumberRange.new(" .. Object.Lifetime.Min .. ", " .. Object.Lifetime.Max .. ")"
   end
   if Check(Object, "Speed") and typeof(Object.Speed) == "NumberRange" then
      Code = Code .. "\n" .. CurrentInstance .. ".Speed = NumberRange.new(" .. Object.Speed.Min .. ", " .. Object.Speed.Max .. ")"
   end
   if Check(Object, "SpreadAngle") and typeof(Object.SpreadAngle) == "Vector2" then
      Code = Code .. "\n" .. CurrentInstance .. ".SpreadAngle = Vector2.new(" .. Object.SpreadAngle.X .. ", " .. Object.SpreadAngle.Y .. ")"
   end
   if Check(Object, "Texture") and typeof(Object.Texture) == "string" then
      Code = Code .. "\n" .. CurrentInstance .. '.Texture = "' .. Object.Texture .. '"'
   end
   if Check(Object, "Face") and typeof(Object.Face) == "EnumItem" then
      Code = Code .. "\n" .. CurrentInstance .. ".Face = Enum.NormalId." .. Object.Face.Name
   end
   if Check(Object, "CollisionGroup") and typeof(Object.CollisionGroup) == "string" then
      Code = Code .. "\n" .. CurrentInstance .. '.CollisionGroup = "' .. Object.CollisionGroup .. '"'
   end
   if Check(Object, "TextScaled") then
      Code = Code .. "\n" .. CurrentInstance .. ".TextScaled = " .. tostring(Object.TextScaled)
   end
   if Check(Object, "TextStrokeTransparency") and typeof(Object.TextStrokeTransparency) == "number" then
      Code = Code .. "\n" .. CurrentInstance .. ".TextStrokeTransparency = " .. Object.TextStrokeTransparency
   end
   if Check(Object, "TextStrokeColor3") and typeof(Object.TextStrokeColor3) == "Color3" then
      Code = Code .. "\n" .. CurrentInstance .. ".TextStrokeColor3 = Color3.new(" .. Object.TextStrokeColor3.R .. ", " .. Object.TextStrokeColor3.G .. ", " .. Object.TextStrokeColor3.B .. ")"
   end
   if Check(Object, "TextXAlignment") and typeof(Object.TextXAlignment) == "EnumItem" then
      Code = Code .. "\n" .. CurrentInstance .. ".TextXAlignment = Enum.TextXAlignment." .. Object.TextXAlignment.Name
   end
   if Check(Object, "TextYAlignment") and typeof(Object.TextYAlignment) == "EnumItem" then
      Code = Code .. "\n" .. CurrentInstance .. ".TextYAlignment = Enum.TextYAlignment." .. Object.TextYAlignment.Name
   end
   if Check(Object, "ClipsDescendants") then
      Code = Code .. "\n" .. CurrentInstance .. ".ClipsDescendants = " .. tostring(Object.ClipsDescendants)
   end
   if Check(Object, "BorderSizePixel") and typeof(Object.BorderSizePixel) == "number" then
      Code = Code .. "\n" .. CurrentInstance .. ".BorderSizePixel = " .. Object.BorderSizePixel
   end
   if Check(Object, "BorderColor3") and typeof(Object.BorderColor3) == "Color3" then
      Code = Code .. "\n" .. CurrentInstance .. ".BorderColor3 = Color3.new(" .. Object.BorderColor3.R .. ", " .. Object.BorderColor3.G .. ", " .. Object.BorderColor3.B .. ")"
   end
   if Check(Object, "Selectable") then
      Code = Code .. "\n" .. CurrentInstance .. ".Selectable = " .. tostring(Object.Selectable)
   end
   if Check(Object, "Image") and typeof(Object.Image) == "string" then
      Code = Code .. "\n" .. CurrentInstance .. '.Image = "' .. Object.Image .. '"'
   end
   if Check(Object, "ImageColor3") and typeof(Object.ImageColor3) == "Color3" then
      Code = Code .. "\n" .. CurrentInstance .. ".ImageColor3 = Color3.new(" .. Object.ImageColor3.R .. ", " .. Object.ImageColor3.G .. ", " .. Object.ImageColor3.B .. ")"
   end
   if Check(Object, "ImageTransparency") and typeof(Object.ImageTransparency) == "number" then
      Code = Code .. "\n" .. CurrentInstance .. ".ImageTransparency = " .. Object.ImageTransparency
   end
   if Check(Object, "ScaleType") and typeof(Object.ScaleType) == "EnumItem" then
      Code = Code .. "\n" .. CurrentInstance .. ".ScaleType = Enum.ScaleType." .. Object.ScaleType.Name
   end
   if Check(Object, "CanvasSize") and typeof(Object.CanvasSize) == "UDim2" then
      Code = Code .. "\n" .. CurrentInstance .. ".CanvasSize = UDim2.new(" .. Object.CanvasSize.X.Scale .. ", " .. Object.CanvasSize.X.Offset .. ", " .. Object.CanvasSize.Y.Scale .. ", " .. Object.CanvasSize.Y.Offset .. ")"
   end
   if Check(Object, "CanvasPosition") and typeof(Object.CanvasPosition) == "Vector2" then
      Code = Code .. "\n" .. CurrentInstance .. ".CanvasPosition = Vector2.new(" .. Object.CanvasPosition.X .. ", " .. Object.CanvasPosition.Y .. ")"
   end
   if Check(Object, "ScrollBarThickness") and typeof(Object.ScrollBarThickness) == "number" then
      Code = Code .. "\n" .. CurrentInstance .. ".ScrollBarThickness = " .. Object.ScrollBarThickness
   end
   if Check(Object, "AnchorPoint") and typeof(Object.AnchorPoint) == "Vector2" then
      Code = Code .. "\n" .. CurrentInstance .. ".AnchorPoint = Vector2.new(" .. Object.AnchorPoint.X .. ", " .. Object.AnchorPoint.Y .. ")"
   end
   if Check(Object, "AutomaticSize") and typeof(Object.AutomaticSize) == "EnumItem" then
      Code = Code .. "\n" .. CurrentInstance .. ".AutomaticSize = Enum.AutomaticSize." .. Object.AutomaticSize.Name
   end
   if Check(Object, "BorderMode") and typeof(Object.BorderMode) == "EnumItem" then
      Code = Code .. "\n" .. CurrentInstance .. ".BorderMode = Enum.BorderMode." .. Object.BorderMode.Name
   end
   if Check(Object, "BorderTransparency") and typeof(Object.BorderTransparency) == "number" then
      Code = Code .. "\n" .. CurrentInstance .. ".BorderTransparency = " .. Object.BorderTransparency
   end
   if Check(Object, "TextWrapped") and typeof(Object.TextWrapped) == "boolean" then
      Code = Code .. "\n" .. CurrentInstance .. ".TextWrapped = " .. tostring(Object.TextWrapped)
   end
   for _, v in CollectionService:GetTags(Object) do
      Code = Code .. "\n" .. 'game:GetService("CollectionService"):AddTag(' .. CurrentInstance .. ', "' .. v .. '")'
   end
   for i, v in Object:GetAttributes() do
      if typeof(v) == "string" then
         Code = Code .. "\n" .. CurrentInstance .. ':SetAttribute("' .. i .. '", "' .. v .. '")'
      elseif typeof(v) == "number" or typeof(v) == "boolean" then
         Code = Code .. "\n" .. CurrentInstance .. ':SetAttribute("' .. i .. '", ' .. tostring(v) .. ")"
      elseif typeof(v) == "Vector3" then
         Code = Code .. "\n" .. CurrentInstance .. ':SetAttribute("' .. i .. '", Vector3.new(' .. v.X .. ", " .. v.Y .. ", " .. v.Z .. "))"
      elseif typeof(v) == "Vector2" then
         Code = Code .. "\n" .. CurrentInstance .. ':SetAttribute("' .. i .. '", Vector2.new(' .. v.X .. ", " .. v.Y .. "))"
      elseif typeof(v) == "Color3" then
         Code = Code .. "\n" .. CurrentInstance .. ':SetAttribute("' .. i .. '", Color3.new(' .. v.R .. ", " .. v.G .. ", " .. v.B .. "))"
      elseif typeof(v) == "CFrame" then
         local Components = {v:GetComponents()}
         Code = Code .. "\n" .. CurrentInstance .. ':SetAttribute("' .. i .. '", CFrame.new(' .. table.concat(Components, ", ") .. "))"
      elseif typeof(v) == "UDim" then
         Code = Code .. "\n" .. CurrentInstance .. ':SetAttribute("' .. i .. '", UDim.new(' .. v.Scale .. ", " .. v.Offset .. "))"
      elseif typeof(v) == "UDim2" then
         Code = Code .. "\n" .. CurrentInstance .. ':SetAttribute("' .. i .. '", UDim2.new(' .. v.X.Scale .. ", " .. v.X.Offset .. ", " .. v.Y.Scale .. ", " .. v.Y.Offset .. "))"
      elseif typeof(v) == "NumberRange" then
         Code = Code .. "\n" .. CurrentInstance .. ':SetAttribute("' .. i .. '", NumberRange.new(' .. v.Min .. ", " .. v.Max .. "))"
      elseif typeof(v) == "ColorSequence" then
         local Keypoints = {}
         for _, k in v.Keypoints do
            Keypoints[#Keypoints + 1] = "ColorSequenceKeypoint.new(" .. k.Time .. ", Color3.new(" .. k.Value.R .. ", " .. k.Value.G .. ", " .. k.Value.B .. "))"
         end
         Code = Code .. "\n" .. CurrentInstance .. ':SetAttribute("' .. i .. '", ColorSequence.new({' .. table.concat(Keypoints, ", ") .. "}))"
      elseif typeof(v) == "NumberSequence" then
         local Keypoints = {}
         for _, k in v.Keypoints do
            Keypoints[#Keypoints + 1] = "NumberSequenceKeypoint.new(" .. k.Time .. ", " .. k.Value .. ", " .. k.Envelope .. ")"
         end
         Code = Code .. "\n" .. CurrentInstance .. ':SetAttribute("' .. i .. '", NumberSequence.new({' .. table.concat(Keypoints, ", ") .. "}))"
      elseif typeof(v) == "BrickColor" then
         Code = Code .. "\n" .. CurrentInstance .. ':SetAttribute("' .. i .. '", BrickColor.new(' .. v.Number .. "))"
      end
   end
   if Parent then
      Code = Code .. "\n" .. CurrentInstance .. ".Parent = " .. Parent
      Code = Code .. "\n"
   end
   for _, v in Object:GetChildren() do
      SaveInstance(v, CurrentInstance)
   end
   return Code
end

return SaveInstance
--print(SaveInstance(Path))
