function result = clean(dataset,sep_sympol,fid,lid)  %fid feature index, lid label id
[N,n]=size(dataset);
n=max(N,n);
X=zeros(n,length(fid));
label={};
for ii=1:n,    
    temp=strsplit(dataset{ii},sep_sympol);
    for jj=1:length(fid),
        X(ii,jj)=str2double(temp{jj});
    end;
    label{ii}=temp{jj+1};
end;
result.X=X;
result.label=label;
