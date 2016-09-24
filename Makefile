DOCKER=docker

ifeq ($(LOGDIR),)
  LOGDIR:=/tmp/log
endif

TEST_DATE := $(shell /bin/date +%F-%H-%M-%S)
TEST_LOGDIR := $(LOGDIR)/testruns/$(TEST_DATE)

TARGETS=fedora ubuntu

RUNFLAGS=
WITH_SKETCHES=
ifneq ($(WITH_SKETCHES),)
	RUNFLAGS:=$(RUNFLAGS) -v $(WITH_SKETCHES):/var/cfengine/design-center/sketches:z
endif

WITH_ACTIVATIONS=
ifneq ($(WITH_ACTIVATIONS),)
	RUNFLAGS:=$(RUNFLAGS) -v $(WITH_ACTIVATIONS):/opt/local/inputs/design_center.cf.json:z
endif

build:
	$(foreach target,$(TARGETS),cp design_center.cf design_center.cf.json cfengine-tester $(target)/;)
	$(foreach target,$(TARGETS),$(DOCKER) build -t cfengine-docker-testbed:$(target) ./$(target);)

run:
	$(foreach target,$(TARGETS),mkdir -p $(TEST_LOGDIR)/$(target)/;)
	$(foreach target,$(TARGETS),$(DOCKER) run -it  -v $(TEST_LOGDIR)/$(target)/:/opt/local/log/ $(RUNFLAGS) cfengine-docker-testbed:$(target);)

kill:
	$(DOCKER) kill `$(DOCKER) ps -q -f label=classification=cfengine-docker-testbed` || echo nothing to kill
	$(DOCKER) rm -f `$(DOCKER) ps -a -q -f label=classification=cfengine-docker-testbed` || echo nothing to clean

clean: kill
	$(DOCKER) rmi "cfengine-docker-testbed" || echo no image to remove
