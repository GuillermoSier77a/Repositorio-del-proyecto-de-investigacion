function graficos_envolvente(ruta,delta_irradiancias,envolvente,I2,estilo,lambda,filename_18_1,filename_18_2,filename_18_3,num_prueba,resolucion,x)

    x_norm = x/lambda;

    I2 = I2/max(I2(:));

    % % Creamos una figura no visible para representar tridimensionalmente
    % % la autocorrelación normalizada.
    % fig_3_0 = figure('Visible','off',"Units", 'normalized', 'Position', [0, 0, 1, 1]);
    % 
    % surf(x_norm,x_norm,I2,'FaceColor',[0.2 0.5 0.9],'EdgeColor','none');
    % 
    % shading interp
    % camlight headlight
    % lighting gouraud
    % 
    % % Orientamos el eje vertical de manera que sus valores aumenten de
    % % abajo hacia arriba.
    % set(gca,'YDir','normal') 
    % 
    % % I2ndicamos en el título el número correspondiente a la simulación.
    % title(['Simulación ',num2str(num_prueba)],'FontWeight','bold');
    % 
    % % Etiquetamos los ejes espaciales normalizados y el valor de la
    % % autocorrelación.
    % xlabel('x/λ','FontWeight','bold');
    % ylabel('y/λ','FontWeight','bold');
    % zlabel('I [u. a.]','FontWeight','bold');
    % 
    % % Configuramos el tamaño y el grosor de la fuente de los ejes.
    % set(gca,'FontSize',15,'FontWeight','bold')
    % 
    % % Ajustamos los límites de los ejes al intervalo de los datos mostrados.
    % axis tight
    % 
    % % Establecemos el ángulo de observación de la superficie tridimensional.
    % view(0,0);
    % 
    % % Agregamos una barra de color para indicar los valores de la
    % % autocorrelación.
    % cb = colorbar;
    % 
    % % Aplicamos el mapa de colores seleccionado para la simulación.
    % colormap(gca, estilo)
    % 
    % % Etiquetamos la barra de color.
    % ylabel(cb,'C_{norm}','FontWeight','bold')
    % 
    % % Exportamos la representación tridimensional de la autocorrelación
    % % utilizando la resolución especificada.
    % exportgraphics(fig_3_0,filename_18_1,'Resolution',resolucion);
    % 
    % % La siguiente instrucción permite cerrar la figura después de
    % % exportarla.
    % close(fig_3_0)
    % 
    % % Creamos una figura no visible para representar tridimensionalmente
    % % la autocorrelación normalizada.
    % fig_2 = figure('Visible','off',"Units", 'normalized', 'Position', [0, 0, 1, 1]);
    % 
    % surf(x_norm,x_norm,delta_irradiancias,'FaceColor',[0.2 0.5 0.9],'EdgeColor','none');
    % 
    % shading interp
    % camlight headlight
    % lighting gouraud
    % 
    % % Orientamos el eje vertical de manera que sus valores aumenten de
    % % abajo hacia arriba.
    % set(gca,'YDir','normal') 
    % 
    % % I2ndicamos en el título el número correspondiente a la simulación.
    % title(['Simulación ',num2str(num_prueba)],'FontWeight','bold');
    % 
    % % Etiquetamos los ejes espaciales normalizados y el valor de la
    % % autocorrelación.
    % xlabel('x/λ','FontWeight','bold');
    % ylabel('y/λ','FontWeight','bold');
    % zlabel('I [u. a.]','FontWeight','bold');
    % 
    % % Configuramos el tamaño y el grosor de la fuente de los ejes.
    % set(gca,'FontSize',15,'FontWeight','bold')
    % 
    % % Ajustamos los límites de los ejes al intervalo de los datos mostrados.
    % axis tight
    % 
    % % Establecemos el ángulo de observación de la superficie tridimensional.
    % view(0,0);
    % 
    % % Agregamos una barra de color para indicar los valores de la
    % % autocorrelación.
    % cb = colorbar;
    % 
    % % Aplicamos el mapa de colores seleccionado para la simulación.
    % colormap(gca, estilo)
    % 
    % % Etiquetamos la barra de color.
    % ylabel(cb,'C_{norm}','FontWeight','bold')
    % 
    % % Exportamos la representación tridimensional de la autocorrelación
    % % utilizando la resolución especificada.
    % exportgraphics(fig_2,filename_18_2,'Resolution',resolucion);
    % 
    % % La siguiente instrucción permite cerrar la figura después de
    % % exportarla.
    % close(fig_2)

    % Creamos una figura no visible para representar tridimensionalmente
    % la autocorrelación normalizada.
    fig_3 = figure('Visible','off',"Units", 'normalized', 'Position', [0, 0, 1, 1]);

    surf(x_norm,x_norm,envolvente,'FaceColor',[0.2 0.5 0.9],'EdgeColor','none');

    shading interp
    camlight headlight
    lighting gouraud

    % Orientamos el eje vertical de manera que sus valores aumenten de
    % abajo hacia arriba.
    set(gca,'YDir','normal') 

    % I2ndicamos en el título el número correspondiente a la simulación.
    title(['Simulación ',num2str(num_prueba)],'FontWeight','bold');

    % Etiquetamos los ejes espaciales normalizados y el valor de la
    % autocorrelación.
    xlabel('x/λ','FontWeight','bold');
    ylabel('y/λ','FontWeight','bold');
    zlabel('I [u. a.]','FontWeight','bold');

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
    exportgraphics(fig_3,filename_18_3,'Resolution',resolucion);

    % La siguiente instrucción permite cerrar la figura después de
    % exportarla.
    close(fig_3)

    % writematrix(I2,fullfile(ruta,'Campo con envolvente.csv'));
    % writematrix(delta_irradiancias,fullfile(ruta,'Campo sin envolvente.csv'));
    % 
    % filename_12 = fullfile(ruta,'Campo en el plano de Fourier sin envolvente.png');
    % 
    % graficos_campo_plano_de_Fourier(resolucion,lambda,filename_12,estilo,delta_irradiancias,num_prueba,x)

end