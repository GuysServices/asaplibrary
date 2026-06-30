--[[
    Custom UI Library – Blue/Cyan Theme
    API:
        CustomUI:CreateWindow(config) -> window
        window:CreateTab(name) -> tab
        tab:CreateSection(name)
        tab:CreateToggle(config)
        tab:CreateSlider(config)
        tab:CreateDropdown(config)
        tab:CreateButton(config)
        CustomUI:Notify(config)
]]

local CustomUI = {}

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local Debris = game:GetService("Debris")

local Colors = {
    Accent = Color3.fromRGB(0, 170, 255),
    AccentDark = Color3.fromRGB(0, 120, 200),
    Background = Color3.fromRGB(18, 18, 28),
    Surface = Color3.fromRGB(30, 30, 45),
    SurfaceHover = Color3.fromRGB(45, 45, 65),
    Text = Color3.fromRGB(255, 255, 255),
    TextDim = Color3.fromRGB(160, 170, 190),
    Shadow = Color3.fromRGB(0, 0, 0),
}

local function makeRounded(instance, radius)
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, radius or 6)
    corner.Parent = instance
end

local function makeShadow(parent)
    local shadow = Instance.new("Frame")
    shadow.Size = parent.Size + UDim2.new(0, 10, 0, 10)
    shadow.Position = parent.Position - UDim2.new(0, 5, 0, 5)
    shadow.BackgroundColor3 = Colors.Shadow
    shadow.BackgroundTransparency = 0.6
    shadow.BorderSizePixel = 0
    shadow.ZIndex = 0
    shadow.Parent = parent.Parent
    local corner = parent:FindFirstChild("UICorner")
    local radius = corner and corner.CornerRadius.Offset + 2 or 10
    makeRounded(shadow, radius)
    return shadow
end

local function makeDraggable(frame, dragHandle)
    local dragging = false
    local dragStart
    local startPos

    dragHandle.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = frame.Position
        end
    end)

    dragHandle.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = input.Position - dragStart

            frame.Position = UDim2.new(
                startPos.X.Scale,
                startPos.X.Offset + delta.X,
                startPos.Y.Scale,
                startPos.Y.Offset + delta.Y
            )
        end
    end)
end

local notificationContainer = nil

function CustomUI:Notify(config)
    if not notificationContainer then
        local gui = Instance.new("ScreenGui")
        gui.Name = "CustomUINotifications"
        gui.ResetOnSpawn = false
        gui.Parent = LocalPlayer:WaitForChild("PlayerGui")
        notificationContainer = Instance.new("Frame")
        notificationContainer.Size = UDim2.new(0, 300, 0, 0)
        notificationContainer.Position = UDim2.new(1, -320, 0, 20)
        notificationContainer.BackgroundTransparency = 1
        notificationContainer.Parent = gui
    end

    local title = config.Title or "Notification"
    local content = config.Content or ""
    local duration = config.Duration or 3

    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, 0, 0, 55)
    frame.Position = UDim2.new(0, 0, 0, #notificationContainer:GetChildren() * 65)
    frame.BackgroundColor3 = Colors.Background
    frame.BorderSizePixel = 0
    frame.Parent = notificationContainer
    makeRounded(frame, 6)
    makeShadow(frame)

    local accent = Instance.new("Frame")
    accent.Size = UDim2.new(0, 4, 1, 0)
    accent.BackgroundColor3 = Colors.Accent
    accent.BorderSizePixel = 0
    accent.Parent = frame
    makeRounded(accent, 2)

    local titleLabel = Instance.new("TextLabel")
    titleLabel.Size = UDim2.new(1, -15, 0.4, 0)
    titleLabel.Position = UDim2.new(0, 10, 0, 3)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = title
    titleLabel.TextColor3 = Colors.Text
    titleLabel.TextScaled = true
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.Parent = frame

    local contentLabel = Instance.new("TextLabel")
    contentLabel.Size = UDim2.new(1, -15, 0.4, 0)
    contentLabel.Position = UDim2.new(0, 10, 0, 22)
    contentLabel.BackgroundTransparency = 1
    contentLabel.Text = content
    contentLabel.TextColor3 = Colors.TextDim
    contentLabel.TextScaled = true
    contentLabel.Font = Enum.Font.Gotham
    contentLabel.TextXAlignment = Enum.TextXAlignment.Left
    contentLabel.Parent = frame

    Debris:AddItem(frame, duration + 0.5)
    task.wait(duration)
    for i, child in ipairs(notificationContainer:GetChildren()) do
        child.Position = UDim2.new(0, 0, 0, (i - 1) * 65)
    end
end

function CustomUI:CreateWindow(config)
    local window = {}

    local name = config.Name or "Window"
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = name .. "GUI"
    screenGui.ResetOnSpawn = false
    screenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 400, 0, 500)
    frame.Position = UDim2.new(0.5, -200, 0.5, -250)
    frame.BackgroundColor3 = Colors.Background
    frame.BorderSizePixel = 0
    frame.Parent = screenGui
    makeRounded(frame, 10)
    makeShadow(frame)

    local border = Instance.new("Frame")
    border.Size = UDim2.new(1, 0, 1, 0)
    border.BackgroundColor3 = Colors.Accent
    border.BackgroundTransparency = 0.8
    border.BorderSizePixel = 0
    border.Parent = frame
    makeRounded(border, 10)

    local titleBar = Instance.new("Frame")
    titleBar.Size = UDim2.new(1, 0, 0, 40)
    titleBar.BackgroundTransparency = 1
    titleBar.Parent = frame

    local titleLabel = Instance.new("TextLabel")
    titleLabel.Size = UDim2.new(0.7, 0, 1, 0)
    titleLabel.Position = UDim2.new(0, 15, 0, 0)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = name
    titleLabel.TextColor3 = Colors.Text
    titleLabel.TextScaled = true
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.Parent = titleBar

    local closeBtn = Instance.new("TextButton")
    closeBtn.Size = UDim2.new(0, 30, 0, 30)
    closeBtn.Position = UDim2.new(1, -40, 0, 5)
    closeBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    closeBtn.BackgroundTransparency = 0.3
    closeBtn.BorderSizePixel = 0
    closeBtn.Text = "✕"
    closeBtn.TextColor3 = Colors.Text
    closeBtn.TextScaled = true
    closeBtn.Font = Enum.Font.GothamBold
    closeBtn.Parent = titleBar
    makeRounded(closeBtn, 15)
    closeBtn.MouseButton1Click:Connect(function()
        screenGui:Destroy()
    end)

    makeDraggable(frame, titleBar)

    local tabBar = Instance.new("Frame")
    tabBar.Size = UDim2.new(1, 0, 0, 35)
    tabBar.Position = UDim2.new(0, 0, 0, 40)
    tabBar.BackgroundTransparency = 1
    tabBar.Parent = frame

    local tabs = {}
    local tabContents = {}
    local tabButtons = {}

    function window:CreateTab(tabName)
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(1 / (#tabs + 1), 0, 1, 0)
        btn.Position = UDim2.new(#tabs / (#tabs + 1), 0, 0, 0)
        btn.BackgroundTransparency = 1
        btn.BorderSizePixel = 0
        btn.Text = tabName
        btn.TextColor3 = Colors.TextDim
        btn.TextScaled = true
        btn.Font = Enum.Font.GothamMedium
        btn.Parent = tabBar

        local indicator = Instance.new("Frame")
        indicator.Size = UDim2.new(0.6, 0, 0, 3)
        indicator.Position = UDim2.new(0.2, 0, 1, -3)
        indicator.BackgroundColor3 = Colors.Accent
        indicator.BorderSizePixel = 0
        indicator.Visible = false
        indicator.Parent = btn

        local content = Instance.new("ScrollingFrame")
        content.Size = UDim2.new(1, 0, 1, -75)
        content.Position = UDim2.new(0, 0, 0, 75)
        content.BackgroundTransparency = 1
        content.BorderSizePixel = 0
        content.CanvasSize = UDim2.new(0, 0, 0, 0)
        content.ScrollBarThickness = 4
        content.ScrollBarImageColor3 = Colors.Accent
        content.Visible = (#tabs == 0)
        content.Parent = frame

        local tabObj = {}
        table.insert(tabs, tabName)
        tabContents[tabName] = content
        tabButtons[tabName] = {btn = btn, indicator = indicator}

        local function select()
            for _, t in pairs(tabs) do
                tabButtons[t].indicator.Visible = false
                tabButtons[t].btn.TextColor3 = Colors.TextDim
                tabContents[t].Visible = false
            end
            indicator.Visible = true
            btn.TextColor3 = Colors.Text
            content.Visible = true
        end

        btn.MouseButton1Click:Connect(select)

        if #tabs == 1 then
            select()
        end

        function tabObj:CreateSection(title)
            local y = #content:GetChildren() == 0 and 0.02 or 0.0
            local last = content:GetChildren()
            if #last > 0 then
                local lastChild = last[#last]
                y = lastChild.Position.Y.Scale + lastChild.Size.Y.Scale + 0.02
            end
            y = math.max(y, 0.02)

            local line = Instance.new("Frame")
            line.Size = UDim2.new(0.9, 0, 0, 1)
            line.Position = UDim2.new(0.05, 0, y, 0)
            line.BackgroundColor3 = Colors.Accent
            line.BackgroundTransparency = 0.6
            line.BorderSizePixel = 0
            line.Parent = content

            local label = Instance.new("TextLabel")
            label.Size = UDim2.new(0.9, 0, 0, 20)
            label.Position = UDim2.new(0.05, 0, y + 0.015, 0)
            label.BackgroundTransparency = 1
            label.Text = title
            label.TextColor3 = Colors.Accent
            label.TextScaled = true
            label.Font = Enum.Font.GothamBold
            label.TextXAlignment = Enum.TextXAlignment.Left
            label.Parent = content

            content.CanvasSize = UDim2.new(0, 0, 0, label.Position.Y.Scale * 500 + 40)
        end

        function tabObj:CreateToggle(config)
            local labelText = config.Name or "Toggle"
            local default = config.CurrentValue or false
            local callback = config.Callback or function() end

            local y = #content:GetChildren() == 0 and 0.02 or 0.0
            local last = content:GetChildren()
            if #last > 0 then
                local lastChild = last[#last]
                y = lastChild.Position.Y.Scale + lastChild.Size.Y.Scale + 0.02
            end
            y = math.max(y, 0.02)

            local frame = Instance.new("Frame")
            frame.Size = UDim2.new(0.9, 0, 0, 35)
            frame.Position = UDim2.new(0.05, 0, y, 0)
            frame.BackgroundTransparency = 1
            frame.Parent = content

            local label = Instance.new("TextLabel")
            label.Size = UDim2.new(0.7, 0, 1, 0)
            label.BackgroundTransparency = 1
            label.Text = labelText
            label.TextColor3 = Colors.Text
            label.TextScaled = true
            label.Font = Enum.Font.Gotham
            label.TextXAlignment = Enum.TextXAlignment.Left
            label.Parent = frame

            local track = Instance.new("Frame")
            track.Size = UDim2.new(0, 40, 0, 22)
            track.Position = UDim2.new(1, -45, 0.5, -11)
            track.BackgroundColor3 = Colors.Surface
            track.BorderSizePixel = 0
            track.Parent = frame
            makeRounded(track, 11)

            local knob = Instance.new("Frame")
            knob.Size = UDim2.new(0, 18, 0, 18)
            knob.Position = UDim2.new(0, 2, 0.5, -9)
            knob.BackgroundColor3 = Colors.Text
            knob.BorderSizePixel = 0
            knob.Parent = track
            makeRounded(knob, 9)

            local state = default
            local function setState(newState)
                state = newState
                if state then
                    track.BackgroundColor3 = Colors.Accent
                    knob.Position = UDim2.new(0, 20, 0.5, -9)
                else
                    track.BackgroundColor3 = Colors.Surface
                    knob.Position = UDim2.new(0, 2, 0.5, -9)
                end
                callback(state)
            end
            setState(default)

            local btn = Instance.new("TextButton")
            btn.Size = UDim2.new(1, 0, 1, 0)
            btn.BackgroundTransparency = 1
            btn.Text = ""
            btn.Parent = frame
            btn.MouseButton1Click:Connect(function()
                setState(not state)
            end)

            content.CanvasSize = UDim2.new(0, 0, 0, frame.Position.Y.Scale * 500 + 50)

            return {
                SetState = setState,
                GetState = function() return state end,
            }
        end

        function tabObj:CreateSlider(config)
            local labelText = config.Name or "Slider"
            local minVal = config.Min or 0
            local maxVal = config.Max or 100
            local defaultVal = config.CurrentValue or minVal
            local suffix = config.Suffix or ""
            local callback = config.Callback or function() end

            local y = #content:GetChildren() == 0 and 0.02 or 0.0
            local last = content:GetChildren()
            if #last > 0 then
                local lastChild = last[#last]
                y = lastChild.Position.Y.Scale + lastChild.Size.Y.Scale + 0.02
            end
            y = math.max(y, 0.02)

            local frame = Instance.new("Frame")
            frame.Size = UDim2.new(0.9, 0, 0, 45)
            frame.Position = UDim2.new(0.05, 0, y, 0)
            frame.BackgroundTransparency = 1
            frame.Parent = content

            local label = Instance.new("TextLabel")
            label.Size = UDim2.new(0.6, 0, 0.4, 0)
            label.BackgroundTransparency = 1
            label.Text = labelText
            label.TextColor3 = Colors.Text
            label.TextScaled = true
            label.Font = Enum.Font.Gotham
            label.TextXAlignment = Enum.TextXAlignment.Left
            label.Parent = frame

            local valueDisplay = Instance.new("TextLabel")
            valueDisplay.Size = UDim2.new(0.35, 0, 0.4, 0)
            valueDisplay.Position = UDim2.new(0.65, 0, 0, 0)
            valueDisplay.BackgroundTransparency = 1
            valueDisplay.Text = tostring(defaultVal) .. suffix
            valueDisplay.TextColor3 = Colors.Accent
            valueDisplay.TextScaled = true
            valueDisplay.Font = Enum.Font.GothamBold
            valueDisplay.TextXAlignment = Enum.TextXAlignment.Right
            valueDisplay.Parent = frame

            local track = Instance.new("Frame")
            track.Size = UDim2.new(1, 0, 0.25, 0)
            track.Position = UDim2.new(0, 0, 0.6, 0)
            track.BackgroundColor3 = Colors.Surface
            track.BorderSizePixel = 0
            track.Parent = frame
            makeRounded(track, 3)

            local fill = Instance.new("Frame")
            fill.Size = UDim2.new((defaultVal - minVal) / (maxVal - minVal), 0, 1, 0)
            fill.BackgroundColor3 = Colors.Accent
            fill.BorderSizePixel = 0
            fill.Parent = track
            makeRounded(fill, 3)

            local knob = Instance.new("TextButton")
            knob.Size = UDim2.new(0, 16, 0, 16)
            knob.Position = UDim2.new((defaultVal - minVal) / (maxVal - minVal), -8, 0.5, -8)
            knob.BackgroundColor3 = Colors.Accent
            knob.BorderSizePixel = 0
            knob.Text = ""
            knob.Parent = track
            makeRounded(knob, 8)

            local dragging = false
            local currentVal = defaultVal

            local function update(input)
                local x = math.clamp((input.Position.X - track.AbsolutePosition.X) / track.AbsoluteSize.X, 0, 1)
                local value = math.round((minVal + (maxVal - minVal) * x) / 1) * 1
                value = math.clamp(value, minVal, maxVal)
                fill.Size = UDim2.new((value - minVal) / (maxVal - minVal), 0, 1, 0)
                knob.Position = UDim2.new((value - minVal) / (maxVal - minVal), -8, 0.5, -8)
                valueDisplay.Text = tostring(value) .. suffix
                currentVal = value
                callback(value)
            end

            knob.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    dragging = true
                    update(input)
                end
            end)
            knob.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    dragging = false
                end
            end)
            UserInputService.InputChanged:Connect(function(input)
                if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                    update(input)
                end
            end)

            content.CanvasSize = UDim2.new(0, 0, 0, frame.Position.Y.Scale * 500 + 60)

            return {
                SetValue = function(val)
                    val = math.clamp(val, minVal, maxVal)
                    fill.Size = UDim2.new((val - minVal) / (maxVal - minVal), 0, 1, 0)
                    knob.Position = UDim2.new((val - minVal) / (maxVal - minVal), -8, 0.5, -8)
                    valueDisplay.Text = tostring(val) .. suffix
                    currentVal = val
                    callback(val)
                end,
                GetValue = function() return currentVal end,
            }
        end

        function tabObj:CreateDropdown(config)
            local labelText = config.Name or "Dropdown"
            local options = config.Options or {}
            local default = config.CurrentOption or options[1] or ""
            local callback = config.Callback or function() end

            local y = #content:GetChildren() == 0 and 0.02 or 0.0
            local last = content:GetChildren()
            if #last > 0 then
                local lastChild = last[#last]
                y = lastChild.Position.Y.Scale + lastChild.Size.Y.Scale + 0.02
            end
            y = math.max(y, 0.02)

            local frame = Instance.new("Frame")
            frame.Size = UDim2.new(0.9, 0, 0, 40)
            frame.Position = UDim2.new(0.05, 0, y, 0)
            frame.BackgroundTransparency = 1
            frame.Parent = content

            local label = Instance.new("TextLabel")
            label.Size = UDim2.new(0.3, 0, 1, 0)
            label.BackgroundTransparency = 1
            label.Text = labelText
            label.TextColor3 = Colors.Text
            label.TextScaled = true
            label.Font = Enum.Font.Gotham
            label.TextXAlignment = Enum.TextXAlignment.Left
            label.Parent = frame

            local mainBtn = Instance.new("TextButton")
            mainBtn.Size = UDim2.new(0.65, 0, 0.8, 0)
            mainBtn.Position = UDim2.new(0.35, 0, 0.1, 0)
            mainBtn.BackgroundColor3 = Colors.Surface
            mainBtn.BorderSizePixel = 0
            mainBtn.Text = default
            mainBtn.TextColor3 = Colors.Text
            mainBtn.TextScaled = true
            mainBtn.Font = Enum.Font.Gotham
            mainBtn.Parent = frame
            makeRounded(mainBtn, 4)

            local listFrame = Instance.new("Frame")
            listFrame.Size = UDim2.new(0.65, 0, 0, 100)
            listFrame.Position = UDim2.new(0.35, 0, 0.85, 0)
            listFrame.BackgroundColor3 = Colors.Background
            listFrame.BorderSizePixel = 0
            listFrame.Visible = false
            listFrame.ClipsDescendants = true
            listFrame.Parent = frame
            makeRounded(listFrame, 4)

            local scroll = Instance.new("ScrollingFrame")
            scroll.Size = UDim2.new(1, 0, 1, 0)
            scroll.BackgroundTransparency = 1
            scroll.BorderSizePixel = 0
            scroll.CanvasSize = UDim2.new(0, 0, 0, #options * 30)
            scroll.ScrollBarThickness = 4
            scroll.ScrollBarImageColor3 = Colors.Accent
            scroll.Parent = listFrame

            local selected = default
            local buttons = {}

            local function rebuildList()
                for _, btn in pairs(buttons) do btn:Destroy() end
                buttons = {}
                local yPos = 0
                for _, opt in ipairs(options) do
                    local optBtn = Instance.new("TextButton")
                    optBtn.Size = UDim2.new(1, 0, 0, 30)
                    optBtn.Position = UDim2.new(0, 0, 0, yPos)
                    optBtn.BackgroundColor3 = Colors.Surface
                    optBtn.BackgroundTransparency = 0.3
                    optBtn.BorderSizePixel = 0
                    optBtn.Text = opt
                    optBtn.TextColor3 = Colors.Text
                    optBtn.TextScaled = true
                    optBtn.Font = Enum.Font.Gotham
                    optBtn.Parent = scroll
                    makeRounded(optBtn, 3)
                    optBtn.MouseButton1Click:Connect(function()
                        selected = opt
                        mainBtn.Text = opt
                        listFrame.Visible = false
                        callback(opt)
                    end)
                    table.insert(buttons, optBtn)
                    yPos = yPos + 33
                end
                scroll.CanvasSize = UDim2.new(0, 0, 0, yPos)
            end
            rebuildList()

            mainBtn.MouseButton1Click:Connect(function()
                listFrame.Visible = not listFrame.Visible
                rebuildList()
            end)

            content.CanvasSize = UDim2.new(0, 0, 0, frame.Position.Y.Scale * 500 + 55)

            return {
                SetOptions = function(newOptions)
                    options = newOptions
                    rebuildList()
                end,
                SetValue = function(val)
                    if table.find(options, val) then
                        selected = val
                        mainBtn.Text = val
                        callback(val)
                    end
                end,
                GetValue = function() return selected end,
            }
        end

        function tabObj:CreateButton(config)
            local labelText = config.Name or "Button"
            local callback = config.Callback or function() end

            local y = #content:GetChildren() == 0 and 0.02 or 0.0
            local last = content:GetChildren()
            if #last > 0 then
                local lastChild = last[#last]
                y = lastChild.Position.Y.Scale + lastChild.Size.Y.Scale + 0.02
            end
            y = math.max(y, 0.02)

            local btn = Instance.new("TextButton")
            btn.Size = UDim2.new(0.8, 0, 0, 35)
            btn.Position = UDim2.new(0.1, 0, y, 0)
            btn.BackgroundColor3 = Colors.Accent
            btn.BackgroundTransparency = 0.2
            btn.BorderSizePixel = 0
            btn.Text = labelText
            btn.TextColor3 = Colors.Text
            btn.TextScaled = true
            btn.Font = Enum.Font.GothamBold
            btn.Parent = content
            makeRounded(btn, 6)

            btn.MouseButton1Click:Connect(callback)

            content.CanvasSize = UDim2.new(0, 0, 0, btn.Position.Y.Scale * 500 + 50)

            return {
                SetText = function(newText) btn.Text = newText end,
            }
        end

        return tabObj
    end

    return window
end

return CustomUI
