function varargout = RockSegmenter(varargin)
% ROCKSEGMENTER MATLAB code for RockSegmenter.fig
%      ROCKSEGMENTER, by itself, creates a new ROCKSEGMENTER or raises the existing
%      singleton*.
%
%      H = ROCKSEGMENTER returns the handle to a new ROCKSEGMENTER or the handle to
%      the existing singleton*.
%
%      ROCKSEGMENTER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ROCKSEGMENTER.M with the given input arguments.
%
%      ROCKSEGMENTER('Property','Value',...) creates a new ROCKSEGMENTER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before RockSegmenter_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to RockSegmenter_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help RockSegmenter

% Last Modified by GUIDE v2.5 05-Jul-2022 19:33:33

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @RockSegmenter_OpeningFcn, ...
    'gui_OutputFcn',  @RockSegmenter_OutputFcn, ...
    'gui_LayoutFcn',  [] , ...
    'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT

function figure1_CreateFcn(hObject, eventdata, handles)
function sImage_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
function RockSegmenter_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;
handles.automateImage = [];
handles.sParam2.Enable = "off";
handles.tParam2.Enable = "off";
handles.eParam2.Enable = "off";
handles.sParam3.Enable = "off";
handles.tParam3.Enable = "off";
handles.eParam3.Enable = "off";
guidata(hObject, handles);
function eParam1_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function eParam2_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function eParam3_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function eLoad_Callback(hObject, eventdata, handles)
function eLoad_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function eSave_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function cbMask_Callback(hObject, eventdata, handles)
function cbCrop_Callback(hObject, eventdata, handles)
function eMaskSuffix_Callback(hObject, eventdata, handles)
function eMaskSuffix_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function eWidth_Callback(hObject, eventdata, handles)
function eWidth_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function eHeight_Callback(hObject, eventdata, handles)
function eHeight_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function sParam1_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
function sParam2_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
function sParam3_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
function cbSuppress_Callback(hObject, eventdata, handles)
function cbSuppressMasks_Callback(hObject, eventdata, handles)
function varargout = RockSegmenter_OutputFcn(hObject, eventdata, handles)
varargout{1} = handles.output;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function pbAutomate_Callback(hObject, eventdata, handles)
handles.automateImage = handles.tImageName.String;
f1 = figure;
ax1 = axes;
imshow(handles.I,'Parent',ax1);
title("Select the boundary by dragging the mouse cursor and wait until the figure closes")
ROI = drawfreehand(ax1);

global groundTruth ind I
I = rgb2gray(handles.I);
groundTruth = double(createMask(ROI,I));


if handles.rbInputWhite.Value
    hs = imhist(I);
    [~,mxind] = max(hs(150:end));
    [~,ind] = min(hs(150:mxind+149));
    handles.sParam1.Value = fminbnd(@segmentWhite,0,1);
    handles.eParam1.String = num2str(handles.sParam1.Value);

elseif handles.rbInputBlack.Value
    handles.sParam1.Value = fminbnd(@segmentBlack,0,1);
    handles.eParam1.String = num2str(handles.sParam1.Value);
    
elseif handles.rbInputGradient.Value
    handles.sParam1.Value = fminbnd(@segmentGradient,0,1);
    handles.eParam1.String = num2str(handles.sParam1.Value);
    
end
close(f1)
segmentImage(handles)
guidata(hObject, handles);




% opts = optimoptions(@fmincon,'Algorithm','sqp');
% problem = createOptimProblem('fmincon','objective',...
%     @segmentWhite,'x0',0.5,'lb',0,'ub',1,'options',opts);
% gs = GlobalSearch;
% [param1,f] = run(gs,problem)

        




function cbActiveContours_Callback(hObject, eventdata, handles)
if hObject.Value
    handles.sParam3.Enable = "on";
    handles.tParam3.Enable = "on";
    handles.eParam3.Enable = "on";
else
    handles.sParam3.Enable = "off";
    handles.tParam3.Enable = "off";
    handles.eParam3.Enable = "off";
end

function eParam1_Callback(hObject, eventdata, handles)
handles.sParam1.Value = min(1,max(0,str2double(hObject.String)));
segmentImage(handles)

function eParam2_Callback(hObject, eventdata, handles)
handles.sParam2.Value = min(1,max(0,str2double(hObject.String)));
segmentImage(handles)

function eParam3_Callback(hObject, eventdata, handles)
handles.sParam3.Value = min(20,max(0,str2double(hObject.String)));
segmentImage(handles)



function eSave_Callback(hObject, eventdata, handles)
if ~exist(hObject.String, 'dir')
    mkdir(hObject.String)
    disp("Created folder: "+hObject.String)
end


function pbLoad_Callback(hObject, eventdata, handles)
%% read folder name and update edit fields
fileID = fopen('setup.ini','r');
st = fgetl(fileID);
fclose(fileID);
handles.eLoad.String = uigetdir(st);
fileID = fopen('setup.ini','w');
fprintf(fileID,'%s\n',handles.eLoad.String);
fclose(fileID);
handles.eSave.String = handles.eLoad.String;
handles.sParam1.Value = 0.5;
handles.sParam2.Value = 0.5;
handles.sParam3.Value = 0.5;
handles.eParam1.String = '0.5';
handles.eParam2.String = '0.5';
handles.eParam3.String = '0.5';

%% read the first JPG file
listing = dir([handles.eLoad.String,'\*.jpg']);
if numel(listing)>=1
    handles.sImage.Max = numel(listing);
    handles.sImage.Value = 1;
    handles.sImage.SliderStep = [1/handles.sImage.Max,3/handles.sImage.Max];
    I = imread(fullfile(handles.eLoad.String,listing(1).name));
    handles.tImageName.String = listing(1).name;
    %% update cropping size
    handles.eWidth.String = num2str(size(I,2));
    handles.eHeight.String = num2str(size(I,1));
    %% scale image down to approximately 300px height
    scale = round(size(I,1)/300);
    handles.I = I;
    handles.Idown = rgb2gray(I(1:scale:end,1:scale:end,:));
    
    %% detect BG colors
    BG1 = handles.Idown(1:50,:);
    BG2 = handles.Idown(end-49:end,:);
    BG3 = handles.Idown(:,1:50);
    BG4 = handles.Idown(:,end-49:end,:);
    BG = cat(1,BG1(:),BG2(:),BG3(:),BG4(:));
    
    if mean(BG)<50
        handles.rbInputBlack.Value = 1;
    elseif mean(BG)>200
        handles.rbInputWhite.Value = 1;
    else
        handles.rbInputGradient.Value = 1;
        handles.sParam1.Value = 0.794;
        handles.eParam1.String = '0.794';
    end
    
    %% segment the image
    segmentImage(handles)
else
    msgbox('No JPG files available in this folder')
end


guidata(hObject, handles);


function pbSave_Callback(hObject, eventdata, handles)
handles.eSave.String = uigetdir;
guidata(hObject, handles);


function sParam1_Callback(hObject, eventdata, handles)
handles.eParam1.String = num2str(hObject.Value);
segmentImage(handles)




function sParam2_Callback(hObject, eventdata, handles)
handles.eParam2.String = num2str(hObject.Value);
segmentImage(handles)



function sParam3_Callback(hObject, eventdata, handles)
handles.eParam3.String = num2str(hObject.Value);
segmentImage(handles)

function tbMask_Callback(hObject, eventdata, handles)
segmentImage(handles)


function rbInputWhite_Callback(hObject, eventdata, handles)
handles.sParam2.Enable = "off";
handles.tParam2.Enable = "off";
handles.eParam2.Enable = "off";
handles.sParam1.Value = 0.5;
handles.sParam2.Value = 0.5;
handles.eParam1.String = '0.5';
handles.eParam2.String = '0.5';
segmentImage(handles)


function rbInputBlack_Callback(hObject, eventdata, handles)
handles.sParam2.Enable = "off";
handles.tParam2.Enable = "off";
handles.eParam2.Enable = "off";
handles.sParam1.Value = 0.5;
handles.sParam2.Value = 0.5;
handles.eParam1.String = '0.5';
handles.eParam2.String = '0.5';
segmentImage(handles)


function rbInputGradient_Callback(hObject, eventdata, handles)
handles.sParam2.Enable = "off";
handles.tParam2.Enable = "off";
handles.eParam2.Enable = "off";
handles.sParam1.Value = 0.794;
handles.sParam2.Value = 0.5;
handles.eParam1.String = '0.794';
handles.eParam2.String = '0.5';
segmentImage(handles)


function rbInputComplex_Callback(hObject, eventdata, handles)
handles.sParam2.Enable = "on";
handles.tParam2.Enable = "on";
handles.eParam2.Enable = "on";
handles.sParam1.Value = 0.5;
handles.sParam2.Value = 0.5;
handles.eParam1.String = '0.5';
handles.eParam2.String = '0.5';
segmentImage(handles)


function sImage_Callback(hObject, eventdata, handles)
listing = dir([handles.eLoad.String,'\*.jpg']);
I = imread(fullfile(handles.eLoad.String,listing(round(handles.sImage.Value)).name));
handles.tImageName.String = listing(round(handles.sImage.Value)).name;
%% update cropping size
handles.eWidth.String = num2str(size(I,2));
handles.eHeight.String = num2str(size(I,1));
%% scale image down to approximately 300px height
scale = round(size(I,1)/300);
handles.I = I;
handles.Idown = rgb2gray(I(1:scale:end,1:scale:end,:));
segmentImage(handles)
guidata(hObject, handles);



function pbProcess_Callback(hObject, eventdata, handles)
h = waitbar(0,'Please wait...');
C = strsplit(handles.eSave.String,'\');
fid = fopen(fullfile(handles.eSave.String,[C{end},'_processing.log']),'wt');
listing = dir([handles.eLoad.String,'\*.jpg']);
param1 = handles.sParam1.Value;
param2 = handles.sParam2.Value;
fprintf(fid,'%s%f\n','Parameter 1 = ',param1);
fprintf(fid,'%s%f\n','Parameter 2 = ',param2);
fprintf(fid,'%s%f\n','Parameter 3 = ',handles.sParam3.Value);
fprintf(fid,'%s%s\n','Saving in ',handles.eSave.String);
if ~isempty(handles.automateImage)
   fprintf(fid,'%s%s\n','Image used for automation: ',handles.automateImage);
end
for t=1:numel(listing)
    I = imread(fullfile(listing(t).folder,listing(t).name));
    fprintf(fid,'%s%s\n','Time: ',datestr(now));
    fprintf(fid,'%s%s\n','Processing ',fullfile(listing(t).folder,listing(t).name));
    J = rgb2gray(I);
    if handles.rbInputBlack.Value
        BW = J>20+100*param1-50;
        fprintf(fid,'%s\n','Assuming black background');
    elseif handles.rbInputGradient.Value
        [Gmag,~] = imgradient(J);
        BW=Gmag>50+100*param1^3-50;
        fprintf(fid,'%s\n','Assuming gradient background');
    elseif handles.rbInputComplex.Value
        BW = userSegmentation(J,param1,param2);
        fprintf(fid,'%s\n','Assuming complex background');
    else
        hs = imhist(J);
        [~,mxind] = max(hs);
        [~,ind] = min(hs(150:mxind));
        BW = J<149+ind+100*param1-50;
        fprintf(fid,'%s\n','Assuming white background');
    end
    BW = imclose(BW,strel('disk',2));
    BW = bwareafilt(BW,1);
    BW = uint8(imfill(BW, 'holes'));
    if handles.cbActiveContours.Value
        BW = activecontour(J,BW,20,'edge','SmoothFactor',str2double(handles.eParam3.String));
        BW = uint8(BW);
    end
    I = uint8(I);
    I = I.*cat(3,BW,BW,BW);
    
    if handles.cbCrop.Value
        canvas = zeros(str2double(handles.eHeight.String),str2double(handles.eWidth.String),3,'uint8');
        canvasBW = zeros(str2double(handles.eHeight.String),str2double(handles.eWidth.String),1,'uint8');
        mn = find(sum(BW)>0,1,'first');
        I(:,1:mn-1,:)=[];
        BW(:,1:mn-1)=[];
        mn = find(sum(BW)>0,1,'last');
        I(:,mn+1:end,:)=[];
        BW(:,mn+1:end)=[];
        mn = find(sum(BW,2)>0,1,'first');
        I(1:mn-1,:,:)=[];
        BW(1:mn-1,:)=[];
        mn = find(sum(BW,2)>0,1,'last');
        I(mn+1:end,:,:)=[];
        BW(mn+1:end,:)=[];
        
        mn = min(str2double(handles.eHeight.String)/size(I,1),str2double(handles.eWidth.String)/size(I,2));
        J = imresize(I,mn);
        BW = imresize(BW,mn);
        upperCorner = max(round((size(canvas,1)-size(J,1))/2),1);
        leftCorner = max(round((size(canvas,2)-size(J,2))/2),1);
        canvas(upperCorner:upperCorner+size(J,1)-1,leftCorner:leftCorner+size(J,2)-1,:) = J;
        canvasBW(upperCorner:upperCorner+size(J,1)-1,leftCorner:leftCorner+size(J,2)-1) = BW;
        I = canvas;
        BW = canvasBW;
        fprintf(fid,'%s%s%s%s\n','Scaled to W = ',handles.eWidth.String,' and H = ',handles.eHeight.String);
    end
    if handles.cbMask.Value
        imwrite(BW*255,fullfile(handles.eSave.String,[listing(t).name(1:end-4),handles.eMaskSuffix.String,'.png']))
    end
    if ~handles.cbSuppress.Value
        if handles.rbOutputBlack.Value
            fprintf(fid,'%s\n','Stored with black background');
            if handles.rbPNG.Value
                imwrite(I,fullfile(handles.eSave.String,[listing(t).name(1:end-4),'_segmentedBlack.png']));
                fprintf(fid,'%s\n','Stored as PNG');
            else
                imwrite(I,fullfile(handles.eSave.String,[listing(t).name(1:end-4),'_segmentedBlack.jpg']));
                fprintf(fid,'%s\n','Stored as JPG');
            end
        else
            fprintf(fid,'%s\n','Stored with white background');
            I(~logical(cat(3,BW,BW,BW))) = 255;
            if handles.rbPNG.Value
                imwrite(I,fullfile(handles.eSave.String,[listing(t).name(1:end-4),'_segmentedWhite.png']));
                fprintf(fid,'%s\n','Stored as PNG');
            else
                imwrite(I,fullfile(handles.eSave.String,[listing(t).name(1:end-4),'_segmentedWhite.jpg']));
                fprintf(fid,'%s\n','Stored as JPG');
            end
        end
    end
    waitbar(t/numel(listing))
end
fclose(fid);
close (h)
if ~handles.cbSuppressMasks.Value
    f = waitbar(0,'Please wait...');
    files = dir([handles.eSave.String,'\*',handles.eMaskSuffix.String,'.png']);
    if numel(files)>0
        for t=1:numel(files)
            I(:,:,t) = imread(fullfile(files(t).folder,files(t).name));
        end
        waitbar(0.2)
        figure
        montage(I)
    else
        msgbox('No Mask files available')
    end
    close(f)
end


function pbPreview_Callback(hObject, eventdata, handles)
figure(1)
param1 = handles.sParam1.Value;
param2 = handles.sParam2.Value;
I = handles.I;
J = rgb2gray(I);
if handles.rbInputBlack.Value
    BW = J>20+100*param1-50;
elseif handles.rbInputGradient.Value
    [Gmag,~] = imgradient(J);
    BW=Gmag>50+100*param1^3-50;
elseif handles.rbInputComplex.Value
    BW = userSegmentation(J,param1,param2);
else
    hs = imhist(J);
    [~,mxind] = max(hs(150:end));
    [~,ind] = min(hs(150:mxind+149));
    BW = J<149+ind+100*param1-50;
end
BW = imclose(BW,strel('disk',2));
BW = bwareafilt(BW,1);
BW = uint8(imfill(BW, 'holes'));
if handles.cbActiveContours.Value
    BW = activecontour(J,BW,20,'edge','SmoothFactor',str2double(handles.eParam3.String));
end
I = uint8(I);
I = I.*cat(3,BW,BW,BW);

if handles.cbCrop.Value
    canvas = zeros(str2double(handles.eHeight.String),str2double(handles.eWidth.String),3,'uint8');
    canvasBW = zeros(str2double(handles.eHeight.String),str2double(handles.eWidth.String),1,'uint8');
    mn = find(sum(BW)>0,1,'first');
    I(:,1:mn-1,:)=[];
    BW(:,1:mn-1)=[];
    mn = find(sum(BW)>0,1,'last');
    I(:,mn+1:end,:)=[];
    BW(:,mn+1:end)=[];
    mn = find(sum(BW,2)>0,1,'first');
    I(1:mn-1,:,:)=[];
    BW(1:mn-1,:)=[];
    mn = find(sum(BW,2)>0,1,'last');
    I(mn+1:end,:,:)=[];
    BW(mn+1:end,:)=[];
    
    mn = min(str2double(handles.eHeight.String)/size(I,1),str2double(handles.eWidth.String)/size(I,2));
    J = imresize(I,mn);
    BW = imresize(BW,mn);
    upperCorner = max(round((size(canvas,1)-size(J,1))/2),1);
    leftCorner = max(round((size(canvas,2)-size(J,2))/2),1);
    canvas(upperCorner:upperCorner+size(J,1)-1,leftCorner:leftCorner+size(J,2)-1,:) = J;
    canvasBW(upperCorner:upperCorner+size(J,1)-1,leftCorner:leftCorner+size(J,2)-1) = BW;
    I = canvas;
    BW = canvasBW;
end

if handles.tbMask.Value
    imshow(BW,[])
else
    if handles.rbOutputBlack.Value
        imshow(I)
    else
        I(~logical(cat(3,BW,BW,BW))) = 255;
        imshow(I)
    end
end
title(handles.tImageName.String, 'Interpreter', 'none')

function pbHistogram_Callback(hObject, eventdata, handles)
imcontrast(handles.axes1)


function pbViewMasks_Callback(hObject, eventdata, handles)
f = waitbar(0,'Please wait...');
files = dir([handles.eSave.String,'\*',handles.eMaskSuffix.String,'.png']);
if numel(files)>0
    for t=1:numel(files)
        I(:,:,t) = imread(fullfile(files(t).folder,files(t).name));
    end
    waitbar(0.2)
    figure
    montage(I)
else
    msgbox('No Mask files available')
end
close(f)


function uipushtool1_ClickedCallback(hObject, eventdata, handles)
[configFile,path] = uigetfile(fullfile(handles.eSave.String,'*.mat'));
load(fullfile(path,configFile))
handles.eLoad.String = eLoad;
handles.eSave.String = eSave;
handles.rbInputWhite.Value = rbInputWhite;
handles.rbInputBlack.Value = rbInputBlack;
handles.rbInputGradient.Value = rbInputGradient;
handles.rbInputComplex.Value = rbInputComplex;
handles.eWidth.String = eWidth;
handles.eHeight.String = eHeight;
handles.sParam1.Min = min1;
handles.sParam1.Max = max1;
handles.sParam1.Value = value1;
handles.sParam2.Min = min2;
handles.sParam2.Max = max2;
handles.sParam2.Value = value2;
handles.sParam3.Min = min3;
handles.sParam3.Max = max3;
handles.sParam3.Value = value3;
handles.eParam1.String = eParam1;
handles.eParam2.String = eParam2;
handles.eParam3.String = eParam3;
handles.sImage.Min = minI1;
handles.sImage.Max = maxI1;
handles.sImage.Value = valueI1;
handles.sImage.SliderStep = sliderStep;

guidata(hObject, handles);



function uipushtool2_ClickedCallback(hObject, eventdata, handles)
eLoad = handles.eLoad.String;
eSave = handles.eSave.String;
rbInputWhite = handles.rbInputWhite.Value;
rbInputBlack = handles.rbInputBlack.Value;
rbInputGradient = handles.rbInputGradient.Value;
rbInputComplex = handles.rbInputComplex.Value;
eWidth = handles.eWidth.String;
eHeight = handles.eHeight.String;
min1 = handles.sParam1.Min;
max1 = handles.sParam1.Max;
value1 = handles.sParam1.Value;
min2 = handles.sParam2.Min;
max2 = handles.sParam2.Max;
value2 = handles.sParam2.Value;
min3 = handles.sParam3.Min;
max3 = handles.sParam3.Max;
value3 = handles.sParam3.Value;
eParam1 = handles.eParam1.String;
eParam2 = handles.eParam2.String;
eParam3 = handles.eParam3.String;
minI1 = handles.sImage.Min;
maxI1 = handles.sImage.Max;
valueI1 = handles.sImage.Value;
sliderStep = handles.sImage.SliderStep;

[file,path] = uiputfile(fullfile(handles.eSave.String,'\config.mat'));
save(fullfile(path,file),'eParam3','eParam2','eParam1','value3','max3','min3',...
    'value2','max2','min2','value1','max1','min1','eHeight','eWidth','rbInputComplex',...
    'rbInputGradient','rbInputBlack','rbInputWhite','eSave','eLoad',...
    'minI1','maxI1','valueI1','sliderStep')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function f = segmentWhite(param1)
global I ind groundTruth
BW = I<149+ind+100*param1-50;
BW = imclose(BW,strel('disk',2));
BW = bwareafilt(BW,1);
BW = double(imfill(BW, 'holes'));
f = -sum(BW.*groundTruth,"all")/(sum(BW,"all")+sum(groundTruth,"all"));

function f = segmentBlack(param1)
global I groundTruth
BW = I>20+100*param1-50;
BW = imclose(BW,strel('disk',2));
BW = bwareafilt(BW,1);
BW = double(imfill(BW, 'holes'));
f = -sum(BW.*groundTruth,"all")/(sum(BW,"all")+sum(groundTruth,"all"));

function f = segmentGradient(param1)
global I groundTruth
[Gmag,~] = imgradient(I);
BW=Gmag>50+100*param1^3-50;
BW = imclose(BW,strel('disk',2));
BW = bwareafilt(BW,1);
BW = double(imfill(BW, 'holes'));
f = -sum(BW.*groundTruth,"all")/(sum(BW,"all")+sum(groundTruth,"all"));


function segmentImage(handles)
axis(handles.axes1);
I = handles.Idown;
param1 = handles.sParam1.Value;
param2 = handles.sParam2.Value;
param3 = handles.sParam3.Value;

if handles.rbInputWhite.Value
    hs = imhist(I);
    [~,mxind] = max(hs(150:end));
    [~,ind] = min(hs(150:mxind+149));
    BW = I<149+ind+100*param1-50;
    BW = imclose(BW,strel('disk',2));
    BW = bwareafilt(BW,1);
    BW = uint8(imfill(BW, 'holes'));
    
elseif handles.rbInputBlack.Value
    BW = I>20+100*param1-50;
    BW = imclose(BW,strel('disk',2));
    BW = bwareafilt(BW,1);
    BW = uint8(imfill(BW, 'holes'));
    
elseif handles.rbInputGradient.Value
    [Gmag,~] = imgradient(I);
    BW=Gmag>50+100*param1^3-50;
    BW = imclose(BW,strel('disk',2));
    BW = bwareafilt(BW,1);
    BW = uint8(imfill(BW, 'holes'));
else
    BW = userSegmentation(I,param1);
end
if handles.tbMask.Value
    imshow(BW,[])
    colormap gray
else
    imshow(I)
    hold on
    visboundaries(handles.axes1,BW,'Color','r');
end
