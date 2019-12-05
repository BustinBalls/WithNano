function VisionControl()
%%72 dpi
global stereoParams
%intialize  Variables
pixel2mm=1;
mm2pixel=1/pixel2mm;
ballDiam.mm=58;
ballDiam.pixel=60.1664;%h=imline 58.8767
bumper2dots.mm=68;
bumper2dots.pixel=bumper2dots.mm*
ballRad.mm=ballDiam.mm/2;
%color matrix
color = {[0 0 0];[1 0 0];[0.4660 0.6740 0.1880];[0 0 1];[0.8500 0.3250 0.0980];[1 0 1]};
%%
%Get IMG and undistort
%Get IMG and undistort
load imgLeft leftImgArry
load imgRight rightImgArry
load ZedCallibrated stereoParams


zed.left.OG=leftImgArry;
zed.left.undistorted.BGR = undistortImage(zed.left.OG,stereoParams.CameraParameters1);
zed.left.undistorted.RGB=BGR2RGB(zed.left.undistorted.BGR);


zed.right.OG=rightImgArry;
zed.right.undistorted.BGR = undistortImage(rightImgArry,stereoParams.CameraParameters2);
zed.right.undistorted.RGB=BGR2RGB(zed.right.undistorted.BGR);



%%
%dot Diameter =16max
Left=[];
Right=[];
Top=[];
Bot=[];


%{
while ((isempty(Left) | isempty(Right) | isempty(Top) | isempty(Bot))==1)==1
    Left=[];
    Right=[];
    Top=[];
    Bot=[];

    [cDot, r] = imfindcircles(leftEye,[5 11],'Sensitivity', 0.9, 'EdgeThreshold', 0.2);
    viscircles(cDot, r,'Color','r');
    
    rNew=[];
    cDotNew=[];
    for i=1:length(cDot)
        if r(i)<8.5 && r(i)>6.5
            rNew=[rNew;r(i)];
            cDotNew=[cDotNew; cDot(i,:)];
        end
    end
    cDot=cDotNew;
    r=rNew;

    viscircles(cDot, r,'Color','y');
    for i=1:length(cDot)
        if cDot(i,1) <= 300 && cDot(i,1) >= 200
            Left=[Left,cDot(i,1)];
        elseif cDot(i,1) >= 2000 && cDot(i,1) <= 2200
            Right=[Right,cDot(i,1)];
        elseif
            if cDot(i,2)<= 140 && cDot(i,2)>= 40
                Top=[Top,cDot(i,2)];
            elseif cDot(i,2)>= 1050 && cDot(i,2)<= 1150
                Bot=[Bot,cDot(i,2)];
            end
        else  
            cDot(i,1)=[];
        end
    end
end
viscircles(cDot, r,'Color','g');

Top=sum(Top)/length(Top);
Bot=sum(Bot)/length(Bot);
Right=sum(Right)/length(Right);
Left=sum(Left)/length(Left);
CroppedTable=[Left+bumper2dots.pixel Top+bumper2dots.pixel Right-Left-bumper2dots.pixel*2 Bot-Top-bumper2dots.pixel*2];
img=imcrop(img,CroppedTable);
%}


2.625
9.18

end
























































































%%
function [fixedImage]=BGR2RGB(imageArray)
placeholder(:,:,1)=imageArray(:,:,3);
imageArray(:,:,3)=imageArray(:,:,1);
imageArray(:,:,1)=placeholder(:,:,1);
fixedImage=imageArray;
end
