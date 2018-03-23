.PHONY: check-ready check-live

host ?= localhost
max_try ?= 1
wait_seconds ?= 1
delay_seconds ?= 1

default: check-ready

check-ready:
	wait_for_jenkins $(host) $(max_try) $(wait_seconds) $(delay_seconds)

check-live:
	@echo "OK"
