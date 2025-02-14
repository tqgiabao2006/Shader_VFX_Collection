# ✨ SHADER_VFX_COLLECTION ✨

![ShaderLogo.PNG]()

[![Unity](https://img.shields.io/badge/Made_with-Unity-000?logo=unity&style=for-the-badge)](https://unity.com/)  
[![GitHub Repo](https://img.shields.io/badge/View_on-GitHub-blue?style=for-the-badge&logo=github)]()

---

### 🚀 Overview  
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

## A. 🙈 DISSOLVE EFFECT
**Core Idea:** Manipulate Alpha Clip Threshold over time to cut out part of a texture

**1.** Turn rendering mode from `obaque` to `transparent`

**2.** Tint a `noise texture` to alpha channel of a `main texture`
![NoiseImage.PNG]()


**3.** Enable `Alpha Clip Threshold` that will cut out the pixel which has alpha value under it
**4.** Increase `Alpha Clip Threshold` by time**
![AlphaCLipThreshold.GIF]()

**5.** Add `Edge Thickness` and `Edge Color` with emssion to tint color for part that will be cut
![EdgeColor.PNG]()

**Optional:** Create VFX Graph then synchronize with Shader Graph to track the area close to the disappeared area to create fire embles
![VFXGraph.PNG]()


**Optional:** Spawn animted butterfly after a model fully disappears
![Butterfly.GIF]()

---
## FINAL RESULT

**Before**

**After**

![RESULT.GIF]()

---

#### B. ⛩️ Portal Effect
**Core Idea:** Use Polar Coordinate to twist a seamless noise texture into a circle, then rotate over time with multiples layers

**1**. Use `Polar Coordinate` to twist noise texture
![PolarCoordinate.PNG]()

**2**. Rotate over time
![ROTATE.GIFT]()

**3.** Use mutliple layers with differnt color
![Layers.GIF]()

---
## FINAL RESULT

**Before**

**After**

![RESULT.GIF]()

---

#### C. 🌊 WAVE EFFECT
**Core effects:**

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

---
## FINAL RESULT

**Before**

**After**

![RESULT.GIF]()
![WATER SURFACE.GIF]()

![ROCK.GIF]()

![ROTATE.GIF]()

---

#### D. 🖼️ PIXELATION EFFECTS
**Core steps:**

**1.** Multiples `UVs` with some constant resolution rate, then `Floor` it and divides with the resolution rate to get a pixel rendering effect
![Pixelation]()

**2.** Use 'Time' to move 'Voronoi' node then connect it to 'Blend' to blend a 'UVs' of main textrue to moving 'Vornoi' noise create a moving pixel effect
![Voronoi]()

---
## FINAL RESULT

**Before**

**After**

![RESULT.GIF]()

---

#### E. 🥇 TYLIZED GOLD EFFECT
**Core effects**

**1.** Apply Normal Map
![Normal]()

**2.** Spectacular: Use `View Direction` with `Dot Product` to calculate the pixels are directly lighted, then tint it with spectacular `Color` 
![Spectacular.PNG]()

**3.** Trim effect: Use `Fresnel Effect` then tint with rim `Color` to make a soft light shine in the brightest part

**Optional:** Toon Shading

---
## FINAL RESULT

**Before**

**After**

![RESULT.GIF]()


---

## 🎮 Current Status  
📦 **Developing**

---


## 🏆 Contributors & Credits  
👨‍💻 **Ben** (*Mad Scientist of Game Lab*) – Solo Developer  
🎵 **Music & SFX:** Open-source / Custom Compositions  
📖 **Special Thanks:** [Unity Vietnam Community], Senior Game Artist Tung Anh as an advisor
🔥 **Inspired by:** Daniel Ilett, MinionsArt,Acerola

---

## ⭐ Support & Feedback  
💬 **Have feedback?** Open an [issue](https://github.com/tqgiabao2006/blood-vein/issues) or contact me via email: tqgiabao2006@gmail.com.  
🎮 **Follow my journey:** [🔗 Portfolio](https://your-portfolio-link.com)  
