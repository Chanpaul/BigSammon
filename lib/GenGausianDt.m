% function gdata = GenGausianDt( Dnum,C ,dim)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
f='D:\UmassMed\Code\Dataset\SimulateData\6000x7.txt';
clusterNum=5;
dataNum=6000;
dim=7;
fileId = fopen(f,'w');
rng('default');
rng(1000);
gdata=[];
for i=1:clusterNum,
    mu=5*i*rand(1,dim);
    sigma=zeros(dim,dim);    
    for k=1:dim,
        sigma(k,k)=1;
    end;
    %*********************************
% %     a=eye(N)*sprandsym(N,3);
%     while(prod((1:dim)'.*(eig(sigma)>0))==0)
%         for k=1:dim-1,
%             for j=k+1:dim,
%                 sigma(j,k)=abs(randn(1,1));
%                 sigma(k,j)=sigma(j,k);
%             end;
%         end;
%         for k=1:dim,
%             sigma(k,k)=1;
%         end;
%     end
    
%**************************
    tdata=mvnrnd(mu,sigma,dataNum/clusterNum);
    tdata=cat(2,tdata,i*ones(dataNum/clusterNum,1));
    gdata=cat(1,gdata,tdata);
    
end;
dlmwrite(f,gdata,'-append','delimiter', ' ');
% count=fwrite(fileId,tdata,'double');
% fclose(fileId);
rdata=importdata('D:\UmassMed\Code\Dataset\SimulateData\6000x7.txt');
% plot(rdata(:,1),rdata(:,2),'o');
% end

