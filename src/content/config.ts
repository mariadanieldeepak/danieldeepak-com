import { z, defineCollection } from 'astro:content';

const blogCollection = defineCollection({
  type: 'content',
  schema: z.object({
    title: z.string(),
    date: z.date(),
    excerpt: z.string(),
    featuredImage: z.string().optional(),
    category: z.string(),
    tags: z.array(z.string()),
  }),
});

export const collections = { blog: blogCollection };
