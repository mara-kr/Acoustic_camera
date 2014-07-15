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

% Last Modified by GUIDE v2.5 10-Jul-2014 13:35:08

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
handles.output = hObject;
guidata(hObject, handles);
original = load('ndrqwertyuiop.mat');
delete('ndrqwertyuiop.mat')
handles.res = original.handles.res;
handles.micSep = original.handles.micSep;
handles.temp = original.handles.temp;
handles.fs = original.handles.fs;
handles.aDims = original.handles.aDims;
handles.aCrds = original.handles.aCrds;
handles.pCrds = original.handles.pCrds;
handles.signals = original.handles.signals;
handles.original = original;
handles.currentFrame = 1;
guidata(hObject, handles);


% --- Outputs from this function are returned to the command line.
function varargout = movieAnalysis_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;

function fpsBox_Callback(hObject, eventdata, handles) %#ok<*DEFNU>
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
if ispc && isequal(get(hObject,'BackgroundColor'), ...
                   get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in newDataPb.
function newDataPb_Callback(hObject, eventdata, handles)
selection = questdlg('Keep Variable State?','Select New Data',...
                     'Yes','No','Yes');
if strcmp(selection,'No')
    delete(gcf)
    dataInput
elseif strcmp(selection,'Yes')
    set(handles.doubleSpeedToggle,'Enable','off')
    set(handles.halfSpeedToggle,'Enable','off')
    set(handles.stopPb,'Enable','off')
    set(handles.createMovPb,'Enable','off')
    set(handles.rewindToggle,'Enable','off')
    set(handles.playToggle,'Enable','off')
    set(handles.exportPb,'Enable','off')
    set(handles.newDataPb,'Enable','off')
    save('ndrqwertyuiop.mat','handles')%avoids namespace error
    delete(gcf)
    dataInput
else %figure closed
    return 
end


% --- Executes on button press in createMovPb.
function createMovPb_Callback(hObject, eventdata, handles)
if isfield(handles,'fps')
    set(handles.doubleSpeedToggle,'Enable','off')
    set(handles.halfSpeedToggle,'Enable','off')
    set(handles.stopPb,'Enable','off')
    set(handles.createMovPb,'Enable','off')
    set(handles.rewindToggle,'Enable','off')
    set(handles.playToggle,'Enable','off')
    set(handles.exportPb,'Enable','off')
    set(handles.newDataPb,'Enable','off')
    handles.frameLength = round(handles.fs/handles.fps);
    handles.movie = bmfPtsMovie(handles.pCrds,handles.signals,...
                                handles.res,handles.micSep,...
                                handles.aDims,handles.aCrds,handles.fs,...
                                handles.temp,handles.frameLength);
   numMics = size(handles.signals,2);
   if numMics<6
       handles.zlim = .05;
   elseif numMics>6 && numMics<=10
       handles.zlim = .07;
   elseif numMics>10 && numMics<=14
       handles.zlim = .1;
   elseif numMics>14 && numMics<=22
       handles.zlim = .4;
   else
       handles.zlim = .6;
   end
   nFrames = size(handles.movie,3);
   frameTime = 1/handles.fps;
   set(handles.totalTimeTxt,'String',num2str(nFrames*frameTime,3))
   guidata(hObject,handles)
   set(handles.doubleSpeedToggle,'Enable','on')
   set(handles.halfSpeedToggle,'Enable','on')
   set(handles.stopPb,'Enable','on')
   set(handles.createMovPb,'Enable','on')
   set(handles.rewindToggle,'Enable','on')
   set(handles.playToggle,'Enable','on')
   set(handles.exportPb,'Enable','on')
   set(handles.newDataPb,'Enable','on')
else
    errordlg('Enter desired frames per second!')
end


% --- Executes on selection change in colormapSelectPopUp.
function colormapSelectPopUp_Callback(hObject, eventdata, handles)
popupSelIndex = get(hObject,'Value');
switch popupSelIndex
    case 1
        handles.colormap = 'Jet';
    case 2
        handles.colormap = 'HSV';
    case 3
        handles.colormap = 'Hot';
    case 4
        handles.colormap = 'Cool';
end
guidata(hObject,handles)

% --- Executes during object creation, after setting all properties.
function colormapSelectPopUp_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), ...
                   get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
handles.colormap = 'Jet';
guidata(hObject,handles)


% --- Executes on button press in playToggle.
function playToggle_Callback(hObject, eventdata, handles)
if isfield(handles,'fps') && isfield(handles,'movie')
    nFrames = size(handles.movie,3);
    frameTime = 1/handles.fps;
    if get(hObject,'Value')
        set(hObject,'String','Pause')
        set(handles.doubleSpeedToggle,'Enable','off')
        set(handles.halfSpeedToggle,'Enable','off')
        set(handles.stopPb,'Enable','off')
        set(handles.createMovPb,'Enable','off')
        set(handles.rewindToggle,'Enable','off')
        set(handles.colormapSelectPopUp,'Enable','off')
        set(handles.graphTypePopup,'Enable','off')
        set(handles.exportPb,'Enable','off')
    else
        set(hObject,'String','Play')
        set(handles.doubleSpeedToggle,'Enable','on')
        set(handles.halfSpeedToggle,'Enable','on')
        set(handles.stopPb,'Enable','on')
        set(handles.createMovPb,'Enable','on')
        set(handles.rewindToggle,'Enable','on')
        set(handles.colormapSelectPopUp,'Enable','on')
        set(handles.graphTypePopup,'Enable','on')
        set(handles.exportPb,'Enable','on')
    end
    while get(hObject,'Value') && handles.currentFrame<=nFrames
        data = cell2mat(handles.movie(:,:,handles.currentFrame));
        if strcmp(handles.graphType,'Surf')
            surf(data)
            zlim([0,handles.zlim])
        else
            contour(data)
        end
        colormap(handles.colormap)
        time = num2str(frameTime*handles.currentFrame,3);
        set(handles.timeStamp,'String',time)
        pause(frameTime)
        handles.currentFrame = handles.currentFrame+1;
    end
    if handles.currentFrame==(nFrames+1)%since loop increases it by 1 over
        handles.currentFrame = 1;
        if get(handles.repeatToggle,'Value')
            playToggle_Callback(hObject, eventdata, handles)
        else
            set(hObject,'String','Play')
            set(hObject,'Value',0)
            set(handles.doubleSpeedToggle,'Enable','on')
            set(handles.halfSpeedToggle,'Enable','on')
            set(handles.stopPb,'Enable','on')
            set(handles.createMovPb,'Enable','on')
            set(handles.rewindToggle,'Enable','on')
            set(handles.colormapSelectPopUp,'Enable','on')
            set(handles.graphTypePopup,'Enable','on')
            set(handles.exportPb,'Enable','on')
            set(handles.timeStamp,'String',num2str(0,3))
        end
    end
    guidata(hObject,handles)
elseif isfield(handles,'fps')
    errordlg('Need to create the movie before playing it!')
else
    errordlg('Enter desired frames per second!')
end


% --- Executes on button press in doubleSpeedToggle.
function doubleSpeedToggle_Callback(hObject, eventdata, handles)
if isfield(handles,'fps') && isfield(handles,'movie')
    nFrames = size(handles.movie,3);
    frameTime = 1/handles.fps;
    if get(hObject,'Value')
        set(hObject,'String','Pause')
        set(handles.playToggle,'Enable','off')
        set(handles.halfSpeedToggle,'Enable','off')
        set(handles.stopPb,'Enable','off')
        set(handles.createMovPb,'Enable','off')
        set(handles.rewindToggle,'Enable','off')
        set(handles.colormapSelectPopUp,'Enable','off')
        set(handles.graphTypePopup,'Enable','off')
        set(handles.exportPb,'Enable','off')
    else
        set(hObject,'String','Play 2x Speed')
        set(handles.playToggle,'Enable','on')
        set(handles.halfSpeedToggle,'Enable','on')
        set(handles.stopPb,'Enable','on')
        set(handles.createMovPb,'Enable','on')
        set(handles.rewindToggle,'Enable','on')
        set(handles.colormapSelectPopUp,'Enable','on')
        set(handles.graphTypePopup,'Enable','on')
        set(handles.exportPb,'Enable','on')
    end
    while get(hObject,'Value') && handles.currentFrame<=nFrames
        data = cell2mat(handles.movie(:,:,handles.currentFrame));
        if strcmp(handles.graphType,'Surf')
            surf(data)
            zlim([0,handles.zlim])
        else
            contour(data)
        end
        colormap(handles.colormap)
        time = num2str(frameTime*handles.currentFrame,3);
        set(handles.timeStamp,'String',time)
        pause(frameTime/2)
        handles.currentFrame = handles.currentFrame+1;
    end
    if handles.currentFrame==(nFrames+1)%since loop increases it by 1 over
        handles.currentFrame = 1;
        if get(handles.repeatToggle,'Value')
            doubleSpeedToggle_Callback(hObject, eventdata, handles)
        else
            set(hObject,'Value',0)
            set(hObject,'String','Play 2x Speed')
            set(handles.playToggle,'Enable','on')
            set(handles.halfSpeedToggle,'Enable','on')
            set(handles.stopPb,'Enable','on')
            set(handles.createMovPb,'Enable','on')
            set(handles.rewindToggle,'Enable','on')
            set(handles.colormapSelectPopUp,'Enable','on')
            set(handles.graphTypePopup,'Enable','on')
            set(handles.exportPb,'Enable','on')
            set(handles.timeStamp,'String',num2str(0,3))
        end
    end
    guidata(hObject,handles)
elseif isfield(handles,'fps')
    errordlg('Need to create the movie before playing it!')
else
    errordlg('Enter desired frames per second!')
end

% --- Executes on button press in halfSpeedToggle.
function halfSpeedToggle_Callback(hObject, eventdata, handles)
if isfield(handles,'fps') && isfield(handles,'movie')
    nFrames = size(handles.movie,3);
    frameTime = 1/handles.fps;
    if get(hObject,'Value')
        set(hObject,'String','Pause')
        set(handles.playToggle,'Enable','off')
        set(handles.doubleSpeedToggle,'Enable','off')
        set(handles.stopPb,'Enable','off')
        set(handles.createMovPb,'Enable','off')
        set(handles.rewindToggle,'Enable','off')
        set(handles.colormapSelectPopUp,'Enable','off')
        set(handles.graphTypePopup,'Enable','off')
        set(handles.exportPb,'Enable','off')
    else
        set(hObject,'String','Play 1/2 Speed')
        set(handles.playToggle,'Enable','on')
        set(handles.doubleSpeedToggle,'Enable','on')
        set(handles.stopPb,'Enable','on')
        set(handles.createMovPb,'Enable','on')
        set(handles.rewindToggle,'Enable','on')
        set(handles.colormapSelectPopUp,'Enable','on')
        set(handles.graphTypePopup,'Enable','on')
        set(handles.exportPb,'Enable','on')
    end
    while get(hObject,'Value') && handles.currentFrame<=nFrames
        data = cell2mat(handles.movie(:,:,handles.currentFrame));
        if strcmp(handles.graphType,'Surf')
            surf(data)
            zlim([0,handles.zlim])
        else
            contour(data)
        end
        colormap(handles.colormap)
        time = num2str(frameTime*handles.currentFrame,3);
        set(handles.timeStamp,'String',time)
        pause(frameTime*2)
        handles.currentFrame = handles.currentFrame+1;
    end
    if handles.currentFrame==(nFrames+1)%since loop increases it by 1 over
        handles.currentFrame = 1;
        if get(handles.repeatToggle,'Value')
            halfSpeedToggle_Callback(hObject, eventdata, handles)
        else
            set(hObject,'Value',0)
            set(handles.playToggle,'Enable','on')
            set(handles.doubleSpeedToggle,'Enable','on')
            set(handles.stopPb,'Enable','on')
            set(handles.createMovPb,'Enable','on')
            set(handles.rewindToggle,'Enable','on')
            set(handles.colormapSelectPopUp,'Enable','on')
            set(handles.graphTypePopup,'Enable','on')
            set(handles.exportPb,'Enable','on')
            set(handles.timeStamp,'String',num2str(0,3))
        end
    end
    guidata(hObject,handles)
elseif isfield(handles,'fps')
    errordlg('Need to create the movie before playing it!')
else
    errordlg('Enter desired frames per second!')
end

% --- Executes on button press in stopPb.
function stopPb_Callback(hObject, eventdata, handles)
set(handles.halfSpeedToggle,'Value',0)
set(handles.playToggle,'Value',0)
set(handles.doubleSpeedToggle,'Value',0)
set(handles.rewindToggle,'Enable','off')
handles.currentFrame = 1;
guidata(hObject,handles)


% --- Executes on button press in rewindToggle.
function rewindToggle_Callback(hObject, eventdata, handles)
if isfield(handles,'fps') && isfield(handles,'movie')
    nFrames = size(handles.movie,3);
    frameTime = 1/handles.fps;
    if get(hObject,'Value')
        set(hObject,'String','Rewinding')
        set(handles.playToggle,'Enable','off')
        set(handles.doubleSpeedToggle,'Enable','off')
        set(handles.stopPb,'Enable','off')
        set(handles.halfSpeedToggle,'Enable','off')
        set(handles.createMovPb,'Enable','off')
        set(handles.colormapSelectPopUp,'Enable','off')
        set(handles.graphTypePopup,'Enable','off')
        set(handles.exportPb,'Enable','off')
    else
        set(hObject,'String','Rewind')
        set(handles.playToggle,'Enable','on')
        set(handles.doubleSpeedToggle,'Enable','on')
        set(handles.halfSpeedToggle,'Enable','on')
        set(handles.stopPb,'Enable','on')
        set(handles.createMovPb,'Enable','on')
        set(handles.colormapSelectPopUp,'Enable','on')
        set(handles.graphTypePopup,'Enable','on')
        set(handles.exportPb,'Enable','on')
    end
    while get(hObject,'Value') && handles.currentFrame>1
        data = cell2mat(handles.movie(:,:,handles.currentFrame));
        if strcmp(handles.graphType,'Surf')
            surf(data)
            zlim([0,handles.zlim])
        else
            contour(data)
        end
        colormap(handles.colormap)
        time = num2str(frameTime*handles.currentFrame,3);
        set(handles.timeStamp,'String',time)
        pause(frameTime)
        handles.currentFrame = handles.currentFrame-1;
    end
    if handles.currentFrame==(nFrames+1)%since loop increases it by 1 over
        handles.currentFrame = 1;
    else
        set(hObject,'Value',0)
        set(hObject,'String','Rewind')
        set(handles.playToggle,'Enable','on')
        set(handles.doubleSpeedToggle,'Enable','on')
        set(handles.halfSpeedToggle,'Enable','on')
        set(handles.stopPb,'Enable','on')
        set(handles.createMovPb,'Enable','on')
        set(handles.colormapSelectPopUp,'Enable','on')
        set(handles.graphTypePopup,'Enable','on')
        set(handles.exportPb,'Enable','on')
        set(handles.timeStamp,'String',num2str(0,3))
    end
    guidata(hObject,handles)
elseif isfield(handles,'fps')
    errordlg('Need to create the movie before playing it!')
else
    errordlg('Enter desired frames per second!')
end


% --- Executes on button press in repeatToggle.
function repeatToggle_Callback(hObject, eventdata, handles)
if get(hObject,'Value')
    set(hObject,'String','Repeat On')
    set(hObject,'backg',[.4 .8 .6])
else
    set(hObject,'String','Repeat Off')
    set(hObject,'backg',[.94 .94 .94])
end


% --- Executes on button press in exportPb.
function exportPb_Callback(hObject, eventdata, handles)
if isfield(handles,'movie') && isfield(handles,'fps')
    [fname,path] = uiputfile('*.avi');
    if fname==0
        return
    end
    set(handles.playToggle,'Enable','off')
    set(handles.doubleSpeedToggle,'Enable','off')
    set(handles.halfSpeedToggle,'Enable','off')
    set(handles.stopPb,'Enable','off')
    set(handles.createMovPb,'Enable','off')
    set(handles.rewindToggle,'Enable','off')
    set(handles.colormapSelectPopUp,'Enable','off')
    set(handles.graphTypePopup,'Enable','off')
    frameLength = handles.fs/handles.fps;
    nFrames = ceil(length(handles.signals(:,1))/frameLength);
    m = struct('cdata', cell(1,nFrames), 'colormap', cell(1,nFrames));
    for frame=1:nFrames
        data = cell2mat(handles.movie(:,:,frame));
        if strcmp(handles.graphType,'Surf')
            surf(data)
            zlim([0,handles.zlim])
        else
            contour(data)
        end
        colormap(handles.colormap)
        m(frame) = getframe;
    end
    name = strcat(path,fname);
    movie2avi(m, name, 'fps', handles.fps,...
              'compression','None')
    set(handles.playToggle,'Enable','on')
    set(handles.doubleSpeedToggle,'Enable','on')
    set(handles.halfSpeedToggle,'Enable','on')
    set(handles.stopPb,'Enable','on')
    set(handles.createMovPb,'Enable','on')
    set(handles.rewindToggle,'Enable','on')
    set(handles.colormapSelectPopUp,'Enable','on')
    set(handles.graphTypePopup,'Enable','on')
elseif isfield(handles,'fps')
    errordlg('Need to create movie before exporting it!')
else
    errordlg('Need to input desired frames per second!')
end

% --- Executes on selection change in graphTypePopup.
function graphTypePopup_Callback(hObject, eventdata, handles)
if get(hObject,'Value') == 1
    handles.graphType = 'Contour';
elseif get(hObject,'Value') == 2
    handles.graphType = 'Surf';
end
guidata(hObject,handles)

% --- Executes during object creation, after setting all properties.
function graphTypePopup_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), ...
                   get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
handles.graphType = 'Contour';
guidata(hObject,handles)