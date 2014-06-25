%See bmfPts.m for documentation on variable meanings!
function varargout = dataInput(varargin)
%DATAINPUT M-file for dataInput.fig
%      DATAINPUT, by itself, creates a new DATAINPUT or raises the existing
%      singleton*.
%
%      H = DATAINPUT returns the handle to a new DATAINPUT or the handle to
%      the existing singleton*.
%
%      DATAINPUT('Property','Value',...) creates a new DATAINPUT using the
%      given property value pairs. Unrecognized properties are passed via
%      varargin to dataInput_OpeningFcn.  This calling syntax produces a
%      warning when there is an existing singleton*.
%
%      DATAINPUT('CALLBACK') and DATAINPUT('CALLBACK',hObject,...) call the
%      local function named CALLBACK in DATAINPUT.M with the given input
%      arguments.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help dataInput

% Last Modified by GUIDE v2.5 25-Jun-2014 15:17:44

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @dataInput_OpeningFcn, ...
                   'gui_OutputFcn',  @dataInput_OutputFcn, ...
                   'gui_LayoutFcn',  [], ...
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


% --- Executes just before dataInput is made visible.
function dataInput_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   unrecognized PropertyName/PropertyValue pairs from the
%            command line (see VARARGIN)

% Choose default command line output for dataInput
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes dataInput wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = dataInput_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function micSep_Callback(hObject, eventdata, handles)
val = str2double(get(hObject,'String'));
if ~isnan(val)
    handles.micSep = val;
    guidata(hObject,handles)
else
    error('Input must be an integer')
end


function micSep_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function temp_Callback(hObject, eventdata, handles)
val = str2double(get(hObject,'String'));
if ~isnan(val)
    handles.temp = val;
    guidata(hObject,handles)
else
    error('Input must be an integer')
end


function temp_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function fs_Callback(hObject, eventdata, handles)
val = str2double(get(hObject,'String'));
if ~isnan(val)
    handles.fs = val;
    guidata(hObject,handles)
else
    error('Input must be an integer')
end


function fs_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function arrayWidth_Callback(hObject, eventdata, handles)
val = str2double(get(hObject,'String'));
if ~isnan(val)
    handles.arrayWidth = val;
    guidata(hObject,handles)
else
    error('Input must be an integer')
end


function arrayWidth_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function arrayHeight_Callback(hObject, eventdata, handles)
val = str2double(get(hObject,'String'));
if ~isnan(val)
    handles.arrayHeight = val;
    guidata(hObject,handles)
else
    error('Input must be an integer')
end


function arrayHeight_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function x0_Callback(hObject, eventdata, handles)
val = str2double(get(hObject,'String'));
if ~isnan(val)
    handles.x0 = val;
    guidata(hObject,handles)
else
    error('Input must be an integer')
end


function x0_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function yo_Callback(hObject, eventdata, handles)
val = str2double(get(hObject,'String'));
if ~isnan(val)
    handles.y0 = val;
    guidata(hObject,handles)
else
    error('Input must be an integer')
end


function yo_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function z0_Callback(hObject, eventdata, handles)
val = str2double(get(hObject,'String'));
if ~isnan(val)
    handles.z0 = val;
    guidata(hObject,handles)
else
    error('Input must be an integer')
end

function z0_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function x1_Callback(hObject, eventdata, handles)
val = str2double(get(hObject,'String'));
if ~isnan(val)
    handles.x1 = val;
    guidata(hObject,handles)
else
    error('Input must be an integer')
end

function x1_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function y1_Callback(hObject, eventdata, handles)
val = str2double(get(hObject,'String'));
if ~isnan(val)
    handles.y1 = val;
    guidata(hObject,handles)
else
    error('Input must be an integer')
end

function y1_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function z1_Callback(hObject, eventdata, handles)
val = str2double(get(hObject,'String'));
if ~isnan(val)
    handles.z1 = val;
    guidata(hObject,handles)
else
    error('Input must be an integer')
end

function z1_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function xa_Callback(hObject, eventdata, handles)
val = str2double(get(hObject,'String'));
if ~isnan(val)
    handles.xa = val;
    guidata(hObject,handles)
else
    error('Input must be an integer')
end


function xa_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function ya_Callback(hObject, eventdata, handles)
val = str2double(get(hObject,'String'));
if ~isnan(val)
    handles.ya = val;
    guidata(hObject,handles)
else
    error('Input must be an integer')
end


function ya_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function za_Callback(hObject, eventdata, handles)
val = str2double(get(hObject,'String'));
if ~isnan(val)
    handles.za = val;
    guidata(hObject,handles)
else
    error('Input must be an integer')
end

function za_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function xres_Callback(hObject, eventdata, handles)
val = str2double(get(hObject,'String'));
if ~isnan(val)
    handles.xres = val;
    guidata(hObject,handles)
else
    error('Input must be an integer')
end

function xres_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function yres_Callback(hObject, eventdata, handles)
val = str2double(get(hObject,'String'));
if ~isnan(val)
    handles.yres = val;
    guidata(hObject,handles)
else
    error('Input must be an integer')
end

function yres_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in nextButton.
function nextButton_Callback(hObject, eventdata, handles)
handles.pCrds = [handles.x0,handles.y0,handles.z0;...
                 handles.x1,handles.y1,handles.z1];
handles.aCrds = [handles.xa,handles.ya,handles.za];
handles.aDims = [handles.arrayWidth,handles.arrayHeight];
handles.res = [handles.xres,handles.yres];
guidata(hObject,handles)
disp(handles)
save('handles.mat','handles')
close(gcf)
graphAnalysis


% --- Executes on button press in ldMicData.
function ldMicData_Callback(hObject, eventdata, handles)
open('micDataWarning.fig')
uiwait(gcf)
cd = pwd;
ld = load(strcat(cd,'\','micDataWarning.mat'));
delete(strcat(cd,'\','micDataWarning.mat'))
if ld.response==1
    %signals array variable should be called signals!
    [fname,path] = uigetfile('.mat');
    ld = load(strcat(path,fname));
    handles.signals = ld.signals;
else
    %if isnumeric('handles.arrayWidth')
    numMic = handles.arrayWidth*handles.arrayHeight;
    handles.signals = selectMicData(numMic);
    %else
    %    error('Must set Array Width and Height before creating mic data!')
    %end
end
guidata(hObject,handles)


% --- Executes on button press in savePb.
function savePb_Callback(hObject, eventdata, handles)%saves in working dir
% hObject    handle to savePb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
state.x0 = handles.x0;
state.y0 = handles.y0;
state.z0 = handles.z0;
state.x1 = handles.x1;
state.y1 = handles.y1;
state.z1 = handles.z1;
state.micSep = handles.micSep;
state.temp = handles.temp;
state.fs = handles.fs;
state.arrayWidth = handles.arrayWidth;
state.arrayHeight = handles.arrayHeight;
state.xres = handles.xres;
state.yres = handles.yres;
state.xa = handles.xa;
state.ya = handles.ya;
state.za = handles.za;
state.signals = handles.signals; %#ok<STRNU>
fname = inputdlg('Enter filename','Save State');
save(strcat(fname{1},'.mat'),'state')


% --- Executes on button press in loadPb.
function loadPb_Callback(hObject, eventdata, handles)
% hObject    handle to loadPb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[fname,path] = uigetfile('.mat');
old = load(strcat(path,fname));




