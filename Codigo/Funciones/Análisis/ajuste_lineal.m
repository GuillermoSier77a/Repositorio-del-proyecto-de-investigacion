function ajuste_lineal(leyx,leyy,vector_grosor,vector_r_prom,filename_26,resolucion)

    % Convertimos los datos a vectores columna.
    vector_grosor = vector_grosor(:);
    vector_r_prom = vector_r_prom(:);
    
    % Realizamos el ajuste lineal.
    p = polyfit(vector_grosor,vector_r_prom,1);
    
    % Extraemos los parámetros del ajuste.
    m = p(1);
    b = p(2);
    
    % Evaluamos el ajuste en los puntos originales.
    y_ajuste = polyval(p,vector_grosor);
    
    % Calculamos el coeficiente de determinación.
    SS_res = sum((vector_r_prom-y_ajuste).^2);
    SS_tot = sum((vector_r_prom-mean(vector_r_prom)).^2);
    
    R2 = 1-SS_res/SS_tot;
    
    % Definimos el intervalo de representación.
    r_min = min(vector_grosor);
    r_max = max(vector_grosor);
    
    % Generamos las abscisas del ajuste.
    abscisas = linspace(r_min,r_max,1000);
    
    % Evaluamos el modelo lineal ajustado.
    ordenadas = polyval(p,abscisas);
    
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
    
    % Representamos el ajuste lineal.
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
        sprintf(['Ajuste: m*(',leyx,'/λ)+b\n', ...
        'm = %.4e, b = %.4e, R^2 = %.4f'], ...
        m,b,R2)}, ...
        'Location','northeast');
    
    % Exportamos la gráfica.
    exportgraphics(fig_6,filename_26,'Resolution',resolucion);
    
    % Cerramos la figura.
    close(fig_6)

end
