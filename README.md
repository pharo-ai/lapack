# Pharo LAPACK

[![Build status](https://github.com/pharo-ai/lapack/workflows/CI/badge.svg)](https://github.com/pharo-ai/lapack/actions/workflows/test.yml)
[![Coverage Status](https://coveralls.io/repos/github/pharo-ai/lapack/badge.svg?branch=master)](https://coveralls.io/github/pharo-ai/lapack?branch=master)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](https://raw.githubusercontent.com/pharo-ai/lapack/master/LICENSE)

A minimal FFI binding for LAPACK (http://www.netlib.org/lapack/) in Pharo.

For the documentation, please refer to the pharo-ai wiki page: https://github.com/pharo-ai/wiki/blob/master/wiki/LinearAlgebra/Lapack.md

For creating another binding to another method (or routine, because the library is written in Fortran), you only need to create a subclass of `LapackAlgorithm`. You can check `LapackDgelsd` as an example. 

_Note: We only tested this for MacOS. But it should work on Windows and Linux too. A prerequisite is to have already intalled the library on your OS. For making it work on Linux and Windows, is only needed to override the methods `unixLibraryName` and `win32LibraryName` to return the path in which the library is installed on your system. Check `LapackLibrary>>#macLibraryName`_

## How to install it?

To install `Lapack`, go to the Playground (Ctrl+OW) on your [Pharo](https://pharo.org/) image and execute the following Metacello script (select it and press Do-it button or Ctrl+D):

```Smalltalk
Metacello new
  baseline: 'Lapack';
  repository: 'github://pharo-ai/lapack/src';
  load.
```

## How to depend on it?

If you want to add a dependency on `Lapack` to your project, include the following lines into your baseline method:

```Smalltalk
spec
  baseline: 'Lapack'
  with: [ spec repository: 'github://pharo-ai/lapack/src' ].
```

If you are new to baselines and Metacello, check out the [Baselines](https://github.com/pharo-open-documentation/pharo-wiki/blob/master/General/Baselines.md) tutorial on Pharo Wiki.

## Why the CI is red?

To run the algorithm, one needs to have installed Lapack library in the computer. We need to find a way to install Lapack in Smalltalk CI to be able to run the tests. If you have lapack installed in your computer, you can run manually the tests. They should be green.
