function varargout = F_123190103_ResponsiSCPK_SAW(varargin)
% F_123190103_RESPONSISCPK_SAW MATLAB code for F_123190103_ResponsiSCPK_SAW.fig
%      F_123190103_RESPONSISCPK_SAW, by itself, creates a new F_123190103_RESPONSISCPK_SAW or raises the existing
%      singleton*.
%
%      H = F_123190103_RESPONSISCPK_SAW returns the handle to a new F_123190103_RESPONSISCPK_SAW or the handle to
%      the existing singleton*.
%
%      F_123190103_RESPONSISCPK_SAW('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in F_123190103_RESPONSISCPK_SAW.M with the given input arguments.
%
%      F_123190103_RESPONSISCPK_SAW('Property','Value',...) creates a new F_123190103_RESPONSISCPK_SAW or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before F_123190103_ResponsiSCPK_SAW_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to F_123190103_ResponsiSCPK_SAW_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help F_123190103_ResponsiSCPK_SAW

% Last Modified by GUIDE v2.5 26-Jun-2021 08:00:29

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @F_123190103_ResponsiSCPK_SAW_OpeningFcn, ...
                   'gui_OutputFcn',  @F_123190103_ResponsiSCPK_SAW_OutputFcn, ...
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


% --- Executes just before F_123190103_ResponsiSCPK_SAW is made visible.
function F_123190103_ResponsiSCPK_SAW_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to F_123190103_ResponsiSCPK_SAW (see VARARGIN)

% Choose default command line output for F_123190103_ResponsiSCPK_SAW
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes F_123190103_ResponsiSCPK_SAW wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = F_123190103_ResponsiSCPK_SAW_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in proses.
function proses_Callback(hObject, eventdata, handles)
%membaca  dataset dan memberi variabel
data = readtable('DATA RUMAH.xlsx');
data1 = xlsread('DATA RUMAH.xlsx');
dataid = data(:,2);
data1 = [data1(:,1) data1(:,3) data1(:,4) data1(:,5) data1(:,6) data1(:,7) data1(:,8)];
data = [data(:,3) data(:,4) data(:,5) data(:,6) data(:,7) data(:,8)];
data = table2array(data);
dataid = table2array(dataid);
set(handles.tabeldata, 'Data', data1);

%menentukan nilai k dan w
k = [0,1,1,1,1,1];
w = [0.30,0.20,0.23,0.10,0.07,0.10];

%normalisasi dan membuat matrix R dan Y
[m, n] = size (data); 

%menghitung statemen
for j = 1:n,
 if k(j) == 1, %dengan k = 1
  R(:,j) = data(:,j)./max(data(:,j));
 else %dengan k = 0
  R(:,j)= min(data(:,j))./data(:,j);
 end;
end;

%memeringkatkan nilai
for i=1:m,
 H(i)= sum(w.*R(i,:));
end;

%mengurutkan nilai dari yang tertinggi dan menampilkan
[maks, index] = maxk(H,20);
dataid = dataid(index);
maks = transpose(num2cell(maks));
databaru = [dataid, maks];
set(handles.tabelhasil, 'Data', databaru);
