function generate_wikipediaEditor_network

[u, v, edge] = read_wikiEditor;

% data format:
% edge: 1 : positive edge
%     : 0 : negative edge

nodeIdIdx     = union(u,v);
numberOfNodes = length(nodeIdIdx);

% network
uNodeId       = get_node_id(u, nodeIdIdx);
vNodeId       = get_node_id(v, nodeIdIdx);
1;

loc  = edge == 1;
Wpos = sparse(uNodeId(loc),vNodeId(loc),edge(loc),numberOfNodes,numberOfNodes);
Wpos = sign(Wpos + Wpos');

loc  = edge == 0;
Wneg = sparse(uNodeId(loc),vNodeId(loc),ones(sum(loc),1),numberOfNodes,numberOfNodes);
Wneg = sign(Wneg + Wneg');

% node labels
[w, nodeLabel]     = read_wikiEditor_labels;
wNodeId            = get_node_id(w, nodeIdIdx);
[wNodeId, idxSort] = sort(wNodeId, 'ascend');
labels             = nodeLabel(idxSort);
labels(labels==0)  = -1;

% save
filename = strcat('wikipediaEditor.mat');
save(filename, 'Wpos', 'Wneg', 'labels', '-v7.3')
1;

function nodId = get_node_id(userNumber, nodeIdIdx)

nodId = nan(length(userNumber),1);
for i = 1:length(userNumber)
    nodId(i) = find(userNumber(i) == nodeIdIdx);
end