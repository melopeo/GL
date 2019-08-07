function [eigVecs,eigVals] = get_eigenvectors_from_sponge(Wpos,Wneg,numEigenVectors)
% [eigVecs,eigVals] = spectral_clustering_with_sponge(Wpos,Wneg,numClusters)
% Get eigenpairs of SPONGE
% INPUT : Wpos:        positive adjacency matrix
%       : Wneg:        negative adjacency matrix
%       : numEigenVectors: number of eigenpairs to compute
% OUTPUT: eigVecs : matrix with eigenvectors
% OUTPUT: eigVals : matrix with eigenvalues

% Reference:
% @InProceedings{pmlr-v89-cucuringu19a,
%   title = 	 {SPONGE: A generalized eigenproblem for clustering signed networks},
%   author = 	 {Cucuringu, Mihai and Davies, Peter and Glielmo, Aldo and Tyagi, Hemant},
%   booktitle = 	 {Proceedings of Machine Learning Research},
%   pages = 	 {1088--1098},
%   year = 	 {2019},
%   editor = 	 {Chaudhuri, Kamalika and Sugiyama, Masashi},
%   volume = 	 {89},
%   series = 	 {Proceedings of Machine Learning Research},
%   address = 	 {},
%   month = 	 {16--18 Apr},
%   publisher = 	 {PMLR},
%   pdf = 	 {http://proceedings.mlr.press/v89/cucuringu19a/cucuringu19a.pdf},
%   url = 	 {http://proceedings.mlr.press/v89/cucuringu19a.html},
% }

n    = size(Wpos,1);
Lpos = build_laplacian_matrix(Wpos);
Lneg = build_laplacian_matrix(Wneg);

% extract eigenvectors
% opts.issym        = 1;
opts.isreal       = 1;
[eigVecs,eigVals] = eigs(Lpos+speye(n),Lneg+speye(n),numEigenVectors,'sa', opts);


