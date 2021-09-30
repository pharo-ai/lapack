# Pharo LAPACK

[![Build status](https://github.com/pharo-ai/lapack/workflows/CI/badge.svg)](https://github.com/pharo-ai/lapack/actions/workflows/test.yml)
[![Coverage Status](https://coveralls.io/repos/github/pharo-ai/lapack/badge.svg?branch=master)](https://coveralls.io/github/pharo-ai/lapack?branch=master)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](https://raw.githubusercontent.com/pharo-ai/lapack/master/LICENSE)

A minimal FFI binding for LAPACK (http://www.netlib.org/lapack/) in Pharo. For more complete binding see [nicolas-cellier-aka-nice/smallapack](https://github.com/nicolas-cellier-aka-nice/smallapack).

## How to install it?

To install `lapack`, go to the Playground (Ctrl+OW) in your [Pharo](https://pharo.org/) image and execute the following Metacello script (select it and press Do-it button or Ctrl+D):

```Smalltalk
Metacello new
  baseline: 'Lapack';
  repository: 'github://pharo-ai/lapack/src';
  load.
```

## How to depend on it?

If you want to add a dependency on `lapack` to your project, include the following lines into your baseline method:

```Smalltalk
spec
  baseline: 'Lapack'
  with: [ spec repository: 'github://pharo-ai/lapack/src' ].
```

If you are new to baselines and Metacello, check out the [Baselines](https://github.com/pharo-open-documentation/pharo-wiki/blob/master/General/Baselines.md) tutorial on Pharo Wiki.

## How to use it?
