function [u,supervisedNodes,nonsupervisedNodes] = set_node_supervision2(C, portionOfNodesToLabel)
% u0 = set_node_supervision(nphase, n)
% INPUT: C                    : ground truth labeling
%      : portionOfNodesToLabel: portion of nodes to label per class


labels          = unique(C);
numberOfClasses = length(labels);
numberOfNodes   = length(C);

nphase          = numberOfClasses;%1/numberOfClasses;
n               = numberOfNodes;
u               = (1/nphase)*ones(n,numberOfClasses);

supervisedNodes = [];

for i = 1:numberOfClasses
    
    label_i     = labels(i);
    population  = find(C == label_i);
    
    k           = floor( portionOfNodesToLabel(i)*length(population) );
    sample      = randsample(population,k);
    
    u(sample,:) = 0;
    u(sample,i) = 1;
    
    supervisedNodes = [supervisedNodes sample];
    
end

supervisedNodes    = supervisedNodes(:);
nonsupervisedNodes = setdiff(1:numberOfNodes, supervisedNodes);
