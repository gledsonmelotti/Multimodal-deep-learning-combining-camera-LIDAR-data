clear
close
clc
st.x_min = 5;   % movement direction
st.x_max = 80;
st.y_min = -80; % right
st.y_max = 80;  % left
st.bias = 1.73; % velodyne elevation 

%% Range
A=linspace(5,80);

%% Range Linear  
dm  = (A-st.x_min)./(st.x_max-st.x_min);  
dm(dm < 0) = 0; dm(dm > 1) = 1;
dm_final  = uint8(255*dm);
plot(A,dm_final,'LineWidth',2)

dm = [];
dm_final = [];

%% Range Inversde
dm = (st.x_max*(A-st.x_min))./(A*(st.x_max-st.x_min)); 
dm(dm < 0) = 0; dm(dm > 1) = 1;
dm_final  = uint8(255*dm);

hold on
%% 
plot(A,dm_final,'LineWidth',2)
legend('Range linear','Range inverse')
xlabel('Range (m)')
ylabel('Quantized 8-bit value')
grid