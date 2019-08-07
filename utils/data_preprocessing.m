function [Wpos, Wneg, labels] = data_preprocessing(Wpos, Wneg, labels, Laplacian_str)

    % work only with labeled nodes
    idx    = find(labels ~= 0);
    labels = labels(idx);
    Wpos   = Wpos(idx,idx);
    Wneg   = Wneg(idx,idx);
    
    [Wpos, Wneg, labels] = get_largest_connected_component_from_signed_graph(Wpos, Wneg, labels, Laplacian_str);
    
    % sort by labels
    [labels, idxSort] = sort(labels, 'ascend');
    Wpos = Wpos(idxSort, idxSort);
    Wneg = Wneg(idxSort, idxSort);
    
function [Wpos, Wneg, labels] = get_largest_connected_component_from_signed_graph(Wpos, Wneg, labels, Laplacian_str)

    if sum( strcmp(Laplacian_str, {'signed_normalized_cut', 'arithmetic_mean', 'sponge'}) )
        [W_out, loc, connected] = get_largest_component( sign(Wpos + Wneg) );
        Wpos                    = Wpos(loc, loc);
        Wneg                    = Wneg(loc, loc);
        labels                  = labels(loc);

    elseif sum( strcmp(Laplacian_str, {'Laplacian_positive'}) )
        [W_out, loc, connected] = get_largest_component( sign(Wpos) );
        Wpos                    = Wpos(loc, loc);
        labels                  = labels(loc);

    elseif strcmp(Laplacian_str, 'SignlessLaplacian_negative')
        [W_out, loc, connected] = get_largest_component( sign(Wneg) );
        Wneg                    = Wneg(loc, loc);
        labels                  = labels(loc);
        
    else
        error(['Unkown Laplacian'])
    end
    
