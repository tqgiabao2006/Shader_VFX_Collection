# ✨ SHADER_VFX_COLLECTION ✨

![ShaderLogo.PNG]()

[![Unity](https://img.shields.io/badge/Made_with-Unity-000?logo=unity&style=for-the-badge)](https://unity.com/)  
[![GitHub Repo](https://img.shields.io/badge/View_on-GitHub-blue?style=for-the-badge&logo=github)]()

---

## 🚀 Overview  
*SHADER_VFX_COLLECTION* is a collection of all visual effect that I have learned. It plays a key role to learn about rendering process, and foster my interst in graphic programming
After this, I will learn **High-Level Shader Language** and **OpenGL**

### 🎯 Key Effects
- 🙈 **Dissolve Effect** – Characters are disappeared by time with burning effect. 
- ⛩️ **Portal Effect** – A spining light in the center of a portal. 
- 🌊 **Wave Effect** – A wave rises and falls naturally, with foam effect around object intersecting with its surface
- 🖼️ **Pixelation Effect** – Turning a normal image to pixel image, moving the pixel assets like it is affected by winds
- 🥇 **Stylized Gold Effect** - Color tinted, with normal map, and stylized occlusion making a object has gold reflection, and gold-like surface
---

### 📌 Details

#### A. 🙈 DISSOLVE EFFECT
## Core Idea: Manipulate Alpha Clip Threshold over time to cut out part of a texture

**1. Turn rendering mode from `obaque` to `transparent`**
**2. Tint a `noise texture` to alpha channel of a `main texture`**
![NoiseImage.PNG]()


**3. Enable `Alpha Clip Threshold` that will cut out the pixel which has alpha value under it**
**4. Increase `Alpha Clip Threshold` by time**
![AlphaCLipThreshold.GIF]()

**5. Add `Edge Thickness` and `Edge Color` with emssion to tint color for part that will be cut**
![EdgeColor.PNG]()

**OPTIONAL: Create VFX Graph then synchronize with Shader Graph to track the area close to the disappeared area to create fire embles**
![VFXGraph.PNG]()


**OPTIONAL: Spawn animted butterfly after a model fully disappears**
![Butterfly.GIF]()

## FINAL RESULT
![RESULT.GIF]()

---

#### B. ⛩️ Portal Effect
## Core Idea: Use Polar Coordinate to twist a seamless noise texture into a circle, then rotate over time with multiples layers

**1. Use `Polar Coordinate` to twist noise texture**
![PolarCoordinate.PNG]()

**2. Rotate over time**
![ROTATE.GIFT]()

**3. Use mutliple layers with differnt color**
![Layers.GIF]()

## FINAL RESULT
![RESULT.GIF]()

---

#### C. 🌊 WAVE EFFECT
## Core effects:

**1. Tint color by depth:** `Screen Depth` return distance between camera and water surface pixel, `Screen Position` return distance between camera pixel inside surface, 
subtract `Screen Position` from `Screen Depth` to calculate depth then saturate to blend color from dark to light based on depth
![DEPTH.PNG]()

**2. Water surface:** Use `moving UVs` map with `Gradient Noise` and use `Normal From Height` to create normal, then map to the main texture
![NORMAL.PNG]()

**3. Wave movemnt:** Use `Split` to isolate only x component of vertices' positions, then moving by `Sine` wave over time 
![Wave.PNG]()

**4. Foam effect:** Use the same subgraph to calculate depth between the surface and the nearby object, then if the depth is larger than some threshold, detect its as a collision
between water surface and objects, then create foam nearby
![Foam.PNG]()

## FINAL RESULT

![WATER SURFACE.GIF]()

![ROCK.GIF]()

![ROTATE.GIF]()





**✨ How It Works**
A* combines:
- **G(n)** → The actual cost from the start node to the current node.
- **H(n)** → The estimated cost (heuristic) from the current node to the goal.
- **F(n) = G(n) + H(n)** → The total estimated cost of the path.

The algorithm **prioritizes nodes with the lowest `F(n)`**, ensuring an optimal and efficient path.  

**🕹 Application in Blood Vein**  
In **Mining**, A* is used for **vehicle movement and network optimization**, allowing mining cars to navigate efficiently.

**📌 Why A***  
✔ **Optimal & Efficient** – Finds the shortest path with minimal cost.  
✔ **Heuristic-Based** – Can be tuned for different movement styles.  
✔ **Scalable** – Works for both simple grids and complex road networks.  
✔ **Realistic and Random** – Can be modified with random variations to create more realistic behavior.  

---

#### **3. ⚙️ Procedural Mesh Generation**
- **Road Mesh:**
  - Pre-calculates four standard shape types with different angles: 180° (continuous road), 135°, 90° (corner road), and 45°.
  - Uses an enum **Direction**, assigned with bitwise integers to merge directions. Iterates through a node's neighbor list and calculates the direction between them.
  - Determines the number of standard shapes required, then rotates them accordingly.

![Bitwise Direction](https://github.com/tqgiabao2006/Blood-vein/raw/main/ReadMe/Enum%20Direction.png)

![Get Baked Directions](https://github.com/tqgiabao2006/Blood-vein/raw/main/ReadMe/Get%20direction.png)

  - Finally, uses polar coordinates to create smooth curves at sharp angles.

![Curve Mesh](https://github.com/tqgiabao2006/Blood-vein/raw/main/ReadMe/Smooth%20curve.png)

- **Parking Lot Mesh:**
  - Creates a rounded rectangle based on the building's size and direction.

---

#### **4. 🔀 Multi-threading with ECS**
- **Why Use It?**
  - **Performance**: Needed to handle large amounts of AI-driven entities (mining cars, roads) efficiently.
  - **Scalability**: Ensures smooth performance as complexity grows.
  - **Multithreading**: Avoids performance bottlenecks in pathfinding and vehicle movement.

- **How It Was Applied:**
  - **ECS (Entity Component System)**: Decouples game data (position, speed, etc.) from logic, improving memory usage and CPU performance.
  - **Multithreading**: Distributes intensive tasks across multiple CPU cores, maintaining **1000+ FPS** even with **1000 cars**.
  - **Burst Compiler**: Optimizes performance-critical code, improving runtime execution efficiency.

### **Drawbacks**
- **Complexity**: DOTS requires a new approach to game architecture, increasing development difficulty.
- **Debugging Challenges**: Multithreading introduces race conditions and synchronization issues.
- **Imperfect for Uncertain Data**: User-defined data types that change unpredictably can cause issues in road calculations and building placement.

![ECS](https://github.com/tqgiabao2006/Blood-vein/raw/main/ReadMe/ECS.png)

---
## 🎥 Demo Gameplay Video
![Gameplay Preview](https://github.com/tqgiabao2006/Blood-vein/raw/main/ReadMe/Gameplay.gif)

---

## 🛠 Tech Stack  
| **Technology**   | **Usage**  |  
|-----------------|-----------|  
| Unity (C#) | Core Engine & Gameplay |  
| Shader Graph | Visual Effects & Water Rendering |  
| A* Algorithm | Pathfinding |  
| ECS (Entity Component System) | Multi-threading Performance |  

---

## 🏗 Design Patterns Used  
✔ **Observer Pattern** – Event-driven architecture for game logic.  
✔ **State Pattern** – AI and game state transitions.  
✔ **Factory Pattern** – Dynamic object creation.  
✔ **Unity Test Framework** – Ensures stability and correctness.  

---

## 🎮 Current Status  
📦 **Developing**

---

## 🚧 Development Roadmap  
🔹 **[ ] Multiplayer Mode** – Co-op city building.  
🔹 **[ ] Improved AI Steering** – Smarter vehicle movement.  
🔹 **[ ] Procedural Environment** – Dynamic terrain growth.  
🔹 **[ ] Transition to 3D Perspective**  

---

## 🏆 Contributors & Credits  
👨‍💻 **Ben** (*Mad Scientist of Game Lab*) – Solo Developer  
🎵 **Music & SFX:** Open-source / Custom Compositions  
📖 **Special Thanks:** [Unity Vietnam Community], and Senior Game Artist Tung Anh as an advisor  

---

## ⭐ Support & Feedback  
💬 **Have feedback?** Open an [issue](https://github.com/tqgiabao2006/blood-vein/issues) or contact me via email: tqgiabao2006@gmail.com.  
🎮 **Follow my journey:** [🔗 Portfolio](https://your-portfolio-link.com)  
