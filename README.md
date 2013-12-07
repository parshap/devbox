# devbox

This is a set of tools to provision an environment for me to hack in
using *[Chef][]*. It creates my user account and configures the system
and configures the system using the [parshap coookbook][].

It works by copying all required cookbooks to the target and then
running `chef-solo`.

[chef]: http://www.opscode.com/chef/ "Opscode Chef"
[parshap cookbook]: https://github.com/parshap/parshap-cookbook "parshap-cookbook on GitHub"

## Usage

**Install [Berkshelf][] first** and then just clone this repository.

[berkshelf]: http://berkshelf.com/

### Local Host

To provision your local host use `run-local.sh`.

### Remote Host

To provision a remote host use `run-remote.sh [user@]hostname`. For example:

```bash
$ run-remote.sh parshap@dev.parshap.com
```

### Vagrant

To use Vagrant to provision a virtual machine use `vagrant up`.

Use the `USE_32BIT` environment variable to use a 32-bit "precise32"
base box instead of the default 64bit "precise64" box when initially
creating the virtual machine.
