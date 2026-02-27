# Astro Image Optimization Standards

This rule establishes the requirement to use Astro's `Image` and `Picture` components for all images in the project to ensure optimal performance, automatic compression, and responsive image delivery.

## 1. Always Use the Image Component

Use the `<Image />` component from `astro:assets` for all local images instead of standard HTML `<img>` tags.

### Why

- **Automatic Compression**: Reduces file sizes by converting to modern formats (WebP, AVIF)
- **Performance**: Prevents layout shifts and optimizes for different screen sizes
- **Type Safety**: TypeScript-integrated image imports with path validation
- **Build-Time Optimization**: Images are processed during build, not at runtime

### Basic Usage

```astro
---
import { Image } from 'astro:assets';
import heroImage from '../images/hero.png';
---

<Image
  src={heroImage}
  alt="Hero section image"
  width={1200}
  height={600}
/>
```

### Key Requirements

- **Always provide `alt` text** for accessibility
- **Always set explicit `width` and `height`** to prevent layout shift
- **Import the image** directly in the frontmatter; don't use string paths

## 2. Use Picture Component for Multiple Formats

Use the `<Picture />` component when you need to serve different formats to different browsers.

### When to Use

- Supporting both modern (WebP, AVIF) and legacy (JPEG, PNG) formats
- Different images for mobile vs. desktop
- Fallback support for older browsers

### Example

```astro
---
import { Picture } from 'astro:assets';
import heroImage from '../images/hero.png';
---

<Picture
  src={heroImage}
  alt="Hero section image"
  widths={[400, 800, 1200]}
  sizes="(max-width: 640px) 400px, (max-width: 1024px) 800px, 1200px"
  formats={['avif', 'webp', 'jpeg']}
/>
```

## 3. Avoid Direct Image Usage

❌ **Don't use:**
```astro
<!-- Standard HTML img tag - no optimization -->
<img src="/images/hero.png" alt="Hero" />

<!-- Remote URLs without proper setup -->
<img src="https://example.com/image.png" alt="External" />
```

✅ **Do use:**
```astro
---
import { Image } from 'astro:assets';
import heroImage from '../images/hero.png';
---

<Image src={heroImage} alt="Hero" width={1200} height={600} />
```

## 4. Remote Images

For remote images, configure an authorized image service:

### Using a Remote Image

```astro
---
import { Image } from 'astro:assets';
---

<Image
  src="https://cdn.example.com/image.png"
  alt="Description"
  width={1200}
  height={600}
/>
```

### Configuration

In `astro.config.mjs`, set up image service authorization:

```javascript
export default defineConfig({
  image: {
    service: {
      entrypoint: 'astro/assets/services/sharp',
    },
  },
});
```

## 5. File Organization

Store all images in `/public/images/` for local images:

```
/public/
  └── images/
      ├── hero.png
      ├── avatar.svg
      └── logo.svg
```

## 6. Responsive Images

Always use responsive sizing to optimize for different devices:

```astro
---
import { Image } from 'astro:assets';
import myImage from '../images/responsive-image.png';
---

<Image
  src={myImage}
  alt="Responsive content image"
  width={800}
  height={400}
  sizes="(max-width: 640px) 100vw, (max-width: 1024px) 50vw, 800px"
/>
```

## 7. Quality and Format Settings

Optimize compression and format selection:

```astro
<Image
  src={heroImage}
  alt="Hero"
  width={1200}
  height={600}
  quality="mid"
  format="webp"
/>
```

### Quality Options
- `low` - Smaller file size, lower visual quality
- `mid` - Balanced compression and quality (default)
- `high` - Better visual quality, larger file size

## 8. Static vs. Dynamic Images

### Static Images
Use direct imports for images known at build time:

```astro
---
import { Image } from 'astro:assets';
import staticImage from '../images/team.png';
---

<Image src={staticImage} alt="Team photo" width={800} height={600} />
```

### Dynamic Images
Use `getImage()` for programmatic optimization:

```astro
---
import { getImage } from 'astro:assets';
import myImage from '../images/my-image.png';

const optimizedImage = await getImage({ src: myImage, width: 800 });
---

<img src={optimizedImage.src} alt="Optimized" width={800} height={600} />
```

## 9. Accessibility

Always include meaningful `alt` text:

```astro
<!-- Good -->
<Image
  src={heroImage}
  alt="Daniel's headshot - founder of Deepak Analytics"
  width={300}
  height={300}
/>

<!-- Avoid decorative alt text if the image has meaning -->
<Image
  src={decorativeIcon}
  alt=""  <!-- Empty alt for truly decorative images -->
  width={24}
  height={24}
/>
```

## 10. Performance Checklist

Before deploying images:

- ✅ Using `<Image />` or `<Picture />` component
- ✅ Images imported directly (not hardcoded paths)
- ✅ `width` and `height` always specified
- ✅ `alt` text is descriptive and meaningful
- ✅ Images are in `/public/images/`
- ✅ Modern formats (WebP/AVIF) are leveraged
- ✅ Responsive sizes are set for mobile optimization
- ✅ Build completes without image-related warnings

## References

- [Astro Images Guide](https://docs.astro.build/en/guides/images/)
- [Astro Image Component API](https://docs.astro.build/en/reference/modules/astro-assets/)
- [Sharp Image Service](https://github.com/withastro/astro/tree/main/packages/astro/src/assets/services)
