function example

restoredefaultpath
addpath(genpath('utils/'))
addpath(genpath('Laplacians/'))

% % % % % % % first generate a random signed graph
numLayers                     = 2;
numNodes                      = 100;
numClusters                   = 2;
groundTruth                   = zeros(numNodes,1);
groundTruth(1:numNodes/2)     = 1;
groundTruth(numNodes/2+1:end) = 2;
labels                        = groundTruth;
GroundTruthPerLayerCell       = {groundTruth, groundTruth};
pinVec                        = [0.6 0.4];
poutVec                       = [0.4 0.6];
s                             = RandStream('mcg16807','Seed',0); RandStream.setGlobalStream(s);
Wcell                         = generate_multilayer_graph(numLayers, GroundTruthPerLayerCell, pinVec, poutVec);
Wpos                          = Wcell{1};
Wneg                          = Wcell{2};
numEigenvectors               = 1;

% visualize adjacency matrices
figure, hold on
subplot(1,2,1), spy(Wcell{1}), title('Positive Edges')
subplot(1,2,2), spy(Wcell{2}), title('Negative Edges')

% % % % % % % now randomly choose nodes to be labeled
percentageNodesToAnotatePerClassScalar      = 0.05;
s                                           = RandStream('mcg16807', 'Seed', 0); RandStream.setGlobalStream(s);
percentageNodesToAnotatePerClass            = percentageNodesToAnotatePerClassScalar*ones(1,2);
[u,supervised_nodes_idx,nonsupervisedNodes] = set_node_supervision2(labels', percentageNodesToAnotatePerClass); % get node supervision
labels_of_supervised_nodes                  = labels(supervised_nodes_idx);

% % % % % % % node classification
% with signed normalized Laplacian
Laplacian_str = 'signed_normalized_cut';
Yout          = NCSN_using_diffuse_interface_methods(Wpos, Wneg, supervised_nodes_idx, labels_of_supervised_nodes, Laplacian_str, numEigenvectors);
trainAccuracy = mean( labels(supervised_nodes_idx) == Yout(supervised_nodes_idx) );
testAccuracy  = mean( labels(nonsupervisedNodes) == Yout(nonsupervisedNodes) )
1;

% with arithmetic mean of Laplacians
Laplacian_str = 'arithmetic_mean';
Yout          = NCSN_using_diffuse_interface_methods(Wpos, Wneg, supervised_nodes_idx, labels_of_supervised_nodes, Laplacian_str, numEigenvectors);
trainAccuracy = mean( labels(supervised_nodes_idx) == Yout(supervised_nodes_idx) );
testAccuracy  = mean( labels(nonsupervisedNodes) == Yout(nonsupervisedNodes) )
1;

% with sponge
Laplacian_str = 'sponge';
Yout          = NCSN_using_diffuse_interface_methods(Wpos, Wneg, supervised_nodes_idx, labels_of_supervised_nodes, Laplacian_str, numEigenvectors);
trainAccuracy = mean( labels(supervised_nodes_idx) == Yout(supervised_nodes_idx) );
testAccuracy  = mean( labels(nonsupervisedNodes) == Yout(nonsupervisedNodes) )
1;