function projection = bigSammon(data,param)

%Calling function of the visualization functions
% close all
% clear all
colors={'r.' 'gx' 'b+' 'ys' 'm.' 'c.' 'k.' 'r*' 'g*' 'b*' 'y*' 'm*' 'c*' 'k*' };
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
C=data.label;
cnum=data.cnum;
% %normalization of the data
data.X=clustnorml(data.X,'range');
%fuzzy c-means clustering 
m=param.m;
percent=param.percent;
[ND,na]=size(data.X);
%***************************Compute distance**********************************
mdist=zeros(ND,ND);
for i=1:ND
    mdist(i,:)=sqrt(sum(abs(ones(ND,1)*data.X(i,:)-data.X).^2,2));
end;
fprintf('average percentage of neighbours (hard coded): %5.6f\n', percent);
N=ND*ND;
xx=reshape(mdist,[1,N]);
position=round(N*percent/100);
sda=sort(xx);
dc=sda(position);

fprintf('Computing Rho with gaussian kernel of radius: %12.6f\n', dc);
data_sep_info=data_sep(mdist,dc);
%[coeff, score, latent, tsquared, explained] = pca(data.X);
figure(21)
plot(data_sep_info.rho,data_sep_info.delta,'o');
[mappedX, mapping] = pca(data.X);
proj=mappedX;
%proj=data.X*coeff(:,1:2); %obtain the projection;
%param.rho=data_sep_info.rho
param.alpha = 0.4;
param.max=100;
figure(6);
result=ESam(proj,data.X,param,data_sep_info);
ClustName=unique(C);
figure(3);
for kk=1:length(ClustName),
    if iscell(ClustName)    
        x = strcmp(ClustName{kk}, C);
    else        
        x=(C==ClustName(kk));
        %temp=result.proj.P(C==ClustName(kk),:);
    end;
    temp=result.proj.P(x,:);
    plot(temp(:,1),temp(:,2),'ob','markersize',10,'markerfacecolor','w');
    for idx = 1:length(temp)
        text(temp(idx,1),temp(idx,2), num2str(kk),...
            'FontSize',8,...
            'HorizontalAlignment','center');
    end
    hold on;
end;
projection=result.proj.P;




