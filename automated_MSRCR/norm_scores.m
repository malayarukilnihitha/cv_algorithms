function norm_scores(imageDir, outputFileName)
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
    
            
            img =test_run(data_path,config_file,baseFileName);
            
            Im1_ = rgb2gray(img);
            Im2 = rgb2gray(im);
            
            hn1 = imhist(Im1_)./numel(Im1_);
            hn2 = imhist(Im2)./numel(Im2);
            
            % Calculate the Euclidean distance
            f = norm(hn1-hn2);
            disp(['Euclidean distance of the image: ', num2str(f)]);
    
            fprintf('norm score for image %s: %.4f\n', baseFileName, f);
    
            % Write the score to the file
            fprintf(outputFile, ' %.4f\n',  f);
        catch ME
            % Display the error message if something goes wrong
            fprintf('Error processing image %s: %s\n', baseFileName, ME.message);
        end
    end
    
    % Close the file
    fclose(outputFile);
end
