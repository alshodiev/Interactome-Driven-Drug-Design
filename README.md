# Interactome-Driven Drug Design

## Overview
This project addresses the challenge of data sparsity in drug-target interaction (DTI) datasets by leveraging interactome-based imputation methods. By combining protein-protein interaction networks and advanced molecular representations, we aim to enhance the accuracy of molecular optimization tasks in drug development.

Key methods include:
1. **Matrix Factorization** : Imputing missing DTI scores using Singular Value Decomposition (SVD).
2. **Random Walk Score Propagation**: Utilizing a high-quality protein interactome graph to propagate interaction scores.
   
The effectiveness of these methods is validated through cross-validation and downstream molecular optimization for the protein tyrosine phosphatase non-receptor (PTP1B) inhibition task.

## Contents
- **Data Preparation**:
  - Generating protein-protein interaction graphs using the HuRI dataset.
  - Constructing DTI matrices from ChEMBL data.
- Imputation Strategies:
  - Matrix Factorization (SVD).
  - Random Walk Propagation on protein interactome graphs.
- Validation:
  - Cross-validation for imputation accuracy.
  - Downstream molecular optimization tasks using Chemprop and Junction Tree Variational Autoencoders (JT-VAE).
Results Analysis:
  - Comparing RMSE and MAE for each imputation method.
  - Evaluating success rates for de novo molecular generation.
 
## Key Findings
- **Imputation Accuracy** : Random Walk Propagation outperformed Matrix Factorization in RMSE (39.6 vs. 48.8) but had slightly higher MAE (35.1 vs. 29.0).
- **Molecular Optimization**: Uniform success rates were observed across imputed datasets in generating molecules targeting PTP1B.
- **Interactome Insights**: Highly connected protein nodes, such as UBQLN2 and PICK1, were identified as biologically relevant hubs in the interactome.

## Future Work
1. Refining hyperparameters for Random Walk Propagation.
2. Exploring larger datasets for better downstream validation.
3. Addressing current issues with molecular translation in target augmentation.
