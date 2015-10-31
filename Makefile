# vim: set ts=8 tw=0 noet :
#
# Makefile for building the Gem
#

all: build
	git status

rel: build
	vim lib/pigeon_band/version.rb
	git commit -a
	gem uninstall pigeon_band --all
	rake release


install: build
	git commit -a
	gem uninstall pigeon_band --all
	rake install
	rm -rf pkg

build:
	git add lib

