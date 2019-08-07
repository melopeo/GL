## Node Classification for Signed Social Networks Using Diffuse Interface Methods

MATLAB implementation of the paper:

[P. Mercado, J. Bosch, and M. Stoll, Node Classification for Signed Social Networks Using Diffuse Interface Methods. In ECMLPKDD 2019.](https://arxiv.org/abs/1809.06432)

## Content:
- `example.m` : contains an easy example showing how to use the code

- `sample_script_wikipedia.m` : example on how to use our approach on Wikipedia Datasets from our [paper](https://arxiv.org/abs/1809.06432)

## Usage:
Let `Wpos,Wneg` be adjacency matrices of positive and negative graphs, `supervised_nodes_idx` an array with indexes of labeled nodes, `labels_of_supervised_nodes` an array with the corresponding labels, `Laplacian_str` a string indicating wich signed Laplacian to use, and `numEigenvectors` a scalar indicating how many eigenvectors to take. 

Node Classification for signed graphs via diffuse interface methods is performed via:
```
Y_hat = NCSN_using_diffuse_interface_methods(Wpos, Wneg, supervised_nodes_idx, labels_of_supervised_nodes, Laplacian_str, numEigenvectors);
```

## Citation:
```
@InProceedings{Mercado:2019:ecmlpkdd,
author="Mercado, Pedro and Bosch, Jessica and Stoll, Martin"
title="Node Classification for Signed Social Networks Using Diffuse Interface Methods",
booktitle="ECMLPKDD",
year="2019",
}
