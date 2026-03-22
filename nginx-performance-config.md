# Nginx Performance Configuration Reminder

## Compression Configuration

Enable gzip and brotli compression for text-based assets to reduce transfer size and improve page load times.

### Gzip Compression

```nginx
# Enable gzip compression
gzip on;
gzip_vary on;
gzip_proxied any;
gzip_comp_level 6;
gzip_types
    text/plain
    text/css
    text/xml
    text/javascript
    application/json
    application/javascript
    application/xml+rss
    application/rss+xml
    font/truetype
    font/opentype
    application/vnd.ms-fontobject
    image/svg+xml;
gzip_min_length 1000;
```

### Brotli Compression (if module available)

```nginx
# Enable brotli compression (requires ngx_brotli module)
brotli on;
brotli_comp_level 6;
brotli_types
    text/plain
    text/css
    text/xml
    text/javascript
    application/json
    application/javascript
    application/xml+rss
    application/rss+xml
    font/truetype
    font/opentype
    application/vnd.ms-fontobject
    image/svg+xml;
brotli_min_length 1000;
```

## Cache Headers Configuration

Configure appropriate cache headers for different asset types to improve repeat visit performance.

### Static Assets (Images, CSS, JS, Fonts)

```nginx
# Cache static assets for 1 year with immutable flag
location ~* \.(jpg|jpeg|png|gif|ico|svg|webp|avif|css|js|woff|woff2|ttf|eot)$ {
    expires 1y;
    add_header Cache-Control "public, max-age=31536000, immutable";
    access_log off;
}
```

### HTML Files

```nginx
# Cache HTML for 1 hour with must-revalidate
location ~* \.html$ {
    expires 1h;
    add_header Cache-Control "public, max-age=3600, must-revalidate";
}
```

### Astro Generated Assets

```nginx
# Cache Astro's generated assets (_astro directory)
location /_astro/ {
    expires 1y;
    add_header Cache-Control "public, max-age=31536000, immutable";
    access_log off;
}
```

## Complete Example Configuration Block

```nginx
server {
    # ... other server configuration ...

    # Compression
    gzip on;
    gzip_vary on;
    gzip_proxied any;
    gzip_comp_level 6;
    gzip_types text/plain text/css text/xml text/javascript application/json application/javascript application/xml+rss application/rss+xml font/truetype font/opentype application/vnd.ms-fontobject image/svg+xml;
    gzip_min_length 1000;

    # Cache headers for static assets
    location ~* \.(jpg|jpeg|png|gif|ico|svg|webp|avif|css|js|woff|woff2|ttf|eot)$ {
        expires 1y;
        add_header Cache-Control "public, max-age=31536000, immutable";
        access_log off;
    }

    # Cache headers for HTML
    location ~* \.html$ {
        expires 1h;
        add_header Cache-Control "public, max-age=3600, must-revalidate";
    }

    # Cache headers for Astro assets
    location /_astro/ {
        expires 1y;
        add_header Cache-Control "public, max-age=31536000, immutable";
        access_log off;
    }

    # ... rest of server configuration ...
}
```

## Performance Impact

- **Compression**: Can reduce text-based asset sizes by 60-80%, saving ~32.8 kB per page load
- **Cache Headers**: Improves repeat visit performance, saving ~19.5 kB on subsequent loads
- **Combined**: Significantly improves Largest Contentful Paint (LCP) and overall page load metrics

## Notes

- Test compression levels (4-9) to balance CPU usage vs compression ratio
- Ensure brotli module is compiled/installed before using brotli directives
- Adjust cache durations based on deployment frequency
- Use `immutable` flag only for assets with content-based hashing (Astro does this automatically)
