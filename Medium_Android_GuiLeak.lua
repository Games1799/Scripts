-- Madium Android arm64 lua

repeat task.wait() until game:IsLoaded()
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Stats = game:GetService("Stats")
local TweenService = game:GetService("TweenService")
local TextService = game:GetService("TextService")
local UserInputService = game:GetService("UserInputService")
local localPlayer = Players.LocalPlayer
local environment = if getgenv then getgenv() else _G
local function getGlobal(name)
    return rawget(environment, name) or rawget(_G, name)
local function resolveGuiParent()
    --[[
    local getHiddenUi = getGlobal("gethui")
    if type(getHiddenUi) == "function" then
        local ok, result = pcall(getHiddenUi)
        if ok and result then
            return result
        end
    end
    ]]
    local ok, coreGui = pcall(game.GetService, game, "CoreGui")
    if ok and coreGui then
        return coreGui
    end
    return localPlayer:WaitForChild("PlayerGui")
local guiParent = resolveGuiParent()
local previous = guiParent:FindFirstChild("MadiumMonochrome")
if previous then
    previous:Destroy()
local Theme = {
    Background = Color3.fromRGB(11, 12, 14),
    Window = Color3.fromRGB(15, 16, 19),
    Rail = Color3.fromRGB(18, 19, 22),
    Surface = Color3.fromRGB(20, 21, 24),
    SurfaceHigh = Color3.fromRGB(32, 34, 39),
    SurfaceLow = Color3.fromRGB(13, 14, 17),
    Stroke = Color3.fromRGB(53, 55, 63),
    StrokeSoft = Color3.fromRGB(36, 38, 44),
    Text = Color3.fromRGB(235, 236, 240),
    Muted = Color3.fromRGB(174, 180, 191),
    Dim = Color3.fromRGB(139, 147, 160),
    White = Color3.fromRGB(249, 249, 251),
    Black = Color3.fromRGB(10, 11, 13),
local Fonts = {
    Regular = Font.new("rbxasset://fonts/families/BuilderSans.json", Enum.FontWeight.Regular),
    Medium = Font.new("rbxasset://fonts/families/BuilderSans.json", Enum.FontWeight.Medium),
    SemiBold = Font.new("rbxasset://fonts/families/BuilderSans.json", Enum.FontWeight.SemiBold),
    Code = Font.new("rbxasset://fonts/families/RobotoMono.json", Enum.FontWeight.Regular),
-- 48px source sprites stay crisp at 18-24px, including high-density mobile screens.
-- https://github.com/latte-soft/lucide-roblox (full license notice at the end of this file).
local Icons = {
    ["square-m"] = { 16898613777, 306, 967 },
    ["square-code"] = { 16898613777, 820, 196 },
    ["file-code-2"] = { 16898613353, 918, 0 },
    ["folder"] = { 16898613353, 404, 967 },
    ["settings-2"] = { 16898613777, 0, 771 },
    ["trash-2"] = { 16898613869, 257, 918 },
    ["clipboard-paste"] = { 16898613044, 514, 869 },
    ["play"] = { 16898613699, 918, 257 },
    ["plus"] = { 16898613699, 257, 918 },
    ["layout-grid"] = { 16898613509, 918, 404 },
    ["grip-horizontal"] = { 16898613509, 49, 820 },
local connections = {}
local destroyed = false
local function connect(signal, callback)
    local connection = signal:Connect(callback)
    table.insert(connections, connection)
    return connection
local function create(className, properties, parent)
    local object = Instance.new(className)
    for property, value in pairs(properties or {}) do
        object[property] = value
    end
    object.Parent = parent
    return object
local function addCorner(object, radius)
    return create("UICorner", { CornerRadius = UDim.new(0, radius) }, object)
local function addStroke(object, color, transparency, thickness)
    return create("UIStroke", {
        Color = color or Theme.Stroke,
        Transparency = transparency or 0,
        Thickness = thickness or 1,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
    }, object)
local function addGradient(object, top, bottom, rotation)
    return create("UIGradient", {
        Color = ColorSequence.new(top, bottom),
        Rotation = rotation or 90,
    }, object)
local function tween(object, duration, properties)
    local animation = TweenService:Create(
        object,
        TweenInfo.new(duration, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
        properties
    )
    animation:Play()
    return animation
local function label(properties, parent)
    properties.BackgroundTransparency = 1
    properties.BorderSizePixel = 0
    properties.FontFace = properties.FontFace or Fonts.Regular
    properties.TextColor3 = properties.TextColor3 or Theme.Text
    return create("TextLabel", properties, parent)
local function button(properties, parent)
    properties.AutoButtonColor = false
    properties.BorderSizePixel = 0
    properties.FontFace = properties.FontFace or Fonts.Medium
    properties.TextColor3 = properties.TextColor3 or Theme.Text
    return create("TextButton", properties, parent)
-- Material-inspired primitives: one icon family, stable sizes, tap feedback.
local function divider(parent, position, size)
    return create("Frame", {
        Name = "Divider", Position = position, Size = size,
        BackgroundColor3 = Theme.StrokeSoft, BorderSizePixel = 0,
    }, parent)
local function imageIcon(parent, name, size, color)
    local asset = assert(Icons[name], "Unknown icon: " .. name)
    return create("ImageLabel", {
        Name = "Icon", AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromOffset(size or 22, size or 22),
        BackgroundTransparency = 1, BorderSizePixel = 0,
        Image = "rbxassetid://" .. tostring(asset[1]), ImageRectSize = Vector2.new(48, 48),
        ImageRectOffset = Vector2.new(asset[2], asset[3]), ImageColor3 = color or Theme.Muted,
        ScaleType = Enum.ScaleType.Fit,
    }, parent)
local function tapFeedback(control)
    local feedback = addStroke(control, Theme.White, 1, 1)
    connect(control.Activated, function()
        feedback.Transparency = 0.65
        tween(feedback, 0.24, { Transparency = 1 })
    end)
local function makePanel(parent, position, size, radius)
    local panel = create("Frame", {
        Position = position, Size = size, BackgroundColor3 = Theme.Surface,
        BorderSizePixel = 0,
    }, parent)
    addCorner(panel, radius or 18)
    addStroke(panel, Theme.StrokeSoft, 0, 1)
    return panel
local function actionButton(parent, name, title, iconName, primary)
    local control = button({
        Name = name, Size = UDim2.fromOffset(144, 52), Text = "",
        BackgroundColor3 = if primary then Theme.White else Theme.SurfaceHigh,
    }, parent)
    addCorner(control, 12)
    if not primary then addStroke(control, Theme.Stroke, 0.15) end
    local group = create("Frame", {
        Name = "Content", Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1,
        BorderSizePixel = 0,
    }, control)
    create("UIListLayout", {
        FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Center,
        VerticalAlignment = Enum.VerticalAlignment.Center, SortOrder = Enum.SortOrder.LayoutOrder,
        Padding = UDim.new(0, 8),
    }, group)
    local icon = imageIcon(group, iconName, 20, if primary then Theme.Black else Theme.Text)
    icon.AnchorPoint, icon.Position, icon.LayoutOrder = Vector2.new(), UDim2.new(), 1
    label({
        Name = "Caption", LayoutOrder = 2, Size = UDim2.fromOffset(0, 22),
        AutomaticSize = Enum.AutomaticSize.X, Text = title, TextSize = 14,
        FontFace = Fonts.Medium, TextColor3 = if primary then Theme.Black else Theme.Text,
    }, group)
    tapFeedback(control)
    return control
local function railButton(parent, name, title, iconName)
    local control = button({
        Name = name, Size = UDim2.fromOffset(68, 68), Text = "",
        BackgroundColor3 = Theme.SurfaceHigh, BackgroundTransparency = 1,
    }, parent)
    addCorner(control, 12)
    local icon = imageIcon(control, iconName, 24)
    icon.Position = UDim2.new(0.5, 0, 0, 23)
    local caption = label({
        Name = "Caption", Position = UDim2.new(0, 0, 1, -26), Size = UDim2.new(1, 0, 0, 20),
        Text = title, TextSize = 12, FontFace = Fonts.Medium, TextColor3 = Theme.Muted,
    }, control)
    tapFeedback(control)
    return control, icon, caption
local screenGui = create("ScreenGui", {
    Name = "MadiumMonochrome",
    ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets,
    ResetOnSpawn = false,
    ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
    DisplayOrder = 999999,
}, guiParent)
local synTable = rawget(environment, "syn")
if type(synTable) == "table" and type(synTable.protect_gui) == "function" then
    pcall(synTable.protect_gui, screenGui)
local root = create("Frame", {
    Name = "Root", AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5),
    Size = UDim2.new(1, -24, 1, -24), BackgroundColor3 = Theme.Background,
    BorderSizePixel = 0, ClipsDescendants = true,
}, screenGui)
addCorner(root, 20)
-- A sibling of Root: hiding the workspace must never hide its launcher.
local launcher = button({
    Name = "MadiumToggle", AnchorPoint = Vector2.new(0.5, 0), Position = UDim2.new(0.5, 0, 0, 8),
    Size = UDim2.fromOffset(52, 52), Text = "", BackgroundColor3 = Theme.SurfaceHigh,
    Active = true, ZIndex = 100,
}, screenGui)
addCorner(launcher, 18)
local launcherBorder = addStroke(launcher, Theme.White, 0.5)
imageIcon(launcher, "square-m", 32, Theme.White)
tapFeedback(launcher)
-- Shipped Roblox image textures: no uploaded background or external loader needed.
local background = create("Frame", {
    Name = "MeshBackground", Size = UDim2.fromScale(1, 1), BackgroundColor3 = Theme.Background,
    BorderSizePixel = 0, ZIndex = 1,
}, root)
addCorner(background, 20)
addGradient(background, Color3.fromRGB(19, 20, 23), Color3.fromRGB(9, 10, 12), 125)
local function textureLayer(name, image, transparency, color, tile)
    local layer = create("ImageLabel", {
        Name = name, Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1, BorderSizePixel = 0,
        Image = image, ImageColor3 = color, ImageTransparency = transparency,
        ScaleType = if tile then Enum.ScaleType.Tile else Enum.ScaleType.Stretch,
        TileSize = UDim2.fromOffset(tile or 32, tile or 32),
    }, background)
    addCorner(layer, 20)
    return layer
textureLayer("RadialMeshGlow", "rbxasset://textures/shadowblurmask.png", 0.62, Color3.fromRGB(52, 54, 60))
textureLayer("DitherMicroGrid", "rbxasset://textures/ui/traildot.png", 0.88, Theme.Black, 5)
textureLayer("FineFilmGrain", "rbxasset://textures/noise.dds", 0.972, Theme.White, 64)
textureLayer("SoftVignette", "rbxasset://textures/loading/loadingvignette.png", 0.68, Theme.Black)
local window = create("Frame", {
    Name = "Workspace", Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1,
    BorderSizePixel = 0, ZIndex = 2,
}, root)
addCorner(window, 20)
addStroke(window, Theme.Stroke, 0.48)
local rail = makePanel(window, UDim2.fromOffset(12, 12), UDim2.new(0, 84, 1, -24))
rail.Name = "NavigationRail"
local brand = create("Frame", {
    Name = "MadiumBrand", Position = UDim2.new(0.5, -22, 0, 16), Size = UDim2.fromOffset(44, 44),
    BackgroundTransparency = 1, BorderSizePixel = 0,
}, rail)
imageIcon(brand, "square-m", 36, Theme.White)
label({
    Name = "BrandCaption",
    Position = UDim2.fromOffset(0, 64), Size = UDim2.new(1, 0, 0, 18), Text = "MADIUM",
    FontFace = Fonts.SemiBold, TextSize = 11, TextColor3 = Theme.Text,
}, rail)
local windowOffset = Vector2.new()
local layoutViewport = Vector2.new()
local dragDetectors = {}
local activeDrag
local dragStart, dragOrigin
local function stopDrag()
    local detector = activeDrag
    activeDrag, dragStart, dragOrigin = nil, nil, nil
    if detector then
        detector.Enabled = false
        detector.Enabled = root.Visible and screenGui.Enabled and not destroyed
    end
local function positionWindow(offset)
    local viewport = screenGui.AbsoluteSize
    local limitX = math.max(0, math.floor((viewport.X - root.Size.X.Offset) / 2 - 12))
    local limitY = math.max(0, math.floor((viewport.Y - root.Size.Y.Offset) / 2 - 12))
    windowOffset = Vector2.new(
        math.clamp(math.round(offset.X), -limitX, limitX),
        math.clamp(math.round(offset.Y), -limitY, limitY)
    )
    root.Position = UDim2.new(0.5, windowOffset.X, 0.5, windowOffset.Y)
-- Native detectors own touch/mouse capture instead of a transparent Frame and
-- manual InputObject matching. Only header buttons receive a detector.
local function makeDragHandle(parent, name, position, size)
    local handle = button({
        Name = name, Position = position, Size = size, Text = "",
        BackgroundTransparency = 1, Active = true, Selectable = false, ZIndex = 5,
    }, parent)
    local detector = create("UIDragDetector", {
        Name = "WindowDrag", DragStyle = Enum.UIDragDetectorDragStyle.TranslatePlane,
        ResponseStyle = Enum.UIDragDetectorResponseStyle.CustomOffset,
        Enabled = true,
    }, handle)
    table.insert(dragDetectors, detector)
    connect(detector.DragStart, function(inputPosition)
        if activeDrag or not root.Visible or not screenGui.Enabled or destroyed then return end
        activeDrag, dragStart, dragOrigin = detector, inputPosition, windowOffset
    end)
    connect(detector.DragContinue, function(inputPosition)
        if activeDrag ~= detector then return end
        positionWindow(dragOrigin + inputPosition - dragStart)
    end)
    connect(detector.DragEnd, function()
        if activeDrag == detector then stopDrag() end
    end)
    return handle
makeDragHandle(rail, "DragHandle", UDim2.fromOffset(4, 8), UDim2.new(1, -8, 0, 78))
local function syncWindowVisibility()
    stopDrag()
    local enabled = root.Visible and screenGui.Enabled and not destroyed
    for _, detector in ipairs(dragDetectors) do detector.Enabled = enabled end
    launcherBorder.Transparency = if root.Visible then 0.5 else 0.8
    launcher:SetAttribute("WindowOpen", root.Visible)
local function setWindowVisible(visible)
    if destroyed then return end
    root.Visible = visible
    if visible then positionWindow(windowOffset) end
connect(launcher.Activated, function() setWindowVisible(not root.Visible) end)
connect(UserInputService.WindowFocusReleased, stopDrag)
connect(screenGui:GetPropertyChangedSignal("Enabled"), syncWindowVisibility)
connect(root:GetPropertyChangedSignal("Visible"), syncWindowVisibility)
connect(screenGui.Destroying, stopDrag)
syncWindowVisibility()
local body = create("Frame", {
    Name = "Body", Position = UDim2.fromOffset(108, 12), Size = UDim2.new(1, -120, 1, -24),
    BackgroundTransparency = 1, BorderSizePixel = 0,
}, window)
local pages, navButtons = {}, {}
local activePage = "Editor"
local function setNavVisual(name, selected)
    local nav = navButtons[name]
    if not nav then return end
    tween(nav.button, 0.16, {
        BackgroundColor3 = if selected then Theme.White else Theme.SurfaceHigh,
        BackgroundTransparency = if selected then 0 else 1,
    })
    local color = if selected then Theme.Black else Theme.Muted
    tween(nav.icon, 0.16, { ImageColor3 = color })
    tween(nav.caption, 0.16, { TextColor3 = color })
local function showPage(name)
    activePage = name
    for pageName, page in pairs(pages) do
        page.Visible = pageName == name
        setNavVisual(pageName, pageName == name)
    end
for index, data in ipairs({
    { "Editor", "square-code" }, { "Files", "folder" },
    { "Editor", "square-code" },
    { "Scripts", "layout-grid" }, { "Settings", "settings-2" },
}) do
    local control, icon, caption = railButton(rail, data[1], data[1], data[2])
    control.Position = UDim2.fromOffset(6, 108 + (index - 1) * 84)
    control.Size = UDim2.new(1, -12, 0, 72)
    navButtons[data[1]] = { button = control, icon = icon, caption = caption }
    connect(control.Activated, function() showPage(data[1]) end)
local consoleLines, consoleText = {}, nil
local autoClearConsole = false
local function log(kind, message)
    table.insert(consoleLines, string.format("%s  %s\n%s", os.date("%H:%M:%S"), string.upper(kind), tostring(message)))
    if #consoleLines > 80 then table.remove(consoleLines, 1) end
    if consoleText then consoleText.Text = table.concat(consoleLines, "\n\n") end
local editorPage = create("Frame", {
    Name = "EditorPage", Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1, BorderSizePixel = 0,
}, body)
pages.Editor = editorPage
local statusPanel = makePanel(editorPage, UDim2.new(), UDim2.fromOffset(244, 156))
statusPanel.Name = "NetworkPanel"
label({
    Name = "NetworkTitle",
    Position = UDim2.fromOffset(18, 16), Size = UDim2.new(1, -36, 0, 25),
    Text = "Network", TextSize = 18, FontFace = Fonts.SemiBold, TextXAlignment = Enum.TextXAlignment.Left,
}, statusPanel)
label({
    Name = "NetworkSubtitle",
    Position = UDim2.fromOffset(18, 45), Size = UDim2.new(1, -36, 0, 20),
    Text = "Client status", TextSize = 13, TextColor3 = Theme.Muted, TextXAlignment = Enum.TextXAlignment.Left,
}, statusPanel)
local networkHandle = makeDragHandle(statusPanel, "NetworkDragHandle", UDim2.fromOffset(8, 8), UDim2.new(1, -16, 0, 48))
local networkGrip = imageIcon(networkHandle, "grip-horizontal", 18, Theme.Dim)
networkGrip.Position = UDim2.new(1, -16, 0.5, 0)
local metrics = create("Frame", {
    Name = "Metrics", Position = UDim2.fromOffset(12, 86), Size = UDim2.new(1, -24, 0, 52),
    BackgroundColor3 = Theme.SurfaceLow, BorderSizePixel = 0,
}, statusPanel)
addCorner(metrics, 12)
local metricLabels = {}
for index, name in ipairs({ "FPS", "PING", "PLAYERS" }) do
    metricLabels[name] = label({
        Name = name .. "Metric", Position = UDim2.new((index - 1) / 3, 0, 0, 0),
        Size = UDim2.new(1 / 3, 0, 1, 0), Text = "-- " .. name,
        TextSize = 11, FontFace = Fonts.Medium, TextColor3 = Theme.Muted,
    }, metrics)
local function refreshPlayerCount()
    local count = #Players:GetPlayers()
    metricLabels.PLAYERS.Text = string.format("%d %s", count, if count == 1 then "PLAYER" else "PLAYERS")
local consolePanel = makePanel(editorPage, UDim2.fromOffset(0, 168), UDim2.new(0, 244, 1, -168))
consolePanel.Name = "ConsolePanel"
label({
    Position = UDim2.fromOffset(18, 16), Size = UDim2.new(1, -82, 0, 28),
    Text = "Console", TextSize = 18, FontFace = Fonts.SemiBold, TextXAlignment = Enum.TextXAlignment.Left,
}, consolePanel)
makeDragHandle(consolePanel, "ConsoleDragHandle", UDim2.fromOffset(8, 8), UDim2.new(1, -76, 0, 48))
local clearConsole = button({
    Name = "ClearConsole", Position = UDim2.new(1, -56, 0, 8), Size = UDim2.fromOffset(48, 48),
    BackgroundColor3 = Theme.SurfaceHigh, BackgroundTransparency = 1, Text = "",
}, consolePanel)
addCorner(clearConsole, 12)
imageIcon(clearConsole, "trash-2", 20)
tapFeedback(clearConsole)
divider(consolePanel, UDim2.fromOffset(16, 62), UDim2.new(1, -32, 0, 1))
local consoleScroll = create("ScrollingFrame", {
    Name = "ConsoleOutput", Position = UDim2.fromOffset(16, 78), Size = UDim2.new(1, -32, 1, -94),
    BackgroundTransparency = 1, BorderSizePixel = 0, CanvasSize = UDim2.new(),
    AutomaticCanvasSize = Enum.AutomaticSize.Y, ScrollBarThickness = 3, ScrollBarImageColor3 = Theme.Dim,
}, consolePanel)
consoleText = label({
    Name = "ConsoleText", Size = UDim2.new(1, -8, 0, 0), AutomaticSize = Enum.AutomaticSize.Y,
    Text = "", TextSize = 12, FontFace = Fonts.Code, LineHeight = 1.35, TextWrapped = true,
    TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Top, TextColor3 = Theme.Muted,
}, consoleScroll)
connect(clearConsole.Activated, function() table.clear(consoleLines) consoleText.Text = "" end)
local editorPanel = makePanel(editorPage, UDim2.fromOffset(256, 0), UDim2.new(1, -256, 1, 0))
editorPanel.Name = "EditorSurface"
local tabbar = create("Frame", {
    Name = "EditorTabs", Size = UDim2.new(1, 0, 0, 68), BackgroundTransparency = 1, BorderSizePixel = 0,
}, editorPanel)
local tabsHolder = create("ScrollingFrame", {
    Name = "TabList", Position = UDim2.fromOffset(12, 12), Size = UDim2.new(1, -76, 0, 48),
    BackgroundTransparency = 1, BorderSizePixel = 0, CanvasSize = UDim2.new(),
    AutomaticCanvasSize = Enum.AutomaticSize.X, ScrollingDirection = Enum.ScrollingDirection.X,
    ScrollBarThickness = 2, ScrollBarImageColor3 = Theme.Dim,
}, tabbar)
create("UIListLayout", {
    FillDirection = Enum.FillDirection.Horizontal, SortOrder = Enum.SortOrder.LayoutOrder,
    Padding = UDim.new(0, 8), VerticalAlignment = Enum.VerticalAlignment.Center,
}, tabsHolder)
local addTabButton = button({
    Name = "NewTab", Position = UDim2.new(1, -60, 0, 12), Size = UDim2.fromOffset(48, 48),
    BackgroundColor3 = Theme.SurfaceHigh, Text = "",
}, tabbar)
addCorner(addTabButton, 12)
imageIcon(addTabButton, "plus", 22, Theme.Text)
tapFeedback(addTabButton)
divider(editorPanel, UDim2.fromOffset(16, 68), UDim2.new(1, -32, 0, 1))
local gutter = create("Frame", {
    Name = "LineNumberGutter", Position = UDim2.fromOffset(12, 82), Size = UDim2.new(0, 42, 1, -194),
    BackgroundTransparency = 1, BorderSizePixel = 0, ClipsDescendants = true,
}, editorPanel)
local lineNumbers = label({
    Name = "LineNumbers", Position = UDim2.fromOffset(0, 12), Size = UDim2.fromOffset(34, 300),
    Text = "1", TextSize = 16, FontFace = Fonts.Code, LineHeight = 1.5,
    TextXAlignment = Enum.TextXAlignment.Right, TextYAlignment = Enum.TextYAlignment.Top, TextColor3 = Theme.Dim,
}, gutter)
local editorViewport = create("ScrollingFrame", {
    Name = "EditorViewport", Position = UDim2.fromOffset(54, 82), Size = UDim2.new(1, -68, 1, -194),
    BackgroundTransparency = 1, BorderSizePixel = 0, CanvasSize = UDim2.new(),
    ScrollingDirection = Enum.ScrollingDirection.XY, ScrollBarThickness = 3, ScrollBarImageColor3 = Theme.Dim,
}, editorPanel)
local currentLine = create("Frame", {
    Name = "CurrentLine", Position = UDim2.fromOffset(0, 12), Size = UDim2.new(1, 0, 0, 24),
    BackgroundColor3 = Theme.White, BackgroundTransparency = 0.974, BorderSizePixel = 0,
}, editorViewport)
local defaultCode = [[-- Welcome to Madium
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local function greet(name: string)
    print("Hello from Madium, " .. name)
greet(player.DisplayName)]]
-- The native TextBox owns touch selection and Android IME input. The matching
-- RichText layer draws tokens continuously, including while the editor is focused.
local codeBox = create("TextBox", {
    Name = "CodeEditor", Position = UDim2.fromOffset(12, 12), Size = UDim2.new(1, -24, 0, 300),
    BackgroundTransparency = 1, BorderSizePixel = 0, ClearTextOnFocus = false, MultiLine = true,
    Text = defaultCode, TextSize = 16, FontFace = Fonts.Code, LineHeight = 1.5,
    TextColor3 = Theme.Text, TextTransparency = 1, TextXAlignment = Enum.TextXAlignment.Left,
    TextYAlignment = Enum.TextYAlignment.Top, TextWrapped = false, RichText = false,
    ShowNativeInput = false, ZIndex = 4,
}, editorViewport)
local codePreview = label({
    Name = "SyntaxHighlight", Position = codeBox.Position, Size = codeBox.Size, Text = "",
    TextSize = 16, FontFace = Fonts.Code, LineHeight = 1.5, RichText = true,
    TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Top,
    Active = false, ZIndex = 3,
}, editorViewport)
local caret = create("Frame", {
    Name = "EditorCaret", Position = UDim2.fromOffset(12, 12), Size = UDim2.fromOffset(2, 21),
    BackgroundColor3 = Theme.White, BorderSizePixel = 0, Visible = false, ZIndex = 5,
}, editorViewport)
local selectionLayer = create("Frame", {
    Name = "SelectionLayer", Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1, BorderSizePixel = 0, ZIndex = 2,
}, editorViewport)
local actionbar = create("Frame", {
    Name = "BottomActions", Position = UDim2.new(0, 12, 1, -72), Size = UDim2.new(1, -24, 0, 56),
    BackgroundTransparency = 1, BorderSizePixel = 0,
}, editorPanel)
local executeButton = actionButton(actionbar, "Execute", "Execute", "play", true)
local clearButton = actionButton(actionbar, "ClearEditor", "Clear", "trash-2", false)
local clipboardButton = actionButton(actionbar, "RunClipboard", "Execute Clipboard", "clipboard-paste", false)
local executeButton = actionButton(actionbar, "Execute", "Execute", "play", true)
local cursorLabel = label({
    Name = "CursorStatus", Position = UDim2.new(0, 18, 1, -105), Size = UDim2.fromOffset(170, 22),
    Text = "Ln 1, Col 1", TextSize = 12, FontFace = Fonts.Medium,
    TextColor3 = Theme.Muted, TextXAlignment = Enum.TextXAlignment.Left,
}, editorPanel)
-- BEGIN LUAU SYNTAX
local Syntax = {
    Keyword = "#DCC3FF", String = "#B9F59D", Number = "#FFD58A", Comment = "#A8B4C8",
    Literal = "#A8D6FF", Builtin = "#8BE4FF", Operator = "#F1F3FA", Type = "#94EAD8",
local keywords = {}
for word in string.gmatch("and break continue do else elseif end for function if in local not or repeat return then until while export type", "%S+") do
    keywords[word] = true
local builtins = {}
for word in string.gmatch("assert error ipairs next pairs pcall print select tonumber tostring type typeof unpack warn xpcall game workspace script task table string math utf8 coroutine buffer Vector2 Vector3 CFrame Color3 UDim2 Instance Enum", "%S+") do
    builtins[word] = true
local typeNames = { string = true, number = true, boolean = true, any = true, unknown = true, never = true, thread = true }
local function escapeRichText(text)
    return (text:gsub("&", "&amp;"):gsub("<", "&lt;"):gsub(">", "&gt;"):gsub('"', "&quot;"):gsub("'", "&apos;"))
local function longBracketEnd(source, start)
    local equals = source:match("^%[(=*)%[", start)
    if equals == nil then return nil end
    local close = "]" .. equals .. "]"
    local _, finish = source:find(close, start + #equals + 2, true)
    return finish or #source
local function highlightLuau(source)
    -- Tokenization only: source is never evaluated or rewritten by highlighting.
    if #source > 200000 then return escapeRichText(source) end
    local output, at, length = {}, 1, #source
    while at <= length do
        local finish, color
        local char, pair = source:sub(at, at), source:sub(at, at + 1)
        if pair == "--" then
            finish = longBracketEnd(source, at + 2)
            if not finish then
                local newline = source:find("\n", at + 2, true)
                finish = if newline then newline - 1 else length
            end
            color = Syntax.Comment
        elseif char == "[" and longBracketEnd(source, at) then
            finish, color = longBracketEnd(source, at), Syntax.String
        elseif char == '"' or char == "'" or char == "`" then
            local cursor = at + 1
            while cursor <= length do
                local nextChar = source:sub(cursor, cursor)
                if nextChar == "\\" then cursor += 2
                elseif nextChar == char then cursor += 1 break
                elseif nextChar == "\n" and char ~= "`" then break
                else cursor += 1 end
            end
            finish, color = math.min(cursor - 1, length), Syntax.String
        elseif char:match("[%a_]") then
            local word = source:match("^[%a_][%w_]*", at)
            finish = at + #word - 1
            color = if keywords[word] then Syntax.Keyword
                elseif word == "true" or word == "false" or word == "nil" then Syntax.Literal
                elseif typeNames[word] then Syntax.Type
                elseif builtins[word] or source:match("^%s*%(", finish + 1) then Syntax.Builtin else nil
        elseif pair == ".." then
            finish, color = if source:sub(at, at + 2) == "..." then at + 2 else at + 1, Syntax.Operator
        elseif char:match("%d") or (char == "." and source:sub(at + 1, at + 1):match("%d")) then
            local number = source:match("^0[xX][%da-fA-F_]+%.?[%da-fA-F_]*[pP][+-]?[%d_]+", at)
                or source:match("^0[xX][%da-fA-F_]+", at)
                or source:match("^0[bB][01_]+", at)
                or source:match("^%d[%d_]*%.?[%d_]*[eE][+-]?[%d_]+", at)
                or source:match("^%.%d[%d_]*[eE][+-]?[%d_]+", at)
                or source:match("^%.%d[%d_]*", at)
                or source:match("^%d[%d_]*", at)
            finish, color = at + #number - 1, Syntax.Number
            if source:sub(finish + 1, finish + 1) == "." and source:sub(finish + 2, finish + 2) ~= "." then
                local fraction = source:match("^%.%d[%d_]*", finish + 1)
                if fraction then finish += #fraction end
            end
        elseif char:match("%s") then
            local whitespace = source:match("^%s+", at)
            finish = at + #whitespace - 1
        else
            finish, color = at, Syntax.Operator
        end
        local token = escapeRichText(source:sub(at, finish))
        table.insert(output, if color then '<font color="' .. color .. '">' .. token .. '</font>' else token)
        at = finish + 1
    end
    return table.concat(output)
-- END LUAU SYNTAX
local Editor = {
    source = "", lines = {}, lineStarts = {}, numbers = "", columns = 0,
    focused = false, blink = 0, fontSize = 0, charWidth = 9.6,
    lineHeight = 24, compact = false, selectionRects = {}, revision = 0,
local function visualColumns(text)
    local count = 0
    for _, codepoint in utf8.codes(text) do
        count += if codepoint == 9 then 4 - (count % 4) else 1
    end
    return count
local function cursorLocation(position)
    local bytePosition = math.clamp(position, 1, #codeBox.Text + 1)
    local row = 1
    for index, start in ipairs(Editor.lineStarts) do
        if start > bytePosition then break end
        row = index
    end
    local start = Editor.lineStarts[row] or 1
    return row, visualColumns(codeBox.Text:sub(start, bytePosition - 1))
local function syncSelection()
    local cursor = math.max(codeBox.CursorPosition, 1)
    local row, column = cursorLocation(cursor)
    cursorLabel.Text = string.format("Ln %d, Col %d", row, column + 1)
    local y = 12 + (row - 1) * Editor.lineHeight
    caret.Position = UDim2.fromOffset(math.floor(12 + column * Editor.charWidth + 0.5), y)
    caret.Size = UDim2.fromOffset(2, math.floor(Editor.lineHeight - 2))
    currentLine.Position = UDim2.fromOffset(editorViewport.CanvasPosition.X, y)
    currentLine.Size = UDim2.fromOffset(editorViewport.AbsoluteSize.X, Editor.lineHeight)
    local selectionStart = codeBox.SelectionStart
    local hasSelection = Editor.focused and selectionStart >= 1 and selectionStart ~= cursor
    caret.Visible = Editor.focused and not hasSelection
    Editor.blink = 0
    for _, rect in ipairs(Editor.selectionRects) do rect.Visible = false end
    if not hasSelection then return end
    local first, last = math.min(cursor, selectionStart), math.max(cursor, selectionStart)
    local firstRow, firstColumn = cursorLocation(first)
    local lastRow, lastColumn = cursorLocation(last)
    -- Only the visible lines need selection rectangles.
    local topRow = math.max(firstRow, math.floor(editorViewport.CanvasPosition.Y / Editor.lineHeight) + 1)
    local bottomRow = math.min(lastRow, topRow + math.ceil(editorViewport.AbsoluteSize.Y / Editor.lineHeight) + 1)
    for selectedRow = topRow, bottomRow do
        local index = selectedRow - topRow + 1
        local rect = Editor.selectionRects[index]
        if not rect then
            rect = create("Frame", {
                Name = "Selection", BackgroundColor3 = Theme.White, BackgroundTransparency = 0.87,
                BorderSizePixel = 0, ZIndex = 2,
            }, selectionLayer)
            Editor.selectionRects[index] = rect
        end
        local left = if selectedRow == firstRow then firstColumn else 0
        local right = if selectedRow == lastRow then lastColumn else visualColumns(Editor.lines[selectedRow] or "") + 1
        rect.Position = UDim2.fromOffset(math.floor(12 + left * Editor.charWidth + 0.5), 12 + (selectedRow - 1) * Editor.lineHeight)
        rect.Size = UDim2.fromOffset(math.max(2, math.floor((right - left) * Editor.charWidth + 0.5)), Editor.lineHeight)
        rect.Visible = true
    end
local function updateEditorMetrics()
    local source = codeBox.Text
    if source ~= Editor.source then
        Editor.source = source
        Editor.lines, Editor.lineStarts = string.split(source, "\n"), {}
        Editor.columns = 0
        local numbers, start = {}, 1
        for index, line in ipairs(Editor.lines) do
            numbers[index], Editor.lineStarts[index] = tostring(index), start
            Editor.columns = math.max(Editor.columns, visualColumns(line))
            start += #line + 1
        end
        Editor.numbers = table.concat(numbers, "\n")
        lineNumbers.Text = Editor.numbers
        -- Native input, rich text and gutter share face, size and line pitch.
        codePreview.Text = highlightLuau(source)
    end
    local width = math.max(1, editorViewport.AbsoluteSize.X - 24, math.ceil(Editor.columns * Editor.charWidth) + 16)
    local height = math.max(1, editorViewport.AbsoluteSize.Y - 24, #Editor.lines * Editor.lineHeight + 8)
    codeBox.Size, codePreview.Size = UDim2.fromOffset(width, height), UDim2.fromOffset(width, height)
    lineNumbers.Size = UDim2.fromOffset(34, height)
    editorViewport.CanvasSize = UDim2.fromOffset(width + 24, height + 24)
    lineNumbers.Position = UDim2.fromOffset(0, 12 - editorViewport.CanvasPosition.Y)
    syncSelection()
local function setEditorFont(size)
    if size == Editor.fontSize then return end
    Editor.fontSize, Editor.charWidth, Editor.lineHeight = size, size * 0.6, math.floor(size * 1.5)
    for _, text in ipairs({ codeBox, codePreview, lineNumbers }) do
        text.TextSize, text.LineHeight = size, Editor.lineHeight / size
    end
    updateEditorMetrics()
    task.spawn(function()
        local params = Instance.new("GetTextBoundsParams")
        params.Font, params.Size, params.Text, params.Width = Fonts.Code, size, "0000000000", 10000
        local ok, bounds = pcall(function() return TextService:GetTextBoundsAsync(params) end)
        params:Destroy()
        if ok and not destroyed and size == Editor.fontSize and bounds.X > 0 then
            Editor.charWidth = bounds.X / 10
            updateEditorMetrics()
        end
    end)
connect(codeBox.Focused, function() Editor.focused = true syncSelection() end)
connect(codeBox.FocusLost, function() Editor.focused = false syncSelection() end)
connect(root:GetPropertyChangedSignal("Visible"), function()
    if not root.Visible and Editor.focused then codeBox:ReleaseFocus() end
end)
connect(codeBox:GetPropertyChangedSignal("SelectionStart"), syncSelection)
connect(editorViewport:GetPropertyChangedSignal("CanvasPosition"), function()
    lineNumbers.Position = UDim2.fromOffset(0, 12 - editorViewport.CanvasPosition.Y)
    syncSelection()
end)
local function updateLayout()
    local viewport = screenGui.AbsoluteSize
    if viewport.X <= 0 or viewport.Y <= 0 then return end
    -- Shrink the window, not the touch targets or font pixels.
    local width = math.floor(math.min(viewport.X - 24, math.clamp(viewport.X * 0.82, 736, 1120)))
    local height = math.floor(math.min(viewport.Y - 24, math.clamp(viewport.Y * 0.80, 360, 680)))
    root.Size = UDim2.fromOffset(width, height)
    -- Duplicate camera/layout notifications must not cancel an in-progress drag.
    if viewport.X ~= layoutViewport.X or viewport.Y ~= layoutViewport.Y then
        stopDrag()
        layoutViewport = viewport
    end
    positionWindow(windowOffset)
    local compact, short, narrow = width < 1000, height < 420, width < 800
    local padding, gap = 12, if compact then 8 else 12
    local navWidth = if narrow then 64 elseif compact then 72 else 84
    rail.Position, rail.Size = UDim2.fromOffset(padding, padding), UDim2.fromOffset(navWidth, height - padding * 2)
    local bodyX = padding + navWidth + gap
    local bodyWidth = width - padding * 2 - navWidth - gap
    body.Position, body.Size = UDim2.fromOffset(bodyX, padding), UDim2.fromOffset(bodyWidth, height - padding * 2)
    local infoWidth = math.floor(math.clamp(bodyWidth * 0.25, if narrow then 160 elseif compact then 184 else 232, 288))
    local networkHeight = if short then 108 else 156
    statusPanel.Size = UDim2.fromOffset(infoWidth, networkHeight)
    statusPanel.NetworkSubtitle.Visible = not short
    metrics.Position, metrics.Size = UDim2.fromOffset(12, if short then 50 else 86), UDim2.new(1, -24, 0, if short then 44 else 52)
    for _, metric in pairs(metricLabels) do metric.TextSize = if narrow then 10 else 11 end
    consolePanel.Position, consolePanel.Size = UDim2.fromOffset(0, networkHeight + gap), UDim2.new(0, infoWidth, 1, -networkHeight - gap)
    editorPanel.Position = UDim2.fromOffset(infoWidth + gap, 0)
    editorPanel.Size = UDim2.new(1, -infoWidth - gap, 1, 0)
    local navStart = if short then 88 elseif height < 520 then 92 else 112
    local navStep = if short then 56 elseif height < 520 then 72 else 84
    local navHeight = if short then 48 else 68
    for index, name in ipairs({ "Editor", "Scripts", "Settings" }) do
        local control = navButtons[name].button
        control.Position, control.Size = UDim2.fromOffset(4, navStart + (index - 1) * navStep), UDim2.new(1, -8, 0, navHeight)
        navButtons[name].icon.Position = UDim2.new(0.5, 0, 0, if short then 15 else 23)
        navButtons[name].caption.Position = UDim2.new(0, 0, 1, if short then -20 else -26)
        navButtons[name].caption.TextSize = if short then 11 else 12
    end
    local available = bodyWidth - infoWidth - gap - 24 - 16
    local widths = { math.floor(available * 0.22), math.floor(available * 0.46) }
    widths[3] = available - widths[1] - widths[2]
    local clearWidth, clipboardWidth = math.floor(available * 0.22), math.floor(available * 0.46)
    local widths = { available - clearWidth - clipboardWidth, clearWidth, clipboardWidth }
    local offset = 0
    for index, control in ipairs({ executeButton, clearButton, clipboardButton }) do
        control.LayoutOrder = index
        control.Position, control.Size = UDim2.fromOffset(offset, 0), UDim2.fromOffset(widths[index], 52)
        control.Content.Caption.TextSize = if compact then 13 else 14
        offset += widths[index] + 8
    end
    setEditorFont(if Editor.compact or compact or short then 14 else 16)
    updateEditorMetrics()
connect(screenGui:GetPropertyChangedSignal("AbsoluteSize"), updateLayout)
connect(workspace:GetPropertyChangedSignal("CurrentCamera"), updateLayout)
local viewportConnection
local function bindCamera()
    if viewportConnection then viewportConnection:Disconnect() end
    if workspace.CurrentCamera then viewportConnection = connect(workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"), updateLayout) end
    updateLayout()
connect(workspace:GetPropertyChangedSignal("CurrentCamera"), bindCamera)
bindCamera()
local tabs = {
    {
        name = "Welcome.luau",
        content = defaultCode,
    },
local activeTab = 1
local applyingText = false
local function applyTabContent(tab)
    applyingText = true
    codeBox.Text = tab.content
    applyingText = false
    updateEditorMetrics()
local function renderTabs()
    for _, child in ipairs(tabsHolder:GetChildren()) do
        if child:IsA("TextButton") then child:Destroy() end
    end
    for index, tab in ipairs(tabs) do
        local selected = index == activeTab
        local control = button({
            Name = "TabRow", LayoutOrder = index, Size = UDim2.fromOffset(math.clamp(64 + #tab.name * 7, 144, 232), 48),
            BackgroundColor3 = Theme.SurfaceHigh, BackgroundTransparency = if selected then 0 else 1,
            Text = "", ClipsDescendants = true,
        }, tabsHolder)
        addCorner(control, 12)
        if selected then addStroke(control, Theme.Stroke, 0.15) end
        local icon = imageIcon(control, "file-code-2", 18, if selected then Theme.Text else Theme.Muted)
        icon.Position = UDim2.fromOffset(22, 24)
        label({
            Name = "TabName", Position = UDim2.fromOffset(42, 0), Size = UDim2.new(1, -54, 1, 0),
            Text = tab.name, TextSize = 14, FontFace = Fonts.Medium,
            TextColor3 = if selected then Theme.Text else Theme.Muted,
            TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd,
        }, control)
        tapFeedback(control)
        connect(control.Activated, function()
            tabs[activeTab].content = codeBox.Text
            activeTab = index
            applyTabContent(tab)
            renderTabs()
        end)
    end
local function openTab(name, source)
    tabs[activeTab].content = codeBox.Text
    table.insert(tabs, {
        name = name,
        content = source,
    })
    activeTab = #tabs
    applyTabContent(tabs[activeTab])
    renderTabs()
    showPage("Editor")
connect(codeBox:GetPropertyChangedSignal("Text"), function()
    -- A single Return on the Android keyboard carries the current indentation.
    -- Pasting and tab switching leave the source exactly as supplied.
    local previous, current = Editor.source, codeBox.Text
    if Editor.focused and not applyingText and #current == #previous + 1 then
        local insertion = 1
        while insertion <= #previous and previous:sub(insertion, insertion) == current:sub(insertion, insertion) do insertion += 1 end
        if current:sub(insertion, insertion) == "\n" and current:sub(insertion + 1) == previous:sub(insertion) then
            local line = previous:sub(1, insertion - 1):match("[^\n]*$") or ""
            local indent = line:match("^[ \t]*") or ""
            if #indent > 0 then
                applyingText = true
                codeBox.Text = current:sub(1, insertion) .. indent .. current:sub(insertion + 1)
                codeBox.CursorPosition = insertion + #indent + 1
                applyingText = false
            end
        end
    end
    tabs[activeTab].content = codeBox.Text
    updateEditorMetrics()
end)
local function revealCaret()
    if not Editor.focused then return end
    local x, y = caret.Position.X.Offset, caret.Position.Y.Offset
    local scroll, viewport = editorViewport.CanvasPosition, editorViewport.AbsoluteSize
    local sx, sy = scroll.X, scroll.Y
    if x < sx + 4 then sx = math.max(0, x - 12)
    elseif x + 4 > sx + viewport.X then sx = x - viewport.X + 16 end
    if y < sy then sy = math.max(0, y - 12)
    elseif y + Editor.lineHeight > sy + viewport.Y then sy = y + Editor.lineHeight - viewport.Y + 12 end
    if sx ~= scroll.X or sy ~= scroll.Y then editorViewport.CanvasPosition = Vector2.new(sx, sy) end
connect(codeBox:GetPropertyChangedSignal("CursorPosition"), function() syncSelection() revealCaret() end)
connect(editorViewport:GetPropertyChangedSignal("AbsoluteSize"), updateEditorMetrics)
connect(addTabButton.Activated, function()
    openTab(string.format("script%d.luau", #tabs + 1), "-- new Madium script\n")
end)
local function executeSource(source, chunkName)
    if autoClearConsole then
        table.clear(consoleLines)
        consoleText.Text = ""
    end
    local compiler = getGlobal("loadstring")
    if type(compiler) ~= "function" then
        log("error", "loadstring is unavailable in this runtime")
        return
    end
    local compiled, chunkOrError = pcall(compiler, source, "=" .. chunkName)
    if not compiled or type(chunkOrError) ~= "function" then
        log("error", chunkOrError)
        return
    end
    log("run", chunkName)
    task.spawn(function()
        local ok, result = pcall(chunkOrError)
        if ok then
            log("done", if result == nil then "completed" else tostring(result))
        else
            log("error", result)
        end
    end)
local function executeEditor()
    executeSource(codeBox.Text, tabs[activeTab].name)
local function executeClipboard()
    local reader = getGlobal("getclipboard")
    if type(reader) ~= "function" then
        log("error", "getclipboard is unavailable in this runtime")
        return
    end
    local ok, contents = pcall(reader)
    if not ok then
        log("error", contents)
        return
    end
    executeSource(tostring(contents), "Clipboard")
connect(executeButton.Activated, executeEditor)
connect(clipboardButton.Activated, executeClipboard)
connect(clearButton.Activated, function()
    codeBox.Text = ""
    codeBox:CaptureFocus()
end)
local filesPage = create("Frame", {
    Name = "FilesPage",
    Size = UDim2.fromScale(1, 1),
    BackgroundTransparency = 1,
    BorderSizePixel = 0,
    Visible = false,
}, body)
pages.Files = filesPage
local filesPanel = makePanel(filesPage, UDim2.fromOffset(0, 0), UDim2.fromScale(1, 1), 18)
label({
    Position = UDim2.fromOffset(24, 20),
    Size = UDim2.new(1, -180, 0, 28),
    Text = "Workspace files",
    TextSize = 18,
    FontFace = Fonts.SemiBold,
    TextXAlignment = Enum.TextXAlignment.Left,
}, filesPanel)
label({
    Position = UDim2.fromOffset(24, 49),
    Size = UDim2.new(1, -48, 0, 20),
    Text = "Browse and open scripts from the Madium workspace.",
    TextSize = 13,
    TextXAlignment = Enum.TextXAlignment.Left,
    TextColor3 = Theme.Muted,
}, filesPanel)
local refreshFilesButton = button({
    AnchorPoint = Vector2.new(1, 0),
    Position = UDim2.new(1, -20, 0, 18),
    Size = UDim2.fromOffset(112, 48),
    BackgroundColor3 = Theme.White,
    TextColor3 = Theme.Black,
    Text = "Refresh",
    TextSize = 12,
    FontFace = Fonts.Medium,
}, filesPanel)
addCorner(refreshFilesButton, 12)
local fileList = create("ScrollingFrame", {
    Position = UDim2.fromOffset(20, 84),
    Size = UDim2.new(1, -40, 1, -104),
    BackgroundTransparency = 1,
    BorderSizePixel = 0,
    AutomaticCanvasSize = Enum.AutomaticSize.Y,
    CanvasSize = UDim2.fromOffset(0, 0),
    ScrollBarThickness = 3,
    ScrollBarImageColor3 = Theme.Dim,
}, filesPanel)
create("UIListLayout", { Padding = UDim.new(0, 8), SortOrder = Enum.SortOrder.LayoutOrder }, fileList)
local function refreshFiles()
    for _, child in ipairs(fileList:GetChildren()) do
        if child:IsA("TextButton") or child:IsA("TextLabel") then
            child:Destroy()
        end
    end
    local lister = getGlobal("listfiles")
    local reader = getGlobal("readfile")
    if type(lister) ~= "function" or type(reader) ~= "function" then
        label({
            Size = UDim2.new(1, -8, 0, 54),
            Text = "Filesystem APIs are unavailable in this runtime.",
            TextSize = 12,
            TextColor3 = Theme.Muted,
        }, fileList)
        return
    end
    local ok, files = pcall(lister, "madium")
    if not ok or type(files) ~= "table" or #files == 0 then
        label({
            Size = UDim2.new(1, -8, 0, 54),
            Text = "No scripts found in madium/.",
            TextSize = 12,
            TextColor3 = Theme.Muted,
        }, fileList)
        return
    end
    table.sort(files)
    for index, path in ipairs(files) do
        local fileName = string.match(path, "[^/\\]+$") or path
        local row = button({
            LayoutOrder = index,
            Size = UDim2.new(1, -8, 0, 56),
            BackgroundColor3 = Theme.SurfaceHigh,
            Text = "",
            TextSize = 12,
            TextXAlignment = Enum.TextXAlignment.Left,
        }, fileList)
        addCorner(row, 12)
        addStroke(row, Theme.StrokeSoft, 0.25, 1)
        tapFeedback(row)
        local fileIcon = imageIcon(row, "file-code-2", 20)
        fileIcon.Position = UDim2.fromOffset(26, 28)
        label({
            Position = UDim2.fromOffset(48, 0), Size = UDim2.new(1, -72, 1, 0), Text = fileName,
            TextSize = 13, FontFace = Fonts.Medium, TextXAlignment = Enum.TextXAlignment.Left,
            TextTruncate = Enum.TextTruncate.AtEnd,
        }, row)
        connect(row.Activated, function()
            local readOk, source = pcall(reader, path)
            if readOk then
                openTab(fileName, tostring(source))
            else
                log("error", source)
            end
        end)
    end
connect(refreshFilesButton.Activated, refreshFiles)
local scriptsPage = create("Frame", {
    Name = "ScriptsPage",
    Size = UDim2.fromScale(1, 1),
    BackgroundTransparency = 1,
    BorderSizePixel = 0,
    Visible = false,
}, body)
pages.Scripts = scriptsPage
label({
    Position = UDim2.fromOffset(3, 0),
    Size = UDim2.new(1, -6, 0, 35),
    Text = "Script library",
    TextSize = 18,
    FontFace = Fonts.SemiBold,
    TextXAlignment = Enum.TextXAlignment.Left,
}, scriptsPage)
local scriptGrid = create("ScrollingFrame", {
    Position = UDim2.fromOffset(0, 50),
    Size = UDim2.new(1, 0, 1, -50),
    CanvasSize = UDim2.new(), AutomaticCanvasSize = Enum.AutomaticSize.Y, ScrollBarThickness = 3,
    BackgroundTransparency = 1,
    BorderSizePixel = 0,
}, scriptsPage)
create("UIGridLayout", {
    CellSize = UDim2.new(0.5, -6, 0, 180),
    CellPadding = UDim2.fromOffset(12, 12),
    SortOrder = Enum.SortOrder.LayoutOrder,
}, scriptGrid)
local libraryScripts = {
    {
        name = "Player Snapshot",
        description = "Print a clean list of players currently connected.",
        source = [[for _, player in ipairs(game:GetService("Players"):GetPlayers()) do
    print(player.Name, player.UserId)
end]],
    },
    {
        name = "Performance Readout",
        description = "Display client performance information in the console.",
        source = [[local Stats = game:GetService("Stats")
print("Memory", Stats:GetTotalMemoryUsageMb(), "MB")
print("Instances", Stats.InstanceCount)]],
    },
    {
        name = "Character Reset",
        description = "Reset the local character through its Humanoid.",
        source = [[local player = game:GetService("Players").LocalPlayer
local humanoid = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
if humanoid then humanoid.Health = 0 end]],
    },
    {
        name = "Workspace Scan",
        description = "Count visible parts currently present in Workspace.",
        source = [[local count = 0
for _, object in ipairs(workspace:GetDescendants()) do
    if object:IsA("BasePart") then count += 1 end
print("BaseParts", count)]],
    },
for index, scriptData in ipairs(libraryScripts) do
    local card = makePanel(scriptGrid, UDim2.fromOffset(0, 0), UDim2.fromOffset(100, 100), 18)
    card.LayoutOrder = index
    local cardIcon = imageIcon(card, "file-code-2", 20, Theme.Muted)
    cardIcon.Position = UDim2.fromOffset(28, 29)
    label({
        Position = UDim2.fromOffset(46, 16),
        Size = UDim2.new(1, -62, 0, 24),
        Text = scriptData.name,
        TextSize = 14,
        FontFace = Fonts.SemiBold,
        TextXAlignment = Enum.TextXAlignment.Left,
    }, card)
    label({
        Position = UDim2.fromOffset(18, 45),
        Size = UDim2.new(1, -36, 0, 42),
        Text = scriptData.description,
        TextSize = 13,
        TextWrapped = true,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextYAlignment = Enum.TextYAlignment.Top,
        TextColor3 = Theme.Muted,
    }, card)
    local openButton = button({
        AnchorPoint = Vector2.new(1, 1),
        Position = UDim2.new(1, -14, 1, -14),
        Size = UDim2.fromOffset(112, 48),
        BackgroundColor3 = Theme.White,
        TextColor3 = Theme.Black,
        Text = "Open script",
        TextSize = 12,
        FontFace = Fonts.Medium,
    }, card)
    addCorner(openButton, 12)
    connect(openButton.Activated, function()
        openTab(scriptData.name .. ".luau", scriptData.source)
    end)
local settingsPage = create("Frame", {
    Name = "SettingsPage",
    Size = UDim2.fromScale(1, 1),
    BackgroundTransparency = 1,
    BorderSizePixel = 0,
    Visible = false,
}, body)
pages.Settings = settingsPage
local settingsPanel = makePanel(settingsPage, UDim2.fromOffset(0, 0), UDim2.fromScale(1, 1), 18)
label({
    Position = UDim2.fromOffset(24, 20),
    Size = UDim2.new(1, -48, 0, 28),
    Text = "Preferences",
    TextSize = 18,
    FontFace = Fonts.SemiBold,
    TextXAlignment = Enum.TextXAlignment.Left,
}, settingsPanel)
local function makeToggle(order, title, description, initial, callback)
    local row = button({
        Name = "Setting" .. order, Position = UDim2.fromOffset(20, 70 + (order - 1) * 88),
        Size = UDim2.new(1, -40, 0, 76), Text = "", BackgroundColor3 = Theme.SurfaceHigh,
    }, settingsPanel)
    addCorner(row, 12)
    addStroke(row, Theme.StrokeSoft, 0)
    label({
        Position = UDim2.fromOffset(16, 10), Size = UDim2.new(1, -110, 0, 24), Text = title,
        TextSize = 15, FontFace = Fonts.Medium, TextXAlignment = Enum.TextXAlignment.Left,
    }, row)
    label({
        Position = UDim2.fromOffset(16, 36), Size = UDim2.new(1, -110, 0, 30), Text = description,
        TextSize = 12, TextColor3 = Theme.Muted, TextXAlignment = Enum.TextXAlignment.Left, TextWrapped = true,
    }, row)
    local enabled = initial
    local pill = create("Frame", {
        AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -16, 0.5, 0), Size = UDim2.fromOffset(52, 30),
        BackgroundColor3 = if enabled then Theme.White else Theme.SurfaceLow, BorderSizePixel = 0,
    }, row)
    addCorner(pill, 15)
    local knob = create("Frame", {
        Position = UDim2.fromOffset(if enabled then 27 else 5, 5), Size = UDim2.fromOffset(20, 20),
        BackgroundColor3 = if enabled then Theme.Black else Theme.Muted, BorderSizePixel = 0,
    }, pill)
    addCorner(knob, 10)
    tapFeedback(row)
    connect(row.Activated, function()
        enabled = not enabled
        tween(pill, 0.16, { BackgroundColor3 = if enabled then Theme.White else Theme.SurfaceLow })
        tween(knob, 0.16, {
            Position = UDim2.fromOffset(if enabled then 27 else 5, 5),
            BackgroundColor3 = if enabled then Theme.Black else Theme.Muted,
        })
        callback(enabled)
    end)
makeToggle(1, "Auto-clear console", "Clear previous output before each execution.", false, function(value)
    autoClearConsole = value
end)
makeToggle(2, "High contrast", "Increase border contrast around the workspace.", false, function(value)
    local stroke = window:FindFirstChildOfClass("UIStroke")
    if stroke then
        stroke.Color = if value then Theme.White else Theme.Stroke
        stroke.Transparency = if value then 0.35 else 0.48
    end
end)
makeToggle(3, "Compact editor", "Use smaller monospace type in the editor.", false, function(value)
    Editor.compact = value
    updateLayout()
end)
connect(screenGui.Destroying, function()
    if destroyed then return end
    destroyed = true
    for _, connection in ipairs(connections) do connection:Disconnect() end
end)
local frameCount = 0
local elapsed = 0
connect(RunService.RenderStepped, function(deltaTime)
    if Editor.focused and (codeBox.SelectionStart < 1 or codeBox.SelectionStart == codeBox.CursorPosition) then
        Editor.blink = (Editor.blink + deltaTime) % 1
        caret.Visible = Editor.blink < 0.55
    end
    frameCount += 1
    elapsed += deltaTime
    if elapsed < 0.75 then
        return
    end
    metricLabels.FPS.Text = string.format("%d FPS", math.floor(frameCount / elapsed + 0.5))
    refreshPlayerCount()
    local ping = "--"
    pcall(function()
        ping = Stats.Network.ServerStatsItem["Data Ping"]:GetValueString():match("^%d+") or "--"
    end)
    metricLabels.PING.Text = ping .. " MS"
    frameCount = 0
    elapsed = 0
end)
connect(Players.PlayerAdded, function()
    refreshPlayerCount()
end)
connect(Players.PlayerRemoving, function()
    task.defer(function()
        refreshPlayerCount()
    end)
end)
renderTabs()
refreshFiles()
showPage("Editor")
refreshPlayerCount()
updateLayout()
updateEditorMetrics()
log("ready", "Workspace ready")
