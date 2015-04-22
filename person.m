function varargout = person(varargin)
%PERSON M-file for person.fig
%      PERSON, by itself, creates a new PERSON or raises the existing
%      singleton*.
%
%      H = PERSON returns the handle to a new PERSON or the handle to
%      the existing singleton*.
%
%      PERSON('Property','Value',...) creates a new PERSON using the
%      given property value pairs. Unrecognized properties are passed via
%      varargin to person_OpeningFcn.  This calling syntax produces a
%      warning when there is an existing singleton*.
%
%      PERSON('CALLBACK') and PERSON('CALLBACK',hObject,...) call the
%      local function named CALLBACK in PERSON.M with the given input
%      arguments.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help person

% Last Modified by GUIDE v2.5 21-Apr-2015 20:53:01

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @person_OpeningFcn, ...
                   'gui_OutputFcn',  @person_OutputFcn, ...
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


% --- Executes just before person is made visible.
function person_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   unrecognized PropertyName/PropertyValue pairs from the
%            command line (see VARARGIN)

[old, new, mergeRule, names] = myPart2Index();
user.parts = keys(new{15});
user.ranking = zeros(1,numel(user.parts));
handles.user = user;

imshow(imread('./dataSets/trainval/guiVisuals/personModified.png'));

% Choose default command line output for bird
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes person wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = person_OutputFcn(hObject, eventdata, handles)
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


% --- Executes on selection change in torsoRanking.
function torsoRanking_Callback(hObject, eventdata, handles)
% hObject    handle to torsoRanking (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns torsoRanking contents as cell array
%        contents{get(hObject,'Value')} returns selected item from torsoRanking

contents = cellstr(get(hObject,'String'));
rankString = contents{get(hObject,'Value')};
if(strcmp(rankString,''))
    rank = 0;
else
    rank = str2num(rankString);
end
[~,ind] = ismember('torso',handles.user.parts);
handles.user.ranking(1,ind) = rank;
%handles.user
% Update handles structure
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function torsoRanking_CreateFcn(hObject, eventdata, handles)
% hObject    handle to torsoRanking (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in headNeckTorsoRanking.
function headNeckTorsoRanking_Callback(hObject, eventdata, handles)
% hObject    handle to headNeckTorsoRanking (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns headNeckTorsoRanking contents as cell array
%        contents{get(hObject,'Value')} returns selected item from headNeckTorsoRanking

contents = cellstr(get(hObject,'String'));
rankString = contents{get(hObject,'Value')};
if(strcmp(rankString,''))
    rank = 0;
else
    rank = str2num(rankString);
end
[~,ind] = ismember('hnt',handles.user.parts);
handles.user.ranking(1,ind) = rank;
%handles.user
% Update handles structure
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function headNeckTorsoRanking_CreateFcn(hObject, eventdata, handles)
% hObject    handle to headNeckTorsoRanking (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in armRanking.
function armRanking_Callback(hObject, eventdata, handles)
% hObject    handle to armRanking (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns armRanking contents as cell array
%        contents{get(hObject,'Value')} returns selected item from armRanking

contents = cellstr(get(hObject,'String'));
rankString = contents{get(hObject,'Value')};
if(strcmp(rankString,''))
    rank = 0;
else
    rank = str2num(rankString);
end
[~,ind] = ismember('arm',handles.user.parts);
handles.user.ranking(1,ind) = rank;
%handles.user
% Update handles structure
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function armRanking_CreateFcn(hObject, eventdata, handles)
% hObject    handle to armRanking (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in headRanking.
function headRanking_Callback(hObject, eventdata, handles)
% hObject    handle to headRanking (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns headRanking contents as cell array
%        contents{get(hObject,'Value')} returns selected item from headRanking

contents = cellstr(get(hObject,'String'));
rankString = contents{get(hObject,'Value')};
if(strcmp(rankString,''))
    rank = 0;
else
    rank = str2num(rankString);
end
[~,ind] = ismember('head',handles.user.parts);
handles.user.ranking(1,ind) = rank;
%handles.user
% Update handles structure
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function headRanking_CreateFcn(hObject, eventdata, handles)
% hObject    handle to headRanking (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in legRanking.
function legRanking_Callback(hObject, eventdata, handles)
% hObject    handle to legRanking (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns legRanking contents as cell array
%        contents{get(hObject,'Value')} returns selected item from legRanking

contents = cellstr(get(hObject,'String'));
rankString = contents{get(hObject,'Value')};
if(strcmp(rankString,''))
    rank = 0;
else
    rank = str2num(rankString);
end
[~,ind] = ismember('leg',handles.user.parts);
handles.user.ranking(1,ind) = rank;
%handles.user
% Update handles structure
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function legRanking_CreateFcn(hObject, eventdata, handles)
% hObject    handle to legRanking (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in torsoLegRanking.
function torsoLegRanking_Callback(hObject, eventdata, handles)
% hObject    handle to torsoLegRanking (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns torsoLegRanking contents as cell array
%        contents{get(hObject,'Value')} returns selected item from torsoLegRanking

contents = cellstr(get(hObject,'String'));
rankString = contents{get(hObject,'Value')};
if(strcmp(rankString,''))
    rank = 0;
else
    rank = str2num(rankString);
end
[~,ind] = ismember('torsoleg',handles.user.parts);
handles.user.ranking(1,ind) = rank;
%handles.user
% Update handles structure
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function torsoLegRanking_CreateFcn(hObject, eventdata, handles)
% hObject    handle to torsoLegRanking (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in armTorsoRanking.
function armTorsoRanking_Callback(hObject, eventdata, handles)
% hObject    handle to armTorsoRanking (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns armTorsoRanking contents as cell array
%        contents{get(hObject,'Value')} returns selected item from armTorsoRanking

contents = cellstr(get(hObject,'String'));
rankString = contents{get(hObject,'Value')};
if(strcmp(rankString,''))
    rank = 0;
else
    rank = str2num(rankString);
end
[~,ind] = ismember('at',handles.user.parts);
handles.user.ranking(1,ind) = rank;
%handles.user
% Update handles structure
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function armTorsoRanking_CreateFcn(hObject, eventdata, handles)
% hObject    handle to armTorsoRanking (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in neckTorsoRanking.
function neckTorsoRanking_Callback(hObject, eventdata, handles)
% hObject    handle to neckTorsoRanking (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns neckTorsoRanking contents as cell array
%        contents{get(hObject,'Value')} returns selected item from neckTorsoRanking

contents = cellstr(get(hObject,'String'));
rankString = contents{get(hObject,'Value')};
if(strcmp(rankString,''))
    rank = 0;
else
    rank = str2num(rankString);
end
[~,ind] = ismember('nt',handles.user.parts);
handles.user.ranking(1,ind) = rank;
%handles.user
% Update handles structure
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function neckTorsoRanking_CreateFcn(hObject, eventdata, handles)
% hObject    handle to neckTorsoRanking (see GCBO)
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
        folderPrefix = './dataSets/trainval/humanRanks/person/%s';
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
    delete(handles.personGui);
end


% --- Executes on selection change in hairRanking.
function hairRanking_Callback(hObject, eventdata, handles)
% hObject    handle to hairRanking (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns hairRanking contents as cell array
%        contents{get(hObject,'Value')} returns selected item from hairRanking

contents = cellstr(get(hObject,'String'));
rankString = contents{get(hObject,'Value')};
if(strcmp(rankString,''))
    rank = 0;
else
    rank = str2num(rankString);
end
[~,ind] = ismember('hair',handles.user.parts);
handles.user.ranking(1,ind) = rank;
%handles.user
% Update handles structure
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function hairRanking_CreateFcn(hObject, eventdata, handles)
% hObject    handle to hairRanking (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in handRanking.
function handRanking_Callback(hObject, eventdata, handles)
% hObject    handle to handRanking (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns handRanking contents as cell array
%        contents{get(hObject,'Value')} returns selected item from handRanking

contents = cellstr(get(hObject,'String'));
rankString = contents{get(hObject,'Value')};
if(strcmp(rankString,''))
    rank = 0;
else
    rank = str2num(rankString);
end
[~,ind] = ismember('hand',handles.user.parts);
handles.user.ranking(1,ind) = rank;
%handles.user
% Update handles structure
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function handRanking_CreateFcn(hObject, eventdata, handles)
% hObject    handle to handRanking (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
