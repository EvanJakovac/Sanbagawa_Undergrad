%Set FileName as string first
%Import the data then do this stuff
[grains,ebsd.grainId,ebsd.mis2mean] = calcGrains(ebsd,'threshold',[2*degree, 10*degree]);
ebsd(grains(grains.grainSize<3))= [];
[grains,ebsd.grainId,ebsd.mis2mean] = calcGrains(ebsd,'threshold',[2*degree, 10*degree]);
grains = smooth(grains,5);

%Remove twins
gB = grains.boundary; 
gB_QzQz = gB('Quartz','Quartz');
cs = ebsd('Quartz').CS; 
h = Miller(0,0,0,1,cs);
twinning = orientation('axis',h,'angle',60*degree,cs,cs); 
isTwinning = angle(gB_QzQz.misorientation,twinning)<5*degree;
twinBoundary = gB_QzQz(isTwinning);
[mergedGrains,grains.prop.parentId] = merge(grains,twinBoundary);
%[mergedGrains,parentId] = merge(grains,twinBoundary); 
grains = mergedGrains; 


cs = loadCIF('quartz');
odf = calcDensity(ebsd('Quartz').orientations,'halfwidth',10*degree);
ori = [xvector,yvector,zvector];
oM2 = ipfHSVKey(cs.Laue);
oM = ipfHSVKey(cs.Laue);
oM.inversePoleFigureDirection = ori;
oM2.inversePoleFigureDirection = ori;

h = [Miller(0,0,0,1,ebsd('Quartz').CS),Miller(1,1,-2,0,ebsd('Quartz').CS)];
MI = calcMIndex(odf); 
o = ebsd('Quartz').orientations;
v = o*Miller(0,0,0,1,cs,'Quartz','uvw');
[x,y,z] = double(v);
OT=1./numel(x)*[x,y,z]'*[x,y,z];
[Vec,Diagonal]=eig(OT);
value=diag(Diagonal);
[value,index]=sort(value,'descend');
vec1(1:3)=Vec(:,index(1));
vec2(1:3)=Vec(:,index(2));
vec3(1:3)=Vec(:,index(3));
NORM=value(1)+value(2)+value(3);
P100=(value(1)-value(2))/NORM;
G100=(2.0*(value(2)-value(3)))/NORM;
R100=(3.0*value(3))/NORM;
%% Maps
figure
plot(ebsd)
nextAxis 
plot(grains)
%% Figures
figure(1)
plot(ebsd,ebsd.prop.bc)
mtexColorMap black2white
hold on
plot(ebsd('Quartz'),ebsd('Quartz').orientations,'FaceAlpha',0.70)
hold on
plot(grains('Quartz').boundary,'linewidth',1.5)
%saveas(gcf,[fileName,'_OriMap.jpg'])

figure(2)
plot(ebsd,ebsd.prop.bc)
mtexColorMap black2white
hold on
plot(ebsd('Quartz'),'FaceAlpha',0.70)
hold on
plot(grains('Quartz').boundary,'linewidth',1.5)
%saveas(gcf,[fileName,'_PhaseMap.jpg'])

% figure
% plotPDF(odf,h,'points',10000,'halfwidth',10*degree,'antipodal','lower','minmax')
% setColorRange('equal');
% mtexColorbar

% figure
% plotIPDF(odf,ori,'halfwidth',10*degree,'minmax')
% setColorRange('equal')
% mtexColorbar

figure(3)
plotPDF(ebsd('Quartz').orientations,h,'contourf','halfwidth',10*degree,'antipodal','lower','minmax'); 
setColorRange('equal');
mtexColorbar
%saveas(gcf,[fileName, '_PF_pixel.jpg'])

figure(4)
plotPDF(grains('Quartz').meanOrientation,h,'contourf','halfwidth',10*degree,'antipodal','lower','minmax'); 
setColorRange('equal');
mtexColorbar
%saveas(gcf,[fileName, '_PF_grain.jpg'])

figure(5)
hold on
plot(oM2,'noLabel','noTitle')
plotIPDF(ebsd('Quartz').orientations,[xvector,yvector,zvector],'contourf','halfwidth',10*degree,'minmax');
setColorRange('equal');
mtexColorbar
%saveas(gcf,[fileName,'_IPF.jpg'])

% %% Misorientations
mori = grains('Quartz').innerBoundary.misorientation;
figure(6)
plot(mori.axis,'fundamentalRegion','contourf','antipodal')
hold on
h = Miller(1,0,-1,0,cs);
plot(h)
nextAxis
plotAxisDistribution(grains.boundary('q','q').misorientation(grains.boundary('q','q').misorientation.angle<=15*degree),'fundamentalregion','contourf','antipodal')
mtexColorbar
%saveas(gcf,[fileName, '_Misori.jpg'])
