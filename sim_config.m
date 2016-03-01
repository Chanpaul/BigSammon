function result = sim_config(data_file_list)
dataMap=containers.Map();
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
% %************************Page block**************************************
pageblock.name='page-blocks.data'; 
pageblock.subdir='pageblock\';
pageblock.label=11; %Indicates which column is the label, 0 for unlabeled.
pageblock.feature=[1:10];  %features used for clustering
pageblock.isNormalizable=1;   % indicates whether this dataset needs normalization.
pageblock.other=[];  %others, e.g., the id and sth like.
pageblock.ncopy=1;
pageblock.numPerCopy=5473;
pageblock.cnum=5;
pageblock.clean='N';
dataMap('pageblock')=pageblock;
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
iris.name='iris.data';
iris.subdir='';
iris.label=5;
iris.feature=[1:4];
iris.sep=',';
iris.clean='Y';
iris.isNormalizable=1;   % indicates whether this dataset needs normalization.
iris.other=[];  %others, e.g., the id and sth like.
iris.ncopy=1;
iris.numPerCopy=150;
iris.cnum=3;
dataMap('iris')=iris;
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
base=10000;
for ii=1:2:10,  
    prefix=strcat('sim_quit_primo_',num2str(ii*base));
    cur_dataset.name=strcat(prefix,'.dat');
    cur_dataset.subdir='SimulateData\';        
    cur_dataset.label=21;
    cur_dataset.feature=[1:20];
    cur_dataset.isNormalizable=1;
    cur_dataset.other=[];
    cur_dataset.ncopy=1;
    cur_dataset.numPerCopy=ii*base;
    cur_dataset.cnum=4;
    cur_dataset.clean='N';
    dataMap(prefix)=cur_dataset;    
end;
%****************************************************************************
retDataMap=containers.Map();
for ii=1:length(data_file_list),
    curFile=data_file_list{ii};
    retDataMap(curFile)=dataMap(curFile);    
end;
result=retDataMap;