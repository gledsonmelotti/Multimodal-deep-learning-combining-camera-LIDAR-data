clear
clc
%%
%Train

path = 'D:\Dataset_Point_Cloud\Com_Clustering_Sem_Limite_Pontos\upsampling_256\Tres_classes\Tres_classes\train\Pedestrian';
diretorio = dir(path);
diretorio = diretorio(3:end,:);
Remove_MIN_MAX_Ped = [];
k=0;
for i=1:size(diretorio,1)
    i
    point = strcat('D:\Dataset_Point_Cloud\Com_Clustering_Sem_Limite_Pontos\upsampling_256\Tres_classes\train\Pedestrian\',diretorio(i).name);
    cloud = load(point);
    pointcloud = cloud.velo_point;
    x = pointcloud(:,1).^2;
    y = pointcloud(:,2).^2;
    z = pointcloud(:,3).^2;
    d = sqrt(x+y+z);
       
    minimo=min(d);
    indice_minimo = find(d==minimo);
    d(indice_minimo)=[];
    
    maximo=max(d);
    indice_maximo=find(d==maximo);
    d(indice_maximo)=[];
    
    if isempty(d)
        d = sqrt(x+y+z);
    end

    MedioPC = sum(d)/(size(d,1));
    Remove_MIN_MAX_Ped = [Remove_MIN_MAX_Ped;MedioPC];
end

path = 'D:\Dataset_Point_Cloud\Com_Clustering_Sem_Limite_Pontos\upsampling_256\Tres_classes\train\Car2';
diretorio = dir(path)
diretorio = diretorio(3:end,:);
Remove_MIN_MAX_Car = [];
for i=1:size(diretorio,1)
    i
    point = strcat('D:\Dataset_Point_Cloud\Com_Clustering_Sem_Limite_Pontos\upsampling_256\Tres_classes\train\Car2\',diretorio(i).name);
    cloud = load(point);
    pointcloud = cloud.velo_point;
    x = pointcloud(:,1).^2;
    y = pointcloud(:,2).^2;
    z = pointcloud(:,3).^2;
    d = sqrt(x+y+z);
       
    minimo=min(d);
    indice_minimo = find(d==minimo);
    d(indice_minimo)=[];
    
    maximo=max(d);
    indice_maximo=find(d==maximo);
    d(indice_maximo)=[];
    
    if isempty(d)
        d = sqrt(x+y+z);
    end

    MedioPC = sum(d)/(size(d,1));
    Remove_MIN_MAX_Car = [Remove_MIN_MAX_Car;MedioPC];
end

path = 'D:\Dataset_Point_Cloud\Com_Clustering_Sem_Limite_Pontos\upsampling_256\Tres_classes\train\Cyclist';
diretorio = dir(path)
diretorio = diretorio(3:end,:);
Remove_MIN_MAX_Cyc = [];
for i=1:size(diretorio,1)
    i
    point = strcat('D:\Dataset_Point_Cloud\Com_Clustering_Sem_Limite_Pontos\upsampling_256\Tres_classes\train\Cyclist\',diretorio(i).name);
    cloud = load(point);
    pointcloud = cloud.velo_point;
    x = pointcloud(:,1).^2;
    y = pointcloud(:,2).^2;
    z = pointcloud(:,3).^2;
    d = sqrt(x+y+z);
       
    minimo=min(d);
    indice_minimo = find(d==minimo);
    d(indice_minimo)=[];
    
    maximo=max(d);
    indice_maximo=find(d==maximo);
    d(indice_maximo)=[];
    
    if isempty(d)
        d = sqrt(x+y+z);
    end

    MedioPC = sum(d)/(size(d,1));
    Remove_MIN_MAX_Cyc = [Remove_MIN_MAX_Cyc;MedioPC];
end

Train_Remove_MIN_MAX_RI_PC = [Remove_MIN_MAX_Ped;Remove_MIN_MAX_Car;Remove_MIN_MAX_Cyc];
save Train_Remove_MIN_MAX_RI_PC.mat Train_Remove_MIN_MAX_RI_PC

%% Range Inverse
% Validation
path = 'D:\Dataset_Point_Cloud\Com_Clustering_Sem_Limite_Pontos\upsampling_256\Tres_classes\validation\Pedestrian';
diretorio = dir(path)
diretorio = diretorio(3:end,:);
Remove_MIN_MAX_Ped = [];
for i=1:size(diretorio,1)
    i
    point = strcat('D:\Dataset_Point_Cloud\Com_Clustering_Sem_Limite_Pontos\upsampling_256\Tres_classes\validation\Pedestrian\',diretorio(i).name);
    cloud = load(point);
    pointcloud = cloud.velo_point;
    x = pointcloud(:,1).^2;
    y = pointcloud(:,2).^2;
    z = pointcloud(:,3).^2;
    d = sqrt(x+y+z);
       
    minimo=min(d);
    indice_minimo = find(d==minimo);
    d(indice_minimo)=[];
    
    maximo=max(d);
    indice_maximo=find(d==maximo);
    d(indice_maximo)=[];
    
    if isempty(d)
        d = sqrt(x+y+z);
    end
 
    MedioPC = sum(d)/(size(d,1));
    Remove_MIN_MAX_Ped = [Remove_MIN_MAX_Ped;MedioPC];
end
 
path = 'D:\Dataset_Point_Cloud\Com_Clustering_Sem_Limite_Pontos\upsampling_256\Tres_classes\validation\Car2';
diretorio = dir(path)
diretorio = diretorio(3:end,:);
Remove_MIN_MAX_Car = [];
for i=1:size(diretorio,1)
    i
    point = strcat('D:\Dataset_Point_Cloud\Com_Clustering_Sem_Limite_Pontos\upsampling_256\Tres_classes\validation\Car2\',diretorio(i).name);
    cloud = load(point);
    pointcloud = cloud.velo_point;
    x = pointcloud(:,1).^2;
    y = pointcloud(:,2).^2;
    z = pointcloud(:,3).^2;
    d = sqrt(x+y+z);
       
    minimo=min(d);
    indice_minimo = find(d==minimo);
    d(indice_minimo)=[];
    
    maximo=max(d);
    indice_maximo=find(d==maximo);
    d(indice_maximo)=[];
    
    if isempty(d)
        d = sqrt(x+y+z);
    end

    MedioPC = sum(d)/(size(d,1));
    Remove_MIN_MAX_Car = [Remove_MIN_MAX_Car;MedioPC];
end
 
path = 'D:\Dataset_Point_Cloud\Com_Clustering_Sem_Limite_Pontos\upsampling_256\Tres_classes\validation\Cyclist';
diretorio = dir(path)
diretorio = diretorio(3:end,:);
Remove_MIN_MAX_Cyc = [];
for i=1:size(diretorio,1)
    i
    point = strcat('D:\Dataset_Point_Cloud\Com_Clustering_Sem_Limite_Pontos\upsampling_256\Tres_classes\validation\Cyclist\',diretorio(i).name);
    cloud = load(point);
    pointcloud = cloud.velo_point;
    x = pointcloud(:,1).^2;
    y = pointcloud(:,2).^2;
    z = pointcloud(:,3).^2;
    d = sqrt(x+y+z);
       
    minimo=min(d);
    indice_minimo = find(d==minimo);
    d(indice_minimo)=[];
    
    maximo=max(d);
    indice_maximo=find(d==maximo);
    d(indice_maximo)=[];
    
    if isempty(d)
        d = sqrt(x+y+z);
    end

    MedioPC = sum(d)/(size(d,1));
    Remove_MIN_MAX_Cyc = [Remove_MIN_MAX_Cyc;MedioPC];
end

Val_Remove_MIN_MAX_RI_PC = [Remove_MIN_MAX_Ped;Remove_MIN_MAX_Car;Remove_MIN_MAX_Cyc];
save Val_Remove_MIN_MAX_RI_PC.mat Val_Remove_MIN_MAX_RI_PC

%% Train and Validation togheter
TrainVal_Remove_MIN_MAX_RI_PC = [Train_Remove_MIN_MAX_RI_PC;Val_Remove_MIN_MAX_RI_PC];
save TrainVal_Remove_MIN_MAX_RI_PC.mat TrainVal_Remove_MIN_MAX_RI_PC 

%%
% Test
path = 'D:\Dataset_Point_Cloud\Com_Clustering_Sem_Limite_Pontos\upsampling_256\Tres_classes\test\Pedestrian';
diretorio = dir(path);
diretorio = diretorio(3:end,:);
Remove_MIN_MAX_Ped = [];
k=0;
for i=1:size(diretorio,1)
    i
    point = strcat('D:\Dataset_Point_Cloud\Com_Clustering_Sem_Limite_Pontos\upsampling_256\Tres_classes\test\Pedestrian\',diretorio(i).name);
    cloud = load(point);
    pointcloud = cloud.velo_point;
    x = pointcloud(:,1).^2;
    y = pointcloud(:,2).^2;
    z = pointcloud(:,3).^2;
    d = sqrt(x+y+z);
       
    minimo=min(d);
    indice_minimo = find(d==minimo);
    d(indice_minimo)=[];
    
    maximo=max(d);
    indice_maximo=find(d==maximo);
    d(indice_maximo)=[];
    
    if isempty(d)
        d = sqrt(x+y+z);
    end

    MedioPC = sum(d)/(size(d,1));
    Remove_MIN_MAX_Ped = [Remove_MIN_MAX_Ped;MedioPC];
end
 
path = 'D:\Dataset_Point_Cloud\Com_Clustering_Sem_Limite_Pontos\upsampling_256\Tres_classes\test\Car2';
diretorio = dir(path);
diretorio = diretorio(3:end,:);
Remove_MIN_MAX_Car = [];
for i=1:size(diretorio,1)
    i
    point = strcat('D:\Dataset_Point_Cloud\Com_Clustering_Sem_Limite_Pontos\upsampling_256\Tres_classes\test\Car2\',diretorio(i).name);
    cloud = load(point);
    pointcloud = cloud.velo_point;
    x = pointcloud(:,1).^2;
    y = pointcloud(:,2).^2;
    z = pointcloud(:,3).^2;
    d = sqrt(x+y+z);
       
    minimo=min(d);
    indice_minimo = find(d==minimo);
    d(indice_minimo)=[];
    
    maximo=max(d);
    indice_maximo=find(d==maximo);
    d(indice_maximo)=[];
    
    if isempty(d)
        d = sqrt(x+y+z);
    end
 
    MedioPC = sum(d)/(size(d,1));
    Remove_MIN_MAX_Car = [Remove_MIN_MAX_Car;MedioPC];
end
 
path = 'D:\Dataset_Point_Cloud\Com_Clustering_Sem_Limite_Pontos\upsampling_256\Tres_classes\test\Cyclist';
diretorio = dir(path);
diretorio = diretorio(3:end,:);
Remove_MIN_MAX_Cyc = [];
for i=1:size(diretorio,1)
    i
    point = strcat('D:\Dataset_Point_Cloud\Com_Clustering_Sem_Limite_Pontos\upsampling_256\Tres_classes\test\Cyclist\',diretorio(i).name);
    cloud = load(point);
    pointcloud = cloud.velo_point;
    x = pointcloud(:,1).^2;
    y = pointcloud(:,2).^2;
    z = pointcloud(:,3).^2;
    d = sqrt(x+y+z);
       
    minimo=min(d);
    indice_minimo = find(d==minimo);
    d(indice_minimo)=[];
    
    maximo=max(d);
    indice_maximo=find(d==maximo);
    d(indice_maximo)=[];
    
    if isempty(d)
        d = sqrt(x+y+z);
    end

    MedioPC = sum(d)/(size(d,1));
    Remove_MIN_MAX_Cyc = [Remove_MIN_MAX_Cyc;MedioPC];
end
 
Test_Remove_MIN_MAX_RI_PC = [Remove_MIN_MAX_Ped;Remove_MIN_MAX_Car;Remove_MIN_MAX_Cyc];
save Test_Remove_MIN_MAX_RI_PC.mat Test_Remove_MIN_MAX_RI_PC


