
all:

release:
	git add .
	git commit -m "auto release -pipeline construction" --no-verify
	git push
	git tag -a -m "My first action release $(version)" $(version)
	git push --follow-tags
