new-post-images:
	hugo new posts/$(name)/index.md
	mkdir content/posts/$(name)/images

new-post-text:
	hugo new posts/$(name).md
