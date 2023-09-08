.PHONY: delete-remote-tags

BUILD_TIME := $(shell date '+%Y%m%d%H%M%S')
delete-remote-tags:
	git fetch --prune --tags
	git ls-remote --tags origin | awk -F/ '{print $$3}' | xargs -I {} git push origin --delete {}

all:

release_: delete-remote-tags
	echo "release"
	git tag -d $(git tag -l)
	git fetch
	@git push origin --delete $(version)
	echo "$(date)" >> release_time.txt
	git add .
	date +%Y%m%d%H%M%S
	#git tag -a -m "My first action release" "$(version)-rc$(BUILD_TIME)"
	git tag -a -m "My first action release" "$(version)"
	git push --follow-tags


release:
	echo "release"
	echo "$(BUILD_TIME)" >> release_time.txt
	git add .
	git commit -m "release version:$(version) at $(BUILD_TIME)"
	git tag -a -m "My first action release" "$(version)"
	git push --follow-tags
