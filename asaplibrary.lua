-- Modern Cyan UI Library Template
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")

local ModernUI = {}
ModernUI.__index = ModernUI

function ModernUI.new(titleText)
    local self = setmetatable({}, ModernUI)
    
    -- Main Container
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "ModernCyanUI"
    -- Parent to CoreGui if running in a command bar/plugin context, otherwise player GUI
    local success, _ = pcall(function()
        screenGui.Parent = CoreGui
    end)
    if not success then
        screenGui.Parent = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
    end
    
    self.ScreenGui = screenGui
    
    -- Main Frame
    local mainFrame = Instance.new("Frame")
    mainFrame.Name = "MainFrame"
    mainFrame.Size = UDim2.new(0, 550, 0, 350)
    mainFrame.Position = UDim2.new(0.5, -275, 0.5, -175)
    mainFrame.BackgroundColor3 = Color3.fromRGB(15, 18, 24) -- Dark theme background
    mainFrame.BorderSizePixel = 0
    mainFrame.Active = true
    mainFrame.Draggable = true -- Simple drag fallback
    mainFrame.Parent = screenGui
    
    local mainCorner = Instance.new("UICorner")
    mainCorner.CornerRadius = UDim.new(0, 8)
    mainCorner.Parent = mainFrame
    
    -- Cyan Border Stroke
    local mainStroke = Instance.new("UIStroke")
    mainStroke.Color = Color3.fromRGB(0, 180, 216) -- Cyan Accent
    mainStroke.Thickness = 1.5
    mainStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    mainStroke.Parent = mainFrame
    
    -- Sidebar (Navigation)
    local sidebar = Instance.new("Frame")
    sidebar.Name = "Sidebar"
    sidebar.Size = UDim2.new(0, 150, 1, 0)
    sidebar.BackgroundColor3 = Color3.fromRGB(10, 12, 16)
    sidebar.BorderSizePixel = 0
    sidebar.Parent = mainFrame
    
    local sidebarCorner = Instance.new("UICorner")
    sidebarCorner.CornerRadius = UDim.new(0, 8)
    sidebarCorner.Parent = sidebar
    
    -- Title Label
    local title = Instance.new("TextLabel")
    title.Name = "Title"
    title.Size = UDim2.new(1, 0, 0, 45)
    title.BackgroundTransparency = 1
    title.Text = titleText or "DASHBOARD"
    title.TextColor3 = Color3.fromRGB(0, 224, 255) -- Bright Cyan
    title.TextSize = 16
    title.Font = Enum.Font.GothamBold
    title.Parent = sidebar
    
    -- Navigation Buttons Container
    local navList = Instance.new("Frame")
    navList.Name = "NavList"
    navList.Position = UDim2.new(0, 0, 0, 50)
    navList.Size = UDim2.new(1, 0, 1, -50)
    navList.BackgroundTransparency = 1
    navList.Parent = sidebar
    
    local navLayout = Instance.new("UIListLayout")
    navLayout.SortOrder = Enum.SortOrder.LayoutOrder
    navLayout.Padding = UDim.new(0, 6)
    navLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    navLayout.Parent = navList
    
    -- Content Area
    local container = Instance.new("Frame")
    container.Name = "Container"
    container.Position = UDim2.new(0, 160, 0, 10)
    container.Size = UDim2.new(1, -170, 1, -20)
    container.BackgroundTransparency = 1
    container.Parent = mainFrame
    
    self.MainFrame = mainFrame
    self.Container = container
    self.NavList = navList
    self.Tabs = {}
    self.ActiveTab = nil
    
    return self
end

function ModernUI:CreateTab(tabName)
    local tabButton = Instance.new("TextButton")
    tabButton.Name = tabName .. "Btn"
    tabButton.Size = UDim2.new(0, 130, 0, 32)
    tabButton.BackgroundColor3 = Color3.fromRGB(20, 24, 33)
    tabButton.Text = tabName
    tabButton.TextColor3 = Color3.fromRGB(200, 200, 200)
    tabButton.TextSize = 13
    tabButton.Font = Enum.Font.GothamSemibold
    tabButton.AutoButtonColor = false
    tabButton.Parent = self.NavList
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 6)
    btnCorner.Parent = tabButton
    
    local btnStroke = Instance.new("UIStroke")
    btnStroke.Color = Color3.fromRGB(30, 35, 45)
    btnStroke.Thickness = 1
    btnStroke.Parent = tabButton
    
    -- Content page for this tab
    local page = Instance.new("ScrollingFrame")
    page.Name = tabName .. "Page"
    page.Size = UDim2.new(1, 0, 1, 0)
    page.BackgroundTransparency = 1
    page.Visible = false
    page.ScrollBarThickness = 2
    page.ScrollBarImageColor3 = Color3.fromRGB(0, 180, 216)
    page.Parent = self.Container
    
    local pageLayout = Instance.new("UIListLayout")
    pageLayout.SortOrder = Enum.SortOrder.LayoutOrder
    pageLayout.Padding = UDim.new(0, 8)
    pageLayout.Parent = page
    
    local tabData = {
        Button = tabButton,
        Page = page,
        Stroke = btnStroke
    }
    
    self.Tabs[tabName] = tabData
    
    -- Switch Tab Event
    tabButton.MouseButton1Click:Connect(function()
        self:SelectTab(tabName)
    end)
    
    -- Default selection if it's the first tab
    if not self.ActiveTab then
        self:SelectTab(tabName)
    end
    
    return page
end

function ModernUI:SelectTab(tabName)
    for name, data in pairs(self.Tabs) do
        if name == tabName then
            data.Page.Visible = true
            TweenService:Create(data.Button, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(0, 119, 182)}):Play()
            TweenService:Create(data.Button, TweenInfo.new(0.2), {TextColor3 = Color3.fromRGB(255, 255, 255)}):Play()
            data.Stroke.Color = Color3.fromRGB(0, 180, 216)
            self.ActiveTab = tabName
        else
            data.Page.Visible = false
            TweenService:Create(data.Button, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(20, 24, 33)}):Play()
            TweenService:Create(data.Button, TweenInfo.new(0.2), {TextColor3 = Color3.fromRGB(200, 200, 200)}):Play()
            data.Stroke.Color = Color3.fromRGB(30, 35, 45)
        end
    end
end

-- Add a button element to a specific tab page
function ModernUI:AddButton(page, text, callback)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(1, -10, 0, 35)
    button.BackgroundColor3 = Color3.fromRGB(25, 30, 40)
    button.Text = "  " .. text
    button.TextColor3 = Color3.fromRGB(230, 230, 230)
    button.TextSize = 13
    button.Font = Enum.Font.Gotham
    button.TextXAlignment = Enum.TextXAlignment.Left
    button.AutoButtonColor = false
    button.Parent = page
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = button
    
    local stroke = Instance.new("UIStroke")
    stroke.Color = Color3.fromRGB(40, 45, 55)
    stroke.Thickness = 1
    stroke.Parent = button
    
    -- Visual Feedback
    button.MouseEnter:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(35, 40, 55)}):Play()
        TweenService:Create(stroke, TweenInfo.new(0.15), {Color = Color3.fromRGB(0, 180, 216)}):Play()
    end)
    
    button.MouseLeave:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(25, 30, 40)}):Play()
        TweenService:Create(stroke, TweenInfo.new(0.15), {Color = Color3.fromRGB(40, 45, 55)}):Play()
    end)
    
    button.MouseButton1Click:Connect(function()
        -- Flash effect on click
        button.BackgroundColor3 = Color3.fromRGB(0, 180, 216)
        task.wait(0.08)
        button.BackgroundColor3 = Color3.fromRGB(35, 40, 55)
        if callback then
            task.spawn(callback)
        end
    end)
end

return ModernUI
