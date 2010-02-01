all: build

install: build
	cp -r "Lyrics and Artwork.scpt" ~/Library/iTunes/Scripts/

build:
	osacompile -o "Lyrics and Artwork.scpt" "Lyrics and Artwork.applescript"
	
edit: build
	open "Lyrics and Artwork.scpt"