--// WizardLibrary (clean refactor)
--// UI helper library for Roblox (Luau)
--// Features: draggable windows, collapsible sections, Toggle / Slider / ColorPicker (with rainbow), tweened animations.
--// Hotkey: RightCtrl toggles the entire UI (ScreenGui.Enabled)

--// Services
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")

--// Ensure single instance
local PREVIOUS = CoreGui:FindFirstChild("WizardLibrary")
if PREVIOUS then
    PREVIOUS:Destroy()
end

--// Root ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "WizardLibrary"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = (typeof(gethui) == "function" and gethui()) or CoreGui

--// Hotkey (RightCtrl) to show/hide
UserInputService.InputBegan:Connect(function(input, gp)
    if not gp and input.KeyCode == Enum.KeyCode.RightControl then
        ScreenGui.Enabled = not ScreenGui.Enabled
    end
end)

--// Style
local COLORS = {
    Window  = Color3.fromRGB(25, 25, 25),
    Body    = Color3.fromRGB(35, 35, 35),
    Track   = Color3.fromRGB(65, 65, 65),
    Accent  = Color3.fromRGB(255, 87, 87),
    Text    = Color3.fromRGB(255, 255, 255),
}

--// Helpers
local function corneredImage(parent, color, size, z)
    local img = Instance.new("ImageLabel")
    img.BackgroundTransparency = 1
    img.Image = "rbxassetid://3570695787"
    img.ScaleType = Enum.ScaleType.Slice
    img.SliceCenter = Rect.new(100, 100, 100, 100)
    img.SliceScale = 0.05
    img.ImageColor3 = color or COLORS.Body
    img.Size = size or UDim2.fromOffset(170, 30)
    img.ZIndex = z or 1
    img.Parent = parent
    return img
end

local function draggable(frame, handle)
    handle = handle or frame
    local dragging = false
    local dragInput, dragStart, startPos

    local function update(input)
        local delta = input.Position - dragStart
        frame.Position = UDim2.new(
            startPos.X.Scale, startPos.X.Offset + delta.X,
            startPos.Y.Scale, startPos.Y.Offset + delta.Y
        )
    end

    handle.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
            or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = frame.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    handle.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement
            or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            update(input)
        end
    end)
end

--// Library
local Library = {}

--// Creates a floating window with a topbar and a scroll-like body area (via grow/shrink).
function Library.NewWindow(title, position)
    title = title or "Window"
    position = position or UDim2.new(0, 40, 0, 40)

    -- Window container
    local window = corneredImage(ScreenGui, COLORS.Window, UDim2.fromOffset(170, 30), 2)
    window.Name = (title:gsub("%s+", "")) .. "_Window"
    window.Position = position

    -- Topbar
    local topbar = Instance.new("Frame")
    topbar.BackgroundTransparency = 1
    topbar.Size = UDim2.new(1, 0, 0, 30)
    topbar.ZIndex = 3
    topbar.Parent = window

    local titleLabel = Instance.new("TextLabel")
    titleLabel.BackgroundTransparency = 1
    titleLabel.Size = UDim2.new(1, -30, 1, 0)
    titleLabel.Font = Enum.Font.SourceSansBold
    titleLabel.Text = title
    titleLabel.TextColor3 = COLORS.Text
    titleLabel.TextSize = 17
    titleLabel.ZIndex = 3
    titleLabel.Parent = topbar

    local collapseBtn = Instance.new("TextButton")
    collapseBtn.BackgroundTransparency = 1
    collapseBtn.Size = UDim2.fromOffset(30, 30)
    collapseBtn.Position = UDim2.new(1, -30, 0, 0)
    collapseBtn.Font = Enum.Font.SourceSansSemibold
    collapseBtn.Text = "-"
    collapseBtn.TextColor3 = COLORS.Text
    collapseBtn.TextSize = 20
    collapseBtn.ZIndex = 3
    collapseBtn.Parent = topbar

    -- Body
    local body = corneredImage(window, COLORS.Body, UDim2.fromOffset(170, 0), 2)
    body.Name = "Body"
    body.Position = UDim2.new(0, 0, 0, 30)
    body.ClipsDescendants = true
    local bodyLayout = Instance.new("UIListLayout")
    bodyLayout.Parent = body
    bodyLayout.SortOrder = Enum.SortOrder.LayoutOrder

    local isOpen = true
    local contentHeight = 0

    local function tweenSizes(targetBodyHeight)
        TweenService:Create(body, TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Size = UDim2.new(0, 170, 0, targetBodyHeight)
        }):Play()
        TweenService:Create(window, TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Size = UDim2.new(0, 170, 0, 30 + targetBodyHeight)
        }):Play()
    end

    local function grow(delta)
        contentHeight += delta
        if isOpen then tweenSizes(contentHeight) end
    end

    local function shrink(delta)
        contentHeight -= delta
        if contentHeight < 0 then contentHeight = 0 end
        if isOpen then tweenSizes(contentHeight) end
    end

    collapseBtn.MouseButton1Click:Connect(function()
        isOpen = not isOpen
        collapseBtn.Text = isOpen and "-" or "v"
        if isOpen then
            tweenSizes(contentHeight)
        else
            tweenSizes(0)
        end
    end)

    draggable(window, topbar)

    --// Window API: sections
    local WindowAPI = {}

    function WindowAPI:NewSection(name)
        name = name or "Section"

        local section = Instance.new("Frame")
        section.BackgroundColor3 = COLORS.Body
        section.BorderSizePixel = 0
        section.ClipsDescendants = true
        section.Size = UDim2.new(0, 170, 0, 30)
        section.ZIndex = 2
        section.Parent = body
        grow(30)

        local info = Instance.new("Frame")
        info.BackgroundTransparency = 1
        info.Size = UDim2.new(1, 0, 0, 30)
        info.ZIndex = 3
        info.Parent = section

        local sectionTitle = Instance.new("TextLabel")
        sectionTitle.BackgroundTransparency = 1
        sectionTitle.Position = UDim2.new(0, 9, 0, 0)
        sectionTitle.Size = UDim2.new(1, -45, 1, 0)
        sectionTitle.Font = Enum.Font.SourceSansBold
        sectionTitle.Text = name
        sectionTitle.TextColor3 = COLORS.Text
        sectionTitle.TextSize = 17
        sectionTitle.TextXAlignment = Enum.TextXAlignment.Left
        sectionTitle.ZIndex = 3
        sectionTitle.Parent = info

        local toggleBtn = Instance.new("TextButton")
        toggleBtn.BackgroundTransparency = 1
        toggleBtn.Position = UDim2.new(1, -30, 0, 0)
        toggleBtn.Size = UDim2.fromOffset(30, 30)
        toggleBtn.Font = Enum.Font.SourceSansSemibold
        toggleBtn.Text = "v"
        toggleBtn.TextColor3 = COLORS.Text
        toggleBtn.TextSize = 14
        toggleBtn.ZIndex = 3
        toggleBtn.Parent = info

        local sectionLayout = Instance.new("UIListLayout")
        sectionLayout.Parent = section
        sectionLayout.SortOrder = Enum.SortOrder.LayoutOrder

        local sectionOpen = true
        local sectionContentHeight = 0

        local function sectionGrow(h)
            sectionContentHeight += h
            TweenService:Create(section, TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                Size = UDim2.new(0, 170, 0, 30 + sectionContentHeight)
            }):Play()
            if sectionOpen and isOpen then grow(h) end
        end

        local function sectionShrink(h)
            sectionContentHeight -= h
            if sectionContentHeight < 0 then sectionContentHeight = 0 end
            TweenService:Create(section, TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                Size = UDim2.new(0, 170, 0, 30 + sectionContentHeight)
            }):Play()
            if sectionOpen and isOpen then shrink(h) end
        end

        toggleBtn.MouseButton1Click:Connect(function()
            sectionOpen = not sectionOpen
            toggleBtn.Text = sectionOpen and "v" or "-"
            if sectionOpen then
                TweenService:Create(section, TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                    Size = UDim2.new(0, 170, 0, 30 + sectionContentHeight)
                }):Play()
                if isOpen then grow(sectionContentHeight) end
            else
                if isOpen then shrink(sectionContentHeight) end
                TweenService:Create(section, TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                    Size = UDim2.new(0, 170, 0, 30)
                }):Play()
            end
        end)

        --// Controls API
        local SectionAPI = {}

        function SectionAPI:CreateToggle(text, default, callback)
            text = text or "Toggle"
            local row = Instance.new("Frame")
            row.BackgroundColor3 = COLORS.Body
            row.BorderSizePixel = 0
            row.Size = UDim2.new(0, 170, 0, 30)
            row.Parent = section
            sectionGrow(30)

            local label = Instance.new("TextLabel")
            label.BackgroundTransparency = 1
            label.Position = UDim2.new(0, 9, 0, 0)
            label.Size = UDim2.new(1, -55, 1, 0)
            label.Font = Enum.Font.SourceSansBold
            label.Text = text
            label.TextColor3 = COLORS.Text
            label.TextSize = 17
            label.TextXAlignment = Enum.TextXAlignment.Left
            label.Parent = row

            local bg = corneredImage(row, COLORS.Track, UDim2.fromOffset(20, 20), 3)
            bg.Position = UDim2.new(1, -25, 0, 5)

            local knob = corneredImage(bg, COLORS.Accent, UDim2.fromOffset(16, 16), 4)
            knob.Position = UDim2.new(0, 2, 0, 2)
            knob.ImageTransparency = 1

            local state = default and true or false
            local function setState(v)
                state = v and true or false
                TweenService:Create(knob, TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                    ImageTransparency = state and 0 or 1
                }):Play()
                if callback then task.spawn(callback, state) end
            end
            setState(state)

            knob.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    setState(not state)
                end
            end)

            return {
                Set = setState,
                Get = function() return state end,
                Destroy = function()
                    sectionShrink(30)
                    row:Destroy()
                end,
            }
        end

        function SectionAPI:CreateSlider(text, min, max, default, wholeNumbers, callback)
            text = text or "Slider"
            min = tonumber(min) or 0
            max = tonumber(max) or 100
            local value = tonumber(default) or min

            local row = Instance.new("Frame")
            row.BackgroundColor3 = COLORS.Body
            row.BorderSizePixel = 0
            row.Size = UDim2.new(0, 170, 0, 30)
            row.Parent = section
            sectionGrow(30)

            local label = Instance.new("TextLabel")
            label.BackgroundTransparency = 1
            label.Position = UDim2.new(0, 9, 0, 0)
            label.Size = UDim2.new(0, 125, 0, 15)
            label.Text = text
            label.Font = Enum.Font.SourceSansSemibold
            label.TextColor3 = COLORS.Text
            label.TextSize = 17
            label.TextXAlignment = Enum.TextXAlignment.Left
            label.Parent = row

            local valueBox = corneredImage(row, COLORS.Track, UDim2.fromOffset(35, 15), 3)
            valueBox.Position = UDim2.new(1, -45, 0, 0)
            valueBox.ImageTransparency = 0.5

            local valueText = Instance.new("TextLabel")
            valueText.BackgroundTransparency = 1
            valueText.Size = UDim2.fromOffset(35, 15)
            valueText.Font = Enum.Font.SourceSansSemibold
            valueText.TextColor3 = COLORS.Text
            valueText.TextSize = 14
            valueText.Text = ""
            valueText.Parent = valueBox

            local track = corneredImage(row, COLORS.Track, UDim2.fromOffset(153, 5), 3)
            track.Position = UDim2.new(0, 9, 0, 20)
            track.ImageTransparency = 0.5
            track.ClipsDescendants = true

            local fill = corneredImage(track, COLORS.Accent, UDim2.new(0, 0, 0, 5), 4)

            local dragging = false
            local function setValueFromAlpha(alpha)
                alpha = math.clamp(alpha, 0, 1)
                local v = min + (max - min) * alpha
                if wholeNumbers then v = math.floor(v + 0.5) end
                value = tonumber(string.format("%.2f", v))
                valueText.Text = tostring(value)
                TweenService:Create(fill, TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                    Size = UDim2.new(alpha, 0, 0, 5)
                }):Play()
                if callback then task.spawn(callback, value) end
            end

            setValueFromAlpha((value - min) / (max - min))

            track.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    dragging = true
                    local alpha = (input.Position.X - track.AbsolutePosition.X) / track.AbsoluteSize.X
                    setValueFromAlpha(alpha)
                end
            end)
            track.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    dragging = false
                end
            end)

            UserInputService.InputChanged:Connect(function(input)
                if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                    local alpha = (input.Position.X - track.AbsolutePosition.X) / track.AbsoluteSize.X
                    setValueFromAlpha(alpha)
                end
            end)

            return {
                Set = function(v) setValueFromAlpha((v - min) / (max - min)) end,
                Get = function() return value end,
                Destroy = function()
                    sectionShrink(30)
                    row:Destroy()
                end,
            }
        end

        function SectionAPI:CreateColorPicker(text, defaultColor, callback)
            text = text or "Color"
            defaultColor = defaultColor or Color3.new(1, 1, 1)

            local row = Instance.new("Frame")
            row.BackgroundColor3 = COLORS.Body
            row.BorderSizePixel = 0
            row.Size = UDim2.new(0, 170, 0, 30)
            row.Parent = section
            sectionGrow(30)

            local title = Instance.new("TextLabel")
            title.BackgroundTransparency = 1
            title.Position = UDim2.new(0, 9, 0, 0)
            title.Size = UDim2.new(1, -55, 1, 0)
            title.Font = Enum.Font.SourceSansBold
            title.Text = text
            title.TextColor3 = COLORS.Text
            title.TextSize = 17
            title.TextXAlignment = Enum.TextXAlignment.Left
            title.Parent = row

            local preview = corneredImage(row, defaultColor, UDim2.fromOffset(22, 20), 3)
            preview.Position = UDim2.new(1, -27, 0, 5)

            local popup = corneredImage(row, COLORS.Body, UDim2.fromOffset(0, 175), 10)
            popup.Position = UDim2.new(1, 5, 0, -140)
            popup.ZIndex = 10
            popup.ClipsDescendants = true

            local H, S, V = defaultColor:ToHSV()
            local rainbow = false

            local svHolder = corneredImage(popup, COLORS.Body, UDim2.fromOffset(122, 114), 11)
            svHolder.Position = UDim2.new(0, 7, 0, 6)

            local svImage = Instance.new("ImageLabel")
            svImage.BackgroundTransparency = 1
            svImage.Size = UDim2.fromScale(1, 1)
            svImage.Image = "rbxassetid://4805274903"
            svImage.ImageColor3 = Color3.fromHSV(H, 1, 1)
            svImage.ZIndex = 12
            svImage.Parent = svHolder

            local svMarker = Instance.new("ImageLabel")
            svMarker.BackgroundTransparency = 1
            svMarker.Size = UDim2.fromOffset(0, 0)
            svMarker.Image = "http://www.roblox.com/asset/?id=4805639000"
            svMarker.ZIndex = 13
            svMarker.Parent = svHolder

            local hueHolder = corneredImage(popup, COLORS.Body, UDim2.fromOffset(28, 114), 11)
            hueHolder.Position = UDim2.new(0, 136, 0, 6)

            local hueStrip = Instance.new("ImageLabel")
            hueStrip.BackgroundTransparency = 1
            hueStrip.Size = UDim2.fromScale(1, 1)
            hueStrip.Image = "http://www.roblox.com/asset/?id=4801885250"
            hueStrip.ZIndex = 12
            hueStrip.Parent = hueHolder

            local hueMarker = Instance.new("Frame")
            hueMarker.BackgroundColor3 = Color3.fromRGB(75, 75, 75)
            hueMarker.BorderSizePixel = 0
            hueMarker.Size = UDim2.fromOffset(42, 5)
            hueMarker.Position = UDim2.new(-0.25, 0, (1 - H), 0)
            hueMarker.ZIndex = 13
            hueMarker.Parent = hueHolder

            local rgbR = Instance.new("TextLabel"); rgbR.Parent = popup
            local rgbG = Instance.new("TextLabel"); rgbG.Parent = popup
            local rgbB = Instance.new("TextLabel"); rgbB.Parent = popup
            for _, lbl in ipairs({rgbR, rgbG, rgbB}) do
                lbl.BackgroundTransparency = 1
                lbl.Font = Enum.Font.SourceSansBold
                lbl.TextColor3 = COLORS.Text
                lbl.TextSize = 14
                lbl.ZIndex = 12
            end
            rgbR.Position = UDim2.new(0, 7, 0, 127); rgbR.Size = UDim2.fromOffset(50, 16)
            rgbG.Position = UDim2.new(0, 60, 0, 127); rgbG.Size = UDim2.fromOffset(51, 16)
            rgbB.Position = UDim2.new(0, 114, 0, 127); rgbB.Size = UDim2.fromOffset(50, 16)

            local function updateRGBLabels(color)
                rgbR.Text = ("R: %03d"):format(math.floor(color.R * 255))
                rgbG.Text = ("G: %03d"):format(math.floor(color.G * 255))
                rgbB.Text = ("B: %03d"):format(math.floor(color.B * 255))
            end

            local function applyColor()
                local color = Color3.fromHSV(H, S, V)
                preview.ImageColor3 = color
                svImage.ImageColor3 = Color3.fromHSV(H, 1, 1)
                updateRGBLabels(color)
                if callback then task.spawn(callback, color) end
            end

            applyColor()

            local popupOpen = false
            local function setPopup(open)
                popupOpen = open
                local target = open and 171 or 0
                TweenService:Create(popup, TweenInfo.new(0.35, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                    Size = UDim2.fromOffset(target, 175)
                }):Play()
            end

            preview.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    setPopup(not popupOpen)
                end
            end)

            local rbwRow = Instance.new("Frame")
            rbwRow.BackgroundTransparency = 1
            rbwRow.Size = UDim2.new(1, 0, 0, 30)
            rbwRow.Position = UDim2.new(0, 0, 0, 145)
            rbwRow.ZIndex = 12
            rbwRow.Parent = popup

            local rbwText = Instance.new("TextLabel")
            rbwText.BackgroundTransparency = 1
            rbwText.Position = UDim2.new(0, 9, 0, 0)
            rbwText.Size = UDim2.new(1, -55, 1, 0)
            rbwText.Font = Enum.Font.SourceSansBold
            rbwText.Text = "Rainbow"
            rbwText.TextColor3 = COLORS.Text
            rbwText.TextSize = 17
            rbwText.TextXAlignment = Enum.TextXAlignment.Left
            rbwText.ZIndex = 12
            rbwText.Parent = rbwRow

            local rbwBg = corneredImage(rbwRow, COLORS.Track, UDim2.fromOffset(20, 20), 13)
            rbwBg.Position = UDim2.new(1, -25, 0, 5)

            local rbwKnob = corneredImage(rbwBg, COLORS.Accent, UDim2.fromOffset(16, 16), 14)
            rbwKnob.Position = UDim2.new(0, 2, 0, 2)
            rbwKnob.ImageTransparency = 1

            local function setRainbow(on)
                rainbow = on and true or false
                TweenService:Create(rbwKnob, TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                    ImageTransparency = rainbow and 0 or 1
                }):Play()
            end
            setRainbow(false)

            rbwKnob.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    setRainbow(not rainbow)
                end
            end)

            -- SV & Hue interactions
            local svDragging, hueDragging = false, false

            local function svToAlpha(x, y)
                local aX = math.clamp((x - svHolder.AbsolutePosition.X) / svHolder.AbsoluteSize.X, 0, 1)
                local aY = math.clamp((y - svHolder.AbsolutePosition.Y) / svHolder.AbsoluteSize.Y, 0, 1)
                return aX, 1 - aY
            end

            svHolder.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    svDragging = true
                    local aX, v = svToAlpha(input.Position.X, input.Position.Y)
                    S, V = aX, v
                    svMarker.Position = UDim2.new(aX, 0, 1 - v, 0)
                    applyColor()
                end
            end)
            svHolder.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    svDragging = false
                end
            end)

            hueHolder.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    hueDragging = true
                    local y = math.clamp((input.Position.Y - hueHolder.AbsolutePosition.Y) / hueHolder.AbsoluteSize.Y, 0, 1)
                    H = 1 - y
                    hueMarker.Position = UDim2.new(-0.25, 0, y, 0)
                    applyColor()
                end
            end)
            hueHolder.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    hueDragging = false
                end
            end)

            UserInputService.InputChanged:Connect(function(input)
                if input.UserInputType ~= Enum.UserInputType.MouseMovement then return end
                if svDragging then
                    local aX, v = svToAlpha(input.Position.X, input.Position.Y)
                    S, V = aX, v
                    svMarker.Position = UDim2.new(aX, 0, 1 - v, 0)
                    applyColor()
                elseif hueDragging then
                    local y = math.clamp((input.Position.Y - hueHolder.AbsolutePosition.Y) / hueHolder.AbsoluteSize.Y, 0, 1)
                    H = 1 - y
                    hueMarker.Position = UDim2.new(-0.25, 0, y, 0)
                    applyColor()
                end
            end)

            RunService.RenderStepped:Connect(function()
                if rainbow then
                    local t = (tick() % 5) / 5
                    H = t
                    applyColor()
                end
            end)

            local function setColor(c)
                H, S, V = c:ToHSV()
                applyColor()
            end

            return {
                Set = setColor,
                Get = function() return Color3.fromHSV(H, S, V) end,
                SetRainbow = setRainbow,
                Destroy = function()
                    sectionShrink(30)
                    row:Destroy()
                end,
            }
        end

        
        function SectionAPI:CreateButton(text, callback)
            text = text or "Button"
            local row = Instance.new("Frame")
            row.BackgroundColor3 = COLORS.Body
            row.BorderSizePixel = 0
            row.Size = UDim2.new(0, 170, 0, 30)
            row.Parent = section
            sectionGrow(30)

            local button = Instance.new("TextButton")
            button.BackgroundColor3 = COLORS.Accent
            button.Size = UDim2.new(1, -20, 1, -6)
            button.Position = UDim2.new(0, 10, 0, 3)
            button.Font = Enum.Font.SourceSansBold
            button.Text = text
            button.TextColor3 = COLORS.Text
            button.TextSize = 17
            button.Parent = row

            button.MouseButton1Click:Connect(function()
                if callback then task.spawn(callback) end
            end)

            return {
                SetText = function(newText) button.Text = newText end,
                Destroy = function()
                    sectionShrink(30)
                    row:Destroy()
                end
            }
        end

        return SectionAPI
    end

    return WindowAPI
end

return Library
