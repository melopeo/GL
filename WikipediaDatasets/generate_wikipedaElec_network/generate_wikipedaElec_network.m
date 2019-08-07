function generate_wikipedaElec_network

% dir_output = 'generate_wikipedaElec_network';
% if ~exist(dir_output, 'dir')
%     mkdir(dir_output)
% end

% Data format
%    E: did the elector result in promotion (1) or not (0)
%    T: time election was closed
%    U: user id (and screen name) of editor that is being considered for promotion
%    N: user id (and screen name) of the nominator
%    V: vote(1:support, 0:neutral, -1:oppose) user_id time screen_name


wikiElec = read_wikipediaElec;
1;

typeOfInfo = wikiElec(:,1);

idxE          = find(strcmp(typeOfInfo, 'E'));
idxU          = find(strcmp(typeOfInfo, 'U'));
idxV          = find(strcmp(typeOfInfo, 'V'));

numberOfElections = length(idxE);

idxU_userId   = cell2mat(wikiElec(idxU,2));
idxV_userId   = cell2mat(wikiElec(idxV,3));

userId_array   = union(idxU_userId, idxV_userId);
numberOfUsers  = length(userId_array);
largest_userId = max(userId_array);

vArray = [];
uArray = [];
edges  = [];
for i = 1:numberOfElections
    
    idx_start  = idxU(i)+2;
    
    if i < numberOfElections
        idxEnd = idxE(i+1)-1;
    elseif i == numberOfElections
        idxEnd = idxV(end);
    else
        error('something is wrong here')
    end
        
    numVotes   = idxEnd - idx_start + 1;
    
    loc        = ( (idx_start <= idxV).*(idxV <= idxEnd) == 1 );
    vIdxTemp   = idxV( loc );
    
    vArrayTemp = idxU_userId(i)*ones(numVotes,1);
    uArrayTemp = cell2mat( wikiElec(vIdxTemp,3) );
    edgesTemp  = cell2mat( wikiElec(vIdxTemp,2) );
    
    vArray     = [ vArrayTemp; vArray];
    uArray     = [ uArrayTemp; uArray];
    edges      = [ edgesTemp;  edges];
    
end
1;

% the largest userId is larger than the number of users. 
% We need a way to map from userId to nodeId. We use the trick of the following line.
userId_array = sort(userId_array, 'ascend');
vArray       = userId2nodId(vArray, userId_array);
uArray       = userId2nodId(uArray, userId_array);

loc = edges > 0;
Wpos = sparse(vArray(loc),uArray(loc),edges(loc),numberOfUsers,numberOfUsers);
Wpos = sign(Wpos + Wpos');

loc = edges < 0;
Wneg = sparse(vArray(loc),uArray(loc),-edges(loc),numberOfUsers,numberOfUsers);
Wneg = sign(Wneg + Wneg');

1;
nodeId_labels = nan(numberOfUsers,1);
nodeId_labels( userId2nodId( idxU_userId, userId_array ) ) = cell2mat(wikiElec(idxE,2));
nodeId_labels(nodeId_labels == 0) = -1;
nodeId_labels(isnan(nodeId_labels)) = 0;

labels = nodeId_labels;

filename = strcat('wikipedaElec.mat');
save(filename, 'Wpos', 'Wneg', 'labels', '-v7.3')
1;


function nodeId = userId2nodId(userId, userId_idx)
for i = 1:length(userId)
    nodeId(i) = find(userId_idx == userId(i));
end