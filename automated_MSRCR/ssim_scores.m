function ssim_scores(imageDir, outputFileName)
    % Input:
    %   imageDir - Directory containing the images
    %   outputFileName - Name of the output file 
    
    % Get a list of all jpg files in the directory
    imageFiles = dir(fullfile(imageDir, '*.jpg'));
    
    % Open a file to write the UIQM scores
    outputFile = fopen(outputFileName, 'w');
    data_path = '/Users/nihithamalayarukil/Downloads/INTERNSHIPS-2024/NIHITHA/IMPLEMENTATION/ALGORITHMS/Retinex/Retinex-cr/data/';
    config_file = 'config.json';
    % Loop through each image file
    for k = 1:length(imageFiles)
        try
            % Construct the full file name
            baseFileName = imageFiles(k).name;
            fullFileName = fullfile(imageDir, baseFileName);
    
            % Read the image
            im = imread(fullFileName);
            fprintf('Processing image: %s\n', baseFileName);
    
            % Call the auto_redchan function to enhance the red channel
            A = test_run(data_path,config_file,baseFileName);
            
            % Compute PSNR score
            ssim_score = ssim(A, im);
            disp(['ssim score of the image: ', num2str(ssim_score)]);
    
            fprintf('ssim score for image %s: %.4f\n', baseFileName, ssim_score);
    
            % Write the score to the file
            fprintf(outputFile, ' %.4f\n', ssim_score);
        catch ME
            % Display the error message if something goes wrong
            fprintf('Error processing image %s: %s\n', baseFileName, ME.message);
        end
    end
    
    % Close the file
    fclose(outputFile);
    
    disp('ssim scores have been written to ssim.txt');
end