function medianImageSizes = temp_resize_images(posDir, outputDir)
default posDir    = ('C:\Users\Shaked\nanit\head_marking_acf\pos');
default outputDir = ('C:\Users\Shaked\nanit\head_marking_acf\pos_resized');

imageFiles = rdir(fullfile(posDir, '*.tif'));
imagePaths = {imageFiles(:).name};
images = cellfun(@imread, imagePaths, 'UniformOutput', false);

imageSizes = cellfun(@size, images, 'UniformOutput', false);
imageSizes = cat(1, imageSizes{:});
medianImageSizes = median(imageSizes);

resizedImages = cellfun(@(im) imresize(im, medianImageSizes), images, 'UniformOutput', false);
outputPaths = strrep(imagePaths, posDir, outputDir);
EnsureDir(outputDir);
cellfun(@(im,imPath) imwrite(im, imPath), resizedImages, outputPaths);

end

