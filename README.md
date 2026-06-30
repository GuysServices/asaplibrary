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
- [API Documentation](#-api-documentation)
  - [Window Methods](#window-methods)
  - [Tab Methods](#tab-methods)
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
-- 1. Load the UI Library
local AsapUI = loadstring(game:HttpGet("https://gist.githubusercontent.com/GuysServices/55a3e3913f2eaae6b96563410d1c7652/raw/AsapUI.lua"))()

-- 2. Initialize a Window
local Window = AsapUI.new("ASAP MENU")

-- 3. Create Navigation Tabs
local HomeTab = Window:CreateTab("Home")
local UtilityTab = Window:CreateTab("Utility")

-- 4. Add Interactive Buttons
AsapUI:AddButton(HomeTab, "Hello World", function()
    print("Welcome to AsapUI!")
end)

AsapUI:AddButton(UtilityTab, "Close UI", function()
    Window.ScreenGui:Destroy()
end)
