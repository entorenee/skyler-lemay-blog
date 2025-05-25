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

### Tags
Reference @.claude/tag-taxonomy.json for complete tag taxonomy when applying tags to posts. Contains 46 unique tags with usage counts and categorization by topic (technical, personal, workplace, learning, accessibility, projects). Use this to maintain consistency and discover related tags.

#### Tag Capitalization Rules
- Use kebab-case format for multi-word tags
- Technology names and acronyms should use proper capitalization:
  - `JavaScript` (not `javascript`)
  - `TypeScript` (not `typescript`) 
  - `GraphQL` (not `graphql`)
  - `CSS` (not `css`)
  - `AI` (not `ai`)
- Compound technical tags maintain proper capitalization: `TypeScript-generics`
- General concept tags remain lowercase: `tooling`, `accessibility`, `learning`

### Categories
Reference @.claude/category-taxonomy.json for the category structure when categorizing posts. The taxonomy has been updated to a 9-category system for better content discoverability:

#### Recommended Category Structure
- **Technical**: Pure technical tutorials, how-tos, tool guides
- **Learning & Challenges**: Structured learning experiences, coding challenges
- **Personal Growth**: Self-reflection, personal development, life lessons, habit building
- **Projects**: Project showcases, builds, creation stories  
- **Career Development**: Professional growth, workplace skills, leadership
- **Identity & Intersectionality**: Nuanced identity work, social systems analysis, intersectional perspectives
- **Sports & Recreation**: Physical activities, cycling, endurance sports
- **Creative Writing**: Poetry, artistic expression
- **Resources**: Curated collections, link roundups

Categories use title case format and are stored as arrays in frontmatter. Each post should have exactly one category for optimal information architecture.

#### Category Implementation with Special Characters
Categories containing special characters (like "&") use kebab-case directory names with a display title set in the category's `_index.md`:

**Directory Structure:**
```
content/categories/
├── identity-and-intersectionality/
│   └── _index.md
├── learning-and-challenges/
│   └── _index.md
└── sports-and-recreation/
    └── _index.md
```

**Category Index File Format:**
```yaml
---
title: 'Identity & Intersectionality'
description: 'Nuanced identity work, social systems analysis, and intersectional perspectives on society.'
---
```

**In Post Frontmatter:**
```yaml
categories: ['identity-and-intersectionality']
```

This approach ensures URL-safe directory names while maintaining proper display formatting with special characters.
