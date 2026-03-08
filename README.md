<div align="center">

```
██╗██╗    ██╗ █████╗       ██████╗ ███████╗ ██████╗
██║██║    ██║██╔══██╗     ██╔════╝ ██╔════╝██╔════╝
██║██║ █╗ ██║╚█████╔╝     ██║  ███╗███████╗██║
██║██║███╗██║██╔══██╗     ██║   ██║╚════██║██║
██║╚███╔███╔╝╚█████╔╝     ╚██████╔╝███████║╚██████╗
╚═╝ ╚══╝╚══╝  ╚════╝       ╚═════╝ ╚══════╝ ╚═════╝
```

### `GSC SCRIPTING LAB`

![Engine](https://img.shields.io/badge/Engine-IW8-FF0000?style=for-the-badge&logo=data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdCb3g9IjAgMCAyNCAyNCI+PHBhdGggZmlsbD0id2hpdGUiIGQ9Ik0xMiAyTDIgN2wxMCA1IDEwLTV6TTIgMTdsOCA1IDgtNVYybC04IDUtOC01eiIvPjwvc3ZnPg==&logoColor=white)
![Language](https://img.shields.io/badge/Language-GSC-00FF41?style=for-the-badge)
![Game](https://img.shields.io/badge/Game-Call%20of%20Duty%C2%AE-1a1a2e?style=for-the-badge)
![Status](https://img.shields.io/badge/Status-Active%20Research-FFD700?style=for-the-badge)
![License](https://img.shields.io/badge/License-MIT-blue?style=for-the-badge)

<br/>

> *A personal lab for testing, reverse-engineering, and mastering GSC scripting on the IW8 engine.*

</div>

---

## ⚡ What Is This?

This repo is my **sandbox and knowledge base** for everything GSC on the **IW8 engine** — the engine powering the Call of Duty® titles built on Infinity Ward's eighth-generation tech.

Whether I'm poking at game logic, building custom scripts, or documenting discoveries — it all lives here.

```gsc
// Entry point
init()
{
    level thread onPlayerConnect();
}

onPlayerConnect()
{
    for(;;)
    {
        level waittill( "connected", player );
        player thread onPlayerSpawned();
    }
}

onPlayerSpawned()
{
    self waittill( "spawned_player" );
    self iprintln( "^2Welcome to IW8-GSC-SCRIPTING" );
}
```

---

## 🔬 Areas of Research

| Area | Description | Status |
|------|-------------|--------|
| 🎮 **Player Logic** | Spawn events, health, movement callbacks | 🟢 Active |
| 🌐 **Level Scripting** | Entity management, trigger zones | 🟡 In Progress |
| 🧠 **AI / Bots** | NPC goal states & navigation hooks | 🔴 Early Research |
| 💬 **Notifications** | `waittill` / `notify` patterns | 🟢 Active |
| 🎯 **Weapon Data** | Weapon definitions & stat hooks | 🟡 In Progress |
| 🛠️ **Utility Libs** | Array helpers, string ops, math utils | 🟢 Active |

---

## 📖 GSC Quick Reference

<details>
<summary><b>🧵 Threading Patterns</b></summary>

```gsc
// Spawn a thread on an entity
entity thread myFunction();

// Spawn a thread on level
level thread myFunction();

// Wait for a notification
self waittill( "event_name" );

// Fire a notification
self notify( "event_name" );

// Yield execution
wait 0.05;  // wait N seconds
```
</details>

<details>
<summary><b>🔁 Common Loop Patterns</b></summary>

```gsc
// Infinite loop (must have a wait!)
for(;;)
{
    // do something
    wait 0.1;
}

// Wait for condition
while( !self isOnGround() )
{
    wait 0.05;
}
```
</details>

<details>
<summary><b>📦 Arrays & Data</b></summary>

```gsc
// Create and iterate an array
players = getEntArray( "player", "classname" );

for( i = 0; i < players.size; i++ )
{
    players[i] iprintln( "^3Hello, " + players[i].name );
}
```
</details>

<details>
<summary><b>⚠️ Common Gotchas</b></summary>

- Always `wait` inside `for(;;)` loops or you'll hang the server
- GSC is **not typed** — variables can change type at runtime
- `self` refers to the entity the thread is running on
- Strings are compared with `==`, not `.equals()`
- Function names are **case-sensitive**
</details>

---

## 🚀 Getting Started

```bash
# Clone the repo
git clone https://github.com/YOUR_USERNAME/IW8-GSC-SCRIPTING.git
cd IW8-GSC-SCRIPTING

# Browse scripts
ls scripts/experiments/
```

> **Note:** Scripts here are for **research and educational purposes**. Always ensure you comply with the game's terms of service before using any modifications online.

---

## 📚 Resources

| Resource | Link |
|----------|------|
| 📘 GSC Modtools Docs | [Infinity Ward Modtools](https://www.infinityward.com) |
| 💬 Modding Communities | [UnknownCheats](https://unknowncheats.me) · [CabCon Forums](https://cabconmodding.com) |
| 🛠️ Compiler Tools | [GSC Tool by xensik](https://github.com/xensik/gsc-tool) |
| 📖 IW Engine History | Community wikis & reverse-engineering docs |

---

<div align="center">

**Built with curiosity. Fueled by caffeine. Guided by `waittill("understanding", knowledge);`**

⭐ *Star this repo if it helped you learn something new!*

</div>
