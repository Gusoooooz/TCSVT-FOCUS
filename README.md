## Fast Multiview Co-Clustering in Unified Subspace

In this paper, we proposed a novel multiview co-clustering method named FOCUS, which achieves discrete label decoupling to avoid reliance on post-processing. Specifically, unsupervised feature embedding is conducted with the principle of information loss minimization, which ensures the sparsity and validity of common representations. Additionally, the coupling matrix is relaxed to unconstrained for flexible approximation in the enhanced version.

## Operation Instruction

To demonstrate the performance of our method on the real-world dataset, please run the program named "demo.m". Moreover, the optimization details of FOCUS1 and FOCUS2 are included in 'main1.m' function and 'main2.m' function, respectively.

## Initialization Discussion

We noted that the self-decoupling strategy inevitably makes performance sensitive to initialization. For reproducibility, we have shared the initial matrix (corresponding to the results in Table V) in the "Initial" file. Additionally, for stability, we recommend adopting an initialization strategy named nearest neighbor hierarchical initialization (N2HI), and relevant studies can be found in the following papers.

    @ARTICLE{11003403,
      author={Xie, Fangyuan and Xue, Jingjing and Nie, Feiping and Yu, Weizhong and Li, Xuelong},
      journal={IEEE Transactions on Knowledge and Data Engineering}, 
      title={Fast Anchor Graph Clustering via Maximizing Within-Cluster Similarity}, 
      year={2025},
      volume={37},
      number={8},
      pages={4591-4603},
      doi={10.1109/TKDE.2025.3569777}
    }

    @ARTICLE{10132543,
      author={Nie, Feiping and Lu, Jitao and Wu, Danyang and Wang, Rong and Li, Xuelong},
      journal={IEEE Transactions on Pattern Analysis and Machine Intelligence}, 
      title={A Novel Normalized-Cut Solver With Nearest Neighbor Hierarchical Initialization}, 
      year={2024},
      volume={46},
      number={1},
      pages={659-666},
      doi={10.1109/TPAMI.2023.3279394}
    }

## Citation

We appreciate it if you cite the following paper:

    @ARTICLE{FOCUS,
      author={Guo, Shengzhao and Ma, Zhenyu and Wang, Jingyu and Nie, Feiping and Li, Xuelong},
      journal={IEEE Transactions on Circuits and Systems for Video Technology}, 
      title={Fast Multiview Co-Clustering in Unified Subspace}, 
      year={2025},
      doi={10.1109/TCSVT.2025.3613381}
    }

## Contact

If you have any questions, feel free to contact me. (Email: gusoz\@mail.nwpu.edu.cn)
