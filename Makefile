
.PHONY: dev install changelog test dockertest

default: test

dev:
	nix-shell

install:
	nix-env -f . -i

changelog:
	gitchangelog >CHANGELOG.rst

test:
	nix-shell --command 'py.test tests/test.py'

dockertest:
	docker run -v $(PWD):/data --rm nixos/nix:latest bash /data/tests/docker.sh
# this runs the same test as above in a docker container


