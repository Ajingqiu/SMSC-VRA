# Dataset Documentation
This directory contains the multi-view datasets used in the SMSC‑VRA experiments. Statistics follow Table 1 and Section 4.1 of the original paper.

## Dataset List
### BDGP (currently included)
- **Samples**: 2500
- **Views**: 3
- **Clusters**: 5
- **Domain**: Bioinformatics / Drosophila gene‑expression in‑situ images
- **Source**: [https://www.fruitfly.org/](https://www.fruitfly.org/)
- **Feature Extraction**: Three sets of hand‑crafted visual descriptors extracted from embryo images.
- **File Format**: MATLAB `.mat` file
- **Expected Variables in .mat file**:
  - `X1`: View 1 data, size `[dim1 × 2500]`
  - `X2`: View 2 data, size `[dim2 × 2500]`
  - `X3`: View 3 data, size `[dim3 × 2500]`
  - `label`: Ground truth labels, size `[1 × 2500]`

> Format convention: **features in rows, samples in columns**.

## Dataset Format Requirements
For compatibility with SMSC‑VRA, the `.mat` file should contain:
- Feature matrices for each view (separate variables or cell array)
- Ground‑truth cluster labels
- Equal number of samples across all views
- Feature matrix shape: `[feature_dimension × num_samples]`

## Other Datasets (not included in this repository)
Due to file‑size and license restrictions, these datasets are not distributed here. Download from original sources and place `.mat` files under `data/`.

| Dataset | Samples | Views | Clusters | Notes |
|---|---|---|---|---|
| Caltech101‑7 | 1474 | 6 | 7 | Source: [https://data.caltech.edu/records/mzrjq](https://data.caltech.edu/records/mzrjq)‑6wc02 |
| Animal | 11673 | 4 | 20 | Pre‑processed multi‑view benchmark |
| Reuters | 18758 | 5 | 6 | Source: [http://archive.ics.uci.edu/ml/machine](http://archive.ics.uci.edu/ml/machine)‑learning‑databases/00259/ |
| AwA | 30475 | 6 | 50 | Source: [https://cvml.ist.ac.at/AwA/](https://cvml.ist.ac.at/AwA/) |
| YTF10 | 111740 | 4 | 10 | Source: [https://www.cs.tau.ac.il/~wolf/ytfaces/](https://www.cs.tau.ac.il/~wolf/ytfaces/) |
| YTF100 | 195537 | 4 | 100 | Source: [https://www.cs.tau.ac.il/~wolf/ytfaces/](https://www.cs.tau.ac.il/~wolf/ytfaces/) |

Naming convention: `{DatasetName}.mat`

## Data Preprocessing Notes
- All features require **per‑sample L2 normalization** before feeding into the algorithm.
- Reuters: TF‑IDF is used for text feature representation.
- Image datasets: Use released hand‑crafted / deep pre‑extracted features.
- Labels should be 1‑based integers.
- See paper Section 4.1 for full experimental dataset descriptions.