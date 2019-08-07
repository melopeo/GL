function [Dgral,Vgral] = get_Laplacian_eigenvectors(Wpos,Wneg,Laplacian_str,maxNumEigVec)

    % eigenvector parameters
    opts.isreal  = 1;
    opts.issym   = 1;

	if strcmp('sponge', Laplacian_str)
		[Vgral,Dgral]    = get_eigenvectors_from_sponge(Wpos,Wneg,maxNumEigVec);
	else
	    % generate Laplacian
	    L                = get_signed_Laplacian(Wpos,Wneg,Laplacian_str); % get Laplacian

	    % get eigenvectors
	    [Vgral,Dgral]    = eigs(L, maxNumEigVec, 'sa', opts);
	end

    % sort eigenvectors and eigenvalues
    dgral                = diag(Dgral);
    [dgral,idxSort]      = sort(dgral, 'ascend');
    Dgral                = diag(dgral);
    Vgral                = Vgral(:, idxSort);
    1;
