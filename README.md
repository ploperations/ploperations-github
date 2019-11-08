# github

![](https://img.shields.io/puppetforge/pdk-version/ploperations/ploperations-github.svg?style=popout)
![](https://img.shields.io/puppetforge/v/ploperations/ploperations-github.svg?style=popout)
![](https://img.shields.io/puppetforge/dt/ploperations/ploperations-github.svg?style=popout)
[![Build Status](https://travis-ci.org/ploperations/ploperations-ploperations-github.svg?branch=master)](https://travis-ci.org/ploperations/ploperations-ploperations-github)

This module mirrors your GitHub repos locally, so that you can rapidly create and destroy repositories before the heat death of the universe!

> NOTE: this module currently uses a private fork of the apache module. We are working to migrate it to the normal version of apache and plan to release it on the Forge after that.

#### Table of Contents

1. [Description](#description)
2. [Setup - The basics of getting started with github](#setup)
    * [What github affects](#what-github-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with github](#beginning-with-github)
3. [Usage - Configuration options and additional functionality](#usage)
4. [Limitations - OS compatibility, etc.](#limitations)
5. [Development - Guide for contributing to the module](#development)

## Description

Mirroring github repos creates a replica of the authoritative repository.

Mirroring is quite common and is used to distribute content (in this case, source code) faster and reduces load on the primary service.

Also great for air-gapped networks.

## Setup

### Beginning with github

Here are some examples:

```
class { "github::params":
  user       => "gitmirror",
  group      => "gitmirror",
  basedir    => "/home/gitmirror",
  wwwroot    => "/var/www/gitmirror",
  vhost_name => "git",
}

file { "/var/www/gitmirror":
  ensure => directory,
  owner  => "gitmirror",
  group  => "gitmirror",
  mode   => "0755",
}

github::mirror {
  "puppetlabs/puppet":
    ensure => present;
  "supersecret/world-domination-plans":
    ensure  => present,
    private => true;
}
```

## Reference

This module is documented via
`pdk bundle exec puppet strings generate --format markdown`.
Please see [REFERENCE.md](REFERENCE.md) for more info.

## Changelog

[CHANGELOG.md](CHANGELOG.md) is generated prior to each release via
`pdk bundle exec rake changelog`. This proecss relies on labels that are applied
to each pull request.
