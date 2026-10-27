function filtro_DoG_videos(resolucion,filename_19,lambda,x,I_ref,ruta,calidad_de_video,num_prueba)

    % Convertimos la distribución de irradiancia de referencia a precisión
    % simple para reducir el uso de memoria durante el procesamiento.
    I_ref = single(I_ref);

    % Definimos el número de configuraciones del filtro DoG que serán
    % evaluadas y la tasa de cuadros de los videos generados.
    num_frames = 15;
    frame_rate = 5;

    % Número de niveles del mapa de colores.
    n = 256;

    %----------------------------------------------------------------------
    % Mapas de colores para fondo oscuro.
    %----------------------------------------------------------------------

    % Definimos los colores principales.
    azul = [0.48 0.43 1.00];
    negro = [0.07 0.07 0.07];
    rojo = [1.00 0.38 0.42];

    % Mapa azul -> negro.
    azul_negro = [ ...
        linspace(azul(1),negro(1),n/2)', ...
        linspace(azul(2),negro(2),n/2)', ...
        linspace(azul(3),negro(3),n/2)'];

    % Mapa negro -> rojo.
    negro_rojo = [ ...
        linspace(negro(1),rojo(1),n/2)', ...
        linspace(negro(2),rojo(2),n/2)', ...
        linspace(negro(3),rojo(3),n/2)'];

    % Mapa divergente azul -> negro -> rojo.
    azul_negro_rojo = [azul_negro;negro_rojo];

    % Mapa para representar únicamente respuestas positivas.
    mapa_positivo = [ ...
        linspace(negro(1),rojo(1),n)', ...
        linspace(negro(2),rojo(2),n)', ...
        linspace(negro(3),rojo(3),n)'];

    % Mapa para representar únicamente respuestas negativas.
    mapa_negativo = [ ...
        linspace(azul(1),negro(1),n)', ...
        linspace(azul(2),negro(2),n)', ...
        linspace(azul(3),negro(3),n)'];

    % Definimos el color de fondo de las figuras.
    color_fondo = [0.07 0.07 0.07];

    %----------------------------------------------------------------------
    % Creación de los archivos de video.
    %----------------------------------------------------------------------

    video_filename_1 = fullfile(ruta,'Filtro DoG oscuro.mp4');
    video_filename_2 = fullfile(ruta,'Filtro DoG dividido oscuro.mp4');

    % Creamos el primer video.
    video_1 = VideoWriter(video_filename_1,'MPEG-4');
    video_1.FrameRate = frame_rate;
    video_1.Quality = calidad_de_video;
    open(video_1);

    % Creamos el segundo video.
    video_2 = VideoWriter(video_filename_2,'MPEG-4');
    video_2.FrameRate = frame_rate;
    video_2.Quality = calidad_de_video;
    open(video_2);

    %----------------------------------------------------------------------
    % Figura 1: Respuesta completa del filtro DoG.
    %----------------------------------------------------------------------

    fig_1 = figure('Visible','off', ...
        'Units','pixels', ...
        'Position',[100 100 800 800], ...
        'Color',color_fondo, ...
        'InvertHardcopy','off');

    ax1 = axes(fig_1);

    % Inicializamos la imagen.
    h1 = imagesc(ax1,x/lambda,x/lambda, ...
        zeros(size(I_ref),'like',I_ref));

    % Etiquetamos los ejes.
    xlabel(ax1,'x/λ','FontWeight','bold','Color','w');
    ylabel(ax1,'y/λ','FontWeight','bold','Color','w');

    % Agregamos la barra de color.
    cb1 = colorbar(ax1);
    ylabel(cb1,'Respuesta DoG [u. a.]', ...
        'FontWeight','bold','Color','w');

    % Aplicamos el mapa de colores oscuro.
    colormap(ax1,azul_negro_rojo);

    % Configuramos los ejes.
    set(ax1, ...
        'YDir','normal', ...
        'FontSize',15, ...
        'FontWeight','bold', ...
        'Color',color_fondo, ...
        'XColor','w', ...
        'YColor','w');

    % Configuramos la barra de color.
    cb1.Color = 'w';

    % Conservamos la escala espacial.
    axis(ax1,'equal');
    axis(ax1,'tight');

    %----------------------------------------------------------------------
    % Figura 2: Respuestas positiva y negativa por separado.
    %----------------------------------------------------------------------

    fig_2 = figure('Visible','off', ...
        'Units','pixels', ...
        'Position',[100 100 1600 800], ...
        'Color',color_fondo, ...
        'InvertHardcopy','off');

    tiledlayout(fig_2,1,2, ...
        'TileSpacing','compact', ...
        'Padding','compact');

    %----------------------------------------------------------------------
    % Panel 1: Respuesta positiva.
    %----------------------------------------------------------------------

    ax2 = nexttile;

    h2 = imagesc(ax2,x/lambda,x/lambda, ...
        zeros(size(I_ref),'like',I_ref));

    xlabel(ax2,'x/λ','FontWeight','bold','Color','w');
    ylabel(ax2,'y/λ','FontWeight','bold','Color','w');

    cb2 = colorbar(ax2);
    ylabel(cb2,'Respuesta DoG [u. a.]', ...
        'FontWeight','bold','Color','w');

    colormap(ax2,mapa_positivo);

    set(ax2, ...
        'YDir','normal', ...
        'FontSize',15, ...
        'FontWeight','bold', ...
        'Color',color_fondo, ...
        'XColor','w', ...
        'YColor','w');

    cb2.Color = 'w';

    axis(ax2,'equal');
    axis(ax2,'tight');

    %----------------------------------------------------------------------
    % Panel 2: Respuesta negativa.
    %----------------------------------------------------------------------

    ax3 = nexttile;

    h3 = imagesc(ax3,x/lambda,x/lambda, ...
        zeros(size(I_ref),'like',I_ref));

    xlabel(ax3,'x/λ','FontWeight','bold','Color','w');
    ylabel(ax3,'y/λ','FontWeight','bold','Color','w');

    cb3 = colorbar(ax3);
    ylabel(cb3,'Respuesta DoG [u. a.]', ...
        'FontWeight','bold','Color','w');

    colormap(ax3,mapa_negativo);

    set(ax3, ...
        'YDir','normal', ...
        'FontSize',15, ...
        'FontWeight','bold', ...
        'Color',color_fondo, ...
        'XColor','w', ...
        'YColor','w');

    cb3.Color = 'w';

    axis(ax3,'equal');
    axis(ax3,'tight');

    %----------------------------------------------------------------------
    % Aplicación del filtro DoG.
    %----------------------------------------------------------------------

    for i = 1:num_frames

        % Definimos las desviaciones estándar de las gaussianas.
        sigma1 = 0.5*i;
        sigma2 = 2*sigma1;

        % Aplicamos ambos filtros gaussianos.
        I1 = imgaussfilt(I_ref,sigma1);
        I2 = imgaussfilt(I_ref,sigma2);

        % Calculamos la diferencia de gaussianas.
        DoG = I1 - I2;

        % % Guardamos la figura correspondiente al último filtro.
        % if i == num_frames
        % 
        %     graficos_campo_plano_de_Fourier_con_filtro( ...
        %         sigma1,sigma2,resolucion,lambda, ...
        %         filename_19,azul_negro_rojo, ...
        %         DoG,num_prueba,x);
        % 
        % end

        % Separamos las respuestas positiva y negativa.
        I1 = max(DoG,0);
        I2 = min(DoG,0);

        % Calculamos el límite de visualización.
        limite = prctile(abs(DoG(:)),99.5);

        % Evitamos límites de color idénticos.
        limite = max(double(limite),eps);

        %------------------------------------------------------------------
        % Actualización de la figura 1.
        %------------------------------------------------------------------

        h1.CData = DoG;

        % Escala simétrica respecto a cero.
        clim(ax1,[-limite limite]);

        title(ax1, ...
            sprintf('Simulación %g (\\sigma_1/dx = %g, \\sigma_2/dx = %g)', ...
            num_prueba,sigma1,sigma2), ...
            'FontWeight','bold','Color','w');

        drawnow;

        % Capturamos el cuadro.
        frame_1 = getframe(fig_1);
        writeVideo(video_1,frame_1);

        clear frame_1

        %------------------------------------------------------------------
        % Actualización de la figura 2.
        %------------------------------------------------------------------

        h2.CData = I1;
        h3.CData = I2;

        % Escalas para las componentes positiva y negativa.
        clim(ax2,[0 limite]);
        clim(ax3,[-limite 0]);

        title(ax2, ...
            sprintf('Simulación %g (\\sigma_1/dx = %g, \\sigma_2/dx = %g)', ...
            num_prueba,sigma1,sigma2), ...
            'FontWeight','bold','Color','w');

        title(ax3, ...
            sprintf('Simulación %g (\\sigma_1/dx = %g, \\sigma_2/dx = %g)', ...
            num_prueba,sigma1,sigma2), ...
            'FontWeight','bold','Color','w');

        drawnow;

        % Capturamos el cuadro.
        frame_2 = getframe(fig_2);
        writeVideo(video_2,frame_2);

        clear frame_2 I1 I2 DoG

    end

    %----------------------------------------------------------------------
    % Finalización.
    %----------------------------------------------------------------------

    % Cerramos los archivos de video.
    close(video_1);
    close(video_2);

    % Cerramos las figuras auxiliares.
    close(fig_1);
    close(fig_2);

end
