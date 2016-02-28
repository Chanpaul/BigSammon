function projection = bigSammon(data,param)
ts1=tic;
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
flag=param.flag;  %used for save file;
result_dir=strcat(param.res_dir,'/');
percent=param.percent;
[ND,na]=size(data.X);
%***************************Compute distance**********************************
mdist=zeros(ND,ND);
for i=1:ND
    mdist(i,:)=sqrt(sum(abs(ones(ND,1)*data.X(i,:)-data.X + 0.00001).^2,2));
end;
fprintf('average percentage of neighbours (hard coded): %5.6f\n', percent);
N=ND*ND;
xx=reshape(mdist,[1,N]);
position=round(N*percent/100);
sda=sort(xx);
dc=sda(position);

fprintf('Computing Rho with gaussian kernel of radius: %12.6f\n', dc);
data_sep_info=data_sep(mdist,dc);
telapsed1=toc(ts1);
%[coeff, score, latent, tsquared, explained] = pca(data.X);
figure(2);
plot(data_sep_info.rho,data_sep_info.delta,'o');
grid;
fig_name=strcat(result_dir,flag,'_dc',num2str(percent),'_dg');
saveas(2,fig_name{1},'png');

ts2=tic;
[mappedX, mapping] = pca(data.X);
proj=mappedX;
%proj=data.X*coeff(:,1:2); %obtain the projection;
%param.rho=data_sep_info.rho
param.alpha = 0.4;
param.max=100;
figure(3);
result=ESam(proj,data.X,param,data_sep_info);

telapsed2=toc(ts2);
ClustName=unique(C);
fig_name=strcat(result_dir,flag,'_dc',num2str(percent),'_2dim1');
saveas(3,fig_name{1},'png');

figure(4);
for kk=1:length(ClustName),
    if iscell(ClustName)    
        x = strcmp(ClustName{kk}, C);
    else        
        x=(C==ClustName(kk));
        %temp=result.proj.P(C==ClustName(kk),:);
    end;
    temp=result.proj.P(x,:);
    plot(temp(:,1),temp(:,2),colors{kk},'markersize',10,'markerfacecolor','w');
    for idx = 1:length(temp)
        text(temp(idx,1),temp(idx,2), num2str(kk),...
            'FontSize',5,...
            'HorizontalAlignment','center');
    end
    hold on;
end;
fig_name=strcat(result_dir,flag,'_dc',num2str(percent),'2dim2');
saveas(4,fig_name{1},'png');
projection.proj=result.proj.P;
projection.elapsed=telapsed2+telapsed1;
close all;



