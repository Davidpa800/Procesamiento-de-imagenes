function varargout = camaraD(varargin)
% CAMARAD MATLAB code for camaraD.fig
%      CAMARAD, by itself, creates a new CAMARAD or raises the existing
%      singleton*.
%
%      H = CAMARAD returns the handle to a new CAMARAD or the handle to
%      the existing singleton*.
%
%      CAMARAD('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CAMARAD.M with the given input arguments.
%
%      CAMARAD('Property','Value',...) creates a new CAMARAD or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before camaraD_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to camaraD_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help camaraD

% Last Modified by GUIDE v2.5 28-Feb-2019 13:52:07

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @camaraD_OpeningFcn, ...
                   'gui_OutputFcn',  @camaraD_OutputFcn, ...
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


% --- Executes just before camaraD is made visible.
function camaraD_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to camaraD (see VARARGIN)

% Choose default command line output for camaraD
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes camaraD wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = camaraD_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in CamaraT.
function CamaraT_Callback(hObject, eventdata, handles)
% hObject    handle to CamaraT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)%%Coneccion a camara
global vid
global encender;
encender=1;
vid=videoinput('winvideo',1,'YUY2_640X480');
handles.output=hObject;
axes(handles.axes1);
rc=getselectedsource(vid);
vid.FramesPerTrigger=1;
vid.ReturnedColorspace='rgb';
hImage=image(zeros(480,640,3),'Parent',handles.axes1);
preview(vid,hImage);
guidata(hObject,handles);

% --- Executes on button press in TomarFoto.
function TomarFoto_Callback(hObject, eventdata, handles)
% hObject    handle to TomarFoto (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)%%
global imagen
global vid
global carga
global encender
if encender==1
    carga=1;
    foto=getsnapshot(vid);
    stoppreview(vid);
    imwrite(foto,'foto76.jpg');
    imagen=imread('foto76.jpg');
    x=imagen;
    subplot (handles.axes2), imshow(x);
    encender=0;
else
    msgbox('Primero debe activar la camara','Error','error');
end
% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global carga
%Se limpian los axes y la etiqueta, ademas carga se resetea a 0
cla(handles.axes1);
cla(handles.axes2);
set(handles.nombreimagen,'String','Original'); 
carga=0;

% --- Executes during object creation, after setting all properties.
function axes1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes1


% --- Executes on button press in laplaciano.
function laplaciano_Callback(hObject, eventdata, handles)%%Filtro Lapaciano
% hObject    handle to laplaciano (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global imagen
global carga
if carga==1  
    foto=imagen;
    sigma = 0.4; 
    alpha = 0.5;
    final=locallapfilt(foto, sigma, alpha); %%Creal el filtro laplaciano
    imshow(final);
else
    msgbox('Necesita cargar imagen','Error','error')
end

% --- Executes on button press in Gausiano.
function Gausiano_Callback(hObject, eventdata, handles)
% hObject    handle to Gausiano (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global imagen
global carga
if carga==1  
    foto=imagen;
    final=imnoise(foto,'gaussian'); %%Filtro Gausiano
    imshow(final);
else
    msgbox('Necesita cargar imagen','Error','error')
end

% --- Executes on button press in SalPinienta.
function SalPinienta_Callback(hObject, eventdata, handles)
% hObject    handle to SalPinienta (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global imagen
global carga
if carga==1  
    foto=imagen;
    final=imnoise(foto,'salt & pepper',0.05); %%Filtro sal y pimienta
    imshow(final);
else
    msgbox('Necesita cargar imagen','Error','error')
end

% --- Executes on button press in Relieve.
function Relieve_Callback(hObject, eventdata, handles)
% hObject    handle to Relieve (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global imagen;
global carga
if carga==1  
    foto=imagen;
    sf=fspecial('prewitt');
    sc=sf;
    im=rgb2gray(foto);
    b1=imfilter(im,sf);
    b2=imfilter(im,sc);
    relieve=imadd(b1,b2);
    subplot (handles.axes2), imshow(relieve);
else
    msgbox('Necesita cargar imagen','Error','error')
end


% --- Executes on button press in realce.
function realce_Callback(hObject, eventdata, handles)
% hObject    handle to realce (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global imagen;
global carga
if carga==1  
    foto=imagen;
    foto=getimage(handles.axes1);
    if isequal(foto,0),return,end
    f=foto;
    h=fspecial('unsharp');
    realce=imfilter(f,h,'replicate');
    subplot(handles.axes2), imshow(realce);
else
    msgbox('Necesita cargar imagen','Error','error')
end

% --- Executes on button press in Suavisado.
function Suavisado_Callback(hObject, eventdata, handles)
% hObject    handle to Suavisado (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global imagen
global carga
if carga==1  
        foto= imagen;
        if isequal(foto,0),return,end
        rojo=foto(:,:,1);
        verde=foto(:,:,2);
        azul=foto(:,:,3);
        w=fspecial('average',10);
        FR_filtrada=imfilter(rojo,w);
        FG_filtrada=imfilter(verde,w);
        FB_filtrada=imfilter(azul,w);
        fc_filtrada=cat(3,FR_filtrada,FG_filtrada,FB_filtrada);
        subplot (handles.axes2) , imshow(fc_filtrada);
else
    msgbox('Necesita cargar imagen','Error','error')
end

% --- Executes on button press in Negativo.
function Negativo_Callback(hObject, eventdata, handles)
% hObject    handle to Negativo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global imagen
global carga
if carga==1  
     imagenGris=rgb2gray(imagen);
     imagenDoble=im2double(imagenGris);
     [xmax, ymax]=size(imagenDoble);
 
     for x=1:xmax
         for y=1:ymax
             imagenNegativo (x,y)=1 - imagenDoble (x,y);
         end
     end
    resultadoMatrizMatlab= im2uint8(imagenNegativo);
     resultado=resultadoMatrizMatlab;
     subplot(handles.axes2), imshow(resultado);
else
    msgbox('Necesita cargar imagen','Error','error')
end


% --- Executes on button press in Lapiz.
function Lapiz_Callback(hObject, eventdata, handles)
% hObject    handle to Lapiz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global imagen
global carga
if carga==1  
    foto=imagen;
    sf=fspecial('prewitt');
    sc=sf;
    im=rgb2gray(foto);
    b1=imfilter(im,sf);
    b2=imfilter(im,sc);
    relieve=imadd(b1,b2);
    dibujo=imadjust(relieve,[],[1 0]);
    subplot (handles.axes2) , imshow(dibujo);
else
    msgbox('Necesita cargar imagen','Error','error')
end


% --- Executes on button press in Magenta.
function Magenta_Callback(hObject, eventdata, handles)
% hObject    handle to Magenta (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global imagen
global carga
if carga==1  
   foto=imagen;
   foto2=imagen;
   rojo=foto(:,:,1);
   verde=foto(:,:,2);
   azul=foto(:,:,3);
   foto(:,:,2)=0;
   foto(:,:,3)=0;
       
   rojo=foto2(:,:,1);
   verde=foto2(:,:,2);
   azul=foto2(:,:,3);
   foto2(:,:,1)=0;
   foto2(:,:,2)=0;
       
   magenta=foto+foto2;
   subplot (handles.axes2), imshow(magenta);
else
    msgbox('Necesita cargar imagen','Error','error')
end


% --- Executes on button press in rotar2.
function rotar2_Callback(hObject, eventdata, handles)
% hObject    handle to rotar2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global imagen
global carga
if carga==1  
    foto=imagen;
    foto=flipdim(foto,1);
    foto=flipdim(foto,2);
    subplot (handles.axes2), imshow(foto);
else
    msgbox('Necesita cargar imagen','Error','error')
end


% --- Executes on button press in grisbtn.
function grisbtn_Callback(hObject, eventdata, handles)
% hObject    handle to grisbtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global carga
global imagen
if carga==1
    I=rgb2gray(imagen);
    imshow(I );
%   Im2=imagen(RGB,'Parent',handles.axes2);
%   set(handles.axes2,'Visible','off','Ydir','reverse','XLim',get(Im2,'Xdata'),'Ylim',get(Im2,'Xdata'));
    guidata(hObject,handles);
else
    msgbox('Necesita cargar imagen','Error','error')
end


% --- Executes on button press in sepiabtn.
function sepiabtn_Callback(hObject, eventdata, handles)
% hObject    handle to sepiabtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global imagen
global carga
if carga==1
    inputRed=imagen(:,:,1);
    inputGreen=imagen(:,:,2);
    inputBlue=imagen(:,:,3);
    %// Create sepia tones for each channel
    outputRed = (inputRed * .393) + (inputGreen *.769) + (inputBlue * .189);
    outputGreen = (inputRed * .349) + (inputGreen *.686) + (inputBlue * .168);
    outputBlue = (inputRed * .272) + (inputGreen *.534) + (inputBlue * .131);
    out = uint8(cat(3, outputRed, outputGreen, outputBlue));
    imshow(out);
%    Im2=imagen(inputRed,inputGreen,inputBlue,'Parent',handles.axes2);
%   set(handles.axes2,'Visible','off','Ydir','reverse','XLim',get(Im2,'Xdata'),'Ylim',get(Im2,'Xdata'));
    guidata(hObject,handles);
else
    msgbox('Necesita cargar imagen','Error','error')
end


% --- Executes on button press in loadImage.
function loadImage_Callback(hObject, eventdata, handles)
% hObject    handle to loadImage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global imagen
global carga
[filename,pathname]=uigetfile('*.jpg','Seleccion de Imagen');
if isequal(filename,0)||isequal(pathname,0)
    disp('Usuario presiono cancelar')
else
    carga=1;
    disp(['Usuario selecciono',fullfile(pathname,filename)])
    todo=strcat(pathname,filename)
    imagen=imread(todo);
    %%Hay un error aqui
    set(handles.nombreimagen,'String',filename);
    handles.filename=filename;
    imagen=uint8(imagen);
    Img=image(imagen,'Parent',handles.axes1);
    %set(handles.axes1,'Visible','off','Ydir','reverse','XLim',get(Img,Xdata),'Ylim',get(Img,XData))
    %guidata(hObject,handles);
end


% --- Executes on button press in reflejo.
function reflejo_Callback(hObject, eventdata, handles)
% hObject    handle to reflejo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global imagen;
global carga;
if carga==1
    
    C=uint8(zeros(size(imagen)));

    R=fliplr(imagen(:,:,1));
    G=fliplr(imagen(:,:,2));
    B=fliplr(imagen(:,:,3));

    C (:,:,1)=R;
    C (:,:,2)=G;
    C (:,:,3)=B;

    subplot (handles.axes2), imshow(C);
else
    msgbox('Necesita cargar imagen','Error','error')
end


% --- Executes on button press in rotar.
function rotar_Callback(hObject, eventdata, handles)
% hObject    handle to rotar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global imagen
global carga
if carga==1
    R = rot90 (imagen(:,:,1),1);
    G = rot90 (imagen(:,:,2),1);
    B = rot90 (imagen(:,:,3),1);    
    %C= uint8 (ceros(tamano(imagen)));
    C (:,:,1) = rot90(imagen(:,:,1),1);
    C (:,:,2) = rot90(imagen(:,:,2),1);
    C (:,:,3) = rot90(imagen(:,:,3),1);
    subplot (handles.axes2), imshow(C);
else
    msgbox('Necesita cargar imagen','Error','error')
end


% --- Executes on button press in hbtn.
function hbtn_Callback(hObject, eventdata, handles)
% hObject    handle to hbtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global imagen
global carga
if carga==1
    planeH=imagen;
    planeH(:,:,1)=0;
    planeH(:,:,2)=0;
    % planeH(:,:,3)=0;
    hsv=rgb2hsv(planeH);
    imshow(hsv);
%    Im3=imagen(hsv,'Parent',handles.axes2);
%    set(handles.axes2,'Visible','off','Ydir','reverse','XLim',get(Im3,'Xdata'),'Ylim',get(Im3,'Xdata'));
    guidata(hObject,handles);
else
    msgbox('Necesita cargar imagen','Error','error')
end


% --- Executes on button press in sbtn.
function sbtn_Callback(hObject, eventdata, handles)
% hObject    handle to sbtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global imagen
global carga
if carga==1
    planeS=imagen;
    planeS(:,:,1)=0;
    planeS(:,:,3)=0;
    % planeH(:,:,3)=0;
    hsv=rgb2hsv(planeS);
    imshow(hsv);
%   Im3=imagen(hsv,'Parent',handles.axes2);
%   set(handles.axes2,'Visible','off','Ydir','reverse','XLim',get(Im3,'Xdata'),'Ylim',get(Im3,'Xdata'));
    guidata(hObject,handles);
else
    msgbox('Necesita cargar imagen','Error','error')
end


% --- Executes on button press in vbtn.
function vbtn_Callback(hObject, eventdata, handles)
% hObject    handle to vbtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global imagen
global carga
if carga==1
    planeV=imagen;
    planeV(:,:,2)=0;
    planeV(:,:,3)=0;
    % planeH(:,:,3)=0;
    hsv=rgb2hsv(planeV);
    imshow(hsv);
%    Im3=imagen(hsv,'Parent',handles.axes2);
%    set(handles.axes2,'Visible','off','Ydir','reverse','XLim',get(Im3,'Xdata'),'Ylim',get(Im3,'Xdata'));
    guidata(hObject,handles);
else
    msgbox('Necesita cargar imagen','Error','error')
end


% --- Executes on button press in rbtn.
function rbtn_Callback(hObject, eventdata, handles)
% hObject    handle to rbtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global imagen
global carga
if carga==1
    planeR=imagen;
    planeR(:,:,2)=0;
    planeR(:,:,3)=0;
    imshow(planeR);
%   Im2=imagen(planeR,'Parent',handles.axes2);
%   set(handles.axes2,'Visible','off','Ydir','reverse','XLim',get(Im2,'Xdata'),'Ylim',get(Im2,'Xdata'));
    guidata(hObject,handles);
else
    msgbox('Necesita cargar imagen','Error','error')
end

% --- Executes on button press in gvtn.
function gvtn_Callback(hObject, eventdata, handles)
% hObject    handle to gvtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global imagen
global carga
if carga==1
    planeG=imagen;
    planeG(:,:,1)=0;
    planeG(:,:,2)=0;
    imshow(planeG);
%    Im3=imagen(planeG,'Parent',handles.axes2);
%    set(handles.axes2,'Visible','off','Ydir','reverse','XLim',get(Im3,'Xdata'),'Ylim',get(Im3,'Xdata'));
    guidata(hObject,handles);
else
    msgbox('Necesita cargar imagen','Error','error')
end

% --- Executes on button press in bbtn.
function bbtn_Callback(hObject, eventdata, handles)
% hObject    handle to bbtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global imagen
global carga
if carga==1
    planeG=imagen;
    planeG(:,:,1)=0;
    planeG(:,:,2)=0;
    imshow(planeG);
%    Im3=imagen(planeG,'Parent',handles.axes2);
%    set(handles.axes2,'Visible','off','Ydir','reverse','XLim',get(Im3,'Xdata'),'Ylim',get(Im3,'Xdata'));
    guidata(hObject,handles);
else
    msgbox('Necesita cargar imagen','Error','error')
end
