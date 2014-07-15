function varargout = micSelect(varargin)
% MICSELECT MATLAB code for micSelect.fig
%      MICSELECT, by itself, creates a new MICSELECT or raises the existing
%      singleton*.
%
%      H = MICSELECT returns the handle to a new MICSELECT or the handle to
%      the existing singleton*.
%
%      MICSELECT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MICSELECT.M with the given input arguments.
%
%      MICSELECT('Property','Value',...) creates a new MICSELECT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before micSelect_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to micSelect_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help micSelect

% Last Modified by GUIDE v2.5 09-Jul-2014 13:51:51

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @micSelect_OpeningFcn, ...
                   'gui_OutputFcn',  @micSelect_OutputFcn, ...
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


% --- Executes just before micSelect is made visible.
function micSelect_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;
handles.m1 = 0;
handles.m2 = 0;
handles.m3 = 0;
handles.m4 = 0;
handles.m5 = 0;
handles.m6 = 0;
handles.m7 = 0;
handles.m8 = 0;
handles.m9 = 0;
handles.m10 = 0;
handles.m11 = 0;
handles.m12 = 0;
handles.m13 = 0;
handles.m14 = 0;
handles.m15 = 0;
handles.m16 = 0;
handles.m17 = 0;
handles.m18 = 0;
handles.m19 = 0;
handles.m20 = 0;
handles.m21 = 0;
handles.m22 = 0;
handles.m23 = 0;
handles.m24 = 0;
handles.m25 = 0;
handles.m26 = 0;
handles.m27 = 0;
handles.m28 = 0;
handles.m29 = 0;
handles.m30 = 0;
guidata(hObject,handles)    
old = load('toMicSelections.mat');
if isfield(old.state,'temp')
    handles.temp = old.state.temp;
end
if isfield(old.state,'fs')
    handles.fs = old.state.fs;
end
if isfield(old.state,'x0')
    handles.x0 = old.state.x0;
end
if isfield(old.state,'y0')
    handles.y0 = old.state.y0;
end
if isfield(old.state,'x1')
    handles.x1 = old.state.x1;
end
if isfield(old.state,'y1')
    handles.y1 = old.state.y1;
end
if isfield(old.state,'zp')
    handles.zp = old.state.zp;
end
if isfield(old.state,'za')
    handles.za = old.state.za;
end
if isfield(old.state,'xres')
    handles.xres = old.state.xres;
end
if isfield(old.state,'yres')
    handles.yres = old.state.yres;
end
handles.micSep = old.state.micSep;
handles.arrayWidth = old.state.arrayWidth;
handles.arrayHeight = old.state.arrayHeight;
handles.xa = old.state.xa;
handles.ya = old.state.ya;
handles.signals = old.state.signals;
guidata(hObject,handles)
delete('toMicSelections.mat')
    

% --- Outputs from this function are returned to the command line.
function varargout = micSelect_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;


% --- Executes on button press in m1Toggle.
function m1Toggle_Callback(hObject, eventdata, handles)
if get(hObject,'Value')
    handles.m1 = 1;
else
    handles.m1 = 0;
end
guidata(hObject,handles)

% --- Executes on button press in m2Toggle.
function m2Toggle_Callback(hObject, eventdata, handles)
if get(hObject,'Value')
    handles.m2 = 1;
else
    handles.m2 = 0;
end
guidata(hObject,handles)

% --- Executes on button press in m3Toggle.
function m3Toggle_Callback(hObject, eventdata, handles)
if get(hObject,'Value')
    handles.m3 = 1;
else
    handles.m3 = 0;
end
guidata(hObject,handles)

% --- Executes on button press in m4Toggle.
function m4Toggle_Callback(hObject, eventdata, handles)
if get(hObject,'Value')
    handles.m4 = 1;
else
    handles.m4 = 0;
end
guidata(hObject,handles)

% --- Executes on button press in m5Toggle.
function m5Toggle_Callback(hObject, eventdata, handles)
if get(hObject,'Value')
    handles.m5 = 1;
else
    handles.m5 = 0;
end
guidata(hObject,handles)

% --- Executes on button press in m6Toggle.
function m6Toggle_Callback(hObject, eventdata, handles)
if get(hObject,'Value')
    handles.m6 = 1;
else
    handles.m6 = 0;
end
guidata(hObject,handles)

% --- Executes on button press in m7Toggle.
function m7Toggle_Callback(hObject, eventdata, handles)
if get(hObject,'Value')
    handles.m7 = 1;
else
    handles.m7 = 0;
end
guidata(hObject,handles)

% --- Executes on button press in m8Toggle.
function m8Toggle_Callback(hObject, eventdata, handles)
if get(hObject,'Value')
    handles.m8 = 1;
else
    handles.m8 = 0;
end
guidata(hObject,handles)

% --- Executes on button press in m9Toggle.
function m9Toggle_Callback(hObject, eventdata, handles)
if get(hObject,'Value')
    handles.m9 = 1;
else
    handles.m9 = 0;
end
guidata(hObject,handles)

% --- Executes on button press in m10Toggle.
function m10Toggle_Callback(hObject, eventdata, handles)
if get(hObject,'Value')
    handles.m10 = 1;
else
    handles.m10 = 0;
end
guidata(hObject,handles)

% --- Executes on button press in m11Toggle.
function m11Toggle_Callback(hObject, eventdata, handles)
if get(hObject,'Value')
    handles.m11 = 1;
else
    handles.m11 = 0;
end
guidata(hObject,handles)

% --- Executes on button press in m12Toggle.
function m12Toggle_Callback(hObject, eventdata, handles)
if get(hObject,'Value')
    handles.m12 = 1;
else
    handles.m12 = 0;
end
guidata(hObject,handles)

% --- Executes on button press in m13Toggle.
function m13Toggle_Callback(hObject, eventdata, handles)
if get(hObject,'Value')
    handles.m13 = 1;
else
    handles.m13 = 0;
end
guidata(hObject,handles)

% --- Executes on button press in m14Toggle.
function m14Toggle_Callback(hObject, eventdata, handles)
if get(hObject,'Value')
    handles.m14 = 1;
else
    handles.m14 = 0;
end
guidata(hObject,handles)

% --- Executes on button press in m15Toggle.
function m15Toggle_Callback(hObject, eventdata, handles)
if get(hObject,'Value')
    handles.m15 = 1;
else
    handles.m15 = 0;
end
guidata(hObject,handles)


% --- Executes on button press in m16Toggle.
function m16Toggle_Callback(hObject, eventdata, handles)
if get(hObject,'Value')
    handles.m16 = 1;
else
    handles.m16 = 0;
end
guidata(hObject,handles)

% --- Executes on button press in m17Toggle.
function m17Toggle_Callback(hObject, eventdata, handles)
if get(hObject,'Value')
    handles.m17 = 1;
else
    handles.m17 = 0;
end
guidata(hObject,handles)

% --- Executes on button press in m18Toggle.
function m18Toggle_Callback(hObject, eventdata, handles)
if get(hObject,'Value')
    handles.m18 = 1;
else
    handles.m18 = 0;
end
guidata(hObject,handles)

% --- Executes on button press in m19Toggle.
function m19Toggle_Callback(hObject, eventdata, handles)
if get(hObject,'Value')
    handles.m19 = 1;
else
    handles.m19 = 0;
end
guidata(hObject,handles)

% --- Executes on button press in m20Toggle.
function m20Toggle_Callback(hObject, eventdata, handles)
if get(hObject,'Value')
    handles.m20 = 1;
else
    handles.m20 = 0;
end
guidata(hObject,handles)

% --- Executes on button press in m21Toggle.
function m21Toggle_Callback(hObject, eventdata, handles)
if get(hObject,'Value')
    handles.m21 = 1;
else
    handles.m21 = 0;
end
guidata(hObject,handles)

% --- Executes on button press in m22Toggle.
function m22Toggle_Callback(hObject, eventdata, handles)
if get(hObject,'Value')
    handles.m22 = 1;
else
    handles.m22 = 0;
end
guidata(hObject,handles)

% --- Executes on button press in m23Toggle.
function m23Toggle_Callback(hObject, eventdata, handles)
if get(hObject,'Value')
    handles.m23 = 1;
else
    handles.m23 = 0;
end
guidata(hObject,handles)

% --- Executes on button press in m24Toggle.
function m24Toggle_Callback(hObject, eventdata, handles)
if get(hObject,'Value')
    handles.m24 = 1;
else
    handles.m24 = 0;
end
guidata(hObject,handles)

% --- Executes on button press in m25Toggle.
function m25Toggle_Callback(hObject, eventdata, handles)
if get(hObject,'Value')
    handles.m25 = 1;
else
    handles.m25 = 0;
end
guidata(hObject,handles)

% --- Executes on button press in m26Toggle.
function m26Toggle_Callback(hObject, eventdata, handles)
if get(hObject,'Value')
    handles.m26 = 1;
else
    handles.m26 = 0;
end
guidata(hObject,handles)

% --- Executes on button press in m27Toggle.
function m27Toggle_Callback(hObject, eventdata, handles)
if get(hObject,'Value')
    handles.m27 = 1;
else
    handles.m27 = 0;
end
guidata(hObject,handles)

% --- Executes on button press in m28Toggle.
function m28Toggle_Callback(hObject, eventdata, handles)
if get(hObject,'Value')
    handles.m28 = 1;
else
    handles.m28 = 0;
end
guidata(hObject,handles)

% --- Executes on button press in m29Toggle.
function m29Toggle_Callback(hObject, eventdata, handles)
if get(hObject,'Value')
    handles.m29 = 1;
else
    handles.m29 = 0;
end
guidata(hObject,handles)

% --- Executes on button press in m30Toggle.
function m30Toggle_Callback(hObject, eventdata, handles)
if get(hObject,'Value')
    handles.m30 = 1;
else
    handles.m30 = 0;
end
guidata(hObject,handles)

function continuePb_Callback(hObject, eventdata, handles)
%   not algorithmically optimal, O(nCols^3*nRows^3). Since we know worst
%   case the simplicity is justified
mics=[handles.m1, handles.m2, handles.m3, handles.m4, handles.m5, handles.m6;...
      handles.m7, handles.m8, handles.m9, handles.m10,handles.m11,handles.m12;...
      handles.m13,handles.m14,handles.m15,handles.m16,handles.m17,handles.m18;...
      handles.m19,handles.m20,handles.m21,handles.m22,handles.m23,handles.m24;...
      handles.m25,handles.m26,handles.m27,handles.m28,handles.m29,handles.m30];
nRows = 5;
nCols = 6; %based on current setup of array
xa = -1;
ya = -1; %(xa,ya) is the coordinates of the lower left mic of maxArea rect
maxArea = 0;
arrayHeight = 0;
arrayWidth = 0;
for x0 = 1:nCols %(x0,y0) is lower left corner, (x1,y1) is upper Right
    for y0 = 1:nRows
        for x1 = x0+1:nCols%skipping rectangles of size 1
            for y1 = y0+1:nRows
                testRect = mics(y0:y1,x0:x1);
                width = (x1-x0+1);
                height = (y1-y0+1);
                area = width*height;
                if all(all(testRect)) && area>maxArea
                    maxArea = area;
                    xa = x0;
                    ya = y0;
                    arrayHeight = height;
                    arrayWidth = width;
                end
            end
        end
    end
end
if maxArea<=1
    errordlg('No rectangle was selected!')
    return
end

%check for only one rectangle
for row=1:arrayHeight
    for col=1:arrayWidth
        mics(ya+row-1,xa+col-1) = 0;
    end
end
if any(any(mics))
    errordlg('Only select one rectangle!')
    return
end
handles.arrayHeight = arrayHeight;
handles.arrayWidth = arrayWidth;
micIndexes = zeros(1,maxArea);
index = 1;
for row=1:arrayHeight
    for col=1:arrayWidth
        micIndexes(index) = 6*(ya+row-2)+xa+col-1;
        index = index + 1;
    end
end
handles.micIndexes = micIndexes;
handles.xa = ((xa-1)*handles.micSep)+handles.xa;
handles.ya = ((ya-1)*handles.micSep)+handles.ya;
guidata(hObject,handles)
save('fromMicSelections.mat','handles')
close(gcf)
dataInput
       
                

% --- Executes on button press in clearPb.
function clearPb_Callback(hObject, eventdata, handles) %#ok<*DEFNU>
handles.m1 = 0;
handles.m2 = 0;
handles.m3 = 0;
handles.m4 = 0;
handles.m5 = 0;
handles.m6 = 0;
handles.m7 = 0;
handles.m8 = 0;
handles.m9 = 0;
handles.m10 = 0;
handles.m11 = 0;
handles.m12 = 0;
handles.m13 = 0;
handles.m14 = 0;
handles.m15 = 0;
handles.m16 = 0;
handles.m17 = 0;
handles.m18 = 0;
handles.m19 = 0;
handles.m20 = 0;
handles.m21 = 0;
handles.m22 = 0;
handles.m23 = 0;
handles.m24 = 0;
handles.m25 = 0;
handles.m26 = 0;
handles.m27 = 0;
handles.m28 = 0;
handles.m29 = 0;
handles.m30 = 0;
set(handles.m1Toggle,'Value',0)
set(handles.m2Toggle,'Value',0)
set(handles.m3Toggle,'Value',0)
set(handles.m4Toggle,'Value',0)
set(handles.m5Toggle,'Value',0)
set(handles.m6Toggle,'Value',0)
set(handles.m7Toggle,'Value',0)
set(handles.m8Toggle,'Value',0)
set(handles.m9Toggle,'Value',0)
set(handles.m10Toggle,'Value',0)
set(handles.m11Toggle,'Value',0)
set(handles.m12Toggle,'Value',0)
set(handles.m13Toggle,'Value',0)
set(handles.m14Toggle,'Value',0)
set(handles.m15Toggle,'Value',0)
set(handles.m16Toggle,'Value',0)
set(handles.m17Toggle,'Value',0)
set(handles.m18Toggle,'Value',0)
set(handles.m19Toggle,'Value',0)
set(handles.m20Toggle,'Value',0)
set(handles.m21Toggle,'Value',0)
set(handles.m22Toggle,'Value',0)
set(handles.m23Toggle,'Value',0)
set(handles.m24Toggle,'Value',0)
set(handles.m25Toggle,'Value',0)
set(handles.m26Toggle,'Value',0)
set(handles.m27Toggle,'Value',0)
set(handles.m28Toggle,'Value',0)
set(handles.m29Toggle,'Value',0)
set(handles.m30Toggle,'Value',0)
