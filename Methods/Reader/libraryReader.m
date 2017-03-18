function [output_args,v] = libraryReader( input_args )
% fid=fopen(input_args);
% tlines=cell(0,1);
% tline = fgetl(fid);
% t=cell(0,1);
% u=cell(0,1);
% while ischar(tline)
%     tlines{end+1,1} = tline;
%     tlines{end,1}=strsplit(tlines{end,1});
%     if iscell(tlines{end,1})
%         [~,a]=size(tlines{end,1});
%         for i=1:a
%             if isequal(tlines{end,1}{1,i},'.LIB')
%                t{end+1,1}=tlines{end,1}{1,i+1};
%                u{end+1,1}=1;
%                j=1;
%             end
%             if ~isempty(strfind(tlines{end,1}{1,i},'.MODEL'))
%                u{end,j}=tlines{end,1}{1,i+1};
%                j=j+1;
%             end
%         end
%     end
%     tline = fgetl(fid);
% end
% fclose(fid);
% output_args=t;
% v=u;

fid=fopen(input_args);
tlines=cell(0,1);
tline = fgetl(fid);
t=cell(0,1);
u=cell(0,1);
include=0;
file_mld='';
while ischar(tline)
    tlines{end+1,1} = tline;
    tlines{end,1}=strsplit(tlines{end,1});
    if iscell(tlines{end,1})
        [~,a]=size(tlines{end,1});
        for i=1:a
            if isequal(tlines{end,1}{1,i},'.LIB')
               t{end+1,1}=tlines{end,1}{1,i+1};
               u{end+1,1}=1;
               j=1;
            end
            if ~isempty(strfind(tlines{end,1}{1,i},'.MODEL'))
               u{end,j}=tlines{end,1}{1,i+1};
               j=j+1;
            end
            if ~isempty(strfind(tlines{end,1}{1,i},'.include'))
                include=1;
                file_mld=tlines{end,1}{1,i+1};
            end
        end
    end
    tline = fgetl(fid);
end
fclose(fid);
if include==1
    if file_mld(2)=='.'
        display(true);
        path2=strsplit(input_args,'\');
        path2=path2(1:end-1);
        path2{1,end+1}=file_mld(4:end-1);
        [~,a]=size(path2);
        %Parallels desktop user
        path3=['\',path2{1,1}];
        %Windows user
        %path3=path2{1,1};
        for i=2:a
            path3=[path3,'\',path2{1,i}];
        end
        file_mld=path3;
    end
    fid=fopen(file_mld);
    tlines2=cell(0,1);
    list=cell(1,0);
    tline = fgetl(fid);
    while ischar(tline)
        tlines2{end+1,1} = tline;
        tlines2{end,1}=strsplit(tlines2{end,1});
        if iscell(tlines2{end,1})
            [~,a]=size(tlines2{end,1});
            for i=1:a
                if ~isempty(strfind(tlines2{end,1}{1,i},'.model'))
                    list{1,end+1}=tlines2{end,1}{1,i+1};
                end
            end
        end
        tline = fgetl(fid);
    end
    fclose(fid);
    [b,~]=size(t);
    [~,c]=size(list);
    u=cell(b,c);
    for i=1:b
        for j=1:c
            u{i,j}=list{1,j};
        end
    end
end
output_args=t;
v=u;
end

