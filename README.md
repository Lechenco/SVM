# Support Vector Machine

[![License: GPL v3](https://img.shields.io/badge/License-GPL%20v3-blue.svg)](https://www.gnu.org/licenses/gpl)


Repository from study in [SVM](./_articles/_SVM/SUPPORT%20VECTOR%20MACHINES.pdf) 
techniques, with the objective to classsify data from Eletrocardiograms.

The code implemented here uses an [SMO algorithm](./_articles/_SVM/SMO_Pratt.pdf) 
to resolve the optimization problems to approximate the [Lagrange Multipliers](./_articles/_SVM/LagrangeForSVMs.pdf)
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

---
## Folders Structure

This repository have the follows folders:

- [_articles](_articles/) - reference studies on all the topics used in this research:
  - [Correntropy](_articles/_correntropy/)
  - [SVM](_articles/_SVM/)
  - [Wavelet](_articles/Wavelet/)

- [_code](_code/) - Research code fucntions
  
- [_data](_data/) - with the database data and files of post-processing 
  - [Arritmia](_data/Arritmia/) - 
  - [Normal](_data/Normal/) -

- [_samples](_samples/) - example algorithms to work with the database

- [_svmImplementation](_svmImplementation/) - SVM implementation code using a SMO algorithm
