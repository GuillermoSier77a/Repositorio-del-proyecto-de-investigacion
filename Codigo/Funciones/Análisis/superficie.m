function superficie(ruta_de_carpeta_de_simulaciones,numero_de_simulaciones,filename_16,niveles,estilo,resolucion)

    vector_C = niveles'; % x
    vector_size_de_grano_x = zeros(1,numero_de_simulaciones); % y
    vector_areas = zeros(numero_de_simulaciones,numel(niveles)); % z

    for i = 1:numero_de_simulaciones
    
        % Se construye la ruta de la carpeta correspondiente a la simulación
        % actual.
        carpeta = fullfile(ruta_de_carpeta_de_simulaciones,sprintf('Simulación %d',i));
    
        archivo_1 = fullfile(carpeta,'Parámetros y resultados de propagación.csv');

        % Se leen los datos almacenados en el archivo CSV de la simulación.
        datos_1 = readmatrix(archivo_1);
        vector_size_de_grano_x(1,i) = datos_1(1,10);

        archivo_2 = fullfile(carpeta,'Datos para superficie.csv');

        % Se leen los datos almacenados en el archivo CSV de la simulación.
        datos_2 = readmatrix(archivo_2);
        vector_areas(i,:) = datos_2(:,1);

    end

    %----------------------------------------------------------------------
    % Ordenamos los radios centrales y sus áreas correspondientes.
    %----------------------------------------------------------------------

    [vector_size_de_grano_x,orden] = sort(vector_size_de_grano_x);
    vector_areas = vector_areas(orden,:);

    %----------------------------------------------------------------------
    % Construimos la malla bidimensional.
    %----------------------------------------------------------------------

    [X,Y] = meshgrid(vector_size_de_grano_x,vector_C);

    %----------------------------------------------------------------------
    % Representamos la superficie tridimensional.
    %----------------------------------------------------------------------

    fig_1 = figure('Visible','on','Units','normalized','Position',[0,0,1,1]);

    ax = axes(fig_1);

    surf(ax,X,Y,vector_areas',...
        'FaceColor','interp',...
        'EdgeColor','k',...
        'EdgeAlpha',0.8,...
        'LineWidth',0.6);

    % % Seleccionamos los índices de los niveles que queremos representar.
    % indices_niveles = round(linspace(1,numel(niveles),30));
    % 
    % hold on
    % 
    % for i = indices_niveles
    % 
    %     % Coordenadas horizontales.
    %     X_linea = vector_size_de_grano_x;
    % 
    %     % Coordenadas del nivel de autocorrelación.
    %     Y_linea = niveles(i)*ones(size(vector_size_de_grano_x));
    % 
    %     % Áreas correspondientes al nivel seleccionado.
    %     Z_linea = vector_areas(:,i)';
    % 
    %     % Representamos la curva tridimensional.
    %     plot3(X_linea,Y_linea,Z_linea,'k','LineWidth',3);
    % 
    % end
    % 
    % hold off

    %----------------------------------------------------------------------
    % Configuramos la perspectiva de observación.
    %----------------------------------------------------------------------

    view(ax,135,10);

    % Utilizamos una proyección ortográfica.
    camproj(ax,'orthographic');

    % Ajustamos la proporción visual de los ejes.
    pbaspect(ax,[1.5 1 0.8]);

    %----------------------------------------------------------------------
    % Configuramos los ejes.
    %----------------------------------------------------------------------

    xlabel(ax,'α/λ','FontWeight','bold');
    ylabel(ax,'C_{norm}','FontWeight','bold');
    zlabel(ax,'A_{norm}','FontWeight','bold');

    set(ax,'FontSize',15,'FontWeight','bold');

    axis(ax,'tight');
    grid(ax,'on');
    grid(ax,'minor');
    box(ax,'on');

    %----------------------------------------------------------------------
    % Configuramos el mapa de colores.
    %----------------------------------------------------------------------

    colormap(ax,estilo);

    cb = colorbar(ax);
    ylabel(cb,'A/A_0','FontWeight','bold');

    %----------------------------------------------------------------------
    % Exportamos la figura.
    %----------------------------------------------------------------------

    exportgraphics(fig_1,filename_16,'Resolution',resolucion);

    % La siguiente instrucción permite cerrar la figura después de
    % exportarla.
    % close(fig_1)

end
