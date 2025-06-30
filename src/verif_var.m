function [r] = verif_var(v)
%Funcao que verfica se a variavel independente é x
r = 0;

for i=1:length(v)
    if v(i) == 'x'
        r = 1;
    end
end

end


