# devbox

This is a set of tools to provision an environment for me to hack in. It
creates my user account and configures the system and configures the
system using the *[Chef][]* [parshap cookbook][].

It works by copying all required cookbooks to the target and then
running `chef-solo`.

[chef]: http://www.opscode.com/chef/ "Opscode Chef"
[parshap cookbook]: https://github.com/parshap/parshap-cookbook "parshap-cookbook on GitHub"

## Usage

1. **Install [Berkshelf][] first** and then just clone this repository. On
Ubuntu you can use `./install_berkshelf` to install Berkshelf.

1. Run `make` to build artifacts required for provisioning.

[berkshelf]: http://berkshelf.com/

### Local Host

To provision your local host use `./run-local`.

### Remote Host

To provision a remote host use `./run-remote [user@]hostname`. For example:

```bash
$ ./run-remote parshap@dev.parshap.com
```

### Vagrant

To use Vagrant to provision a virtual machine use `vagrant up`.

Use the `USE_32BIT` environment variable to use a 32-bit "precise32"
base box instead of the default 64bit "precise64" box when initially
creating the virtual machine.

## OSX

The `osx-bootstrap.sh` script will install some things on OSX. This is not the
same as the chef cookbooks and should be used separately.

### Manual Installs

#### SIMBL + MouseTerm
http://www.culater.net/software/SIMBL/SIMBL.php
https://bitheap.org/mouseterm/
