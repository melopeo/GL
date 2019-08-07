function [u, class_mapping] = set_node_supervision_given_node_ids(numberOfNodes, supervised_nodes_idx,labels_of_supervised_nodes)

C                       = labels_of_supervised_nodes;
labels                  = unique(C);
numberOfClasses         = length(labels);
numberOfSupervisedNodes = length(C); 
 
nphase          = numberOfClasses;%1/numberOfClasses;
n               = numberOfNodes;
u               = (1/nphase)*ones(n,numberOfClasses);

for i = 1:numberOfClasses
    class_mapping(i) = labels(i);
end

for i = 1:numberOfSupervisedNodes
    node_id                       = supervised_nodes_idx(i);
    node_label                    = C(i);
    node_label_mapping            = find(class_mapping == node_label);
    u(node_id,:)                  = 0;
    u(node_id, node_label_mapping) = 1;
end
    
    

