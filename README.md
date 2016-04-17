# cfengine-docker-testbed

## Usage

Build it like this: `make build`

Run it like this: `make run LOGDIR=/tmp/log`

This invocation:

* will output the logs from the test to
  `/tmp/log/PLATFORM/YYYY-MM-DD-HH-MM-SS` which is a timestamped
  directory so you can run multiple tests. The platform is things like
  `fedora` and `ubuntu`.

## TODO

* build CFEngine from source
