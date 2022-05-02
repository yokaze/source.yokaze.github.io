HUGO_VERSION := 0.95.0

.PHONY: blog
blog:
	cd template; make template
	docker run --rm -it -v $(shell pwd):/src klakegg/hugo:$(HUGO_VERSION)
	for i in $$(find yokaze.github.io -name '*.html'); do \
		js-beautify --replace --no-preserve-newlines --end-with-newline $$i; \
	done

.PHONY: preview
preview:
	docker run --rm -it -v $(shell pwd):/src -p 1313:1313 klakegg/hugo:$(HUGO_VERSION) server --bind="0.0.0.0" --baseURL="http://$(shell hostname)/"

.PHONY: draft
draft:
	docker run --rm -it -v $(shell pwd):/src -p 1313:1313 klakegg/hugo:$(HUGO_VERSION) server --bind="0.0.0.0" --baseURL="http://$(shell hostname)/" --buildDrafts --buildFuture

.PHONY: date
date:
	@for i in $(shell find content -name '*.md'); do \
		if grep -q lastmod: $$i; then \
			printf $$(grep lastmod: $$i | awk '{ print $$2 }'); \
		else \
			printf $$(grep date: $$i | awk '{ print substr($$2, 0, 10) }'); \
		fi; \
		printf '  '; \
		printf $$(echo $$i | awk '{ print substr($$0, 9) }'); \
		printf '  '; \
		grep title: $$i | awk '{ print substr($$0, 8) }' | jq -r; \
	done | sort | bat -

.PHONY: update-nochange
update-nochange:
	@cd yokaze.github.io; git config --local core.quotepath false
	@for i in $$(cd yokaze.github.io; git diff --numstat | grep -e '1\s1' | awk '{print $$3}'); do \
		echo $$i; \
		pushd yokaze.github.io > /dev/null; \
		git add $$i; \
		popd > /dev/null; \
	done
