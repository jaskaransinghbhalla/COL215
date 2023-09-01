image_filename = "sample_test_image.png";
image_matrix = imread(image_filename);
matrix=zeros(256,256);
%imshow(image_matrix);
disp(image_matrix(5,5));
for i=1:256
  for j=2:256
    if j==256
     % image_matrix(i,j+1)=0;
      matrix(i,j)=image_matrix(i,j-1)-2*image_matrix(i,j);
    elseif j==1
      matrix(i,j)=image_matrix(i,j+1)-2*image_matrix(i,j);
      else
    matrix(i,j)=image_matrix(i,j-1)-2*image_matrix(i,j)+image_matrix(i,j+1);
    end
    if matrix(i,j)<0
      matrix(i,j)=0;
      end
  endfor
 endfor
image_matrix=matrix;
imshow(image_matrix);