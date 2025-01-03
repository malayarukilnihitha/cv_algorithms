function uiqm = UIQM(im)
% Start timing
tic;

im=imread("/home/seaeurov/SEA-UE/INTERNSHIPS-2024/NIHITHA/IMPLEMENTATION/ALGORITHMS/ALL_IMAGES/img_in/1.jpg");
c1 = 0.0282;
c2 = 0.2953;
c3 = 3.5753;

% Call the fusion function 
img = fusion(im);
uicm = UICM(img);
uism = UISM(img);
uiconm = UIConM(img);

uiqm = c1 * uicm + c2 * uism + c3 * uiconm;

% Stop timing
t = toc;
% Display execution time
disp(['Total execution time: ', num2str(t), ' seconds']);

% Get information about memory consumption of variables
variable_info = whos;

% Initialize total memory counter
total_memory = 0;

% Loop through each variable and sum up memory consumption
for i = 1:length(variable_info)
    total_memory = total_memory + variable_info(i).bytes;
end

% Display total memory consumption
disp(['Total memory used by variables: ', num2str(total_memory), ' bytes']);
