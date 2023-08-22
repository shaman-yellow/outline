
# NMR and predict diagnostic model

Serum and urine metabolomics study reveals a distinct diagnostic model for
cancer cachexia

## abstract

nuclear magnetic resonance-based metabolics analysis
reveal cancer profile
establish diagnostic model (molecular biomarker) **cancer cachexia**

## methods

diagnostic model:

Random forest

logistic regression

ROC

## Methods details

- Identification: Chenomx NMR Suite software
- NMR data reduction: AMIX
    - Reduced into integral regions of equal lengths of 0.005 p.p.m
    - Regions of δ 4.7–5.1 that contained the resonance from residual water were set to zero
    - Normalized to the total spectral area
- Metabolomics analysis: Simca and ...
    - PCA
    - Normalization: Response variables were centred and scaled to Pareto variance ((x - u) / sigma ^ .5)
    - Log transform
    - OPLS-DA and VIP value to select metabolites
    - heatmap (metaboAnalyst)
    - Statistic: VIP &gt; 1 (PLS), p1 $\geq$ 0.05 (S-plot)
    - ? GlobalTest: ...
- MetaboAnalyst
    - Pathway analysis
- Establish Model
    - Random forest
    - Logistic regression
    - ROC validation
- MedCalc software
    - attribute data: as counts, non-parametric test
    - measurement data: mean +- standard
    - normal distribution data: 2 groups, t-test; more group, ANOVA, Tukey's post-hoc test
    - non-normal distribution data: likeli-hood ratio chi-square statistical method
    - Correlation: weight loss and metabolites level, correlation and regression 

## Analysis route

### Individual serum

### Individual Urine

### Correlation between serum and urine





