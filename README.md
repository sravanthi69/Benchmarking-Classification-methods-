# Benchmarking Multiple Classification Models in R

This project compares the performance of different classification algorithms across multiple real-world datasets using R. 

The main objective is to observe how model performance changes when the dataset characteristics change. Instead of evaluating a model on just one dataset, this project evaluates the same model set over many different datasets—this gives a much more realistic understanding of algorithm behavior.



## Models Used

This benchmark evaluates 7 well-known classification models:

- Logistic Regression (GLM)
- LDA
- QDA
- BSNSING Decision Tree
- Random Forest
- Support Vector Machine
- Naive Bayes

### Metrics Evaluated
- **AUC**
- **Accuracy**
- **Training Time**

---

## Two Benchmark Approaches in This Repo
This project has **two** evaluation modes:

| Part | Script | Description |
|------|--------|-------------|
| **Part 1 – Baseline Benchmark** | `codep1.R` | Runs all 7 classification models directly using all available features in the dataset. This is the fast and simple baseline run, useful for comparing pure model behavior across multiple datasets. |
| **Part 2 – Forward Feature Selection Benchmark** | `codep2.R` | Performs forward feature selection first (for each model) to find the best combination of predictors. Then trains and evaluates using that optimized feature set. This run takes longer but provides more insight on which features actually matter. |

The core engine used by both is defined inside **`model.R`**.
---

## Repository Structure
```
root/
├── model.R
├── codep1.R
├── codep2.R
├── Dataprocessing.R
├── ROC_func.R
├── accuracymod.R
├── forwardselectionmod.R
├── data sets/          # raw datasets 
├── datasets2/          # processed dataset folder
└── reports/
```

## Datasets Used:
The project uses multiple public classification datasets.
These came from common ML sources like UCI and Kaggle.



