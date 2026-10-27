function ajuste_exponencial_estirada(leyx,leyy,vector_grosor,vector_r_prom,filename_26,resolucion)
    
    % Convertimos los datos a vectores columna.
    vector_grosor = vector_grosor(:);
    vector_r_prom = vector_r_prom(:);
    
    % Definimos el modelo exponencial generalizado.
    modelo = fittype('c+a*exp(-(x/b)^p)', ...
        'independent','x', ...
        'coefficients',{'c','a','b','p'});

    % Realizamos el ajuste.
    [ajuste,gof] = fit(vector_grosor(:),vector_r_prom(:), ...
        modelo, ...
        'StartPoint',[0.45,0.55,2000,2], ...
        'Lower',[0,0,eps,0.1], ...
        'Upper',[1,1,Inf,5]);

    % Extraemos los parámetros.
    c = ajuste.c;
    a = ajuste.a;
    b = ajuste.b;
    p = ajuste.p;

    % Obtenemos el coeficiente de determinación.
    R2 = gof.rsquare;
    
    % Definimos el intervalo de representación.
    r_min = min(vector_grosor);
    r_max = max(vector_grosor);
    
    % Generamos las abscisas del ajuste.
    abscisas = linspace(r_min,r_max,1000);
    
    % Evaluamos el modelo de potencias ajustado.
    ordenadas = ajuste(abscisas);
    
    % Creamos una figura para representar los resultados.
    fig_6 = figure('Visible','off', ...
        'Units','normalized', ...
        'Position',[0,0,1,1]);
    
    % Representamos los datos numéricos.
    h1 = plot(vector_grosor,vector_r_prom, ...
        'LineWidth',3, ...
        'Color','r', ...
        'Marker','o', ...
        'MarkerFaceColor','k', ...
        'MarkerSize',3, ...
        'MarkerEdgeColor','none');
    
    hold on
    
    % Representamos el ajuste de ley de potencias.
    h2 = plot(abscisas,ordenadas, ...
        'LineWidth',3, ...
        'Color','b', ...
        'LineStyle','--');
    
    hold off
    
    % Etiquetamos los ejes.
    xlabel([leyx,'/λ'],'FontWeight','bold');
    ylabel(leyy,'FontWeight','bold');
    
    % Aplicamos la configuración general de los ejes.
    configurar_ejes()
    
    % Agregamos una leyenda con los parámetros del ajuste.
    legend([h1,h2], ...
        {'Datos numéricos', ...
        sprintf(['Ajuste: a*exp[-[',leyx,'/(λb)]^p]+c\n', ...
        'a = %.4e, b = %.4e, c = %.4e,\n p = %.4e, R^2 = %.4f'], ...
        a,b,c,p,R2)}, ...
        'Location','northeast');
    
    % Exportamos la gráfica.
    exportgraphics(fig_6,filename_26,'Resolution',resolucion);
    
    % Cerramos la figura.
    close(fig_6)

end
