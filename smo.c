#include <stdio.h>
#include <stdlib.h>
#define EPS 0.01
#define DIM 2
#define TAM 10

float* target;    /*desire output vector*/
float** point;    /*trainig point matrix*/
float* alphas;    /* Lagrange multipliers */
float* E;    /*actual error vector*/
float* w;    /* weigth vector solution */
float b;    /* bias */
float C;    

float
max(float num1, float num2)
{
    return num1 > num2 ? num1 : num2;
}

float
min(float num1, float num2)
{
    return num1 < num2 ? num1 : num2;
}

float
absolute(float x)
{
    return x >= 0 ? x : -x;
}

float
linearKernel(int pos1, int pos2)
{
    int i;
    float res = 0.0;
    for (i = 0; i < DIM; i++) {
        res += point[pos1][i] * point[pos2][i];
    }

    return res;
}

void
updateErrorCache()
{
    int i, j;
    for (i = 0; i < TAM; i++) {
        for (j = 0; j < DIM; j++) {
            E[i] = w[j]*point[i][j] - b - target[i];
        }
    }
}

int
takeStep(int i1, int i2)
{
    float alpha1, y1, E1,
        alpha2, y2, E2;
    float s, L, H, k11, k12, k22, a1,
        a2, f1, f2, L1, H1, Lobj, Hobj, 
        eta, b1, b2, bnew;
    int i;

    if (i1 == i2) return 0;
    
    alpha1 = alphas[i1];
    y1 = target[i1];
    E1 = E[i1];
    y2 = target[i2];
    alpha2 = alphas[i2];
    E2 = E[i2];
    s = y1 * y2;

    /* Calculate upper and lower limits */
    if (y1 == y2) {
        L = max(0, alpha2 + alpha1 - C);
        H = min(C, alpha2 + alpha1);
    } else {
        L = max(0, alpha2 - alpha1);
        H = min(C, C + alpha2 - alpha1);
    }

    k11 = linearKernel(i1, i1);
    k12 = linearKernel(i1, i2);
    k22 = linearKernel(i2, i2);

    eta = k11 + k22 - 2*k12;

    /* Calculate new alpha2 */
    if (eta > 0) {
        a2 = alpha2 + y2 * (E1 - E2) / eta;
        a2 = min(H, max(L, a2));
    } else {
        /* If eta is non-negative, move new a2 to bound 
        with greater objective function value */
        f1 = y1*(E1 + b) - alpha1*k11 - s*alpha2*k12;
        f2 = y2*(E2 + b) - alpha2*k22 - s*alpha1*k12;
        L1 = alpha1 + s*(alpha2 - L);
        H1 = alpha1 + s*(alpha2 - H);
        Lobj = L1*f1 + 0.5*L1*L1*k11 + 0.5*L*L*k22 + s*L*L1*k12;
        Hobj = H1*f1 + 0.5*H1*H1*k11 + 0.5*H*H*k22 + s*H*H1*k12;

        if (Lobj < Hobj - EPS)
            a2 = L;
        else if (Lobj > Hobj + EPS)
            a2 = H;
        else
            a2 = alpha2;
    }

    /* Checking a2 */
    if (absolute(a2 - alpha2) < EPS*(a2 + alpha2 + EPS)) 
        return 0;

    /* Calculate new alpha1 */
    a1 = alpha1 + s*(alpha2 - a2);

    /* Update threshold b */
    b1 = E1 + y1*(a1 - alpha1)*k11 + y2*(a2 - alpha2)*k12 + b;
    b1 = E2 + y1*(a1 - alpha1)*k12 + y2*(a2 - alpha2)*k22 + b;

    if (0 < a1 && a1 < C)
        bnew = b1;
    else if (0 < a2 && a2 < C)
        bnew = b2;
    else
        bnew = (b1 + b2) / 2;

    /* Update weigth vector w */
    for (i = 0; i < DIM; i++) {
        w[i] = w[i] + y1*(a1 - alpha1)*point[i1][i] + 
                y2*(a2 - alpha2)*point[i2][i];
    }

    /* Update alphas and error cache*/
    alphas[i1] = a1;
    alphas[i2] = a2;
    b = bnew;
    updateErrorCache();

    return 1;

}

int 
examineExample(int i2)
{

}

int
main(int argc, char *argv[])
{
    printf("Hello world");
}