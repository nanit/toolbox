function temp_test()

if ~exist('detector', 'var')
    load('C:\Users\Shaked\nanit\pdollar-toolbox\Detector.mat');
end
I = imread('C:\Users\Shaked\nanit\algorithms\TestImage2.jpg');
I = impyramid(I, 'reduce');
bbs = acfDetect(I, detector);

% for i = 1:size(bbs,1)
%     image = insertShape(image, 'rectangle', bbs(i,:));
% end
% 
% figure;
% imshow(image);

figure(1); 
im(I); 
bbApply('draw',bbs); 
pause(.1);

end
