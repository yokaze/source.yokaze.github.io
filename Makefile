.PHONY: blog
blog:
	docker run --rm -it -v $(shell pwd):/src klakegg/hugo:0.83.1

.PHONY: preview
preview:
	docker run --rm -it -v $(shell pwd):/src -p 1313:1313 klakegg/hugo:0.83.1 server --bind="0.0.0.0" --baseURL="http://$(shell hostname)/"

.PHONY: draft
draft:
	docker run --rm -it -v $(shell pwd):/src -p 1313:1313 klakegg/hugo:0.83.1 server --bind="0.0.0.0" --baseURL="http://$(shell hostname)/" --buildDrafts --buildFuture
