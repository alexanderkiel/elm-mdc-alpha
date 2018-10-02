install-elm:
	npm install elm

build:
	elm make src/Material/*.elm

.PHONY: install-elm, build
