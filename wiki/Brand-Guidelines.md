# Brand Guidelines 

This page defines how ATHA visual assets should be used consistently across GitHub, the AUR, documentation screenshots, and social posts.

## Core Identity

* **Name:** ATHA
* **Tagline:** A safety and workflow layer for pacman on Arch Linux.
* **Voice:** Technical, concise, practical.

## Logo Files

All official vector assets are stored in the `assets/branding/` directory:

* **Full logo:** `atha-logo.svg`
* **Full logo (dark):** `atha-logo-dark.svg`
* **Full logo (light):** `atha-logo-light.svg`
* **Mark/icon:** `atha-mark.svg`
* **Avatar:** `atha-avatar.svg`
* **Favicon:** `atha-favicon.svg`
* **Social banner:** `atha-banner.svg`

## Recommended Usage

* **Full Logo:** Use for `README.md` headers, official documentation, and presentations.
* **Mark / Avatar:** Use for repository profile images and compact UI placements.
* **Banner:** Use for social media preview images, link unfurling, and major announcements.
* **Source of Truth:** Always prefer the SVG format to avoid scaling artifacts or quality loss.

## Color and Contrast

* Use the **light logo** on dark backgrounds to ensure visibility.
* Use the **dark logo** on light backgrounds.
* Always preserve high contrast for accessibility and screenshot readability.

## Minimum Clear Space & Size

* **Clear Space:** Keep a margin of clear space around the logo at least equal to the height of the letter **A** in ATHA.
* **Minimum Size (Full Logo):** At least **180px** wide in digital contexts.
* **Minimum Size (Mark/Avatar):** At least **32px by 32px**.

## ✅ Do and ❌ Do Not

**Do:**
* ✅ Keep the aspect ratio unchanged.
* ✅ Use original colors and contrast-safe backgrounds.
* ✅ Pick the dark or light variant based on the background tone.

**Do not:**
* ❌ Stretch, squash, or distort the logo.
* ❌ Add heavy effects, drop shadows, outlines, or glows.
* ❌ Rotate or recolor the logo arbitrarily.

## PNG Export (Arch Linux)

If you need rasterized versions of the logo, you can easily generate them on Arch Linux.

**1. Install the SVG converter:**
```bash
sudo pacman -S librsvg

```

**2. Generate common outputs:**

```bash
rsvg-convert -h 32 -w 32 assets/branding/atha-favicon.svg > assets/branding/atha-favicon-32.png
rsvg-convert -h 64 -w 64 assets/branding/atha-favicon.svg > assets/branding/atha-favicon-64.png
rsvg-convert -h 512 -w 512 assets/branding/atha-avatar.svg > assets/branding/atha-avatar-512.png
rsvg-convert -h 630 -w 1200 assets/branding/atha-banner.svg > assets/branding/atha-banner-1200x630.png

```

## GitHub Social Preview

To ensure links to the ATHA repository look professional on platforms like Twitter/X, Discord, or Reddit:

1. Generate the `assets/branding/atha-banner-1200x630.png` file using the command above.
2. In the GitHub repository **Settings**, upload it as the **Social preview** image.

## License & Attribution

* **License:** Brand assets follow the same repository MIT license unless otherwise stated.
* **Attribution:** When reusing ATHA branding in third-party materials, blogs, or videos, please include a visible reference/link to: [https://github.com/Bangkah/Atha](https://github.com/Bangkah/Atha)

