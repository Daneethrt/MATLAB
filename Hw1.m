%{
   1. Make a scatter plot of the data using different colors for the two different classes. 
      Rather than writing loops, you can use the power of Matlab to achieve this simply:
%}
data=load('tremor.mat');
I= find(ttr==0);
scatter(Xtr(I,1), Xtr(I,2), 10,'b','filled')
hold on
I1=find(ttr==1);
scatter(Xtr(I1,1), Xtr(I1,2), 10,'r','filled')

% 2. mean
mean(Xtr)
mean(Xtr(:,1))
mean(Xtr(:,2))
% standard devation
std(Xtr)
std(Xtr(:,1))
std(Xtr(:,2))
% covariance
cov(Xtr)
cov(Xtr(:,1))
cov(Xtr(:,2))
%correlation
corr(Xtr) 
corr(Xtr(I,1), Xtr(I,2)) 
corr(Xtr(I1,1), Xtr(I1,2)) 


%3.standardization
meanArray = mean(Xtr(:,1));
stdArray=std(Xtr(:,1));
standardizedData = (Xtr(:,1) - meanArray)/ stdArray;
meanArray1 = mean(Xtr(:,2));
stdArray1=std(Xtr(:,2));
standardizedData1 = (Xtr(:,2) - meanArray1)/ stdArray1;
newData=[standardizedData(:,1),standardizedData1(:,1)];
mean(newData)
mean(standardizedData(:,1))
mean(standardizedData1(:,1))

%x1=standardizedData1(:,1);
%x2=standardizedData2(:,1);



%4.Mahalanobis Classifier
N = 30;
M = 30;
x = Xte(:,1);
y = Xte(:,2);
%space for distance
D = zeros(M, N);
indexTr0=find(ttr==0);
indexTr1=find(ttr==1);
%individual variables
x0=Xtr(indexTr0,:);
x1=Xtr(indexTr1,:);
covarianceMatrix0=cov(x0);
covarianceMatrix1=cov(x1);
covarianceMatrix=cov(Xtr);
result=zeros(M,1);
for nx=1:N
    for my=1:M
        s1=[x(nx),y(my)]-mean(x1);
        s0=[x(nx),y(my)]-mean(x0);
        d1=sqrt((s1)*inv(covarianceMatrix1)*(s1).');
        d0=sqrt((s0)*inv(covarianceMatrix0)*(s0).');

        if(d1>d0)
            result(my)=0;
            D(my,nx)=d0;
        else
            result(my)=1;
            D(my,nx)=d1;
        end
    end
end 

total=0;
for i=1:M
    if (result(i)==tte(i))
        total=total+1;
    end
end 
disp(total)
tterate=(total/M*100)

total=0;
for i=1:M
    if(result(i)==ttr(i))
        total=total+1;
    end
end 
ttrate=(total/M*100)



 




