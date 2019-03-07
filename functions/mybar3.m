%xdata :x������ֵ ��: xdata ={'����', '����', '����', '������'};
%xl    :x���ǩ������beta

%ydata :y������ֵ ��: zdata ={'�ϸ���','��Ʒ��','��Ʒ��'};
%yl    :y���ǩ������alpha

%zdata :z�����ݣ���һ������,�����СΪ��size(xdata,2),size(ydata2)��  ����rand(3, 4);
%zl    :z���ǩ������AUC

function mybar3(xdata,xl,ydata,yl,zdata,zl,AX,EL)
    % ��Ҫ���������3ά��״ͼ��
    % ��򵥵�д�����£�
    hb = bar3(zdata);
    % renderCDataByHeight(hb, false);
    %colorbar;
    set(gca, 'xticklabel', xdata);
    set(gca, 'yticklabel', ydata);
    view([AX, EL])
    %���ֱ�ע
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
    x = xlabel(xl);        %x�����
    y = ylabel(yl);        %y�����
    zlabel(zl);        %z�����
    
     %set(x1,'Rotation',30);    %x��������ת
     %set(x2,'Rotation',-30);    %y��������ת

    %colormap spring;
end

function renderCDataByHeight(hb, interp)
% hbΪbar3���ص���ά��״ͼ���,
% ��hb�ĸ����Ӱ��߶���ȾCData���ԣ�
% interpָ���Ƿ񽥱�(Ĭ��Ϊfalse)
% interp==true:ÿ�����Ӵ��µ�����ɫ����
% interp==false:ÿ������һ����ɫ
% hb�о������������������,hb(j)Ϊ��j�����ݵľ��
if nargin == 1
    % interpĬ��ֵ
    interp=false;
end
if interp == true
    %ÿ�����Ӵ��µ�����ɫ����
    shading interp;
    for j = 1 : length(hb)
        % ��Zdata����ȥ���Cdata����
        zdata = get(hb(j), 'Zdata');
        set(hb(j), 'Cdata', zdata);
        % ���ñ�����ɫ
        set(hb, 'EdgeColor', [0.5 0.5 0.5]);
    end
else
    % ÿ������һ����ɫ
    for j = 1:length(hb)
        % ����hb(j)��Cdata����
        % ����CData��ֵcdata�����滻���ֵ
        % cdata����ZData�Ļ������޸Ķ���
        cdata = get(hb(j), 'ZData');
        % cdata��������6������������
        m = size(cdata,1)/6;
        % ���cdata
        for i = 1:m
            % ����cdata��(i,j)���ݶ�Ӧ��6��
            % ����6�е�ֵ�����(i,j)���ݵ�ֵ
            vij = cdata((i-1)*6+2,2);%����cdata(ZData)�л��(i,j)���ݵ�ֵ
            cdata((i-1)*6+1:(i-1)*6+6,:) = vij;%(i,j)���ݶ�Ӧ��6��������
        end
        set(hb(j), 'Cdata', cdata);%��cdata����Cdata����
    end
end
end