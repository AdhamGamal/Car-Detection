clear all
close all
clc

if exist('vl_sift' , 'file' )==0
    run( 'vlfeat\toolbox\vl_setup' );
end

th=.9;
ESE =[1 0 0; 0 1 0; 0 0 1];
DSE =[0 0 1; 0 1 0; 1 0 0];
optimalMatches=18;

videoObj = VideoReader('video.MP4');
nFrames = videoObj.NumberOfFrames;


Ia = imread('car5.png');
I1 = im2bw(Ia,th);
I1 = imerode(I1,ESE);
I1 = imdilate(I1,DSE);
I1 = single(I1);
[f1,d1] = vl_sift(I1);
figure(1), imshow(Ia,[]);

for j=14875:25:nFrames 
	Ib = read(videoObj,j); 
	I2 = im2bw(Ib,th);
    I2 = imerode(I2,ESE);
    I2 = imdilate(I2,DSE);
	figure(2),imshow(Ib, []); 
    I2 = single(I2); 
    [f2,d2] = vl_sift(I2);
    [matches,scores] = vl_ubcmatch(d1, d2);
    [~,nom]=size(matches);
    if nom > optimalMatches
        vl_plotframe(f2(:,matches(2,:))) ;
        pause
    end
end

