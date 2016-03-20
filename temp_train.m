function temp_train(cascCal)

rescaledMinWH = [61 61];
rescaledMaxWH = [108 108];


opts = acfTrain();
opts.posWinDir = 'C:\Users\Shaked\nanit\head_marking_acf\pos_resized_0.4872';
opts.negImgDir = 'C:\Users\Shaked\nanit\head_marking_acf\neg_gray';
opts.modelDs = [63 63];%[33 33];%[32 32];%[33 33];%[130 130];%[65 65];
opts.modelDsPad = [76 76];%[40 40];%[38 38];%[39 39];%[156 156];%[78 78];
% opts.pPyramid.nOctUp = 2;
% opts.pPyramid = chnsPyramid();
opts.pPyramid.pChns.pColor.colorSpace = 'gray';
opts.pPyramid.minDs = rescaledMinWH;%opts.modelDs;
% opts.pPyramid.complete = 1;
% opts.pPyramid.pChns.pColor.enabled = false;
opts.nWeak = 2.^(1:7);
opts.cascCal = cascCal;
% opts.cascCal = 0.05;
% opts.cascThr = 5;
% opts.pBoost.verbose = true;
% opts.nNeg = 2;
opts.stride = 8;%16;
opts.name = sprintf('modelDs_63-nWeak_2pow1-7-stride_8-cascCal_%d', cascCal);

acfTrain(opts);

end
