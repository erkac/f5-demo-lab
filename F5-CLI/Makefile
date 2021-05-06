LICENSE = 

all: ssh chrome tuning do as3

ssh:
	@./01_ssh-key.sh

chrome:
	@./02_fix_chrome.sh

tuning:
	@./03_system_tuning.sh

do:
ifdef LICENSE
	@./04_do.sh $(LICENSE)
else
	@./04_do.sh
endif

as3:
	@./05_as3.sh

ts:
	@./06_ts.sh