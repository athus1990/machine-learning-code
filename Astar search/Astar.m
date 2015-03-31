function P = Astar(S,G)
dont=0;%[can be 1,2,3,4-->if 4 was done dont do 3 if 3 was done dont do 4 and so on]
P=0;
pool={S};
pool{1,2}=h(S,G);
pool{1,3}=0;
PQ=[];%Initialize priority queque%have labels
if nargin<2
    G = [1 2 3; 4 5 6; 7 8 9]; %default goal state
end
%cost of s%
[v,op,bp]=suc(S,pool,dont);
PQ=v;
[PS,cost]=rearrange(PQ,G,S,1);
PQ=PS;
%calculate PQ's function cost
lll=1;
for i=1:length(PQ)
    if(sum(cell2mat(cellfun(@(x)isequal(PQ{i},x),pool(:,1),'UniformOutput',false)))==0)
        dumm{lll,2}=cost(i);
        dumm{lll,1}=PQ{i};
        dumm{lll,3}=bp(1);
        lll=lll+1;
    end
end
lll=1;
%now push to pool
pool=[pool;dumm];
clear dumm
count = 1; %keep track of iterations
%%
maxiter = 1e6; %just to make sure the code does not run forever

while ~isempty(PQ) && count<maxiter 
    if(sum(cell2mat(cellfun(@(x)isequal(PQ{1},x),pool(:,1),'UniformOutput',false)))~=0)
        ploc=cell2mat(pool(find((cellfun(@(x)isequal(PQ{1},x),pool(:,1)))),3));
        if(ploc)
        par=pool(ploc,1);
        chx=find(cell2mat(par)==9)-find((PQ{1})==9);
        switch(chx)
            case  3;
                dont=2;%dont moved blank to right again
            case 1 ;
                dont=4;%dont moved down again
            case -1 ;
                dont=3;% dont moved up again
            case -3 ;
                dont=1;%dont moved blank to left again
        end
        else
            PQ(1)=[];
            cost(1)=[];
            dont=0;
        end
    else
        dont=0;
    end
    %
    cc=count+1;
    [v,op,bp]=suc(PQ{1},pool,dont); %CHANGED CODE
    %[v,op,bp]=suc(PQ{1},pool,dont);
    
    PQ(1)=[];
    %%
    %%Final attempt to fix code-do not change the cost of items already existing in PQ
    %find the new cost of v items
    pcost=cost(2:end);%stored the cost of items already in PQ during the last run
    % cost of items in v have to be found
    [PF,cost2]=rearrange(v',G,S,cc);
    v=PF';
    
    [v,cost2,bp]=inornot(v,pool,PQ,bp,cost2,pcost);

    %these new costs have to added to the end of pcost and v has to added to PQ
    PQ=[PQ,v'];
    cost=[pcost,cost2];
   
    % Now sorting must be done again based on cost
    [cost,idx2]=sort(cost);
    for i=1:length(idx2)
        RR{i}=PQ{idx2(i)};
    end
    PQ=RR;
    clear RR
    %%
    %     PQ=[PQ,v'];
    %     [PS,cost]=rearrange(PQ,G,S,cc);
    %     PQ=PS;
    %%
    lll=1;
    dumm=[];
    %%
    for i=1:length(PQ)
        if(sum(cell2mat(cellfun(@(x)isequal(PQ{i},x),pool(:,1),'UniformOutput',false)))==0)
            dumm{lll,2}=cost(i);
            dumm{lll,1}=PQ{i};
            dumm{lll,3}=bp(1);
            lll=lll+1;
        end
    end
    %~~~~~~~~CHANGES~~~~~~~~~~~~~~
%     if(sum(cell2mat(cellfun(@(x)isequal(G,x),PQ,'UniformOutput',false)))~=0)
%         PQ{1}=G;
%         pool=[pool;{G,0,bp(1)}];
%         PQ=[];
%     else
        
pool=[pool;dumm];
% 
%     end
    %~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    count = count+1;
    if(sum(cell2mat(cellfun(@(x)isequal(G,x),pool(:,1),'UniformOutput',false)))~=0)
        PQ=[];
    end
    count
    clear v
end
% P=pool;
P=mov(pool,S,G);
end

function [v,op,bp]=suc(N,pool,dont)
t=find(N==9);
U=[];D=[];L=[];R=[];
op=[0,0,0,0];
if(t~=3 && t~=6 && t~=9 && dont~=4)
    D=down(N,t);
    op(2)=4;
end
if(t~=1 && t~=4 && t~=7 && dont~=3)
    U=up(N,t);
    op(1)=3;
end

if(t~=1 && t~=2 && t~=3 && dont~=1)
    L=left(N,t);
    op(3)=1;
end
if(t~=7 && t~=8 && t~=9 && dont~=2)
    R=right(N,t);
    op(4)=2;
end
suc1={L;D;U;R};
v=suc1(~cellfun('isempty',suc1));
op(op==0) = [];
bploc=find(cell2mat(cellfun(@(x) isequal(x,N),pool,'UniformOutput',false))==1);
for i=1:length(op)
    bp(i)=bploc;
end
end

function A=up(N,t)
N(t)=N(t-1);
N(t-1)=9;
A=N;
end
function A=down(N,t)
N(t)=N(t+1);
N(t+1)=9;
A=N;
end
function A=left(N,t)
N(t)=N(t-3);
N(t-3)=9;
A=N;
end
function A=right(N,t)
N(t)=N(t+3);
N(t+3)=9;
A=N;
end
%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~%


%------REARRANGE AND TOTAL COST function f(N)-----------------%

function [R,cost]=rearrange(N,G,S,cc) %Total cost
for i=1:length(N)
    m(i)=f(N{i},G,S,cc);
end
[~,idx]=sort(m);
for i=1:length(idx)
    Rx{i}=N{idx(i)};
end
R=Rx;
for i=1:length(R)
    cost(i)=f(R{i},G,S,cc);
end
end
function F=f(N,G,S,cc) %Total cost
F=(9-h(N,G))+cc; %working condition for first two
%F=(9-h(N,G))-cc;%working condition for first
%F=(9-h(N,G));%working condition for first
end
function H=h(N,G)
H=sum(sum(bsxfun(@eq,N,G)));
end
function g=gn(N,S)
g=sum(sum(bsxfun(@eq,N,S)));
end

function P=mov(pool,S,G)
pos=cell2mat(pool(length(pool),3));
C{1}=G;
k=2;
while(1)
    if(pos==1)break ;end
    C(k)=pool(pos,1);
    k=k+1;
    pos=cell2mat(pool(pos,3));
end
C{length(C)+1}=S;
C=fliplr(C);
for i=1:length(C)-1
    A=(C{i});
    B=(C{i+1});
    ch=find(B==9)-find(A==9);
    switch(ch)
        case 3;
            P(i)=1;%moved blank to left
        case 1 ;
            P(i)=3;%moved down
        case -1 ;
            P(i)=4;% moved up
        case -3 ;
            P(i)=2;%moved right
    end
end
end
function [v2,cost22,bp2]=inornot(v,pool,PQ,bp,cost2,pcost)
gh=1;
kkl=1;
for ik=1:length(v)
    a=sum(cell2mat(cellfun(@(x)isequal(v{ik},x),pool(:,1),'UniformOutput',false)));
    if(a==0)
        cv2(kkl)=v(ik);
        ccost2(kkl)=cost2(ik);
        bp2(kkl)=bp(ik);
        kkl=kkl+1;
        gh=0;
    end
    if (sum(cell2mat(cellfun(@(x)isequal(v{ik},x),PQ,'UniformOutput',false)))~=0)
        [iii,jjj]=find(cellfun(@(x)isequal(v{ik},x),PQ));
        if(pcost(jjj(1))>cost2(ik))
        pool(find(cellfun(@(x)isequal(v{ik},x),pool(:,1))),2:3)={cost2(ik),bp(ik)};
        cv2(kkl)=v(ik);
        ccost2(kkl)=cost2(ik);
        bp2(kkl)=bp(ik);
        kkl=kkl+1;
        gh=0;
        end
        
    end
    if(a~=0)
        costcheck=cell2mat(pool(find((cellfun(@(x)isequal(v{ik},x),pool(:,1)))),2));
        if(costcheck>cost2(ik))
            pool(find(cellfun(@(x)isequal(v{ik},x),pool(:,1))),2:3)={cost2(ik),bp(ik)};
            cv2(kkl)=v(ik);
            ccost2(kkl)=cost2(ik);
            bp2(kkl)=bp(ik);
            kkl=kkl+1;
        gh=0;    
        end
        
    end

   
end
if(gh==0)
    v2=cv2';
    cost22=ccost2;
else
    v2=[];
    cost22=[];
    bp2=[];
end

end