% clear all
% close all
%dataDir= pwd;
%dataDir=strcat(dataDir,'\');
dataDir='..\';
path(path,'lib');
%***********************set global simulation configuration****************************
data_set_name={'waveform','pageblock','Quitprimo'};
base=10000;
for ii=1:2:10,  
    prefix=strcat('sim_quit_primo_',num2str(ii*base));
    data_set_name{end+1}=prefix;
end;
dataMap=sim_config(data_set_name);
colors={'r.' 'gx' 'b+' 'ys' 'm.' 'c.' 'k.' 'r*' 'g*' 'b*' 'y*' 'm*' 'c*' 'k*' };
cur_dir=pwd;
data_set_keys=dataMap.keys();
numOfDataset=length(data_set_keys);
drtools={'sammon','bigsammon'};
mcmc=20;
dc_lim=50;%50;
eval_method='fcm';  %'kmeans'
%********************************end of configuration************************************
%***********************************set Sammon configuration*****************************


%***********************************set BigSammon configuration***********************

%*******************************run simulation**********************************************
for ii = 1:numOfDataset,
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
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    param.c=data.cnum;
    %fuzzy c-means clustering 
    param.m=2;
    param.val=1;
    param.vis=0;    
    param.flag=data_set_keys(ii);
    param.res_dir=result_dir;

    ClustName=unique(data.label);  
    
    fn=strcat(result_dir,'\','performance');
    fid=fopen(fn,'w');
    
    for kk=1:length(drtools),
        if strcmp(drtools{kk},'sammon'),
        %*****************sammon from drtoolbox**********
            drname='Sammon';            
            no_dims=2;
            
            temp_elaps=[];
            temp_acc=[];
            for jj=1:mcmc,
                tstart=tic;   %begin counting time;
                mappedA = compute_mapping(data.X, drname, no_dims);
                telapsed=toc(tstart);  
                res=comAcc(mappedA,data,eval_method);
                temp_elaps(jj)=telapsed;
                temp_acc(jj)=res.accuracy;
            end;
            avg_elaps=mean(temp_elaps);
            std_elaps=std(temp_elaps);
            avg_acc=mean(temp_acc);
            std_acc=std(temp_acc);
            content=sprintf('\n*********drname=%s***********\n  average running time (std): %f (%f)  \n, average accuracy (std)=%f(%f) \n',...
                drname,avg_elaps,std_elaps,avg_acc,std_acc);                    
            fwrite(fid,content);
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
            title_content=sprintf('Sammon on %s',param.flag{1});
            title(title_content);
            fig_name4=strcat(result_dir,'\',param.flag,'_sammon_','2dim2');
            saveas(1,fig_name4{1},'png');
            
            content=sprintf('\n*********drname=%s***********\n running time: %f \n, accuracy=%f \n',drname, telapsed,res.accuracy);
%             fn=strcat(result_dir,'\','performance');
%             fid=fopen(fn,'w');
            fwrite(fid,content);
        else if strcmp(drtools{kk},'bigsammon'),
            %*********************bigSammon******************************
                drname='bigsammon';
                
                for tt=1:dc_lim,%50,%12:5:100,                    
                    param.percent=tt; %5 2   
                    avg_elaps=[];
                    std_elaps=[];
                    avg_acc=[];
                    std_acc=[];
                    temp_elaps=[];
                    temp_acc=[];
                    for jj=1:mcmc,   %each dc with 20 simulations
                        mappedA=bigSammon(data,param);
                        telapsed=mappedA.elapsed;
                        res=comAcc(mappedA.proj,data,eval_method);
                        temp_elaps(jj)=telapsed;
                        temp_acc(jj)=res.accuracy;
                    end;
                    avg_elaps(tt)=mean(temp_elaps);
                    std_elaps(tt)=std(temp_elaps);
                    avg_acc(tt)=mean(temp_acc);
                    std_acc(tt)=std(temp_acc);
                    content=sprintf('\n*********drname=%s***********\n  dc=%d, average running time (std): %f (%f)  \n, average accuracy (std)=%f(%f) \n',...
                        drname, param.percent,avg_elaps(tt),std_elaps(tt),avg_acc(tt),std_acc(tt));                    
                    fwrite(fid,content);
                end;
                figure(999);
                plotyy(1:dc_lim,avg_elaps,1:dc_lim,avg_acc);
                grid;
                %title_content=sprintf('BigSammon on %s with different ',flag{1},percent);
                %title(title_content);
                fig_name5=strcat(result_dir,param.flag,'_performance');
                saveas(999,fig_name5{1},'png');
            end;
        end;                 
    end;
end;


