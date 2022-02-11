[r c] =size(BWdfill);
 for i = 395:400 
    for j= 320:350
           BWdfill(j,i) = 0;      
    end
 end
 figure, imshow(BWdfill),impixelinfo
 
 
 [r c] =size(BWdfill);
 for i = 1:r
    for j= 1:c
        if L(i,j) == 0
           L(i,j) = 0;
        else
            L(i,j)=255;
        end
    end
 end
 figure, imshow(L),impixelinfo