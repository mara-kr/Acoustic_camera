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

% Last Modified by GUIDE v2.5 09-Jul-2014 16:58:44

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
handles.output = hObject;
guidata(hObject, handles);
if exist('ndrqwertyuiop.mat','file')
    state = load('ndrqwertyuiop.mat');
    delete('ndrqwertyuiop.mat')
    handles.micSep = state.handles.micSep;
    set(handles.micSepBox,'String',handles.micSep)
    handles.temp = state.handles.temp;
    set(handles.tempBox,'String',handles.temp)
    handles.fs = state.handles.fs;
    set(handles.fsBox,'String',handles.fs)
    handles.x0 = state.handles.pCrds(1,1);
    set(handles.x0Box,'String',handles.x0)
    handles.y0 = state.handles.pCrds(1,2);
    set(handles.y0Box,'String',handles.y0)
    handles.x1 = state.handles.pCrds(2,1);
    set(handles.x1Box,'String',handles.x1)
    handles.y1 = state.handles.pCrds(2,2);
    set(handles.y1Box,'String',handles.y1)
    handles.zp = state.handles.pCrds(1,3);
    set(handles.zpBox,'String',handles.zp)
    handles.arrayWidth = state.handles.aDims(1);
    set(handles.arrayWidthBox,'String',handles.arrayWidth)
    handles.arrayHeight = state.handles.aDims(2);
    set(handles.arrayHeightBox,'String',handles.arrayHeight)
    handles.xa = state.handles.aCrds(1);
    set(handles.xaBox,'String',handles.xa)
    handles.ya = state.handles.aCrds(2);
    set(handles.yaBox,'String',handles.ya)
    handles.za = state.handles.aCrds(3);
    set(handles.zaBox,'String',handles.za)
    handles.signals = state.handles.signals;
    handles.xres = state.handles.res(1);
    set(handles.xresBox,'String',handles.xres)
    handles.yres = state.handles.res(2);
    set(handles.yresBox,'String',handles.yres)
    guidata(hObject,handles)
end
if exist('fromMicSelections.mat','file')
    state = load('fromMicSelections.mat');
    delete('fromMicSelections.mat')
    handles.arrayHeight = state.handles.arrayHeight;%new arrayHeight/width
    set(handles.arrayHeightBox,'String',handles.arrayHeight)
    handles.arrayWidth = state.handles.arrayWidth;
    set(handles.arrayWidthBox,'String',handles.arrayWidth)
    handles.xa = state.handles.xa;%gives new xa coordinate
    set(handles.xaBox,'String',handles.xa)
    handles.ya = state.handles.ya;%gives new ya coordinate
    set(handles.yaBox,'String',handles.ya)
    handles.micSep = state.handles.micSep;
    set(handles.micSepBox,'String',handles.micSep)
    micIndexes = state.handles.micIndexes;
    signals = state.handles.signals;
    sampLength = size(signals,1);%num rows
    data = zeros(sampLength,length(micIndexes));
    for index=1:length(micIndexes)%creates new signals array
        data(:,index) = signals(:,micIndexes(index));
    end
    handles.signals = data;
    if isfield(state.handles,'temp')
        handles.temp = state.handles.temp;
        set(handles.tempBox,'String',handles.temp)
    end
    if isfield(state.handles,'fs')
        handles.fs = state.handles.fs;
        set(handles.fsBox,'String',handles.fs)
    end
    if isfield(state.handles,'x0')
        handles.x0 = state.handles.x0;
        set(handles.x0Box,'String',handles.x0)
    end
    if isfield(state.handles,'y0')
        handles.y0 = state.handles.y0;
        set(handles.y0Box,'String',handles.y0)
    end
    if isfield(state.handles,'x1')
        handles.x1 = state.handles.x1;
        set(handles.x1Box,'String',handles.x1)
    end
    if isfield(state.handles,'y1')
        handles.y1 = state.handles.y1;
        set(handles.y1Box,'String',handles.y1)
    end
    if isfield(state.handles,'zp')
        handles.zp = state.handles.zp;
        set(handles.zpBox,'String',handles.zp)
    end
    if isfield(state.handles,'za')
        handles.za = state.handles.za;
        set(handles.zaBox,'String',handles.za)
    end
    if isfield(state.handles,'xres')
        handles.xres = state.handles.xres;
        set(handles.xresBox,'String',handles.xres)
    end
    if isfield(state.handles,'yres')
        handles.yres = state.handles.yres;
        set(handles.yresBox,'String',handles.yres)
    end
    guidata(hObject,handles)
end


% --- Outputs from this function are returned to the command line.
function varargout = dataInput_OutputFcn(hObject, eventdata, handles)
varargout{1} = handles.output;



function micSepBox_Callback(hObject, eventdata, handles) 
val = str2double(get(hObject,'String'));
if ~isnan(val)
    handles.micSep = val;
    guidata(hObject,handles)
else
    errordlg('Input must be an integer')
    set(handles.micSepBox,'String','in inches')
end


function micSepBox_CreateFcn(hObject, eventdata, handles) %#ok<*DEFNU>
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function tempBox_Callback(hObject, eventdata, handles)
val = str2double(get(hObject,'String'));
if ~isnan(val)
    handles.temp = val;
    guidata(hObject,handles)
else
    errordlg('Input must be an integer')
    set(handles.tempBox,'String','degrees F')
end


function tempBox_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function fsBox_Callback(hObject, eventdata, handles)
val = str2double(get(hObject,'String'));
if ~isnan(val)
    handles.fs = val;
    guidata(hObject,handles)
else
    errordlg('Input must be an integer')
    set(handles.fsBox,'String','Hertz')
end


function fsBox_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function arrayWidthBox_Callback(hObject, eventdata, handles)
val = str2double(get(hObject,'String'));
if ~isnan(val)
    handles.arrayWidth = val;
    guidata(hObject,handles)
else
    errordlg('Input must be an integer')
    set(handles.arrayWidthBox,'String','# mics')
end


function arrayWidthBox_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function arrayHeightBox_Callback(hObject, eventdata, handles)
val = str2double(get(hObject,'String'));
if ~isnan(val)
    handles.arrayHeight = val;
    guidata(hObject,handles)
else
    errordlg('Input must be an integer')
    set(handles.arrayHeightBox,'String','# mics')
end


function arrayHeightBox_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function x0Box_Callback(hObject, eventdata, handles)
val = str2double(get(hObject,'String'));
if ~isnan(val)
    handles.x0 = val;
    guidata(hObject,handles)
else
    errordlg('Input must be an integer')
    set(handles.x0Box,'String','x0')
end


function x0Box_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function y0Box_Callback(hObject, eventdata, handles)
val = str2double(get(hObject,'String'));
if ~isnan(val)
    handles.y0 = val;
    guidata(hObject,handles)
else
    errordlg('Input must be an integer')
    set(handles.y0Box,'String','y0')
end


function y0Box_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function x1Box_Callback(hObject, eventdata, handles)
val = str2double(get(hObject,'String'));
if ~isnan(val)
    handles.x1 = val;
    guidata(hObject,handles)
else
    errordlg('Input must be an integer')
    set(handles.x1Box,'String','x1')
end


function x1Box_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function y1Box_Callback(hObject, eventdata, handles)
val = str2double(get(hObject,'String'));
if ~isnan(val)
    handles.y1 = val;
    guidata(hObject,handles)
else
    errordlg('Input must be an integer')
    set(handles.y1Box,'String','y1')
end


function y1Box_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function zpBox_Callback(hObject, eventdata, handles)
val = str2double(get(hObject,'String'));
if ~isnan(val)
    handles.zp = val;
    guidata(hObject,handles)
else
    errordlg('Input must be an integer')
    set(handles.z1Box,'String','zp')
end


function zpBox_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function xaBox_Callback(hObject, eventdata, handles)
val = str2double(get(hObject,'String'));
if ~isnan(val)
    handles.xa = val;
    guidata(hObject,handles)
else
    errordlg('Input must be an integer')
    set(handles.xaBox,'String','xa')
end


function xaBox_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function yaBox_Callback(hObject, eventdata, handles)
val = str2double(get(hObject,'String'));
if ~isnan(val)
    handles.ya = val;
    guidata(hObject,handles)
else
    errordlg('Input must be an integer')
    set(handles.yaBox,'String','ya')
end


function yaBox_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function zaBox_Callback(hObject, eventdata, handles)
val = str2double(get(hObject,'String'));
if ~isnan(val)
    handles.za = val;
    guidata(hObject,handles)
else
    errordlg('Input must be an integer')
    set(handles.zaBox,'String','za')
end


function zaBox_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function xresBox_Callback(hObject, eventdata, handles)
val = str2double(get(hObject,'String'));
if ~isnan(val)
    handles.xres = val;
    guidata(hObject,handles)
else
    errordlg('Input must be an integer')
    set(handles.xresBox,'String','xres')
end


function xresBox_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function yresBox_Callback(hObject, eventdata, handles)
val = str2double(get(hObject,'String'));
if ~isnan(val)
    handles.yres = val;
    guidata(hObject,handles)
else
    errordlg('Input must be an integer')
    set(handles.yresBox,'String','yres')
end


function yresBox_CreateFcn(hObject, eventdata, handles) %#ok<*INUSD>
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in toPanButton.
function toPanButton_Callback(hObject, ~, handles)
if isfield(handles,{'x0','y0','x1','y1','zp','xa','ya','za',...
                    'micSep','temp','fs','arrayWidth','arrayHeight',...
                    'xres','yres','signals'})
    if handles.xa<handles.x0 || handles.xa>handles.x1
        errordlg('Xa must be between x0 and x1 (inclusive)!')
        return
    end
    if handles.ya<handles.y0 || handles.ya>handles.y1
        errordlg('Ya must be between y0 and y1 (inclusive)!')
    end
    if length(handles.signals)>150000
        dlg=strcat('Signals are over 150k samples. Processing will',...
                   ' be long for panning. Do you want to continue?');
        selection = questdlg(dlg,'Long Signals','Yes','No','No');
        if strcmp(selection,'No')
            return;
        end
    end
    handles.pCrds = [handles.x0,handles.y0,handles.zp;...
        handles.x1,handles.y1,handles.zp];
    handles.aCrds = [handles.xa,handles.ya,handles.za];
    handles.aDims = [handles.arrayWidth,handles.arrayHeight];
    handles.res = [handles.xres,handles.yres];
    guidata(hObject,handles)
    save('ndrqwertyuiop.mat','handles')
    close(gcf)
    graphAnalysis
elseif isfield(handles,{'x0','y0','x1','y1','zp','xa','ya','za',...
                    'micSep','temp','fs','arrayWidth','arrayHeight',...
                    'xres','yres'})
    errordlg('Need to load mic data!')
else
    errordlg('Need to input all variables!')
end

% --- Executes on button press in ldMicData.
function ldMicData_Callback(hObject, eventdata, handles)
if isfield(handles,'signals')
    answer = questdlg('Signals data already exists. Overwrite?',...
                      'Overwrite?','Yes','No','No');
    if strcmp(answer,'No')
        return
    elseif strcmp(answer,'')%user closed dlg box
        return
    end
end
dlg = strcat('Load mic data from signals variable inside .mat file,',...
             ' or load data from an Audacity export?');
selection = questdlg(dlg,'Load Mic Data','.mat File','Audacity export',...
                     '.mat File');
if strcmp(selection,'.mat File')
    %signals array variable should be called signals!
    [fname,path] = uigetfile('.mat');
    if fname~=0
        ld = load(strcat(path,fname));
        if isfield(ld,'signals')
            handles.signals = ld.signals;
            guidata(hObject,handles)
        else
            errordlg('Mic Data must be stored in variable called signals!')
        end
    else
        return
    end
elseif strcmp(selection,'Audacity export')
    handles.signals = importMics();
    if size(handles.signals)~=[1,1]%importMics didn't return prematurely
        guidata(hObject,handles)
    end
else
    return
end


% --- Executes on button press in savePb.
function savePb_Callback(hObject, eventdata, handles)%saves in working dir
if isfield(handles,'x0')
    state.x0 = handles.x0;
end
if isfield(handles,'y0')
    state.y0 = handles.y0;
end
if isfield(handles,'x1')
    state.x1 = handles.x1;
end
if isfield(handles,'y1')
    state.y1 = handles.y1;
end
if isfield(handles,'zp')
    state.zp = handles.zp;
end
if isfield(handles,'micSep')
    state.micSep = handles.micSep;
end
if isfield(handles,'temp')
    state.temp = handles.temp;
end
if isfield(handles,'fs')
    state.fs = handles.fs;
end
if isfield(handles,'arrayWidth')
    state.arrayWidth = handles.arrayWidth;
end
if isfield(handles,'arrayHeight')
    state.arrayHeight = handles.arrayHeight;
end
if isfield(handles,'xres')
    state.xres = handles.xres;
end
if isfield(handles,'yres')
    state.yres = handles.yres;
end
if isfield(handles,'xa')
    state.xa = handles.xa;
end
if isfield(handles,'ya')
    state.ya = handles.ya;
end
if isfield(handles,'za')
    state.za = handles.za;
end
if isfield(handles,'signals')
    state.signals = handles.signals;  %#ok<STRNU>
end
if exist('state') %#ok<EXIST>
    [fname,path] = uiputfile('*.mat');
    if ~isempty(fname)
        save(strcat(path,fname),'state')
    else
        return
    end
else
    errordlg('Must have data inputed to save a state!')
end

% --- Executes on button press in loadPb.
function loadPb_Callback(hObject, eventdata, handles)
[fname,path] = uigetfile('.mat');
if fname~=0
    old = load(strcat(path,fname));
else
    return
end
if isfield(old.state,'micSep')
    set(handles.micSepBox,'String',old.state.micSep)
    handles.micSep = old.state.micSep;
end
if isfield(old.state,'temp')
    set(handles.tempBox,'String',old.state.temp)
    handles.temp = old.state.temp;
end
if isfield(old.state,'fs')
    set(handles.fsBox,'String',old.state.fs)
    handles.fs = old.state.fs;
end
if isfield(old.state,'arrayWidth')
    set(handles.arrayWidthBox,'String',old.state.arrayWidth)
    handles.arrayWidth = old.state.arrayWidth;
end
if isfield(old.state,'arrayHeight')
    set(handles.arrayHeightBox,'String',old.state.arrayHeight)
    handles.arrayHeight = old.state.arrayHeight;
end
if isfield(old.state,'x0')
    set(handles.x0Box,'String',old.state.x0)
    handles.x0 = old.state.x0;
end
if isfield(old.state,'y0')
    set(handles.y0Box,'String',old.state.y0)
    handles.y0 = old.state.y0;
end
if isfield(old.state,'x1')
    set(handles.x1Box,'String',old.state.x1)
    handles.x1 = old.state.x1;
end
if isfield(old.state,'y1')
    set(handles.y1Box,'String',old.state.y1)
    handles.y1 = old.state.y1;
end
if isfield(old.state,'zp')
    set(handles.zpBox,'String',old.state.zp)
    handles.zp = old.state.zp;
end
if isfield(old.state,'xa')
    set(handles.xaBox,'String',old.state.xa)
    handles.xa = old.state.xa;
end
if isfield(old.state,'ya')
    set(handles.yaBox,'String',old.state.ya)
    handles.ya = old.state.ya;
end
if isfield(old.state,'za')
    set(handles.zaBox,'String',old.state.za)
    handles.za = old.state.za;
end
if isfield(old.state,'xres')
    set(handles.xresBox,'String',old.state.xres)
    handles.xres = old.state.xres;
end
if isfield(old.state,'yres')
    set(handles.yresBox,'String',old.state.yres)
    handles.yres = old.state.yres;
end
if isfield(old.state,'signals')
    handles.signals = old.state.signals;
end
guidata(hObject,handles)


% --- Executes on button press in toMoviePb.
function toMoviePb_Callback(hObject, eventdata, handles)
if isfield(handles,{'x0','y0','x1','y1','zp','xa','ya','za',...
                    'micSep','temp','fs','arrayWidth','arrayHeight',...
                    'xres','yres','signals'})
    if handles.za>=handles.zp
        errordlg('Za must be less than zp!')
        return
    end
    if handles.xa<handles.x0 || handles.xa>handles.x1
        errordlg('Xa must be between x0 and x1 (inclusive)!')
        return
    end
    if handles.ya<handles.y0 || handles.ya>handles.y1
        errordlg('Ya must be between y0 and y1 (inclusive)!')
    end
    if length(handles.signals)<handles.fs
        dlg=strcat('Signals are under one second. Longer movies are',...
                   ' usually more meaningful. Do you want to continue?');
        selection = questdlg(dlg,'Short Signals','Yes','No','No');
        if strcmp(selection,'No')
            return;
        end
    end
    handles.pCrds = [handles.x0,handles.y0,handles.zp;...
        handles.x1,handles.y1,handles.zp];
    handles.aCrds = [handles.xa,handles.ya,handles.za];
    handles.aDims = [handles.arrayWidth,handles.arrayHeight];
    handles.res = [handles.xres,handles.yres];
    guidata(hObject,handles)
    save('ndrqwertyuiop.mat','handles')%avoid namespace error
    close(gcf)
    movieAnalysis;
elseif isfield(handles,{'x0','y0','x1','y1','zp','xa','ya','za',...
                    'micSep','temp','fs','arrayWidth','arrayHeight',...
                    'xres','yres'})
    errordlg('Need to load mic data!')
else
    errordlg('Need to input all variables!')
end


% --- Executes on button press in micSelectPb.
function micSelectPb_Callback(hObject, eventdata, handles) %#ok<*INUSL>
if isfield(handles,{'xa','ya','micSep','arrayWidth','arrayHeight','signals'})
    if isfield(handles,'x0')
        state.x0 = handles.x0;
    end
    if isfield(handles,'y0')
        state.y0 = handles.y0;
    end
    if isfield(handles,'x1')
        state.x1 = handles.x1;
    end
    if isfield(handles,'y1')
        state.y1 = handles.y1;
    end
    if isfield(handles,'zp')
        state.zp = handles.zp;
    end
    if isfield(handles,'temp')
        state.temp = handles.temp;
    end
    if isfield(handles,'fs')
        state.fs = handles.fs;
    end
    if isfield(handles,'xres')
        state.xres = handles.xres;
    end
    if isfield(handles,'yres')
        state.yres = handles.yres;
    end
    if isfield(handles,'za')
        state.za = handles.za;
    end
    state.micSep = handles.micSep;
    state.arrayWidth = handles.arrayWidth;
    state.arrayHeight = handles.arrayHeight;
    if state.arrayWidth~=6 || state.arrayHeight~=5 || size(handles.signals,2)~=30
        errordlg('Must have a 6x5 array to use this tool!')
        return
    end
    state.xa = handles.xa;
    state.ya = handles.ya;
    state.signals = handles.signals; %#ok<STRNU>
    save('toMicSelections.mat','state')
    close(gcf)
    micSelect
else
    errordlg('Need to enter xa, ya, micSep, array width/height, and signals!')
end
