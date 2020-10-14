function [FscoreCyc, spDivRIr, PercCyc] = CycRGB

%% load data
load TrainVal_Remove_MIN_MAX_RI
load TrainVal_labels;
load TrainVal_predictDM;

%% Cyc
CycIndex = TrainVal_labels == 2; % binary index for Cyc labels
dmCyc = TrainVal_Remove_MIN_MAX_RI(CycIndex);
predictCyc = TrainVal_predictDM(CycIndex); predictCyc = predictCyc == 2;
gtCyc = TrainVal_labels(CycIndex); gtCyc = gtCyc == 2;

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

accCyc = zeros(length(spDivRI)-1, 1);
FscoreCyc = zeros(length(spDivRI)-1, 1);
PercCyc = zeros(length(spDivRI)-1, 1);

for i = 1:size(spDivRIr,2)-1
    
dmMEDIO = spDivRI(i);
dmMax = spDivRI(i+1);
pilarIndex = (dmCyc >= dmMEDIO) & (dmCyc < dmMax);
predictPilarCyc = predictCyc(pilarIndex);
gtPilarCyc = gtCyc(pilarIndex);   
PercCyc(i) = sum(pilarIndex) / length(dmCyc) * 100; % percentage of samples
% 57.8117,    26.6056,    12.5700,     2.2595,     0.7532

% F-score
TP = sum((predictPilarCyc == 1) & (gtPilarCyc == 1));
FN = sum((predictPilarCyc == 0) & (gtPilarCyc == 1));
FP = sum((predictPilarCyc == 1) & (gtPilarCyc == 0));
TN = sum((predictPilarCyc == 0) & (gtPilarCyc == 0));
P=TP+FN;
N=FP+TN;
accCyc(i) =(TP+TN)/(P+N); 
Recall=TP./(TP+FN);
Precision=TP./(TP+FP);
FscoreCyc(i) = (2*Precision*Recall)/(Precision+Recall);

end
FscoreCyc(isnan(FscoreCyc)) = 0;



