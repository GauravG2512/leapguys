# 🎮 Leap Guys

<p align="center">
  <img src="splash-screen.png" alt="Leap Guys Banner" width="720"/>
</p>

<p align="center">
  <b>A vibrant, fast-paced 3D platformer built in Godot Engine featuring multi-jump mechanics, moving platforms, collapsing hazards, and thrilling level design.</b>
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Engine-Godot%204-478CBF?style=for-the-badge&logo=godotengine&logoColor=white" alt="Godot 4"/>
  <img src="https://img.shields.io/badge/Genre-3D%20Platformer-FF6F00?style=for-the-badge" alt="Genre 3D Platformer"/>
  <img src="https://img.shields.io/badge/Status-Playable-success?style=for-the-badge" alt="Playable"/>
</p>

---

## 📸 Gameplay Screenshot

<p align="center">
  <img src="screenshots/gameplay.png" alt="Leap Guys Gameplay Screenshot" width="850"/>
</p>

---

## 🌟 About the Game

**Leap Guys** is a 3D precision platformer with smooth movement, airborne multi-jumping, and obstacle courses designed to test your timing and agility. Guide your character across perilous floating islands, avoid falling into the void, collect shiny coins, and reach the finish flag across 5 unique levels!

---

## 🕹️ Levels Overview

1. **Level 1 — Garden Run**
   - *Beginner Course*: A gentle introduction to core mechanics with standard single jumps across lush, winding grass platforms.
2. **Level 2 — Double / Triple Leap**
   - *Aerial Agility*: Introduces airborne multi-jumps. Clear wide canyon gaps requiring double and triple jump timing.
3. **Level 3 — Drifting Switchbacks**
   - *Moving Hazards*: Ascend an S-shaped mountain path with dynamic platforms oscillating across the X, Y, and Z axes.
4. **Level 4 — Falling Trail**
   - *Collapsing Footing*: High-tension courses where platforms shake and drop beneath your feet—keep moving or fall!
5. **Level 5 — Sky Ruins**
   - *The Ultimate Gauntlet*: An expansive 21-platform endurance test combining triple jumps, drifting platforms, and falling tiles.

---

## 🎮 Controls

| Action | Keyboard / Mouse | Gamepad |
| :--- | :--- | :--- |
| **Move** | <kbd>W</kbd> <kbd>A</kbd> <kbd>S</kbd> <kbd>D</kbd> / Arrow Keys | Left Analog Stick |
| **Jump / Multi-Jump** | <kbd>Space</kbd> | Bottom Button (A / Cross) |
| **Rotate Camera** | Hold <kbd>Right Click</kbd> & Drag | Right Analog Stick |
| **Zoom Camera** | <kbd>Mouse Wheel</kbd> | - |
| **Restart Level** | <kbd>R</kbd> | Select / Back |
| **Release Mouse** | <kbd>Esc</kbd> | - |

---

## ✨ Features

- **Fluid Movement & Multi-Jump**: Responsive character movement with support for double and triple jump sequences.
- **Dynamic Platform Types**: Stationary, oscillating/moving, and crumbling falling platforms.
- **Checkpoint & Respawn System**: Smart checkpoints ensure smooth gameplay without losing your hard-earned progress.
- **Orbital 3D Camera**: Free orbital rotation and zoom controls for spatial awareness.
- **Polished Audio & Feedback**: Satisfying sound effects for jumping, landing, collecting coins, and falling platforms.
- **Clean HUD & UI**: Level counter, coin tracker, splash screen, and victory celebration screens.

---

## 🚀 How to Run & Play

### Requirements
- [Godot Engine 4.x](https://godotengine.org/download) (Godot 4.2+ recommended)

### Running the Project
1. Clone or download this repository:
   ```bash
   git clone https://github.com/GauravG2512/leapguys.git
   ```
2. Open the **Godot Project Manager**.
3. Click **Import** and navigate to this folder.
4. Select `project.godot` and click **Import & Edit**.
5. Press <kbd>F5</kbd> (or click the **Play** button in the top right corner) to launch the game!

---

## 📁 Project Structure

```
leapguys/
├── fonts/            # Custom typography & fonts
├── meshes/           # Custom mesh definitions
├── models/           # 3D models (characters, platforms, coins, clouds)
├── objects/          # Reusable scene objects (player, coins, platforms)
├── scenes/           # Core environments and level scenes
├── screenshots/      # Gameplay screenshots & promotional images
├── scripts/          # GDScript game logic (character controller, camera, HUD)
├── sounds/           # Audio effects (jump, land, break, coins)
├── sprites/          # 2D sprites, shadows, skybox textures
├── project.godot     # Main Godot project configuration
└── README.md         # Documentation
```
