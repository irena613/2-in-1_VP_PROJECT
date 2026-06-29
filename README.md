# 2-in-1 VP Project

Two games, one launcher. Built with **Godot 4.3**.

---

## Games

### Treasure-Hunting-Hound

![Main menu](screenshots/treasure-hunting-hound-menu.png)

A 3D first-person game where you play as a dog exploring a large open map. Collect **25 coins** and **7 keys** and reach the treasure chest before the timer runs out.

**How to play:**
- Move with `WASD / Arrow keys`, look around with the mouse, hold `Shift` to run
- Collect all 25 coins and 7 keys hidden across the map
- You can see your progress at the top
- Reach the chest with all items collected to win
- You have **7 minutes** — if the timer hits 0, it's Game Over

**Mechanics:**
- Coins and keys spawn at random positions every new game
- If you stand too close to a key for **5 seconds** without moving, it despawns and respawns elsewhere
- The chest's light grows brighter with each key collected

![Game](screenshots/treasure-hunting-hound.png)

---

### The Forgotten Melody

![Main menu](screenshots/forgotten-melody-menu.png)

A 2D platformer where you play as Whalien across 7 levels. Each level has **13 floating musical notes** to collect before the portal to the next level opens.

**How to play:**
- Move with `A`/`D` or arrow keys, jump with `Space`
- Collect all 13 notes — each plays a unique sound when picked up
- Once all notes are collected, the portal opens — enter it to complete the level
- Fall off the map and you get a Game Over — retry or return to the menu
- Complete all 7 levels to reach the Win Screen

**Mechanics:**
- Notes have a float animation and are randomly repositioned each run
- Levels unlock one by one as you complete them
- Progress saves automatically — next launch you continue from where you left off

![Level select screen](screenshots/forgotten-melody-level-menu.png)

![In-game note collection](screenshots/forgotten-melody-level-1-look.png)

---

### Launcher

![Launcher menu](screenshots/launcher.png)

A simple menu with two buttons, one for each game. Clicking a button starts the selected game as a separate process and closes the launcher.

**Folder contents:**
```
2-in-1/
├── 2-in-1.exe
├── The Forgo_ten Melody.exe
├── Treasure-Hunting-Hound.exe
└── godot-jolt_windows-x64_editor.dll
```

> The `.dll` file must stay in the same folder as the `.exe` files for Treasure-Hunting-Hound to run correctly.

---

## Controls

| Action | Treasure-Hunting-Hound | The Forgotten Melody |
|--------|------------------------|----------------------|
| Move | `W` `A` `S` `D` / arrow keys | `A` / `D` or arrow keys |
| Look | Mouse | — |
| Run | `Shift` | — |
| Jump | `Space` | `Space` / `W` |
| Exit | `ESC` | `ESC` (back to menu) |

---

## Built With

- [Godot 4.3](https://godotengine.org/)
- GDScript
- JoltPhysics3D (Treasure-Hunting-Hound)

## Game Play
![Short Gameplay Video](short-gameplay.gif)
