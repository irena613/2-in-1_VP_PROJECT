# 2-in-1 VP Project

A combined launcher that packages two independently developed games into a single entry point. Select a game from the launcher and it opens as its own process — no setup required.

Built with **Godot 4.3** · GDScript · Windows

---

## Games

- [Treasure-Hunting-Hound](#treasure-hunting-hound) — 3D first-person treasure hunt
- [The Forgotten Melody](#the-forgotten-melody) — 2D platformer with a musical collectible mechanic

---

## Treasure-Hunting-Hound

![Main menu](screenshots/treasure-hunting-hound-menu.png)

A 3D first-person game where you play as a dog exploring a large open map. Your goal is to collect **25 coins** and **7 keys** scattered across the environment and reach the treasure chest — all within a **7-minute** time limit.

### Gameplay

![In-game](screenshots/treasure-hunting-hound.png)

- Move with `WASD`, look around with the mouse, hold `Shift` to run
- The HUD at the top of the screen tracks your coin and key count at all times
- Once you have collected everything, head to the chest to win
- If the timer reaches zero before you finish, it's Game Over

### Features

- Coins and keys are placed at random positions at the start of every session
- Linger too close to a key for more than **5 seconds** and it despawns and reappears somewhere else on the map
- The chest emits a stronger glow with each key collected, giving you a visual sense of progress
- The chest only opens when all 25 coins and all 7 keys have been collected

---

## The Forgotten Melody

![Main menu](screenshots/forgotten-melody-menu.png)

A 2D side-scrolling platformer where you play as **Whalien** across 7 handcrafted levels. Each level contains **13 floating musical notes** — collect them all to open the portal and advance to the next level.

### Gameplay

![Level select](screenshots/forgotten-melody-level-menu.png)

![In-game](screenshots/forgotten-melody-level-1-look.png)

- Move with `A` / `D` or the arrow keys, jump with `Space`
- Every note plays a unique sound when collected
- Collect all 13 notes in a level to unlock the exit portal, then enter it to proceed
- Falling off the map ends the run — you can retry the level or return to the menu
- Finish all 7 levels to reach the Win Screen

### Features

- Notes float with a smooth bobbing animation and are randomly repositioned at the start of each run
- Levels unlock sequentially — you must complete one to access the next
- Progress is saved automatically after each level, so you can pick up where you left off
- Completing all 7 levels triggers a confetti Win Screen

---

## Launcher

![Launcher](screenshots/launcher.png)

A minimal menu with one button per game. Clicking a button launches the selected game as a separate process and closes the launcher automatically.

### Project Structure

```
2-in-1/
├── 2-in-1.exe
├── The Forgo_ten Melody.exe
├── Treasure-Hunting-Hound.exe
└── godot-jolt_windows-x64_editor.dll
```

> `godot-jolt_windows-x64_editor.dll` must remain in the same folder as the executables for Treasure-Hunting-Hound to run correctly.

---

## Key Classes and Functions

### KeySpawner — `key_spawner.gd`

Responsible for placing 7 keys at valid positions across the 3D map at the start of each session, and for managing key respawning during gameplay.

At initialisation, the spawner runs a loop until 7 valid positions have been found. For each candidate position, it generates random X and Z coordinates within the map boundaries and checks them against a set of exclusion rules: the position must not fall inside the lake area, must not be too close to the chest or the player's starting point, and must be at least 35 units away from any already-placed key. If all conditions pass, the key is placed; otherwise a new candidate is generated. During gameplay, if a player stands near a key for more than 5 seconds without collecting it, the spawner removes it and runs the same placement logic again for that single key.

This class is important because it directly affects fairness and replayability. Without the distance constraint, keys could cluster together. Without the exclusion zones, keys could appear inside geometry or in unreachable spots. The respawn mechanic prevents the player from idling near a key, which would otherwise break the time-pressure design.

---

### CoinSpawner — `coin_spawner.gd`

Responsible for placing 25 coins at random positions across the map at the start of each session.

The logic is simpler than KeySpawner — it generates random X and Z coordinates within the map bounds and only excludes the lake area. No minimum distance between coins is enforced, since coins are more numerous and their clustering is less impactful on gameplay. All 25 instances are placed in a single pass at scene initialisation and remain fixed for the rest of the session.

This class keeps the coin placement logic self-contained and separate from the player and HUD scripts, making it easy to adjust the number of coins or the spawn boundaries without touching other systems.

---

### LevelBase — `level_base.gd`

A base class inherited by all 7 levels in The Forgotten Melody. It handles everything that is common across levels: note spawning, the win condition, and the Game Over trigger.

At the start of each level, it iterates over the 13 note nodes and repositions each one at a random coordinate within the playable area of the level. Each note also receives a start position used by a sine function to produce a smooth floating animation throughout the session. When the player collects a note, a signal is received by the base class, which updates the counter and removes the node. Once the counter reaches 13, the portal is activated. If the player falls off the map, the base class detects it and loads the Game Over screen.

Without this base class, the same spawning, counting, and transition logic would need to be duplicated across all 7 level scripts. Centralising it here means any change to core level behaviour only needs to be made in one place.

---

## Controls

| Action | Treasure-Hunting-Hound | The Forgotten Melody |
|--------|------------------------|----------------------|
| Move | `W` `A` `S` `D` | `A` / `D` or arrow keys |
| Look | Mouse | — |
| Run | `Shift` | — |
| Jump | `Space` | `Space` |
| Exit / Menu | `ESC` | `ESC` |

---

## Gameplay Video

A short gameplay clip is available below. For the full playthrough, see the [Dropbox recording](https://www.dropbox.com/scl/fo/fiu3sndv9cnaizjavf7hy/AIuWx5AAzjNyhMscLxnkeQY?rlkey=y2c020ngayyci2mexx1fgxsjn&st=ogq29rd3&dl=0).

![Gameplay](short-gameplay.gif)

---

## Built With

- [Godot 4.3](https://godotengine.org/)
- GDScript
- JoltPhysics3D — physics backend for Treasure-Hunting-Hound
