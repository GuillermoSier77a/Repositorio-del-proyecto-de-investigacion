function ajuste_exponencial(leyx,leyy,vector_grosor,vector_r_prom,filename_26,resolucion)

    % Convertimos los datos a vectores columna.
    vector_grosor = vector_grosor(:);
    vector_r_prom = vector_r_prom(:);
    
    % Definimos el modelo exponencial.
    modelo_exp = fittype('c + a*exp(-x/b)', ...
        'independent','x', ...
        'coefficients',{'c','a','b'});
    
    % % Realizamos el ajuste exponencial.
    % [ajuste_exp,gof_exp] = fit(vector_grosor,vector_r_prom, ...
    %     modelo_exp, ...
    %     'StartPoint',[0.44,0.6,350], ...
    %     'Lower',[0,0,eps]);

    % Realizamos el ajuste exponencial.
    [ajuste_exp,gof_exp] = fit(vector_grosor,vector_r_prom, ...
        modelo_exp, ...
        'StartPoint',[3.5e-5,2.1e-5,300], ...
        'Lower',[0,0,eps], ...
        'Upper',[Inf,Inf,Inf]);
    
    
    % Extraemos los parámetros del ajuste.
    c = ajuste_exp.c;
    a = ajuste_exp.a;
    b = ajuste_exp.b;
    
    % Obtenemos el coeficiente de determinación.
    R2 = gof_exp.rsquare;
    
    % Definimos el intervalo de representación.
    r_min = min(vector_grosor);
    r_max = max(vector_grosor);
    
    % Generamos las abscisas del ajuste.
    abscisas = linspace(r_min,r_max,1000);
    
    % Evaluamos el modelo exponencial ajustado.
    ordenadas = ajuste_exp(abscisas);
    
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
    
    % Representamos el ajuste exponencial.
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
        sprintf(['Ajuste: a*exp[-',leyx,'/(λb)]+c\n', ...
        'a = %.4e, b = %.4e,\n c = %.4e, R^2 = %.4f'], ...
        a,b,c,R2)}, ...
        'Location','northeast');
    
    % Exportamos la gráfica.
    exportgraphics(fig_6,filename_26,'Resolution',resolucion);
    
    % Cerramos la figura.
    close(fig_6)

end