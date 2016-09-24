# cfengine-docker-testbed

## Usage

Build it like this: `make build`

Run it like this: `make run LOGDIR=/tmp/log`

This invocation:

* will output the logs from the test to
  `/tmp/log/PLATFORM/YYYY-MM-DD-HH-MM-SS` which is a timestamped
  directory so you can run multiple tests. The platform is things like
  `fedora` and `ubuntu`.

If you run `make build TARGETS=fedora` or `make run TARGETS=fedora` then only
those targets will be run or built instead of all of them.

## Design Center support

If you run `make run WITH_SKETCHES=/my/path/design-center/sketches` then that
path will be mounted under `/var/cfengine/design-center/sketches` so both the
container and you can access and modify them. The Design Center policy will
install the sketches from that directory, so this is a very convenient way to
test your own sketches.

If you run `make run WITH_ACTIVATIONS=/my/path/activations.json` then that path
will be mounted under `/opt/local/inputs/design_center.cf.json` and determine
what sketches from the Design Center (either the Design Center sketch
repository, or the path you gave to `WITH_SKETCHES` above) are installed and
activated. By default, that file tells the policy to install the Design Center
`System::motd` sketch with a single activation (see `design_center.cf.json`
here).

## TODO

* build CFEngine from source
