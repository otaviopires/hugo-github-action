.POSIX:
DESTDIR=docs
HUGO_VERSION=0.59

.PHONY: all
all: get_repository clean get build test deploy

.PHONY: get_repository
get_repository:
	@echo Getting Pages Repository
	git clone https://github.com/otaviopires/hugo-github-pages.git $(DESTDIR)
