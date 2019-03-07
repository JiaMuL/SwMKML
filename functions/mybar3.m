%xdata :x轴坐标值 例: xdata ={'张三', '李四', '王二', '胡汉三'};
%xl    :x轴标签，例：beta

%ydata :y轴坐标值 例: zdata ={'合格率','次品率','废品率'};
%yl    :y轴标签，例：alpha

%zdata :z轴数据，是一个矩阵,矩阵大小为（size(xdata,2),size(ydata2)）  例：rand(3, 4);
%zl    :z轴标签，例：AUC

function mybar3(xdata,xl,ydata,yl,zdata,zl,AX,EL)
    % 现要画出其分组3维柱状图。
    % 最简单的写法如下：
    hb = bar3(zdata);
    % renderCDataByHeight(hb, false);
    %colorbar;
    set(gca, 'xticklabel', xdata);
    set(gca, 'yticklabel', ydata);
    view([AX, EL])
    %文字标注
    digits(2);


    for i = 1:size(zdata,1)
        for j = 1:size(zdata,2)
            value = num2str(zdata(i,j));
            text(j, i, zdata(i,j)+0.005, value(1:4));%0.005
        end
    end
    %pause(1);
    %renderCDataByHeight(hb, true);
    axis([0, size(xdata,2)+1, 0, size(ydata,2)+1, 0.6, max(max(zdata))]);%min(min(zdata)), max(max(zdata))
    %pause(1);
    % renderCDataByHeight(hb, true);
    x = xlabel(xl);        %x轴标题
    y = ylabel(yl);        %y轴标题
    zlabel(zl);        %z轴标题
    
     %set(x1,'Rotation',30);    %x轴名称旋转
     %set(x2,'Rotation',-30);    %y轴名称旋转

    %colormap spring;
end

function renderCDataByHeight(hb, interp)
% hb为bar3返回的三维柱状图句柄,
% 对hb的各柱子按高度渲染CData属性，
% interp指定是否渐变(默认为false)
% interp==true:每个柱子从下到上颜色渐变
% interp==false:每个柱子一种颜色
% hb中句柄个数等于数据列数,hb(j)为第j列数据的句柄
if nargin == 1
    % interp默认值
    interp=false;
end
if interp == true
    %每个柱子从下到上颜色渐变
    shading interp;
    for j = 1 : length(hb)
        % 用Zdata属性去填充Cdata属性
        zdata = get(hb(j), 'Zdata');
        set(hb(j), 'Cdata', zdata);
        % 设置边线颜色
        set(hb, 'EdgeColor', [0.5 0.5 0.5]);
    end
else
    % 每个柱子一种颜色
    for j = 1:length(hb)
        % 设置hb(j)的Cdata属性
        % 制作CData新值cdata用以替换其旧值
        % cdata将在ZData的基础上修改而成
        cdata = get(hb(j), 'ZData');
        % cdata行数除以6就是数据行数
        m = size(cdata,1)/6;
        % 填充cdata
        for i = 1:m
            % 设置cdata中(i,j)数据对应的6行
            % 将这6行的值均填充(i,j)数据的值
            vij = cdata((i-1)*6+2,2);%可由cdata(ZData)中获得(i,j)数据的值
            cdata((i-1)*6+1:(i-1)*6+6,:) = vij;%(i,j)数据对应的6行填充完毕
        end
        set(hb(j), 'Cdata', cdata);%将cdata赋给Cdata属性
    end
end
end