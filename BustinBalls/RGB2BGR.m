function [fixedImage]=BGR2RGB(imageArray)
placeholder(:,:,1)=imageArray(:,:,3);
imageArray(:,:,3)=imageArray(:,:,1);
imageArray(:,:,1)=placeholder(:,:,1);
fixedImage=imageArray;
end