%% Within Subject CI - Masson & Loftus, 1994 (and Nathoo & Masson, 2018)
newtable = [];
newtable(:,1) = [10.73,11.40,10.73,11.40,10.73,11.40,11.73,10.07,10.73,11.07];
newtable(:,2) = [13.73,13.40,13.73,12.40,12.73,13.40,11.73,13.07,13.73,12.07];
newtable(:,3) = [13.73,13.40,13.73,14.40,14.73,13.40,14.73,15.07,13.73,15.07];
newtable(:,4) = [1,2,3,4,5,6,7,8,9,10];

a = vertcat(newtable(:,1), newtable(:,2),newtable(:,3));
overall = mean(a);
digits(4)
overall = vpa(overall);
b = [newtable(:,1), newtable(:,2),newtable(:,3)];
newtable(:,5) = mean(b,2);
newtable(:,6) = (newtable(:,1) - vpa((newtable(:,5)-overall)));
newtable(:,7) = (newtable(:,2) - vpa((newtable(:,5)-overall)));
newtable(:,8) = (newtable(:,3) - vpa((newtable(:,5)-overall)));
%Array
temp_data = array2table(newtable);
temp_data.Properties.VariableNames = {'condi1' 'condi2' 'condi3' 'subjects'...
    'condimean' 'stanmean1' 'stanmean2' 'stanmean3'};
%RM ANOVA
temp_RM = fitrm(temp_data,'stanmean1-stanmean3~1');
temp_RM_vals = ranova(temp_RM);
k = 3;
N = 10;
MSe = table2array(temp_RM_vals(2,3));
WS_CI_old = sqrt(MSe/N)*(tinv(0.975,((k-1)*(N-1)))); %old 

%New method using Nathoo Masson 2018
SSe = table2array(temp_RM_vals(2,1));
WS_CI = sqrt(SSe/(N*(N-1)*k))*(tinv(0.975,((k*(N-1)))));