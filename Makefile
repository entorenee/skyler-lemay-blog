new-post-images:
	hugo new posts/$(name)/index.md
	mkdir content/posts/$(name)/images

new-post-text:
	hugo new posts/$(name).md

new-category:
	hugo new categories/$(name)/_index.md

new-tag:
	hugo new tags/$(name)/_index.md
