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

## 📌 Table of Contents
- [Key Features](#-key-features)
- [Visual Style Guide](#-visual-style-guide)
- [Quick Start](#-quick-start)
- [Code Examples & Snippets](#-code-&-snippet-examples-below-to-start-making-ui's-with-asap-ui)
  - [1. Simple Window Creation](#1-simple-window-creation)
  - [2. Multi-Tab Navigation](#2-multi-tab-navigation)
  - [3. Action Callbacks & Scripts](#3-action-callbacks--scripts)
  - [4. Graceful Cleanup (Self Destruct)](#4-graceful-cleanup-self-destruct)
- [API Documentation](#-api-documentation)
- [Configuration & Customization](#-configuration--customization)
- [License](#-license)

---

## 🌟 Key Features

* 🚀 **Zero Asset Loading** – Built entirely in-code. No external decals, meshes, or models required to load.
* 🎨 **Premium Cyan Palette** – Modern dark themes with vibrant cyan borders, high contrast text, and structured layouts.
* ✨ **Micro-Animations** – Smooth tween transitions on sidebar buttons, hover stroke reactions, and button click feedback.
* 📱 **Auto-Layout Scrolling** – Integrated scroll frames automatically adjust heights to accommodate any number of elements.
* 🛡️ **Execution Safe** – Gracefully attempts to parent to `CoreGui` to protect against local script analysis, falling back safely to `PlayerGui` when needed.

---

## 🎨 Visual Style Guide

| Element | Color Scheme | RGB Value | Hex Code |
| :--- | :--- | :--- | :--- |
| **Main Window Background** | Dark Indigo-Black | `RGB(15, 18, 24)` | `#0f1218` |
| **Sidebar Background** | Deep Obsidian | `RGB(10, 12, 16)` | `#0a0c10` |
| **Primary Accent & Borders** | Cyan Blue | `RGB(0, 180, 216)` | `#00b4d8` |
| **Active Highlights** | Electric Cyan | `RGB(0, 224, 255)` | `#00e0ff` |
| **Inactive Buttons** | Slate Charcoal | `RGB(20, 24, 33)` | `#141821` |

---

## ⚡ Quick Start

Paste this bootstrapper into your execution console to load your menu dynamically:

```lua
local AsapUI = loadstring(game:HttpGet("https://gist.githubusercontent.com/GuysServices/55a3e3913f2eaae6b96563410d1c7652/raw/AsapUI.lua"))()
local Window = AsapUI.new("ASAP MENU")

local HomeTab = Window:CreateTab("Home")
AsapUI:AddButton(HomeTab, "Hello World", function()
    print("Welcome to AsapUI!")
end)
```

## CODE & SNIPPET EXAMPLES BELOW TO START MAKING UI'S WITH ASAP UI

## 1. Simple Window Creation
Create a standard window instance with custom title formatting:
```lua

-- Instantiates a new menu container labeled "DEVELOPMENT"
local MyWindow = AsapUI.new("DEVELOPMENT")
```

## 2. Multi-Tab Navigation
Easily group and partition functions into dedicated category pages:
```lua
local MyWindow = AsapUI.new("CONTROL PANEL")

-- Define your category tabs
local CombatPage = MyWindow:CreateTab("Combat")
local MovementPage = MyWindow:CreateTab("Movement")
local VisualsPage = MyWindow:CreateTab("Visuals")
```
-- The UI will automatically register tab switching animations on click

## 3. Action Callbacks & Scripts
-- Connect functions directly to buttons to trigger game actions on click:
```lua
local CombatPage = MyWindow:CreateTab("Combat")

-- Button with character manipulation logic
MyWindow:AddButton(CombatPage, "Increase WalkSpeed", function()
    local player = game:GetService("Players").LocalPlayer
    if player and player.Character and player.Character:FindFirstChildOfClass("Humanoid") then
        player.Character:FindFirstChildOfClass("Humanoid").WalkSpeed = 50
    end
end)
```

## 4. Graceful Cleanup (Self Destruct)
-- Provide a button to safely destroy the GUI elements and clear screen memory:
```lua
local SettingsPage = MyWindow:CreateTab("Settings")

-- Remove the GUI container completely
MyWindow:AddButton(SettingsPage, "Unload UI", function()
    MyWindow.ScreenGui:Destroy()
end)
```
