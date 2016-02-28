% clear all
% close all
%dataDir= pwd;
%dataDir=strcat(dataDir,'\');
dataDir='..\';
path(path,'lib');
dataMap=containers.Map();
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
%************************Quitprimo**************************************
Quitprimo.name='QP_dur_clusterlabel.xlsx';
Quitprimo.subdir='';
% dataFile=strcat(dataDir,dataFileName);
% rawdata=importdata(dataFile); 
% dataset=rawdata.data.Sheet1;
Quitprimo.label=27; %Indicates which column is the label, 0 for unlabeled.
Quitprimo.feature=[5:22];  %features used for clustering
Quitprimo.other=[];  %others, e.g., the id and sth like.
Quitprimo.ncopy=1;
Quitprimo.numPerCopy=1320;
Quitprimo.isNormalizable=1;   % indicates whether this dataset needs normalization.
Quitprimo.cnum=4;
Quitprimo.clean='N';

dataMap('Quitprimo')=Quitprimo;
% %************************musk version 2 **************************************
musk.name='clean2.data';
musk.subdir='musk\';
musk.label=167; %Indicates which column is the label, 0 for unlabeled.
musk.feature=[1:166];  %features used for clustering
musk.other=[];  %others, e.g., the id and sth like.
musk.ncopy=1;
musk.numPerCopy=6598;
musk.isNormalizable=1;   % indicates whether this dataset needs normalization.
musk.cnum=2;
musk.clean='N';
dataMap('musk')=musk;
% %************************Pen-Based Recognition of Handwritten Digits**************************************
penRecognition.name='pendigits.tra'; 
penRecognition.subdir='pendigits\';
penRecognition.label=17; %Indicates which column is the label, 0 for unlabeled.
penRecognition.feature=[1:16];  %features used for clustering
penRecognition.isNormalizable=1;   % indicates whether this dataset needs normalization.
penRecognition.other=[];  %others, e.g., the id and sth like.
penRecognition.ncopy=1;
penRecognition.numPerCopy=7494;
penRecognition.cnum=10;
penRecognition.clean='N';
dataMap('penRecognition')=penRecognition;
% %************************QSAR biodegradation Data Set **************************************
QSAR.name='biodeg.csv';
QSAR.subdir='QSAR_Bio\';
QSAR.label=42; %Indicates which column is the label, 0 for unlabeled.
QSAR.feature=[1:41];  %features used for clustering
QSAR.isNormalizable=0;   % indicates whether this dataset needs normalization.
QSAR.other=[];  %others, e.g., the id and sth like.
QSAR.ncopy=1;
QSAR.numPerCopy=1055;
QSAR.cnum=2;
QSAR.clean='Y';
QSAR.sep=';';
dataMap('QSAR')=QSAR;
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
%************************waveform**************************************
waveform.name='waveform.data';
waveform.subdir='';
waveform.label=22; %Indicates which column is the label, 0 for unlabeled.
waveform.feature=[1:21];  %features used for clustering
waveform.isNormalizable=1;   % indicates whether this dataset needs normalization.
waveform.other=[];  %others, e.g., the id and sth like.
waveform.ncopy=1;
waveform.numPerCopy=5000;
waveform.cnum=3;
waveform.clean='N';
dataMap('waveform')=waveform;
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
% 
% for ii=1:2:10,
%     simulate_data_num=10000*ii;
%     simulate_data=[];
%     sim_data_file=strcat('../DataSet/SimulateData/sim_quit_primo-',num2str(simulate_data_num),'.dat');
%     sim_mu=strcat('../Dataset/SimulateData/sim_quit_primo-',num2str(simulate_data_num),'.mu');
%     sim_sigma=strcat('../Dataset/SimulateData/sim_quit_primo-',num2str(simulate_data_num),'.sigma');
%     mu=[];
%     sigma=[];
%     for i=1:4,
%         tdata=data.X(data.label==i,:);
%         t_num=round(simulate_data_num*(length(tdata)/length(data.X)));
%         [muhat,sigma1hat]=normfit(tdata);
%         sigmahat=cov(tdata);
%         temp_data=mvnrnd(muhat+i*2,sigmahat,t_num);
%         temp_data(:,end+1)=i;
%         mu=[mu;muhat];
%         sigma=[sigma;sigmahat];
%         simulate_data=[simulate_data ;temp_data];
%     end;
% 
%     dlmwrite(sim_data_file,simulate_data);
%     dlmwrite(sim_mu,mu);
%     dlmwrite(sim_sigma,sigma);
% end;
%**************************simulated dataset***********************************
% clear all;
%the command 'eval' is useful
base=10000;
for ii=1:2:10,  
    prefix=strcat('sim_quit_primo_',num2str(ii*base));
    cur_dataset.name=strcat(prefix,'.dat');
    cur_dataset.subdir='SimulateData/';        
    cur_dataset.label=21;
    cur_dataset.feature=[1:20];
    cur_dataset.isNormalizable=1;
    cur_dataset.other=[];
    cur_dataset.ncopy=1;
    cur_dataset.numPerCopy=ii*base;
    cur_dataset.cnum=4;
    dataMap(prefix)=cur_dataset;    
end;
%*******************************run simulation**********************************************
colors={'r.' 'gx' 'b+' 'ys' 'm.' 'c.' 'k.' 'r*' 'g*' 'b*' 'y*' 'm*' 'c*' 'k*' };
%testFile={Quitprimo,waveform,QSAR,penRecognition,musk,sim_data{:}};
cur_dir=pwd;
data_set_keys=dataMap.keys();
numoffile=length(data_set_keys);
drtools={'sammon','bigsammon'};
for ii = 1:1,%numoffile,
    cur_data_str=dataMap(data_set_keys{ii});
    result_dir=strcat(cur_dir,'\result\',data_set_keys{ii});
    if exist(result_dir,'dir')~=7,
        %mkdirc=['mkdir', result_dir];
        mkdirc=sprintf('mkdir %s',result_dir);
        %mkdirc=strcat('mkdir','  ', result_dir);  %matlab 
        system(mkdirc) ;
    end;
    dataFile=strcat('..\DataSet\',cur_data_str.subdir,cur_data_str.name);
    rawdata=importdata(dataFile);
    if strfind(cur_data_str.name,'.xls'),        
        dataset=rawdata.data.Sheet1; 
    else
        dataset=rawdata;
    end; 
    if strcmp(cur_data_str.clean,'Y'),
        res_cle=clean(dataset,cur_data_str.sep,cur_data_str.feature,cur_data_str.label);
        data.X=res_cle.X;
        data.label=res_cle.label;
    else
        data.X=dataset(:,cur_data_str.feature);
        data.label=dataset(:,cur_data_str.label);
    end;
    
    data.cnum=cur_data_str.cnum;
    data.isNormalizable=cur_data_str.isNormalizable;   % indicates whether this dataset needs normalization.
    data.other=cur_data_str.other;  %others, e.g., the id and sth like.
    data.ncopy=cur_data_str.ncopy;
    data.numPerCopy=cur_data_str.numPerCopy;
    [ND,na]=size(data.X);
    
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
    param.flag=data_set_keys(ii);
    param.res_dir=result_dir;

    ClustName=unique(data.label);
    drname='';
    
    fn=strcat(result_dir,'\','performance');
    fid=fopen(fn,'w');
    
    for kk=1:length(drtools),
        if strcmp(drtools{kk},'sammon'),
        %*****************sammon from drtoolbox**********
            drname='sammon';
            types='Sammon';
            no_dims=2;
            tstart=tic;   %begin counting time;
            mappedA = compute_mapping(data.X, types, no_dims);
            telapsed=toc(tstart);
            
            figure(1);
            for kk=1:length(ClustName),
                if iscell(ClustName)    
                    x = strcmp(ClustName{kk}, data.label);
                else        
                    x=(data.label==ClustName(kk));
                    %temp=result.proj.P(C==ClustName(kk),:);
                end;
                temp=mappedA(x,:);
                plot(temp(:,1),temp(:,2),colors{kk},'markersize',10,'markerfacecolor','w');
                for idx = 1:length(temp)
                    text(temp(idx,1),temp(idx,2), num2str(kk),...
                        'FontSize',5,...
                        'HorizontalAlignment','center');
                end
                hold on;
            end; 
            fig_name=strcat(result_dir,'\',param.flag,'_sammon_','2dim2');
            saveas(1,fig_name{1},'png');
            res=comAcc(mappedA,data);
            content=sprintf('\n*********drname=%s***********\n running time: %f \n, accuracy=%f \n',drname, telapsed,res.accuracy);
            fn=strcat(result_dir,'\','performance');
            fid=foper(fn,'w');
            fwrite(fid,content);
        else if strcmp(drtools{kk},'bigsammon'),
            %*********************bigSammon******************************
                drname='bigsammon';
                for tt=2:2:10,
                    param.percent=tt; %5 2                    
                    mappedA=bigSammon(data,param);
                    telapsed=mappedA.elapsed;
                    res=comAcc(mappedA.proj,data);
                    content=sprintf('\n*********drname=%s***********\n running time: %f \n, dc=%d, accuracy=%f \n',...
                        drname, telapsed,param.percent,res.accuracy);
                    %content=sprintf('drname=%s, dc=%d, accuracy=%f;\n',drname, param.percent,res.accuracy);

                    fwrite(fid,content);
                end;
            end;
        end;
                 
    end;
end;


