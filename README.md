# Puppet module for Squid

[![Build Status](https://img.shields.io/travis/alexharv074/puppet-squid.svg)](https://travis-ci.org/alexharv074/puppet-squid)

## Description

A simple Puppet module for configuring the squid caching service.

## Usage

The set up a simple squid server:

Hiera:

~~~ yaml
---
squid::config: '/etc/squid/squid.conf'
squid::squid_conf: |
  http_port 3128
  acl localnet src 192.168.1.0/24
  http_access allow localnet
  http_access deny all
~~~

Puppet:

~~~ puppet
include squid
~~~

### Parameters for squid class

* `squid_conf` (mandatory parameter) The contents of the `squid.conf` file as a string. It is expected you will use either a block scalar in Hiera, or a Heredoc in your manifest. It would also be trivial to add a feature here to also allow this to be specified file or template that would live outside of this module. Let me know if you'd like me to implement this feature.
* `ensure_service` The ensure value of the squid service, defaults to `running`.
* `enable_service` The enable value of the squid service, defaults to `true`.
* `config` Location of `squid.conf` file, has appropriate OS defaults.
* `config_user` user which owns the config file, has appropriate OS defaults.
* `config_group` group which owns the config file, has appropriate OS defaults.
* `daemon_user` user which runs the squid daemon, this is used for ownership of the cache directory, has appropriate OS defaults.
* `daemon_group` group which runs the squid daemon, this is used for ownership of the cache directory, has appropriate OS defaults.
* `package_name` name of the squid package to manage, has appropriate OS defaults.
* `service_name` name of the squid service to manage, has appropriate OS defaults.

## Development

Please read CONTRIBUTING.md before contributing.

### Testing

Make sure you have:

* rake
* bundler

Install the necessary gems:

    bundle install

To run the tests from the root of the source code:

    bundle exec rake spec

