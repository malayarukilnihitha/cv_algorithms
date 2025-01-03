function img_amsrcr = test_run(data_path, config_file, img_name)

    % Read the configuration from JSON
    fid = fopen(config_file);
    if fid == -1
        error('Cannot open configuration file.');
    end
    raw = fread(fid, inf);
    str = char(raw');
    fclose(fid);
    config = jsondecode(str);

    % Import retinex functions from Python
    retinex = py.importlib.import_module('retinex');

    % Read the image using MATLAB's imread function
    img = imread(fullfile(data_path, img_name));

    % Convert the image to uint8 if it's not already
    if ~isa(img, 'uint8')
        img = uint8(img);
    end

    % Convert the image to Python format
    img_py = py.numpy.array(img);

    % Apply automated MSRCR
    img_amsrcr_py = retinex.automatedMSRCR(img_py, py.list(config.sigma_list));
    img_amsrcr = uint8(img_amsrcr_py);
end


    
