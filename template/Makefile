.PHONY: template
template:
	go run main.go

.PHONY: format
format:
	@for i in $(shell find . -name '*.yaml'); do \
		echo $$i; \
		yq e . $$i -P | sponge $$i; \
	done
