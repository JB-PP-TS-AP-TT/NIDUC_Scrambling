function varargout = mainView(varargin)
% MAINVIEW MATLAB code for mainView.fig
%      MAINVIEW, by itself, creates a new MAINVIEW or raises the existing
%      singleton*.
%
%      H = MAINVIEW returns the handle to a new MAINVIEW or the handle to
%      the existing singleton*.
%
%      MAINVIEW('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MAINVIEW.M with the given input arguments.
%
%      MAINVIEW('Property','Value',...) creates a new MAINVIEW or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before mainView_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to mainView_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help mainView

% Last Modified by GUIDE v2.5 18-Apr-2018 00:06:57

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @mainView_OpeningFcn, ...
                   'gui_OutputFcn',  @mainView_OutputFcn, ...
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


% --- Executes just before mainView is made visible.
function mainView_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to mainView (see VARARGIN)

% Choose default command line output for mainView
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
movegui(hObject, 'center');
%signalGenerator = SignalGenerator();


% UIWAIT makes mainView wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = mainView_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbuttonGenerateSignal.
function pushbuttonGenerateSignal_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonGenerateSignal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global frame; global probability; global copySignal;
frame = get(handles.editFrame, 'String'); %pobranie stringa z edittexta
disp(frame);
probability = get(handles.editProbability, 'String'); % pobranie stringa z editboxa
disp(probability);
signalGenerator = SignalGenerator(frame, probability);
signal = signalGenerator.generateSignal(); %generuje sygna³
copySignal = signal.copy();
set(handles.textOriginalView, 'String', copySignal.toString());
%-----------------------SCRAMBLER
scrambler = Scrambler();
copySignal = scrambler.scrambleSignal(copySignal);
set(handles.textScramblerView, 'String', copySignal.toString());
%-----------------------KODER
encoder = Encoder();
copySignal = encoder.encode(copySignal);
set(handles.textEncodeView, 'String', copySignal.toString());

function editFrame_Callback(hObject, eventdata, handles)
% hObject    handle to editFrame (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editFrame as text
%        str2double(get(hObject,'String')) returns contents of editFrame as a double


% --- Executes during object creation, after setting all properties.
function editFrame_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editFrame (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editProbability_Callback(hObject, eventdata, handles)
% hObject    handle to editProbability (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editProbability as text
%        str2double(get(hObject,'String')) returns contents of editProbability as a double


% --- Executes during object creation, after setting all properties.
function editProbability_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editProbability (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function textScramblerView_CreateFcn(hObject, eventdata, handles)
% hObject    handle to textScramblerView (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% --- Executes during object creation, after setting all properties.
function textEncodeView_CreateFcn(hObject, eventdata, handles)
% hObject    handle to textEncodeView (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
