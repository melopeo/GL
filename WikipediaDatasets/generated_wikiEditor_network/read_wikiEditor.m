function [VarName1, VarName2, VarName3] = read_wikiEditor
%% Import data from text file.
% Script for importing data from the following text file:
%
%    /home/administrator/Desktop/WikipediaExperiments/SignedNetworks-master-0caa78654921f3a5865ebccd41dfa1695c1d0898/code/data/WikipediaDatasets/generated_wikiEditor_network/wiki_edit.txt
%
% To extend the code to different selected data or a different text file,
% generate a function instead of a script.

% Auto-generated by MATLAB on 2017/12/18 18:43:03

%% Initialize variables.
filename = '/home/administrator/Desktop/WikipediaExperiments/SignedNetworks-master-0caa78654921f3a5865ebccd41dfa1695c1d0898/code/data/WikipediaDatasets/generated_wikiEditor_network/wiki_edit.txt';
delimiter = '\t';

%% Format for each line of text:
%   column1: double (%f)
%	column2: double (%f)
%   column3: double (%f)
% For more information, see the TEXTSCAN documentation.
formatSpec = '%f%f%f%[^\n\r]';

%% Open the text file.
fileID = fopen(filename,'r');

%% Read columns of data according to the format.
% This call is based on the structure of the file used to generate this
% code. If an error occurs for a different file, try regenerating the code
% from the Import Tool.
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'EmptyValue' ,NaN, 'ReturnOnError', false);

%% Close the text file.
fclose(fileID);

%% Post processing for unimportable data.
% No unimportable data rules were applied during the import, so no post
% processing code is included. To generate code which works for
% unimportable data, select unimportable cells in a file and regenerate the
% script.

%% Allocate imported array to column variable names
VarName1 = dataArray{:, 1};
VarName2 = dataArray{:, 2};
VarName3 = dataArray{:, 3};


%% Clear temporary variables
clearvars filename delimiter formatSpec fileID dataArray ans;