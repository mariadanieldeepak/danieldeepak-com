# Daniel Deepak's Personal Blog

A modern, minimalist personal blog built with [Astro](https://astro.build/), [Tailwind CSS](https://tailwindcss.com/), and file-based content collections.

## Features

✨ **Complete Blog System**
- Responsive design (mobile-first)
- Dark mode ready (color scheme can be customized)
- Fast static site generation
- File-based content (no database needed)

📝 **Rich Content**
- Blog posts with Markdown support
- Featured images, categories, and tags
- Reading time estimation
- Category and tag filtering with dynamic routes
- Individual post pages with full post layout

🎯 **Pages Included**
- **Home** – Hero section with recent posts grid
- **About** – Full bio and values
- **Blog** – Filterable post listing
- **FAQ** – Accordion-style FAQ section
- **Now** – "What I'm doing now" page (inspired by nownownow.com)
- **Tools** – Curated list of tools by category

🎨 **Design**
- Clean, authoritative founder-style aesthetic
- Manrope font from Google Fonts
- Electric blue accent color (#2563EB)
- Generous whitespace and typography hierarchy
- Max content width: 1100px, centered
- Grid layout: 3 columns on desktop, responsive on smaller screens

## Getting Started

### Prerequisites
- Node.js (v16+)
- npm or yarn

### Installation

1. **Install dependencies:**
   ```bash
   npm install
   ```

2. **Start the development server:**
   ```bash
   npm run dev
   ```

3. **Open in browser:**
   Visit `http://localhost:4321/` to see your site

### Building for Production

```bash
npm run build
npm run preview  # Preview the built site locally
```

## File Structure

```
.
├── public/
│   ├── favicon.svg
│   └── images/
│       └── placeholder-avatar.svg
├── src/
│   ├── content/
│   │   ├── config.ts              # Content collection schema
│   │   └── blog/
│   │       ├── first-principles-thinking.md
│   │       ├── tools-that-changed-my-workflow.md
│   │       └── building-in-public.md
│   ├── layouts/
│   │   ├── BaseLayout.astro       # Main layout wrapper
│   │   └── BlogPostLayout.astro   # Post-specific layout
│   ├── components/
│   │   ├── Navbar.astro
│   │   ├── Footer.astro
│   │   ├── Hero.astro
│   │   ├── BlogCard.astro
│   │   ├── CategoryBadge.astro
│   │   └── TagPill.astro
│   └── pages/
│       ├── index.astro            # Home
│       ├── about.astro
│       ├── blog/
│       │   ├── index.astro        # Blog listing
│       │   └── [...slug].astro    # Individual posts
│       ├── category/[category].astro
│       ├── tags/[tag].astro
│       ├── faq.astro
│       ├── now.astro
│       └── tools.astro
├── astro.config.mjs
├── tailwind.config.mjs
├── tsconfig.json
└── package.json
```

## Customization

### Update Your Photo

1. Replace `/public/images/placeholder-avatar.svg` with your own image
2. Save it as a `.jpg`, `.png`, or keep the `.svg` extension
3. To change the filename, update these files:
   - [src/components/Hero.astro](src/components/Hero.astro) – line where `src="/images/..."` is defined
   - [src/pages/about.astro](src/pages/about.astro) – same location

### Update Your Bio & Site Name

1. **Hero headline and bio** – Edit [src/components/Hero.astro](src/components/Hero.astro)
2. **About page content** – Edit [src/pages/about.astro](src/pages/about.astro)
3. **Site name (navbar/footer)** – Edit [src/components/Navbar.astro](src/components/Navbar.astro) and [src/components/Footer.astro](src/components/Footer.astro)

### Update Social Links

Edit [src/components/Footer.astro](src/components/Footer.astro) and replace the placeholder URLs:
- Twitter/X: `https://twitter.com/yourusername`
- LinkedIn: `https://linkedin.com/in/yourprofile`
- GitHub: `https://github.com/yourusername`

### Change the Accent Color

Edit [tailwind.config.mjs](tailwind.config.mjs):

```javascript
colors: {
  accent: '#F59E0B', // Change from #2563EB to your preferred color
}
```

Common color options:
- Electric Blue: `#2563EB` (current)
- Warm Amber: `#F59E0B`
- Rose: `#EC4899`
- Green: `#10B981`
- Purple: `#8B5CF6`

### Update Tools List

Edit [src/pages/tools.astro](src/pages/tools.astro) and modify the `toolCategories` array with your tools.

### Update Now Page

Edit [src/pages/now.astro](src/pages/now.astro) and update the sections:
- What I'm Working On
- Currently Reading
- Thinking About
- Location

### Update FAQ

Edit [src/pages/faq.astro](src/pages/faq.astro) and modify the FAQ items within the `<details>` elements.

## Adding Blog Posts

### Creating a New Post

Create a new `.md` file in `/src/content/blog/`:

```md
---
title: "Your Post Title"
date: 2024-02-27
excerpt: "A short excerpt that shows on the blog listing"
category: "Thinking"
tags: ["tag1", "tag2", "tag3"]
featuredImage: "optional-image-url"
---

Your post content here in Markdown.

# Heading 2
Regular paragraph text...
```

### Post Frontmatter Fields

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `title` | string | Yes | Post title |
| `date` | date | Yes | Publication date (YYYY-MM-DD) |
| `excerpt` | string | Yes | Short summary for listings |
| `category` | string | Yes | Single category (e.g., "Business") |
| `tags` | array | Yes | List of tag strings |
| `featuredImage` | string | No | URL to featured image |

### Markdown Support

Posts support standard Markdown + Astro's enhanced features:

```markdown
# Heading 1
## Heading 2
### Heading 3

**Bold text** and *italic text*

- Bullet list
- Another item

1. Numbered list
2. Another item

[Link text](https://example.com)

> Blockquote text

`inline code`

```js
// Code block with syntax highlighting
const greeting = "Hello World";
```
```

## Design Customization

### Colors

Modify the color scheme in [tailwind.config.mjs](tailwind.config.mjs):

```javascript
colors: {
  primary: '#0A0A0A',      // Text and headings
  accent: '#2563EB',       // Links, buttons, highlights
}
```

### Typography

The blog uses [Manrope](https://fonts.google.com/specimen/Manrope) from Google Fonts with fallbacks to Inter and sans-serif.

To change fonts, edit [src/layouts/BaseLayout.astro](src/layouts/BaseLayout.astro) – update the `<link>` tag in the `<head>` and the `fontFamily` in [tailwind.config.mjs](tailwind.config.mjs).

### Spacing & Layout

Max content width is set to `1100px`. Adjust in:
- [src/layouts/BaseLayout.astro](src/layouts/BaseLayout.astro) – `max-w-[1100px]` class
- Individual pages as needed

## Testing

The site ships with 3 sample blog posts to test all features:

1. **First Principles Thinking** (Category: Thinking)
   - Tags: mental-models, decision-making, strategy

2. **Tools That Changed My Workflow** (Category: Tools)
   - Tags: productivity, software, workflow

3. **Building in Public** (Category: Business)
   - Tags: startups, transparency, growth

After running `npm run dev`, visit:
- Home: `http://localhost:4321/`
- Blog: `http://localhost:4321/blog`
- Category filtering: `http://localhost:4321/category/thinking`
- Tag filtering: `http://localhost:4321/tags/productivity`

## Performance

- **Static generation**: All pages are pre-built as static HTML
- **Fast load times**: No databases, minimal JavaScript
- **Optimized images**: Images are automatically optimized
- **Zero CMS overhead**: All content is in Markdown files

## Deployment

The site can be deployed anywhere that serves static files:

### Vercel (recommended)

```bash
npm install -g vercel
vercel
```

### Netlify

```bash
npm install -g netlify-cli
netlify deploy --prod --dir=./dist
```

### GitHub Pages

See [Astro GitHub Pages guide](https://docs.astro.build/guides/deploy/github/)

### Other Static Hosts

- AWS S3 + CloudFront
- Cloudflare Pages
- Firebase Hosting
- Any web server (just serve files from `/dist/`)

## Troubleshooting

### Build fails with TypeScript errors

Make sure `tsconfig.json` extends `"astro/tsconfigs/strict"` (not `astro/configs/strict`).

### Images not showing

Check that image paths are correct:
- Local images in `/public/images/` should be referenced as `/images/filename.ext`
- External images should use full URLs

### Categories/Tags not showing

Make sure your blog posts have:
- A `category` field (string, single value)
- A `tags` field (array of strings)

## License

This template is free to use and modify. No license restrictions.

## Support

For issues with Astro:
- [Astro Documentation](https://docs.astro.build/)
- [Astro Discord Community](https://astro.build/chat)

For questions about this template, check the customization section above.

---

**Built with ❤️ using Astro and Tailwind CSS**
