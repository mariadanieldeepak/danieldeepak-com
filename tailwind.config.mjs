/** @type {import('tailwindcss').Config} */
export default {
  content: ['./src/**/*.{astro,html,js,ts,md,mdx}'],
  theme: {
    extend: {
      fontFamily: {
        sans: ['Manrope', 'Inter', 'sans-serif'],
      },
      colors: {
        accent: '#2563EB',
        primary: '#0A0A0A',
      },
    },
  },
  plugins: [require('@tailwindcss/typography')],
};
