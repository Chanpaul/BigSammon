function result = ESamv1(proj,data, result,param)
%rand('seed',120)
D=data.X;
paramdag.percent=2;
dagInfo = DAGInit(D,paramdag);
frt=dagInfo.clustRt;
nneigh=dagInfo.nneigh;
d=dagInfo.delta;
rho=dagInfo.rho;
rho=rho.^2;
% rho=1./(1+exp(-1*rho));
gama=(rho./max(rho)).*(d./max(d));
[rho_sorted,ordrho]=sort(rho,'descend');

%Adapt the data
P = proj.P;             %P projected data or dimension
m = param.m;            %m fuzzy exponent
maxstep = param.max;
alpha = param.alpha;
% compute data dimensions
orig_si = size(D); 
dim = orig_si(2); 
noc = orig_si(1);
np=noc;
% compute data dimensions
% [np,nc]=size(d);        %number of data and number of clusters
% orig_si = size(d); 
% noc = orig_si(1); 
% nc = orig_si(2); %
param.q=2;
pcaresult = PCA(data,param,result);

if prod(size(P))==1,    %output dimension given
  odim = P; 
  P = rand(np,odim)-0.5;
  %P = 2*rand(np,odim)-1; 
else                    %initial projection matrix given
  si = size(P);
  odim = si(end);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

np_x_1  = ones(np, 1); 
% nc_x_1  = ones(nc, 1); 
odim_x_1 = ones(odim,1); 
% xu = zeros(np, odim);       %projected data matrix
% xd = zeros(np, odim);       %projected distance matrix
% dq = zeros(np, 1);
% dr = zeros(np, 1);
%alpha = 0.4;                %gradient method step size

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
tic
fprintf(2, 'iterating                    \r');

% % initializing 
x  = P ;
% xv=x(refPt,:);
% 
% % fm = f.^m;
% % sumf = sum(fm);
% % xv = (fm'*x)./(sumf'*ones(1,2));;   %projected cluster centers
% 
c = sum(x) / np;% move the center of mass to the center
x = x - c(np_x_1, :);
% xv = xv - c(nc_x_1, :); 
xu=zeros(np,odim);
for i=1:maxstep;
  for k = 2:np,
      j=ordrho(k);
    xd      = - x(nneigh(j),:) + x(j,:);
    xd2     = xd.^2+1e-6;
    dpj     = sqrt(sum(xd2));
    dq      = d(j) - dpj;   
    dr      =  dpj+1e-6;    
    term    = rho(j)*dq/dr;
    e1      = xd*term+1e-6;
    term2   = rho(j)*d(j)/dpj^3;
%     term2   = ((1.0 + dq/dpj) / dpj) ./ dr;
    e2      = term - xd2 .* term2+1e-6;
    xu(j,:) = x(j,:) + alpha * e1 ./ abs(e2);
  end
  xu(ordrho(1),:)=x(ordrho(1),:);
  x=xu;
  c = mean(x);
  x = x - c(np_x_1, :);
 
  if 1, 
    clf
    plot(x(:,1), x(:,2), 'o');
    hold on
%     plot(xv(:,1), xv(:,2), 'r*');
    %projeval(x,xv,m,nc,fm);
    hold off
    title('Fuzzy Sammon mapping - training')
    drawnow
  end
  fprintf(2, '\r%d iterations', i);
end   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
disp('Press any key.')
pause
xv=x(frt,:);
% reshape
orig_si(end) = odim; 
P = reshape(x, orig_si);

%results
result.proj.vp=xv;
result.proj.P=x;
param.rho=rho;
Eprojeval(result,param)

