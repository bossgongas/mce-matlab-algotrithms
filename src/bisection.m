function c = bisection(f, a, b, tol)

%------------ % Veficações %------------ %
if f(a)*f(b) > 0
    error('O intervalo não contém nenhuma raiz');
end
% calcular a solução exata
x0 = [a b];
[sol,fval,exitflag,output] = fzero(f,x0);
if exitflag == -5
    error('Algoritmo pode ter convergido para um ponto singular!');
end
if exitflag == -6
    error('Não detectada mudança de sinal.');
end

%------------ % Variaveis %------------ %
kmax = 20;
t_pausa = 1;


%------------ % Gráfico %------------ %
figure (1); 
grid on; 
hold on;
x = a:0.01:b;
y = zeros(length(x),1);
%plot da função
plot(x, f(x), 'LineWidth',1.5);
%plot do eixo de xx
plot(x,y,'K', 'LineWidth',1.00);

%------------ % Animação %------------ % 
for k = 1:kmax
    %plot dos extremos
    h_a = plot(a,0,'ro', 'MarkerFaceColor', 'r', 'MarkerSize', 5);
    m_a = text(a,0,'a');
    h_b = plot(b,0,'ro', 'MarkerFaceColor', 'r', 'MarkerSize', 5);
    m_b = text(b,0,'b');

    % ponto médio
    c = (a+b)/2; 
    h_c = plot(c,0,'go', 'MarkerFaceColor', 'g', 'MarkerSize', 5);
    m_c = text(c,0,'c');

    %info
    fprintf("Interação: %i \t Sol:%.6f \t Erro:%.6f\n", k-1, c,abs(c-sol));

    pause(t_pausa);

    % apagar frame
    delete(h_a);
    delete(h_b);
    delete(h_c);
    delete(m_a);
    delete(m_b);
    delete(m_c);
    
    % Pára se houver uma raíz
    if f(c) == 0 
        return
    end
    
    % Valor abaixo da tolerância
    if (b-a)/2 < tol 
        return
    end
    
    % Verifica mudança de sinal
    if f(b)*f(c) > 0 
        b = c; % Ajusta o limite do intervalo
    else 
        a = c;
    end

end

hold off;
