function varargout = movieAnalysis(varargin)
% MOVIEANALYSIS MATLAB code for movieAnalysis.fig
%      MOVIEANALYSIS, by itself, creates a new MOVIEANALYSIS or raises the existing
%      singleton*.
%
%      H = MOVIEANALYSIS returns the handle to a new MOVIEANALYSIS or the handle to
%      the existing singleton*.
%
%      MOVIEANALYSIS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MOVIEANALYSIS.M with the given input arguments.
%
%      MOVIEANALYSIS('Property','Value',...) creates a new MOVIEANALYSIS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before movieAnalysis_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to movieAnalysis_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help movieAnalysis

% Last Modified by GUIDE v2.5 27-Jun-2014 10:21:32

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @movieAnalysis_OpeningFcn, ...
                   'gui_OutputFcn',  @movieAnalysis_OutputFcn, ...
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


% --- Executes just before movieAnalysis is made visible.
function movieAnalysis_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to movieAnalysis (see VARARGIN)

% Choose default command line output for movieAnalysis
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

% UIWAIT makes movieAnalysis wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = movieAnalysis_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in runPb.
function runPb_Callback(hObject, eventdata, handles) %#ok<*DEFNU>
% hObject    handle to runPb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if isfield(handles,{'fps','movie'})
    movie(handles.movie,1,handles.fps)
elseif isfield(handles,'fps')
    errordlg('Need to create the movie before running it!')
else
    errordlg('Enter desired frames per second!')
end

% --- Executes on button press in run2xPb.
function run2xPb_Callback(hObject, eventdata, handles)
% hObject    handle to run2xPb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if isfield(handles,{'fps','movie'})
    movie(handles.movie,1,handles.fps*2)
elseif isfield(handles,'fps')
    errordlg('Need to create the movie before running it!')
else
    errordlg('Enter desired frames per second!')
end

% --- Executes on button press in runHalfSpeedPb.
function runHalfSpeedPb_Callback(hObject, eventdata, handles)
% hObject    handle to runHalfSpeedPb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if isfield(handles,{'fps','movie'})
    movie(handles.movie,1,handles.fps*.5)
elseif isfield(handles,'fps')
    errordlg('Need to create the movie before running it!')
else
    errordlg('Enter desired frames per second!')
end


function fpsBox_Callback(hObject, eventdata, handles)
% hObject    handle to fpsBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
val = str2double(get(hObject,'String'));
if ~isnan(val)
    handles.fps = val;
    guidata(hObject,handles)
else
    errordlg('Input must be an integer')
    set(handles.fpsBox,'String','Enter an Integer')
end

% --- Executes during object creation, after setting all properties.
function fpsBox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fpsBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in newDataPb.
function newDataPb_Callback(hObject, eventdata, handles)
% hObject    handle to newDataPb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
selection = questdlg('Are you sure? This will clear everything.',...
                     'Select new data','Yes','No','No');
if strcmp(selection,'No')
    return;
else
    delete(gcf)
    dataInput
end


% --- Executes on button press in createMovPb.
function createMovPb_Callback(hObject, eventdata, handles)
% hObject    handle to createMovPb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if isfield(handles,'fps')
    h = figure('Renderer','zbuffer','NextPlot','replacechildren',...
        'Units','pixels','Position',[100,100,773,502]);
    %width and height come from axes-Outerposition width+5,height-5
    handles.frameLength = round(handles.fs/handles.fps);
    handles.movie = bmfPtsMovie(handles.pCrds,handles.signals,...
                                handles.res,handles.micSep,...
                                handles.aDims,handles.aCrds,handles.fs,...
                                handles.temp,handles.frameLength);
   guidata(hObject,handles)
   close(h)
else
    errordlg('Enter desired frames per second!')
end
