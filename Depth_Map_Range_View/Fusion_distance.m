clear
close
clc

load('Test_labels.mat')

load('Test_ProbabilityDM.mat')

load('Test_ProbabilityRGB.mat')

%% Determinando a distância para cada amostra.
x_min = 5;   % movement direction
x_max = 80;
load('Test_Remove_MIN_MAX_RI.mat');
Test_Remove_MIN_MAX_RI = double(Test_Remove_MIN_MAX_RI);
dm = Test_Remove_MIN_MAX_RI./255;
D = -x_max*x_min./(dm.*(x_max-x_min)-x_max);

%% Determinar o valor da ponderação para cada amostra usando interpolação.

load('Normalized_DM')
load('spDivRIr_DM_Car')

w = zeros(size(D,1),1);
for k=1:size(D,1)
    k;
    menor_distance = spDivRIr_DM_Car(D(k)>=spDivRIr_DM_Car);
    menor_distance = menor_distance(end);
    
    menor_pond = find(spDivRIr_DM_Car==menor_distance);
    menor_pond = Normalized_DM(menor_pond(end));
    
    if D(k)>max(spDivRIr_DM_Car)
        maximo_distance = 80;
        maximo_pond = 0;
    else    
        maximo_distance = spDivRIr_DM_Car(D(k)<spDivRIr_DM_Car);
        maximo_distance = maximo_distance(1);
        maximo_pond = find(spDivRIr_DM_Car==maximo_distance);
        maximo_pond = Normalized_DM(maximo_pond(1));
    end
    w(k)=menor_pond+(maximo_pond-menor_pond).*((D(k)-menor_distance)/(maximo_distance-menor_distance));
end

%% Calculando a fusão dos scores
Score_final =zeros(size(w,1),3);
for j=1:size(w,1)
     Score_final(j,:) = (1-w(j)).*Test_ProbabilityRGB(j,:)+(w(j)).*Test_ProbabilityDM(j,:);
end

%% Predição 
Test_predict = zeros(11657,1);
FusionMatrix = Score_final;
for j=1:size(FusionMatrix,1)
    [valor,posicao]=find(FusionMatrix(j,:)>=0.5);
    if posicao==1
        Test_predict(j) = 0;
    end
    if posicao==2
        Test_predict(j) = 1;
    end
    if posicao==3
        Test_predict(j) = 2;
    end
end

%% Performance measures / results
[LTe, iTest]=unique(Test_labels);
cte1 = Test_labels == LTe(1); cte2 = Test_labels == LTe(2); cte3 = Test_labels == LTe(3);
NC1 = sum(cte1); NC2 = sum(cte2); NC3 = sum(cte3);
Y = FusionMatrix;
n = size(Y,1);
TP = zeros(1,3);
FP = zeros(1,3);
FN = zeros(1,3);
% % ------------------
yFP1 = [0, 0];
i1 = 1; i2 = [2 3];
for i=1:(iTest(2)-1)
    res = Y(i,:) == max(Y(i,:)); %1x3 logical array
    TP(i1) = TP(i1) + res(i1);
    FP(i2) = FP(i2) + res(i2);
    if sum(res(i2))==1
       yFP1(1) =  yFP1(1) + Y(i,res);
       yFP1(2) =  yFP1(2) + 1;
    end    
end
FN(i1) = NC1 - TP(i1);

i1 = 2; i2 = [1 3];
for i=iTest(2):(iTest(3)-1)
    res = Y(i,:) == max(Y(i,:)); %1x3 logical array
    TP(i1) = TP(i1) + res(i1);
    FP(i2) = FP(i2) + res(i2);
    if sum(res(i2))==1
       yFP1(1) =  yFP1(1) + Y(i,res);
       yFP1(2) =  yFP1(2) + 1;
    end    
end
FN(i1) = NC2 - TP(i1);

i1 = 3; i2 = [1 2];
for i=iTest(3):n
    res = Y(i,:) == max(Y(i,:)); %1x3 logical array
    TP(i1) = TP(i1) + res(i1);
    FP(i2) = FP(i2) + res(i2);
    if sum(res(i2))==1
       yFP1(1) =  yFP1(1) + Y(i,res);
       yFP1(2) =  yFP1(2) + 1;
    end    
end
FN(i1) = NC3 - TP(i1);
disp('********** Baseline ');
Pre = TP./(TP + FP);
Rec = TP./(TP + FN);
F1 = 2*(Pre.*Rec)./(Pre + Rec);
fprintf('F-1 = %1.2f \n',100*mean(F1));
TP1 = TP; FP1 = FP; FN1 = FN;







