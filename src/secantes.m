function r = secantes(f, x2, x1, tol)
N = 50; % n.º máx de iterações (pode ser alterado)

close all;

t_pausa = 3;

% calcular a solução exata
[sol,fval,exitflag,output] = fzero(f,x1);
if exitflag == -5
    error('Algoritmo pode ter convergido para um ponto singular!');
end
if exitflag == -6
    error('Não detectada mudança de sinal.');
end


%------------ % Gráfico %------------ %
figure (1); 
grid on; 
hold on;
x = sol-1:0.01:sol+x2;
y = zeros(length(x),1);
%plot da função
plot(x, f(x), 'LineWidth',1.5);
%plot do eixo de xx
plot(x,y,'K', 'LineWidth',1.00);


%------------ % Animação %------------ % 

for n = 2:N
    if x1 == x2
        error('x1 tem de ser diferente de x2');
    end
    
    %plot de f(x1) e f(x2) e da reta que une
    plot(x2, f(x2), 'ro','MarkerFaceColor','r');
    mf2 = text(x2,f(x2), 'f(x_2)');
    plot(x1, f(x1), 'ro','MarkerFaceColor','r');
    mf1 = text(x1,f(x1), 'f(x_1)');
    pause(t_pausa);
    fx2fx1 = plot([x2 x1], [f(x2) f(x1)], 'g--', 'LineWidth',1.00);

    %calculo de x3
    x3 = x2 - ((x2 - x1)/(f(x2) - f(x1))) * f(x2);

    %info
    fprintf("Interação: %i \t Sol:%.6f \t Erro:%.6f\n", n-1, x3,abs(x3-sol));
    
    %plot de x3 e da reta que une f(x1) a x3
    fx1x3 = plot([x1 x3], [f(x1) 0], 'g--', 'LineWidth',1.00);
    plot(x3,0, 'ro','MarkerFaceColor','r');
    m3 = text(x3, 0, 'x_3');
    pause(t_pausa);

    %plot de f(x3)
    plot([x3 x3], [0 f(x3)], 'm--', 'LineWidth',1.00);
    plot(x3, f(x3), 'ro','MarkerFaceColor','r');
    mf3 = text(x3, f(x3), 'f(x_3)');
    pause(t_pausa);
    

    %apagar os tracejados e f(x2) e f(x1)
    delete(fx2fx1);
    delete(fx1x3);
    delete(mf2);
    delete(mf1);
    delete(mf3);
    delete(m3);
    pause(t_pausa/2);

    if abs(x3 - x2) < tol
        r = x3;
        return
    else
        x1 = x2;
        x2 = x3;
    end
end

hold off;