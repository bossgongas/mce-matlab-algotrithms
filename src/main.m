%Main
clear;
clc;
close all;

sym x;
out_flag = 0;

while out_flag == 0
    clc;

    menu();
    opcao = input('Opção: ', 's');

    %verificacao
    while(opcao ~= '1' && opcao ~='2' && opcao ~='3' && opcao ~='s')
        warning('Escolha uma das opções');
        menu();
        opcao = input('Opção: ', 's');
    end

    clc;%clear prompt

    switch opcao
        case '1'
            %pedir equacao
            f1 = input('Equação(em x): ', 's');

            %verficar que a v.ind é x
            aux = verif_var(f1);
            while(aux == 0)
                warning('Variavel independente tem de ser x');
                f1 = input('Equação(em x): ', 's');
                %verficar que a v.ind é x
                aux = verif_var(f1);
            end

            %passar de string para symbolica
            f1 = str2sym(f1);
            %passar para anonima
            f = matlabFunction(f1);


            %pedir intervalo com verif
            a = input('Limite Inferior: ');
            b = input('Limite Superior: ');
            while(a>b)
                a = input('Limite Inferior: ');
                b = input('Limite Superior: ');
            end

            %pedir tolerancia %tol = 1e-4
            tol = input('Tolerancia da solução: ');
            while tol < 0 || tol > 1
                tol = input('Tolerancia da solução: ') ;
            end

            %iniciar a animacao
            c = bisection(f,a,b,tol);
            fprintf("Solução: x = %.6f\n", c);
            pause(5);

        case '2'
            %pedir equacao
            f1 = input('Equação(em x): ', 's');
            %verficar que a v.ind é x
            aux = verif_var(f1);
            while(aux == 0)
                warning('Variavel independente tem de ser x');
                f1 = input('Equação(em x): ', 's');
                %verficar que a v.ind é x
                aux = verif_var(f1);
            end
            %passar de string para symbolica
            f1 = str2sym(f1);
            %passar para anonima
            f = matlabFunction(f1);

            %ponto de partida
            xi = input('Ponto de partida: ');
            sol = fzero(f,xi);

            %verif do ponto inicial escolhido
            in_flag = 0;
            while abs(xi - sol) > 5 && in_flag == 0
                warning('Atenção! Ponto muito afastado da solução. Algoritmo pode falhar');
                in_flag = input('Prentende continuar? [0 ou 1] : ');
                if in_flag == 0
                    xi = input('Ponto de partida: ');
                end
            end

            %pedir tolerancia tol = 1e-4
            tol = input('Tolerancia da solução: ');
            while tol < 0 || tol > 1
                tol = input('Tolerancia da solução: ') ;
            end

            %inciar animação
            r = newton(f, xi,tol);
            fprintf("Solução: x = %.6f\n", r);
            pause(5);
        case '3'
            %pedir equacao
            f1 = input('Equação(em x): ', 's');
            %verficar que a v.ind é x
            aux = verif_var(f1);
            while(aux == 0)
                warning('Variavel independente tem de ser x');
                f1 = input('Equação(em x): ', 's');
                %verficar que a v.ind é x
                aux = verif_var(f1);
            end
            %passar de string para symbolica
            f1 = str2sym(f1);
            %passar para anonima
            f = matlabFunction(f1);

            %pedir intervalo
            a = input('Valor inicial 1: ');
            b = input('Valor inicial 2: ');

            %pedir tolerancia
            tol = input('Tolerancia da solução: ');
            while tol < 0 || tol > 1
                tol = input('Tolerancia da solução: ') ;
            end

            %iniciar a animacao
            c = secantes(f,a,b,tol);
            fprintf("Solução: x = %.6f\n", c);
            pause(5);

        case 's'
            %Sair
            out_flag = 1;
    end
end


