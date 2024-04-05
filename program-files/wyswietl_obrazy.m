

clear all;
close all;

%jpg



% Ustawienie ścieżki do folderu ze zdjęciami
folder_path = 'zdjecia-zle';

% Pobranie listy plików w folderze
image_files_jpg = dir(fullfile(folder_path, '*.JPG')); % Zakłada, że obrazy mają rozszerzenie .jpg


% Iteracja przez każdy plik

for i = 1:numel(image_files_jpg)
    % Wczytanie obrazu
    img = imread(fullfile(folder_path, image_files_jpg(i).name));
    
    % Wyświetlenie obrazu
    wszystkie_kolory_new(img)
    title(['Zdjęcie ', num2str(i)]);
    
    % Poczekaj na potwierdzenie użytkownika przed przejściem do następnego obrazu
    pause;
    close(gcf);
end


%jpeg

image_files_jpeg = dir(fullfile(folder_path, '*.jpeg')); % Zakłada, że obrazy mają rozszerzenie .jpg

% Iteracja przez każdy plik
for i = 1:numel(image_files_jpeg)
    % Wczytanie obrazu

    img = imread(fullfile(folder_path, image_files_jpeg(i).name));
    
    % Wyświetlenie obrazu
  
    wszystkie_kolory_new(img)
    title(['Zdjęcie ', num2str(i)]);
    
    % Poczekaj na potwierdzenie użytkownika przed przejściem do następnego obrazu
    pause;
    close(gcf);
end