# Prepare Post for Publication

This document outlines the systematic steps for preparing a blog post for publication.

## Publication Preparation Steps

### 1. Content Review
- Review the entire content of the post for clarity, accuracy, and completeness
- Ensure the post provides value and aligns with blog quality standards
- **Check for invalid or empty links**: Verify all URLs are functional and properly formatted
- **Validate internal page links**: Apply internal link validation checks (see Internal Link Validation section below)
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
- **CRITICAL**: If draft is true, ask the user explicitly: "Would you like me to change draft from true to false to publish this post?"
- **NEVER** change draft status without explicit user permission
- Wait for clear confirmation before making any changes to draft status
- This step prevents accidental publication of incomplete content

## Internal Link Validation

When checking internal Markdown page links (not image links), apply these validation rules:

### Link Format Requirements
- **Start with forward slash**: Internal page links must begin with `/` (e.g., `/blog/post-name/`)
- **End with forward slash**: Links must conclude with `/` for pretty URLs and consistent search engine results
- **Exclude image links**: These validation rules apply only to page links, not image references

### Link Validation Process
1. **Check dev server**: Confirm the development server is running at `http://localhost:1313`
2. **Test each link**: Validate that each internal link renders successfully by accessing `http://localhost:1313/link`
3. **Verify response**: Ensure the page loads with proper HTML structure (contains `<title>` and `<h1>` tags)
4. **Check for 404s**: Look for pages with `class="not-found"` which indicate broken links

### Common Link Issues
- **Missing trailing slash**: `/blog/post-name` should be `/blog/post-name/`
- **Incorrect slugs**: Verify the URL matches the actual post slug in frontmatter
- **Typos in URLs**: Check for spelling errors in link paths

## Quality Checklist
- [ ] Content reviewed and polished
- [ ] No invalid or empty links
- [ ] Internal page links validated against localhost:1313
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