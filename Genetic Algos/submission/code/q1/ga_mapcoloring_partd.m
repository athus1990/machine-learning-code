function [solution,sc] = ga_mapcoloring(varargin)
%INITIALIZE ALL VALUES

load usmap; 
params = struct(...
    'psize',500,...%m
    'offspringsize',498,...%l
    'n',50,...%N
    'maxiter',200,...%mtimer %%~~~~~~~~~~~~~~~~~~~~~~changes made for part d
    'tournament',10,...%k
    'mutationrate',0.1,...%pm
    'crossoverrate',0.9,...%pc
    'figurehandle',sum(mfilename)+0,...%h
    'update',false,...%liveupdate
    'show',true);%show results
dummy=struct2cell(params);
[m,l,N,mtimer,k,pm,pc,h,lupdate,showresults]=dummy{:};
%------------------------------------------------------%
%% GA ALGO

% initilaize POP
gotit=1;%%~~~~~~~~~~~~~~~~~~~~~~changes made for part d
while(gotit)%%~~~~~~~~~~~~~~~~~~~~~~changes made for part d
 p=zeros(N,m);
 for i=1:m
     p(:,i)=randi(4,N,1);
 end
 %------------------P has all random data
 %%
sc=fit(p,A);
%%
[sc,id]=sort(sc,'ascend');
p=p(:,id);
%%
for run=1:mtimer
    id=min(randi(size(p,2),k,l));
    par=p(:,id);
    chil=cross(par,pc);
    chil=mut(chil,pm);
    [p,sc]=ss(par,chil,A);
    if sc(1)==0
        break;
    end
end
solution=p(:,1)';%%~~~~~~~~~~~~~~~~~~~~~~changes made for part d
if(solution(33)==1)&& (solution(40)==1) gotit=0;end%%~~~~~~~~~~~~~~~~~~~~~~changes made for part d
end%%~~~~~~~~~~~~~~~~~~~~~~changes made for part d

if sc(1)~=0
    iterations=mtimer;
end
solution=p(:,1)';
sc=sc(1);
showmap(1,L,solution);
end

%% sc/FITNESS
function sc=fit(p,A)
[ii,jj]=size(p);
 sc=zeros(1,jj);
 
 for i=1:jj
     for j=1:ii
     if sum(p(find(A(:,j)==1),i)==p(j,i))>0
         sc(1,i)=sc(1,i)+1;
     end
 end
 end
end

%% cross
function chil=cross(par,pc)
chil=zeros(size(par));
for ii=1:2:size(par,2)
    if rand<pc
        r=randi(2,size(par,1),1);
        chil(r==1,ii)=par(r==1,ii);
        chil(r==2,ii)=par(r==2,ii+1);
        chil(r==1,ii+1)=par(r==1,ii+1);
        chil(r==2,ii+1)=par(r==2,ii);
    else
        chil(:,ii)=par(:,ii);
        chil(:,ii+1)=par(:,ii+1);
    end
end
end

%% MUTATION
function chil=mut(chil,pm)
bmn=rand(size(chil))<pm;
newv=randi(4,size(chil));
chil(bmn)=newv(bmn);
end

%% SURVIVE
function [p,sc]=ss(par,chil,A)
a=[par,chil];
sc1=fit(a,A);
[sc1,id]=sort(sc1,'ascend');
s=a(:,id);
s(:,501:end)=[];
p=s;
sc1(:,501:end)=[];
sc=sc1;
end

% helper functions
%==========================================================================
function showmap(h,L,X)
% SHOWMAP Visualize the colored map.
%   h   Figure handle.
%   L   Label matrix representing an image of the map. Each pixel has an 
%       integer value (0->lines, 1->background, and [2-51]->the 50 states).
%   X   An individual solution, encoded as a vector of integers to indicate
%       colors; that is, X(i) is the index into a color array for the ith
%       state. For example, if X(27)=3, then the 27th state (pixels for
%       which L=28) should take on the 3rd color.

    clrs = [0.73 0.83 0.96;
            1 0.69 0.39;
            0.76 0.87 0.78;
            1 0.97 0.55;
            1 0.4 0.4];

    figure(h); clf;
    set(gcf,...
        'NumberTitle','off',...
        'Name','Map of the United States',...
        'Color',[1 1 1],...
        'MenuBar','none','Toolbar','none',...
        'Position',[300 200 786 570]);
    axes(...
        'Color',[1 0.95 0.81],...
        'Position',[-0.001 -0.001 1.002 1.002]);
    imshow(label2rgb(L,[1 1 1; clrs(X,:)],'k'));
end
