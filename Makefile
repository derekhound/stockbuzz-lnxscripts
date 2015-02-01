PACKAGE=stockbuzz-lnxscripts

.PHONY: all clean install install-dev

all:
	# dist
	[ -d dist ] || mkdir -p dist
	cp -r hybrid-site/* dist
	# rm .bak files
	find dist -name *.bak | xargs --no-run-if-empty rm

clean:
	rm -rf dist
	rm -rf _install
	rm -rf _tarball

install:
	# config
	php ./tool/apply_config.php --type rel
	# dist
	[ -d _install ] || mkdir -p _install
	cp -r dist/* _install
	# tar
	[ -d _tarball ] || mkdir -p _tarball
	tar -czvf _tarball/${PACKAGE}.tar.gz -C _install .

install-dev:
	# config
	php ./tool/apply_config.php --type dev
	# dist
	[ -d _install/var/www ] || mkdir -p _install/var/www/stockbuzz
	cp -r dist/* _install
	# tar
	[ -d _tarball ] || mkdir -p _tarball
	tar -czvf _tarball/${PACKAGE}.tar.gz -C _install .
