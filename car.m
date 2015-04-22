function varargout = car(varargin)
%CAR M-file for car.fig
%      CAR, by itself, creates a new CAR or raises the existing
%      singleton*.
%
%      H = CAR returns the handle to a new CAR or the handle to
%      the existing singleton*.
%
%      CAR('Property','Value',...) creates a new CAR using the
%      given property value pairs. Unrecognized properties are passed via
%      varargin to car_OpeningFcn.  This calling syntax produces a
%      warning when there is an existing singleton*.
%
%      CAR('CALLBACK') and CAR('CALLBACK',hObject,...) call the
%      local function named CALLBACK in CAR.M with the given input
%      arguments.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help car

% Last Modified by GUIDE v2.5 21-Apr-2015 18:45:22

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @car_OpeningFcn, ...
                   'gui_OutputFcn',  @car_OutputFcn, ...
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


% --- Executes just before car is made visible.
function car_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   unrecognized PropertyName/PropertyValue pairs from the
%            command line (see VARARGIN)

[old, new, mergeRule, names] = myPart2Index();
user.parts = keys(new{7});
user.ranking = zeros(1,numel(user.parts));
handles.user = user;

imshow(imread('./dataSets/trainval/guiVisuals/carModified.png'));

% Choose default command line output for bird
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes dog wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = car_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in completeRanking.
function completeRanking_Callback(hObject, eventdata, handles)
% hObject    handle to completeRanking (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns completeRanking contents as cell array
%        contents{get(hObject,'Value')} returns selected item from completeRanking
contents = cellstr(get(hObject,'String'));
rankString = contents{get(hObject,'Value')};
if(strcmp(rankString,''))
    rank = 0;
else
    rank = str2num(rankString);
end
[~,ind] = ismember('complete',handles.user.parts);
handles.user.ranking(1,ind) = rank;
%handles.user
% Update handles structure
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function completeRanking_CreateFcn(hObject, eventdata, handles)
% hObject    handle to completeRanking (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in frontSideRanking.
function frontSideRanking_Callback(hObject, eventdata, handles)
% hObject    handle to frontSideRanking (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns frontSideRanking contents as cell array
%        contents{get(hObject,'Value')} returns selected item from frontSideRanking
contents = cellstr(get(hObject,'String'));
rankString = contents{get(hObject,'Value')};
if(strcmp(rankString,''))
    rank = 0;
else
    rank = str2num(rankString);
end
[~,ind] = ismember('frontside',handles.user.parts);
handles.user.ranking(1,ind) = rank;
%handles.user
% Update handles structure
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function frontSideRanking_CreateFcn(hObject, eventdata, handles)
% hObject    handle to frontSideRanking (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in leftSideRanking.
function leftSideRanking_Callback(hObject, eventdata, handles)
% hObject    handle to leftSideRanking (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns leftSideRanking contents as cell array
%        contents{get(hObject,'Value')} returns selected item from leftSideRanking
contents = cellstr(get(hObject,'String'));
rankString = contents{get(hObject,'Value')};
if(strcmp(rankString,''))
    rank = 0;
else
    rank = str2num(rankString);
end
[~,ind] = ismember('leftside',handles.user.parts);
handles.user.ranking(1,ind) = rank;
%handles.user
% Update handles structure
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function leftSideRanking_CreateFcn(hObject, eventdata, handles)
% hObject    handle to leftSideRanking (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in rightSideRanking.
function rightSideRanking_Callback(hObject, eventdata, handles)
% hObject    handle to rightSideRanking (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns rightSideRanking contents as cell array
%        contents{get(hObject,'Value')} returns selected item from rightSideRanking
contents = cellstr(get(hObject,'String'));
rankString = contents{get(hObject,'Value')};
if(strcmp(rankString,''))
    rank = 0;
else
    rank = str2num(rankString);
end
[~,ind] = ismember('rightside',handles.user.parts);
handles.user.ranking(1,ind) = rank;
%handles.user
% Update handles structure
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function rightSideRanking_CreateFcn(hObject, eventdata, handles)
% hObject    handle to rightSideRanking (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in backSideRanking.
function backSideRanking_Callback(hObject, eventdata, handles)
% hObject    handle to backSideRanking (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns backSideRanking contents as cell array
%        contents{get(hObject,'Value')} returns selected item from backSideRanking
contents = cellstr(get(hObject,'String'));
rankString = contents{get(hObject,'Value')};
if(strcmp(rankString,''))
    rank = 0;
else
    rank = str2num(rankString);
end
[~,ind] = ismember('backside',handles.user.parts);
handles.user.ranking(1,ind) = rank;
%handles.user
% Update handles structure
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function backSideRanking_CreateFcn(hObject, eventdata, handles)
% hObject    handle to backSideRanking (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in roofSideRanking.
function roofSideRanking_Callback(hObject, eventdata, handles)
% hObject    handle to roofSideRanking (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns roofSideRanking contents as cell array
%        contents{get(hObject,'Value')} returns selected item from roofSideRanking
contents = cellstr(get(hObject,'String'));
rankString = contents{get(hObject,'Value')};
if(strcmp(rankString,''))
    rank = 0;
else
    rank = str2num(rankString);
end
[~,ind] = ismember('roofside',handles.user.parts);
handles.user.ranking(1,ind) = rank;
%handles.user
% Update handles structure
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function roofSideRanking_CreateFcn(hObject, eventdata, handles)
% hObject    handle to roofSideRanking (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in frontLicencePlateRanking.
function frontLicencePlateRanking_Callback(hObject, eventdata, handles)
% hObject    handle to frontLicencePlateRanking (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns frontLicencePlateRanking contents as cell array
%        contents{get(hObject,'Value')} returns selected item from frontLicencePlateRanking
contents = cellstr(get(hObject,'String'));
rankString = contents{get(hObject,'Value')};
if(strcmp(rankString,''))
    rank = 0;
else
    rank = str2num(rankString);
end
[~,ind] = ismember('fliplate',handles.user.parts);
handles.user.ranking(1,ind) = rank;
%handles.user
% Update handles structure
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function frontLicencePlateRanking_CreateFcn(hObject, eventdata, handles)
% hObject    handle to frontLicencePlateRanking (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in backLicencePlateRanking.
function backLicencePlateRanking_Callback(hObject, eventdata, handles)
% hObject    handle to backLicencePlateRanking (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns backLicencePlateRanking contents as cell array
%        contents{get(hObject,'Value')} returns selected item from backLicencePlateRanking
contents = cellstr(get(hObject,'String'));
rankString = contents{get(hObject,'Value')};
if(strcmp(rankString,''))
    rank = 0;
else
    rank = str2num(rankString);
end
[~,ind] = ismember('bliplate',handles.user.parts);
handles.user.ranking(1,ind) = rank;
%handles.user
% Update handles structure
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function backLicencePlateRanking_CreateFcn(hObject, eventdata, handles)
% hObject    handle to backLicencePlateRanking (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in wheelRanking.
function wheelRanking_Callback(hObject, eventdata, handles)
% hObject    handle to wheelRanking (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns wheelRanking contents as cell array
%        contents{get(hObject,'Value')} returns selected item from wheelRanking
contents = cellstr(get(hObject,'String'));
rankString = contents{get(hObject,'Value')};
if(strcmp(rankString,''))
    rank = 0;
else
    rank = str2num(rankString);
end
[~,ind] = ismember('wheel',handles.user.parts);
handles.user.ranking(1,ind) = rank;
%handles.user
% Update handles structure
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function wheelRanking_CreateFcn(hObject, eventdata, handles)
% hObject    handle to wheelRanking (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in saveButton.
function saveButton_Callback(hObject, eventdata, handles)
% hObject    handle to saveButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
flag = false;
finalRanking = handles.user.ranking;
totalNumberOfParts = numel(handles.user.parts);
missingCategoryIndex = find(finalRanking == 0); 
if(~isempty(missingCategoryIndex))
    warndlg('ERROR: Missing ranks..');
else
    if(numel(unique(finalRanking)) ~= totalNumberOfParts)
        warndlg('ERROR: Duplicate ranks given...');
    else
        % count existing files
        folderPrefix = './dataSets/trainval/humanRanks/car/%s';
        currentFileNumber = numel(dir(sprintf(folderPrefix,'*.mat')));
        user = handles.user;
        save(sprintf(folderPrefix,[num2str(currentFileNumber+1) '.mat']),...
            'user');
        flag = true;
    end
end

if(flag)
    clearString = 'clear';
    evalin('base',clearString);
    delete(handles.carGui);
end
