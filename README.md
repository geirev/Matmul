# Matmul

test code for timeing and checing dgemm from blas vs fortran matmul.

<p align="center">
<img src="doc/example.png" width="600">
</p>

# Installation:

## 1. Building the Project

If you plan to collaborate or contribute anything to the project, use the <a href="#1b-advanced-installation">Advanced Installation</a> option.

### 1a. Basic installation

Create a directory to clone the three following repositories:

```bash
git clone git@github.com:geirev/Matmul.git
```

## 2. Required Packages

### Linux

```bash
sudo apt-get update
sudo apt-get install libblas-dev libomp-dev gfortran
```

### Mac

```bash
brew install gcc openblas libomp-dev? gfortran?
```

**Note:** You must have [Homebrew](https://brew.sh/) installed to install
packages using `brew`

## 5. Compile and run

### Linux

Navigate to the `src` folder of the `Matmul` repository:

```bash
cd Matmul/src
```

then compile and install the executable in the target directory, defaulting to
`$HOME/bin`:

```bash
make BINDIR=$HOME/bin
```

### Mac

Navigate to the `src` folder of the `EnKF_MS` repository:

```bash
cd Matmul/src
```

then edit the following line in `Matmul/src/makefile` from:

```bash
LIBS = -lblas
```

to:

```bash
LIBS = -lblas
```

then compile and install the executable in the target directory, defaulting to
`$HOME/bin`:

```bash
make BINDIR=$HOME/bin
```
