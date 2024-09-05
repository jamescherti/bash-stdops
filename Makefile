ifeq ($(PREFIX),)
	PREFIX=/usr/local
endif

all:
	@echo "Run the following to install the bash scripts: make install"

install:
	@install -d $(PREFIX)/bin
	@install -m 755 ./example.sh $(PREFIX)/bin/
