function time_memory(imageDir, outputFile)
    % Inputs:
    %   imageDir - Directory containing the images
    %   outputFile - Name of the output file to write the results

    % Get a list of all jpg files in the directory
    imageFiles = dir(fullfile(imageDir, '*.jpg'));
    data_path = '/Users/nihithamalayarukil/Downloads/INTERNSHIPS-2024/NIHITHA/IMPLEMENTATION/ALGORITHMS/Retinex/Retinex-cr/data/';
    config_file = 'config.json';
    % Open the file for writing
    fid = fopen(outputFile, 'w');
    
    % Write header
    fprintf(fid, '---------------------------------------------------------\n');
    fprintf(fid, '%-20s\t%-15s\t%-20s\n', 'Input Image', 'Time (s)', 'Memory (MB)');
    fprintf(fid, '---------------------------------------------------------\n');
    
    % Loop through each image file
    for k = 1:length(imageFiles)
        try
            % Construct the full file name
            baseFileName = imageFiles(k).name;
            fullFileName = fullfile(imageDir, baseFileName);

            % Extract the file name without path
            [~, imageName, ext] = fileparts(fullFileName);
            fileName = [imageName, ext];

            % Start timing
            tic;
            
            % Read the image
            %im = imread(fullFileName);
            
            % Call the fusion function to enhance the image
            img = test_run(data_path,config_file,baseFileName);
            
            % Stop timing
            execution_time = toc;

            % Get information about memory consumption of variables
            variable_info = whos;

            % Initialize total memory counter
            total_memory = 0;

            % Loop through each variable and sum up memory consumption
            for i = 1:length(variable_info)
                total_memory = total_memory + variable_info(i).bytes;
            end

            % Convert total memory consumption to megabytes
            total_memory_mb = total_memory / (1024^2); % Convert bytes to megabytes

            % Display execution time and memory usage
            disp(['Processing image: ', fileName]);
            disp(['Total execution time: ', num2str(execution_time), ' seconds']);
            disp(['Total memory used by variables: ', num2str(total_memory_mb), ' MB']);

            % Write data to the file
            fprintf(fid, '%-20s\t%-15.4f\t%-20.4f\n', fileName, execution_time, total_memory_mb);
        catch ME
            % Display the error message if something goes wrong
            fprintf('Error processing image %s: %s\n', baseFileName, ME.message);
        end
    end

    % Close the file
    fclose(fid);

    disp(['Data saved to ', outputFile]);
end

