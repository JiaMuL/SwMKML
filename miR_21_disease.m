load('output/case_study.mat');
F = predRes';
nm = size(F,2);%550

%fid = fopen('./datasets/diseaseNames.txt');
%data = textscan(fid,'%s',328);
%fclose(fid);
dNames = textread('datasets/diseaseNames.txt', '%s', 'delimiter', '');
mNames = textread('datasets/miRNANames.txt', '%s', 'delimiter', '');
pan = [28,5,33,11,7,69,45,22,9,10,27,121,86,94,72,188,215,128,64,55,1];
len = size(pan,2);%21
store = {};
v = 1;
for i = pan
    if (v == 22)
            break;
    end
    store{1,v} = F(i,:);
    v = v + 1;
end

for j = 1:len
    scores = store{1,j};
    u = unique(scores);
    sort_s = sort(u, 'descend');
    filename = strcat('output/case_study/', dNames{pan(1,j),1}, '.txt');
    fp = fopen(filename,'w');
    sum = 0;
    for i =1:size(sort_s,2) 
       for t =1:nm
          if sort_s(1,i) == scores(1,t)
             sum = sum + 1;
             fprintf(fp, '%s\n', mNames{t,1});
          % if sum == 51
             %    continue;
           %end
          end
       end
    end
    fclose(fp);
    str = sprintf('Current is : %d',j);
    disp(str);
end    
