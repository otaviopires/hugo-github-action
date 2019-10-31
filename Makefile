.POSIX:
DESTDIR=docs
HUGO_VERSION=0.59

.PHONY: all
all: get_repository clean get build deploy

.PHONY: get_repository
get_repository:
	@echo Getting Pages Repository
	git clone https://github.com/otaviopires/hugo-github-pages.git $(DESTDIR)

.PHONY: clean
clean:
	@echo Cleaning Old Build
	cd $(DESTDIR) && rm -rf *

.PHONY: get
get:
	@echo "Checking for Hugo"
	@if ! [ -x "$$(command -v hugo)" ]; then\
		echo "Getting Hugo";\
		wget -q -P tmp/ https://github.com/gohugoio/hugo/releases/download/v$(HUGO_VERSION)/hugo_extended_$(HUGO_VERSION)_Linux-64bit.tar.gz;\
		tar xf tmp/hugo_extended_$$(HUGO_VERSION)_Linux-64bit.tar.gz -C tmp/;\
		sudo mv -f tmp/hugo /usr/bin/;\
		rm -rf tmp/;\
		hugo version;\
	fi

.PHONY: build
build:
	@echo Generating Site
	hugo --gc --minify -d $(DESTDIR)

.PHONY: deploy
deploy:
	@echo Preparing Commit
	@cd $(DESTDIR) \
	&& git config user.email "p_otavio_s@hotmail.com" \ 
	&& git config user.name "Otavio Silva" \
	&& git add . \
	&& git status \
	&& git commit -m "GitHub Action Auto Build and Deploy"
	&& git push -f -q https://$(TOKEN)@github.com/otaviopires/hugo-github-pages.git master
	@echo Site is Deployed!

