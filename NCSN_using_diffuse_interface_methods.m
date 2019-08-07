function Yout = NCSN_using_diffuse_interface_methods(Wpos, Wneg, supervised_nodes_idx, labels_of_supervised_nodes, Laplacian_str, numEigenvectors)
% Y = NCSN_using_diffuse_interface_methods(Wpos, Wneg, Laplacian_str, supervised_nodes_idx, labels_of_supervised_nodes, potential_str)
% Performs Node Classification for Signed Networks using diffuse interface
% methods
% INPUT: Wpos : adjacency matrix of positive edges
%      : Wneg : adjacency matrix of negative edges
%      : Laplacian_str : string indicating which signed Laplacian to use.
%               Options are:
%               'Laplacian_positive':         for Laplacian on positive edges, 
%               'SignlessLaplacian_negative': for signless Laplacian on negative edges, 
%               'signed_normalized_cut':      for signed normalized Laplacian on signed graph,
%               'arithmetic_mean':            for arithmetic mean of Laplacians on signed graph
%               'sponge':                     for SPONGE Laplacian
%      : supervised_nodes_idx :       array with indexes of labeled nodes
%      : labels_of_supervised_nodes : labels of labeled nodes
%      : numEigenvectors :            number of Laplacian eigenvectors to use
%      (default: equal to number of classes)
% 
% Reference:
% @InProceedings{Mercado:2019:ecmlpkdd,
% author="Mercado, Pedro and Bosch, Jessica and Stoll, Martin"
% title="Node Classification for Signed Social Networks Using Diffuse Interface Methods",
% booktitle="ECMLPKDD",
% year="2019",
% }

% set (non) smooth potential parameters
omega_0   = 10^3;
epsilon   = 10^(-1);
dt        = 0.1;
MAX_ITER  = 2000;
tolit     = 10.^(-6);
c         = (3/epsilon)+omega_0;
1;

if nargin < 5
    Laplacian_str = 'arithmetic_mean';
end

if nargin < 6
    numEigenvectors = length(unique(labels_of_supervised_nodes));
end

numberOfNodes = size(Wpos,1);

[D,V]              = get_Laplacian_eigenvectors(Wpos,Wneg,Laplacian_str,numEigenvectors);
[u, class_mapping] = set_node_supervision_given_node_ids(numberOfNodes, supervised_nodes_idx,labels_of_supervised_nodes);

Y = classification_with_smooth_potential(u, D, V,omega_0,epsilon,dt,c,MAX_ITER,tolit); 

%map labels to original value
Yout = inf(size(Y));
for i = 1:length(class_mapping)
    loc       = Y == i;
    Yout(loc) = class_mapping(i);
end
Yout(supervised_nodes_idx) = labels_of_supervised_nodes;
