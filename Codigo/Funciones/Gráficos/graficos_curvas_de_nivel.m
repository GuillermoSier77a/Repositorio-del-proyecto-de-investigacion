function graficos_curvas_de_nivel(curvas_promedio,estilo,lambda,filename_3_1,filename_3_2,num_prueba,resolucion,x,autocorrelacion,niveles)

    % Normalizamos las coordenadas espaciales respecto a la longitud
    % de onda.
    x_norm = x/lambda;
    
    % Creamos una figura no visible para representar las curvas
    % de nivel de la autocorrelación normalizada.
    fig_3_1 = figure('Visible','off',"Units",'normalized', ...
        'Position',[0,0,1,1]);
    
    ax1 = axes(fig_3_1);
    
    % Representamos los contornos correspondientes a los niveles
    % de autocorrelación previamente calculados.
    contour(ax1,x_norm,x_norm,autocorrelacion,niveles, ...
        'LineWidth',1);
    
    % Orientamos el eje vertical de manera que sus valores aumenten
    % de abajo hacia arriba.
    set(ax1,'YDir','normal');
    
    % Indicamos en el título el número de simulación.
    title(ax1,['Simulación ',num2str(num_prueba)], ...
        'FontWeight','bold');
    
    % Etiquetamos los ejes espaciales normalizados.
    xlabel(ax1,'x/λ','FontWeight','bold');
    ylabel(ax1,'y/λ','FontWeight','bold');
    
    % Configuramos el tamaño y el grosor de la fuente.
    set(ax1,'FontSize',15,'FontWeight','bold');
    
    % Ajustamos los límites de los ejes.
    axis(ax1,'tight');
    axis(ax1,'square');
    
    % Agregamos una barra de color.
    cb = colorbar(ax1);
    
    % Aplicamos el mapa de colores seleccionado.
    colormap(ax1,estilo);
    
    % Etiquetamos la barra de color.
    ylabel(cb,'C_{norm}','FontWeight','bold');
    
    % Exportamos la figura con los contornos originales.
    exportgraphics(fig_3_1,filename_3_1, ...
        'Resolution',resolucion);
    
    % Conservamos la figura para agregar las curvas promedio.
    hold(ax1,'on');
    
    % Representamos las curvas promedio previamente calculadas.
    for i = 1:numel(curvas_promedio)
    
        puntos = curvas_promedio{i};
    
        if ~isempty(puntos)
    
            plot(ax1,puntos(:,1),puntos(:,2), ...
                'r','LineWidth',2);
    
        end
    
    end
    
    hold(ax1,'off');
    
    % Exportamos la figura con las curvas promedio.
    exportgraphics(fig_3_1,filename_3_2, ...
        'Resolution',resolucion);
    
    % Cerramos la figura.
    close(fig_3_1);

end
