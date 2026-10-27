function graficos_autocorrelacion_3d(filas_maximos,columnas_maximos,maximos,autocorrelacion,estilo,lambda,filename_3_0,num_prueba,resolucion,x)

    x_norm = x/lambda;

    % Creamos una figura no visible para representar tridimensionalmente
    % la autocorrelación normalizada.
    fig_3_0 = figure('Visible','off',"Units", 'normalized', 'Position', [0, 0, 1, 1]);

    % % Definimos el factor de reducción.
    % factor = 4;
    % 
    % % Seleccionamos los índices de muestreo.
    % idx = 1:factor:numel(x_norm);
    % 
    % % Representamos la superficie con resolución reducida.
    % surf(x_norm(idx),x_norm(idx),autocorrelacion(idx,idx),'FaceColor',[0.2 0.5 0.9],'EdgeColor','none');

    surf(x_norm,x_norm,autocorrelacion,'FaceColor',[0.2 0.5 0.9],'EdgeColor','none');

    shading interp
    camlight headlight
    lighting gouraud

    hold on

    % Representamos los máximos locales.
    plot3(x_norm(columnas_maximos),x_norm(filas_maximos),maximos,'r.','MarkerSize',5);

    % Orientamos el eje vertical de manera que sus valores aumenten de
    % abajo hacia arriba.
    set(gca,'YDir','normal') 

    % Indicamos en el título el número correspondiente a la simulación.
    title(['Simulación ',num2str(num_prueba)],'FontWeight','bold');

    % Etiquetamos los ejes espaciales normalizados y el valor de la
    % autocorrelación.
    xlabel('x/λ','FontWeight','bold');
    ylabel('y/λ','FontWeight','bold');
    zlabel('C_{norm}','FontWeight','bold');

    % Configuramos el tamaño y el grosor de la fuente de los ejes.
    set(gca,'FontSize',15,'FontWeight','bold')

    % Ajustamos los límites de los ejes al intervalo de los datos mostrados.
    axis tight

    % Establecemos el ángulo de observación de la superficie tridimensional.
    view(0,0);

    % Agregamos una barra de color para indicar los valores de la
    % autocorrelación.
    cb = colorbar;

    % Aplicamos el mapa de colores seleccionado para la simulación.
    colormap(gca, estilo)

    % Etiquetamos la barra de color.
    ylabel(cb,'C_{norm}','FontWeight','bold')

    % Exportamos la representación tridimensional de la autocorrelación
    % utilizando la resolución especificada.
    exportgraphics(fig_3_0,filename_3_0,'Resolution',resolucion);

    % La siguiente instrucción permite cerrar la figura después de
    % exportarla.
    close(fig_3_0)
   
end