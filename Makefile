DOCKER=docker

ifeq ($(LOGDIR),)
  LOGDIR:=/tmp/log
endif

TEST_DATE := $(shell /bin/date +%F-%H-%M-%S)
TEST_LOGDIR := $(LOGDIR)/testruns/$(TEST_DATE)

build:
	$(DOCKER) build -t cfengine-docker-testbed:fedora ./fedora
	$(DOCKER) build -t cfengine-docker-testbed:ubuntu ./ubuntu

run:
	mkdir -p $(TEST_LOGDIR)/fedora/
	$(DOCKER) run -it  -v $(TEST_LOGDIR)/fedora/:/opt/local/log/ cfengine-docker-testbed:fedora

	mkdir -p $(TEST_LOGDIR)/ubuntu/
	$(DOCKER) run -it  -v $(TEST_LOGDIR)/ubuntu/:/opt/local/log/ cfengine-docker-testbed:ubuntu

kill:
	$(DOCKER) kill `$(DOCKER) ps -q -f label=classification=cfengine-docker-testbed` || echo nothing to kill
	$(DOCKER) rm -f `$(DOCKER) ps -a -q -f label=classification=cfengine-docker-testbed` || echo nothing to clean

clean: kill
	$(DOCKER) rmi "cfengine-docker-testbed" || echo no image to remove
