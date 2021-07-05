function varargout = bantuanbencana(varargin)
% BANTUANBENCANA MATLAB code for bantuanbencana.fig
%       ANALISIS KORBAN BENCANA ALAM GUNA PENYALURAN BANTUAN DENGAN METODE
%       SAW
%       Nama :
%       1. Aliefa Haniif S  (123190090)
%       2. Ananda Eka A     (123190094)








%
%      BANTUANBENCANA, by itself, creates a new BANTUANBENCANA or raises the existing
%      singleton*.
%
%      H = BANTUANBENCANA returns the handle to a new BANTUANBENCANA or the handle to
%      the existing singleton*.
%
%      BANTUANBENCANA('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in BANTUANBENCANA.M with the given input arguments.
%
%      BANTUANBENCANA('Property','Value',...) creates a new BANTUANBENCANA or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before bantuanbencana_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to bantuanbencana_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help bantuanbencana

% Last Modified by GUIDE v2.5 04-Jul-2021 15:20:22

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @bantuanbencana_OpeningFcn, ...
                   'gui_OutputFcn',  @bantuanbencana_OutputFcn, ...
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


% --- Executes just before bantuanbencana is made visible.
function bantuanbencana_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to bantuanbencana (see VARARGIN)
global u
u.urut=[];
% Choose default command line output for bantuanbencana
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes bantuanbencana wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = bantuanbencana_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
opts = detectImportOptions('databencana.csv');
opts.SelectedVariableNames = [1 3:6];
data = readmatrix('databencana.csv',opts);
set(handles.uitable1,'Data', data);


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
opts = detectImportOptions('databencana.csv');
opts.SelectedVariableNames = [3:6];
x = readmatrix('databencana.csv',opts);

k=[1,1,1,1];%nilai atribut, dimana 0= atribut biaya &1= atribut keuntungan
w=[0.15,0.15,0.3,0.4];% bobot untuk masing-masing kriteria

%normalisasi matriks
[m n]=size (x); %matriks m x n dengan ukuran sebanyak variabel x (input)
R=zeros (m,n); %membuat matriks R, yang merupakan matriks kosong
Y=zeros (m,n); %membuat matriks Y, yang merupakan titik kosong
for j=1:n,
 if k(j)==1, %statement untuk kriteria dengan atribut keuntungan
  R(:,j)=x(:,j)./max(x(:,j));
 else
  R(:,j)=min(x(:,j))./x(:,j);
 end;
end;

%ranking 5 teratas
for i=1:m,
 V(i)= sum(w.*R(i,:))
end;

[nilai nr]=sort(V,'descend');%diurutkan secara descending

global u
for rank=1:5, %meranking menjadi 5 data teratas
	u.urut=[u.urut; [nilai(rank), nr(rank)]]; %memilih datanya bedasarkan nilai V dan nomor
	disp (u.urut); %menampilkan data yang sudah urut
	set(handles.uitable2,'Data',u.urut);
end;
