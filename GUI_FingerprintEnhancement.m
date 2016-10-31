%Group member: Mahesh Mitikiri

function varargout = firstg(varargin)
% FIRSTG M-file for firstg.fig
%      FIRSTG, by itself, creates a new FIRSTG or raises the existing
%      singleton*.
%
%      H = FIRSTG returns the handle to a new FIRSTG or the handle to
%      the existing singleton*.
%
%      FIRSTG('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FIRSTG.M with the given input arguments.
%
%      FIRSTG('Property','Value',...) creates a new FIRSTG or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before firstg_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to firstg_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help firstg

% Last Modified by GUIDE v2.5 10-Sep-2013 13:53:00

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @firstg_OpeningFcn, ...
                   'gui_OutputFcn',  @firstg_OutputFcn, ...
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


% --- Executes just before firstg is made visible.
function firstg_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to firstg (see VARARGIN)

set(handles.text1,'String', 'IMAGE ENHANCEMENT');

set(handles.text3,'String', 'Project done by Mahesh Mitikiri');
% Choose default command line output for firstg


handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes firstg wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = firstg_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(handles.slider1,'Value',-100);             
% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

                             
gam=get(handles.slider1,'Value')         % Value of slider sliderValue = get(handles.slider1,'Value');
                                                            %powlaw=2.*((handles.image2).^gam);    %c=1
powlaw=((handles.image2).^gam);

handles.powlaw=powlaw;
           axes(handles.axes1);
           % imshow(handles.powlaw, [handles.low handles.high]);
imshow(handles.powlaw,[]);
            % Choose default command line output for firstg
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in import.
function import_Callback(hObject, eventdata, handles)
% hObject    handle to import (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
          % Gets file pathway and uploads the file.
        try
           [file, pathway] = uigetfile('*.png');
            file_pathway = strcat(pathway, file);
           % load(file_pathway);          %To load jpeg files
        %   handles.image = double(imread(file_pathway));
        
          image=double(imread(file_pathway));
           handles.image=image;

          image2=image;
           handles.image2=image2;
           
         handles.low=min(min(image))
        handles.high=max(max(image))
 
 
 axes(handles.axes1);
 imshow(handles.image,[handles.low handles.high]);

           set(handles.text2,'String', 'File imported: Fingerprint.png'); 
 %imshow(I1,[low high]);
 % I2=I1;
 %handles.I2=I2;
 %imread(file_pathway,png);
            
     catch err
            fprintf('Unable to access file %s',file);
            
        end

        % Format slider
       

       % uicontrol('Style','slider','Min',-100,'Max',100,...
          %'Value',-100,'SliderStep',[0.0005 0.0005])

        MIN = 0.1;
         MAX = 2;
         STEP = 0.1;
         
         set(handles.slider1,'Min', MIN, ...
                           'Max', MAX, ...
                            'Value', MIN, ...
                             'SliderStep', [STEP STEP], ...
                        'Interruptible', 'off'); 

                 %   uicontrol('Style','slider','Min',-100,'Max',100,...
          %'Value',-100,'SliderStep',[0.5 0.5]);
      
      %              set(handles.slider1,'Min', MIN, ...
         %                   'Max', MAX, ...
            %                'Value', MIN, ...
               %             'SliderStep', [0.0005 0.0005]);
        
                            
     %        set(handles.slider1,'Min', MIN, ...
        %                    'Max', MAX, ...
           %                 'SliderStep', [STEP STEP], ...
              %              'Interruptible', 'off'); 
         % Choose default command line output for Example_GUI
        handles.output = hObject;

        % Update handles structure
        guidata(hObject, handles);

        % --- Executes on button press in AdaptHist.
function AdaptHist_Callback(hObject, eventdata, handles)
% hObject    handle to AdaptHist (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.image2=((handles.image2-handles.low)/(handles.high-handles.low));  %Normalizing the imiage of type double to have values in the range [0,1]
handles.image2=handles.image2*255;   %or ((2^16)-1)
handles.im2un=uint8(handles.image2);   %handles.im2un=uint16(handles.image2);

handles.image2=double(adapthisteq(handles.im2un));   %Normalization is ((I-min)/(max-min))*255 and convert to uint8
%J=histeq(handles.image2,100);
%handles.J=J;
 %J=imadjust(J1);

         % Choose default command line output for Example_GUI
         
        axes(handles.axes1);
      %should be into the axes  %
         imshow(handles.image2,[handles.low handles.high]);
  handles.output = hObject;

        % Update handles structure
        guidata(hObject, handles);
        
% --- Executes on button press in hist.
function hist_Callback(hObject, eventdata, handles)
% hObject    handle to hist (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.image2=((handles.image2-handles.low)/(handles.high-handles.low));  %Normalizing the imiage of type double to have values in the range [0,1]
handles.image2=handles.image2*255;   %or ((2^16)-1)
handles.im2un=uint8(handles.image2);   %handles.im2un=uint16(handles.image2);

handles.image2=double(histeq(handles.im2un,100));   %Normalization is ((I-min)/(max-min))*255 and convert to uint8
%J=histeq(handles.image2,100);
%handles.J=J;
 %J=imadjust(J1);

         % Choose default command line output for Example_GUI
         
        axes(handles.axes1);
      %should be into the axes  %
         imshow(handles.image2,[handles.low handles.high]);

           handles.output = hObject;

        % Update handles structure
        guidata(hObject, handles);

% --- Executes on button press in original.
function original_Callback(hObject, eventdata, handles)
% hObject    handle to original (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.image2=handles.image;

axes(handles.axes1);
imshow(handles.image2,[handles.low handles.high]);
                        %Resetting position of slider when the original button is pressed

        MIN = 0.1;
         MAX = 2;
         STEP = 0.1;
         
         set(handles.slider1,'Min', MIN, ...
                           'Max', MAX, ...
                            'Value', MIN, ...
                             'SliderStep', [STEP STEP], ...
                        'Interruptible', 'off'); 


handles.output = hObject;
guidata(hObject, handles);

% --- Executes on button press in save1.
function save1_Callback(hObject, eventdata, handles)
% hObject    handle to save1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%A=A-min(A(:)); % shift data such that the smallest element of A is 0
%A=A/max(A(:)); % normalize the shifted data to 1 
handles.image3=handles.image2;
handles.image2=handles.image2-min(min(handles.image2));
handles.image2=handles.image2/max(max(handles.image2));
imwrite(handles.image2, 'Mitikiri.png','bitdepth',16);

handles.image2=handles.image3;                          %If the user wants to perform adapt hist eq and hist eq on the saved image

handles.output = hObject;
guidata(hObject, handles);
