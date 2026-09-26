# SMSC-VRA

MATLAB implementation of **SMSC-VRA** (Scalable Multi-view Subspace Clustering with View Rarity Analysis). Paper: *Knowledge-Based Systems*.

## Quick Start

1. Place your dataset (e.g., BDGP.mat) in the data/ directory.
2. Open MATLAB, navigate to this directory, and run:

        demo

This runs the SMSC-VRA algorithm on the BDGP dataset and saves results to the results/ directory.

## Dataset

See data/README_data.md for dataset format requirements.

## Main Files

| File | Description |
|------|-------------|
| demo.m | Demo script (entry point) |
| SMSC_VRA_run.m | Core SMSC-VRA algorithm |
| ablation.m | Ablation study |
| plot_runtime_figure3.m | Running time comparison (Figure 3) |
| measure/ | Clustering evaluation metrics (ACC, NMI, etc.) |

## Requirements

- MATLAB R2020b or later

## Citation

If you use this code, please cite:

    @misc{wang2026smscvra,
      title={Geometric-driven Scalable Multi-view Subspace Clustering with View Rarity Analysis},
      author={Wang, Jingqiu and Yang, Geping and Yang, Yiyang and Chen, Can and Gong, Zhiguo and Hao, Zhifeng},
      year={2026},
      note={Submitted to Knowledge-Based Systems}
    }
