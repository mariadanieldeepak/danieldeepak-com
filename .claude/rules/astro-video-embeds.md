# Astro Video Embed Standards

This rule establishes best practices for embedding videos in Astro projects, prioritizing performance, privacy, and accessibility.

## 1. Never Use Raw iframes

❌ **Don't do this:**
```astro
<div class="aspect-video">
  <iframe
    width="100%"
    height="100%"
    src="https://www.youtube.com/embed/VIDEO_ID"
    allowfullscreen>
  </iframe>
</div>
```

**Why:** Raw iframes load immediately, wasting bandwidth and reducing performance. They don't respect privacy-first approaches.

## 2. Use the YouTube Component

✅ **Do this instead:**
```astro
---
import { YouTube } from '@astro-community/astro-embed-youtube';
---

<div class="aspect-video rounded-lg overflow-hidden">
  <YouTube id="VIDEO_ID" />
</div>
```

## 3. Benefits of Using the YouTube Component

- **Lazy Loading**: The iframe only loads when a user clicks play, not on initial page load
- **Privacy Mode**: Uses `youtube-nocookie.com` by default, which doesn't affect user watch history
- **Performance**: Minimal JavaScript footprint with a static placeholder image
- **Responsive**: Automatically responsive to container width

## 4. Installation

The project uses `@astro-community/astro-embed-youtube`:

```bash
npm install @astro-community/astro-embed-youtube
```

## 5. Usage in Components

### Basic Usage
```astro
---
import { YouTube } from '@astro-community/astro-embed-youtube';
---

<YouTube id="R9OCA6UFE-0" />
```

### With Container Styling
```astro
<div class="aspect-video rounded-lg overflow-hidden shadow-lg">
  <YouTube id="R9OCA6UFE-0" />
</div>
```

### With Custom Poster Image
```astro
<YouTube
  id="R9OCA6UFE-0"
  poster="https://example.com/custom-poster.jpg"
/>
```

## 6. Accessibility

The YouTube component maintains accessibility:
- Proper semantic structure
- Keyboard navigation support
- Screen reader friendly
- No auto-play by default

## 7. Checklist Before Committing

- ✅ Using `<YouTube>` component, not raw `<iframe>`
- ✅ Imported from `@astro-community/astro-embed-youtube`
- ✅ Video ID is valid (YouTube share URL: `youtube.com/watch?v=VIDEO_ID`)
- ✅ Container has appropriate styling (e.g., `aspect-video` class)
- ✅ Build completes without warnings

## References

- [Astro Embed YouTube](https://astro-embed.netlify.app/components/youtube/)
- [@astro-community/astro-embed-youtube npm](https://www.npmjs.com/package/@astro-community/astro-embed-youtube)
- [lite-youtube-embed](https://github.com/paulirish/lite-youtube-embed) (underlying library)
