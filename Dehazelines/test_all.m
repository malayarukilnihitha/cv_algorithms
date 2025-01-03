% Define the directory containing your images
image_directory = '/home/seaeurov/SEA-UE/INTERNSHIPS-2024/NIHITHA/IMPLEMENTATION/ALGORITHMS/ALL_IMAGES/all/';

% Get a list of all image files in the directory
image_files = dir(fullfile(image_directory, '*.jpg'));

% Initialize arrays to store execution times and memory consumption for each image
execution_times = zeros(1, numel(image_files));
memory_consumptions = zeros(1, numel(image_files));

% Loop through each image file
for i = 1:numel(image_files)
    % Start timing
    tic;
    
    % Read the image
    im = imread(fullfile(image_directory, image_files(i).name));
    
    % Call the auto_redchan function to enhance the red channel
    img = hazelines(im);
    
    % Stop timing
    t = toc;
    
    % Record execution time
    execution_times(i) = t;
    
    % Get information about memory consumption of variables
    variable_info = whos;
    
    % Initialize total memory counter
    total_memory = 0;
    
    % Loop through each variable and sum up memory consumption
    for j = 1:length(variable_info)
        total_memory = total_memory + variable_info(j).bytes;
    end
    
    % Record total memory consumption
    memory_consumptions(i) = total_memory;
    
    % Display execution time and memory consumption for the current image
    disp(['Image ', num2str(i), ':']);
    disp(['Execution time: ', num2str(t), ' seconds']);
    disp(['Memory used by variables: ', num2str(total_memory), ' bytes']);
end

% Display average execution time and memory consumption across all images
disp(['Average execution time: ', num2str(mean(execution_times)), ' seconds']);
disp(['Average memory used by variables: ', num2str(mean(memory_consumptions)), ' bytes']);