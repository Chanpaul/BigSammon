function result = comAcc(mappedA,data,cluster_method)
    [ND,na]=size(data.X);
    ClustName=unique(data.label);
    if strcmp(cluster_method,'kmeans'),
        idx=kmeans(mappedA,data.cnum);
    else if strcmp(cluster_method,'fcm'),
        X.X=mappedA;
        fcm_param.c=data.cnum;
        fcm_res=FCMclust(X,fcm_param);        
        [mv,idx]=max(fcm_res.data.f,[],2);        
        end;
    end;
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
    result.accuracy=accuracy;
    result.true_label=true_labels;
    result.CM=CM;
    result.corLabel=corLabel;
end