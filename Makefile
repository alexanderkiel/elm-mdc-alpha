install-elm:
	npm install elm

build:
	elm make src/Material/*.elm

format:
	elm-format --yes src

.PHONY: install-elm, build, format
