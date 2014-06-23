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

% Last Modified by GUIDE v2.5 23-Jun-2014 15:25:14

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
% hObject    handle to micSep (see GCBO)
% handles    structure with handles and user data (see GUIDATA)
val = str2double(get(hObject,'String'));
if ~isnan(val)
    handles.micSep = val;
    guidata(hObject,handles)
else
    error('Input must be an integer')
end

% --- Executes during object creation, after setting all properties.
function micSep_CreateFcn(hObject, eventdata, handles)
% hObject    handle to micSep (see GCBO)
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function temp_Callback(hObject, eventdata, handles)
% hObject    handle to temp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
val = str2double(get(hObject,'String'));
if ~isnan(val)
    handles.temp = val;
    guidata(hObject,handles)
else
    error('Input must be an integer')
end


% --- Executes during object creation, after setting all properties.
function temp_CreateFcn(hObject, eventdata, handles)
% hObject    handle to temp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function fs_Callback(hObject, eventdata, handles)
% hObject    handle to fs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
val = str2double(get(hObject,'String'));
if ~isnan(val)
    handles.fs = val;
    guidata(hObject,handles)
else
    error('Input must be an integer')
end


% --- Executes during object creation, after setting all properties.
function fs_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function arrayWidth_Callback(hObject, eventdata, handles)
% hObject    handle to arrayWidth (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
val = str2double(get(hObject,'String'));
if ~isnan(val)
    handles.arrayWidth = val;
    guidata(hObject,handles)
else
    error('Input must be an integer')
end


% --- Executes during object creation, after setting all properties.
function arrayWidth_CreateFcn(hObject, eventdata, handles)
% hObject    handle to arrayWidth (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function arrayHeight_Callback(hObject, eventdata, handles)
% hObject    handle to arrayHeight (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
val = str2double(get(hObject,'String'));
if ~isnan(val)
    handles.arrayHeight = val;
    guidata(hObject,handles)
else
    error('Input must be an integer')
end


% --- Executes during object creation, after setting all properties.
function arrayHeight_CreateFcn(hObject, eventdata, handles)
% hObject    handle to arrayHeight (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function x0_Callback(hObject, eventdata, handles)
% hObject    handle to x0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
val = str2double(get(hObject,'String'));
if ~isnan(val)
    handles.x0 = val;
    guidata(hObject,handles)
else
    error('Input must be an integer')
end



% --- Executes during object creation, after setting all properties.
function x0_CreateFcn(hObject, eventdata, handles)
% hObject    handle to x0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function yo_Callback(hObject, eventdata, handles)
% hObject    handle to yo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
val = str2double(get(hObject,'String'));
if ~isnan(val)
    handles.y0 = val;
    guidata(hObject,handles)
else
    error('Input must be an integer')
end


% --- Executes during object creation, after setting all properties.
function yo_CreateFcn(hObject, eventdata, handles)
% hObject    handle to yo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function z0_Callback(hObject, eventdata, handles)
% hObject    handle to z0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
val = str2double(get(hObject,'String'));
if ~isnan(val)
    handles.z0 = val;
    guidata(hObject,handles)
else
    error('Input must be an integer')
end


% --- Executes during object creation, after setting all properties.
function z0_CreateFcn(hObject, eventdata, handles)
% hObject    handle to z0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function x1_Callback(hObject, eventdata, handles)
% hObject    handle to x1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
val = str2double(get(hObject,'String'));
if ~isnan(val)
    handles.x1 = val;
    guidata(hObject,handles)
else
    error('Input must be an integer')
end


% --- Executes during object creation, after setting all properties.
function x1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to x1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function y1_Callback(hObject, eventdata, handles)
% hObject    handle to y1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
val = str2double(get(hObject,'String'));
if ~isnan(val)
    handles.y1 = val;
    guidata(hObject,handles)
else
    error('Input must be an integer')
end


% --- Executes during object creation, after setting all properties.
function y1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to y1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function z1_Callback(hObject, eventdata, handles)
% hObject    handle to z1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
val = str2double(get(hObject,'String'));
if ~isnan(val)
    handles.z1 = val;
    guidata(hObject,handles)
else
    error('Input must be an integer')
end


% --- Executes during object creation, after setting all properties.
function z1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to z1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function xa_Callback(hObject, eventdata, handles)
% hObject    handle to xa (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
val = str2double(get(hObject,'String'));
if ~isnan(val)
    handles.xa = val;
    guidata(hObject,handles)
else
    error('Input must be an integer')
end


% --- Executes during object creation, after setting all properties.
function xa_CreateFcn(hObject, eventdata, handles)
% hObject    handle to xa (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ya_Callback(hObject, eventdata, handles)
% hObject    handle to ya (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
val = str2double(get(hObject,'String'));
if ~isnan(val)
    handles.ya = val;
    guidata(hObject,handles)
else
    error('Input must be an integer')
end


% --- Executes during object creation, after setting all properties.
function ya_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ya (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function za_Callback(hObject, eventdata, handles)
% hObject    handle to za (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
val = str2double(get(hObject,'String'));
if ~isnan(val)
    handles.za = val;
    guidata(hObject,handles)
else
    error('Input must be an integer')
end


% --- Executes during object creation, after setting all properties.
function za_CreateFcn(hObject, eventdata, handles)
% hObject    handle to za (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function xres_Callback(hObject, eventdata, handles)
% hObject    handle to xres (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
val = str2double(get(hObject,'String'));
if ~isnan(val)
    handles.xres = val;
    guidata(hObject,handles)
else
    error('Input must be an integer')
end


% --- Executes during object creation, after setting all properties.
function xres_CreateFcn(hObject, eventdata, handles)
% hObject    handle to xres (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function yres_Callback(hObject, eventdata, handles)
% hObject    handle to yres (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
val = str2double(get(hObject,'String'));
if ~isnan(val)
    handles.yres = val;
    guidata(hObject,handles)
else
    error('Input must be an integer')
end


% --- Executes during object creation, after setting all properties.
function yres_CreateFcn(hObject, eventdata, handles)
% hObject    handle to yres (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in nextButton.
function nextButton_Callback(hObject, eventdata, handles)
% hObject    handle to nextButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
x = handles;
save('handles.mat','x')
disp(handles)


% --- Executes on button press in ldMicData.
function ldMicData_Callback(hObject, eventdata, handles)
% hObject    handle to ldMicData (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[fname,path] = uigetfile('.mat');
han



