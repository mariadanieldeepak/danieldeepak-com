# Image Organization Standards

This rule establishes the folder structure for organizing images in the project to maintain a clean, maintainable asset library.

## 1. Image Folder Structure

All images that will be optimized by Astro must be organized by **year and month** in the following structure:

```
/src/assets/images/
  └── YYYY/
      └── MM/
          ├── image-1.jpg
          ├── image-2.png
          └── image-3.svg
```

### Examples

- **2026 February images**: `/src/assets/images/2026/02/`
- **2026 March images**: `/src/assets/images/2026/03/`
- **2027 January images**: `/src/assets/images/2027/01/`

### Important: src/assets/ vs /public/

- **Use `/src/assets/images/YYYY/MM/`** for images that will be optimized (JPG, PNG) and used with `<Image />` component
- **Use `/public/images/`** only for static assets that don't need optimization (favicons, SVGs, logos)

## 2. When Adding New Images

When adding an image to the project:

1. Create the year folder if it doesn't exist: `mkdir -p src/assets/images/YYYY/MM/`
2. Copy the image to the appropriate month folder
3. Import the image directly in your Astro component frontmatter
4. Use the `<Image />` component from `astro:assets` for rendering

### Example Workflow

```bash
# Image dated February 2026
mkdir -p src/assets/images/2026/02/
cp ~/Downloads/my-image.jpg src/assets/images/2026/02/my-image.jpg
```

```astro
---
import { Image } from 'astro:assets';
import myImage from '../assets/images/2026/02/my-image.jpg';
---

<Image src={myImage} alt="Description" width={600} height={400} />
```

## 3. File Naming Conventions

- Use **lowercase** with **hyphens** for multi-word names
- Include descriptive names: `office-workspace.jpg`, `team-photo.png`
- Avoid generic names: ❌ `image1.jpg`, ❌ `photo.png`
- Include context if helpful: `hero-section-banner.jpg`, `about-page-hero.jpg`

### Good Examples
- `my-office.jpg`
- `hero-banner.png`
- `team-photo-2026.jpg`
- `feature-illustration.svg`

### Bad Examples
- `IMG_1234.jpg`
- `image.png`
- `photo1.jpg`
- `temp.jpg`

## 4. Directory Creation

If a year/month directory doesn't exist, create it before adding the image:

```bash
mkdir -p src/assets/images/2026/02/
cp ~/Downloads/image.jpg src/assets/images/2026/02/image.jpg
```

## 5. Keeping Placeholder Assets

Assets like favicons and shared SVGs that aren't date-specific can be stored directly in `/public/`:

```
/public/
  ├── favicon.svg
  ├── robots.txt
  └── images/
      ├── placeholder-avatar.svg
      └── logo.svg
```

Date-classified images go in `src/assets/`:

```
/src/assets/images/
  └── 2026/          ← Date-classified content
      └── 02/
          ├── my-office.jpg
          └── maria-daniel-deepak.jpg
```

## 6. Importing Images

Always import from `src/assets/images/` with the full year/month path:

```astro
---
// ✅ Correct - full path including year/month
import myImage from '../assets/images/2026/02/my-office.jpg';

// ❌ Incorrect - missing date folders
import myImage from '../assets/images/my-office.jpg';

// ❌ Don't use public/ for optimized images
import myImage from '../public/images/2026/02/my-office.jpg';
```

## Checklist Before Adding Images

- ✅ Image is placed in `/src/assets/images/YYYY/MM/` folder
- ✅ Year and month folders exist and are created as needed
- ✅ Image filename is lowercase with hyphens
- ✅ Import path is `../assets/images/YYYY/MM/filename`
- ✅ Using `<Image />` component from `astro:assets`
- ✅ `width` and `height` are explicitly set
- ✅ `alt` text is descriptive and meaningful
- ✅ Build completes without image-related warnings
