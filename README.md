# Hanami Dash Docset

This docset for [Dash](https://kapeli.com/dash) contains the developer guides of [Hanami](https://hanamirb.org/), a modern web framework for Ruby.

## Download

No releases yet, there's still too much room for improvements. However, you can download the `hanami-*.docset` artefact of the [latest successful workflow run](https://github.com/svoop/hanami-docset/actions).

## Development

For this to work, both [Homebrew](https://brew.sh/) and [Ruby](https://www.ruby-lang.org/en/) have to be installed.

```bash
# Install tools
brew install dashing hugo

# Build
./build.sh

# Install
open hanami.docset
```

## Action

The workflow reads the version to build the docset for from `version.txt`. The leading `v` has to be omitted.

## References

* [Dashing](https://github.com/technosophos/dashing)
