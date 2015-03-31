%%
clc
clear all
classname = importdata('newsgrouplabels.txt');
classn=length(classname);
classpos=1:length(classname);
classpos=classpos';
vocab=importdata('vocabulary.txt');
vocabpos=1:length(vocab);
vocabpos=vocabpos';
vocabn=length(vocab);
cdlabel = importdata('train.label');
docn=length(cdlabel);
cdlabel_test = importdata('test.label');
docn_test=length(cdlabel_test);
test=importdata('test.data');
train=importdata('train.data');
%%
prob1=zeros(20,1);
run=1;
alpha=linspace(.00001,1,20);
for ii=1:classn
    a=find(cdlabel==classpos(ii));%find the list of docs that belong to this class ii
    d=a';
    prob1(ii)=length(a)/docn;%no of docs in this class/total number of docs
    f={};
    %creating a full text cell matrix with all docs of this class
    for j=1:length(a)
        f{j}=find(train(:,1)==d(j));
    end
    %------------------------%
    min1 = min(cellfun(@(x) min(x(:)),f));
    max1 = max(cellfun(@(x) max(x(:)),f));
    allwords=train(min1:max1,2:3);%A full text matrix containing the wordid,count of each document in class
    %PART 2--------------%
    clear kk
    %for j=1:length(f)
    %   kk(j+1)=length(f{j});
    %end
    %kk(1)=1;
    %now you have the size of each document in this class
    %yyy=0;
    %for i=1:length(f)
    %  zz(yyy+1:yyy+kk(i+1),1)=f{i};%a vector pointing to the location of each document in class
    %   yyy=yyy+kk(i+1);
    %end
    %for k=1:length(zz)
    %   allwords(k,1:2)=train(zz(k),2:3);%A full text matrix containing the wordid,count of each document in class
    %end
    %ttextn(ii)=sum(allwords(:,2));%total occurrences of all words in this class
    %ttextn1(ii)=length(unique(allwords(:,1)));%no of unique word positions in full text
    %%
    pwc=1;
    clear nk nnn
    nnn=zeros(vocabn,1);
    counter=1;
    for l=1:vocabn
        vindex=find(l==allwords(:,1));
        if(isempty(vindex)==0)
            vvv(counter)=l;%A vector containing the list of vocabIDs that exist in this class
            counter=counter+1;
        end
        vvv=sort(vvv);
        for mm=1:length(vindex)
            nnn(l,1)=nnn(l,1)+allwords(vindex(mm),2);%A vector containing occurrences of each word in vocab in full text
        end
        freq(ii,l)=nnn(l,1);
    end
    nf=sum(freq(ii,:));
    
    for ll=1:length(freq(ii,:))
        dric=(1/vocabn);
        pwcfreq(ii,ll)=((freq(ii,ll)+dric)/(nf+20*dric));
        dric=(alpha(1));
        pwcfreq1(ii,ll)=((freq(ii,ll)+dric)/(nf+20*dric));
        dric=(alpha(2));
        pwcfreq2(ii,ll)=((freq(ii,ll)+dric)/(nf+20*dric));
        dric=(alpha(3));
        pwcfreq3(ii,ll)=((freq(ii,ll)+dric)/(nf+20*dric));
        dric=(alpha(4));
        pwcfreq4(ii,ll)=((freq(ii,ll)+dric)/(nf+20*dric));
        dric=(alpha(5));
        pwcfreq5(ii,ll)=((freq(ii,ll)+dric)/(nf+20*dric));
        dric=(alpha(6));
        pwcfreq6(ii,ll)=((freq(ii,ll)+dric)/(nf+20*dric));
        dric=(alpha(7));
        pwcfreq7(ii,ll)=((freq(ii,ll)+dric)/(nf+20*dric));
        dric=(alpha(8));
        pwcfreq8(ii,ll)=((freq(ii,ll)+dric)/(nf+20*dric));
        dric=(alpha(9));
        pwcfreq9(ii,ll)=((freq(ii,ll)+dric)/(nf+20*dric));
        dric=(alpha(10));
        pwcfreq10(ii,ll)=((freq(ii,ll)+dric)/(nf+20*dric));
        dric=(alpha(11));
        pwcfreq11(ii,ll)=((freq(ii,ll)+dric)/(nf+20*dric));
        dric=(alpha(12));
        pwcfreq12(ii,ll)=((freq(ii,ll)+dric)/(nf+20*dric));
        dric=(alpha(13));
        pwcfreq13(ii,ll)=((freq(ii,ll)+dric)/(nf+20*dric));
        dric=(alpha(14));
        pwcfreq14(ii,ll)=((freq(ii,ll)+dric)/(nf+20*dric));
        dric=(alpha(15));
        pwcfreq15(ii,ll)=((freq(ii,ll)+dric)/(nf+20*dric));
        dric=(alpha(16));
        pwcfreq16(ii,ll)=((freq(ii,ll)+dric)/(nf+20*dric));
        dric=(alpha(17));
        pwcfreq17(ii,ll)=((freq(ii,ll)+dric)/(nf+20*dric));
        dric=(alpha(18));
        pwcfreq18(ii,ll)=((freq(ii,ll)+dric)/(nf+20*dric));
        dric=(alpha(19));
        pwcfreq19(ii,ll)=((freq(ii,ll)+dric)/(nf+20*dric));
        dric=(alpha(20));
        pwcfreq20(ii,ll)=((freq(ii,ll)+dric)/(nf+20*dric));
        
    end
    
    
    clear a d f sum1 kk yyy zz nnn allwords nnn
end
%%

for k=1:length(cdlabel_test)
    index=find(test(:,1)==k);
    %max(index)=rownumber
    %min(index)=rownumber
    doctotest(:,:)=test(min(index):max(index),1:3);
    p=size(doctotest);
    for ii=1:20
        for i=1:p(1)
            g(ii,i)=pwcfreq(ii,doctotest(i,2));%*doctotest(i,3);%find the corresponding prob%*****************
            g1(ii,1)=pwcfreq1(ii,doctotest(i,2));
            g2(ii,1)=pwcfreq2(ii,doctotest(i,2));
            g3(ii,1)=pwcfreq3(ii,doctotest(i,2));
            g4(ii,1)=pwcfreq4(ii,doctotest(i,2));
            g5(ii,1)=pwcfreq5(ii,doctotest(i,2));
            g6(ii,1)=pwcfreq6(ii,doctotest(i,2));
            g7(ii,1)=pwcfreq7(ii,doctotest(i,2));
            g8(ii,1)=pwcfreq8(ii,doctotest(i,2));
            g9(ii,1)=pwcfreq9(ii,doctotest(i,2));
            g10(ii,1)=pwcfreq10(ii,doctotest(i,2));
            g11(ii,1)=pwcfreq11(ii,doctotest(i,2));
            g12(ii,1)=pwcfreq12(ii,doctotest(i,2));
            g13(ii,1)=pwcfreq13(ii,doctotest(i,2));
            g14(ii,1)=pwcfreq14(ii,doctotest(i,2));
            g15(ii,1)=pwcfreq15(ii,doctotest(i,2));
            g16(ii,1)=pwcfreq16(ii,doctotest(i,2));
            g17(ii,1)=pwcfreq17(ii,doctotest(i,2));
            g18(ii,1)=pwcfreq18(ii,doctotest(i,2));
            g19(ii,1)=pwcfreq19(ii,doctotest(i,2));
            g20(ii,1)=pwcfreq20(ii,doctotest(i,2));
        end
        %         g(ii,:)=log(g(ii,:));
        %         g1(ii,:)=log(g1(ii,:));
        %         g2(ii,:)=log(g2(ii,:));
        %         g3(ii,:)=log(g3(ii,:));
        %         g4(ii,:)=log(g4(ii,:));
        %         g5(ii,:)=log(g5(ii,:));
        %         g6(ii,:)=log(g6(ii,:));
        %         g7(ii,:)=log(g7(ii,:));
        %         g8(ii,:)=log(g8(ii,:));
        %         g9(ii,:)=log(g9(ii,:));
        %         g10(ii,:)=log(g10(ii,:));
        %         g11(ii,:)=log(g11(ii,:));
        %         g12(ii,:)=log(g12(ii,:));
        %         g13(ii,:)=log(g13(ii,:));
        %         g14(ii,:)=log(g14(ii,:));
        %         g15(ii,:)=log(g15(ii,:));
        %         g16(ii,:)=log(g16(ii,:));
        %         g17(ii,:)=log(g17(ii,:));
        %         g18(ii,:)=log(g18(ii,:));
        %         g19(ii,:)=log(g19(ii,:));
        %         g20(ii,:)=log(g20(ii,:));
        % prob2(ii)=sum(log(g(ii,:)),2);
        % prob21(ii)=sum(log(g1(ii,:)),2);
        % prob22(ii)=sum(log(g2(ii,:)),2);
        % prob23(ii)=sum(log(g3(ii,:)),2);
        % prob24(ii)=sum(log(g4(ii,:)),2);
        % prob25(ii)=sum(log(g5(ii,:)),2);
        % prob26(ii)=sum(log(g6(ii,:)),2);
        % prob27(ii)=sum(log(g7(ii,:)),2);
        % prob28(ii)=sum(log(g8(ii,:)),2);
        % prob29(ii)=sum(log(g9(ii,:)),2);
        % prob210(ii)=sum(log(g10(ii,:)),2);
        % prob211(ii)=sum(log(g11(ii,:)),2);
        % prob212(ii)=sum(log(g12(ii,:)),2);
        % prob213(ii)=sum(log(g13(ii,:)),2);
        % prob214(ii)=sum(log(g14(ii,:)),2);
        % prob215(ii)=sum(log(g15(ii,:)),2);
        % prob216(ii)=sum(log(g16(ii,:)),2);
        % prob217(ii)=sum(log(g17(ii,:)),2);
        % prob218(ii)=sum(log(g18(ii,:)),2);
        % prob219(ii)=sum(log(g19(ii,:)),2);
        % prob220(ii)=sum(log(g20(ii,:)),2);
        %         prob22(ii)=sum(g2(ii,:),2);
        %         prob23(ii)=sum(g3(ii,:),2);
        %         prob24(ii)=sum(g4(ii,:),2);
        %         prob25(ii)=sum(g5(ii,:),2);
        %         prob26(ii)=sum(g6(ii,:),2);
        %         prob27(ii)=sum(g7(ii,:),2);
        %         prob28(ii)=sum(g8(ii,:),2);
        %         prob29(ii)=sum(g9(ii,:),2);
        %         prob210(ii)=sum(g10(ii,:),2);
        %         prob211(ii)=sum(g11(ii,:),2);
        %         prob212(ii)=sum(g12(ii,:),2);
        %         prob213(ii)=sum(g13(ii,:),2);
        %         prob214(ii)=sum(g14(ii,:),2);
        %         prob215(ii)=sum(g15(ii,:),2);
        %         prob216(ii)=sum(g16(ii,:),2);
        %         prob217(ii)=sum(g17(ii,:),2);
        %         prob218(ii)=sum(g18(ii,:),2);
        %         prob219(ii)=sum(g19(ii,:),2);
        %         prob220(ii)=sum(g20(ii,:),2);
        decision(ii)=log(prob1(ii))+sum(log(g(ii,:)),2);
        decision1(ii)=log(prob1(ii))+sum(log(g1(ii,:)),2);
        decision2(ii)=log(prob1(ii))+sum(log(g2(ii,:)),2);
        decision3(ii)=log(prob1(ii))+sum(log(g3(ii,:)),2);
        decision4(ii)=log(prob1(ii))+sum(log(g4(ii,:)),2);
        decision5(ii)=log(prob1(ii))+sum(log(g5(ii,:)),2);
        decision6(ii)=log(prob1(ii))+sum(log(g6(ii,:)),2);
        decision7(ii)=log(prob1(ii))+sum(log(g7(ii,:)),2);
        decision8(ii)=log(prob1(ii))+sum(log(g8(ii,:)),2);
        decision9(ii)=log(prob1(ii))+sum(log(g9(ii,:)),2);
        decision10(ii)=log(prob1(ii))+sum(log(g10(ii,:)),2);
        decision11(ii)=log(prob1(ii))+sum(log(g11(ii,:)),2);
        decision12(ii)=log(prob1(ii))+sum(log(g12(ii,:)),2);
        decision13(ii)=log(prob1(ii))+sum(log(g13(ii,:)),2);
        decision14(ii)=log(prob1(ii))+sum(log(g14(ii,:)),2);
        decision15(ii)=log(prob1(ii))+sum(log(g15(ii,:)),2);
        decision16(ii)=log(prob1(ii))+sum(log(g16(ii,:)),2);
        decision17(ii)=log(prob1(ii))+sum(log(g17(ii,:)),2);
        decision18(ii)=log(prob1(ii))+sum(log(g18(ii,:)),2);
        decision19(ii)=log(prob1(ii))+sum(log(g19(ii,:)),2);
        decision20(ii)=log(prob1(ii))+sum(log(g20(ii,:)),2);
    end
    [AAAA,classnumber]=max(decision);
    final(k)=classnumber;
    [AAAA,classnumber]=max(decision1);
    final1(k)=classnumber;
    [AAAA,classnumber]=max(decision2);
    final2(k)=classnumber;
    [AAAA,classnumber]=max(decision3);
    final3(k)=classnumber;
    [AAAA,classnumber]=max(decision4);
    final4(k)=classnumber;
    [AAAA,classnumber]=max(decision5);
    final5(k)=classnumber;
    [AAAA,classnumber]=max(decision6);
    final6(k)=classnumber;
    [AAAA,classnumber]=max(decision7);
    final7(k)=classnumber;
    [AAAA,classnumber]=max(decision8);
    final8(k)=classnumber;
    [AAAA,classnumber]=max(decision9);
    final9(k)=classnumber;
    [AAAA,classnumber]=max(decision10);
    final10(k)=classnumber;
    [AAAA,classnumber]=max(decision11);
    final11(k)=classnumber;
    [AAAA,classnumber]=max(decision12);
    final12(k)=classnumber;
    [AAAA,classnumber]=max(decision13);
    final13(k)=classnumber;
    [AAAA,classnumber]=max(decision14);
    final14(k)=classnumber;
    [AAAA,classnumber]=max(decision15);
    final15(k)=classnumber;
    [AAAA,classnumber]=max(decision16);
    final16(k)=classnumber;
    [AAAA,classnumber]=max(decision17);
    final17(k)=classnumber;
    [AAAA,classnumber]=max(decision18);
    final18(k)=classnumber;
    [AAAA,classnumber]=max(decision19);
    final19(k)=classnumber;
    [AAAA,classnumber]=max(decision20);
    final20(k)=classnumber;
    clear index doctotest g g1 g2 g3 g4 g5 g6 g7 g8 g9 g10 g11 g12 g13 g14 g15 g16 g17 g18 g19 g20 prob2 decision
end
final(2,:)=final==cdlabel_test';
final1(2,:)=final1==cdlabel_test';
final2(2,:)=final2==cdlabel_test';
final3(2,:)=final3==cdlabel_test';
final4(2,:)=final4==cdlabel_test';
final5(2,:)=final5==cdlabel_test';
final6(2,:)=final6==cdlabel_test';
final7(2,:)=final7==cdlabel_test';
final8(2,:)=final8==cdlabel_test';
final9(2,:)=final9==cdlabel_test';
final10(2,:)=final10==cdlabel_test';
final11(2,:)=final11==cdlabel_test';
final12(2,:)=final12==cdlabel_test';
final13(2,:)=final13==cdlabel_test';
final14(2,:)=final14==cdlabel_test';
final15(2,:)=final15==cdlabel_test';
final16(2,:)=final16==cdlabel_test';
final17(2,:)=final17==cdlabel_test';
final18(2,:)=final18==cdlabel_test';
final19(2,:)=final19==cdlabel_test';
final20(2,:)=final20==cdlabel_test';

accuracy(1)=sum(final(2,:),2)/length(cdlabel_test)*100;
accuracy(2)=sum(final1(2,:),2)/length(cdlabel_test)*100;
accuracy(3)=sum(final2(2,:),2)/length(cdlabel_test)*100;
accuracy(4)=sum(final3(2,:),2)/length(cdlabel_test)*100;
accuracy(5)=sum(final4(2,:),2)/length(cdlabel_test)*100;
accuracy(6)=sum(final5(2,:),2)/length(cdlabel_test)*100;
accuracy(7)=sum(final6(2,:),2)/length(cdlabel_test)*100;
accuracy(8)=sum(final7(2,:),2)/length(cdlabel_test)*100;
accuracy(9)=sum(final8(2,:),2)/length(cdlabel_test)*100;
accuracy(10)=sum(final9(2,:),2)/length(cdlabel_test)*100;
accuracy(11)=sum(final10(2,:),2)/length(cdlabel_test)*100;
accuracy(12)=sum(final11(2,:),2)/length(cdlabel_test)*100;
accuracy(13)=sum(final12(2,:),2)/length(cdlabel_test)*100;
accuracy(14)=sum(final13(2,:),2)/length(cdlabel_test)*100;
accuracy(15)=sum(final14(2,:),2)/length(cdlabel_test)*100;
accuracy(16)=sum(final15(2,:),2)/length(cdlabel_test)*100;
accuracy(17)=sum(final16(2,:),2)/length(cdlabel_test)*100;
accuracy(18)=sum(final17(2,:),2)/length(cdlabel_test)*100;
accuracy(19)=sum(final18(2,:),2)/length(cdlabel_test)*100;
accuracy(20)=sum(final19(2,:),2)/length(cdlabel_test)*100;
accuracy(21)=sum(final20(2,:),2)/length(cdlabel_test)*100;
