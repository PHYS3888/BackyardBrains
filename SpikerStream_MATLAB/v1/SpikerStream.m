% Script reads data from BackyardBrain's Arduino SpikerShield
% https://backyardbrains.com/products/heartAndBrainSpikerShieldBundle
% script produces data in "result" variable
clear all
close all
delete(instrfindall);

port_number = 4; % change this depending on what is the number in "device manager" 

%-------------------------------------------------------------------------------
% Parameters
%-------------------------------------------------------------------------------
total_time = 200; % code will stop after this amount of time in seconds [[1 s = 20000 buffer size]]

max_time = 20; % time plotted in window [s]

%-------------------------------------------------------------------------------
% Initialize import data stream
%-------------------------------------------------------------------------------

inputBufferSize = 1000;   % Bufffer Size - in the range 1000-20000
% e.g. inputBufferSize = 20000 means it waits 1 second before plotting

s = InitializePortInput(inputBufferSize,port_number);

%-------------------------------------------------------------------------------
% Record and plot data
%-------------------------------------------------------------------------------
figure('color','w');
xlabel('Time (s)')
ylabel('Input signal (arb)')
data = [];

N_loops = 20000/s.InputBufferSize*total_time;

T_acquire = s.InputBufferSize/20000;    % length of time that data is acquired for 
N_max_loops = max_time/T_acquire;       %total number of loops to cover desire time window

for i = 1:N_loops 
    % take enough data to cover the first time window
    if i <= N_max_loops
        if i==1
            data = fread(s)';
        else
            data = [fread(s)' data]; % the result stream will be in data variable
        end
    else
        % continue adding data to the time window
        fprintf(1,'%u/%u loops\n',i,N_loops); % just to keep an eye out on how many loops are left
        data = circshift(data',s.InputBufferSize)';
        data(1:s.InputBufferSize) = fread(s)';
    end
    data_actual = process_data_new(data);
    % fixed time bug, putting condition on time once the maximum number of loops is reached
    t = min(i,N_max_loops)*s.InputBufferSize/20000*linspace(0,1,length(data_actual));
    drawnow;
    plot(t,data_actual);
    xlabel('time (s)')
    xlim([0,max_time])
end
