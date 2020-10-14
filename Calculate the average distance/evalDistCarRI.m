clc
clear
close all

%% load data
load TrainVal_Remove_MIN_MAX_RI
load TrainVal_labels;
load TrainVal_predictDM;

%% Car
carIndex = TrainVal_labels == 1; % binary index for car labels
dmCar = TrainVal_Remove_MIN_MAX_RI(carIndex);
predictCar = TrainVal_predictDM(carIndex); predictCar = predictCar == 1;
gtCar = TrainVal_labels(carIndex); gtCar = gtCar == 1;

% divide samples based on depth
spDivRIr = [5,10,15,20,25,30,35,40,45,50,55,60,65,70,75,80];

% usand range inverse
st.x_MEDIO = 5;   % movement direction
st.x_max = 80;
st.y_MEDIO = -80; % right
st.y_max = 80;  % left
dm = (st.x_max*(spDivRIr-st.x_MEDIO))./(spDivRIr*(st.x_max-st.x_MEDIO)); 
dm(dm < 0) = 0; dm(dm > 1) = 1;
spDivRI  = uint8(255*dm);

accCar = zeros(length(spDivRI)-1, 1);
FscoreCarI = zeros(length(spDivRI)-1, 1);
PercCar = zeros(length(spDivRI)-1, 1);

for i = 1:size(spDivRIr,2)-1
    
dmMEDIO = spDivRI(i);
dmMax = spDivRI(i+1);
pilarIndex = (dmCar >= dmMEDIO) & (dmCar < dmMax);
predictPilarCar = predictCar(pilarIndex);
gtPilarCar = gtCar(pilarIndex);   
PercCar(i) = sum(pilarIndex) / length(dmCar) * 100; % percentage of samples
% 57.8117,    26.6056,    12.5700,     2.2595,     0.7532

% F-score
TP = sum((predictPilarCar == 1) & (gtPilarCar == 1));
FN = sum((predictPilarCar == 0) & (gtPilarCar == 1));
FP = sum((predictPilarCar == 1) & (gtPilarCar == 0));
TN = sum((predictPilarCar == 0) & (gtPilarCar == 0));
P=TP+FN;
N=FP+TN;
accCar(i) =(TP+TN)/(P+N); 
Recall=TP./(TP+FN);
Precision=TP./(TP+FP);
FscoreCarI(i) = (2*Precision*Recall)/(Precision+Recall);

end
FscoreCarI(isnan(FscoreCarI)) = 0

%% plot
spDivRIr_DM_Car=spDivRIr(1:end-1);
save spDivRIr_DM_Car.mat spDivRIr_DM_Car

FscoreCarI_DM = FscoreCarI;
%FscoreCarI_DM(7) = (FscoreCarI_DM(6)+FscoreCarI_DM(8))/2;
%FscoreCarI_DM(9) = (FscoreCarI_DM(8)+FscoreCarI_DM(10))/2;
save FscoreCarI_DM.mat FscoreCarI_DM
save PercCar.mat PercCar

hold on
plot(spDivRIr_DM_Car, FscoreCarI_DM, '-g','LineWidth',2);
hold off
%xlim([5 80]); ylim([.99 1.005]); 
grid on
xlabel('Distance (meter)','FontSize',12)
ylabel('F-score','FontSize',12)
legend({' Car - RI'},'FontSize',12)
