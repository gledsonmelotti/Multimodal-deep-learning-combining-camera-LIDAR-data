function [FscorePed, spDivRIr, PercPed] = PedRGB

%% load data
load TrainVal_Remove_MIN_MAX_RI
load TrainVal_labels;
load TrainVal_predictDM;

%% Ped
PedIndex = TrainVal_labels == 0; % binary index for Ped labels
dmPed = TrainVal_Remove_MIN_MAX_RI(PedIndex);
predictPed = TrainVal_predictDM(PedIndex); predictPed = predictPed == 0;
gtPed = TrainVal_labels(PedIndex); gtPed = gtPed == 0;

% divide samples based on depth
spDivRIr = [5,10,15,20,25,30,35,40,45,50,55,60,65,70,75,80];
%spDivRIr = linspace(5,80,100);
%spDivRIr = [5,20,35,50,65,80];
%spDivRIr = linspace(5,80,11);
% usand range inverse
st.x_MEDIO = 5;   % movement direction
st.x_max = 80;
st.y_MEDIO = -80; % right
st.y_max = 80;  % left
dm = (st.x_max*(spDivRIr-st.x_MEDIO))./(spDivRIr*(st.x_max-st.x_MEDIO)); 
dm(dm < 0) = 0; dm(dm > 1) = 1;
spDivRI  = uint8(255*dm);

accPed = zeros(length(spDivRI)-1, 1);
FscorePed = zeros(length(spDivRI)-1, 1);
PercPed = zeros(length(spDivRI)-1, 1);

for i = 1:size(spDivRIr,2)-1
    
dmMEDIO = spDivRI(i);
dmMax = spDivRI(i+1);
pilarIndex = (dmPed >= dmMEDIO) & (dmPed < dmMax);
predictPilarPed = predictPed(pilarIndex);
gtPilarPed = gtPed(pilarIndex);   
PercPed(i) = sum(pilarIndex) / length(dmPed) * 100; % percentage of samples
% 57.8117,    26.6056,    12.5700,     2.2595,     0.7532

% F-score
TP = sum((predictPilarPed == 1) & (gtPilarPed == 1));
FN = sum((predictPilarPed == 0) & (gtPilarPed == 1));
FP = sum((predictPilarPed == 1) & (gtPilarPed == 0));
TN = sum((predictPilarPed == 0) & (gtPilarPed == 0));
P=TP+FN;
N=FP+TN;
accPed(i) =(TP+TN)/(P+N); 
Recall=TP./(TP+FN);
Precision=TP./(TP+FP);
FscorePed(i) = (2*Precision*Recall)/(Precision+Recall);

end
FscorePed(isnan(FscorePed)) = 0;


