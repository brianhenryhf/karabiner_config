# Karabiner Config

## Overview

This project defines the resources to generate keyboard configuration and tweaks for my Mac, using [Karabiner Elements](https://karabiner-elements.pqrs.org/).

## Building

Karabiner operates on JSON config, but JSON is sub-optimal for a variety of reasons. [Jsonnet](https://jsonnet.org/) fixes some of those issues (DRYs up code, allows for comments, less symbol-noise in syntax, etc.), but this requires we add a build step.  The [scripts](./scripts) directory has (not surprisingly) scripts, such as `build_deploy.sh`, which transforms the source jsonnet to JSON and drops it in the right place to be made available to Karabiner settings.
