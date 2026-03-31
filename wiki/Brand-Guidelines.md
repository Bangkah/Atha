# Brand Guidelines

This page defines how ATHA visual assets should be used consistently across GitHub, AUR, screenshots, and social posts.

## Core Identity

- Name: ATHA
- Tagline: Lightweight package manager wrapper for Arch Linux
- Voice: technical, concise, practical

## Logo Files

- Full logo: assets/branding/atha-logo.svg
- Full logo (dark): assets/branding/atha-logo-dark.svg
- Full logo (light): assets/branding/atha-logo-light.svg
- Mark/icon: assets/branding/atha-mark.svg
- Avatar: assets/branding/atha-avatar.svg
- Favicon: assets/branding/atha-favicon.svg
- Social banner: assets/branding/atha-banner.svg

## Recommended Usage

- Use full logo for README headers, docs, and presentations.
- Use mark/avatar for repository profile image and compact placements.
- Use banner for social preview images and announcements.
- Prefer SVG as source-of-truth to avoid quality loss.

## Color and Contrast

- Use the light logo on dark backgrounds.
- Use the dark logo on light backgrounds.
- Preserve contrast for accessibility and screenshot readability.

## Minimum Clear Space

Keep clear space around the logo at least equal to the height of the letter A in ATHA.

## Minimum Size

- Full logo: at least 180px wide in digital contexts.
- Mark/avatar: at least 32px by 32px.

## Do and Do Not

Do:

- Keep aspect ratio unchanged.
- Use original colors and contrast-safe backgrounds.
- Pick dark or light variant based on background tone.

Do not:

- Stretch or squash the logo.
- Add heavy effects, outlines, or glow.
- Rotate or recolor the logo arbitrarily.

## PNG Export (Arch Linux)

Install converter:

```bash
sudo pacman -S librsvg
```

Generate common outputs:

```bash
rsvg-convert -h 32 -w 32 assets/branding/atha-favicon.svg > assets/branding/atha-favicon-32.png
rsvg-convert -h 64 -w 64 assets/branding/atha-favicon.svg > assets/branding/atha-favicon-64.png
rsvg-convert -h 512 -w 512 assets/branding/atha-avatar.svg > assets/branding/atha-avatar-512.png
rsvg-convert -h 630 -w 1200 assets/branding/atha-banner.svg > assets/branding/atha-banner-1200x630.png
```

## GitHub Social Preview

- Generate assets/branding/atha-banner-1200x630.png.
- In repository settings, upload it as the social preview image.

## License

Brand assets follow the same repository license unless otherwise stated.

## Attribution

When reusing ATHA branding in third-party materials, include a visible reference to:
- https://github.com/Bangkah/Atha
