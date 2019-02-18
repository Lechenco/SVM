# Support Vector Machine

[![License: GPL v3](https://img.shields.io/badge/License-GPL%20v3-blue.svg)](https://www.gnu.org/licenses/gpl)


Repository from study in [SVM](./_articles/SUPPORT%20VECTOR%20MACHINES.pdf) 
techniques, with the objective to classsify data from Eletrocardiograms.

The code implemented here uses an [SMO algorithm](./_articles/SMO_Pratt.pdf) 
to resolve the optimization problems to approximate the [Lagrange Multipliers](./_articles/LagrangeForSVMs.pdf)
 to solve the classification problem.

 ## Algorithms Types

 - **SMO:** Sequential Minimal Optimization can be used when is not expected outliers in the data.
 - **ISDA:** Iterative Single Data Algorithm can set a fraction of expected outliers in the data
 - **quadprog:** Quadratic Programming can be use to increase the degree of precision

Recommended to use a optmized library ([libsvm](https://www.csie.ntu.edu.tw/~cjlin/libsvm/)).

## Kernels

The kernels can be a solution when the data don't have a explicit linear separation between the classes. They include functions like:

 - Polynomials
   G(x<sub>1</sub>,x<sub>2</sub>) = (1 + x<sub>1</sub>′x<sub>2</sub>)p.
 
 - Radial basis (Gaussian): 
    G(x<sub>1</sub>,x<sub>2</sub>) = exp(–∥x<sub>1</sub>–x<sub>2</sub>)∥<sup>2</sup>).

 - Multilayer perceptron or sigmoid (neural network)
   G(x<sub>1</sub>,x<sub>2</sub>) = tanh(p<sub>1</sub>x<sub>1</sub>′x<sub>2</sub> + p<sub>2</sub>). 
