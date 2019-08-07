function idxMatrix = get_all_label_sets(labels)
1;
num_nodes     = length(labels);
labels_unique = unique(labels);
num_classes   = length(labels_unique);

% get indexes of class nodes
for i = 1:num_classes
   index_per_class{i} = find(labels == labels_unique(i));
end
1;

% get size of each class
size_per_class = cellfun(@length, index_per_class);

% get all posible labels sets, where from each class only one node is taken
idxMatrix_numRows = prod(size_per_class);
idxMatrix_numCols = num_classes;
idxMatrix         = zeros(idxMatrix_numRows, idxMatrix_numCols);

for classIdx = 1:num_classes
    
    if classIdx == 1
        numRepetitions = 1;
    else
        numRepetitions = prod(size_per_class(1:classIdx-1));
    end
    
    vecToRepeat      = get_vecToRepeat(index_per_class, classIdx);
    idxMatrix(:,classIdx) = repmat(vecToRepeat,numRepetitions,1);
end

function vecToRepeat = get_vecToRepeat(index_per_class, classIdx)
    size_per_class = cellfun(@length, index_per_class);
    numClasses     = length(index_per_class);
    
    if classIdx == numClasses
        vecToRepeat = index_per_class{classIdx};
        
    else
        numOfRepetitions = prod(size_per_class(classIdx+1:end));
        vecToRepeat      = [];
        for i = 1:size_per_class(classIdx)
            vecToRepeat = [vecToRepeat; index_per_class{classIdx}(i)*ones(numOfRepetitions,1)];
        end
    end