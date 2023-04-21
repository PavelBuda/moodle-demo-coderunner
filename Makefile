include .env
export $(shell sed 's/=.*//' .env)

SHELL := /bin/bash
DOCKER_COMPOSE := ./moodle-docker/bin/moodle-docker-compose

#COLOURED ECHO
green  = $(shell echo -e '\x1b[32;01m$1\x1b[0m')
yellow = $(shell echo -e '\x1b[33;01m$1\x1b[0m')
red    = $(shell echo -e '\x1b[33;31m$1\x1b[0m')

#HELP COLORS
RED    := $(shell tput -Txterm setaf 1)
GREEN  := $(shell tput -Txterm setaf 2)
YELLOW := $(shell tput -Txterm setaf 3)
LIGHT_BLUE := $(shell tput -Txterm setaf 6)
WHITE  := $(shell tput -Txterm setaf 7)
RESET  := $(shell tput -Txterm sgr0)

# Add the following 'help' target to your Makefile
# And add help text after each target name starting with '\#\#'
# A category can be added with @category
HELP_FUN = \
    %help; \
    while(<>) { push @{$$help{$$2 // 'options'}}, [$$1, $$3] if /^([a-zA-Z\-\.]+)\s*:.*\#\#(?:@([a-zA-Z\-]+))?\s(.*)$$/ }; \
    print "usage: make [target]\n\n"; \
    for (sort keys %help) { \
    print "${RED}$$_:${RESET}\n"; \
    for (@{$$help{$$_}}) { \
    $$sep = " " x (32 - length $$_->[0]); ($$command = $$_->[0]) =~ s/\\//g; $$description = $$_->[1]; \
    print "  ${YELLOW}make${RESET} ${GREEN}$$command${RESET}$$sep${WHITE}$$description${RESET}\n"; \
    }; \
    print "\n"; }
#HELP COLORS END

all: $(MAKEFILE_LIST)
.PHONY: all

.DEFAULT_GOAL:=help

#To create new command you should use pattern as described below:
# COMMAND_NAME: ##@CATEGORY_NAME DESCRIPTION_TEXT
#Applied DOT (.) for logical separation.

help: ##@Help Show this help
	@perl -e '$(HELP_FUN)' $(MAKEFILE_LIST)

docker.deploy.local: ##@Docker Initial local deploy
	git clone git@github.com:moodlehq/moodle-docker.git ./moodle-docker
	git clone --depth 1 --branch $$MOODLE_VERSION git@github.com:moodle/moodle.git $$MOODLE_DOCKER_WWWROOT
	cp moodle-docker/config.docker-template.php $$MOODLE_DOCKER_WWWROOT/config.php
	cp docker-compose-extra.yml moodle-docker/local.yml
	${DOCKER_COMPOSE} up -d
	$(MAKE) app.fix.permissions

docker.start: ##@Docker Start containers
	${DOCKER_COMPOSE} up -d

docker.stop: ##@Docker Stop containers
	${DOCKER_COMPOSE} stop

docker.down: ##@Docker Stop and remove containers
	${DOCKER_COMPOSE} down

app.fix.permissions: ##@App Fix permissions issues
	${DOCKER_COMPOSE} exec webserver chmod 777 -R /var/www/html/question/type /var/www/html/question/behaviour

app.bash: ##@App Enter bash in webserver container
	${DOCKER_COMPOSE} exec webserver bash

jobe.test: ##@Jobe Runs simple tests
	${DOCKER_COMPOSE} exec jobe /usr/bin/python3 /var/www/html/jobe/simpletest.py

jobe.upgrade: ##@Jobe Upgrade
	${DOCKER_COMPOSE} exec jobe ./install --purge
