function varargout = FinalView(varargin)
%FINALVIEW MATLAB code file for FinalView.fig
%      FINALVIEW, by itself, creates a new FINALVIEW or raises the existing
%      singleton*.
%
%      H = FINALVIEW returns the handle to a new FINALVIEW or the handle to
%      the existing singleton*.
%
%      FINALVIEW('Property','Value',...) creates a new FINALVIEW using the
%      given property value pairs. Unrecognized properties are passed via
%      varargin to FinalView_OpeningFcn.  This calling syntax produces a
%      warning when there is an existing singleton*.
%
%      FINALVIEW('CALLBACK') and FINALVIEW('CALLBACK',hObject,...) call the
%      local function named CALLBACK in FINALVIEW.M with the given input
%      arguments.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help FinalView

% Last Modified by GUIDE v2.5 14-May-2018 22:18:54

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @FinalView_OpeningFcn, ...
                   'gui_OutputFcn',  @FinalView_OutputFcn, ...
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


% --- Executes just before FinalView is made visible.
function FinalView_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   unrecognized PropertyName/PropertyValue pairs from the
%            command line (see VARARGIN)

% Choose default command line output for FinalView
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes FinalView wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = FinalView_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in AboutBtn.
function AboutBtn_Callback(hObject, eventdata, handles)
% hObject    handle to AboutBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
msgbox('NiDUC 2 project: Scrambling', 'About');


% --- Executes on slider movement.
function BSCProbabilitySlider_Callback(hObject, eventdata, handles)
% hObject    handle to BSCProbabilitySlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.BSCProbability, 'String', num2str(round(get(handles.BSCProbabilitySlider, 'Value'),2)));
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function BSCProbabilitySlider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to BSCProbabilitySlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function BitsPeriod_Callback(hObject, eventdata, handles)
% hObject    handle to BitsPeriod (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of BitsPeriod as text
%        str2double(get(hObject,'String')) returns contents of BitsPeriod as a double


% --- Executes during object creation, after setting all properties.
function BitsPeriod_CreateFcn(hObject, eventdata, handles)
% hObject    handle to BitsPeriod (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function BSCProbability_Callback(hObject, eventdata, handles)
% hObject    handle to BSCProbability (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.BSCProbabilitySlider, 'Value', str2double(get(handles.BSCProbability, 'String')));
% Hints: get(hObject,'String') returns contents of BSCProbability as text
%        str2double(get(hObject,'String')) returns contents of BSCProbability as a double


% --- Executes during object creation, after setting all properties.
function BSCProbability_CreateFcn(hObject, eventdata, handles)
% hObject    handle to BSCProbability (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function BitsToDesync_Callback(hObject, eventdata, handles)
% hObject    handle to BitsToDesync (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of BitsToDesync as text
%        str2double(get(hObject,'String')) returns contents of BitsToDesync as a double


% --- Executes during object creation, after setting all properties.
function BitsToDesync_CreateFcn(hObject, eventdata, handles)
% hObject    handle to BitsToDesync (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function TrueProbabilitySlider_Callback(hObject, eventdata, handles)
% hObject    handle to TrueProbabilitySlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MALAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.TrueProbability, 'String', num2str(round(get(handles.TrueProbabilitySlider, 'Value'),2)));
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function TrueProbabilitySlider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TrueProbabilitySlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function TrueProbability_Callback(hObject, eventdata, handles)
% hObject    handle to TrueProbability (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.TrueProbabilitySlider, 'Value', str2double(get(handles.TrueProbability, 'String')));
% Hints: get(hObject,'String') returns contents of TrueProbability as text
%        str2double(get(hObject,'String')) returns contents of TrueProbability as a double


% --- Executes during object creation, after setting all properties.
function TrueProbability_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TrueProbability (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in GenerateBtn.
function GenerateBtn_Callback(hObject, eventdata, handles)
% hObject    handle to GenerateBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function Frames_Callback(hObject, eventdata, handles)
% hObject    handle to Frames (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Frames as text
%        str2double(get(hObject,'String')) returns contents of Frames as a double


% --- Executes during object creation, after setting all properties.
function Frames_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Frames (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in SendBtn.
function SendBtn_Callback(hObject, eventdata, handles)
% hObject    handle to SendBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in ScramblingOption.
function ScramblingOption_Callback(hObject, eventdata, handles)
% hObject    handle to ScramblingOption (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of ScramblingOption


% --- Executes on button press in EncodeOption.
function EncodeOption_Callback(hObject, eventdata, handles)
% hObject    handle to EncodeOption (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of EncodeOption


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over AboutBtn.
function AboutBtn_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to AboutBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
