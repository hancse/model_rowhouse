

 % Exchange_NEN5060_3.m
 %
 % Exchange of NEN5060 data in climate files for Matlab/ Simulink
 %
 % Exchange of NEN5060_2008 data in Excel format to a mat-file with irradiation
 % for irradiation on S, SW, W, NW, N, NE, E, SE and horizontal
 % and Toutdoor
 % Irradiation can be used for solar irradiation on windows
% version September 17th 2018
 % by Arie Taal THUAS (The Hague University of Applied Sciences)

 rground=0; % ground reflection is ignored
for k=1:4

 if k==1
 [NUM,TXT,RAW]=xlsread('NEN5060-2018.xlsx',1); % this file is part of NEN 5060 20018
 elseif k==2
 [NUM,TXT,RAW]=xlsread('NEN5060-2018.xlsx',2);
 elseif k==3
 [NUM,TXT,RAW]=xlsread('NEN5060-2018.xlsx',3);
 end

 t=((1:8760)'-1)*3600;
 dom=NUM(:,3); % day of month
 hod=NUM(:,4); % hour of day
 qglob_hor=NUM(:,5);
 qdiff_hor=NUM(:,6);
 qdir_hor=NUM(:,7);
 qdir_nor=NUM(:,8);
 Toutdoor=NUM(:,9)/10;
 phioutdoor=NUM(:,10);
 xoutdoor=NUM(:,11)/10;
 pdamp=NUM(:,12);
 vwind=NUM(:,13)/10; % at 10 m height
 dirwind=NUM(:,14);
 cloud=NUM(:,15)/10;
 rain=NUM(:,16)/10;

 for j=1:9
 if j<9
 gamma=45*(j-1);
 beta=90;
 else
 gamma=90;
 beta=0;
 end
 for i=1:8760
 E(i,j)=qsun(t(i),qdiff_hor(i),qdir_nor(i),gamma,beta,rground); 
 end
 end
 qsunS=horzcat(t,E(:,1));
 qsunSW=horzcat(t,E(:,2));
 qsunW=horzcat(t,E(:,3));
 qsunNW=horzcat(t,E(:,4));
 qsunN=horzcat(t,E(:,5));
 qsunNE=horzcat(t,E(:,6));
 qsunE=horzcat(t,E(:,7));
 qsunSE=horzcat(t,E(:,8));
 qsunhor=horzcat(t,E(:,9));
 Tout=horzcat(t,Toutdoor);
 phiout=horzcat(t,phioutdoor);
 xout=horzcat(t,xoutdoor);
 pout=horzcat(t,pdamp);
 vout=horzcat(t,vwind);
 dirvout=horzcat(t,dirwind);
 cloudout=horzcat(t,cloud);
 rainout=horzcat(t,rain);

 if k==1
 save NEN5060_B2_1 t Tout qsunS qsunSW qsunW qsunNW qsunN qsunNE qsunE qsunSE ...
 qsunhor Tout phiout xout pout vout dirvout cloudout rainout
 elseif k==2
 save NEN5060_B2_2 t Tout qsunS qsunSW qsunW qsunNW qsunN qsunNE qsunE qsunSE ...
 qsunhor Tout phiout xout pout vout dirvout cloudout rainout
 elseif k==3
 save NEN5060_B2_3 t Tout qsunS qsunSW qsunW qsunNW qsunN qsunNE qsunE qsunSE ...
 qsunhor Tout phiout xout pout vout dirvout cloudout rainout
 end
 end


