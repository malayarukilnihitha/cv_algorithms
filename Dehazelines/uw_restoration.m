function [img_out, trans_out, A, estimated_water_type] = uw_restoration(...
    img_name, edges_path, max_width, verbose)


%% Method params
fid = fopen('TR500.txt', 'r');
uwhl_params.points = cell2mat(textscan(fid,'%f %f %f')) ;
fclose(fid);
uwhl_params.trans_min = 0.01;

% Attenuation coefficient (beta) ratios to test.
[beta_BG_pair, beta_BR_pair, n_iters, water_types] = get_water_types('peak');

%% Image specific handling

% sRGB images do not require special conversion.
img_in = im2double(img_name);
% Contrast stretch, to obtain a better dynamic range.
img_in = adjust_contrast(img_in, 1, 3);

%image size
[h, w, ~] = size(img_in);



resolution_str = [num2str(h), '_', num2str(w)];
mask = true(h,w);


% Prepare dir prefixes and output cell array.
if verbose
    % Verbose results will be saved in this directory, e.g. restoration results 
    % using all water types, and veiling-light.
    %result_dir_verbose = fullfile(result_dir, 'all');
    %if ~exist(result_dir_verbose,'dir'), mkdir(result_dir_verbose); end
    %save_dir_verbose = fullfile(result_dir_verbose, [image_name, '_']);
else
    save_dir_verbose = '';
end
corrected = cell(1, n_iters);


img_in_rgb = img_in;


% Estimate veiling-light (value + textureless map).
[A, uwhl_params.textureless] = estimate_veiling_light(img_in, img_in_rgb, ...
    edges_path, verbose, save_dir_verbose);

% Quality measure - define helper func and binary mask to measure how
% much the image adheres to the Gray-World assumption.
gray_world_dev = @(x) std(mean(x, 1));
not_sky_map = ~uwhl_params.textureless;



% Iterate over different water types (i.e. different attenuation coeffs).
array_uwhl_params = cell(n_iters,1);
for var = 1:n_iters
    array_uwhl_params{var} = uwhl_params;
end
array_uwhl_params = [array_uwhl_params{:}];

for i_water_type = 1:n_iters
    if verbose, disp(['Iter #',num2str(i_water_type)]); end
    array_uwhl_params(i_water_type).betaBR = beta_BR_pair(i_water_type);
    array_uwhl_params(i_water_type).betaBG = beta_BG_pair(i_water_type);
    
    % Restore the colors, assuming a particular water type.
    [out_img, out_trans] = uw_restoration_type(img_in, A, array_uwhl_params(i_water_type), mask);
    
    img_adj = adjust_contrast(out_img, 1, 5, [0.001, 0.999], 0.8);
    
    % Save the restored image and the transmission (per water type).
    if verbose
        file_suffix = ['_beta_', ...
            strrep(['BR',num2str(uwhl_params.betaBR,'%1.2f'), ...
            '_BG',num2str(uwhl_params.betaBG,'%1.2f')],'.','-')];
        img_file_suffix = [save_dir_verbose, 'UWHL_img', file_suffix];
        imwrite(im2uint8(img_adj), [img_file_suffix, '.jpg']);
        transfile_suffix = strrep(img_file_suffix, 'img', 'trans');
        imwrite(im2uint8(out_trans), jet(256), [transfile_suffix, '.jpg']);
    end
        
    % Update output cell array.
    corrected{i_water_type}.trans = out_trans;
    corrected{i_water_type}.out_img = out_img;
    corrected{i_water_type}.out_img_adj = img_adj;
    
    % Measure restoration quality (will be used for comparison between
    % water types later)
    not_sky_pixels = reshape(img_adj(repmat(not_sky_map, [1,1,3])), [], 3);
    corrected{i_water_type}.gw_notsky = gray_world_dev(not_sky_pixels);
    
end  % Loop: iterations on beta ratios

% Quality measure to estimate the best water type
vals = cellfun( @(x) x.gw_notsky, corrected);
[~, idx_sorted] = sort(vals, 'ascend');
% Do not take into consideration beta ratios that their water
% transmission is too high. Specifically, require the RED transmission
% average to be larger by 0.1 on objects than in water.
get_trans_r = @(x) mean(x.trans(not_sky_map)) - mean(x.trans(~not_sky_map));
trans_r_all_beta = cellfun(get_trans_r, corrected);
trans_diff_thres = 0.1;
idx_to_erase = find(trans_r_all_beta < trans_diff_thres);
 while( length(idx_to_erase) == length(trans_r_all_beta))
     trans_diff_thres = trans_diff_thres*0.5;
     idx_to_erase = find(trans_r_all_beta < trans_diff_thres);
     if trans_diff_thres ~= 0
         disp(trans_diff_thres);
     end
     
 end
idx_sorted = setdiff(idx_sorted, idx_to_erase, 'stable');

% The output is the first index after sorting.
selected_idx = idx_sorted(1);
if verbose
    disp(['Estimated water type is: ', water_types{selected_idx}])
end

% Set the output variables
estimated_water_type = water_types{selected_idx};
img_out = corrected{selected_idx}.out_img_adj;
trans_out = corrected{selected_idx}.trans;
