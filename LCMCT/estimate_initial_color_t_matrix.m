function T = estimate_initial_color_t_matrix(r_out,g_out,b_out,r_in,g_in,b_in,lamda)
%%FUNCTION ESTIMATE_INITIAL

out_points = [r_out' ; g_out' ; b_out'];
A= zeros(size(r_in,1),12);

for i = 1:size(r_in,1)
  off = (i-1) * 3;

  rgb1 = [r_in(i) g_in(i) b_in(i)];

  A( off + 1, 1:3 ) = rgb1;
  A( off + 1, 10:12 ) = [1 0 0];
  A( off + 2, 4:6 ) = rgb1;
  A( off + 2, 10:12 ) = [0 1 0];
  A( off + 3, 7:9 ) = rgb1;
  A( off + 3, 10:12 ) = [0 0 1];

  
end

out_points = out_points(:);


T = (A'*A + eye(12)*lamda)^(-1)*A'*out_points(:);
T = [reshape(T(1:9,:),[3 3])' T(10:12)];

end
