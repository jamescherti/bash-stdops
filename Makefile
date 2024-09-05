ifeq ($(PREFIX),)
	PREFIX=/usr/local
endif

all:
	@echo "System-side installation: make install"
	@echo "Local installation (home directory): PREFIX=~/.local make install"

install:
	install -d "$(PREFIX)/bin"
	install -m 755 bin/rgfiles "$(PREFIX)/bin/"

uninstall:
	rm "$(PREFIX)/bin/rgfiles"
