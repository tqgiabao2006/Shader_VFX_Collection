# ✨ SHADER_VFX_COLLECTION ✨

![ShaderLogo.PNG](https://github.com/tqgiabao2006/Shader_VFX_Collection/raw/main/Readme/ShaderLogo.png)

[![Unity](https://img.shields.io/badge/Made_with-Unity-000?logo=unity&style=for-the-badge)](https://unity.com/)  
[![GitHub Repo](https://img.shields.io/badge/View_on-GitHub-blue?style=for-the-badge&logo=github)]()

---

### 🚀 Overview  
*SHADER_VFX_COLLECTION* is a collection of all visual effects that I have learned. It plays a key role in understanding the rendering process and fosters my interest in graphic programming.  
After this, I will learn **High-Level Shader Language** and **OpenGL**.

### 🎯 Key Effects
- 🙈 **Dissolve Effect** – Characters disappear over time with a burning effect.  
- ⛩️ **Portal Effect** – A spinning light in the center of a portal.  
- 🌊 **Wave Effect** – A wave rises and falls naturally, with a foam effect around objects intersecting with its surface.  
- 🖼️ **Pixelation Effect** – Converts a normal image into a pixelated image, moving the pixel assets as if affected by wind.  
- 🥇 **Stylized Gold Effect** – Color-tinted with a normal map and stylized occlusion, giving an object a gold-like reflection and surface.  

---

### 📌 Details

## A. 🙈 DISSOLVE EFFECT
**Core Idea:** Manipulate the Alpha Clip Threshold over time to cut out parts of a texture.

**1.** Tint a `noise texture` to the alpha channel of a `main texture`.  
**2.** Change rendering mode from `opaque` to `transparent`.  

![NoiseImage.PNG](https://github.com/tqgiabao2006/Shader_VFX_Collection/raw/main/Readme/DIssolve_NoiseMap.png)

**3.** Enable `Alpha Clip Threshold`, which will cut out pixels with an alpha value below it.  
**4.** Increase `Alpha Clip Threshold` over time.  
**5.** Add `Edge Thickness` and `Edge Color` with emission to tint the color of the disappearing parts.  

![EdgeColor.PNG](https://github.com/tqgiabao2006/Shader_VFX_Collection/raw/main/Readme/DIssolve_Color_Alpha.png)

**Optional:** Create a VFX Graph and synchronize it with Shader Graph to track the disappearing area and create fire embers.  

![VFXGraph.PNG](https://github.com/tqgiabao2006/Shader_VFX_Collection/raw/main/Readme/Dissolve_VFX.png)

**Optional:** Spawn an animated butterfly after a model fully disappears.  

![Butterfly.GIF](https://github.com/tqgiabao2006/Shader_VFX_Collection/raw/main/Readme/DIssolve_Butterfly.gif)

---
#### FINAL RESULT

**Before:**  

![Before.GIF](https://github.com/tqgiabao2006/Shader_VFX_Collection/raw/main/Readme/Dissolve_Before.gif)

**After:**  

![After.GIF](https://github.com/tqgiabao2006/Shader_VFX_Collection/raw/main/Readme/Dissolve_After.gif)

---

## B. ⛩️ PORTAL EFFECT
**Core Idea:** Use Polar Coordinates to twist a seamless noise texture into a circle, then rotate it over time with multiple layers.

**1.** Use `Polar Coordinates` to twist the noise texture.  
**2.** Rotate over time.  

![ROTATE.GIFT](https://github.com/tqgiabao2006/Shader_VFX_Collection/raw/main/Readme/Portal_Porlar%20%2B%20Rotate.gif)

**3.** Use multiple layers with different colors.  

![Layers.GIF](https://github.com/tqgiabao2006/Shader_VFX_Collection/raw/main/Readme/Portal_Layers.gif)

---
#### FINAL RESULT

**Before:**  

![Before.GIF](https://github.com/tqgiabao2006/Shader_VFX_Collection/raw/main/Readme/Portal_Before.gif)

**After:**  

![After.GIF](https://github.com/tqgiabao2006/Shader_VFX_Collection/raw/main/Readme/Portal_After.gif)

---

## C. 🌊 WAVE EFFECT
**Core Effects:**

**1. Tint color by depth:** `Screen Depth` returns the distance between the camera and the water surface pixels. `Screen Position` returns the distance between the camera and pixels inside the surface. Subtract `Screen Position` from `Screen Depth` to calculate depth, then saturate to blend colors from dark to light based on depth.  

![DEPTH.PNG](https://github.com/tqgiabao2006/Shader_VFX_Collection/raw/main/Readme/Water_ColorDepth.png)

**2. Water surface:** Use `moving UVs` mapped with `Gradient Noise` and apply `Normal From Height` to create normal mapping.  

![NORMAL.PNG](https://github.com/tqgiabao2006/Shader_VFX_Collection/raw/main/Readme/Wave_refraction.gif)

**3. Wave movement:** Isolate the x-component of vertex positions and move it with a `Sine` wave over time.  

![Wave.PNG](https://github.com/tqgiabao2006/Shader_VFX_Collection/raw/main/Readme/Water_Wave.gif)

**4. Foam effect:** Detect the depth between the surface and nearby objects, then generate foam at collision points.  

![Foam.PNG](https://github.com/tqgiabao2006/Shader_VFX_Collection/raw/main/Readme/Water_Foam.gif)

---
#### FINAL RESULT

**Before:**  

![Before.GIF](https://github.com/tqgiabao2006/Shader_VFX_Collection/raw/main/Readme/Water_Before.gif)

**After:**  

![After.GIF](https://github.com/tqgiabao2006/Shader_VFX_Collection/raw/main/Readme/Water_After.gif)

---

## D. 🎮 PIXELATION EFFECTS

**Core steps:**  

**1.** Multiply `UVs` with a constant resolution rate, then `Floor` it and divide by the resolution rate to achieve a pixelated rendering effect.  
![Pixelation](https://github.com/tqgiabao2006/Shader_VFX_Collection/raw/main/Readme/Pixelation.png)  

**2.** Use `Time` to move the `Voronoi` node, then connect it to `Blend` to blend the `UVs` of the main texture with the moving `Voronoi` noise, creating a dynamic pixel effect.  
![Voronoi](https://github.com/tqgiabao2006/Shader_VFX_Collection/raw/main/Readme/Voronoi.gif)  

---  
#### FINAL RESULT  

**Before:**  

![Before.GIF](https://github.com/tqgiabao2006/Shader_VFX_Collection/raw/main/Readme/Pixel_Before.gif)  

**After:**  

![After.GIF](https://github.com/tqgiabao2006/Shader_VFX_Collection/raw/main/Readme/Pixel_After.gif)  

---  

## E. 🏆 STYLIZED GOLD EFFECT  

**Core effects:**  

**1.** Apply a Normal Map.  
![Normal](https://github.com/tqgiabao2006/Shader_VFX_Collection/raw/main/Readme/Normal.png)  

**2.** Specular Effect: Use `View Direction` with `Dot Product` to determine the pixels that receive direct lighting, then tint them with a specular `Color`.  
![Spectacular.PNG](https://github.com/tqgiabao2006/Shader_VFX_Collection/raw/main/Readme/Spectacular.png)  

**3.** Rim Effect: Use the `Fresnel Effect`, then tint with a rim `Color` to create a soft glow on the brightest parts.  
![Trim.PNG](https://github.com/tqgiabao2006/Shader_VFX_Collection/raw/main/Readme/Rim%20Effect.png)  

**Optional:** Implement Toon Shading for a more stylized look.  

---  
#### FINAL RESULT  

**Before:**  

![Before.GIF](https://github.com/tqgiabao2006/Shader_VFX_Collection/raw/main/Readme/Gold_Before.gif)  

**After:**  

![After.GIF](https://github.com/tqgiabao2006/Shader_VFX_Collection/raw/main/Readme/Gold_After%201.gif)  
![After.GIF](https://github.com/tqgiabao2006/Shader_VFX_Collection/raw/main/Readme/Gold_After_2.gif)  

---


## 🎮 Current Status  
📦 **Developing**

---

## 🏆 Contributors & Credits  
👨‍💻 **Ben** (*Mad Scientist of Game Lab*) – Solo Developer  
🎵 **Music & SFX:** Open-source / Custom Compositions  
📖 **Special Thanks:** [Unity Vietnam Community], Senior Game Artist Tung Anh as an advisor  
🔥 **Inspired by:** Daniel Ilett, MinionsArt, Acerola  

---

## ⭐ Support & Feedback  
💬 **Have feedback?** Open an [issue](https://github.com/tqgiabao2006/blood-vein/issues) or contact me via email: tqgiabao2006@gmail.com.  
🎮 **Follow my journey:** [🔗 Portfolio](https://your-portfolio-link.com)  
