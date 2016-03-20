function temp_to_gray(inputDir, outputDir)
default inputDir = ('C:\Users\Shaked\nanit\head_marking_acf\neg');
default outputDir = ('C:\Users\Shaked\nanit\head_marking_acf\neg_gray');

imageFiles = rdir(fullfile(inputDir, '*.tif'));
imagePaths = {imageFiles(:).name};
outputPaths = strrep(imagePaths, inputDir, outputDir);

EnsureDir(outputDir);

parfor i = 1:length(imagePaths)
    image = imread(imagePaths{i});
    if size(image,3) == 3
        image = rgb2gray(image);
    end
    imwrite(image, outputPaths{i});
end

end

