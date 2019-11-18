# github

![](https://img.shields.io/puppetforge/pdk-version/ploperations/github.svg?style=popout)
![](https://img.shields.io/puppetforge/v/ploperations/github.svg?style=popout)
![](https://img.shields.io/puppetforge/dt/ploperations/github.svg?style=popout)
[![Build Status](https://travis-ci.org/ploperations/ploperations-github.svg?branch=master)](https://travis-ci.org/ploperations/ploperations-github)

This module mirrors your GitHub repos locally, so that you can rapidly create and destroy repositories before the heat death of the universe!

- [Description](#description)
- [Beginning with github](#beginning-with-github)
- [Reference](#reference)
- [Changelog](#changelog)

## Description

Mirroring github repos creates a replica of the authoritative repository.

Mirroring is quite common and is used to distribute content (in this case, source code) faster and reduces load on the primary service.

Also great for air-gapped networks.

## Beginning with github

See the example listed with `github::mirror` in [REFERENCE.md](REFERENCE.md)

## Reference

This module is documented via
`pdk bundle exec puppet strings generate --format markdown`.
Please see [REFERENCE.md](REFERENCE.md) for more info.

## Changelog

[CHANGELOG.md](CHANGELOG.md) is generated prior to each release via
`pdk bundle exec rake changelog`. This proecss relies on labels that are applied
to each pull request.
