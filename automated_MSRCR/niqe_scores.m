function niqe_scores(imageDir, outputFileName)
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
            %im = imread(fullFileName);
            fprintf('Processing image: %s\n', baseFileName);
    
            % Call the auto_redchan function to enhance
            img =test_run(data_path,config_file,baseFileName);
    
            
            % Convert the image to grayscale if it's in RGB
            if size(img, 3) == 3
                img = rgb2gray(img);
            end
            
            % Compute BRISQUE score
            niqe_score = niqe(img);
            disp(['niqe score of the image: ', num2str(niqe_score)]);
    
            fprintf('niqe score for image %s: %.4f\n', baseFileName, niqe_score);
    
            % Write the score to the file
            fprintf(outputFile, ' %.4f\n',  niqe_score);
        catch ME
            % Display the error message if something goes wrong
            fprintf('Error processing image %s: %s\n', baseFileName, ME.message);
        end
    end
    
    % Close the file
    fclose(outputFile);
    
    disp('niqe scores have been written to niqe.txt');
end
