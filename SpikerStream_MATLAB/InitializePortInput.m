function s = InitializePortInput(inputBufferSize,PortNumber)
% Sets up and initiates an input data stream from the arduino from a given port

if nargin < 1
    inputBufferSize = 20000;
    PortNumber = 9;
end

% Whatever this means:
theBaudRate = 230400;

%-------------------------------------------------------------------------------
% Get the name of the input port to read data from:
if ismac
    % Get available ports by running:
    % ls /dev/tty.*
    thePortName = num2str(PortNumber);
else
    thePortName = ['COM' num2str(PortNumber)];
end

s = serial(thePortName);

%-------------------------------------------------------------------------------
% Settings:
s.InputBufferSize = inputBufferSize;
s.BaudRate = theBaudRate;
s.Terminator = '';
s.ReadAsyncMode = 'continuous';

% Check status:
disp(s.Status);

% Initiate sampling on the Arduino by sending a special code
fopen(s);
fprintf(s,'conf s:10000;c:1;\n');

end
