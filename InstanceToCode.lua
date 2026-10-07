--!optimize 2
-- Instance To Script v1.3
-- https://discord.gg/rncd8vMV39

local Code = table.create(300000)
local CodeIndex = 0
@native function AddCode(Value)
   CodeIndex += 1
   Code[CodeIndex] = Value
end
local InstanceCount = 0
local InstanceNames = {}
local InstanceVariables = {}
local DeferredProperties = {}
local cloneref = cloneref or clonereference or clone_reference or clone_ref or (cache and cache.cloneref) or function(...) return (...) end
local CollectionService = cloneref(game:GetService("CollectionService"))
local ReflectionService = cloneref(game:GetService("ReflectionService"))
local First = false
local UseCollectionService = false
@native const function SaveInstance(Object: Instance, Parent: string?): string
   if typeof(Object) ~= "Instance" then 
      warn("[Error] – Invalid Argument #1 By Function SaveInstance, Instance Expected")
      return ""
   end
   local PropertyCache = {}
   @native const function Check(Object: Instance, Property: string): boolean
    local ClassName = Object.ClassName
  	local Properties = PropertyCache[ClassName]
  	if not Properties then
	 	Properties = {}
	 	for _, v in ReflectionService:GetPropertiesOfClass(ClassName) do
        	Properties[v.Name] = true
 		end
 		PropertyCache[ClassName] = Properties
  	end
  	if not Properties[Property] then
	     return false
 	end
 	@native function Test()
     	return Object[Property]
  	end
  	local Success = pcall(Test)
      return Success
   end
   
   local function SplitCode(Code, Limit)
      local Parts = {}
      local Start = 1
      local LocalCount = Code:match("^local%s+") and 1 or 0
      local Search = 1
      while true do
         local Position = Code:find("\nlocal ", Search, true)
         if not Position then
            break
         end
         LocalCount += 1
         if LocalCount > Limit then
            Parts[#Parts + 1] = Code:sub(Start, Position - 1):gsub("\n+$", "")
            Start = Position + 1
            LocalCount = 1
         end
         Search = Position + 1
      end
      Parts[#Parts + 1] = Code:sub(Start):gsub("\n+$", "")
      if #Parts == 1 then
         return Code
      end
      local Result = table.create(#Parts * 2)
      Result[#Result + 1] = Parts[1]
      for i = 2, #Parts do
         local Prefix = string.rep("   ", i - 2)
         Result[#Result + 1] = ";\n" .. Prefix .. "(function()\n"
         Result[#Result + 1] = Prefix .. "   " .. Parts[i]:gsub("^\n+", ""):gsub("\n", "\n" .. Prefix .. "   ")
      end
      for i = #Parts - 1, 1, -1 do
         Result[#Result + 1] = "\n" .. string.rep("   ", i - 1) .. "end)()"
      end
      return table.concat(Result)
   end

   InstanceCount += 1
   local CurrentInstance = Object.Name:match("^[%a_][%w_]*$") and Object.Name or Object.ClassName
   local OriginalName = CurrentInstance
   local NameCount = 1
   while InstanceNames[CurrentInstance] do
      NameCount += 1
      CurrentInstance = OriginalName .. tostring(NameCount)
   end
   
   InstanceNames[CurrentInstance] = true
   InstanceVariables[Object] = CurrentInstance
   if Check(Object, "ClassName") then 
      if First == true then 
         AddCode("\n" .. 'local ' .. CurrentInstance .. ' = Instance.new("' .. Object.ClassName .. '")')
      else
         First = true
         AddCode('local ' .. CurrentInstance .. ' = Instance.new("' .. Object.ClassName .. '")')
      end
   end
   if Check(Object, "Name") then
      AddCode("\n" .. CurrentInstance .. ".Name = " .. string.format("%q", Object.Name))
   end
   if Check(Object, "Position") and typeof(Object.Position) == "Vector3" then
      AddCode("\n" .. CurrentInstance .. ".Position = Vector3.new(" .. Object.Position.X .. ", " .. Object.Position.Y .. ", " .. Object.Position.Z .. ")")
   end
   if Check(Object, "Position") and typeof(Object.Position) == "UDim2" then
      AddCode("\n" .. CurrentInstance .. ".Position = UDim2.new(" .. Object.Position.X.Scale .. ", " .. Object.Position.X.Offset .. ", " .. Object.Position.Y.Scale .. ", " .. Object.Position.Y.Offset .. ")")
   end
   if Check(Object, "Position") and typeof(Object.Position) == "Vector2" then
      AddCode("\n" .. CurrentInstance .. ".Position = Vector2.new(" .. Object.Position.X .. ", " .. Object.Position.Y .. ")")
   end
   if Check(Object, "Size") and typeof(Object.Size) == "Vector3" then
      AddCode("\n" .. CurrentInstance .. ".Size = Vector3.new(" .. Object.Size.X .. ", " .. Object.Size.Y .. ", " .. Object.Size.Z .. ")")
   end
   if Check(Object, "Size") and typeof(Object.Size) == "UDim2" then
      AddCode("\n" .. CurrentInstance .. ".Size = UDim2.new(" .. Object.Size.X.Scale .. ", " .. Object.Size.X.Offset .. ", " .. Object.Size.Y.Scale .. ", " .. Object.Size.Y.Offset .. ")")
   end
   if Check(Object, "Size") and typeof(Object.Size) == "number" then
      AddCode("\n" .. CurrentInstance .. ".Size = " .. tostring(Object.Size))
   end
   if Check(Object, "Size") and typeof(Object.Size) == "Vector2" then
      AddCode("\n" .. CurrentInstance .. ".Size = Vector2.new(" .. Object.Size.X .. ", " .. Object.Size.Y .. ")")
   end
   if Check(Object, "Color") and typeof(Object.Color) == "Color3" then
      AddCode("\n" .. CurrentInstance .. ".Color = Color3.new(" .. Object.Color.R .. ", " .. Object.Color.G .. ", " .. Object.Color.B .. ")")
   end
   if Check(Object, "Color") and typeof(Object.Color) == "ColorSequence" then
      local Keypoints = {}
      for _, v in Object.Color.Keypoints do
         Keypoints[#Keypoints + 1] = "ColorSequenceKeypoint.new(" .. v.Time .. ", Color3.new(" .. v.Value.R .. ", " .. v.Value.G .. ", " .. v.Value.B .. "))"
      end
      AddCode("\n" .. CurrentInstance .. ".Color = ColorSequence.new({" .. table.concat(Keypoints, ", ") .. "})")
   end
   if Check(Object, "Transparency") and typeof(Object.Transparency) == "number" then
      AddCode("\n" .. CurrentInstance .. ".Transparency = " .. Object.Transparency)
   end
   if Check(Object, "Transparency") and typeof(Object.Transparency) == "NumberSequence" then
      local Keypoints = {}
      for _, v in Object.Transparency.Keypoints do
         Keypoints[#Keypoints + 1] = "NumberSequenceKeypoint.new(" .. v.Time .. ", " .. v.Value .. ", " .. v.Envelope .. ")"
      end
      AddCode("\n" .. CurrentInstance .. ".Transparency = NumberSequence.new({" .. table.concat(Keypoints, ", ") .. "})")
   end
   if Check(Object, "Reflectance") and typeof(Object.Reflectance) == "number" then
      AddCode("\n" .. CurrentInstance .. ".Reflectance = " .. Object.Reflectance)
   end
   if Check(Object, "Anchored") then
      AddCode("\n" .. CurrentInstance .. ".Anchored = " .. tostring(Object.Anchored))
   end
   if Check(Object, "CanCollide") then
      AddCode("\n" .. CurrentInstance .. ".CanCollide = " .. tostring(Object.CanCollide))
   end
   if Check(Object, "CanTouch") then
      AddCode("\n" .. CurrentInstance .. ".CanTouch = " .. tostring(Object.CanTouch))
   end
   if Check(Object, "CanQuery") then
      AddCode("\n" .. CurrentInstance .. ".CanQuery = " .. tostring(Object.CanQuery))
   end
   if Check(Object, "CastShadow") then
      AddCode("\n" .. CurrentInstance .. ".CastShadow = " .. tostring(Object.CastShadow))
   end
   if Check(Object, "Massless") then
      AddCode("\n" .. CurrentInstance .. ".Massless = " .. tostring(Object.Massless))
   end
   if Check(Object, "Material") and typeof(Object.Material) == "EnumItem" then
       AddCode("\n" .. CurrentInstance .. ".Material = Enum." .. tostring(Object.Material.EnumType) .. "." .. Object.Material.Name)
   end
   if Check(Object, "Shape") and typeof(Object.Shape) == "EnumItem" then
      AddCode("\n" .. CurrentInstance .. ".Shape = Enum." .. tostring(Object.Shape.EnumType) .. "." .. Object.Shape.Name)
   end
   if Object:IsA("ParticleEmitter") and Check(Object, "Shape") and typeof(Object.Shape) == "EnumItem" then
      AddCode("\n" .. CurrentInstance .. ".Shape = Enum." .. tostring(Object.Shape.EnumType) .. "." .. Object.Shape.Name)
   end
   if Check(Object, "TopSurface") and typeof(Object.TopSurface) == "EnumItem" then
      AddCode("\n" .. CurrentInstance .. ".TopSurface = Enum." .. tostring(Object.TopSurface.EnumType) .. "." .. Object.TopSurface.Name)
   end
   if Check(Object, "BottomSurface") and typeof(Object.BottomSurface) == "EnumItem" then
      AddCode("\n" .. CurrentInstance .. ".BottomSurface = Enum." .. tostring(Object.BottomSurface.EnumType) .. "." .. Object.BottomSurface.Name)
   end
   if Check(Object, "LeftSurface") and typeof(Object.LeftSurface) == "EnumItem" then
      AddCode("\n" .. CurrentInstance .. ".LeftSurface = Enum." .. tostring(Object.LeftSurface.EnumType) .. "." .. Object.LeftSurface.Name)
   end
   if Check(Object, "RightSurface") and typeof(Object.RightSurface) == "EnumItem" then
      AddCode("\n" .. CurrentInstance .. ".RightSurface = Enum." .. tostring(Object.RightSurface.EnumType) .. "." .. Object.RightSurface.Name)
   end
   if Check(Object, "FrontSurface") and typeof(Object.FrontSurface) == "EnumItem" then
      AddCode("\n" .. CurrentInstance .. ".FrontSurface = Enum." .. tostring(Object.FrontSurface.EnumType) .. "." .. Object.FrontSurface.Name)
   end
   if Check(Object, "BackSurface") and typeof(Object.BackSurface) == "EnumItem" then
      AddCode("\n" .. CurrentInstance .. ".BackSurface = Enum." .. tostring(Object.BackSurface.EnumType) .. "." .. Object.BackSurface.Name)
   end
   if Check(Object, "Locked") then
      AddCode("\n" .. CurrentInstance .. ".Locked = " .. tostring(Object.Locked))
   end
   if Check(Object, "Enabled") then
      AddCode("\n" .. CurrentInstance .. ".Enabled = " .. tostring(Object.Enabled))
   end
   if Check(Object, "Visible") then
      AddCode("\n" .. CurrentInstance .. ".Visible = " .. tostring(Object.Visible))
   end
   if Check(Object, "Active") then
      AddCode("\n" .. CurrentInstance .. ".Active = " .. tostring(Object.Active))
   end
   if Check(Object, "Archivable") then
      AddCode("\n" .. CurrentInstance .. ".Archivable = " .. tostring(Object.Archivable))
   end
   if Check(Object, "Orientation") and typeof(Object.Orientation) == "Vector3" then
      AddCode("\n" .. CurrentInstance .. ".Orientation = Vector3.new(" .. Object.Orientation.X .. ", " .. Object.Orientation.Y .. ", " .. Object.Orientation.Z .. ")")
   end
   if Check(Object, "AssemblyLinearVelocity") and typeof(Object.AssemblyLinearVelocity) == "Vector3" then
      AddCode("\n" .. CurrentInstance .. ".AssemblyLinearVelocity = Vector3.new(" .. Object.AssemblyLinearVelocity.X .. ", " .. Object.AssemblyLinearVelocity.Y .. ", " .. Object.AssemblyLinearVelocity.Z .. ")")
   end
   if Check(Object, "AssemblyAngularVelocity") and typeof(Object.AssemblyAngularVelocity) == "Vector3" then
      AddCode("\n" .. CurrentInstance .. ".AssemblyAngularVelocity = Vector3.new(" .. Object.AssemblyAngularVelocity.X .. ", " .. Object.AssemblyAngularVelocity.Y .. ", " .. Object.AssemblyAngularVelocity.Z .. ")")
   end
   if Check(Object, "Velocity") and typeof(Object.Velocity) == "Vector3" then
      AddCode("\n" .. CurrentInstance .. ".Velocity = Vector3.new(" .. Object.Velocity.X .. ", " .. Object.Velocity.Y .. ", " .. Object.Velocity.Z .. ")")
   end
   if Check(Object, "RotVelocity") and typeof(Object.RotVelocity) == "Vector3" then
      AddCode("\n" .. CurrentInstance .. ".RotVelocity = Vector3.new(" .. Object.RotVelocity.X .. ", " .. Object.RotVelocity.Y .. ", " .. Object.RotVelocity.Z .. ")")
   end
   if Check(Object, "CustomPhysicalProperties") and Object.CustomPhysicalProperties and Object.CustomPhysicalProperties.Uri then
      AddCode("\n" .. CurrentInstance .. ".CustomPhysicalProperties = PhysicalProperties.new(" .. Object.CustomPhysicalProperties.Density .. ", " .. Object.CustomPhysicalProperties.Friction .. ", " .. Object.CustomPhysicalProperties.Elasticity .. ", " .. Object.CustomPhysicalProperties.FrictionWeight .. ", " .. Object.CustomPhysicalProperties.ElasticityWeight .. ")")
   end
   if Check(Object, "MaxForce") then
      AddCode("\n" .. CurrentInstance .. ".MaxForce = " .. tostring(Object.MaxForce))
   end
   if Check(Object, "MaxTorque") then
      AddCode("\n" .. CurrentInstance .. ".MaxTorque = " .. tostring(Object.MaxTorque))
   end
   if Check(Object, "Responsiveness") then
      AddCode("\n" .. CurrentInstance .. ".Responsiveness = " .. tostring(Object.Responsiveness))
   end
   if Check(Object, "RigidityEnabled") then
      AddCode("\n" .. CurrentInstance .. ".RigidityEnabled = " .. tostring(Object.RigidityEnabled))
   end
   if Check(Object, "ReactionForceEnabled") then
      AddCode("\n" .. CurrentInstance .. ".ReactionForceEnabled = " .. tostring(Object.ReactionForceEnabled))
   end
   if Check(Object, "BrickColor") and typeof(Object.BrickColor) == "BrickColor" then
      AddCode("\n" .. CurrentInstance .. ".BrickColor = BrickColor.new(" .. Object.BrickColor.Number .. ")")
   end
   if Check(Object, "MaterialVariant") and typeof(Object.MaterialVariant) == "string" then
      AddCode("\n" .. CurrentInstance .. '.MaterialVariant = "' .. Object.MaterialVariant .. '"')
   end
   if Check(Object, "Size") and typeof(Object.Size) == "Vector2" then
      AddCode("\n" .. CurrentInstance .. ".Size = Vector2.new(" .. Object.Size.X .. ", " .. Object.Size.Y .. ")")
   end
   if Check(Object, "Position") and typeof(Object.Position) == "Vector2" then
      AddCode("\n" .. CurrentInstance .. ".Position = Vector2.new(" .. Object.Position.X .. ", " .. Object.Position.Y .. ")")
   end
   if Check(Object, "ZIndex") and typeof(Object.ZIndex) == "number" then
      AddCode("\n" .. CurrentInstance .. ".ZIndex = " .. Object.ZIndex)
   end
   if Check(Object, "LayoutOrder") and typeof(Object.LayoutOrder) == "number" then
      AddCode("\n" .. CurrentInstance .. ".LayoutOrder = " .. Object.LayoutOrder)
   end
   if Check(Object, "Text") and typeof(Object.Text) == "string" then
      AddCode("\n" .. CurrentInstance .. ".Text = " .. string.format("%q", Object.Text))
   end
   if Check(Object, "TextColor3") and typeof(Object.TextColor3) == "Color3" then
      AddCode("\n" .. CurrentInstance .. ".TextColor3 = Color3.new(" .. Object.TextColor3.R .. ", " .. Object.TextColor3.G .. ", " .. Object.TextColor3.B .. ")")
   end
   if Check(Object, "BackgroundColor3") and typeof(Object.BackgroundColor3) == "Color3" then
      AddCode("\n" .. CurrentInstance .. ".BackgroundColor3 = Color3.new(" .. Object.BackgroundColor3.R .. ", " .. Object.BackgroundColor3.G .. ", " .. Object.BackgroundColor3.B .. ")")
   end
   if Check(Object, "BackgroundTransparency") and typeof(Object.BackgroundTransparency) == "number" then
      AddCode("\n" .. CurrentInstance .. ".BackgroundTransparency = " .. Object.BackgroundTransparency)
   end
   if Check(Object, "TextTransparency") and typeof(Object.TextTransparency) == "number" then
      AddCode("\n" .. CurrentInstance .. ".TextTransparency = " .. Object.TextTransparency)
   end
   if Check(Object, "TextSize") and typeof(Object.TextSize) == "number" then
      AddCode("\n" .. CurrentInstance .. ".TextSize = " .. Object.TextSize)
   end
   if Check(Object, "Font") and typeof(Object.Font) == "EnumItem" then
      AddCode("\n" .. CurrentInstance .. ".Font = Enum.Font." .. Object.Font.Name)
   end
   if Check(Object, "Axis") and typeof(Object.Axis) == "Vector3" then
      AddCode("\n" .. CurrentInstance .. ".Axis = Vector3.new(" .. Object.Axis.X .. ", " .. Object.Axis.Y .. ", " .. Object.Axis.Z .. ")")
   end
   if Check(Object, "SecondaryAxis") and typeof(Object.SecondaryAxis) == "Vector3" then
      AddCode("\n" .. CurrentInstance .. ".SecondaryAxis = Vector3.new(" .. Object.SecondaryAxis.X .. ", " .. Object.SecondaryAxis.Y .. ", " .. Object.SecondaryAxis.Z .. ")")
   end
   if Check(Object, "Length") and typeof(Object.Length) == "number" then
      AddCode("\n" .. CurrentInstance .. ".Length = " .. Object.Length)
   end
   if Check(Object, "LimitsEnabled") and typeof(Object.LimitsEnabled) == "boolean" then
      AddCode("\n" .. CurrentInstance .. ".LimitsEnabled = " .. tostring(Object.LimitsEnabled))
   end
      if Check(Object, "CFrame") and typeof(Object.CFrame) == "CFrame" then
      local Components = {Object.CFrame:GetComponents()}
      AddCode("\n" .. CurrentInstance .. ".CFrame = CFrame.new(" .. table.concat(Components, ", ") .. ")")
   end
   if Check(Object, "PivotOffset") and typeof(Object.PivotOffset) == "CFrame" then
      local Components = {Object.PivotOffset:GetComponents()}
      AddCode("\n" .. CurrentInstance .. ".PivotOffset = CFrame.new(" .. table.concat(Components, ", ") .. ")")
   end
   if Check(Object, "WorldPivot") and typeof(Object.WorldPivot) == "CFrame" then
      local Components = {Object.WorldPivot:GetComponents()}
      AddCode("\n" .. CurrentInstance .. ".WorldPivot = CFrame.new(" .. table.concat(Components, ", ") .. ")")
   end
   if Check(Object, "SoundId") and typeof(Object.SoundId) == "string" then
      AddCode("\n" .. CurrentInstance .. '.SoundId = "' .. Object.SoundId .. '"')
   end
   if Check(Object, "Volume") and typeof(Object.Volume) == "number" then
      AddCode("\n" .. CurrentInstance .. ".Volume = " .. Object.Volume)
   end
   if Check(Object, "PlaybackSpeed") and typeof(Object.PlaybackSpeed) == "number" then
      AddCode("\n" .. CurrentInstance .. ".PlaybackSpeed = " .. Object.PlaybackSpeed)
   end
   if Check(Object, "Looped") and typeof(Object.Looped) == "boolean" then
      AddCode("\n" .. CurrentInstance .. ".Looped = " .. tostring(Object.Looped))
   end
   if Check(Object, "Rate") and typeof(Object.Rate) == "number" then
      AddCode("\n" .. CurrentInstance .. ".Rate = " .. Object.Rate)
   end
   if Check(Object, "Lifetime") and typeof(Object.Lifetime) == "NumberRange" then
      AddCode("\n" .. CurrentInstance .. ".Lifetime = NumberRange.new(" .. Object.Lifetime.Min .. ", " .. Object.Lifetime.Max .. ")")
   end
   if Check(Object, "Speed") and typeof(Object.Speed) == "NumberRange" then
      AddCode("\n" .. CurrentInstance .. ".Speed = NumberRange.new(" .. Object.Speed.Min .. ", " .. Object.Speed.Max .. ")")
   end
   if Check(Object, "SpreadAngle") and typeof(Object.SpreadAngle) == "Vector2" then
      AddCode("\n" .. CurrentInstance .. ".SpreadAngle = Vector2.new(" .. Object.SpreadAngle.X .. ", " .. Object.SpreadAngle.Y .. ")")
   end
   if Check(Object, "Texture") and typeof(Object.Texture) == "string" then
      AddCode("\n" .. CurrentInstance .. '.Texture = "' .. Object.Texture .. '"')
   end
   if Check(Object, "Face") and typeof(Object.Face) == "EnumItem" then
      AddCode("\n" .. CurrentInstance .. ".Face = Enum.NormalId." .. Object.Face.Name)
   end
   if Check(Object, "CollisionGroup") and typeof(Object.CollisionGroup) == "string" then
      AddCode("\n" .. CurrentInstance .. '.CollisionGroup = "' .. Object.CollisionGroup .. '"')
   end
   if Check(Object, "TextScaled") then
      AddCode("\n" .. CurrentInstance .. ".TextScaled = " .. tostring(Object.TextScaled))
   end
   if Check(Object, "TextStrokeTransparency") and typeof(Object.TextStrokeTransparency) == "number" then
      AddCode("\n" .. CurrentInstance .. ".TextStrokeTransparency = " .. Object.TextStrokeTransparency)
   end
   if Check(Object, "TextStrokeColor3") and typeof(Object.TextStrokeColor3) == "Color3" then
      AddCode("\n" .. CurrentInstance .. ".TextStrokeColor3 = Color3.new(" .. Object.TextStrokeColor3.R .. ", " .. Object.TextStrokeColor3.G .. ", " .. Object.TextStrokeColor3.B .. ")")
   end
   if Check(Object, "TextXAlignment") and typeof(Object.TextXAlignment) == "EnumItem" then
      AddCode("\n" .. CurrentInstance .. ".TextXAlignment = Enum." .. tostring(Object.TextXAlignment.EnumType) .. "." .. Object.TextXAlignment.Name)
   end
   if Check(Object, "TextYAlignment") and typeof(Object.TextYAlignment) == "EnumItem" then
      AddCode("\n" .. CurrentInstance .. ".TextYAlignment = Enum." .. tostring(Object.TextYAlignment.EnumType) .. "." .. Object.TextYAlignment.Name)
   end
   if Check(Object, "ClipsDescendants") then
      AddCode("\n" .. CurrentInstance .. ".ClipsDescendants = " .. tostring(Object.ClipsDescendants))
   end
   if Check(Object, "BorderSizePixel") and typeof(Object.BorderSizePixel) == "number" then
      AddCode("\n" .. CurrentInstance .. ".BorderSizePixel = " .. Object.BorderSizePixel)
   end
   if Check(Object, "BorderColor3") and typeof(Object.BorderColor3) == "Color3" then
      AddCode("\n" .. CurrentInstance .. ".BorderColor3 = Color3.new(" .. Object.BorderColor3.R .. ", " .. Object.BorderColor3.G .. ", " .. Object.BorderColor3.B .. ")")
   end
   if Check(Object, "Selectable") then
      AddCode("\n" .. CurrentInstance .. ".Selectable = " .. tostring(Object.Selectable))
   end
   if Check(Object, "Image") and typeof(Object.Image) == "string" then
      AddCode("\n" .. CurrentInstance .. '.Image = "' .. Object.Image .. '"')
   end
   if Check(Object, "ImageColor3") and typeof(Object.ImageColor3) == "Color3" then
      AddCode("\n" .. CurrentInstance .. ".ImageColor3 = Color3.new(" .. Object.ImageColor3.R .. ", " .. Object.ImageColor3.G .. ", " .. Object.ImageColor3.B .. ")")
   end
   if Check(Object, "ImageTransparency") and typeof(Object.ImageTransparency) == "number" then
      AddCode("\n" .. CurrentInstance .. ".ImageTransparency = " .. Object.ImageTransparency)
   end
   if Check(Object, "ScaleType") and typeof(Object.ScaleType) == "EnumItem" then
      AddCode("\n" .. CurrentInstance .. ".ScaleType = Enum." .. tostring(Object.ScaleType.EnumType) .. "." .. Object.ScaleType.Name)
   end
   if Check(Object, "CanvasSize") and typeof(Object.CanvasSize) == "UDim2" then
      AddCode("\n" .. CurrentInstance .. ".CanvasSize = UDim2.new(" .. Object.CanvasSize.X.Scale .. ", " .. Object.CanvasSize.X.Offset .. ", " .. Object.CanvasSize.Y.Scale .. ", " .. Object.CanvasSize.Y.Offset .. ")")
   end
   if Check(Object, "CanvasPosition") and typeof(Object.CanvasPosition) == "Vector2" then
      AddCode("\n" .. CurrentInstance .. ".CanvasPosition = Vector2.new(" .. Object.CanvasPosition.X .. ", " .. Object.CanvasPosition.Y .. ")")
   end
   if Check(Object, "ScrollBarThickness") and typeof(Object.ScrollBarThickness) == "number" then
      AddCode("\n" .. CurrentInstance .. ".ScrollBarThickness = " .. Object.ScrollBarThickness)
   end
   if Check(Object, "AnchorPoint") and typeof(Object.AnchorPoint) == "Vector2" then
      AddCode("\n" .. CurrentInstance .. ".AnchorPoint = Vector2.new(" .. Object.AnchorPoint.X .. ", " .. Object.AnchorPoint.Y .. ")")
   end
   if Check(Object, "AutomaticSize") and typeof(Object.AutomaticSize) == "EnumItem" then
      AddCode("\n" .. CurrentInstance .. ".AutomaticSize = Enum." .. tostring(Object.AutomaticSize.EnumType) .. "." .. Object.AutomaticSize.Name)
   end
   if Check(Object, "BorderMode") and typeof(Object.BorderMode) == "EnumItem" then
      AddCode("\n" .. CurrentInstance .. ".BorderMode = Enum." .. tostring(Object.BorderMode.EnumType) .. "." .. Object.BorderMode.Name)
   end
   if Check(Object, "BorderTransparency") and typeof(Object.BorderTransparency) == "number" then
      AddCode("\n" .. CurrentInstance .. ".BorderTransparency = " .. Object.BorderTransparency)
   end
   if Check(Object, "TextWrapped") and typeof(Object.TextWrapped) == "boolean" then
      AddCode("\n" .. CurrentInstance .. ".TextWrapped = " .. tostring(Object.TextWrapped))
   end
   if Check(Object, "MeshId") and typeof(Object.MeshId) == "string" then
      AddCode("\n" .. CurrentInstance .. '.MeshId = "' .. Object.MeshId .. '"')
   end
   if Check(Object, "TextureID") and typeof(Object.TextureID) == "string" then
      AddCode("\n" .. CurrentInstance .. '.TextureID = "' .. Object.TextureID .. '"')
   end
   if Check(Object, "RenderFidelity") and typeof(Object.RenderFidelity) == "EnumItem" then
      AddCode("\n" .. CurrentInstance .. ".RenderFidelity = Enum." .. tostring(Object.RenderFidelity.EnumType) .. "." .. Object.RenderFidelity.Name)
   end
   if Check(Object, "DoubleSided") and typeof(Object.DoubleSided) == "boolean" then
      AddCode("\n" .. CurrentInstance .. ".DoubleSided = " .. tostring(Object.DoubleSided))
   end
   if Check(Object, "StudsPerTileU") and typeof(Object.StudsPerTileU) == "number" then
      AddCode("\n" .. CurrentInstance .. ".StudsPerTileU = " .. Object.StudsPerTileU)
   end
   if Check(Object, "StudsPerTileV") and typeof(Object.StudsPerTileV) == "number" then
      AddCode("\n" .. CurrentInstance .. ".StudsPerTileV = " .. Object.StudsPerTileV)
   end
   if Check(Object, "FillColor") and typeof(Object.FillColor) == "Color3" then
      AddCode("\n" .. CurrentInstance .. ".FillColor = Color3.new(" .. Object.FillColor.R .. ", " .. Object.FillColor.G .. ", " .. Object.FillColor.B .. ")")
   end
   if Check(Object, "FillTransparency") and typeof(Object.FillTransparency) == "number" then
      AddCode("\n" .. CurrentInstance .. ".FillTransparency = " .. Object.FillTransparency)
   end
   if Check(Object, "OutlineColor") and typeof(Object.OutlineColor) == "Color3" then
      AddCode("\n" .. CurrentInstance .. ".OutlineColor = Color3.new(" .. Object.OutlineColor.R .. ", " .. Object.OutlineColor.G .. ", " .. Object.OutlineColor.B .. ")")
   end
   if Check(Object, "OutlineTransparency") and typeof(Object.OutlineTransparency) == "number" then
      AddCode("\n" .. CurrentInstance .. ".OutlineTransparency = " .. Object.OutlineTransparency)
   end
   if Check(Object, "DepthMode") and typeof(Object.DepthMode) == "EnumItem" then
      AddCode("\n" .. CurrentInstance .. ".DepthMode = Enum." .. tostring(Object.DepthMode.EnumType) .. "." .. Object.DepthMode.Name)
   end
   if Check(Object, "Thickness") and typeof(Object.Thickness) == "number" then
      AddCode("\n" .. CurrentInstance .. ".Thickness = " .. Object.Thickness)
   end
   if Check(Object, "ApplyStrokeMode") and typeof(Object.ApplyStrokeMode) == "EnumItem" then
      AddCode("\n" .. CurrentInstance .. ".ApplyStrokeMode = Enum.ApplyStrokeMode." .. Object.ApplyStrokeMode.Name)
   end
   if Check(Object, "LineJoinMode") and typeof(Object.LineJoinMode) == "EnumItem" then
      AddCode("\n" .. CurrentInstance .. ".LineJoinMode = Enum.LineJoinMode." .. Object.LineJoinMode.Name)
   end
   if Check(Object, "CornerRadius") and typeof(Object.CornerRadius) == "UDim" then
      AddCode("\n" .. CurrentInstance .. ".CornerRadius = UDim.new(" .. Object.CornerRadius.Scale .. ", " .. Object.CornerRadius.Offset .. ")")
   end
   if Check(Object, "Rotation") and typeof(Object.Rotation) == "number" then
      AddCode("\n" .. CurrentInstance .. ".Rotation = " .. Object.Rotation)
   end
   if Check(Object, "Rotation") and typeof(Object.Rotation) == "NumberRange" then
      AddCode("\n" .. CurrentInstance .. ".Rotation = NumberRange.new(" .. Object.Rotation.Min .. ", " .. Object.Rotation.Max .. ")")
   end
   if Check(Object, "Scale") and typeof(Object.Scale) == "number" then
      AddCode("\n" .. CurrentInstance .. ".Scale = " .. Object.Scale)
   end
   if Check(Object, "Offset") and typeof(Object.Offset) == "Vector2" then
      AddCode("\n" .. CurrentInstance .. ".Offset = Vector2.new(" .. Object.Offset.X .. ", " .. Object.Offset.Y .. ")")
   end
   if Check(Object, "MinLength") and typeof(Object.MinLength) == "number" then
      AddCode("\n" .. CurrentInstance .. ".MinLength = " .. Object.MinLength)
   end
   if Check(Object, "FaceCamera") and typeof(Object.FaceCamera) == "boolean" then
      AddCode("\n" .. CurrentInstance .. ".FaceCamera = " .. tostring(Object.FaceCamera))
   end
   if Check(Object, "Segments") and typeof(Object.Segments) == "number" then
      AddCode("\n" .. CurrentInstance .. ".Segments = " .. Object.Segments)
   end
   if Check(Object, "Width0") and typeof(Object.Width0) == "number" then
      AddCode("\n" .. CurrentInstance .. ".Width0 = " .. Object.Width0)
   end
   if Check(Object, "Width1") and typeof(Object.Width1) == "number" then
      AddCode("\n" .. CurrentInstance .. ".Width1 = " .. Object.Width1)
   end
   if Check(Object, "CurveSize0") and typeof(Object.CurveSize0) == "number" then
      AddCode("\n" .. CurrentInstance .. ".CurveSize0 = " .. Object.CurveSize0)
   end
   if Check(Object, "CurveSize1") and typeof(Object.CurveSize1) == "number" then
      AddCode("\n" .. CurrentInstance .. ".CurveSize1 = " .. Object.CurveSize1)
   end
   if Check(Object, "TextureLength") and typeof(Object.TextureLength) == "number" then
      AddCode("\n" .. CurrentInstance .. ".TextureLength = " .. Object.TextureLength)
   end
   if Check(Object, "TextureMode") and typeof(Object.TextureMode) == "EnumItem" then
      AddCode("\n" .. CurrentInstance .. ".TextureMode = Enum." .. tostring(Object.TextureMode.EnumType) .. "." .. Object.TextureMode.Name)
   end
   if Check(Object, "LightEmission") and typeof(Object.LightEmission) == "number" then
      AddCode("\n" .. CurrentInstance .. ".LightEmission = " .. Object.LightEmission)
   end
   if Check(Object, "LightInfluence") and typeof(Object.LightInfluence) == "number" then
      AddCode("\n" .. CurrentInstance .. ".LightInfluence = " .. Object.LightInfluence)
   end
   if Check(Object, "Range") and typeof(Object.Range) == "number" then
      AddCode("\n" .. CurrentInstance .. ".Range = " .. Object.Range)
   end
   if Check(Object, "Shadows") and typeof(Object.Shadows) == "boolean" then
      AddCode("\n" .. CurrentInstance .. ".Shadows = " .. tostring(Object.Shadows))
   end
   if Check(Object, "Brightness") and typeof(Object.Brightness) == "number" then
      AddCode("\n" .. CurrentInstance .. ".Brightness = " .. Object.Brightness)
   end
   if Check(Object, "LightColor") and typeof(Object.LightColor) == "Color3" then
      AddCode("\n" .. CurrentInstance .. ".LightColor = Color3.new(" .. Object.LightColor.R .. ", " .. Object.LightColor.G .. ", " .. Object.LightColor.B .. ")")
   end
   if Check(Object, "MaxActivationDistance") and typeof(Object.MaxActivationDistance) == "number" then
      AddCode("\n" .. CurrentInstance .. ".MaxActivationDistance = " .. Object.MaxActivationDistance)
   end
   if Check(Object, "HoldDuration") and typeof(Object.HoldDuration) == "number" then
      AddCode("\n" .. CurrentInstance .. ".HoldDuration = " .. Object.HoldDuration)
   end
   if Check(Object, "KeyboardKeyCode") and typeof(Object.KeyboardKeyCode) == "EnumItem" then
      AddCode("\n" .. CurrentInstance .. ".KeyboardKeyCode = Enum." .. tostring(Object.KeyboardKeyCode.EnumType) .. "." .. Object.KeyboardKeyCode.Name)
   end
   if Check(Object, "GamepadKeyCode") and typeof(Object.GamepadKeyCode) == "EnumItem" then
      AddCode("\n" .. CurrentInstance .. ".GamepadKeyCode = Enum." .. tostring(Object.GamepadKeyCode.EnumType) .. "." .. Object.GamepadKeyCode.Name)
   end
   if Check(Object, "MaxVisibleGuis") and typeof(Object.MaxVisibleGuis) == "number" then
      AddCode("\n" .. CurrentInstance .. ".MaxVisibleGuis = " .. Object.MaxVisibleGuis)
   end
   if Check(Object, "ResetOnSpawn") and typeof(Object.ResetOnSpawn) == "boolean" then
      AddCode("\n" .. CurrentInstance .. ".ResetOnSpawn = " .. tostring(Object.ResetOnSpawn))
   end
   if Check(Object, "IgnoreGuiInset") and typeof(Object.IgnoreGuiInset) == "boolean" then
      AddCode("\n" .. CurrentInstance .. ".IgnoreGuiInset = " .. tostring(Object.IgnoreGuiInset))
   end
   if Check(Object, "DisplayOrder") and typeof(Object.DisplayOrder) == "number" then
      AddCode("\n" .. CurrentInstance .. ".DisplayOrder = " .. Object.DisplayOrder)
   end
   if Check(Object, "PaddingLeft") and typeof(Object.PaddingLeft) == "UDim" then
      AddCode("\n" .. CurrentInstance .. ".PaddingLeft = UDim.new(" .. Object.PaddingLeft.Scale .. ", " .. Object.PaddingLeft.Offset .. ")")
   end
   if Check(Object, "PaddingRight") and typeof(Object.PaddingRight) == "UDim" then
      AddCode("\n" .. CurrentInstance .. ".PaddingRight = UDim.new(" .. Object.PaddingRight.Scale .. ", " .. Object.PaddingRight.Offset .. ")")
   end
   if Check(Object, "PaddingTop") and typeof(Object.PaddingTop) == "UDim" then
      AddCode("\n" .. CurrentInstance .. ".PaddingTop = UDim.new(" .. Object.PaddingTop.Scale .. ", " .. Object.PaddingTop.Offset .. ")")
   end
   if Check(Object, "PaddingBottom") and typeof(Object.PaddingBottom) == "UDim" then
      AddCode("\n" .. CurrentInstance .. ".PaddingBottom = UDim.new(" .. Object.PaddingBottom.Scale .. ", " .. Object.PaddingBottom.Offset .. ")")
   end
   if Check(Object, "AspectRatio") and typeof(Object.AspectRatio) == "number" then
      AddCode("\n" .. CurrentInstance .. ".AspectRatio = " .. Object.AspectRatio)
   end
   if Check(Object, "DominantAxis") and typeof(Object.DominantAxis) == "EnumItem" then
      AddCode("\n" .. CurrentInstance .. ".DominantAxis = Enum." .. tostring(Object.DominantAxis.EnumType) .. "." .. Object.DominantAxis.Name)
   end
   if Check(Object, "PrimaryAxis") and typeof(Object.PrimaryAxis) == "Vector3" then
      AddCode("\n" .. CurrentInstance .. ".PrimaryAxis = Vector3.new(" .. Object.PrimaryAxis.X .. ", " .. Object.PrimaryAxis.Y .. ", " .. Object.PrimaryAxis.Z .. ")")
   end
   if Check(Object, "MinSize") and typeof(Object.MinSize) == "Vector2" then
      AddCode("\n" .. CurrentInstance .. ".MinSize = Vector2.new(" .. Object.MinSize.X .. ", " .. Object.MinSize.Y .. ")")
   end
   if Check(Object, "MaxSize") and typeof(Object.MaxSize) == "Vector2" then
      AddCode("\n" .. CurrentInstance .. ".MaxSize = Vector2.new(" .. Object.MaxSize.X .. ", " .. Object.MaxSize.Y .. ")")
   end
   if Check(Object, "MinTextSize") and typeof(Object.MinTextSize) == "number" then
      AddCode("\n" .. CurrentInstance .. ".MinTextSize = " .. Object.MinTextSize)
   end
   if Check(Object, "MaxTextSize") and typeof(Object.MaxTextSize) == "number" then
      AddCode("\n" .. CurrentInstance .. ".MaxTextSize = " .. Object.MaxTextSize)
   end
   if Check(Object, "Disabled") and typeof(Object.Disabled) == "boolean" then
      AddCode("\n" .. CurrentInstance .. ".Disabled = " .. tostring(Object.Disabled))
   end
   if Check(Object, "RichText") and typeof(Object.RichText) == "boolean" then
      AddCode("\n" .. CurrentInstance .. ".RichText = " .. tostring(Object.RichText))
   end
   if Check(Object, "LineHeight") and typeof(Object.LineHeight) == "number" then
      AddCode("\n" .. CurrentInstance .. ".LineHeight = " .. Object.LineHeight)
   end
   if Check(Object, "TextDirection") and typeof(Object.TextDirection) == "EnumItem" then
      AddCode("\n" .. CurrentInstance .. ".TextDirection = Enum." .. tostring(Object.TextDirection.EnumType) .. "." .. Object.TextDirection.Name)
   end
   if Check(Object, "TextTruncate") and typeof(Object.TextTruncate) == "EnumItem" then
      AddCode("\n" .. CurrentInstance .. ".TextTruncate = Enum." .. tostring(Object.TextTruncate.EnumType) .. "." .. Object.TextTruncate.Name)
   end
   if Check(Object, "MaxVisibleGraphemes") and typeof(Object.MaxVisibleGraphemes) == "number" then
      AddCode("\n" .. CurrentInstance .. ".MaxVisibleGraphemes = " .. Object.MaxVisibleGraphemes)
   end
   if Check(Object, "FontFace") and typeof(Object.FontFace) == "Font" then
      AddCode("\n" .. CurrentInstance .. '.FontFace = Font.new("' .. tostring(Object.FontFace.Family) .. '", Enum.FontWeight.' .. Object.FontFace.Weight.Name .. ", Enum.FontStyle." .. Object.FontFace.Style.Name .. ")")
   end
   if Check(Object, "ImageRectOffset") and typeof(Object.ImageRectOffset) == "Vector2" then
      AddCode("\n" .. CurrentInstance .. ".ImageRectOffset = Vector2.new(" .. Object.ImageRectOffset.X .. ", " .. Object.ImageRectOffset.Y .. ")")
   end
   if Check(Object, "ImageRectSize") and typeof(Object.ImageRectSize) == "Vector2" then
      AddCode("\n" .. CurrentInstance .. ".ImageRectSize = Vector2.new(" .. Object.ImageRectSize.X .. ", " .. Object.ImageRectSize.Y .. ")")
   end
   if Check(Object, "SliceScale") and typeof(Object.SliceScale) == "number" then
      AddCode("\n" .. CurrentInstance .. ".SliceScale = " .. Object.SliceScale)
   end
   if Check(Object, "TileSize") and typeof(Object.TileSize) == "UDim2" then
      AddCode("\n" .. CurrentInstance .. ".TileSize = UDim2.new(" .. Object.TileSize.X.Scale .. ", " .. Object.TileSize.X.Offset .. ", " .. Object.TileSize.Y.Scale .. ", " .. Object.TileSize.Y.Offset .. ")")
   end
   if Check(Object, "ScrollBarImageColor3") and typeof(Object.ScrollBarImageColor3) == "Color3" then
      AddCode("\n" .. CurrentInstance .. ".ScrollBarImageColor3 = Color3.new(" .. Object.ScrollBarImageColor3.R .. ", " .. Object.ScrollBarImageColor3.G .. ", " .. Object.ScrollBarImageColor3.B .. ")")
   end
   if Check(Object, "ScrollBarImageTransparency") and typeof(Object.ScrollBarImageTransparency) == "number" then
      AddCode("\n" .. CurrentInstance .. ".ScrollBarImageTransparency = " .. Object.ScrollBarImageTransparency)
   end
   if Check(Object, "ScrollingDirection") and typeof(Object.ScrollingDirection) == "EnumItem" then
      AddCode("\n" .. CurrentInstance .. ".ScrollingDirection = Enum." .. tostring(Object.ScrollingDirection.EnumType) .. "." .. Object.ScrollingDirection.Name)
   end
   if Check(Object, "ScrollingEnabled") and typeof(Object.ScrollingEnabled) == "boolean" then
      AddCode("\n" .. CurrentInstance .. ".ScrollingEnabled = " .. tostring(Object.ScrollingEnabled))
   end
   if Check(Object, "ElasticBehavior") and typeof(Object.ElasticBehavior) == "EnumItem" then
      AddCode("\n" .. CurrentInstance .. ".ElasticBehavior = Enum." .. tostring(Object.ElasticBehavior.EnumType) .. "." .. Object.ElasticBehavior.Name)
   end
   if Check(Object, "AlwaysOnTop") and typeof(Object.AlwaysOnTop) == "boolean" then
      AddCode("\n" .. CurrentInstance .. ".AlwaysOnTop = " .. tostring(Object.AlwaysOnTop))
   end
   if Check(Object, "MaxDistance") and typeof(Object.MaxDistance) == "number" then
      AddCode("\n" .. CurrentInstance .. ".MaxDistance = " .. Object.MaxDistance)
   end
   if Check(Object, "PixelsPerStud") and typeof(Object.PixelsPerStud) == "number" then
      AddCode("\n" .. CurrentInstance .. ".PixelsPerStud = " .. Object.PixelsPerStud)
   end
   if Check(Object, "SizingMode") and typeof(Object.SizingMode) == "EnumItem" then
      AddCode("\n" .. CurrentInstance .. ".SizingMode = Enum." .. tostring(Object.SizingMode.EnumType) .. "." .. Object.SizingMode.Name)
   end
   if Check(Object, "ZOffset") and typeof(Object.ZOffset) == "number" then
      AddCode("\n" .. CurrentInstance .. ".ZOffset = " .. Object.ZOffset)
   end
   if Check(Object, "TextureSpeed") and typeof(Object.TextureSpeed) == "number" then
      AddCode("\n" .. CurrentInstance .. ".TextureSpeed = " .. Object.TextureSpeed)
   end
   if Check(Object, "LocalTransparencyModifier") and typeof(Object.LocalTransparencyModifier) == "number" then
      AddCode("\n" .. CurrentInstance .. ".LocalTransparencyModifier = " .. Object.LocalTransparencyModifier)
   end
   if Check(Object, "ObjectText") and typeof(Object.ObjectText) == "string" then
      AddCode("\n" .. CurrentInstance .. '.ObjectText = "' .. Object.ObjectText .. '"')
   end
   if Check(Object, "ActionText") and typeof(Object.ActionText) == "string" then
      AddCode("\n" .. CurrentInstance .. '.ActionText = "' .. Object.ActionText .. '"')
   end
   if Check(Object, "RequiresLineOfSight") and typeof(Object.RequiresLineOfSight) == "boolean" then
      AddCode("\n" .. CurrentInstance .. ".RequiresLineOfSight = " .. tostring(Object.RequiresLineOfSight))
   end
   if Check(Object, "ClickablePrompt") and typeof(Object.ClickablePrompt) == "boolean" then
      AddCode("\n" .. CurrentInstance .. ".ClickablePrompt = " .. tostring(Object.ClickablePrompt))
   end
   if Check(Object, "Exclusivity") and typeof(Object.Exclusivity) == "EnumItem" then
      AddCode("\n" .. CurrentInstance .. ".Exclusivity = Enum." .. tostring(Object.Exclusivity.EnumType) .. "." .. Object.Exclusivity.Name)
   end
   if Check(Object, "Style") and typeof(Object.Style) == "EnumItem" then
      AddCode("\n" .. CurrentInstance .. ".Style = Enum." .. tostring(Object.Style.EnumType) .. "." .. Object.Style.Name)
   end
   if Check(Object, "MaxIndicatorDistance") and typeof(Object.MaxIndicatorDistance) == "number" then
      AddCode("\n" .. CurrentInstance .. ".MaxIndicatorDistance = " .. Object.MaxIndicatorDistance)
   end
   if Check(Object, "CursorIcon") and typeof(Object.CursorIcon) == "string" then
      AddCode("\n" .. CurrentInstance .. '.CursorIcon = "' .. Object.CursorIcon .. '"')
   end
   if Check(Object, "Acceleration") and typeof(Object.Acceleration) == "Vector3" then
      AddCode("\n" .. CurrentInstance .. ".Acceleration = Vector3.new(" .. Object.Acceleration.X .. ", " .. Object.Acceleration.Y .. ", " .. Object.Acceleration.Z .. ")")
   end
   if Check(Object, "Drag") and typeof(Object.Drag) == "number" then
      AddCode("\n" .. CurrentInstance .. ".Drag = " .. Object.Drag)
   end
   if Check(Object, "EmissionDirection") and typeof(Object.EmissionDirection) == "EnumItem" then
      AddCode("\n" .. CurrentInstance .. ".EmissionDirection = Enum." .. tostring(Object.EmissionDirection.EnumType) .. "." .. Object.EmissionDirection.Name)
   end
   if Check(Object, "LockedToPart") and typeof(Object.LockedToPart) == "boolean" then
      AddCode("\n" .. CurrentInstance .. ".LockedToPart = " .. tostring(Object.LockedToPart))
   end
   if Check(Object, "Orientation") and typeof(Object.Orientation) == "EnumItem" then
      AddCode("\n" .. CurrentInstance .. ".Orientation = Enum." .. tostring(Object.Orientation.EnumType) .. "." .. Object.Orientation.Name)
   end
   if Check(Object, "RotSpeed") and typeof(Object.RotSpeed) == "NumberRange" then
      AddCode("\n" .. CurrentInstance .. ".RotSpeed = NumberRange.new(" .. Object.RotSpeed.Min .. ", " .. Object.RotSpeed.Max .. ")")
   end
   if Check(Object, "ShapeInOut") and typeof(Object.ShapeInOut) == "EnumItem" then
      AddCode("\n" .. CurrentInstance .. ".ShapeInOut = Enum." .. tostring(Object.ShapeInOut.EnumType) .. "." .. Object.ShapeInOut.Name)
   end
   if Check(Object, "ShapePartial") and typeof(Object.ShapePartial) == "number" then
      AddCode("\n" .. CurrentInstance .. ".ShapePartial = " .. Object.ShapePartial)
   end
   if Check(Object, "ShapeStyle") and typeof(Object.ShapeStyle) == "EnumItem" then
      AddCode("\n" .. CurrentInstance .. ".ShapeStyle = Enum." .. tostring(Object.ShapeStyle.EnumType) .. "." .. Object.ShapeStyle.Name)
   end
   if Check(Object, "Squash") and typeof(Object.Squash) == "NumberSequence" then
      local Keypoints = {}
      for _, v in Object.Squash.Keypoints do
         Keypoints[#Keypoints + 1] = "NumberSequenceKeypoint.new(" .. v.Time .. ", " .. v.Value .. ", " .. v.Envelope .. ")"
      end
      AddCode("\n" .. CurrentInstance .. ".Squash = NumberSequence.new({" .. table.concat(Keypoints, ", ") .. "})")
   end
   if Check(Object, "TimeScale") and typeof(Object.TimeScale) == "number" then
      AddCode("\n" .. CurrentInstance .. ".TimeScale = " .. Object.TimeScale)
   end
   if Check(Object, "VelocityInheritance") and typeof(Object.VelocityInheritance) == "number" then
      AddCode("\n" .. CurrentInstance .. ".VelocityInheritance = " .. Object.VelocityInheritance)
   end
   if Check(Object, "WindAffectsDrag") and typeof(Object.WindAffectsDrag) == "boolean" then
      AddCode("\n" .. CurrentInstance .. ".WindAffectsDrag = " .. tostring(Object.WindAffectsDrag))
   end
   if Check(Object, "FlipbookBlendFrames") and typeof(Object.FlipbookBlendFrames) == "boolean" then
      AddCode("\n" .. CurrentInstance .. ".FlipbookBlendFrames = " .. tostring(Object.FlipbookBlendFrames))
   end
   if Check(Object, "FlipbookFramerate") and typeof(Object.FlipbookFramerate) == "NumberRange" then
      AddCode("\n" .. CurrentInstance .. ".FlipbookFramerate = NumberRange.new(" .. Object.FlipbookFramerate.Min .. ", " .. Object.FlipbookFramerate.Max .. ")")
   end
   if Check(Object, "FlipbookLayout") and typeof(Object.FlipbookLayout) == "EnumItem" then
      AddCode("\n" .. CurrentInstance .. ".FlipbookLayout = Enum." .. tostring(Object.FlipbookLayout.EnumType) .. "." .. Object.FlipbookLayout.Name)
   end
   if Check(Object, "FlipbookMode") and typeof(Object.FlipbookMode) == "EnumItem" then
      AddCode("\n" .. CurrentInstance .. ".FlipbookMode = Enum." .. tostring(Object.FlipbookMode.EnumType) .. "." .. Object.FlipbookMode.Name)
   end
   if Check(Object, "FlipbookSizeX") and typeof(Object.FlipbookSizeX) == "number" then
      AddCode("\n" .. CurrentInstance .. ".FlipbookSizeX = " .. Object.FlipbookSizeX)
   end
   if Check(Object, "FlipbookSizeY") and typeof(Object.FlipbookSizeY) == "number" then
      AddCode("\n" .. CurrentInstance .. ".FlipbookSizeY = " .. Object.FlipbookSizeY)
   end
   if Check(Object, "FlipbookStartRandom") and typeof(Object.FlipbookStartRandom) == "boolean" then
      AddCode("\n" .. CurrentInstance .. ".FlipbookStartRandom = " .. tostring(Object.FlipbookStartRandom))
   end
   if Check(Object, "AutoLocalize") and typeof(Object.AutoLocalize) == "boolean" then
      AddCode("\n" .. CurrentInstance .. ".AutoLocalize = " .. tostring(Object.AutoLocalize))
   end
   if Check(Object, "Color3") and typeof(Object.Color3) == "Color3" then
      AddCode("\n" .. CurrentInstance .. ".Color3 = Color3.new(" .. Object.Color3.R .. ", " .. Object.Color3.G .. ", " .. Object.Color3.B .. ")")
   end
   if Check(Object, "UVOffset") and typeof(Object.UVOffset) == "Vector2" then
      AddCode("\n" .. CurrentInstance .. ".UVOffset = Vector2.new(" .. Object.UVOffset.X .. ", " .. Object.UVOffset.Y .. ")")
   end
   if Check(Object, "UVScale") and typeof(Object.UVScale) == "Vector2" then
      AddCode("\n" .. CurrentInstance .. ".UVScale = Vector2.new(" .. Object.UVScale.X .. ", " .. Object.UVScale.Y .. ")")
   end
   if Check(Object, "OffsetStudsU") and typeof(Object.OffsetStudsU) == "number" then
      AddCode("\n" .. CurrentInstance .. ".OffsetStudsU = " .. Object.OffsetStudsU)
   end
   if Check(Object, "OffsetStudsV") and typeof(Object.OffsetStudsV) == "number" then
      AddCode("\n" .. CurrentInstance .. ".OffsetStudsV = " .. Object.OffsetStudsV)
   end
   if Check(Object, "ToolPunchThroughDistance") and typeof(Object.ToolPunchThroughDistance) == "number" then
      AddCode("\n" .. CurrentInstance .. ".ToolPunchThroughDistance = " .. Object.ToolPunchThroughDistance)
   end
   if Check(Object, "ActuatorType") and typeof(Object.ActuatorType) == "EnumItem" then
      AddCode("\n" .. CurrentInstance .. ".ActuatorType = Enum." .. tostring(Object.ActuatorType.EnumType) .. "." .. Object.ActuatorType.Name)
   end
   if Check(Object, "AngularResponsiveness") and typeof(Object.AngularResponsiveness) == "number" then
      AddCode("\n" .. CurrentInstance .. ".AngularResponsiveness = " .. Object.AngularResponsiveness)
   end
   if Check(Object, "AngularSpeed") and typeof(Object.AngularSpeed) == "number" then
      AddCode("\n" .. CurrentInstance .. ".AngularSpeed = " .. Object.AngularSpeed)
   end
   if Check(Object, "AngularVelocity") and typeof(Object.AngularVelocity) == "number" then
      AddCode("\n" .. CurrentInstance .. ".AngularVelocity = " .. Object.AngularVelocity)
   end
   if Check(Object, "LowerAngle") and typeof(Object.LowerAngle) == "number" then
      AddCode("\n" .. CurrentInstance .. ".LowerAngle = " .. Object.LowerAngle)
   end
   if Check(Object, "MotorMaxAcceleration") and typeof(Object.MotorMaxAcceleration) == "number" then
      AddCode("\n" .. CurrentInstance .. ".MotorMaxAcceleration = " .. Object.MotorMaxAcceleration)
   end
   if Check(Object, "MotorMaxTorque") and typeof(Object.MotorMaxTorque) == "number" then
      AddCode("\n" .. CurrentInstance .. ".MotorMaxTorque = " .. Object.MotorMaxTorque)
   end
   if Check(Object, "Radius") and typeof(Object.Radius) == "number" then
      AddCode("\n" .. CurrentInstance .. ".Radius = " .. Object.Radius)
   end
   if Check(Object, "Restitution") and typeof(Object.Restitution) == "number" then
      AddCode("\n" .. CurrentInstance .. ".Restitution = " .. Object.Restitution)
   end
   if Check(Object, "ServoMaxTorque") and typeof(Object.ServoMaxTorque) == "number" then
      AddCode("\n" .. CurrentInstance .. ".ServoMaxTorque = " .. Object.ServoMaxTorque)
   end
   if Check(Object, "TargetAngle") and typeof(Object.TargetAngle) == "number" then
      AddCode("\n" .. CurrentInstance .. ".TargetAngle = " .. Object.TargetAngle)
   end
   if Check(Object, "UpperAngle") and typeof(Object.UpperAngle) == "number" then
      AddCode("\n" .. CurrentInstance .. ".UpperAngle = " .. Object.UpperAngle)
   end
   if Check(Object, "MaxFrictionTorque") and typeof(Object.MaxFrictionTorque) == "number" then
      AddCode("\n" .. CurrentInstance .. ".MaxFrictionTorque = " .. Object.MaxFrictionTorque)
   end
   if Check(Object, "TwistLimitsEnabled") and typeof(Object.TwistLimitsEnabled) == "boolean" then
      AddCode("\n" .. CurrentInstance .. ".TwistLimitsEnabled = " .. tostring(Object.TwistLimitsEnabled))
   end
   if Check(Object, "TwistLowerAngle") and typeof(Object.TwistLowerAngle) == "number" then
      AddCode("\n" .. CurrentInstance .. ".TwistLowerAngle = " .. Object.TwistLowerAngle)
   end
   if Check(Object, "TwistUpperAngle") and typeof(Object.TwistUpperAngle) == "number" then
      AddCode("\n" .. CurrentInstance .. ".TwistUpperAngle = " .. Object.TwistUpperAngle)
   end
   if Check(Object, "Size") and typeof(Object.Size) == "NumberSequence" then
      local Keypoints = {}
      for _, v in Object.Size.Keypoints do
         Keypoints[#Keypoints + 1] = "NumberSequenceKeypoint.new(" .. v.Time .. ", " .. v.Value .. ", " .. v.Envelope .. ")"
      end
      AddCode("\n" .. CurrentInstance .. ".Size = NumberSequence.new({" .. table.concat(Keypoints, ", ") .. "})")
   end
   if Check(Object, "AudioCanCollide") and typeof(Object.AudioCanCollide) == "boolean" then
      AddCode("\n" .. CurrentInstance .. ".AudioCanCollide = " .. tostring(Object.AudioCanCollide))
   end
   if Check(Object, "EnableFluidForces") and typeof(Object.EnableFluidForces) == "boolean" then
      AddCode("\n" .. CurrentInstance .. ".EnableFluidForces = " .. tostring(Object.EnableFluidForces))
   end
   if Check(Object, "RootPriority") and typeof(Object.RootPriority) == "number" then
      AddCode("\n" .. CurrentInstance .. ".RootPriority = " .. Object.RootPriority)
   end
   if Check(Object, "LevelOfDetail") and typeof(Object.LevelOfDetail) == "EnumItem" then
      AddCode("\n" .. CurrentInstance .. ".LevelOfDetail = Enum." .. tostring(Object.LevelOfDetail.EnumType) .. "." .. Object.LevelOfDetail.Name)
   end
   if Check(Object, "ModelStreamingMode") and typeof(Object.ModelStreamingMode) == "EnumItem" then
      AddCode("\n" .. CurrentInstance .. ".ModelStreamingMode = Enum." .. tostring(Object.ModelStreamingMode.EnumType) .. "." .. Object.ModelStreamingMode.Name)
   end
   if Check(Object, "WalkSpeed") and typeof(Object.WalkSpeed) == "number" then
      AddCode("\n" .. CurrentInstance .. ".WalkSpeed = " .. Object.WalkSpeed)
   end
   if Check(Object, "JumpPower") and typeof(Object.JumpPower) == "number" then
      AddCode("\n" .. CurrentInstance .. ".JumpPower = " .. Object.JumpPower)
   end
   if Check(Object, "JumpHeight") and typeof(Object.JumpHeight) == "number" then
      AddCode("\n" .. CurrentInstance .. ".JumpHeight = " .. Object.JumpHeight)
   end
   if Check(Object, "UseJumpPower") and typeof(Object.UseJumpPower) == "boolean" then
      AddCode("\n" .. CurrentInstance .. ".UseJumpPower = " .. tostring(Object.UseJumpPower))
   end
   if Check(Object, "HipHeight") and typeof(Object.HipHeight) == "number" then
      AddCode("\n" .. CurrentInstance .. ".HipHeight = " .. Object.HipHeight)
   end
   if Check(Object, "MaxHealth") and typeof(Object.MaxHealth) == "number" then
      AddCode("\n" .. CurrentInstance .. ".MaxHealth = " .. Object.MaxHealth)
   end
   if Check(Object, "Health") and typeof(Object.Health) == "number" then
      AddCode("\n" .. CurrentInstance .. ".Health = " .. Object.Health)
   end
   if Check(Object, "AutoRotate") and typeof(Object.AutoRotate) == "boolean" then
      AddCode("\n" .. CurrentInstance .. ".AutoRotate = " .. tostring(Object.AutoRotate))
   end
   if Check(Object, "BreakJointsOnDeath") and typeof(Object.BreakJointsOnDeath) == "boolean" then
      AddCode("\n" .. CurrentInstance .. ".BreakJointsOnDeath = " .. tostring(Object.BreakJointsOnDeath))
   end
   if Check(Object, "RequiresNeck") and typeof(Object.RequiresNeck) == "boolean" then
      AddCode("\n" .. CurrentInstance .. ".RequiresNeck = " .. tostring(Object.RequiresNeck))
   end
   if Check(Object, "DisplayName") and typeof(Object.DisplayName) == "string" then
      AddCode("\n" .. CurrentInstance .. '.DisplayName = "' .. Object.DisplayName .. '"')
   end
   if Check(Object, "MaxSlopeAngle") and typeof(Object.MaxSlopeAngle) == "number" then
      AddCode("\n" .. CurrentInstance .. ".MaxSlopeAngle = " .. Object.MaxSlopeAngle)
   end
   if Check(Object, "CameraOffset") and typeof(Object.CameraOffset) == "Vector3" then
      AddCode("\n" .. CurrentInstance .. ".CameraOffset = Vector3.new(" .. Object.CameraOffset.X .. ", " .. Object.CameraOffset.Y .. ", " .. Object.CameraOffset.Z .. ")")
   end
   if Check(Object, "PlatformStand") and typeof(Object.PlatformStand) == "boolean" then
      AddCode("\n" .. CurrentInstance .. ".PlatformStand = " .. tostring(Object.PlatformStand))
   end
   if Check(Object, "AutoJumpEnabled") and typeof(Object.AutoJumpEnabled) == "boolean" then
      AddCode("\n" .. CurrentInstance .. ".AutoJumpEnabled = " .. tostring(Object.AutoJumpEnabled))
   end
   if Check(Object, "AutomaticScalingEnabled") and typeof(Object.AutomaticScalingEnabled) == "boolean" then
      AddCode("\n" .. CurrentInstance .. ".AutomaticScalingEnabled = " .. tostring(Object.AutomaticScalingEnabled))
   end
   if Check(Object, "PlaybackRegionsEnabled") and typeof(Object.PlaybackRegionsEnabled) == "boolean" then
      AddCode("\n" .. CurrentInstance .. ".PlaybackRegionsEnabled = " .. tostring(Object.PlaybackRegionsEnabled))
   end
   if Check(Object, "PlaybackRegion") and typeof(Object.PlaybackRegion) == "NumberRange" then
      AddCode("\n" .. CurrentInstance .. ".PlaybackRegion = NumberRange.new(" .. Object.PlaybackRegion.Min .. ", " .. Object.PlaybackRegion.Max .. ")")
   end
   if Check(Object, "LoopRegion") and typeof(Object.LoopRegion) == "NumberRange" then
      AddCode("\n" .. CurrentInstance .. ".LoopRegion = NumberRange.new(" .. Object.LoopRegion.Min .. ", " .. Object.LoopRegion.Max .. ")")
   end
   if Check(Object, "RollOffMaxDistance") and typeof(Object.RollOffMaxDistance) == "number" then
      AddCode("\n" .. CurrentInstance .. ".RollOffMaxDistance = " .. Object.RollOffMaxDistance)
   end
   if Check(Object, "RollOffMinDistance") and typeof(Object.RollOffMinDistance) == "number" then
      AddCode("\n" .. CurrentInstance .. ".RollOffMinDistance = " .. Object.RollOffMinDistance)
   end
   if Check(Object, "RollOffMode") and typeof(Object.RollOffMode) == "EnumItem" then
      AddCode("\n" .. CurrentInstance .. ".RollOffMode = Enum.RollOffMode." .. Object.RollOffMode.Name)
   end
   if Check(Object, "PlayOnRemove") and typeof(Object.PlayOnRemove) == "boolean" then
      AddCode("\n" .. CurrentInstance .. ".PlayOnRemove = " .. tostring(Object.PlayOnRemove))
   end
   if Check(Object, "ClearTextOnFocus") and typeof(Object.ClearTextOnFocus) == "boolean" then
      AddCode("\n" .. CurrentInstance .. ".ClearTextOnFocus = " .. tostring(Object.ClearTextOnFocus))
   end
   if Check(Object, "MultiLine") and typeof(Object.MultiLine) == "boolean" then
      AddCode("\n" .. CurrentInstance .. ".MultiLine = " .. tostring(Object.MultiLine))
   end
   if Check(Object, "PlaceholderColor3") and typeof(Object.PlaceholderColor3) == "Color3" then
      AddCode("\n" .. CurrentInstance .. ".PlaceholderColor3 = Color3.new(" .. Object.PlaceholderColor3.R .. ", " .. Object.PlaceholderColor3.G .. ", " .. Object.PlaceholderColor3.B .. ")")
   end
   if Check(Object, "PlaceholderText") and typeof(Object.PlaceholderText) == "string" then
      AddCode("\n" .. CurrentInstance .. '.PlaceholderText = "' .. Object.PlaceholderText .. '"')
   end
   if Check(Object, "TextEditable") and typeof(Object.TextEditable) == "boolean" then
      AddCode("\n" .. CurrentInstance .. ".TextEditable = " .. tostring(Object.TextEditable))
   end
   if Check(Object, "ShowNativeInput") and typeof(Object.ShowNativeInput) == "boolean" then
      AddCode("\n" .. CurrentInstance .. ".ShowNativeInput = " .. tostring(Object.ShowNativeInput))
   end
   if Check(Object, "OpenTypeFeatures") and typeof(Object.OpenTypeFeatures) == "string" then
      AddCode("\n" .. CurrentInstance .. '.OpenTypeFeatures = "' .. Object.OpenTypeFeatures .. '"')
   end
   if Check(Object, "Interactable") and typeof(Object.Interactable) == "boolean" then
      AddCode("\n" .. CurrentInstance .. ".Interactable = " .. tostring(Object.Interactable))
   end
   if Check(Object, "SelectionOrder") and typeof(Object.SelectionOrder) == "number" then
      AddCode("\n" .. CurrentInstance .. ".SelectionOrder = " .. Object.SelectionOrder)
   end
   if Check(Object, "SizeConstraint") and typeof(Object.SizeConstraint) == "EnumItem" then
      AddCode("\n" .. CurrentInstance .. ".SizeConstraint = Enum." .. tostring(Object.SizeConstraint.EnumType) .. "." .. Object.SizeConstraint.Name)
   end
   if Check(Object, "AutomaticCanvasSize") and typeof(Object.AutomaticCanvasSize) == "EnumItem" then
      AddCode("\n" .. CurrentInstance .. ".AutomaticCanvasSize = Enum." .. tostring(Object.AutomaticCanvasSize.EnumType) .. "." .. Object.AutomaticCanvasSize.Name)
   end
   if Check(Object, "HorizontalScrollBarInset") and typeof(Object.HorizontalScrollBarInset) == "EnumItem" then
      AddCode("\n" .. CurrentInstance .. ".HorizontalScrollBarInset = Enum." .. tostring(Object.HorizontalScrollBarInset.EnumType) .. "." .. Object.HorizontalScrollBarInset.Name)
   end
   if Check(Object, "VerticalScrollBarInset") and typeof(Object.VerticalScrollBarInset) == "EnumItem" then
      AddCode("\n" .. CurrentInstance .. ".VerticalScrollBarInset = Enum." .. tostring(Object.VerticalScrollBarInset.EnumType) .. "." .. Object.VerticalScrollBarInset.Name)
   end
   if Check(Object, "VerticalScrollBarPosition") and typeof(Object.VerticalScrollBarPosition) == "EnumItem" then
      AddCode("\n" .. CurrentInstance .. ".VerticalScrollBarPosition = Enum." .. tostring(Object.VerticalScrollBarPosition.EnumType) .. "." .. Object.VerticalScrollBarPosition.Name)
   end
   if Check(Object, "AlphaMode") and typeof(Object.AlphaMode) == "EnumItem" then
      AddCode("\n" .. CurrentInstance .. ".AlphaMode = Enum." .. tostring(Object.AlphaMode.EnumType) .. "." .. Object.AlphaMode.Name)
   end
   if Check(Object, "EmissiveStrength") and typeof(Object.EmissiveStrength) == "number" then
      AddCode("\n" .. CurrentInstance .. ".EmissiveStrength = " .. Object.EmissiveStrength)
   end
   if Check(Object, "EmissiveTint") and typeof(Object.EmissiveTint) == "Color3" then
      AddCode("\n" .. CurrentInstance .. ".EmissiveTint = Color3.new(" .. Object.EmissiveTint.R .. ", " .. Object.EmissiveTint.G .. ", " .. Object.EmissiveTint.B .. ")")
   end
   if Check(Object, "ResampleMode") and typeof(Object.ResampleMode) == "EnumItem" then
      AddCode("\n" .. CurrentInstance .. ".ResampleMode = Enum." .. tostring(Object.ResampleMode.EnumType) .. "." .. Object.ResampleMode.Name)
   end
   if Check(Object, "StudsOffset") and typeof(Object.StudsOffset) == "Vector3" then
      AddCode("\n" .. CurrentInstance .. ".StudsOffset = Vector3.new(" .. Object.StudsOffset.X .. ", " .. Object.StudsOffset.Y .. ", " .. Object.StudsOffset.Z .. ")")
   end
   if Check(Object, "StudsOffsetWorldSpace") and typeof(Object.StudsOffsetWorldSpace) == "Vector3" then
      AddCode("\n" .. CurrentInstance .. ".StudsOffsetWorldSpace = Vector3.new(" .. Object.StudsOffsetWorldSpace.X .. ", " .. Object.StudsOffsetWorldSpace.Y .. ", " .. Object.StudsOffsetWorldSpace.Z .. ")")
   end
   if Check(Object, "ExtentsOffset") and typeof(Object.ExtentsOffset) == "Vector3" then
      AddCode("\n" .. CurrentInstance .. ".ExtentsOffset = Vector3.new(" .. Object.ExtentsOffset.X .. ", " .. Object.ExtentsOffset.Y .. ", " .. Object.ExtentsOffset.Z .. ")")
   end
   if Check(Object, "ExtentsOffsetWorldSpace") and typeof(Object.ExtentsOffsetWorldSpace) == "Vector3" then
      AddCode("\n" .. CurrentInstance .. ".ExtentsOffsetWorldSpace = Vector3.new(" .. Object.ExtentsOffsetWorldSpace.X .. ", " .. Object.ExtentsOffsetWorldSpace.Y .. ", " .. Object.ExtentsOffsetWorldSpace.Z .. ")")
   end
   if Check(Object, "SizeOffset") and typeof(Object.SizeOffset) == "Vector2" then
      AddCode("\n" .. CurrentInstance .. ".SizeOffset = Vector2.new(" .. Object.SizeOffset.X .. ", " .. Object.SizeOffset.Y .. ")")
   end
   if Check(Object, "TopLeftRadius") and typeof(Object.TopLeftRadius) == "UDim" then
      AddCode("\n" .. CurrentInstance .. ".TopLeftRadius = UDim.new(" .. Object.TopLeftRadius.Scale .. ", " .. Object.TopLeftRadius.Offset .. ")")
   end
   if Check(Object, "TopRightRadius") and typeof(Object.TopRightRadius) == "UDim" then
      AddCode("\n" .. CurrentInstance .. ".TopRightRadius = UDim.new(" .. Object.TopRightRadius.Scale .. ", " .. Object.TopRightRadius.Offset .. ")")
   end
   if Check(Object, "BottomLeftRadius") and typeof(Object.BottomLeftRadius) == "UDim" then
      AddCode("\n" .. CurrentInstance .. ".BottomLeftRadius = UDim.new(" .. Object.BottomLeftRadius.Scale .. ", " .. Object.BottomLeftRadius.Offset .. ")")
   end
   if Check(Object, "BottomRightRadius") and typeof(Object.BottomRightRadius) == "UDim" then
      AddCode("\n" .. CurrentInstance .. ".BottomRightRadius = UDim.new(" .. Object.BottomRightRadius.Scale .. ", " .. Object.BottomRightRadius.Offset .. ")")
   end
   if Check(Object, "BorderOffset") and typeof(Object.BorderOffset) == "UDim" then
      AddCode("\n" .. CurrentInstance .. ".BorderOffset = UDim.new(" .. Object.BorderOffset.Scale .. ", " .. Object.BorderOffset.Offset .. ")")
   end
   if Check(Object, "BorderStrokePosition") and typeof(Object.BorderStrokePosition) == "EnumItem" then
      AddCode("\n" .. CurrentInstance .. ".BorderStrokePosition = Enum." .. tostring(Object.BorderStrokePosition.EnumType) .. "." .. Object.BorderStrokePosition.Name)
   end
   if Check(Object, "StrokeSizingMode") and typeof(Object.StrokeSizingMode) == "EnumItem" then
      AddCode("\n" .. CurrentInstance .. ".StrokeSizingMode = Enum." .. tostring(Object.StrokeSizingMode.EnumType) .. "." .. Object.StrokeSizingMode.Name)
   end
   if Check(Object, "TileMode") and typeof(Object.TileMode) == "EnumItem" then
      AddCode("\n" .. CurrentInstance .. ".TileMode = Enum." .. tostring(Object.TileMode.EnumType) .. "." .. Object.TileMode.Name)
   end
   if Check(Object, "Type") and typeof(Object.Type) == "EnumItem" then
      AddCode("\n" .. CurrentInstance .. ".Type = Enum." .. tostring(Object.Type.EnumType) .. "." .. Object.Type.Name)
   end
   if Check(Object, "AspectType") and typeof(Object.AspectType) == "EnumItem" then
      AddCode("\n" .. CurrentInstance .. ".AspectType = Enum." .. tostring(Object.AspectType.EnumType) .. "." .. Object.AspectType.Name)
   end
   if Check(Object, "FillDirection") and typeof(Object.FillDirection) == "EnumItem" then
      AddCode("\n" .. CurrentInstance .. ".FillDirection = Enum." .. tostring(Object.FillDirection.EnumType) .. "." .. Object.FillDirection.Name)
   end
   if Check(Object, "HorizontalAlignment") and typeof(Object.HorizontalAlignment) == "EnumItem" then
      AddCode("\n" .. CurrentInstance .. ".HorizontalAlignment = Enum." .. tostring(Object.HorizontalAlignment.EnumType) .. "." .. Object.HorizontalAlignment.Name)
   end
   if Check(Object, "SortOrder") and typeof(Object.SortOrder) == "EnumItem" then
      AddCode("\n" .. CurrentInstance .. ".SortOrder = Enum." .. tostring(Object.SortOrder.EnumType) .. "." .. Object.SortOrder.Name)
   end
   if Check(Object, "VerticalAlignment") and typeof(Object.VerticalAlignment) == "EnumItem" then
      AddCode("\n" .. CurrentInstance .. ".VerticalAlignment = Enum." .. tostring(Object.VerticalAlignment.EnumType) .. "." .. Object.VerticalAlignment.Name)
   end
   if Check(Object, "HorizontalFlex") and typeof(Object.HorizontalFlex) == "EnumItem" then
      AddCode("\n" .. CurrentInstance .. ".HorizontalFlex = Enum." .. tostring(Object.HorizontalFlex.EnumType) .. "." .. Object.HorizontalFlex.Name)
   end
   if Check(Object, "VerticalFlex") and typeof(Object.VerticalFlex) == "EnumItem" then
      AddCode("\n" .. CurrentInstance .. ".VerticalFlex = Enum." .. tostring(Object.VerticalFlex.EnumType) .. "." .. Object.VerticalFlex.Name)
   end
   if Check(Object, "ItemLineAlignment") and typeof(Object.ItemLineAlignment) == "EnumItem" then
      AddCode("\n" .. CurrentInstance .. ".ItemLineAlignment = Enum." .. tostring(Object.ItemLineAlignment.EnumType) .. "." .. Object.ItemLineAlignment.Name)
   end
   if Check(Object, "Wraps") and typeof(Object.Wraps) == "boolean" then
      AddCode("\n" .. CurrentInstance .. ".Wraps = " .. tostring(Object.Wraps))
   end
   if Check(Object, "CellPadding") and typeof(Object.CellPadding) == "UDim2" then
      AddCode("\n" .. CurrentInstance .. ".CellPadding = UDim2.new(" .. Object.CellPadding.X.Scale .. ", " .. Object.CellPadding.X.Offset .. ", " .. Object.CellPadding.Y.Scale .. ", " .. Object.CellPadding.Y.Offset .. ")")
   end
   if Check(Object, "CellSize") and typeof(Object.CellSize) == "UDim2" then
      AddCode("\n" .. CurrentInstance .. ".CellSize = UDim2.new(" .. Object.CellSize.X.Scale .. ", " .. Object.CellSize.X.Offset .. ", " .. Object.CellSize.Y.Scale .. ", " .. Object.CellSize.Y.Offset .. ")")
   end
   if Check(Object, "FillDirectionMaxCells") and typeof(Object.FillDirectionMaxCells) == "number" then
      AddCode("\n" .. CurrentInstance .. ".FillDirectionMaxCells = " .. Object.FillDirectionMaxCells)
   end
   if Check(Object, "StartCorner") and typeof(Object.StartCorner) == "EnumItem" then
      AddCode("\n" .. CurrentInstance .. ".StartCorner = Enum." .. tostring(Object.StartCorner.EnumType) .. "." .. Object.StartCorner.Name)
   end
   if Check(Object, "Animated") and typeof(Object.Animated) == "boolean" then
      AddCode("\n" .. CurrentInstance .. ".Animated = " .. tostring(Object.Animated))
   end
   if Check(Object, "Circular") and typeof(Object.Circular) == "boolean" then
      AddCode("\n" .. CurrentInstance .. ".Circular = " .. tostring(Object.Circular))
   end
   if Check(Object, "EasingDirection") and typeof(Object.EasingDirection) == "EnumItem" then
      AddCode("\n" .. CurrentInstance .. ".EasingDirection = Enum." .. tostring(Object.EasingDirection.EnumType) .. "." .. Object.EasingDirection.Name)
   end
   if Check(Object, "EasingStyle") and typeof(Object.EasingStyle) == "EnumItem" then
      AddCode("\n" .. CurrentInstance .. ".EasingStyle = Enum." .. tostring(Object.EasingStyle.EnumType) .. "." .. Object.EasingStyle.Name)
   end
   if Check(Object, "GamepadInputEnabled") and typeof(Object.GamepadInputEnabled) == "boolean" then
      AddCode("\n" .. CurrentInstance .. ".GamepadInputEnabled = " .. tostring(Object.GamepadInputEnabled))
   end
   if Check(Object, "ScrollWheelInputEnabled") and typeof(Object.ScrollWheelInputEnabled) == "boolean" then
      AddCode("\n" .. CurrentInstance .. ".ScrollWheelInputEnabled = " .. tostring(Object.ScrollWheelInputEnabled))
   end
   if Check(Object, "TouchInputEnabled") and typeof(Object.TouchInputEnabled) == "boolean" then
      AddCode("\n" .. CurrentInstance .. ".TouchInputEnabled = " .. tostring(Object.TouchInputEnabled))
   end
   if Check(Object, "TweenTime") and typeof(Object.TweenTime) == "number" then
      AddCode("\n" .. CurrentInstance .. ".TweenTime = " .. Object.TweenTime)
   end
   if Check(Object, "FlexMode") and typeof(Object.FlexMode) == "EnumItem" then
      AddCode("\n" .. CurrentInstance .. ".FlexMode = Enum." .. tostring(Object.FlexMode.EnumType) .. "." .. Object.FlexMode.Name)
   end
   if Check(Object, "GrowRatio") and typeof(Object.GrowRatio) == "number" then
      AddCode("\n" .. CurrentInstance .. ".GrowRatio = " .. Object.GrowRatio)
   end
   if Check(Object, "ShrinkRatio") and typeof(Object.ShrinkRatio) == "number" then
      AddCode("\n" .. CurrentInstance .. ".ShrinkRatio = " .. Object.ShrinkRatio)
   end
   if Check(Object, "Padding") and typeof(Object.Padding) == "UDim" then
      AddCode("\n" .. CurrentInstance .. ".Padding = UDim.new(" .. Object.Padding.Scale .. ", " .. Object.Padding.Offset .. ")")
   end
   if Check(Object, "InputSink") and typeof(Object.InputSink) == "EnumItem" then
      AddCode("\n" .. CurrentInstance .. ".InputSink = Enum." .. tostring(Object.InputSink.EnumType) .. "." .. Object.InputSink.Name)
   end
   if Check(Object, "AutoButtonColor") and typeof(Object.AutoButtonColor) == "boolean" then
      AddCode("\n" .. CurrentInstance .. ".AutoButtonColor = " .. tostring(Object.AutoButtonColor))
   end
   if Check(Object, "Modal") and typeof(Object.Modal) == "boolean" then
      AddCode("\n" .. CurrentInstance .. ".Modal = " .. tostring(Object.Modal))
   end
   if Check(Object, "Selected") and typeof(Object.Selected) == "boolean" then
      AddCode("\n" .. CurrentInstance .. ".Selected = " .. tostring(Object.Selected))
   end
   if Check(Object, "HoverImage") and typeof(Object.HoverImage) == "string" then
      AddCode("\n" .. CurrentInstance .. '.HoverImage = "' .. Object.HoverImage .. '"')
   end
   if Check(Object, "PressedImage") and typeof(Object.PressedImage) == "string" then
      AddCode("\n" .. CurrentInstance .. '.PressedImage = "' .. Object.PressedImage .. '"')
   end
   if Check(Object, "SliceCenter") and typeof(Object.SliceCenter) == "Rect" then
      AddCode("\n" .. CurrentInstance .. ".SliceCenter = Rect.new(" .. Object.SliceCenter.Min.X .. ", " .. Object.SliceCenter.Min.Y .. ", " .. Object.SliceCenter.Max.X .. ", " .. Object.SliceCenter.Max.Y .. ")")
   end
   if Check(Object, "CursorPosition") and typeof(Object.CursorPosition) == "number" then
      AddCode("\n" .. CurrentInstance .. ".CursorPosition = " .. Object.CursorPosition)
   end
   if Check(Object, "SelectionStart") and typeof(Object.SelectionStart) == "number" then
      AddCode("\n" .. CurrentInstance .. ".SelectionStart = " .. Object.SelectionStart)
   end
   if Check(Object, "TopImage") and typeof(Object.TopImage) == "string" then
      AddCode("\n" .. CurrentInstance .. '.TopImage = "' .. Object.TopImage .. '"')
   end
   if Check(Object, "MidImage") and typeof(Object.MidImage) == "string" then
      AddCode("\n" .. CurrentInstance .. '.MidImage = "' .. Object.MidImage .. '"')
   end
   if Check(Object, "BottomImage") and typeof(Object.BottomImage) == "string" then
      AddCode("\n" .. CurrentInstance .. '.BottomImage = "' .. Object.BottomImage .. '"')
   end
   if Check(Object, "ClipToDeviceSafeArea") and typeof(Object.ClipToDeviceSafeArea) == "boolean" then
      AddCode("\n" .. CurrentInstance .. ".ClipToDeviceSafeArea = " .. tostring(Object.ClipToDeviceSafeArea))
   end
   if Check(Object, "SafeAreaCompatibility") and typeof(Object.SafeAreaCompatibility) == "EnumItem" then
      AddCode("\n" .. CurrentInstance .. ".SafeAreaCompatibility = Enum." .. tostring(Object.SafeAreaCompatibility.EnumType) .. "." .. Object.SafeAreaCompatibility.Name)
   end
   if Check(Object, "ScreenInsets") and typeof(Object.ScreenInsets) == "EnumItem" then
      AddCode("\n" .. CurrentInstance .. ".ScreenInsets = Enum." .. tostring(Object.ScreenInsets.EnumType) .. "." .. Object.ScreenInsets.Name)
   end
   if Check(Object, "GroupColor3") and typeof(Object.GroupColor3) == "Color3" then
      AddCode("\n" .. CurrentInstance .. ".GroupColor3 = Color3.new(" .. Object.GroupColor3.R .. ", " .. Object.GroupColor3.G .. ", " .. Object.GroupColor3.B .. ")")
   end
   if Check(Object, "GroupTransparency") and typeof(Object.GroupTransparency) == "number" then
      AddCode("\n" .. CurrentInstance .. ".GroupTransparency = " .. Object.GroupTransparency)
   end
   if Check(Object, "Ambient") and typeof(Object.Ambient) == "Color3" then
      AddCode("\n" .. CurrentInstance .. ".Ambient = Color3.new(" .. Object.Ambient.R .. ", " .. Object.Ambient.G .. ", " .. Object.Ambient.B .. ")")
   end
   if Check(Object, "LightDirection") and typeof(Object.LightDirection) == "Vector3" then
      AddCode("\n" .. CurrentInstance .. ".LightDirection = Vector3.new(" .. Object.LightDirection.X .. ", " .. Object.LightDirection.Y .. ", " .. Object.LightDirection.Z .. ")")
   end
   if Check(Object, "Video") and typeof(Object.Video) == "string" then
      AddCode("\n" .. CurrentInstance .. '.Video = "' .. Object.Video .. '"')
   end
   if Check(Object, "Playing") and typeof(Object.Playing) == "boolean" then
      AddCode("\n" .. CurrentInstance .. ".Playing = " .. tostring(Object.Playing))
   end
   if Check(Object, "TimePosition") and typeof(Object.TimePosition) == "number" then
      AddCode("\n" .. CurrentInstance .. ".TimePosition = " .. Object.TimePosition)
   end
   if Check(Object, "TextFits") and typeof(Object.TextFits) == "boolean" then
      AddCode("\n" .. CurrentInstance .. ".TextFits = " .. tostring(Object.TextFits))
   end
   if Check(Object, "DragAxis") and typeof(Object.DragAxis) == "Vector2" then
      AddCode("\n" .. CurrentInstance .. ".DragAxis = Vector2.new(" .. Object.DragAxis.X .. ", " .. Object.DragAxis.Y .. ")")
   end
   if Check(Object, "DragRelativity") and typeof(Object.DragRelativity) == "EnumItem" then
      AddCode("\n" .. CurrentInstance .. ".DragRelativity = Enum." .. tostring(Object.DragRelativity.EnumType) .. "." .. Object.DragRelativity.Name)
   end
   if Check(Object, "DragRotation") and typeof(Object.DragRotation) == "number" then
      AddCode("\n" .. CurrentInstance .. ".DragRotation = " .. Object.DragRotation)
   end
   if Check(Object, "DragSpace") and typeof(Object.DragSpace) == "EnumItem" then
      AddCode("\n" .. CurrentInstance .. ".DragSpace = Enum." .. tostring(Object.DragSpace.EnumType) .. "." .. Object.DragSpace.Name)
   end
   if Check(Object, "DragStyle") and typeof(Object.DragStyle) == "EnumItem" then
      AddCode("\n" .. CurrentInstance .. ".DragStyle = Enum." .. tostring(Object.DragStyle.EnumType) .. "." .. Object.DragStyle.Name)
   end
   if Check(Object, "DragUDim2") and typeof(Object.DragUDim2) == "UDim2" then
      AddCode("\n" .. CurrentInstance .. ".DragUDim2 = UDim2.new(" .. Object.DragUDim2.X.Scale .. ", " .. Object.DragUDim2.X.Offset .. ", " .. Object.DragUDim2.Y.Scale .. ", " .. Object.DragUDim2.Y.Offset .. ")")
   end
   if Check(Object, "MaxDragAngle") and typeof(Object.MaxDragAngle) == "number" then
      AddCode("\n" .. CurrentInstance .. ".MaxDragAngle = " .. Object.MaxDragAngle)
   end
   if Check(Object, "MaxDragTranslation") and typeof(Object.MaxDragTranslation) == "UDim2" then
      AddCode("\n" .. CurrentInstance .. ".MaxDragTranslation = UDim2.new(" .. Object.MaxDragTranslation.X.Scale .. ", " .. Object.MaxDragTranslation.X.Offset .. ", " .. Object.MaxDragTranslation.Y.Scale .. ", " .. Object.MaxDragTranslation.Y.Offset .. ")")
   end
   if Check(Object, "MinDragAngle") and typeof(Object.MinDragAngle) == "number" then
      AddCode("\n" .. CurrentInstance .. ".MinDragAngle = " .. Object.MinDragAngle)
   end
   if Check(Object, "MinDragTranslation") and typeof(Object.MinDragTranslation) == "UDim2" then
      AddCode("\n" .. CurrentInstance .. ".MinDragTranslation = UDim2.new(" .. Object.MinDragTranslation.X.Scale .. ", " .. Object.MinDragTranslation.X.Offset .. ", " .. Object.MinDragTranslation.Y.Scale .. ", " .. Object.MinDragTranslation.Y.Offset .. ")")
   end
   if Check(Object, "ResponseStyle") and typeof(Object.ResponseStyle) == "EnumItem" then
      AddCode("\n" .. CurrentInstance .. ".ResponseStyle = Enum." .. tostring(Object.ResponseStyle.EnumType) .. "." .. Object.ResponseStyle.Name)
   end
   if Check(Object, "SelectionModeDragSpeed") and typeof(Object.SelectionModeDragSpeed) == "UDim2" then
      AddCode("\n" .. CurrentInstance .. ".SelectionModeDragSpeed = UDim2.new(" .. Object.SelectionModeDragSpeed.X.Scale .. ", " .. Object.SelectionModeDragSpeed.X.Offset .. ", " .. Object.SelectionModeDragSpeed.Y.Scale .. ", " .. Object.SelectionModeDragSpeed.Y.Offset .. ")")
   end
   if Check(Object, "SelectionModeRotateSpeed") and typeof(Object.SelectionModeRotateSpeed) == "number" then
      AddCode("\n" .. CurrentInstance .. ".SelectionModeRotateSpeed = " .. Object.SelectionModeRotateSpeed)
   end
   if Check(Object, "UIDragSpeedAxisMapping") and typeof(Object.UIDragSpeedAxisMapping) == "EnumItem" then
      AddCode("\n" .. CurrentInstance .. ".UIDragSpeedAxisMapping = Enum." .. tostring(Object.UIDragSpeedAxisMapping.EnumType) .. "." .. Object.UIDragSpeedAxisMapping.Name)
   end
   if Check(Object, "OutdoorAmbient") and typeof(Object.OutdoorAmbient) == "Color3" then
      AddCode("\n" .. CurrentInstance .. ".OutdoorAmbient = Color3.new(" .. Object.OutdoorAmbient.R .. ", " .. Object.OutdoorAmbient.G .. ", " .. Object.OutdoorAmbient.B .. ")")
   end
   if Check(Object, "ColorShift_Top") and typeof(Object.ColorShift_Top) == "Color3" then
      AddCode("\n" .. CurrentInstance .. ".ColorShift_Top = Color3.new(" .. Object.ColorShift_Top.R .. ", " .. Object.ColorShift_Top.G .. ", " .. Object.ColorShift_Top.B .. ")")
   end
   if Check(Object, "ColorShift_Bottom") and typeof(Object.ColorShift_Bottom) == "Color3" then
      AddCode("\n" .. CurrentInstance .. ".ColorShift_Bottom = Color3.new(" .. Object.ColorShift_Bottom.R .. ", " .. Object.ColorShift_Bottom.G .. ", " .. Object.ColorShift_Bottom.B .. ")")
   end
   if Check(Object, "ExposureCompensation") and typeof(Object.ExposureCompensation) == "number" then
      AddCode("\n" .. CurrentInstance .. ".ExposureCompensation = " .. Object.ExposureCompensation)
   end
   if Check(Object, "GlobalShadows") and typeof(Object.GlobalShadows) == "boolean" then
      AddCode("\n" .. CurrentInstance .. ".GlobalShadows = " .. tostring(Object.GlobalShadows))
   end
   if Check(Object, "ShadowSoftness") and typeof(Object.ShadowSoftness) == "number" then
      AddCode("\n" .. CurrentInstance .. ".ShadowSoftness = " .. Object.ShadowSoftness)
   end
   if Check(Object, "LightingStyle") and typeof(Object.LightingStyle) == "EnumItem" then
      AddCode("\n" .. CurrentInstance .. ".LightingStyle = Enum." .. tostring(Object.LightingStyle.EnumType) .. "." .. Object.LightingStyle.Name)
   end
   if Check(Object, "PrioritizeLightingQuality") and typeof(Object.PrioritizeLightingQuality) == "boolean" then
      AddCode("\n" .. CurrentInstance .. ".PrioritizeLightingQuality = " .. tostring(Object.PrioritizeLightingQuality))
   end
   if Check(Object, "ClockTime") and typeof(Object.ClockTime) == "number" then
      AddCode("\n" .. CurrentInstance .. ".ClockTime = " .. Object.ClockTime)
   end
   if Check(Object, "TimeOfDay") and typeof(Object.TimeOfDay) == "string" then
      AddCode("\n" .. CurrentInstance .. '.TimeOfDay = "' .. Object.TimeOfDay .. '"')
   end
   if Check(Object, "GeographicLatitude") and typeof(Object.GeographicLatitude) == "number" then
      AddCode("\n" .. CurrentInstance .. ".GeographicLatitude = " .. Object.GeographicLatitude)
   end
   if Check(Object, "EnvironmentDiffuseScale") and typeof(Object.EnvironmentDiffuseScale) == "number" then
      AddCode("\n" .. CurrentInstance .. ".EnvironmentDiffuseScale = " .. Object.EnvironmentDiffuseScale)
   end
   if Check(Object, "EnvironmentSpecularScale") and typeof(Object.EnvironmentSpecularScale) == "number" then
      AddCode("\n" .. CurrentInstance .. ".EnvironmentSpecularScale = " .. Object.EnvironmentSpecularScale)
   end
   if Check(Object, "Density") and typeof(Object.Density) == "number" then
      AddCode("\n" .. CurrentInstance .. ".Density = " .. Object.Density)
   end
   if Check(Object, "Decay") and typeof(Object.Decay) == "Color3" then
      AddCode("\n" .. CurrentInstance .. ".Decay = Color3.new(" .. Object.Decay.R .. ", " .. Object.Decay.G .. ", " .. Object.Decay.B .. ")")
   end
   if Check(Object, "Glare") and typeof(Object.Glare) == "number" then
      AddCode("\n" .. CurrentInstance .. ".Glare = " .. Object.Glare)
   end
   if Check(Object, "Haze") and typeof(Object.Haze) == "number" then
      AddCode("\n" .. CurrentInstance .. ".Haze = " .. Object.Haze)
   end
   if Check(Object, "CelestialBodiesShown") and typeof(Object.CelestialBodiesShown) == "boolean" then
      AddCode("\n" .. CurrentInstance .. ".CelestialBodiesShown = " .. tostring(Object.CelestialBodiesShown))
   end
   if Check(Object, "MoonAngularSize") and typeof(Object.MoonAngularSize) == "number" then
      AddCode("\n" .. CurrentInstance .. ".MoonAngularSize = " .. Object.MoonAngularSize)
   end
   if Check(Object, "SkyboxOrientation") and typeof(Object.SkyboxOrientation) == "Vector3" then
      AddCode("\n" .. CurrentInstance .. ".SkyboxOrientation = Vector3.new(" .. Object.SkyboxOrientation.X .. ", " .. Object.SkyboxOrientation.Y .. ", " .. Object.SkyboxOrientation.Z .. ")")
   end
   if Check(Object, "StarCount") and typeof(Object.StarCount) == "number" then
      AddCode("\n" .. CurrentInstance .. ".StarCount = " .. Object.StarCount)
   end
   if Check(Object, "SunAngularSize") and typeof(Object.SunAngularSize) == "number" then
      AddCode("\n" .. CurrentInstance .. ".SunAngularSize = " .. Object.SunAngularSize)
   end
   if Check(Object, "WaterColor") and typeof(Object.WaterColor) == "Color3" then
      AddCode("\n" .. CurrentInstance .. ".WaterColor = Color3.new(" .. Object.WaterColor.R .. ", " .. Object.WaterColor.G .. ", " .. Object.WaterColor.B .. ")")
   end
   if Check(Object, "WaterReflectance") and typeof(Object.WaterReflectance) == "number" then
      AddCode("\n" .. CurrentInstance .. ".WaterReflectance = " .. Object.WaterReflectance)
   end
   if Check(Object, "WaterTransparency") and typeof(Object.WaterTransparency) == "number" then
      AddCode("\n" .. CurrentInstance .. ".WaterTransparency = " .. Object.WaterTransparency)
   end
   if Check(Object, "WaterWaveSize") and typeof(Object.WaterWaveSize) == "number" then
      AddCode("\n" .. CurrentInstance .. ".WaterWaveSize = " .. Object.WaterWaveSize)
   end
   if Check(Object, "WaterWaveSpeed") and typeof(Object.WaterWaveSpeed) == "number" then
      AddCode("\n" .. CurrentInstance .. ".WaterWaveSpeed = " .. Object.WaterWaveSpeed)
   end
   if Check(Object, "Decoration") and typeof(Object.Decoration) == "boolean" then
      AddCode("\n" .. CurrentInstance .. ".Decoration = " .. tostring(Object.Decoration))
   end
   if Check(Object, "GrassLength") and typeof(Object.GrassLength) == "number" then
      AddCode("\n" .. CurrentInstance .. ".GrassLength = " .. Object.GrassLength)
   end
   if Check(Object, "FieldOfView") and typeof(Object.FieldOfView) == "number" then
      AddCode("\n" .. CurrentInstance .. ".FieldOfView = " .. Object.FieldOfView)
   end
   if Check(Object, "FieldOfViewMode") and typeof(Object.FieldOfViewMode) == "EnumItem" then
      AddCode("\n" .. CurrentInstance .. ".FieldOfViewMode = Enum." .. tostring(Object.FieldOfViewMode.EnumType) .. "." .. Object.FieldOfViewMode.Name)
   end
   if Check(Object, "CameraType") and typeof(Object.CameraType) == "EnumItem" then
      AddCode("\n" .. CurrentInstance .. ".CameraType = Enum." .. tostring(Object.CameraType.EnumType) .. "." .. Object.CameraType.Name)
   end
   if Check(Object, "Focus") and typeof(Object.Focus) == "CFrame" then
      local Components = {Object.Focus:GetComponents()}
      AddCode("\n" .. CurrentInstance .. ".Focus = CFrame.new(" .. table.concat(Components, ", ") .. ")")
   end
   if Check(Object, "ApplyAtCenterOfMass") and typeof(Object.ApplyAtCenterOfMass) == "boolean" then
      AddCode("\n" .. CurrentInstance .. ".ApplyAtCenterOfMass = " .. tostring(Object.ApplyAtCenterOfMass))
   end
   if Check(Object, "ForceLimitMode") and typeof(Object.ForceLimitMode) == "EnumItem" then
      AddCode("\n" .. CurrentInstance .. ".ForceLimitMode = Enum." .. tostring(Object.ForceLimitMode.EnumType) .. "." .. Object.ForceLimitMode.Name)
   end
   if Check(Object, "ForceRelativeTo") and typeof(Object.ForceRelativeTo) == "EnumItem" then
      AddCode("\n" .. CurrentInstance .. ".ForceRelativeTo = Enum." .. tostring(Object.ForceRelativeTo.EnumType) .. "." .. Object.ForceRelativeTo.Name)
   end
   if Check(Object, "MaxAxesForce") and typeof(Object.MaxAxesForce) == "Vector3" then
      AddCode("\n" .. CurrentInstance .. ".MaxAxesForce = Vector3.new(" .. Object.MaxAxesForce.X .. ", " .. Object.MaxAxesForce.Y .. ", " .. Object.MaxAxesForce.Z .. ")")
   end
   if Check(Object, "MaxVelocity") and typeof(Object.MaxVelocity) == "number" then
      AddCode("\n" .. CurrentInstance .. ".MaxVelocity = " .. Object.MaxVelocity)
   end
   if Check(Object, "Mode") and typeof(Object.Mode) == "EnumItem" then
      AddCode("\n" .. CurrentInstance .. ".Mode = Enum." .. tostring(Object.Mode.EnumType) .. "." .. Object.Mode.Name)
   end
   if Check(Object, "AlignType") and typeof(Object.AlignType) == "EnumItem" then
      AddCode("\n" .. CurrentInstance .. ".AlignType = Enum." .. tostring(Object.AlignType.EnumType) .. "." .. Object.AlignType.Name)
   end
   if Check(Object, "LookAtPosition") and typeof(Object.LookAtPosition) == "Vector3" then
      AddCode("\n" .. CurrentInstance .. ".LookAtPosition = Vector3.new(" .. Object.LookAtPosition.X .. ", " .. Object.LookAtPosition.Y .. ", " .. Object.LookAtPosition.Z .. ")")
   end
   if Check(Object, "MaxAngularVelocity") and typeof(Object.MaxAngularVelocity) == "number" then
      AddCode("\n" .. CurrentInstance .. ".MaxAngularVelocity = " .. Object.MaxAngularVelocity)
   end
   if Check(Object, "ReactionTorqueEnabled") and typeof(Object.ReactionTorqueEnabled) == "boolean" then
      AddCode("\n" .. CurrentInstance .. ".ReactionTorqueEnabled = " .. tostring(Object.ReactionTorqueEnabled))
   end
   if Check(Object, "ForceLimitsEnabled") and typeof(Object.ForceLimitsEnabled) == "boolean" then
      AddCode("\n" .. CurrentInstance .. ".ForceLimitsEnabled = " .. tostring(Object.ForceLimitsEnabled))
   end
   if Check(Object, "LineDirection") and typeof(Object.LineDirection) == "Vector3" then
      AddCode("\n" .. CurrentInstance .. ".LineDirection = Vector3.new(" .. Object.LineDirection.X .. ", " .. Object.LineDirection.Y .. ", " .. Object.LineDirection.Z .. ")")
   end
   if Check(Object, "LineVelocity") and typeof(Object.LineVelocity) == "number" then
      AddCode("\n" .. CurrentInstance .. ".LineVelocity = " .. Object.LineVelocity)
   end
   if Check(Object, "MaxPlanarAxesForce") and typeof(Object.MaxPlanarAxesForce) == "Vector2" then
      AddCode("\n" .. CurrentInstance .. ".MaxPlanarAxesForce = Vector2.new(" .. Object.MaxPlanarAxesForce.X .. ", " .. Object.MaxPlanarAxesForce.Y .. ")")
   end
   if Check(Object, "PlaneVelocity") and typeof(Object.PlaneVelocity) == "Vector2" then
      AddCode("\n" .. CurrentInstance .. ".PlaneVelocity = Vector2.new(" .. Object.PlaneVelocity.X .. ", " .. Object.PlaneVelocity.Y .. ")")
   end
   if Check(Object, "PrimaryTangentAxis") and typeof(Object.PrimaryTangentAxis) == "Vector3" then
      AddCode("\n" .. CurrentInstance .. ".PrimaryTangentAxis = Vector3.new(" .. Object.PrimaryTangentAxis.X .. ", " .. Object.PrimaryTangentAxis.Y .. ", " .. Object.PrimaryTangentAxis.Z .. ")")
   end
   if Check(Object, "RelativeTo") and typeof(Object.RelativeTo) == "EnumItem" then
      AddCode("\n" .. CurrentInstance .. ".RelativeTo = Enum." .. tostring(Object.RelativeTo.EnumType) .. "." .. Object.RelativeTo.Name)
   end
   if Check(Object, "SecondaryTangentAxis") and typeof(Object.SecondaryTangentAxis) == "Vector3" then
      AddCode("\n" .. CurrentInstance .. ".SecondaryTangentAxis = Vector3.new(" .. Object.SecondaryTangentAxis.X .. ", " .. Object.SecondaryTangentAxis.Y .. ", " .. Object.SecondaryTangentAxis.Z .. ")")
   end
   if Check(Object, "VectorVelocity") and typeof(Object.VectorVelocity) == "Vector3" then
      AddCode("\n" .. CurrentInstance .. ".VectorVelocity = Vector3.new(" .. Object.VectorVelocity.X .. ", " .. Object.VectorVelocity.Y .. ", " .. Object.VectorVelocity.Z .. ")")
   end
   if Check(Object, "VelocityConstraintMode") and typeof(Object.VelocityConstraintMode) == "EnumItem" then
      AddCode("\n" .. CurrentInstance .. ".VelocityConstraintMode = Enum." .. tostring(Object.VelocityConstraintMode.EnumType) .. "." .. Object.VelocityConstraintMode.Name)
   end
   if Check(Object, "Force") and typeof(Object.Force) == "Vector3" then
      AddCode("\n" .. CurrentInstance .. ".Force = Vector3.new(" .. Object.Force.X .. ", " .. Object.Force.Y .. ", " .. Object.Force.Z .. ")")
   end
   if Check(Object, "WinchEnabled") and typeof(Object.WinchEnabled) == "boolean" then
      AddCode("\n" .. CurrentInstance .. ".WinchEnabled = " .. tostring(Object.WinchEnabled))
   end
   if Check(Object, "WinchForce") and typeof(Object.WinchForce) == "number" then
      AddCode("\n" .. CurrentInstance .. ".WinchForce = " .. Object.WinchForce)
   end
   if Check(Object, "WinchResponsiveness") and typeof(Object.WinchResponsiveness) == "number" then
      AddCode("\n" .. CurrentInstance .. ".WinchResponsiveness = " .. Object.WinchResponsiveness)
   end
   if Check(Object, "WinchSpeed") and typeof(Object.WinchSpeed) == "number" then
      AddCode("\n" .. CurrentInstance .. ".WinchSpeed = " .. Object.WinchSpeed)
   end
   if Check(Object, "WinchTarget") and typeof(Object.WinchTarget) == "number" then
      AddCode("\n" .. CurrentInstance .. ".WinchTarget = " .. Object.WinchTarget)
   end
   if Check(Object, "Coils") and typeof(Object.Coils) == "number" then
      AddCode("\n" .. CurrentInstance .. ".Coils = " .. Object.Coils)
   end
   if Check(Object, "Damping") and typeof(Object.Damping) == "number" then
      AddCode("\n" .. CurrentInstance .. ".Damping = " .. Object.Damping)
   end
   if Check(Object, "FreeLength") and typeof(Object.FreeLength) == "number" then
      AddCode("\n" .. CurrentInstance .. ".FreeLength = " .. Object.FreeLength)
   end
   if Check(Object, "MaxLength") and typeof(Object.MaxLength) == "number" then
      AddCode("\n" .. CurrentInstance .. ".MaxLength = " .. Object.MaxLength)
   end
   if Check(Object, "Stiffness") and typeof(Object.Stiffness) == "number" then
      AddCode("\n" .. CurrentInstance .. ".Stiffness = " .. Object.Stiffness)
   end
   if Check(Object, "MaxAngle") and typeof(Object.MaxAngle) == "number" then
      AddCode("\n" .. CurrentInstance .. ".MaxAngle = " .. Object.MaxAngle)
   end
   if Check(Object, "EvaluateStateMachine") and typeof(Object.EvaluateStateMachine) == "boolean" then
      AddCode("\n" .. CurrentInstance .. ".EvaluateStateMachine = " .. tostring(Object.EvaluateStateMachine))
   end
   if Check(Object, "DisplayDistanceType") and typeof(Object.DisplayDistanceType) == "EnumItem" then
      AddCode("\n" .. CurrentInstance .. ".DisplayDistanceType = Enum." .. tostring(Object.DisplayDistanceType.EnumType) .. "." .. Object.DisplayDistanceType.Name)
   end
   if Check(Object, "HealthDisplayDistance") and typeof(Object.HealthDisplayDistance) == "number" then
      AddCode("\n" .. CurrentInstance .. ".HealthDisplayDistance = " .. Object.HealthDisplayDistance)
   end
   if Check(Object, "HealthDisplayType") and typeof(Object.HealthDisplayType) == "EnumItem" then
      AddCode("\n" .. CurrentInstance .. ".HealthDisplayType = Enum." .. tostring(Object.HealthDisplayType.EnumType) .. "." .. Object.HealthDisplayType.Name)
   end
   if Check(Object, "NameDisplayDistance") and typeof(Object.NameDisplayDistance) == "number" then
      AddCode("\n" .. CurrentInstance .. ".NameDisplayDistance = " .. Object.NameDisplayDistance)
   end
   if Check(Object, "NameOcclusion") and typeof(Object.NameOcclusion) == "EnumItem" then
      AddCode("\n" .. CurrentInstance .. ".NameOcclusion = Enum." .. tostring(Object.NameOcclusion.EnumType) .. "." .. Object.NameOcclusion.Name)
   end
   if Check(Object, "RigType") and typeof(Object.RigType) == "EnumItem" then
      AddCode("\n" .. CurrentInstance .. ".RigType = Enum." .. tostring(Object.RigType.EnumType) .. "." .. Object.RigType.Name)
   end
   if Check(Object, "Sit") and typeof(Object.Sit) == "boolean" then
      AddCode("\n" .. CurrentInstance .. ".Sit = " .. tostring(Object.Sit))
   end
   if Check(Object, "DiagonalFieldOfView") and typeof(Object.DiagonalFieldOfView) == "number" then
      AddCode("\n" .. CurrentInstance .. ".DiagonalFieldOfView = " .. Object.DiagonalFieldOfView)
   end
   if Check(Object, "HeadLocked") and typeof(Object.HeadLocked) == "boolean" then
      AddCode("\n" .. CurrentInstance .. ".HeadLocked = " .. tostring(Object.HeadLocked))
   end
   if Check(Object, "HeadScale") and typeof(Object.HeadScale) == "number" then
      AddCode("\n" .. CurrentInstance .. ".HeadScale = " .. Object.HeadScale)
   end
   if Check(Object, "VRTiltAndRollEnabled") and typeof(Object.VRTiltAndRollEnabled) == "boolean" then
      AddCode("\n" .. CurrentInstance .. ".VRTiltAndRollEnabled = " .. tostring(Object.VRTiltAndRollEnabled))
   end
   if Check(Object, "Gravity") and typeof(Object.Gravity) == "number" then
      AddCode("\n" .. CurrentInstance .. ".Gravity = " .. Object.Gravity)
   end
   if Check(Object, "GlobalWind") and typeof(Object.GlobalWind) == "Vector3" then
      AddCode("\n" .. CurrentInstance .. ".GlobalWind = Vector3.new(" .. Object.GlobalWind.X .. ", " .. Object.GlobalWind.Y .. ", " .. Object.GlobalWind.Z .. ")")
   end
   if Check(Object, "AirDensity") and typeof(Object.AirDensity) == "number" then
      AddCode("\n" .. CurrentInstance .. ".AirDensity = " .. Object.AirDensity)
   end
   if Check(Object, "AirTurbulenceIntensity") and typeof(Object.AirTurbulenceIntensity) == "number" then
      AddCode("\n" .. CurrentInstance .. ".AirTurbulenceIntensity = " .. Object.AirTurbulenceIntensity)
   end
   if Check(Object, "FallenPartsDestroyHeight") and typeof(Object.FallenPartsDestroyHeight) == "number" then
      AddCode("\n" .. CurrentInstance .. ".FallenPartsDestroyHeight = " .. Object.FallenPartsDestroyHeight)
   end
   if Check(Object, "FallHeightEnabled") and typeof(Object.FallHeightEnabled) == "boolean" then
      AddCode("\n" .. CurrentInstance .. ".FallHeightEnabled = " .. tostring(Object.FallHeightEnabled))
   end
   if Check(Object, "FluidForces") and typeof(Object.FluidForces) == "EnumItem" then
      AddCode("\n" .. CurrentInstance .. ".FluidForces = Enum.FluidForces." .. Object.FluidForces.Name)
   end
   if Check(Object, "Value") and typeof(Object.Value) == "boolean" then
      AddCode("\n" .. CurrentInstance .. ".Value = " .. tostring(Object.Value))
   end
   if Check(Object, "Value") and typeof(Object.Value) == "number" then
      AddCode("\n" .. CurrentInstance .. ".Value = " .. Object.Value)
   end
   if Check(Object, "Value") and typeof(Object.Value) == "string" then
      AddCode("\n" .. CurrentInstance .. '.Value = "' .. Object.Value .. '"')
   end
   if Check(Object, "Value") and typeof(Object.Value) == "Color3" then
      AddCode("\n" .. CurrentInstance .. ".Value = Color3.new(" .. Object.Value.R .. ", " .. Object.Value.G .. ", " .. Object.Value.B .. ")")
   end
   if Check(Object, "Value") and typeof(Object.Value) == "BrickColor" then
      AddCode("\n" .. CurrentInstance .. ".Value = BrickColor.new(" .. Object.Value.Number .. ")")
   end
   if Check(Object, "Value") and typeof(Object.Value) == "Vector3" then
      AddCode("\n" .. CurrentInstance .. ".Value = Vector3.new(" .. Object.Value.X .. ", " .. Object.Value.Y .. ", " .. Object.Value.Z .. ")")
   end
   if Check(Object, "Value") and typeof(Object.Value) == "CFrame" then
      local Components = {Object.Value:GetComponents()}
      AddCode("\n" .. CurrentInstance .. ".Value = CFrame.new(" .. table.concat(Components, ", ") .. ")")
   end
   if Check(Object, "Value") and typeof(Object.Value) == "Instance" then
      if InstanceVariables and InstanceVariables[Object.Value] then
         local Position = CodeIndex + 1
         AddCode("")
         DeferredProperties[#DeferredProperties + 1] = {Position, CurrentInstance, "Value", Object.Value}
      end
   end
   if Check(Object, "Value") and typeof(Object.Value) == "Ray" then
      AddCode("\n" .. CurrentInstance .. ".Value = Ray.new(Vector3.new(" .. Object.Value.Origin.X .. ", " .. Object.Value.Origin.Y .. ", " .. Object.Value.Origin.Z .. "), Vector3.new(" .. Object.Value.Direction.X .. ", " .. Object.Value.Direction.Y .. ", " .. Object.Value.Direction.Z .. "))")
   end
   if Check(Object, "PreferLodEnabled") and typeof(Object.PreferLodEnabled) == "boolean" then
      AddCode("\n" .. CurrentInstance .. ".PreferLodEnabled = " .. tostring(Object.PreferLodEnabled))
   end
   if Check(Object, "AnimationId") and typeof(Object.AnimationId) == "string" then
      AddCode("\n" .. CurrentInstance .. ".AnimationId = " .. string.format("%q", Object.AnimationId))
   end
   if Check(Object, "AnimationContent") and typeof(Object.AnimationContent) == "Content" and Object.AnimationContent.Uri then
      AddCode("\n" .. CurrentInstance .. ".AnimationContent = Content.fromUri(" .. string.format("%q", Object.AnimationContent.Uri) .. ")")
   end
   if Check(Object, "ShirtTemplate") and typeof(Object.ShirtTemplate) == "string" then
      AddCode("\n" .. CurrentInstance .. ".ShirtTemplate = " .. '"' .. Object.ShirtTemplate .. '"')
   end
   if Check(Object, "ShirtTemplateContent") and typeof(Object.ShirtTemplateContent) == "Content" then
      AddCode("\n" .. CurrentInstance .. ".ShirtTemplateContent = Content.fromUri(" .. '"' .. Object.ShirtTemplateContent.Uri .. '"' .. ")")
   end
   if Check(Object, "PantsTemplate") and typeof(Object.PantsTemplate) == "string" then
      AddCode("\n" .. CurrentInstance .. ".PantsTemplate = " .. '"' .. Object.PantsTemplate .. '"')
   end
   if Check(Object, "PantsTemplateContent") and typeof(Object.PantsTemplateContent) == "Content" then
      AddCode("\n" .. CurrentInstance .. ".PantsTemplateContent = Content.fromUri(" .. '"' .. Object.PantsTemplateContent.Uri .. '"' .. ")")
   end
   if Check(Object, "Graphic") and typeof(Object.Graphic) == "string" then
      AddCode("\n" .. CurrentInstance .. ".Graphic = " .. '"' .. Object.Graphic .. '"')
   end
   if Check(Object, "TextureContent") and typeof(Object.TextureContent) == "Content" and Object.TextureContent.Uri then
      AddCode("\n" .. CurrentInstance .. ".TextureContent = Content.fromUri(" .. '"' .. Object.TextureContent.Uri .. '"' .. ")")
   end
   if Check(Object, "BodyPart") and typeof(Object.BodyPart) == "EnumItem" then
      AddCode("\n" .. CurrentInstance .. ".BodyPart = Enum." .. tostring(Object.BodyPart.EnumType) .. "." .. Object.BodyPart.Name)
   end
   if Check(Object, "BaseTextureId") and typeof(Object.BaseTextureId) == "number" then
      AddCode("\n" .. CurrentInstance .. ".BaseTextureId = " .. Object.BaseTextureId)
   end
   if Check(Object, "BaseTextureContent") and typeof(Object.BaseTextureContent) == "Content" then
      AddCode("\n" .. CurrentInstance .. ".BaseTextureContent = Content.fromUri(" .. '"' .. Object.BaseTextureContent.Uri .. '"' .. ")")
   end
   if Check(Object, "OverlayTextureId") and typeof(Object.OverlayTextureId) == "number" then
      AddCode("\n" .. CurrentInstance .. ".OverlayTextureId = " .. Object.OverlayTextureId)
   end
   if Check(Object, "OverlayTextureContent") and typeof(Object.OverlayTextureContent) == "Content" then
      AddCode("\n" .. CurrentInstance .. ".OverlayTextureContent = Content.fromUri(" .. '"' .. Object.OverlayTextureContent.Uri .. '"' .. ")")
   end
   if Check(Object, "PrimaryPart") and Object.PrimaryPart then
      AddCode("")
      DeferredProperties[#DeferredProperties + 1] = {CodeIndex + 1, CurrentInstance, "PrimaryPart", Object.PrimaryPart}
   end
   if Check(Object, "BottomImageContent") and Object.BottomImageContent and Object.BottomImageContent.Uri then
      AddCode("\n" .. CurrentInstance .. ".BottomImageContent = Content.fromUri(" .. string.format("%q", Object.BottomImageContent.Uri) .. ")")
   end
   if Check(Object, "MidImageContent") and Object.MidImageContent and Object.MidImageContent.Uri then
      AddCode("\n" .. CurrentInstance .. ".MidImageContent = Content.fromUri(" .. string.format("%q", Object.MidImageContent.Uri) .. ")")
   end
   if Check(Object, "TopImageContent") and Object.TopImageContent and Object.TopImageContent.Uri then
      AddCode("\n" .. CurrentInstance .. ".TopImageContent = Content.fromUri(" .. string.format("%q", Object.TopImageContent.Uri) .. ")")
   end
   if Check(Object, "Attachment0") and Object.Attachment0 and InstanceVariables[Object.Attachment0] then
      AddCode("")
      DeferredProperties[#DeferredProperties + 1] = {CodeIndex + 1, CurrentInstance, "Attachment0", Object.Attachment0}
   end
   if Check(Object, "Attachment1") and Object.Attachment1 and InstanceVariables[Object.Attachment1] then
      AddCode("")
      DeferredProperties[#DeferredProperties + 1] = {CodeIndex + 1, CurrentInstance, "Attachment1", Object.Attachment1}
   end
   if Check(Object, "AudioContent") and Object.AudioContent and Object.AudioContent.Uri then
      AddCode("\n" .. CurrentInstance .. ".AudioContent = Content.fromUri(" .. string.format("%q", Object.AudioContent.Uri) .. ")")
   end
   if Check(Object, "SoundGroup") and Object.SoundGroup and InstanceVariables[Object.SoundGroup] then
      AddCode("")
      DeferredProperties[#DeferredProperties + 1] = {CodeIndex + 1, CurrentInstance, "SoundGroup", Object.SoundGroup}
   end
   if Check(Object, "FogStart") then
      AddCode("\n" .. CurrentInstance .. ".FogStart = " .. tostring(Object.FogStart))
   end
   if Check(Object, "FogColor") and typeof(Object.FogColor) == "Color3" then
      AddCode("\n" .. CurrentInstance .. ".FogColor = Color3.new(" .. Object.FogColor.R .. ", " .. Object.FogColor.G .. ", " .. Object.FogColor.B .. ")")
   end
   if Check(Object, "FogEnd") then
      AddCode("\n" .. CurrentInstance .. ".FogEnd = " .. tostring(Object.FogEnd))
   end
   if Check(Object, "SpectrumEnabled") and typeof(Object.SpectrumEnabled) == "boolean" then
      AddCode("\n" .. CurrentInstance .. ".SpectrumEnabled = " .. tostring(Object.SpectrumEnabled))
   end
   if Check(Object, "WindowSize") and typeof(Object.WindowSize) == "EnumItem" then
      AddCode("\n" .. CurrentInstance .. ".WindowSize = " .. tostring(Object.WindowSize.EnumType) .. "." .. Object.WindowSize.Name)
   end
   if Check(Object, "AcousticSimulationEnabled") and typeof(Object.AcousticSimulationEnabled) == "boolean" then
      AddCode("\n" .. CurrentInstance .. ".AcousticSimulationEnabled = " .. tostring(Object.AcousticSimulationEnabled))
   end
   if Check(Object, "AudioInteractionGroup") and typeof(Object.AudioInteractionGroup) == "string" then
      AddCode("\n" .. CurrentInstance .. ".AudioInteractionGroup = " .. string.format("%q", Object.AudioInteractionGroup))
   end
   if Check(Object, "DistanceAttenuationBounds") and typeof(Object.DistanceAttenuationBounds) == "Vector2" then
      AddCode("\n" .. CurrentInstance .. ".DistanceAttenuationBounds = Vector2.new(" .. Object.DistanceAttenuationBounds.X .. ", " .. Object.DistanceAttenuationBounds.Y .. ")")
   end
   if Check(Object, "DistanceAttenuationMode") and typeof(Object.DistanceAttenuationMode) == "EnumItem" then
      AddCode("\n" .. CurrentInstance .. ".DistanceAttenuationMode = " .. tostring(Object.DistanceAttenuationMode.EnumType) .. "." .. Object.DistanceAttenuationMode.Name)
   end
   if Check(Object, "PositionInstance") and Object.PositionInstance and InstanceVariables[Object.PositionInstance] then
      AddCode("")
      DeferredProperties[#DeferredProperties + 1] = {CodeIndex + 1, CurrentInstance, "PositionInstance", Object.PositionInstance}
   end
   if Check(Object, "PositionType") and typeof(Object.PositionType) == "EnumItem" then
      AddCode("\n" .. CurrentInstance .. ".PositionType = " .. tostring(Object.PositionType.EnumType) .. "." .. Object.PositionType.Name)
   end
   if Check(Object, "Attack") and typeof(Object.Attack) == "number" then
      AddCode("\n" .. CurrentInstance .. ".Attack = " .. tostring(Object.Attack))
   end
   if Check(Object, "Release") and typeof(Object.Release) == "number" then
      AddCode("\n" .. CurrentInstance .. ".Release = " .. tostring(Object.Release))
   end
   if Check(Object, "Ratio") and typeof(Object.Ratio) == "number" then
      AddCode("\n" .. CurrentInstance .. ".Ratio = " .. tostring(Object.Ratio))
   end
   if Check(Object, "Threshold") and typeof(Object.Threshold) == "number" then
      AddCode("\n" .. CurrentInstance .. ".Threshold = " .. tostring(Object.Threshold))
   end
   if Check(Object, "MakeupGain") and typeof(Object.MakeupGain) == "number" then
      AddCode("\n" .. CurrentInstance .. ".MakeupGain = " .. tostring(Object.MakeupGain))
   end
   if Check(Object, "Depth") and typeof(Object.Depth) == "number" then
      AddCode("\n" .. CurrentInstance .. ".Depth = " .. tostring(Object.Depth))
   end
   if Check(Object, "Duty") and typeof(Object.Duty) == "number" then
      AddCode("\n" .. CurrentInstance .. ".Duty = " .. tostring(Object.Duty))
   end
   if Check(Object, "Frequency") and typeof(Object.Frequency) == "number" then
      AddCode("\n" .. CurrentInstance .. ".Frequency = " .. tostring(Object.Frequency))
   end
   if Check(Object, "Part0") and Object.Part0 and InstanceVariables[Object.Part0] then
      AddCode("")
      DeferredProperties[#DeferredProperties + 1] = {CodeIndex, CurrentInstance, "Part0", Object.Part0}
   end
   if Check(Object, "Part1") and Object.Part1 and InstanceVariables[Object.Part1] then
      AddCode("")
      DeferredProperties[#DeferredProperties + 1] = {CodeIndex, CurrentInstance, "Part1", Object.Part1}
   end
   if Check(Object, "Adornee") and Object.Adornee and InstanceVariables[Object.Adornee] then
      AddCode("")
      DeferredProperties[#DeferredProperties + 1] = {CodeIndex, CurrentInstance, "Adornee", Object.Adornee}
   end
   if Check(Object, "CameraSubject") and typeof(Object.CameraSubject) == "Instance" and Object.CameraSubject and InstanceVariables[Object.CameraSubject] then
      AddCode("")
      DeferredProperties[#DeferredProperties + 1] = {CodeIndex, CurrentInstance, "CameraSubject", Object.CameraSubject}
   end
   if Check(Object, "PlayerToHideFrom") and typeof(Object.PlayerToHideFrom) == "Instance" and Object.PlayerToHideFrom and InstanceVariables[Object.PlayerToHideFrom] then
      AddCode("")
      DeferredProperties[#DeferredProperties + 1] = {CodeIndex, CurrentInstance, "PlayerToHideFrom", Object.PlayerToHideFrom}
   end
   if Check(Object, "Generator") and typeof(Object.Generator) == "Instance" and Object.Generator and InstanceVariables[Object.Generator] then
      AddCode("")
      DeferredProperties[#DeferredProperties + 1] = {CodeIndex, CurrentInstance, "Generator", Object.Generator}
   end
   for _, v in CollectionService:GetTags(Object) do
      UseCollectionService = true
      AddCode("\n" .. "CollectionService:AddTag(" .. CurrentInstance .. ", " .. string.format("%q", v) .. ")")
   end
   for i, v in Object:GetAttributes() do
      if typeof(v) == "string" then
         AddCode("\n" .. CurrentInstance .. ":SetAttribute(" .. string.format("%q", i) .. ", " .. string.format("%q", v) .. ")")
      elseif typeof(v) == "number" or typeof(v) == "boolean" then
         AddCode("\n" .. CurrentInstance .. ":SetAttribute(" .. string.format("%q", i) .. ", " .. tostring(v) .. ")")
      elseif typeof(v) == "Vector3" then
         AddCode("\n" .. CurrentInstance .. ":SetAttribute(" .. string.format("%q", i) .. ", Vector3.new(" .. v.X .. ", " .. v.Y .. ", " .. v.Z .. "))")
      elseif typeof(v) == "Vector2" then
         AddCode("\n" .. CurrentInstance .. ":SetAttribute(" .. string.format("%q", i) .. ", Vector2.new(" .. v.X .. ", " .. v.Y .. "))")
      elseif typeof(v) == "Color3" then
         AddCode("\n" .. CurrentInstance .. ":SetAttribute(" .. string.format("%q", i) .. ", Color3.new(" .. v.R .. ", " .. v.G .. ", " .. v.B .. "))")
      elseif typeof(v) == "CFrame" then
         local Components = {v:GetComponents()}
         AddCode("\n" .. CurrentInstance .. ":SetAttribute(" .. string.format("%q", i) .. ", CFrame.new(" .. table.concat(Components, ", ") .. "))")
      elseif typeof(v) == "UDim" then
         AddCode("\n" .. CurrentInstance .. ":SetAttribute(" .. string.format("%q", i) .. ", UDim.new(" .. v.Scale .. ", " .. v.Offset .. "))")
      elseif typeof(v) == "UDim2" then
         AddCode("\n" .. CurrentInstance .. ":SetAttribute(" .. string.format("%q", i) .. ", UDim2.new(" .. v.X.Scale .. ", " .. v.X.Offset .. ", " .. v.Y.Scale .. ", " .. v.Y.Offset .. "))")
      elseif typeof(v) == "NumberRange" then
         AddCode("\n" .. CurrentInstance .. ":SetAttribute(" .. string.format("%q", i) .. ", NumberRange.new(" .. v.Min .. ", " .. v.Max .. "))")
      elseif typeof(v) == "ColorSequence" then
         local Keypoints = {}
         for _, k in v.Keypoints do
            Keypoints[#Keypoints + 1] = "ColorSequenceKeypoint.new(" .. k.Time .. ", Color3.new(" .. k.Value.R .. ", " .. k.Value.G .. ", " .. k.Value.B .. "))"
         end
         AddCode("\n" .. CurrentInstance .. ":SetAttribute(" .. string.format("%q", i) .. ", ColorSequence.new({" .. table.concat(Keypoints, ", ") .. "}))")
      elseif typeof(v) == "NumberSequence" then
         local Keypoints = {}
         for _, k in v.Keypoints do
            Keypoints[#Keypoints + 1] = "NumberSequenceKeypoint.new(" .. k.Time .. ", " .. k.Value .. ", " .. k.Envelope .. ")"
         end
         AddCode("\n" .. CurrentInstance .. ":SetAttribute(" .. string.format("%q", i) .. ", NumberSequence.new({" .. table.concat(Keypoints, ", ") .. "}))")
      elseif typeof(v) == "BrickColor" then
         AddCode("\n" .. CurrentInstance .. ":SetAttribute(" .. string.format("%q", i) .. ", BrickColor.new(" .. v.Number .. "))")
      end
   end
   if Parent then
      AddCode("\n" .. CurrentInstance .. ".Parent = " .. Parent)
      AddCode("\n")
   end
   if not Parent then
      AddCode("\n" .. CurrentInstance .. ".Parent = -- Enter Your Parent Here")
      AddCode("\n")
   end
   for _, v in Object:GetChildren() do
      SaveInstance(v, CurrentInstance)
   end
   if not Parent then
      for _, v in DeferredProperties do
         local Reference = InstanceVariables[v[4]]
         if Reference then
            Code[v[1]] = "\n" .. v[2] .. "." .. v[3] .. " = " .. Reference
         else
            Code[v[1]] = ""
         end
      end
      if not UseCollectionService then 
         return "-- This Script Generated By Instance To Script v1.3\n" .. SplitCode(table.concat(Code), 190)
      else
         return "-- This Script Generated By Instance To Script v1.3\n" .. 'local cloneref = cloneref or clonereference or function(...) return ... end\nlocal CollectionService = cloneref(game:GetService("CollectionService"))\n\n' .. SplitCode(table.concat(Code), 190)
      end
   end
   return ""
end

return SaveInstance
