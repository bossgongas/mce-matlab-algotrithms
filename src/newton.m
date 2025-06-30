function r = newton(f, x1, tol)

close all;

% calcular a solução exata
[sol,fval,exitflag,output] = fzero(f,x1);
if exitflag == -5
    error('Algoritmo pode ter convergido para um ponto singular!');
end
if exitflag == -6
    error('Não detectada mudança de sinal.');
end

% Converte a função anónima em expressão simbólica, calcula a derivada, e
% converte o resultado numa nova função anónima
y = sym(f);
fp = matlabFunction(diff(y));%derivada

t_pausa = 2;

%grafico
figure (1);
grid on;
hold on;
x = -x1:0.01:x1;
y = zeros(length(x),1);
%plot da função
plot(x, f(x), 'LineWidth',1.5);
%plot do eixo x
plot(x,y,'K', 'LineWidth',1.00);
set(gca, 'Xlim', [sol-x1 sol+x1], 'Ylim', [0 f(x1)])% definição do eixos


for n = 1:50
    set(gca, 'Xlim', [sol-x1 sol+x1], 'Ylim', [0 f(x1)])% definição do eixos
    %plot de f(x1)
    plot(x1, f(x1), 'bo','MarkerEdgeColor','b');
    mf1 = text(x1,f(x1), 'f(x_1)');
    plot(x1, 0 , 'bo','MarkerEdgeColor','b'); %ponto incial
    m1 = text(x1,0,'x_1');
    plot([x1 x1], [0 f(x1)], '-r');%reta que une x1 e f(x1)
    %pause
    pause(t_pausa);

    if fp(x1) == 0
        error('x1 é mín/máx local');
    end

    x2 = x1 - f(x1)/fp(x1);
    m2 = text(x2, 0, 'x_2');
    %plot de reta que une x2 e f(x1)
    plot([x1 x2], [f(x1) 0], '--r');
    %info
    fprintf("Interação: %i \t Sol:%.6f \t Erro:%.6f\n", n-1, x2,abs(x2-sol));
    %pause
    pause(t_pausa);

    delete(mf1);
    delete(m1);
    delete(m2);

    %verif a solucao
    if abs(x2 - x1) < tol
        r = x2;
        return
    else
        x1 = x2;
    end

end

hold off;