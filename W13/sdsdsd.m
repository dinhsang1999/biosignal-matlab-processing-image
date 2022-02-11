function varargout = GUItest(varargin)
% GUITEST MATLAB code for GUItest.fig
%      GUITEST, by itself, creates a new GUITEST or raises the existing
%      singleton*.
%
%      H = GUITEST returns the handle to a new GUITEST or the handle to
%      the existing singleton*.
%
%      GUITEST('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUITEST.M with the given input arguments.
%
%      GUITEST('Property','Value',...) creates a new GUITEST or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUItest_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUItest_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUItest

% Last Modified by GUIDE v2.5 26-May-2021 20:06:31
global txt
global rbg
% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUItest_OpeningFcn, ...
                   'gui_OutputFcn',  @GUItest_OutputFcn, ...
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


% --- Executes just before GUItest is made visible.
function GUItest_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUItest (see VARARGIN)

% Choose default command line output for GUItest
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes GUItest wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GUItest_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double
global txt
txt = get(hObject, 'String')

% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global txt
global rgb
name = char(txt);
rgb=imread(name);
imshow(rgb)
% --- Executes on button press in CIRCLE.
function CIRCLE_Callback(hObject, eventdata, handles)
% hObject    handle to CIRCLE (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global txt
global rgb
name = char(txt);
rgb=imread(name);
imshow(rgb)
a=rgb2gray(rgb);
%edge detection with Canny
bw=edge(a,'canny');

%get rid of noise of less than 15 pixel
bw = bwareaopen(bw,200); %loc noise trong khoang cach 30 pixel

%fill any hole to complete a shape
bw = imfill(bw,'holes'); %fill hinh

%dien tich do matlab
%lay centroid
s  = regionprops(bw, 'centroid');

%lay area
dt  = regionprops(bw, 'area');

%lay perimeter
cv = regionprops(bw, 'perimeter');
dim = size(s);

%lay boundaries X,Y
boundaries = bwboundaries(bw);
for k=1:dim(1)
    b= boundaries{k};
    dim = size(b);
    
    %Calculate the khoang cach tu centroid to each point at the boundaries
    for i=1:dim(1)
        khoangcach{k}(1,i) = sqrt ((b(i,2) - s(k).Centroid(1))^2 + (b(i,1) - s(k).Centroid(2))^2 );
    end 
    
    %detemine the max and min khoang cach
    a=max(khoangcach{k});
    b=min(khoangcach{k});
    
    %get the area from the prop command
    %this is the area based on the number of pixels in the shape
    c=dt(k).Area;
    d=cv(k).Perimeter;
    %dien tich
    %pi*R^2
    tron = round(pi*a^2);
          
     if ((abs(c-tron)/c)<0.1)
            text(s(k).Centroid(1),s(k).Centroid(2),'CIRCLE')
     end
end
% --- Executes on button press in TRIANGLE.
function TRIANGLE_Callback(hObject, eventdata, handles)
% hObject    handle to CIRCLE (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global txt
global rgb
name = char(txt);
rgb=imread(name);
imshow(rgb)
a=rgb2gray(rgb);
%edge detection with Canny
bw=edge(a,'canny');

%get rid of noise of less than 15 pixel
bw = bwareaopen(bw,200); %loc noise trong khoang cach 30 pixel

%fill any hole to complete a shape
bw = imfill(bw,'holes'); %fill hinh

%dien tich do matlab
%lay centroid
s  = regionprops(bw, 'centroid');

%lay area
dt  = regionprops(bw, 'area');

%lay perimeter
cv = regionprops(bw, 'perimeter');
dim = size(s);

%lay boundaries X,Y
boundaries = bwboundaries(bw);
for k=1:dim(1)
    b= boundaries{k};
    dim = size(b);
    
    %Calculate the khoang cach tu centroid to each point at the boundaries
    for i=1:dim(1)
        khoangcach{k}(1,i) = sqrt ((b(i,2) - s(k).Centroid(1))^2 + (b(i,1) - s(k).Centroid(2))^2 );
    end 
    
    %detemine the max and min khoang cach
    a=max(khoangcach{k});
    b=min(khoangcach{k});
    
    %get the area from the prop command
    %this is the area based on the number of pixels in the shape
    c=dt(k).Area;
    d=cv(k).Perimeter;
    %dien tich
    %pi*R^2
    x=sqrt(sqrt(3)*c);
    y=d/3;
    z=2*x;
     if (sqrt(3)*y <= 1.1*z) && (sqrt(3)*y >= 0.9*z)
         text(s(k).Centroid(1),s(k).Centroid(2),'TRIANGLE')
     end
end
% hObject    handle to TRIANGLE (see GCBO)

% eventdata  reserved - to be defined in a future version of MATLAB

% handles    structure with handles and user data (see GUIDATA)

% --- Executes on button press in SQUARE.

function SQUARE_Callback(hObject, eventdata, handles)
% hObject    handle to CIRCLE (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global txt
global rgb
name = char(txt);
rgb=imread(name);
imshow(rgb)
a=rgb2gray(rgb);
%edge detection with Canny
bw=edge(a,'canny');

%get rid of noise of less than 15 pixel
bw = bwareaopen(bw,200); %loc noise trong khoang cach 30 pixel

%fill any hole to complete a shape
bw = imfill(bw,'holes'); %fill hinh

%dien tich do matlab
%lay centroid
s  = regionprops(bw, 'centroid');

%lay area
dt  = regionprops(bw, 'area');

%lay perimeter
cv = regionprops(bw, 'perimeter');
dim = size(s);

%lay boundaries X,Y
boundaries = bwboundaries(bw);
for k=1:dim(1)
    b= boundaries{k};
    dim = size(b);
    
    %Calculate the khoang cach tu centroid to each point at the boundaries
    for i=1:dim(1)
        khoangcach{k}(1,i) = sqrt ((b(i,2) - s(k).Centroid(1))^2 + (b(i,1) - s(k).Centroid(2))^2 );
    end 
    
    %detemine the max and min khoang cach
    a=max(khoangcach{k});
    b=min(khoangcach{k});
    
    %get the area from the prop command
    %this is the area based on the number of pixels in the shape
    c=dt(k).Area;
    d=cv(k).Perimeter;
    %dien tich
    %pi*R^2
     canh=d/4;
     square=canh*canh;
     if (c <= (1.1*square)) && (c >= (0.9*square))
         text(s(k).Centroid(1),s(k).Centroid(2),'SQUARE')
     end
end
% hObject    handle to SQUARE (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in RECTANGLE.
function RECTANGLE_Callback(hObject, eventdata, handles)
% hObject    handle to RECTANGLE (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
