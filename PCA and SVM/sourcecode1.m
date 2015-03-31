%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% NOTE: MY Z1 values for the dendrogram and the Z value got by the MATLAB command Z=linkage(Y) is exactly the same
% Just in some places the 2 connecting points are swapped(eg:3,31-->31,3)
%This does not change the final output figure

%ind has list of indices for class 1
 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clc
clear all
close all
X=importdata('data.txt');
lb=importdata('labels.txt');
munrun=[1, 1;1, 2;1, 3;2, 1;2, 2;2, 3];
nn=1;
%%
for nnn=1:6
%  nnn=3;%change this and above
    mun=munrun(nnn, 1);
    run=munrun(nnn, 2);
if mun==1
Y=pdist(X);
end
if mun==2
% Y=1-pdist(X, 'cosine');
Y=pdist(X, 'cosine');
end
I=squareform(Y);
sim=I;
done=true;
sim(logical(eye(size(sim)))) = max(max(I))+1000;
no_merges=0;
%% Checking_Disable if needed
Z_euc_single=linkage(X, 'single', 'euclidean');
Z_euc_average=linkage(X, 'average', 'euclidean');
Z_euc_complete=linkage(X, 'complete', 'euclidean');
Z_cos_single=linkage(X, 'single', 'cosine');
Z_cos_average=linkage(X, 'average', 'cosine');
Z_cos_complete=linkage(X, 'complete', 'cosine');
%%
% run=input('Choose run: 1)Single 2)Complete 3)Average  :>>');
%% for run=1:SIngle Linkage
if (run==1)
    dean=zeros(2, 1);
    while(done)
        c=min(sim(:));
        no_merges=no_merges+1;
        [row,col] = find(sim(:,:)==c);
        sim(:,col(1))=bsxfun(@min,sim(:,col(1)),sim(:,col(2)));
        sim(col(1),col(1))=max(max(I))+1000;
        sim(col(1),:)=bsxfun(@min,sim(col(1),:),sim(col(2),:));
        sim(col(1),col(1))=max(max(I))+1000;
        sim(:,col(2))=[];
        sim(col(2),:)=[];
        combinations(no_merges,:)=[col',c];
        done=~(length(sim)==1);
        dean(no_merges, 1)=col(1);
    end
end
%% for run=2:Complete Linkage
if (run==2)
    dean=zeros(2, 1);
    while(done)
        c=min(sim(:));
        no_merges=no_merges+1;
        [row,col] = find(sim(:,:)==c);
        sim(:,col(1))=bsxfun(@max,sim(:,col(1)),sim(:,col(2)));
        sim(col(1),col(1))=max(max(I))+1000;
        sim(col(1),:)=bsxfun(@max,sim(col(1),:),sim(col(2),:));
        sim(col(1),col(1))=max(max(I))+1000;
        sim(:,col(2))=[];
        sim(col(2),:)=[];
        combinations(no_merges,:)=[col',c];
        done=~(length(sim)==1);
        dean(no_merges, 1)=col(1);
    end
end
 
 %% for run=3:Average Linkage
if (run==3)
    dean=zeros(2, 1);
    while(done)
        c=min(sim(:));
        no_merges=no_merges+1;
        [row,col] = find(sim(:,:)==c);
        sim(col(1),col(1))=0;
        sim(col(2),col(2))=0;
        dummy=[sim(:,col(1)),sim(:,col(2))];
        bbb=(mean(dummy,2));
        sim(:,col(1))=bbb;
        sim(col(1),:)=bbb';
        sim(col(1),col(1))=max(max(I))+1000;
        sim(:,col(2))=[];
        sim(col(2),:)=[];
        combinations(no_merges,:)=[col',c];
        done=~(length(sim)==1);
        dean(no_merges, 1)=col(1);
 end
end
 
 %--------------------------------------------------%
 %--------------------------------------------------%
 %% Now correcting the Z to use with dendogram data
%% 

la=combinations(:, 1:2);

la(30, :)=[0, 0];
la(31, :)=[0, 0];
ka=zeros(29,2);
% checking at run=1,2,3  reshuffle the data to show the correct order
% not required as the dendogram still connects 3,31 and 31,3 correctly
%---------------------------------------
% if(nnn==3)
%     dummy1=la(28/2,:);
%     la(28/2,:)=la((28/2)+1,:);
%     la((28/2)+1,:)=dummy1;
%     la(14)=11;
%     la(21)=2;
%     la(22)=5;
% end
%--------------------------------------------
    %post correcting the data based on greater than 30 or less than 30
for i=1:29
    tut(i, 1)=la(i, 2);
    kut(i, 1)=la(i, 1);
    tut=sort(tut);
    for j=1:length(tut)
    if(la((i+1), 1)>=tut(j))
        la((i+1),1)=la((i+1), 1)+1;
    end
    if(la((i+1), 2)>=tut(j))
        la((i+1),2)=la((i+1), 2)+1;
    end
    end
    
    if(ismember(la((i+1), 1),kut))
        idx=find(la((i+1), 1)==kut);
        ka(i, 1)=idx(end)+30;
    end
    if(ismember(la((i+1), 2),kut))
       idx=find(la((i+1), 2)==kut);
        ka(i, 2)=idx(end)+30;
    end
    end
    ka=[0, 0;ka];
    la(31, :)=[];
    la(30, :)=[];
    ka(30, :)=[];
for i=1:numel(ka)
if(ka(i)==0)
Z1(i)=la(i);
else
Z1(i)=ka(i);
end
end
Z1=reshape(Z1, 29, 2);
Z1(:, 3)=combinations(:, 3);

figure
dendrogram(Z1)
nn=nn+1;
clear ka la kut tut sim no_merges

don=1;
l=[Z1(1) Z1(30)];
a=31;
while(don)
%Example of marking the indices 
%find where 4/31 is-->make it cluster 2(31) 4,<15>
%find the other part of 31 ie 13-->make it cluster 3(36) <13>,31
%find where 36 is-->make it cluster 4(47) 36 <41>-->36 <2> <32>-->36 2 <12><21>
%find where 47 is -->make it cluster 5(48)--><6> 47
%find where 48 is -->6(53)--><18> 48
%find 53-->7(57)-->53 <55>-->53 <44> <51>-->53 17 <35> <51>-->
%until you reach the last-1 cluster-->ie the cluster 1 and cluster 2 never connect
if(isempty(a)==1)
    break
end
next=find(a==Z1);
if(next>29)
    l=[l,Z1(next),Z1(next-29)];
    a=(next-29)+30;
else
    l=[l,Z1(next),Z1(next+29)];
    a=(next)+30;
    end

end
%now ind has list of indices for class 1
indices{nnn}=l;
kkk=2;
a=indices{nnn};
b=a(1);
for i=2:numel(a)
if(mod(i,2)==0)
b(kkk)=a(i);
kkk=kkk+1;
end
end
c=b;

b(end)=[];
i=1;
while(~isempty(find(b>30)))
    if (b(i)>30)
       b=[b(1:i-1) Z1(b(i)-30,1) Z1(b(i)-30,2) b(i+1:end)];
    else
        i=i+1;
    end
end
p=1:30;
class1{nnn}=b;
class2{nnn}=p(~ismember(p,class1{nnn}));


for nana=1:30
    if(double(ismember(nana,class1{nnn})))
        lbtest(nana)=1;
    else
        lbtest(nana)=2;
    end
end
accuracy{nnn}=sum(double(lb==lbtest'))/30;
 clear Z1 l b a lbtest
 end
accuracy