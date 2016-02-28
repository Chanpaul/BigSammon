function result = comAcc(mappedA,data)
[ND,na]=size(data.X);
    ClustName=unique(data.label);
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
    result.accuracy=accuracy;
    result.true_label=true_labels;
    result.CM=CM
    result.corLabel=corLabel;
end