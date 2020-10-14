clear
close
clc

load('Test_labels.mat')

load('Test_ProbabilityPC.mat')

load('Test_ProbabilityRGB.mat')

%% Determinando a distância para cada amostra usando Point Clouds.
load('Test_Remove_MIN_MAX_RI_PC.mat');
DP = Test_Remove_MIN_MAX_RI_PC;
vazio = find(DP==0);
DP(vazio)=[];

%%
Test_ProbabilityRGB(vazio,:)=[];
Test_ProbabilityPC(vazio,:)=[];
load Test_labels.mat
Test_labels(vazio,:)=[];
%% PC: Determinar o valor da ponderação para cada amostra usando interpolação.
load('Normalized_PC')
load('spDivRIr_PC_Car')
wpc = zeros(size(DP,1),1);
D=DP;
for k=1:size(D,1)
    k;
    menor_distance = spDivRIr_PC_Car(D(k)>=spDivRIr_PC_Car);
    menor_distance = menor_distance(end);
    
    menor_pond = find(spDivRIr_PC_Car==menor_distance);
    % menor_pond = Normalized_PC(menor_pond(end));
    menor_pond = Normalized_PC(menor_pond(end));

    if D(k)>max(spDivRIr_PC_Car)
        maximo_distance = 80;
        maximo_pond = 0;
    else    
        maximo_distance = spDivRIr_PC_Car(D(k)<spDivRIr_PC_Car);
        maximo_distance = maximo_distance(1);
        maximo_pond = find(spDivRIr_PC_Car==maximo_distance);
        % maximo_pond = Normalized_PC(maximo_pond(1));
        maximo_pond = Normalized_PC(maximo_pond(1));
    end
    wpc(k)=menor_pond+(maximo_pond-menor_pond).*((D(k)-menor_distance)/(maximo_distance-menor_distance));
end

%% Calculando a fusão dos scores
Score_final =zeros(size(wpc,1),3);
for j=1:size(wpc,1)
     Score_final(j,:) = (1-wpc(j)).*Test_ProbabilityRGB(j,:)+(wpc(j)).*Test_ProbabilityPC(j,:);
end

%% Predição 
Test_predict = zeros(size(Score_final,1),1);
FusionMatrix = Score_final;
for j=1:size(FusionMatrix,1)
    j;
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






