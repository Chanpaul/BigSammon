%function perf =projeval(x,v,m,c,f)
function perf = Eprojeval(result,param)
%projeval(result.PCAproj.P,result.PCAproj.vp,param.m,param.c,result.data.f);
x = result.proj.P;
v = result.proj.vp;
m = param.m;
c = param.c;
f = result.data.f;
rho=param.rho;
%colormap(hot(256));
colorbar('Ticks',[-5,-2,1,4,7],...
         'TickLabels',{'Cold','Cool','Neutral','Warm','Hot'})
scatter(x(:,1),x(:,2),rho.^2,round(rho.^2),'filled');
% scatter3(x(:,1),x(:,2),rho',[],round(rho.^2));
colorbar
hold on
%calculation of the membership
 for j = 1 : c,                        % for all clusters
    xv = x - ones(length(x),1)*v(j,:);
    d(:,j) = sum((xv*eye(2).*xv),2);
 end;
 d = (d+1e-10).^(-1/(m-1));
 f0 = (d ./ (sum(d,2)*ones(1,c)));
 ff=f0;
 
 perf=[mean(sqrt((ff(:)-f(:)).^2)) sum(mean(f.*f)) sum(mean(ff.*ff))];

 dens=fit(x,rho','poly23');
%[X,Y] = meshgrid(-4:.1:4, -4:.1:4);
lower1=min(x(:,1));upper1=max(x(:,1));scale1=(upper1-lower1)/200;
    lower2=min(x(:,2));upper2=max(x(:,2));scale2=(upper2-lower2)/200;
    [X,Y] = meshgrid(lower1:scale1:upper1, lower2:scale2:upper2);
x=[X(:) Y(:)];
d=[];
%calculation of the membership
%  for j = 1 : c,                        % for all clusters
%     xv = x - ones(length(x),1)*v(j,:);
%     d(:,j) = sum((xv*eye(2).*xv),2);
%  end;
%  d = (d+1e-10).^(-1/(m-1));
%  f0 = (d ./ (sum(d,2)*ones(1,c)));
%  ff=f0;
%  f=max(ff')';
f=dens(x(:,1),x(:,2));
F= reshape(f,size(X,1),size(X,2));
hold on
% contour(X,Y,F);

 
