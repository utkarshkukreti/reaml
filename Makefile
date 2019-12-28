default:

release:
	rm -f ppx/bin/*.exe
	cd ppx && make
	echo "now push the changes to GitHub and wait for the built ppx to be uploaded @ https://github.com/utkarshkukreti/reaml/actions"
	cd ppx && ./get
	npm publish --dry-run
	echo "ctrl+c to cancel; enter to publish"
	read
	npm publish
