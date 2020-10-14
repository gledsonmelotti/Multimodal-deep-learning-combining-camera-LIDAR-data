clear
clc

%%Range Inverse
Distance = 0:255;

%%
%Train

path = 'D:\BF_DM_13_13\Tres_classes\train\Pedestrian'
diretorio = dir(path)
diretorio = diretorio(3:end,:);
MEDPed = [];
for i=1:size(diretorio,1)
    i
    figura = strcat('D:\BF_DM_13_13\Tres_classes\train\Pedestrian\',diretorio(i).name);
    I = imread(figura);
    vector = I(:);
    
    minimo=min(vector);
    indice_minimo = find(vector==minimo);
    vector(indice_minimo)=[];
    
    maximo=max(vector);
    indice_maximo=find(vector==maximo);
    vector(indice_maximo)=[];
    
    if isempty(vector)
        vector = I(:);
    end
    
    MEDIO = sum(vector)/(size(vector,1));
    MEDPed = [MEDPed;MEDIO];
end

path = 'D:\BF_DM_13_13\Tres_classes\train\Car'
diretorio = dir(path)
diretorio = diretorio(3:end,:);
MEDCar =[];
for i=1:size(diretorio,1)
    i
    figura = strcat('D:\BF_DM_13_13\Tres_classes\train\Car\',diretorio(i).name);
    I = imread(figura);
    vector = I(:);
    
    minimo=min(vector);
    indice_minimo = find(vector==minimo);
    vector(indice_minimo)=[];
    
    maximo=max(vector);
    indice_maximo=find(vector==maximo);
    vector(indice_maximo)=[];
    
    if isempty(vector)
        vector = I(:);
    end
    
    MEDIO = sum(vector)/(size(vector,1));
    MEDCar = [MEDCar;MEDIO];
end

path = 'D:\BF_DM_13_13\Tres_classes\train\Cyclist'
diretorio = dir(path)
diretorio = diretorio(3:end,:);
MEDCyc = [];
for i=1:size(diretorio,1)
    i
    figura = strcat('D:\BF_DM_13_13\Tres_classes\train\Cyclist\',diretorio(i).name);
    I = imread(figura);
    vector = I(:);
    
    minimo=min(vector);
    indice_minimo = find(vector==minimo);
    vector(indice_minimo)=[];
    
    maximo=max(vector);
    indice_maximo=find(vector==maximo);
    vector(indice_maximo)=[];
    
    if isempty(vector)
        vector = I(:);
    end
    
    MEDIO = sum(vector)/(size(vector,1));
    MEDCyc = [MEDCyc;MEDIO];
end

Train_Remove_MIN_MAX_RI = [MEDPed;MEDCar;MEDCyc];
save Train_Remove_MIN_MAX_RI.mat Train_Remove_MIN_MAX_RI

%% Range Inverse
% Validation

path = 'D:\BF_DM_13_13\Tres_classes\validation\Pedestrian'
diretorio = dir(path)
diretorio = diretorio(3:end,:);
MEDPed = [];
for i=1:size(diretorio,1)
    i
    figura = strcat('D:\BF_DM_13_13\Tres_classes\validation\Pedestrian\',diretorio(i).name);
    I = imread(figura);
    vector = I(:);
    
    minimo=min(vector);
    indice_minimo = find(vector==minimo);
    vector(indice_minimo)=[];
    
    maximo=max(vector);
    indice_maximo=find(vector==maximo);
    vector(indice_maximo)=[];
    
    if isempty(vector)
        vector = I(:);
    end
    
    MEDIO = sum(vector)/(size(vector,1));
    MEDPed = [MEDPed;MEDIO];
end
 
path = 'D:\BF_DM_13_13\Tres_classes\validation\Car'
diretorio = dir(path)
diretorio = diretorio(3:end,:);
MEDCar = [];
for i=1:size(diretorio,1)
    i
    figura = strcat('D:\BF_DM_13_13\Tres_classes\validation\Car\',diretorio(i).name);
    I = imread(figura);
    vector = I(:);
    
    minimo=min(vector);
    indice_minimo = find(vector==minimo);
    vector(indice_minimo)=[];
    
    maximo=max(vector);
    indice_maximo=find(vector==maximo);
    vector(indice_maximo)=[];
    
    if isempty(vector)
        vector = I(:);
    end
    
    MEDIO = sum(vector)/(size(vector,1));
    MEDCar = [MEDCar;MEDIO];
end
 
path = 'D:\BF_DM_13_13\Tres_classes\validation\Cyclist'
diretorio = dir(path)
diretorio = diretorio(3:end,:);
MEDCyc = [];
for i=1:size(diretorio,1)
    i
    figura = strcat('D:\BF_DM_13_13\Tres_classes\validation\Cyclist\',diretorio(i).name);
    I = imread(figura);
    vector = I(:);
    
    minimo=min(vector);
    indice_minimo = find(vector==minimo);
    vector(indice_minimo)=[];
    
    maximo=max(vector);
    indice_maximo=find(vector==maximo);
    vector(indice_maximo)=[];
    
    if isempty(vector)
        vector = I(:);
    end
    
    MEDIO = sum(vector)/(size(vector,1));
    MEDCyc = [MEDCyc;MEDIO];
end
 
Val_Remove_MIN_MAX_RI = [MEDPed;MEDCar;MEDCyc];
save Val_Remove_MIN_MAX_RI.mat Val_Remove_MIN_MAX_RI

%% Train and Validation togheter
TrainVal_Remove_MIN_MAX_RI = [Train_Remove_MIN_MAX_RI;Val_Remove_MIN_MAX_RI];
save TrainVal_Remove_MIN_MAX_RI.mat TrainVal_Remove_MIN_MAX_RI

%%
% Test

path = 'D:\BF_DM_13_13\Tres_classes\test\Pedestrian'
diretorio = dir(path)
diretorio = diretorio(3:end,:);
MEDPed = [];
for i=1:size(diretorio,1)
    i
    figura = strcat('D:\BF_DM_13_13\Tres_classes\test\Pedestrian\',diretorio(i).name);
    I = imread(figura);
    vector = I(:);
    
    minimo=min(vector);
    indice_minimo = find(vector==minimo);
    vector(indice_minimo)=[];
    
    maximo=max(vector);
    indice_maximo=find(vector==maximo);
    vector(indice_maximo)=[];
    
    if isempty(vector)
        vector = I(:);
    end
    
    MEDIO = sum(vector)/(size(vector,1));
    MEDPed = [MEDPed;MEDIO];
end
 
path = 'D:\BF_DM_13_13\Tres_classes\test\Car'
diretorio = dir(path)
diretorio = diretorio(3:end,:);
MEDCar =[];
for i=1:size(diretorio,1)
    i
    figura = strcat('D:\BF_DM_13_13\Tres_classes\test\Car\',diretorio(i).name);
    I = imread(figura);
    vector = I(:);
    
    minimo=min(vector);
    indice_minimo = find(vector==minimo);
    vector(indice_minimo)=[];
    
    maximo=max(vector);
    indice_maximo=find(vector==maximo);
    vector(indice_maximo)=[];
    
    if isempty(vector)
        vector = I(:);
    end
    
    MEDIO = sum(vector)/(size(vector,1));
    MEDCar = [MEDCar;MEDIO];
end
 
path = 'D:\BF_DM_13_13\Tres_classes\test\Cyclist'
diretorio = dir(path)
diretorio = diretorio(3:end,:);
MEDCyc = [];
for i=1:size(diretorio,1)
    i
    figura = strcat('D:\BF_DM_13_13\Tres_classes\test\Cyclist\',diretorio(i).name);
    I = imread(figura);
    vector = I(:);
    
    minimo=min(vector);
    indice_minimo = find(vector==minimo);
    vector(indice_minimo)=[];
    
    maximo=max(vector);
    indice_maximo=find(vector==maximo);
    vector(indice_maximo)=[];
    
    if isempty(vector)
        vector = I(:);
    end
    
    MEDIO = sum(vector)/(size(vector,1));
    MEDCyc = [MEDCyc;MEDIO];
end
 
Test_Remove_MIN_MAX_RI = [MEDPed;MEDCar;MEDCyc];
save Test_Remove_MIN_MAX_RI.mat Test_Remove_MIN_MAX_RI
