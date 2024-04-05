function detected_regions = wszystkie_kolory_new(img)

% Wczytaj obraz
% img = imread('zdjecia/z1.jpg');

xr=img(:,:,1);
xg=img(:,:,2);
xb=img(:,:,3);

alfa=0.8;
beta=1;
gamma=1.2;

dark_blue_threshold = 40;

[height, width]=size(img(:,:,1)); 
blueMask=zeros(height,width);

for i=1:height
    for j=1:width
        if((xb(i,j)/xg(i,j)>alfa) && (xb(i,j)/xr(i,j)>beta) && (xg(i,j)/xr(i,j)>gamma) && ...
                ((xb(i,j)/xr(i,j)>1.2*alfa) && (xb(i,j)/xg(i,j)>1.2*beta)) && (xb(i,j) > dark_blue_threshold))
          blueMask(i,j)=1;   
        end
    end
end

% Przekształć obraz do przestrzeni kolorów HSV
hsv_img = rgb2hsv(img);

% Określ zakres barw czerwonej
lower_red = [0.9, 0.2, 0.2];
upper_red = [1, 1, 1];

% Zastosuj progowanie na podstawie zakresu barw czerwonej
redMask1 = (hsv_img(:,:,1) >= lower_red(1) & hsv_img(:,:,1) <= upper_red(1) & ...
              hsv_img(:,:,2) >= lower_red(2) & hsv_img(:,:,2) <= upper_red(2) & ...
              hsv_img(:,:,3) >= lower_red(3) & hsv_img(:,:,3) <= upper_red(3));

% Określ zakres barw czerwonej (zawierający jaśniejsze odcienie)
lower_red = [0, 0.2, 0.2];
upper_red = [0.05, 1, 1];

% Zastosuj progowanie na podstawie zakresu barw czerwonej
redMask2 = (hsv_img(:,:,1) >= lower_red(1) & hsv_img(:,:,1) <= upper_red(1) & ...
              hsv_img(:,:,2) >= lower_red(2) & hsv_img(:,:,2) <= upper_red(2) & ...
              hsv_img(:,:,3) >= lower_red(3) & hsv_img(:,:,3) <= upper_red(3));



lower_yellow = [0.1, 0.2, 0.6];
upper_yellow = [0.2, 1, 1];

% Utwórz maskę dla obszarów żółtych
yellowMask = (hsv_img(:,:,1) >= lower_yellow(1)) & (hsv_img(:,:,1) <= upper_yellow(1)) & ...
              (hsv_img(:,:,2) >= lower_yellow(2)) & (hsv_img(:,:,2) <= upper_yellow(2)) & ...
              (hsv_img(:,:,3) >= lower_yellow(3)) & (hsv_img(:,:,3) <= upper_yellow(3));


lower_orange = [0.05, 0.4, 0.5];
upper_orange = [0.15, 1, 1];

% Tworzenie maski binarnej dla koloru pomarańczowego
orange_mask = (hsv_img(:,:,1) >= lower_orange(1) & hsv_img(:,:,1) <= upper_orange(1)) & ...
              (hsv_img(:,:,2) >= lower_orange(2) & hsv_img(:,:,2) <= upper_orange(2)) & ...
              (hsv_img(:,:,3) >= lower_orange(3) & hsv_img(:,:,3) <= upper_orange(3));




binary_img=redMask1| redMask2 | yellowMask | blueMask | orange_mask;

se = strel('square', 4);
erodedImage = imerode(binary_img, se);
% erodedImage = imerode(erodedImage, se);


se = strel('square', 4);
dilatedImage = imdilate(erodedImage, se);


% Oblicz minimalny rozmiar regionu
percent_of_image_min1 = 0.05;
min_region_size1 = calculate_region_size(height, width, percent_of_image_min1);


percent_of_image_min2 = 0.1;
min_region_size2 = calculate_region_size(height, width, percent_of_image_min2);


percent_of_image_max = 2; % Dostosuj tę wartość według potrzeb
max_region_size = calculate_region_size(height,width, percent_of_image_max);


coefficient = 0.04;
join_region_threshold = calculate_relative_threshold(img, coefficient);



detected_regions=detect_regions(dilatedImage, min_region_size1, join_region_threshold, max_region_size, min_region_size2);

display_detected_regions(img, detected_regions, dilatedImage);






