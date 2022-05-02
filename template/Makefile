.PHONY: template
template:
	go run main.go
	@for i in $$(cd ..; git diff --numstat | grep -e '1\s1' | awk '{print $$3}'); do \
		pushd ..; \
		git co $$i 2>&1; \
		popd; \
	done > /dev/null

.PHONY: format
format:
	@for i in $(shell find . -name '*.yaml'); do \
		echo $$i; \
		yq e . $$i -P | sponge $$i; \
	done
