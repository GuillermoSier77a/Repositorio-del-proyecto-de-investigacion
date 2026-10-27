function ajuste_de_potencias(leyx,leyy,vector_grosor,vector_r_prom,filename_26,resolucion)

    % Convertimos los datos a vectores columna.
    vector_grosor = vector_grosor(:);
    vector_r_prom = vector_r_prom(:);
    
    % Definimos el modelo de ley de potencias.
    modelo_pot = fittype('a*x^(-b)+c', ...
        'independent','x', ...
        'coefficients',{'a','b','c'});
    
    % Estimamos los parámetros iniciales.
    p0 = 1;
    c0 = min(vector_r_prom);
    a0 = (max(vector_r_prom)-c0)*min(vector_grosor)^p0;
    
    % Realizamos el ajuste de ley de potencias.
    [ajuste_pot,gof_pot] = fit(vector_grosor,vector_r_prom, ...
        modelo_pot, ...
        'StartPoint',[a0,p0,c0], ...
        'Lower',[0,eps,0], ...
        'Upper',[Inf,Inf,Inf]);
    
    % Extraemos los parámetros del ajuste.
    a = ajuste_pot.a;
    b = ajuste_pot.b;
    c = ajuste_pot.c;
    
    % Obtenemos el coeficiente de determinación.
    R2 = gof_pot.rsquare;
    
    % Definimos el intervalo de representación.
    r_min = min(vector_grosor);
    r_max = max(vector_grosor);
    
    % Generamos las abscisas del ajuste.
    abscisas = linspace(r_min,r_max,1000);
    
    % Evaluamos el modelo de potencias ajustado.
    ordenadas = ajuste_pot(abscisas);
    
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
        sprintf(['Ajuste: a*(',leyx,'/λ)^{-b}+c\n', ...
        'a = %.4e, b = %.4e, c = %.4e, R^2 = %.4f'], ...
        a,b,c,R2)}, ...
        'Location','northeast');
    
    % Exportamos la gráfica.
    exportgraphics(fig_6,filename_26,'Resolution',resolucion);
    
    % Cerramos la figura.
    close(fig_6)

end
