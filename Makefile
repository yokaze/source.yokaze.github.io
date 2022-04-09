HUGO_VERSION := 0.92.2

.PHONY: blog
blog:
	docker run --rm -it -v $(shell pwd):/src klakegg/hugo:$(HUGO_VERSION)

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
