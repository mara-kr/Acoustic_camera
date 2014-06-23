function varargout = micDataWarning(varargin)
%MICDATAWARNING M-file for micDataWarning.fig
%      MICDATAWARNING, by itself, creates a new MICDATAWARNING or raises the existing
%      singleton*.
%
%      H = MICDATAWARNING returns the handle to a new MICDATAWARNING or the handle to
%      the existing singleton*.
%
%      MICDATAWARNING('Property','Value',...) creates a new MICDATAWARNING using the
%      given property value pairs. Unrecognized properties are passed via
%      varargin to micDataWarning_OpeningFcn.  This calling syntax produces a
%      warning when there is an existing singleton*.
%
%      MICDATAWARNING('CALLBACK') and MICDATAWARNING('CALLBACK',hObject,...) call the
%      local function named CALLBACK in MICDATAWARNING.M with the given input
%      arguments.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help micDataWarning

% Last Modified by GUIDE v2.5 23-Jun-2014 15:41:50

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @micDataWarning_OpeningFcn, ...
                   'gui_OutputFcn',  @micDataWarning_OutputFcn, ...
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


% --- Executes just before micDataWarning is made visible.
function micDataWarning_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   unrecognized PropertyName/PropertyValue pairs from the
%            command line (see VARARGIN)

% Choose default command line output for micDataWarning
handles.output = hObject;
handles.yes = 0;
handles.no = 0;
% Update handles structure
guidata(hObject, handles);
disp(handles)
% UIWAIT makes micDataWarning wait for user response (see UIRESUME)
% uiwait(handles.warnFig);


% --- Outputs from this function are returned to the command line.
function varargout = micDataWarning_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on key press with focus on warnFig and none of its controls.
function warnFig_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to warnFig (see GCBO)
% eventdata  structure with the following fields (see FIGURE)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)


% --- Executes when user attempts to close warnFig.
function warnFig_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to warnFig (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure
delete(hObject);


% --- Executes on button press in yesPb.
function yesPb_Callback(hObject, eventdata, handles)
% hObject    handle to yesPb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.yes = 1;
guidata(hObject,handles)
close(gcf)
disp(handles)


% --- Executes on button press in noPb.
function noPb_Callback(hObject, eventdata, handles)
% hObject    handle to noPb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.no = 1;
guidata(hObject,handles)
close(gcf)
disp(handles)