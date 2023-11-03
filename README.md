

<p align="center">
<img src="https://github.com/Trebonius91/Caracal/blob/main/manual/figures/logo.png" alt="drawing" width="300"/>
</p>

<p align="center">
<sub><sup>(Logo reprinted with permission from https://doi.org/10.1021/acs.jctc.3c00568. Copyright 2023 American Chemical Society.)</sup></sub>
</p>

# Caracal
Ring polymer molecular dynamics and rate constant calculations on black-box potential energy surfaces

## About Caracal

Caracal is a free open-source software package that enables a wide variety of molecular dynamics applications.
Unbiased and biased molecular dynamics trajectories can be sampled, unperiodic as well as periodic (NVE, NVT, NpT) setups are possible.

Classical (Newtonian) as well as ring polymer molecular dynamics (RPMD) can be used.
A central feature is the automized setup of potential energy surfaces for gas phase reactions using the EVB-QMDFF methodology.

Quantum mechanical derived force fields (QMDFFs) can be generated in black box fashion for arbitrary chemical systems, two QMDFFs can be coupled by
different EVB (Empirical Valence Bond) coupling methods.

Simple energy difference coupling methods as well as more sophisticated methods like distributed gaussian (DG)-EVB or transition region corrected reaction path EVB-QMDFF (TREQ) are availabe for that purpose.

Especially the TREQ method allows for black-box generation of high quality PES descriptions, the whole process of PES setup and rate constant calculation with RPMD is realized in the black-box program within Caracal.

The well-known class of semiempirical GFN-xTB methods is implemented now as well, enabling the bla
ck-box simulation of arbitrary chemical systems.

QMDFFs of single molecules can be polymerized to describe complex multicomponent mixtures or solutions, containing molecules like transition metal complexes for which it is hard to get force field parametrizations but are easy to setup with QMDFF.

Further, a steadily growing number of analytical PES representations of gas phase reaction systems from the literature is integrated into Caracal, mainly for the calculation of rate constants. Alternatively, you can couple your own
PES routine to the program (either by defining a syscall or directly integrating the subroutine into the Caracal code) and perform biased or unbiased RPMD with it.

If you use Caracal for your research, I would be very glad if you could cite the ***original Caracal paper*** ([DOI: 10.1021/acs.jctc.3c00568](https://pubs.acs.org/doi/10.1021/acs.jctc.3c00568)). 
Within it and its supporting information, more details concerning the underlying theory and algorithms can be found as well.

Included (and sometimes slightly modified) software:

mctc_lib: [https://github.com/grimme-lab/mctc-lib](https://github.com/grimme-lab/mctc-lib)

dftd3_lib: [https://github.com/dftbplus/dftd3-lib](https://github.com/dftbplus/dftd3-lib)

dftd4: [https://github.com/dftd4/dftd4](https://github.com/dftd4/dftd4)

multicharge: [https://github.com/grimme-lab/multicharge](https://github.com/grimme-lab/multicharge)

toml-f: [https://github.com/toml-f/toml-f](https://github.com/toml-f/toml-f)

tblite: [https://github.com/tblite/tblite](https://github.com/tblite/tblite)

## License

Caracal is distributed unter the terms of the [MIT license](https://opensource.org/licenses/mit-license):

```
   CARACAL - Ring polymer molecular dynamics and rate constant calculations
             on black-box generated potential energy surfaces

   Copyright (c) 2023 by Julien Steffen (mail@j-steffen.org)
                         Stefan Grimme (grimme@thch.uni-bonn.de) (QMDFF code)

   Permission is hereby granted, free of charge, to any person obtaining a
   copy of this software and associated documentation files (the "Software"),
   to deal in the Software without restriction, including without limitation
   the rights to use, copy, modify, merge, publish, distribute, sublicense,
   and/or sell copies of the Software, and to permit persons to whom the
   Software is furnished to do so, subject to the following conditions:

   The above copyright notice and this permission notice shall be included in
   all copies or substantial portions of the Software.

   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
   IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
   FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
   THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
   LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
   FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
   DEALINGS IN THE SOFTWARE.
```

## Obtaining Caracal

The program package can be obtained by getting a copy of this repository using git:
```
git clone git://github.com/Trebonius91/CARACAL.git
```
## Installation:

Caracal is written in Fortran 90, with some minor parts in Fortran 77.
For compilation, the following dependencies are required:

- Standard Fortran 90 compiler (gfortran, ifort, etc.)
- Lapack and BLAS
- FFTW
- MPI

## Compiling from Source

The Makefile, which is located in the main directory, should be modified to meet your system requirements, choosing a suitable set of compiler and required libraries
(a separate configure file will be added in the future). After, this, copy it to the src directory and run
```
$ make
```
If the build is successful, the different programs of the package are located in the bin directory.

## Executing the programs

In order to understand the handling of the different programs in Caracal, type the help option, e.g.
```
$ dynamic.x -h
```
Now, general instructions how to use the program as well as a list of available keywords is shown.

## Tutorials and Examples

A detailed set of tutorials describing the different programs, including a set of different examples covering relevant application cases can be found in the [Caracal Wiki](https://github.com/Trebonius91/CARACAL/wiki)

## Further Questions, Suggestions or Bug Reports

If you have further questions, suggestions what shall be added to Caracal, or detected a bug / unexpected behavior within Caracal, please do not hesitate to contact me! (either here on github, or via mail (mail@j-steffen.org)).        

## Future improvements

- Implementing a periodic version of Grimme's GFN-FF as alternative to QMDFF, for an even simpler generation of (diabatic) force field descriptions
- Development of local versions of TREQ, enabling the calculation of larger systems without complicated and error-prone sets of internal coordinates
- Exact unimolecular rate constants: implementing theoretically stringent prefactors for the different unimolecular mechanisms
- Reactions in solvents: Implementing a "QM/MM" scheme, with the reactive part described by TREQ and sampled with RPMD and the solvent described by GFN-FF and classical dynamics

## Latest changes

- 10/09/2023: The FFT routines were updated to the more recent Fortran2003/C interface as recommended by the FFTW developers in order to fix a bug when using the Intel MKL libraries
- 10/09/2023: The keyword RANDOM\_SEED [value] was added for the programs dynamic and calc\_rate in order to enable exact reproduction of calculations for debugging or benchmarks
- 10/30/2023: The program file 'poly_qmdff.f90' which was missing so far, was now added.
