# 🧩 ASAP Library

<div align="center">

A modern, lightweight Roblox UI library designed for executors.

Create beautiful interfaces with **windows**, **tabs**, **toggles**, **sliders**, **dropdowns**, **buttons**, and **notifications**—all from a simple API.

---

**💙 Clean Design • ⚡ Easy to Use • 🎨 Blue/Cyan Theme**

</div>

---

# 📑 Table of Contents

- [✨ Features](#-features)
- [📦 Installation](#-installation)
- [🚀 Quick Start](#-quick-start)
- [🪟 Creating a Window](#-creating-a-window)
- [📂 Creating Tabs](#-creating-tabs)
- [📁 Sections](#-sections)
- [☑️ Toggles](#️-toggles)
- [🎚️ Sliders](#-sliders)
- [📋 Dropdowns](#-dropdowns)
- [🔘 Buttons](#-buttons)
- [🔔 Notifications](#-notifications)
- [📚 API Reference](#-api-reference)

---

# ✨ Features

- 💙 Modern blue/cyan user interface
- 🖱️ Draggable windows
- 📂 Multi-tab support
- 📁 Section dividers
- ☑️ Animated toggles
- 🎚️ Interactive sliders
- 📋 Dynamic dropdown menus
- 🔘 Responsive buttons
- 🔔 Built-in notification system
- ⚡ Lightweight & self-contained
- 📜 Simple and beginner-friendly API
- 🚫 No external dependencies

---

# 📦 Installation

Load the library using `loadstring`.

```lua
local Library = loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/GuysServices/asaplibrary/main/asaplibrary.lua"
))()
```

> 💡 **Tip**
>
> Host your own copy if you plan on making changes to the library.

---

# 🚀 Quick Start

Creating a basic window only takes a few lines.

```lua
local Library = loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/GuysServices/asaplibrary/main/asaplibrary.lua"
))()

local Window = Library:CreateWindow({
    Name = "ASAP Hub"
})

local Main = Window:CreateTab("Main")

Main:CreateButton({
    Name = "Print Hello",
    Callback = function()
        print("Hello World!")
    end
})
```

> 💡 **Tip**
>
> `CreateWindow()` returns a Window object. You'll use this object to create tabs.

---

# 🪟 Creating a Window

Every interface begins with a window.

## Example

```lua
local Window = Library:CreateWindow({
    Name = "ASAP Hub"
})
```

## Parameters

| Property | Type | Description |
|-----------|------|-------------|
| Name | string | Window title shown in the top bar. |

---

# 📂 Creating Tabs

Tabs separate your interface into multiple pages.

## Example

```lua
local Main = Window:CreateTab("Main")
local Settings = Window:CreateTab("Settings")
```

> 💡 **Tip**
>
> The first tab created is automatically selected.

---

# 📁 Sections

Sections create clean dividers inside tabs.

## Example

```lua
Main:CreateSection("Combat")
```

Result

```
────────────
Combat
────────────
```

Use sections whenever you want to organize controls into categories.

---

# ☑️ Toggles

Toggles are perfect for enabling or disabling features.

## Example

```lua
local AutoFarm = Main:CreateToggle({
    Name = "Auto Farm",
    CurrentValue = false,

    Callback = function(Value)
        print("Auto Farm:", Value)
    end
})
```

## Parameters

| Property | Type | Default | Description |
|-----------|------|---------|-------------|
| Name | string | `"Toggle"` | Text displayed beside the toggle. |
| CurrentValue | boolean | `false` | Default state. |
| Callback | function | `function() end` | Called whenever the toggle changes. |

## Returned Functions

```lua
AutoFarm:SetState(true)

print(AutoFarm:GetState())
```

| Function | Description |
|----------|-------------|
| `SetState(boolean)` | Changes the toggle state. |
| `GetState()` | Returns the current state. |

> 💡 **Tip**
>
> Calling `SetState()` also fires the callback, keeping your UI and logic synchronized.

---

# 🎚️ Sliders

Sliders let users select a value within a range.

## Example

```lua
local WalkSpeed = Main:CreateSlider({
    Name = "Walk Speed",

    Min = 16,
    Max = 100,

    CurrentValue = 16,

    Suffix = " Studs",

    Callback = function(Value)
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
    end
})
```

## Parameters

| Property | Type | Default |
|-----------|------|---------|
| Name | string | `"Slider"` |
| Min | number | `0` |
| Max | number | `100` |
| CurrentValue | number | `Min` |
| Suffix | string | `""` |
| Callback | function | `function() end` |

## Returned Functions

```lua
WalkSpeed:SetValue(50)

print(WalkSpeed:GetValue())
```

| Function | Description |
|----------|-------------|
| `SetValue(number)` | Updates the slider value. |
| `GetValue()` | Returns the current value. |

> 💡 **Tip**
>
> Sliders automatically clamp values between the specified minimum and maximum.

---

# 📋 Dropdowns

Dropdowns allow users to choose one option from a list.

## Example

```lua
local Weapon = Main:CreateDropdown({
    Name = "Weapon",

    Options = {
        "AK-47",
        "M4A1",
        "AWP",
        "USP"
    },

    CurrentOption = "AK-47",

    Callback = function(Value)
        print(Value)
    end
})
```

## Parameters

| Property | Type | Default |
|-----------|------|---------|
| Name | string | `"Dropdown"` |
| Options | table | `{}` |
| CurrentOption | string | First option |
| Callback | function | `function() end` |

## Returned Functions

```lua
Weapon:SetValue("M4A1")

Weapon:SetOptions({
    "Knife",
    "Pistol",
    "Sniper"
})

print(Weapon:GetValue())
```

| Function | Description |
|----------|-------------|
| `SetValue(value)` | Selects an option. |
| `SetOptions(table)` | Replaces every dropdown option. |
| `GetValue()` | Returns the selected option. |

> 💡 **Tip**
>
> Updating the option list automatically refreshes the dropdown menu.

---

# 🔘 Buttons

Buttons execute code when clicked.

## Example

```lua
Main:CreateButton({
    Name = "Destroy GUI",

    Callback = function()
        print("Button clicked!")
    end
})
```

## Parameters

| Property | Type | Default |
|-----------|------|---------|
| Name | string | `"Button"` |
| Callback | function | `function() end` |

## Returned Functions

```lua
local Button = Main:CreateButton({
    Name = "Click Me",
    Callback = function()
    end
})

Button:SetText("New Text")
```

| Function | Description |
|----------|-------------|
| `SetText(string)` | Changes the button's displayed text. |

> 💡 **Tip**
>
> Buttons are ideal for actions like teleporting, loading scripts, or executing one-time functions.

---

# 🔔 Notifications

Display clean, stackable notifications anywhere on the player's screen.

## Example

```lua
Library:Notify({
    Title = "ASAP Library",
    Content = "Successfully Loaded!",
    Duration = 5
})
```

## Parameters

| Property | Type | Default |
|-----------|------|---------|
| Title | string | `"Notification"` |
| Content | string | `""` |
| Duration | number | `3` |

> 💡 **Tip**
>
> Multiple notifications automatically stack in the top-right corner and disappear after the specified duration.

---

# 📚 API Reference

## Library

```lua
Library:CreateWindow(config)

Library:Notify(config)
```

---

## Window

```lua
Window:CreateTab(name)
```

---

## Tab

```lua
Tab:CreateSection(name)

Tab:CreateToggle(config)

Tab:CreateSlider(config)

Tab:CreateDropdown(config)

Tab:CreateButton(config)
```

---

## Toggle

```lua
Toggle:SetState(boolean)

Toggle:GetState()
```

---

## Slider

```lua
Slider:SetValue(number)

Slider:GetValue()
```

---

## Dropdown

```lua
Dropdown:SetOptions(table)

Dropdown:SetValue(value)

Dropdown:GetValue()
```

---

## Button

```lua
Button:SetText(string)
```

---

# 💙 ASAP Library

Thank you for using **ASAP Library**.

Designed to be lightweight, easy to understand, and simple to integrate into any Roblox script.

If you enjoy the library, consider ⭐ **starring the repository** to support future updates.
