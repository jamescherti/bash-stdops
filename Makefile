ifeq ($(PREFIX),)
	PREFIX=/usr/local
endif

all:
	@echo "System-side installation:"
	@echo "    sudo make install"
	@echo ""
	@echo "Alternative: Install in your home directory:"
	@echo "    PREFIX=~/.local make install"
	@echo ""

install:
	install -d "$(PREFIX)/bin"
	install -m 755 bin/qparallel "$(PREFIX)/bin/"
	install -m 755 bin/rgfiles "$(PREFIX)/bin/"
	install -m 755 bin/rgfiles-run "$(PREFIX)/bin/"
	install -m 755 bin/sre "$(PREFIX)/bin/"
	install -m 755 bin/file-uppercase "$(PREFIX)/bin/"
	install -m 755 bin/file-tr "$(PREFIX)/bin/"
	install -m 755 bin/file-lowercase "$(PREFIX)/bin/"

uninstall:
	rm "$(PREFIX)/bin/sre"
	rm "$(PREFIX)/bin/qparallel"
	rm "$(PREFIX)/bin/rgfiles"
	rm "$(PREFIX)/bin/rgfiles-run"
	rm "$(PREFIX)/bin/file-uppercase"
	rm "$(PREFIX)/bin/file-lowercase"
	rm "$(PREFIX)/bin/file-tr"
