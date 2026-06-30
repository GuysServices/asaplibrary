# 🧩 ASAP Library – Custom UI Framework for Roblox Exploits

A lightweight, self‑contained UI library with a **blue/cyan** theme. Build clean, draggable GUIs with tabs, toggles, sliders, dropdowns, buttons, and notifications – **no external dependencies**, no `loadstring` beyond the initial load.

> ✅ Perfect for script hubs, admin panels, or any tool that needs a polished user interface.

---

## 🌟 Features

- **Draggable Windows** – move them anywhere on screen.
- **Tabs** – organise your tools into multiple pages.
- **Sections** – add headers with dividers.
- **Toggles** – smooth sliding switches with state callbacks.
- **Sliders** – draggable knobs with real‑time value display.
- **Dropdowns** – scrollable selectors that auto‑update.
- **Buttons** – clickable actions.
- **Notifications** – stackable pop‑ups that auto‑dismiss.
- **Blue/Cyan Theme** – modern dark UI with vibrant accents.
- **Fully Customizable** – colors, sizes, and more can be tweaked easily.

---

## 📦 Installation

Load the library in your exploit script using `loadstring`.  
Replace the URL with your own raw URL if you’ve hosted it elsewhere.

local CustomUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/GuysServices/asaplibrary/refs/heads/main/asaplibrary.lua"))()
