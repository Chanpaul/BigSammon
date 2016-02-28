function result = data_sep(dist,dc)

%determine the parameters in inilization with optimizational methods.
ND=size(dist,1);
% fprintf('Computing Rho with gaussian kernel of radius: %12.6f\n', dc);
rho=zeros(1,ND);
delta=zeros(1,ND);
nneigh=zeros(1,ND);
isBorder=ones(1,ND);    % the border points are not directed neighbors of any points.    
initCenterAt=zeros(1,ND);
finalCenterAt=[];
% dp=[];
% dp(ND).dirNeigh=[];
% dp(ND).dcNeigh=[];

% for i=1:ND
%   rho(i)=0.;
% end
%
% Gaussian kernel
%

for i=1:ND-1    
  for j=i+1:ND
     rho(i)=rho(i)+exp(-(dist(i,j)/dc)*(dist(i,j)/dc))+1e-8;
     rho(j)=rho(j)+exp(-(dist(i,j)/dc)*(dist(i,j)/dc))+1e-8;     
  end 
end
%
% "Cut off" kernel
%
% for i=1:ND-1
%  for j=i+1:ND
%    if (dist(i,j)<dc)
%       rho(i)=rho(i)+1.;
%       rho(j)=rho(j)+1.;
%    end
%  end
% end

maxd=max(max(dist));

[rho_sorted,ordrho]=sort(rho,'descend');
delta(ordrho(1))=-1.;
nneigh(ordrho(1))=0;
initCenterAt(ordrho(1))=ordrho(1);
potClustRt=[ordrho(1)];
%dclMx=zeros(ND,ND);  %indicating the relationship of data point and the cluster.
%dclMx(ordrho(1),ordrho(1))=1;
%dcl(ordrho(1))=ordrho(1); 
% dclMx=sparse(zeros(ND,ND));
% dclMx(ordrho(1),ordrho(1))=1;

for ii=2:ND
   delta(ordrho(ii))=maxd;
   for jj=1:ii-1
     if(dist(ordrho(ii),ordrho(jj))<delta(ordrho(ii)))
        delta(ordrho(ii))=dist(ordrho(ii),ordrho(jj));
        nneigh(ordrho(ii))=ordrho(jj);          
     end
   end   
   isBorder(nneigh(ordrho(ii)))=0;
   if dist(nneigh(ordrho(ii)),ordrho(ii))>dc,
       potClustRt=[potClustRt,ordrho(ii)]; 
       initCenterAt(ordrho(ii))=ordrho(ii);
   else
       initCenterAt(ordrho(ii))=initCenterAt(nneigh(ordrho(ii)));
   end;
end
delta(ordrho(1))=max(delta(:));
%plot(delta,rho,'o');
%*******************For BSN 2015******************************
gama=(delta/max(delta)).*(rho/max(rho));
% [sorted_clustCent_delta,ordinx]=sort(delta(potClustRt),'descend');
[sorted_clustCent_delta,ordinx]=sort(gama(potClustRt),'descend');
fClustRt=potClustRt(ordinx);
finalCenterAt=initCenterAt;

%**************************END********************

% %*************1ST method to compute initial centroids*****************
% rhoth=rho(ordrho(1))/7;   %7   10
% deltath=delta(ordrho(1))/7;   %7   10
% clustSeq=[ordrho(1)];
% distDg=[];
% for i=1:ND,
%   if ( (rho(i)>rhoth) && (delta(i)>deltath))
%       if i~=ordrho(1),          
%           clustSeq(end+1)=i;
%           distDg(end+1)=sqrt((rho(i)-rho(ordrho(1)))^2+(delta(i)-delta(ordrho(1)))^2);
%       end;     
%   end;
% end;
% 
% [sorted_clustCent_delta,ordinx]=sort(delta(clustSeq),'descend');
% sortedClustSeq1=[];
% for j=1:size(clustSeq,2),
%     sortedClustSeq1(j)=clustSeq(ordinx(j));
% end;
% fClustRt=clustSeq(ordinx);
% finalCenterAt=initCenterAt;
% %****************************end*************************************
% %************2nd method to compute initial centroids*****************
% [rhoValue,oriIndex]=sort(rho(potClustRt),'descend');
% numOfPotClustRt=size(potClustRt,2);
% potClustRt=potClustRt(oriIndex);
% densityReachable=zeros(numOfPotClustRt,numOfPotClustRt); 
% for tt=1:ND,
%     dcNeigh=find(dist(tt,:)<dc,2);
%     notInTheSame=find(initCenterAt(dcNeigh)~=initCenterAt(tt),2);
%     if ~isempty(notInTheSame),        
%         c1=find(potClustRt==initCenterAt(tt),2);
%         for jj=1:size(notInTheSame,2),
%             tp=dcNeigh(notInTheSame(jj));
%             c2=find(potClustRt==initCenterAt(tp),2);
%             densityReachable(c1,c2)=max(densityReachable(c1,c2),max(rho(tt),rho(tp)));
%             densityReachable(c2,c1)= densityReachable(c1,c2);            
%         end;
%     end;
% end;
% 
% 
% centerAt=initCenterAt;
% borderDensityTh=unique(densityReachable(:));
% 
% criteriaTh=1000000000000;
% for ii=1:size(borderDensityTh',2),
%     tempRts=[];
%     for ss=1:numOfPotClustRt,        
%         temp=find(densityReachable(ss,:)>borderDensityTh(ii),2);
%         if ~isempty(temp),
%             centerAt(potClustRt(temp))=centerAt(potClustRt(ss));            
%         end;
%     end;
%     for ss=1:ND,
%         centerAt(ss)=centerAt(initCenterAt(ss));
%     end;
%     tClustCenter=unique(centerAt);
%     tc=size(tClustCenter,2);
%     evalCriteria=sum(delta./rho)-sum(delta(tClustCenter)./rho(tClustCenter));
%     evalCriteria=evalCriteria/(tc*min(delta(tClustCenter)));
%     if evalCriteria<criteriaTh,
%         finalCenterAt=centerAt;
%     end;
%     criteriaTh=evalCriteria;
% %     tempRts=unique(centerAt(potClustRt));
% %     localDensityTh=unique(rho(tempRts));
% %     [t_value,ordIndex1]=sort(rho(tempRts),'descend');
% %     for tt=1:size(localDensityTh,2),
% %         for jj=1:size(tempRts,2),
% %             curClustRt=tempRts(ordIndex1(jj));
% %             if rho(curClustRt)< localDensityTh(tt),
% %                 centerAt(curClustRt)=centerAt(nneigh(curClustRt));
% %             end;
% %         end;
% %         for ss=1:ND,
% %             centerAt(ss)=centerAt(initCenterAt(ss));
% %         end;
% %         tClustCenter=unique(centerAt);
% %         tc=size(tClustCenter,2);
% %         evalCriteria=sum(delta./rho)-sum(delta(tClustCenter)./rho(tClustCenter));
% %         evalCriteria=evalCriteria/(tc*min(delta(tClustCenter)));
% %         if evalCriteria<criteriaTh,
% %             finalCenterAt=centerAt;
% %         end;
% %         criteriaTh=evalCriteria;
% %     end;       
%     
% end;
% tSeq1=unique(finalCenterAt);
% [v,tSeq]=sort(rho(tSeq1),'descend');
% fClustRt=tSeq1(tSeq);
% %**************************End****************************************

%***************3rd method to find the initial clustering centers****************
% fClustRt=[];  %final clustering centers;
% 
% fdclMx=dclMx;  %final clustering relations;
% [sortedRtDelta,origInd]=sort(delta(potClustRt),'descend');
% pclustRt=potClustRt(origInd);
% potClustSz=size(potClustRt,2);
% xbv1=-1*ones(1,potClustSz);
% minXbv1=100000000;
% 
% for i=1:potClustSz-1,
%     tempClust=potClustRt(origInd(1:potClustSz-i));
%     tempRt=potClustRt(origInd(potClustSz-i+1));
%     dclMx(:,nneigh(tempRt))=dclMx(:,nneigh(tempRt))+dclMx(:,tempRt);
%     dclMx(:,tempRt)=0;    
%     minDelta=sortedRtDelta(potClustSz-i);  
%     tempRes=(dist.*dclMx).^2;
%     tempXBv1=full(sum(tempRes(:)))/(ND*minDelta);
%     xbv1(potClustSz-i)=tempXBv1;
%     if tempXBv1<minXbv1,
%         minXbv1=tempXBv1;
%         fClustRt=tempClust;
%         fdclMx=dclMx;
%     end;
%     
% end;
    
%*********************************The end********************************
% result.cl=cl;
result.rho=rho;
result.delta=delta;
%result.dclMx=fdclMx;   %dclMx(i,j)=1 means that the ith data belongs to the cluster centered at jth data
result.clustRt=fClustRt;
%result.pclustRt=pclustRt;
result.centerAt=finalCenterAt;

result.nneigh=nneigh;
result.rho_sorted=rho_sorted;
result.ordrho=ordrho;


end




