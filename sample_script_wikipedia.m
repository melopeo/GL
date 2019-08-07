function sample_script_wikipedia
% sample_script_wikipedia
% This shows how experiments of our paper are performed on real world
% signed networks
% Signed Networks considered are:
% - Wikipedia Elections
% - Wikipedia RfA
% - Wikipedia Editor
% Laplacians considered:
% - Laplacian of positive edges
% - Signless Laplacian of negative edges
% - Signed Normalized Laplacian
% - Arithmetic Mean Laplacian
% - Sponge

restoredefaultpath
addpath(genpath('WikipediaDatasets/'))
addpath(genpath('utils/'))
addpath(genpath('Laplacians/'))

dataset_name_cell                      = {'wikipedaElec', 'wikipedaRfA','wikipediaEditor'};
Laplacian_str_cell                     = {'Laplacian_positive', 'SignlessLaplacian_negative', 'signed_normalized_cut', 'arithmetic_mean', 'sponge'};
percentageNodesToAnotatePerClassScalar = 0.01;
numEigenvectors                        = 20;

for l = 1:length(Laplacian_str_cell) % per Laplacian
    Laplacian_str = Laplacian_str_cell{l};

    for m = 1:length(dataset_name_cell) % per dataset

	% load dataset
    dataset_name                        = dataset_name_cell{m};
	[Wpos_orig, Wneg_orig, labels_orig] = load_dataset(dataset_name); 
    [Wpos, Wneg, labels]                = data_preprocessing(Wpos_orig, Wneg_orig, labels_orig, Laplacian_str); % preprocess data

	% randomly choose labeled nodes
    s                                           = RandStream('mcg16807', 'Seed', 0); RandStream.setGlobalStream(s);
    percentageNodesToAnotatePerClass            = percentageNodesToAnotatePerClassScalar*ones(1,2);
    [u,supervised_nodes_idx,nonsupervisedNodes] = set_node_supervision2(labels', percentageNodesToAnotatePerClass); % get node supervision
	labels_of_supervised_nodes                  = labels(supervised_nodes_idx);

    % node classification
    Yout = NCSN_using_diffuse_interface_methods(Wpos, Wneg, supervised_nodes_idx, labels_of_supervised_nodes, Laplacian_str, numEigenvectors);
 
    % performance measures
    trainAccuracy = mean( labels(supervised_nodes_idx) == Yout(supervised_nodes_idx) );
    testAccuracy  = mean( labels(nonsupervisedNodes) == Yout(nonsupervisedNodes) )
    1;
    
    end
end
