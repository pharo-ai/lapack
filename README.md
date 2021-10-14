# Pharo LAPACK

[![Build status](https://github.com/pharo-ai/lapack/workflows/CI/badge.svg)](https://github.com/pharo-ai/lapack/actions/workflows/test.yml)
[![Coverage Status](https://coveralls.io/repos/github/pharo-ai/lapack/badge.svg?branch=master)](https://coveralls.io/github/pharo-ai/lapack?branch=master)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](https://raw.githubusercontent.com/pharo-ai/lapack/master/LICENSE)

A minimal FFI binding for LAPACK (http://www.netlib.org/lapack/) in Pharo.

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

## How to use it?

Currently, we only bound one routine: `dgelsd()` that:
>computes the minimum-norm solution to a linear least squares problem for GE matrices.

To use the method, you only need to:

```st
matrixA := #( 0.12 -6.91 -3.33  3.97 -8.19
              2.22 -8.94  3.33  7.69 -5.12
             -6.72 -2.74 -2.26 -9.08 -4.40
             -7.92 -4.71  9.96 -9.98 -3.20 ).
matrixB := #( 7.30  1.33  2.68 -9.62 0.00
              0.47  6.58 -1.71 -0.79 0.00
             -6.28 -3.42  3.46  0.41 0.00 ).

algorithm := LapackDgelsd new
    numberOfRows: 4;
    numberOfColumns: 5;
    numberOfRightHandSides: 3;
    matrixA: matrixA;
    matrixB: matrixB;
    yourself.

algorithm solve.

"To get the result, we have to call the accessors.
Info represents if the process completed with success"
algorithm info.

"the array with the solutions"
algorithm minimumNormSolution.

"The effective rank"
algorithm rank.

"And the singular values"
algorithm singularValues.
```
