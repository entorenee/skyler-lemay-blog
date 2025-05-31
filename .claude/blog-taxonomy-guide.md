# Blog Post Taxonomy Application Guide

This guide provides a systematic approach for applying categories and tags to blog posts to maintain consistency and discoverability.

## Selecting a Category

1. **Reference the taxonomy**: Use `.claude/category-taxonomy.json` for the complete category taxonomy
2. **Select best fit**: Choose the category that best applies to the post's primary focus
3. **Suggest new categories**: If none of the existing terms apply well, suggest a new category to create
4. **Reclassify existing posts**: If a new category is created, examine existing posts to determine if any should be reclassified

### Category Selection Process:
Reference `.claude/category-taxonomy.json` for complete category definitions, descriptions, and examples.

### Category Implementation Notes:
- Categories with special characters use kebab-case directory names
- Post frontmatter uses kebab-case: `categories: ['identity-and-intersectionality']`
- Display titles are set in the category's `_index.md` file
- Each post should have exactly one category

## Selecting Tags

1. **Reference the taxonomy**: Use `.claude/tag-taxonomy.json` for the complete tag taxonomy (46 unique tags)
2. **Select applicable tags**: Choose tags that best apply to the post content
3. **Suggest new tags**: If additional tags would be beneficial, suggest new tags to create
4. **Review impact**: Examine existing posts to determine if they would benefit from new tags
5. **Confirm single-use tags**: If only one post will have a new tag, ask for explicit confirmation before proceeding

### Tag Guidelines:
- **CRITICAL**: Never duplicate the post's category as a tag (e.g., if category is "Personal Growth", don't use "personal-growth" tag)
- Use kebab-case format for multi-word tags
- Technology names use proper capitalization: `JavaScript`, `TypeScript`, `GraphQL`, `CSS`, `AI`
- Compound technical tags maintain proper capitalization: `TypeScript-generics`
- General concept tags remain lowercase: `tooling`, `accessibility`, `learning`
- Average 2.35 tags per post (aim for 2-4 tags per post)

### Tag Usage Reference:
Reference `.claude/tag-taxonomy.json` for complete tag frequency data and usage patterns.

### Common Tag Combinations by Category:
- **Technical posts**: Often include `tooling`, `testing`, `linting`, specific technologies (`react`, `TypeScript`, `JavaScript`)
- **Personal Growth posts**: Often include `reflections`, may include `learning`, `neurodiversity`, `transgender`, `gender`
- **Projects posts**: Often include technology tags (`react`, `JavaScript`, `gatsby`), `learning`
- **Career Development posts**: Often include `team-health`, `psychological-safety`, `leadership`, `retrospectives`
- **Identity & Intersectionality posts**: Often include `transgender`, `gender`, may include `reflections`, `neurodiversity`

## After Completion

1. **Update JSON files**: Always update the taxonomy JSON files to maintain accurate statistics and metadata:
   - Update `category-taxonomy.json` with new post counts, percentages, and examples
   - Update `tag-taxonomy.json` with new tag usage counts and frequency data
   - Update metadata sections (totalPosts, lastUpdated, etc.)
2. **Add new terms**: If new categories or tags were created, add them to the respective JSON files with proper definitions
3. **Verify consistency**: Ensure all related posts use consistent terminology

## Implementation Format

### Post Frontmatter Example:
```yaml
---
title: "Post Title"
categories: ['technical']
tags: ['react', 'TypeScript', 'testing']
---
```

### Category Directory Structure:
```
content/categories/
├── identity-and-intersectionality/
│   └── _index.md  # Contains: title: 'Identity & Intersectionality'
├── learning-and-challenges/
│   └── _index.md  # Contains: title: 'Learning & Challenges'
└── sports-and-recreation/
    └── _index.md  # Contains: title: 'Sports & Recreation'
```

This systematic approach ensures consistent taxonomy application while maintaining flexibility for content evolution.
