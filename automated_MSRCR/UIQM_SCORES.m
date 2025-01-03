function UIQM_SCORES(imageDir, outputFileName)
    % Input:
    %   imageDir - Directory containing the images
    %   outputFileName - Name of the output file 
    
    % Get a list of all jpg files in the directory
    imageFiles = dir(fullfile(imageDir, '*.jpg'));
    
    % Open a file to write the UIQM scores
    outputFile = fopen(outputFileName, 'w');
    data_path = '/Users/nihithamalayarukil/Downloads/INTERNSHIPS-2024/NIHITHA/IMPLEMENTATION/ALGORITHMS/Retinex/Retinex-cr/data/';
    config_file = 'config.json';
    % Define the coefficients
    c1 = 0.0282;
    c2 = 0.2953;
    c3 = 3.5753;
    % Loop through each image file
    for k = 1:length(imageFiles)
        try
            % Construct the full file name
            baseFileName = imageFiles(k).name;
            fullFileName = fullfile(imageDir, baseFileName);
     
            % Read the image
            %im = imread(fullFileName);
            fprintf('Processing image: %s\n', baseFileName);
            
            % Call the auto_redchan function to enhance the red channel
            img = test_run(data_path,config_file,baseFileName);
            
            % Compute the UICM, UISM, and UIConM scores
            uicm = UICM(img);
            
            uism = UISM(img);
            uiconm = UIConM(img);
    
            % Display the intermediate results for debugging
            %fprintf('UICM: %.4f, UISM: %.4f, UIConM: %.4f\n', uicm, uism, uiconm);
    
            % Calculate the UIQM score
            uiqm = c1 * uicm + c2 * uism + c3 * uiconm;
    
            % Display the calculated UIQM score for debugging
            fprintf('UIQM score for image %s: %.4f\n', baseFileName, uiqm);
    
            % Write the score to the file
            fprintf(outputFile, 'Image: %s, UIQM score: %.4f\n', baseFileName, uiqm);
        catch ME
            % Display the error message if something goes wrong
            fprintf('Error processing image %s: %s\n', baseFileName, ME.message);
        end
    end
    
    % Close the file
    fclose(outputFile);
    
    disp('UIQM scores have been written to UIQM.txt');
end