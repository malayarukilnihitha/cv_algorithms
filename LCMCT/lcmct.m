function out = lcmct(im,ref)
%%FUNCTION LCMCT
    %RGBtoLAB
    
        global LABcolorTransform;
        global RGBcolorTransform;
        LABcolorTransform = makecform('srgb2lab');
        RGBcolorTransform = makecform('lab2srgb');
        
    
    %Load images(input and ref)
        input_im = im;
        ref_im=ref;	% the old version make a imread
%         ref_im_lab = applycform(im2double(ref_im), LABcolorTransform);
%         input_im_lab = applycform(im2double(input_im), LABcolorTransform);
        ref_im_lab = colorspace('Lab<-RGB', im2double(ref_im));
        input_im_lab = colorspace('Lab<-RGB', im2double(input_im));
    
    %load picked color data and params
        s1 = coder.load('pick_match.mat','picked_rbg','output_rbg');
        s2 = coder.load('params.mat','lambds','w2');

       
    %function calling
        [A,B]=estimate_Ab_matrix_trust_region_method(s1.picked_rbg,s1.output_rbg,input_im_lab,ref_im_lab,s2.lambds(1),s2.lambds(2),s2.lambds(3),s2.w2);  
        AB=[A B];
        result_image=transform_by_color_matrix(AB,input_im);
        
    %result
        out = result_image;
        % Define the file path and name with a unique identifier (timestamp)
        timestamp = datestr(now, 'yyyymmdd_HHMMSS');
        output_name = ['output_image_' timestamp '.jpg'];
        filePath = fullfile('/Users/nihithamalayarukil/Downloads/INTERNSHIPS-2024/NIHITHA/IMPLEMENTATION/lcmct_results', output_name);
        
        % Save the image to the specified location
        imwrite(out, filePath);
        
        % Display the result image
        imshow(out);
end

