This tool uses [Vagrant](http://vagrantup.com) to provision an
environment for me to hack in. It does the following:

 * Creates and configures my user account (using the [parshap
   coookbook](https://github.com/parshap/parshap-cookbook))

 * Installs software (git, zsh, node.js)

# Usage

```
vagrant up
```

# Vagrant Plugins

The [berkshelf plugin](https://github.com/RiotGames/vagrant-berkshelf) must be installed.

# Environment Variables

 * `USE_32BIT`: uses the 32-bit "precise32" base box instead of the default 64bit "precise64" box when initially creating vm
