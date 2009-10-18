all: build

install: build
	cp -r "Lyrics and Artwork.app" ~/Library/iTunes/Scripts/

build:
	osacompile -o "Lyrics and Artwork.app" "Lyrics and Artwork.applescript"
	
edit: build
	open -a "Script Editor" "Lyrics and Artwork.app"