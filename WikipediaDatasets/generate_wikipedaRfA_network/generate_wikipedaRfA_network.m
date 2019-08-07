function generate_wikipedaRfA_network

% dir_output = 'generate_wikipedaRfA_network';
% if ~exist(dir_output, 'dir')
%     mkdir(dir_output)
% end

% Data format
% SRC: user name of source, i.e., voter
% TGT: user name of target, i.e., the user running for election
% VOT: the source's vote on the target (-1 = oppose; 0 = neutral; 1 = support)
% RES: the outcome of the election (-1 = target was rejected as admin; 1 = target was accepted)
% YEA: the year in which the election was started
% DAT: the date and time of this vote
% TXT: the comment written by the source, in wiki markup


rfaall = read_wikipediaRfA;
1;
data            = rfaall(:,1);
numberOfActions = length(data)/7;

src       = data(1:7:end);
tgt       = data(2:7:end);
vot       = data(3:7:end);
res       = data(4:7:end);
data_cell = {src, tgt, vot, res};

% % % % Preprocess data

% get rid of first 3 characters
src = get_rid_of_first_characters(src);
tgt = get_rid_of_first_characters(tgt);
vot = get_rid_of_first_characters(vot);
res = get_rid_of_first_characters(res);

% for i = 1:length(data_cell)
%     data_cell{i} = get_rid_of_first_characters(data_cell{i});
% end

% transform vot and res to numerical
vot = cell_str2num(vot);
res = cell_str2num(res);

% total users
userId = union(src,tgt);
% userId = union(idx{1}, idx{2});

% total number of users
totalNumberOfUsers = length(userId);

% build network
nodeU = userId2nodId(src, userId);
nodeV = userId2nodId(tgt, userId);
edge  = cell2mat(vot);

loc  = edge > 0;
Wpos = sparse(nodeU(loc),nodeV(loc),edge(loc),totalNumberOfUsers,totalNumberOfUsers);
Wpos = sign(Wpos + Wpos');

loc  = edge < 0;
Wneg = sparse(nodeU(loc),nodeV(loc),-edge(loc),totalNumberOfUsers,totalNumberOfUsers);
Wneg = sign(Wneg + Wneg');
1;

% node labels
nodeLabel = zeros(totalNumberOfUsers,1);
nodeLabel( nodeV ) = cell2mat(res);
1;

labels = nodeLabel;

filename = strcat('wikipedaRfA.mat');
save(filename, 'Wpos', 'Wneg', 'labels', '-v7.3')








function out = get_rid_of_first_characters(in)
out = cellfun(@(x) x(5:end), in,'UniformOutput', false);

function out = cell_str2num(in)
out = cellfun(@(x) str2num(x), in,'UniformOutput', false);

function nodeId = userId2nodId(userId, userId_idx)
for i = 1:length(userId)
    nodeId(i) = find(strcmp(userId_idx,userId{i}));
end

% % identify guys who never voted
% idx_who_never_voted = [];
% idx_src = idx{1};
% for i = 1:length(idx_src)
%     idx_src_i = idx_src(i,:);
%     loc       = strcmp(data_cell{1}, idx_src_i);
%     vot_i     = data_cell{3}(loc);
%     vot_i     = cell2mat(vot_i);
%     
%     if sum(vot_i == 0) == length(vot_i)
%         idx_who_never_voted = [idx_who_never_voted i];
%     end
% end
% 1;
