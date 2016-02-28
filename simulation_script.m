% clear all
% close all
%dataDir= pwd;
%dataDir=strcat(dataDir,'\');
dataDir='..\';
path(path,'lib');
% %*******************************the real dataset 1****************
% dataFileName='D:\Wangjin\UmassMed\Code\Dataset\01_12_2015\MV\beforeimmu_mi1000.txt';    %the real dataset 1
% % dataFile=strcat(dataDir,dataFileName);
% rawData=importdata(dataFileName);
% dataset=rawData.data;
% 
% labelFile='D:\Wangjin\UmassMed\Code\Dataset\01_12_2015\MV\inconsistency.xls';
% label=importdata(labelFile);
% data.label=label.data(:,2);
% data.ncopy=1000;%1000;
% data.numPerCopy=162;
% isNormalizable=1;   % indicates whether this dataset needs normalization.
% rawNumPerCopy=162;
% data.cnum=3;
% % for jj=1:ncopy,
% %     startId=(jj-1)*numPerCopy+1;
% %     endId=jj*numPerCopy;
% %     dataset(startId:endId,end+1)=label(:,2)';
% % end;
% featureFg=[3:9];  %features used for clustering
% otherFg=[1:2,10];  %others, e.g., the id and sth like.
% data.X=dataset(:,featureFg);
% data.id=dataset(:,1);
% [ND,na]=size(data.X);

% % %**************************the dataset 2************************
% dataFileName='D:\Wangjin\UmassMed\Code\Dataset\01_12_2015\TDTA\TDTA_mi10_10_dur_idx.xls';    %the real dataset 2
% % dataFile=strcat(dataDir,dataFileName);
% dataLabelFg=13; %3%Indicates which column is the label, 0 for unlabeled.
% featureFg=[4:12];  %features used for clustering
% otherFg=[1:3];  %others, e.g., the id and sth like.
% data.ncopy=10;
% data.cnum=3;
% rawData=importdata(dataFileName);
% dataset=rawData.data.Sheet1;
% nullItem=[];
% for ii=1:size(dataset,1),
%     tt=isfinite(dataset(ii,:));
%     if ~isempty(find(tt==0,2)),
%         nullItem=[nullItem,ii];
%     end;
% end;
% dataset(nullItem,:)=[];
% rawNumPerCopy=109;  %including the null data items.
% data.numPerCopy=97;      %no null data items
% isNormalizable=1;   % indicates whether this dataset needs normalization.
% data.X=dataset(:,featureFg);
% data.label=dataset(:,dataLabelFg);
% data.label=data.label(1:data.numPerCopy,:);
% 
% data.X=data.X(1:data.numPerCopy,:);
% 
% data.id=dataset(:,1);
% [ND,na]=size(data.X);
%*********************real dataset ppp_zero_wide dataset************************************
% %this dataset has no label
% dataFileName='ppp_zero_wide\ppp_zero_wide_6m_notrt.xlsx';     %flag=22
% dataFile=strcat(dataDir,dataFileName);
% dataset=importdata(dataFile); 
% featureMM_Count={'MM_Count_performance_t1','MM_Count_performance_t2','MM_Count_performance_t3','MM_Count_performance_t4','MM_Count_performance_t5','MM_Count_performance_t6'};
% featureOA_Count={'OA_Count_performance_t1','OA_Count_performance_t2','OA_Count_performance_t3','OA_Count_performance_t4','OA_Count_performance_t5','OA_Count_performance_t6'};
% featureOC_Count={'OC_Count_performance_t1','OC_Count_performance_t2','OC_Count_performance_t3','OC_Count_performance_t4','OC_Count_performance_t5','OC_Count_performance_t6'};
% featureMM_CountId=[];
% featureOA_CountId=[];
% featureOC_CountId=[];
% featureMM_CountId=find(ismember(dataset.colheaders,featureMM_Count));
% featureOA_CountId=find(ismember(dataset.colheaders,featureOA_Count));
% featureOC_CountId=find(ismember(dataset.colheaders,featureOC_Count));
% dataLabelFg=0; %Indicates which column is the label, 0 for unlabeled.
% featureFg=[featureMM_CountId,featureOA_CountId,featureOC_CountId];  %features used for clustering
% otherFg=[];  %others, e.g., the id and sth like.
% data.ncopy=1;
% data.numPerCopy=1602;
% data.cnum=0;    %0 denotes that the cluster number is unknown.
% isNormalizable=1;   % indicates whether this dataset needs normalization.
% data.X=dataset.data(:,featureFg);
% if dataLabelFg~=0,
%     data.label=dataset(:,dataLabelFg);
% end;
% [ND,na]=size(data.X);
%********************************END**************************
%************************Quitprimo**************************************
% dataFileName='Dataset\QP_dur_clusterlabel.xlsx';
% dataFile=strcat(dataDir,dataFileName);
% rawdata=importdata(dataFile); 
% dataset=rawdata.data.Sheet1;
% dataLabelFg=27; %Indicates which column is the label, 0 for unlabeled.
% featureFg=[5:22,24:25];  %features used for clustering
% otherFg=[];  %others, e.g., the id and sth like.
% data.ncopy=1;
% data.numPerCopy=1320;
% isNormalizable=1;   % indicates whether this dataset needs normalization.
% data.cnum=4;
% data.X=dataset(:,featureFg);
% data.label=dataset(:,dataLabelFg);
% [ND,na]=size(data.X);
% %************************musk version 2 **************************************
% dataFileName='musk\clean2.data';
% distFileName='musk.dist';
% resultFile='musk.txt';
% dataFile=strcat(dataDir,dataFileName);
% rawdata=importdata(dataFile); 
% dataset=rawdata.data;
% dataLabelFg=167; %Indicates which column is the label, 0 for unlabeled.
% featureFg=[1:166];  %features used for clustering
% otherFg=[];  %others, e.g., the id and sth like.
% data.ncopy=1;
% data.numPerCopy=6598;
% isNormalizable=1;   % indicates whether this dataset needs normalization.
% data.cnum=2;
% data.X=dataset(:,featureFg);
% data.label=dataset(:,dataLabelFg);
% data.label(data.label==0)=max(data.label)+1;
% [ND,na]=size(data.X);
% %************************Pen-Based Recognition of Handwritten Digits**************************************
% dataFileName='pendigits\pendigits.tra';
% dataFile=strcat(dataDir,dataFileName);
% dataset=importdata(dataFile); 
% dataLabelFg=17; %Indicates which column is the label, 0 for unlabeled.
% featureFg=[1:16];  %features used for clustering
% isNormalizable=1;   % indicates whether this dataset needs normalization.
% otherFg=[];  %others, e.g., the id and sth like.
% data.ncopy=1;
% data.numPerCopy=7494;
% data.cnum=10;
% data.X=dataset(:,featureFg);
% data.label=dataset(:,dataLabelFg);
% data.label(data.label==0)=max(data.label)+1;
% [ND,na]=size(data.X);
% %************************QSAR biodegradation Data Set **************************************
% dataFileName='D:\Wangjin\UmassMed\Code\Dataset\QSAR_Bio\biodeg.csv';
% dataset=importdata(dataFileName); 
% dataLabelFg=42; %Indicates which column is the label, 0 for unlabeled.
% featureFg=[1:41];  %features used for clustering
% isNormalizable=0;   % indicates whether this dataset needs normalization.
% otherFg=[];  %others, e.g., the id and sth like.
% data.ncopy=1;
% data.numPerCopy=1055;
% data.cnum=2;
% data.X=dataset(:,featureFg);
% data.label=dataset(:,dataLabelFg);
% [ND,na]=size(data.X);

%************************iris**************************************
% data.X=zeros(150,4);
% data.label=[];
% dataFileName='Dataset\iris.data';
% dataFile=strcat(dataDir,dataFileName);
% dataset=importdata(dataFile,','); 
% [N,n]=size(dataset);
% n=max(N,n);
% for ii=1:n,    
%     temp=strsplit(dataset{ii},',');
%     for jj=1:4,
%         data.X(ii,jj)=str2double(temp(jj));
%     end;
%     data.label{ii}=temp{jj+1};
% end;
% dataLabelFg=5; %Indicates which column is the label, 0 for unlabeled.
% featureFg=[1:4];  %features used for clustering
% otherFg=[];  %others, e.g., the id and sth like.
% data.ncopy=1;
% data.numPerCopy=150;
% data.cnum=3;
% isNormalizable=1;   % indicates whether this dataset needs normalization.
% % data.X=dataset(:,featureFg);
% % data.label=dataset(:,dataLabelFg);
% [ND,na]=size(data.X);

%************************breast-cancer**************************************
% dataFileName='D:\Wangjin\UmassMed\Code\Dataset\breast-cancer-wisconsin\breast-cancer-wisconsin.data';
% % dataFile=strcat(dataDir,dataFileName);
% dataset=importdata(dataFileName); 
% dataLabelFg=11; %Indicates which column is the label, 0 for unlabeled.
% featureFg=[2:10];  %features used for clustering
% otherFg=[];  %others, e.g., the id and sth like.
% data.ncopy=1;
% data.numPerCopy=699;
% data.cnum=2;
% isNormalizable=1;   % indicates whether this dataset needs normalization.
% data.X=dataset(:,featureFg);
% data.label=dataset(:,dataLabelFg);
% data.label(data.label==0)=max(data.label)+1;
% [ND,na]=size(data.X);
% %************************ionosphere**************************************
% dataFileName='D:\Wangjin\UmassMed\Code\Dataset\ionosphere\ionosphere.data';
% 
% dataset=importdata(dataFileName); 
% dataLabelFg=35; %Indicates which column is the label, 0 for unlabeled.
% featureFg=[1,3:34];  %features used for clustering
% isNormalizable=0;   % indicates whether this dataset needs normalization.
% otherFg=[];  %others, e.g., the id and sth like.
% data.ncopy=1;
% data.numPerCopy=351;
% data.cnum=2;
% data.X=dataset(:,featureFg);
% data.label=dataset(:,dataLabelFg);
% data.label(data.label==0)=max(data.label)+1;
% [ND,na]=size(data.X);
% %************************pima-india**************************************
% dataFileName='D:\Wangjin\UmassMed\Code\Dataset\pima-indians-diabetes\pima-indians-diabetes.data';
% dataset=importdata(dataFileName); 
% dataLabelFg=9; %Indicates which column is the label, 0 for unlabeled.
% featureFg=[1:8];  %features used for clustering
% isNormalizable=1;   % indicates whether this dataset needs normalization.
% otherFg=[];  %others, e.g., the id and sth like.
% data.ncopy=1;
% data.numPerCopy=768;
% data.cnum=2;
% data.X=dataset(:,featureFg);
% data.label=dataset(:,dataLabelFg);
% data.label(data.label==0)=max(data.label)+1;
% [ND,na]=size(data.X);
%************************waveform**************************************
% dataFileName='Dataset\waveform.data';
% dataFile=strcat(dataDir,dataFileName);
% dataset=importdata(dataFile); 
% dataLabelFg=22; %Indicates which column is the label, 0 for unlabeled.
% featureFg=[1:21];  %features used for clustering
% isNormalizable=1;   % indicates whether this dataset needs normalization.
% otherFg=[];  %others, e.g., the id and sth like.
% data.ncopy=1;
% data.numPerCopy=5000;
% data.cnum=3;
% data.X=dataset(:,featureFg);
% data.label=dataset(:,dataLabelFg);
% %data.label=num2cell(dataset(:,dataLabelFg));    %describe label with cell array;
% [ND,na]=size(data.X);
%****************************end*****************************************
% %************************wine**************************************
% dataFileName='Dataset\wine\wine.data';
% dataFile=strcat(dataDir,dataFileName);
% %dataFileName='D:\Wangjin\UmassMed\Code\Dataset\wine\wine.data';
% dataset=importdata(dataFile); 
% dataLabelFg=1; %Indicates which column is the label, 0 for unlabeled.
% featureFg=[2:13];  %features used for clustering
% isNormalizable=1;   % indicates whether this dataset needs normalization.
% otherFg=[];  %others, e.g., the id and sth like.
% data.ncopy=1;
% data.numPerCopy=178;
% data.cnum=3;
% data.X=dataset(:,featureFg);
% data.label=dataset(:,dataLabelFg);
% %data.label=num2cell(dataset(:,dataLabelFg));    %describe label with cell array;
% [ND,na]=size(data.X);
%****************************end*****************************************
%************************fit quit primo*********************************
% mu=zeros(4,20);
% sigma=zeros(20,20);
% simulate_data_num=10000;
% simulate_data=[];
% mu=[];
% sigma=[];
% for i=1:4,
%     tdata=data.X(data.label==i,:);
%     t_num=round(simulate_data_num*(length(tdata)/length(data.X)));
%     [muhat,sigma1hat]=normfit(tdata);
%     sigmahat=cov(tdata);
%     temp_data=mvnrnd(muhat,sigmahat,t_num);
%     temp_data(:,end+1)=i;
%     mu=[mu;muhat];
%     sigma=[sigma;sigmahat];
%     simulate_data=[simulate_data ;temp_data];
% end;
% dlmwrite('test.dat',simulate_data);
% dlmwrite('test.mu',mu);
% dlmwrite('test.sigma',sigma);
%dlmwrite('test.index',index);

%*************************************************************

dataset=importdata('.\test.dat');
data.cnum=4;
data.label=dataset(:,21);
data.X=dataset(:,1:20);
%Calling function of the visualization functions
% close all
% clear all
colors={'r.' 'gx' 'b+' 'ys' 'm.' 'c.' 'k.' 'r*' 'g*' 'b*' 'y*' 'm*' 'c*' 'k*' };
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

param.c=data.cnum;
%fuzzy c-means clustering 
param.m=2;
param.val=1;
param.vis=0;

ClustName=unique(data.label);
%*****************sammon from drtoolbox**********
% types='Sammon';
% no_dims=2;
% mappedA = compute_mapping(data.X, types, no_dims);

%*********************bigSammon******************************
param.percent=2; %5
mappedA=bigSammon(data,param);
%*************************compute classification accuracy*******************************
idx=kmeans(mappedA,data.cnum);
if iscell(ClustName),
    test.label={};
    for ii=1:ND,
        test.label{ii}=ClustName{idx(ii)};
    end;
else
    test.label=zeros(ND,1);
    for ii=1:ND,
        test.label(ii)=ClustName(idx(ii));
    end;
end;
[accuracy, true_labels, CM, corLabel] = calculateAccuracy(test.label, data.label);
