# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Development Commands

### Content Creation
```bash
# Create new post with images folder (preferred for posts with images)
make new-post-images name="post-name"

# Create text-only post
make new-post-text name="post-name"

# Manual content creation
hugo new posts/post-name/index.md
```

### Development Server
```bash
# Start development server with drafts
hugo server -D

# Build for production
hugo
```

## Architecture Overview

This is a Hugo static site generator blog using the PaperMod theme with several customizations:

### Hugo Modules Structure
- **Theme**: `github.com/adityatelange/hugo-PaperMod` (main theme)
- **Analytics**: `github.com/hugomods/umami-analytics` (privacy-focused)
- **Gallery**: `github.com/mfg92/hugo-shortcode-gallery` (image galleries)

### Content Organization
- **Posts location**: `/content/posts/`
- **Post formats**: 
  - Bundle format: `post-name/index.md` + `images/` folder (recommended)
  - Single file: `post-name.md`
- **Taxonomies**: Categories, Tags, Series (custom taxonomy for grouping related posts)
- **Permalinks**: Posts use `/blog/:slug` pattern

### Theme Customizations
- **Custom CSS**: `/assets/css/extended/custom.css` contains site-specific styling
- **Layouts**: Custom layouts in `/layouts/` for series support and newsletter integration
- **Newsletter**: ConvertKit integration with dark/light theme awareness
- **Analytics**: Umami privacy analytics (production only)

### Key Configuration
- **Base URL**: skylerlemay.com
- **Default theme**: Dark mode
- **Markdown**: Unsafe HTML rendering enabled for flexibility
- **Edit links**: GitHub edit functionality enabled for community contributions

### Development Notes
- Posts support frontmatter series assignment for cross-linking
- Custom accent color: `#5928a4` (purple theme)
- Newsletter signup forms adapt to current theme (dark/light)
- Production builds include minification and analytics
- Static redirects handled via `/static/_redirects`

## Content Taxonomy

For detailed guidance on applying categories and tags to blog posts, reference @.claude/blog-taxonomy-guide.md.

### Quick Reference
- **Categories**: Reference @.claude/category-taxonomy.json (9 categories total)
- **Tags**: Reference @.claude/tag-taxonomy.json (46 unique tags)
