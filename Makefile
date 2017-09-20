# help credit (https://gist.github.com/prwhite/8168133)
help: ## Show this help

	@fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//' | sed -e 's/##//'

target: help

	exit 0

clean: ## -> Deletes current gitbook

	$(info "[-] Who needs all that anyway? Destroying environment....")
	rm -rf _book/

build: ## Builds a new gitbook

	echo "[+] Building new Gitbook..."
	git checkout master \
		&& gitbook build

deploy: build ## Builds, then Packages and Deploys latest service via SAM

	echo "[+] Deploying new Gitbook to gh-pages!"
	git checkout gh-pages \
		&& cp -R _book/* . \
		&& git add .
		&& git commit -m "New build $(uuidgen)"
		&& git push

	git checkout master
