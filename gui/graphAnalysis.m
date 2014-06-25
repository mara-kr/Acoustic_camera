function varargout = graphAnalysis(varargin)
% GRAPHANALYSIS MATLAB code for graphAnalysis.fig
%      GRAPHANALYSIS, by itself, creates a new GRAPHANALYSIS or raises the existing
%      singleton*.
%
%      H = GRAPHANALYSIS returns the handle to a new GRAPHANALYSIS or the handle to
%      the existing singleton*.
%
%      GRAPHANALYSIS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GRAPHANALYSIS.M with the given input arguments.
%
%      GRAPHANALYSIS('Property','Value',...) creates a new GRAPHANALYSIS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before graphAnalysis_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to graphAnalysis_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help graphAnalysis

% Last Modified by GUIDE v2.5 25-Jun-2014 13:18:42

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @graphAnalysis_OpeningFcn, ...
                   'gui_OutputFcn',  @graphAnalysis_OutputFcn, ...
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

% --- Executes just before graphAnalysis is made visible.
function graphAnalysis_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to graphAnalysis (see VARARGIN)

% Choose default command line output for graphAnalysis
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
original = load('handles.mat');
delete('handles.mat')
handles.res = original.handles.res;
handles.micSep = original.handles.micSep;
handles.temp = original.handles.temp;
handles.fs = original.handles.fs;
handles.aDims = original.handles.aDims;
handles.aCrds = original.handles.aCrds;
handles.pCrds = original.handles.pCrds;
handles.signals = original.handles.signals;
handles.original = original;
guidata(hObject, handles);
[handles.stand,handles.subAvg] = bmfPts(handles.pCrds,handles.signals,...
                                        handles.res,handles.micSep,...
                                        handles.aDims,handles.aCrds,...
                                        handles.fs,handles.temp);
guidata(hObject, handles);
if strcmp(get(hObject,'Visible'),'off')
    contour(handles.stand);
end
% UIWAIT makes graphAnalysis wait for user response (see UIRESUME)
% uiwait(handles.graphAnalysisFig);

% --- Outputs from this function are returned to the command line.
function varargout = graphAnalysis_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in dataSelectMenu.
function dataSelectMenu_Callback(hObject, eventdata, handles)
% hObject    handle to dataSelectMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%disp(handles)
%axes(handles.axes);
%cla;

popupSelIndex = get(handles.dataSelectMenu, 'Value');
switch popupSelIndex
    case 1
        contour(handles.stand);
    case 2
        contour(handles.subAvg);
end
% Hints: contents = cellstr(get(hObject,'String')) returns dataSelectMenu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from dataSelectMenu


% --- Executes during object creation, after setting all properties.
function dataSelectMenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dataSelectMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function [stand,subAvg] = beamform(handles)
pCrds = handles.pCrds;
signals = handles.signals;
micSep = handles.micSep;
aDims = handles.aDims;
res = handles.res;
aCrds = handles.aCrds;
fs = handles.fs;
temp = handles.temp;
[stand,subAvg] = bmfPts(pCrds,signals,res,micSep,aDims,aCrds,fs,temp);

% --- Executes on button press in depthInPb.
function depthInPb_Callback(hObject, eventdata, handles)
% hObject    handle to depthInPb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
pause(.1)
pCrds = handles.pCrds;
z = pCrds(1,3);
z = z+5;
pCrds(1,3) = z;
pCrds(2,3) = z;
handles.pCrds = pCrds;
guidata(hObject,handles)
[handles.stand,handles.subAvg] = beamform(handles);
guidata(hObject,handles)
dataSelectMenu_Callback(hObject,eventdata,handles)



% --- Executes on button press in depthDecPb.
function depthDecPb_Callback(hObject, eventdata, handles)
% hObject    handle to depthDecPb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
pause(.1)
pCrds = handles.pCrds;
z = pCrds(1,3);
z = z-5;
pCrds(1,3) = z;
pCrds(2,3) = z;
handles.pCrds = pCrds;
guidata(hObject,handles)
[handles.stand,handles.subAvg] = beamform(handles);
guidata(hObject,handles)
dataSelectMenu_Callback(hObject,eventdata,handles)

% --- Executes on button press in panRightPb.
function panRightPb_Callback(hObject, eventdata, handles)
% hObject    handle to panRightPb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
pause(.1)
pCrds = handles.pCrds;
x0 = pCrds(1,1);
x1 = pCrds(2,1);
dx = abs(x0-x1);
step = floor(dx/10); %change for faster panning
pCrds(1,1) = x0+step;
pCrds(2,1) = x1+step;
handles.pCrds = pCrds;
guidata(hObject,handles)
[handles.stand,handles.subAvg] = beamform(handles);
guidata(hObject,handles)
dataSelectMenu_Callback(hObject,eventdata,handles)


% --- Executes on button press in panDownPb.
function panDownPb_Callback(hObject, eventdata, handles)
% hObject    handle to panDownPb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
pause(.1)
pCrds = handles.pCrds;
y0 = pCrds(1,2);
y1 = pCrds(2,2);
dy = abs(y0-y1);
step = floor(dy/10); %change for faster panning
pCrds(1,2) = y0-step;
pCrds(2,2) = y1-step;
handles.pCrds = pCrds;
guidata(hObject,handles)
[handles.stand,handles.subAvg] = beamform(handles);
guidata(hObject,handles)
dataSelectMenu_Callback(hObject,eventdata,handles)

% --- Executes on button press in panLeftPb.
function panLeftPb_Callback(hObject, eventdata, handles)
% hObject    handle to panLeftPb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
pause(.1)
pCrds = handles.pCrds;
x0 = pCrds(1,1);
x1 = pCrds(2,1);
dx = abs(x0-x1);
step = floor(dx/10); %change for faster panning
pCrds(1,1) = x0-step;
pCrds(2,1) = x1-step;
handles.pCrds = pCrds;
guidata(hObject,handles)
[handles.stand,handles.subAvg] = beamform(handles);
guidata(hObject,handles)
dataSelectMenu_Callback(hObject,eventdata,handles)

% --- Executes on button press in panUpPb.
function panUpPb_Callback(hObject, eventdata, handles)
% hObject    handle to panUpPb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
pause(.1)
pCrds = handles.pCrds;
y0 = pCrds(1,2);
y1 = pCrds(2,2);
dy = abs(y0-y1);
step = floor(dy/10); %change for faster panning
pCrds(1,2) = y0+step;
pCrds(2,2) = y1+step;
handles.pCrds = pCrds;
guidata(hObject,handles)
[handles.stand,handles.subAvg] = beamform(handles);
guidata(hObject,handles)
dataSelectMenu_Callback(hObject,eventdata,handles)


% --- Executes on button press in resetPb.
function resetPb_Callback(hObject, eventdata, handles)
% hObject    handle to resetPb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
original = handles.original;
handles.res = original.handles.res;
handles.micSep = original.handles.micSep;
handles.temp = original.handles.temp;
handles.fs = original.handles.fs;
handles.aDims = original.handles.aDims;
handles.aCrds = original.handles.aCrds;
handles.pCrds = original.handles.pCrds;
handles.signals = original.handles.signals;
[handles.stand,handles.subAvg] = bmfPts(handles.pCrds,handles.signals,...
                                        handles.res,handles.micSep,...
                                        handles.aDims,handles.aCrds,...
                                        handles.fs,handles.temp);
guidata(hObject,handles)
dataSelectMenu_Callback(hObject,eventdata,handles)


% --- Executes on button press in viewPCrdsPb.
function viewPCrdsPb_Callback(hObject, eventdata, handles)
% hObject    handle to viewPCrdsPb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
disp(handles.pCrds)


% --- Executes on button press in newDataPb.
function newDataPb_Callback(hObject, eventdata, handles)
% hObject    handle to newDataPb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%disp(handles.original.handles)
selection = questdlg(['Are you sure? This will clear everything.'],...
                     ['Select new data'],'Yes','No','No');
if strcmp(selection,'No')
    return;
else
    delete(gcf)
    dataInput
end

