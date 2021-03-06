function SpLoader( tlines,handles,file )
%SPLOADER Summary of this function goes here
%   Detailed explanation goes here
[ligne,~]=size(tlines);
sub=0;
subcircuitlist=cell(0,1);
for i=1:ligne
    if ~isempty(tlines{i,1}{1,1})
        if isequal(tlines{i,1}{1,1},'.subckt')
            sub=1;
            subcircuitlist{end+1,1}=tlines{i,1};
        end
        if isequal(tlines{i,1}{1,1},'.ends')
            sub=0;
        end
        if iscell(tlines{i,1})
            if sub==0
                if isequal(tlines{i,1}{1,1}(1),'m')||isequal(tlines{i,1}{1,1}(1),'M')
                    ImportMOSFET(tlines{i,1},handles);
                elseif isequal(tlines{i,1}{1,1}(1),'v')||isequal(tlines{i,1}{1,1}(1),'V')||...
                        isequal(tlines{i,1}{1,1}(1),'i')||isequal(tlines{i,1}{1,1}(1),'I')||...
                        isequal(tlines{i,1}{1,1}(1),'e')||isequal(tlines{i,1}{1,1}(1),'E')||...
                        isequal(tlines{i,1}{1,1}(1),'f')||isequal(tlines{i,1}{1,1}(1),'F')||...
                        isequal(tlines{i,1}{1,1}(1),'g')||isequal(tlines{i,1}{1,1}(1),'G')||...
                        isequal(tlines{i,1}{1,1}(1),'h')||isequal(tlines{i,1}{1,1}(1),'H')
                    ImportSource(tlines{i,1},handles);
                elseif isequal(tlines{i,1}{1,1}(1),'j')||isequal(tlines{i,1}{1,1}(1),'J')
                    ImportJFET(tlines{i,1},handles);
                elseif isequal(tlines{i,1}{1,1}(1),'q')||isequal(tlines{i,1}{1,1}(1),'Q')
                    ImportBipolar(tlines{i,1},handles);
                elseif isequal(tlines{i,1}{1,1}(1),'r')||isequal(tlines{i,1}{1,1}(1),'R')||...
                        isequal(tlines{i,1}{1,1}(1),'l')||isequal(tlines{i,1}{1,1}(1),'L')||...
                        isequal(tlines{i,1}{1,1}(1),'c')||isequal(tlines{i,1}{1,1}(1),'C')||...
                        isequal(tlines{i,1}{1,1}(1),'k')||isequal(tlines{i,1}{1,1}(1),'K')||...
                        isequal(tlines{i,1}{1,1}(1),'d')||isequal(tlines{i,1}{1,1}(1),'D')
                    ImportSimpleElement(tlines{i,1},handles);
                else
                    if isequal(tlines{i,1}{1,1},'.LIB')
                        ImportTechno(tlines{i,1},handles,file);
                    end
                    if ~isequal(tlines{i,1}{1,1}(1),'.')&&...
                            ~isequal(tlines{i,1}{1,1}(1),'+')&&...
                            ~isequal(tlines{i,1}{1,1}(1),'*')
                        ImportSUB(tlines{i,1},handles,subcircuitlist);
                    end
                end
            end
        end
    end
end

