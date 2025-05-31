# Prepare Post for Publication

This document outlines the systematic steps for preparing a blog post for publication.

## Publication Preparation Steps

### 1. Content Review
- Review the entire content of the post for clarity, accuracy, and completeness
- Ensure the post provides value and aligns with blog quality standards
- **Check for invalid or empty links**: Verify all URLs are functional and properly formatted
- **Check for TODO markers**: Flag any instances of "TODO" in the content - this typically indicates the post is not ready for publication

### 2. Category Assignment
- Suggest an appropriate category for the post
- Reference `.claude/category-taxonomy.json` for the complete taxonomy system
- See `.claude/blog-taxonomy-guide.md` for detailed category selection process

### 3. Tag Assignment
- Suggest relevant tags for the post
- Reference `.claude/tag-taxonomy.json` for available tags and usage patterns
- See `.claude/blog-taxonomy-guide.md` for tag selection guidelines and best practices
- Aim for 2-4 tags per post to maintain the current average

### 4. Description/Summary Management
- Check if there is a `description` key in the frontmatter
- **If description key exists but is empty**: Delete the key entirely
- **If no description key exists**: Ensure `summary` key is populated with a maximum 160-character summary
- Summary should be engaging, informative, and capture the post's value proposition

### 5. Draft Status Confirmation
- Check if `draft` is set to `true` in the frontmatter
- **CRITICAL**: Ask for explicit confirmation before changing `draft: true` to `draft: false`
- Must get user approval before making the post live
- This step prevents accidental publication of incomplete content

## Quality Checklist
- [ ] Content reviewed and polished
- [ ] No invalid or empty links
- [ ] No TODO markers present
- [ ] Category assigned from taxonomy
- [ ] Tags assigned from taxonomy (2-4 recommended)
- [ ] Description/summary properly configured
- [ ] Draft status confirmed with user approval

## Notes
- Always reference the established taxonomies for consistency
- Maintain the blog's quality standards and voice
- Ensure user has final say on publication timing
- Posts with TODO markers should generally not be published until completed