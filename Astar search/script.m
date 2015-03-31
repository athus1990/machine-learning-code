clear all
close all
clc
G=[1,2,3;4,5,6;7,8,9];
S1=[9,1,3;4,2,5;7,8,6];
S2=[9,1,3;7,2,6;5,4,8];
S3=[2,4,3;7,9,8;6,1,5];

%%
P1=Astar(S1,G)
show8puzzle(S1,P1)
pause(2)
close all

% ## NOT WORKING CONDITIONS##%
% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~%
%

P2=Astar(S2,G)
show8puzzle(S2,P2)
pause(2)
close all

%

P3=Astar(S3,G);
show8puzzle(S3,P3)

