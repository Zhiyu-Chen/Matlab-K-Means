function varargout = K_Means(varargin)
% K_MEANS MATLAB code for K_Means.fig
%      K_MEANS, by itself, creates a new K_MEANS or raises the existing
%      singleton*.
%
%      H = K_MEANS returns the handle to a new K_MEANS or the handle to
%      the existing singleton*.
%
%      K_MEANS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in K_MEANS.M with the given input arguments.
%
%      K_MEANS('Property','Value',...) creates a new K_MEANS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before K_Means_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to K_Means_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help K_Means

% Last Modified by GUIDE v2.5 26-Oct-2015 23:31:11

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @K_Means_OpeningFcn, ...
                   'gui_OutputFcn',  @K_Means_OutputFcn, ...
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


% --- Executes just before K_Means is made visible.
function K_Means_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to K_Means (see VARARGIN)

% Choose default command line output for K_Means
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes K_Means wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = K_Means_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in cluster.
function cluster_Callback(hObject, eventdata, handles)
% hObject    handle to cluster (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
num = str2double(get(handles.num_cluster,'String'));
x = handles.x;
y = handles.y;
data = [x y];
[IDC,C] = kmeans(data,num);

function num_cluster_Callback(hObject, eventdata, handles)
% hObject    handle to num_cluster (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of num_cluster as text
%        str2double(get(hObject,'String')) returns contents of num_cluster as a double


% --- Executes during object creation, after setting all properties.
function num_cluster_CreateFcn(hObject, eventdata, handles)
% hObject    handle to num_cluster (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in bt_choose.
function bt_choose_Callback(hObject, eventdata, handles)
% hObject    handle to bt_choose (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%axes(handles.axes1)
x = []
y = []
[tx,ty,key] = ginput(1);
while key
    x = [x;tx];
    y = [y;ty];
    hold on;
    plot(handles.axes1,tx,ty,'ro');
    [tx,ty,key] = ginput(1);
end
handles.x = x;
handles.y = y;
guidata(hObject,handles);
plot(handles.axes1,x,y,'o');


% --- Executes on button press in bt_para.
function bt_para_Callback(hObject, eventdata, handles)
% hObject    handle to bt_para (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%%%%%%%%%%%%%%%%%%%%get the input parameter from users%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%and generate data points%%%%%%%%%%%%%%%%%%%%%%%%
answer(1) = 0;
answer(2) = 0;
answer_list = [];
number = str2double(get(handles.num_cluster,'String'));
handles.num = number;
prompt = {'Enter mean:','Enter standard deviation:'};
dlg_title = 'Input';
num_lines = 1;
defaultans = {'0','0'};
options.Resize = 'on';
x = [];
y = [];
for i = drange(1:number)
    answer = inputdlg(prompt,dlg_title,num_lines,defaultans,options);
    answer_list = [answer_list;answer'];
    temp_x = str2double(answer(1)) + str2double(answer(2)).*randn(100,1);
    temp_y = str2double(answer(1)) + str2double(answer(2)).*randn(100,1);
    x = [x;temp_x];
    y = [y;temp_y];
    hold on;
    plot(handles.axes1,temp_x,temp_y,'ro');
end
handles.x = x;
handles.y = y;
guidata(hObject,handles);
