.PHONY: delete-remote-tags

BUILD_TIME := $(shell date '+%Y%m%d%H%M%S')

release:
	echo "release"
	echo "$(BUILD_TIME)" >> release_time.txt
	git add .
	git commit -m "release version:$(version) at $(BUILD_TIME)"
	git tag -a -m "My first action release" "$(version)"
	git push --follow-tags
