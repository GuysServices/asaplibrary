# ⚡ AsapUI

<p align="center">
  <img src="https://img.shields.io/github/license/GuysServices/AsapUI?style=for-the-badge&color=00b4d8" alt="License">
  <img src="https://img.shields.io/github/v/release/GuysServices/AsapUI?style=for-the-badge&color=00e0ff" alt="Version">
  <img src="https://img.shields.io/github/stars/GuysServices/AsapUI?style=for-the-badge&color=03045e" alt="Stars">
</p>

<p align="center">
  <strong>AsapUI</strong> is a high-performance, programmatically generated dark UI library with a vibrant cyan aesthetic. Designed specifically for Roblox Luau script environments, it builds clean interfaces on the fly without relying on pre-made ScreenGuis or external assets.
</p>

---

# 📌 Table of Contents

- [Key Features](#-key-features)
- [Visual Style Guide](#-visual-style-guide)
- [Quick Start](#-quick-start)
- [Code Examples & Snippets](#-code--snippet-examples-below-to-start-making-uis-with-asap-ui)
  - [1. Simple Window Creation](#1-simple-window-creation)
  - [2. Multi-Tab Navigation](#2-multi-tab-navigation)
  - [3. Action Callbacks & Scripts](#3-action-callbacks--scripts)
  - [4. Graceful Cleanup (Self Destruct)](#4-graceful-cleanup-self-destruct)
- [API Documentation](#-api-documentation)
- [Configuration & Customization](#-configuration--customization)
- [Full Example](#-full-example)
- [API Summary](#-api-summary)
- [Notes](#-notes)
- [License](#-license)

---

# 🌟 Key Features

- 🚀 **Zero Asset Loading** – Built entirely in-code. No external decals, meshes, or models required to load.
- 🎨 **Premium Cyan Palette** – Modern dark themes with vibrant cyan borders, high contrast text, and structured layouts.
- ✨ **Micro-Animations** – Smooth tween transitions on sidebar buttons, hover stroke reactions, and button click feedback.
- 📱 **Auto-Layout Scrolling** – Integrated scroll frames automatically adjust heights to accommodate any number of elements.
- 🛡️ **Execution Safe** – Gracefully attempts to parent to `CoreGui` to protect against local script analysis, falling back safely to `PlayerGui` when needed.

---

# 🎨 Visual Style Guide

| Element | Color Scheme | RGB Value | Hex Code |
| :--- | :--- | :--- | :--- |
| **Main Window Background** | Dark Indigo-Black | `RGB(15, 18, 24)` | `#0f1218` |
| **Sidebar Background** | Deep Obsidian | `RGB(10, 12, 16)` | `#0a0c10` |
| **Primary Accent & Borders** | Cyan Blue | `RGB(0, 180, 216)` | `#00b4d8` |
| **Active Highlights** | Electric Cyan | `RGB(0, 224, 255)` | `#00e0ff` |
| **Inactive Buttons** | Slate Charcoal | `RGB(20, 24, 33)` | `#141821` |

---

# ⚡ Quick Start

Paste this bootstrapper into your execution console to load your menu dynamically:

```lua
local AsapUI = loadstring(game:HttpGet("https://gist.githubusercontent.com/GuysServices/55a3e3913f2eaae6b96563410d1c7652/raw/AsapUI.lua"))()

local Window = AsapUI.new("ASAP MENU")

local HomeTab = Window:CreateTab("Home")

Window:AddButton(HomeTab, "Hello World", function()
    print("Welcome to AsapUI!")
end)
```

---

# 💻 Code & Snippet Examples Below to Start Making UI's With AsapUI

## 1. Simple Window Creation

Create a standard window instance with a custom title.

```lua
local MyWindow = AsapUI.new("DEVELOPMENT")
```

---

## 2. Multi-Tab Navigation

Easily organize your interface into multiple categories.

```lua
local MyWindow = AsapUI.new("CONTROL PANEL")

local CombatPage = MyWindow:CreateTab("Combat")
local MovementPage = MyWindow:CreateTab("Movement")
local VisualsPage = MyWindow:CreateTab("Visuals")
```

> The UI automatically handles page switching and sidebar animations.

---

## 3. Action Callbacks & Scripts

Attach functions to buttons with a clean API.

```lua
local CombatPage = MyWindow:CreateTab("Combat")

MyWindow:AddButton(CombatPage, "Increase WalkSpeed", function()
    local player = game:GetService("Players").LocalPlayer

    if player
        and player.Character
        and player.Character:FindFirstChildOfClass("Humanoid") then

        player.Character:FindFirstChildOfClass("Humanoid").WalkSpeed = 50
    end
end)
```

---

## 4. Graceful Cleanup (Self Destruct)

Destroy the interface whenever needed.

```lua
local SettingsPage = MyWindow:CreateTab("Settings")

MyWindow:AddButton(SettingsPage, "Unload UI", function()
    MyWindow.ScreenGui:Destroy()
end)
```

---

# 📖 API Documentation

A complete reference for every public function provided by **AsapUI**.

---

## 🚀 Window Methods

### `AsapUI.new(titleText: string) -> WindowInstance`

Initializes a new UI window with drag support, animations, and sidebar navigation.

#### Parameters

| Parameter | Type | Description |
|-----------|------|-------------|
| `titleText` | `string` | Window title shown in the sidebar. Default is `"DASHBOARD"` |

#### Returns

| Type | Description |
|------|-------------|
| `WindowInstance` | The created window object |

#### Example

```lua
local Window = AsapUI.new("ASAP MENU")
```

---

## 📑 Tab Methods

### `Window:CreateTab(tabName: string) -> ScrollingFrame`

Creates a new sidebar button and page container.

#### Parameters

| Parameter | Type | Description |
|-----------|------|-------------|
| `tabName` | `string` | Name displayed in the sidebar |

#### Returns

| Type | Description |
|------|-------------|
| `ScrollingFrame` | Page container used to place UI elements |

#### Example

```lua
local HomeTab = Window:CreateTab("Home")
```

---

## 🔘 Button Methods

### `Window:AddButton(page: ScrollingFrame, buttonText: string, callback: function)`

Creates an interactive button inside a page.

#### Parameters

| Parameter | Type | Description |
|-----------|------|-------------|
| `page` | `ScrollingFrame` | Page returned from `CreateTab()` |
| `buttonText` | `string` | Button text |
| `callback` | `function` | Function executed when clicked |

#### Example

```lua
Window:AddButton(HomeTab, "Print Message", function()
    print("Button clicked!")
end)
```

---

# ⚙️ Configuration & Customization

All visual settings can be edited directly inside **AsapUI.lua**.

---

## 🎨 Changing the Accent Color

Locate:

```lua
mainStroke.Color = Color3.fromRGB(0, 180, 216)
```

Then replace it with any color you prefer.

### Purple Theme

```lua
mainStroke.Color = Color3.fromRGB(155, 93, 229)
```

### Red Theme

```lua
mainStroke.Color = Color3.fromRGB(255, 60, 60)
```

### Green Theme

```lua
mainStroke.Color = Color3.fromRGB(0, 255, 127)
```

---

# 📚 Full Example

```lua
local AsapUI = loadstring(game:HttpGet("YOUR_URL"))()

local Window = AsapUI.new("ASAP MENU")

local HomeTab = Window:CreateTab("Home")

Window:AddButton(HomeTab, "Print Message", function()
    print("Button clicked!")
end)
```

---

# 📄 API Summary

| Method | Description |
|---------|-------------|
| `AsapUI.new(title)` | Creates a new window |
| `Window:CreateTab(name)` | Creates a new page/tab |
| `Window:AddButton(page, text, callback)` | Adds a button to a page |

---

# 🛠️ Notes

- ✨ Smooth tween animations
- 🖱️ Draggable window
- 📂 Automatic page management
- 📜 Auto-sizing scrolling pages
- 🎨 Easily customizable colors
- ⚡ Lightweight & fast
- 🛡️ Attempts to use `CoreGui` before falling back to `PlayerGui`

---

# 📄 License

This project is licensed under the **MIT License**.

Feel free to use, modify, and distribute AsapUI in your own projects while following the terms of the license.
