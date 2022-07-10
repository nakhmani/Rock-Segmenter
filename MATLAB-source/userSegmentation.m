function BW = userSegmentation(I,param1,param2)
h = waitbar(0,'Please wait...');
I = double(I);

for row=5:size(I,1)-5
    for col=5:size(I,2)-5
        Z = I(row-4:row+4,col-4:col+4);
        [X,Y] = meshgrid(1:9,1:9);
        Xcolv = X(:);
        Const = ones(size(Xcolv));
        C = [Xcolv Y(:) Const]\Z(:);
        Z_p = C(1) * X + C(2) * Y + C(3);
        Z_f = Z - Z_p;
        J(row,col) = std(Z_f(:));
    end
    waitbar(row/size(I,1)*10/11)
end
[hh,bb]=hist(J(:),0:0.01:100);
cnt=1;
while sum(hh(1:cnt))/sum(hh(cnt+1:end))<8
    cnt=cnt+1;
end
BW = J>bb(cnt)+100*param1-50;
BW = imclose(BW,strel('disk',10*param2));
BW = imfill(bwareafilt(BW,1),'holes');
BW = padarray(BW,[5 5],0,'post');
close(h)