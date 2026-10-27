function graficos_varianza_hiperuniformidad(psi,b,R2,radios,varianzas,num_prueba,filename_17,resolucion)
    
    % Construimos la curva correspondiente a la ley de potencia.
    abscisas = logspace(log10(min(radios)),log10(max(radios)),100);
    
    ordenadas = b*abscisas.^psi;
    
    % Creamos la figura.
    fig_1 = figure('Visible','off', ...
        'Units','normalized','Position',[0,0,1,1]);
    
    % Representamos los datos numéricos.
    h1 = loglog(radios,varianzas, ...
        'Color','r', ...
        'Marker','o', ...
        'MarkerSize',6, ...
        'MarkerFaceColor','k', ...
        'MarkerEdgeColor','none', ...
        'LineWidth',3);
    
    hold on
    
    % Representamos la ley de potencia ajustada.
    h2 = loglog(abscisas,ordenadas, ...
        'LineWidth',3, ...
        'Color','b', ...
        'LineStyle','--');
    
    hold off
    
    % Configuramos los ejes.
    title(['Simulación ',num2str(num_prueba)], ...
        'FontWeight','bold');
    
    xlabel('r/\lambda','FontWeight','bold');
    ylabel('\sigma_J^2(r)','FontWeight','bold');
    
    configurar_ejes()
    
    % Agregamos la leyenda con los parámetros del ajuste.
    legend([h1,h2], ...
        {'Datos numéricos', ...
        sprintf('Ajuste lineal:\nψ = %.4f\nb = %.4f\nR^2 = %.4f',psi,b,R2)}, ...
        'Location','northwest');
    
    % Exportamos la figura.
    exportgraphics(fig_1,filename_17, ...
        'Resolution',resolucion);
    
    close(fig_1)

end