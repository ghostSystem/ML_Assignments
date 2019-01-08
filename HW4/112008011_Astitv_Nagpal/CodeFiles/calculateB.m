function [B] = calculateB(w_tr, b_tr)
files = ml_getFilesInDir('/Users/astitvnagpal/Ghost_Files/SBU/Sem1/ML/HomeWork/HW4/trainIms/', 'jpg');
load trainAnno.mat;
B = [];
for z=1:length(files)
    fprintf("Image %d\n",z)
    image_name = files{z};
    im = imread(image_name);
    rects = HW4_Utils.detect(im, w_tr, b_tr, false);
    %imshow(im);
    %HW4_Utils.drawRects(rects);
%     sampleRects = rects(:,end-14:end);
%     [sampleRects, ~] = HW4_Utils.nms(sampleRects, 0.3);
    rectsFinal = [];
    ano_tr = ubAnno{z};
    rectsNeg = [];
    for i = 1:size(rects,2)
        if rects(5,i) < 0 
            rectsNeg = [rectsNeg, rects(:,i)];
        end
    end
    for j = 1:size(ano_tr,2)
        
        o = HW4_Utils.rectOverlap(rectsNeg(1:4,:), ano_tr(:,j));
        for k = 1:size(o,1)
            if o(k)<0.3
                rectsFinal = [rectsFinal, rectsNeg(:,k)];
            end
        end     
    end
    
    if size(rectsFinal,2) > 10
        rectsFinal = rectsFinal(:,1:10);
    end
    
    for j = 1:size(rectsFinal,2)
        rectCordinates = rectsFinal(1:4,j);
        rectCordinates(3,1) = rectCordinates(3,1) - rectCordinates(1,1);
        rectCordinates(4,1) = rectCordinates(4,1) - rectCordinates(2,1);
        rectImg = imcrop(im, rectCordinates);
        rectImg = imresize(rectImg, [64 64]); 
        featVec = HW4_Utils.cmpFeat(rectImg);
        FeatVec_norm = HW4_Utils.l2Norm(featVec);
        FeatVec_norm = transpose(FeatVec_norm);
        B = [B; FeatVec_norm];
    end 
end
end

