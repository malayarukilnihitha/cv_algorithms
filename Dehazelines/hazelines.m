function out = hazelines(im)

	%% Set paths, clear variables
	

	% https://github.com/pdollar/toolbox
	toolbox_path = fullfile('utils', 'toolbox');
	% https://github.com/pdollar/edges
	edges_path = fullfile('utils', 'edges');

	addpath('utils')
	addpath(edges_path)
	addpath(genpath(toolbox_path))
	

	% Suppress Warning regarding image size
	warning('off', 'Images:initSize:adjustingMag');
	feature('DefaultCharacterSet', 'UTF8');


	% A few example input images are saves in this sub-directory. 
	%images_dir = 'images';
	
	verbose = false;    % Whether to print and save verbose details.
	max_width = 2010;   % Maximum image width - larger images will be resized.

	
		
	[img_out, trans_out, A, estimated_water_type] = uw_restoration(...
	    im, edges_path, max_width,verbose);
	
	%result image
	out = im2uint8(img_out);
    imshow(out);
            
end     



