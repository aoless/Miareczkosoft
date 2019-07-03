function varargout = Miareczkosoft(varargin)
% MIARECZKOSOFT MATLAB code for Miareczkosoft.fig
%      MIARECZKOSOFT, by itself, creates a new MIARECZKOSOFT or raises the existing
%      singleton*.
%
%      H = MIARECZKOSOFT returns the handle to a new MIARECZKOSOFT or the handle to
%      the existing singleton*.
%
%      MIARECZKOSOFT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MIARECZKOSOFT.M with the given input arguments.
%
%      MIARECZKOSOFT('Property','Value',...) creates a new MIARECZKOSOFT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Miareczkosoft_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Miareczkosoft_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Miareczkosoft

% Last Modified by GUIDE v2.5 08-Jan-2016 15:22:09

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Miareczkosoft_OpeningFcn, ...
                   'gui_OutputFcn',  @Miareczkosoft_OutputFcn, ...
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


% --- Executes just before Miareczkosoft is made visible.
function Miareczkosoft_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Miareczkosoft (see VARARGIN)

% Choose default command line output for Miareczkosoft
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Miareczkosoft wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Miareczkosoft_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in wybierz.
function wybierz_Callback(hObject, eventdata, handles)
% hObject    handle to wybierz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
listStr = cellstr(get(handles.wybierz,'String'));
a = get(handles.wybierz,'Value');

for i = 2:length(listStr)
    if a==i 
        handles.FileName = listStr{i};
    end
end

[num, txt, raw] = xlsread(handles.FileName);

handles.x = num(:,2);
handles.y = num(:,3);

[dV, dpH, Vsr, dpHdV, pKa1, ind] = wylicz_pKa(num);
handles.dV = dV;
handles.dpH = dpH;
handles.Vsr = Vsr;
handles.dpHdV = dpHdV;
handles.ind = ind;
handles.pKa1 =  pKa1;
set(handles.pKa, 'String', handles.pKa1);
 
p = plot(handles.x, handles.y);
p.Marker = 'o';
hold on
plot(handles.Vsr(handles.ind),max(handles.dpHdV), 'rh', 'MarkerSize',7,'MarkerFace','r');
hold off
title('Wyres zale¿noœci pH roztworu od objêtoœci dodanego titranta');
xlabel ('V titranta [cm3]');
ylabel ('pH [-]');
legend({'Krzywa miareczkowania','Punkt przegiêcia'},'Location','northwest');
guidata(hObject, handles);

% Hints: contents = cellstr(get(hObject,'String')) returns wybierz contents as cell array
%        contents{get(hObject,'Value')} returns selected item from wybierz


% --- Executes during object creation, after setting all properties.
function wybierz_CreateFcn(hObject, eventdata, handles)
% hObject    handle to wybierz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pochodna.
function pochodna_Callback(hObject, eventdata, handles)
% hObject    handle to pochodna (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if strcmp ('Zmieñ wykres na pochodn¹',get(handles.pochodna, 'String'))
    plot(handles.Vsr,handles.dpHdV, '-b');
    title('Wyres pochodnej');
    xlabel ('Vœr [cm3]');
    ylabel ('dpH/dVœr [-]');
    legend('Krzywa pochodnej','Location','northwest');
    set(handles.pochodna,'String','Wróæ do wykresu miareczkowania');
else
    p = plot(handles.x, handles.y);
    p.Marker = 'o';
    hold on
    plot(handles.Vsr(handles.ind),max(handles.dpHdV), 'rh', 'MarkerSize',7,'MarkerFace','r');
    hold off
    title('Wyres zale¿noœci pH roztworu od objêtoœci dodanego titranta');
    xlabel ('V titranta [cm3]');
    ylabel ('pH [-]');
    legend({'Krzywa miareczkowania','Punkt przegiêcia'},'Location','northwest');
    set(handles.pochodna,'String','Zmieñ wykres na pochodn¹');
end
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function wykres_CreateFcn(hObject, eventdata, handles)
% hObject    handle to wykres (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate wykres


% --- Executes on button press in WczytajDane.
function WczytajDane_Callback(hObject, eventdata, handles)
% hObject    handle to WczytajDane (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[handles.FileName] = uigetfile({'.xlsx'},'Wybierz plik z danymi');
if handles.FileName == 0;
    return;
end

[num, txt, raw] = xlsread(handles.FileName);
handles.raw = raw;

[dV, dpH, Vsr, dpHdV, pKa1, ind] = wylicz_pKa(num);

set(handles.pochodna, 'Enable', 'on');
set(handles.zapisz, 'Enable', 'on');

str = handles.FileName;
old = get(handles.wybierz, 'String');
new = char(old, str);
set(handles.wybierz, 'String', new, 'Value', 1);

handles.x = num(:,2);
handles.y = num(:,3);

handles.dV = dV;
handles.dpH = dpH;
handles.Vsr = Vsr;
handles.dpHdV = dpHdV;
handles.ind = ind;
handles.pKa1 =  pKa1;
set(handles.pKa, 'String', handles.pKa1);
 
p = plot(handles.x, handles.y);
p.Marker = 'o';
hold on
plot(handles.Vsr(handles.ind),max(handles.dpHdV), 'rh', 'MarkerSize',7,'MarkerFace','r');
hold off
title('Wyres zale¿noœci pH roztworu od objêtoœci dodanego titranta');
xlabel ('V titranta [cm3]');
ylabel ('pH [-]');
legend({'Krzywa miareczkowania','Punkt przegiêcia'},'Location','northwest');
guidata(hObject, handles);


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over pochodna.
function pochodna_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to pochodna (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object creation, after setting all properties.
function pKa_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pKa (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in zapisz.
function zapisz_Callback(hObject, eventdata, handles)
% hObject    handle to zapisz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[handles.FileName] = uiputfile([handles.FileName] , 'Wybierz œcie¿kê zapisu');
if handles.FileName == 0;
    return;
end

dV = ['dV';NaN;num2cell((handles.dV)')];
dpH = ['pH';NaN;num2cell((handles.dpH)')];
dpHdV = ['dpHdV';NaN;num2cell((handles.dpHdV)')];
Vsr = ['Vœr';NaN;num2cell((handles.Vsr)')];
xlswrite(handles.FileName,[handles.raw, dV, dpH, dpHdV, Vsr]);

guidata(hObject, handles)


% --- Executes during object creation, after setting all properties.
function tytul_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
image=imread('MiareczkoSoft.PNG'); 
imshow(image)

% Hint: place code in OpeningFcn to populate axes2
