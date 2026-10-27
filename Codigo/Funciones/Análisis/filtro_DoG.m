function filtro_DoG(resolucion,filename_19,lambda,x,I_ref,ruta,calidad_de_video,num_prueba)

    % Convertimos la distribución de irradiancia de referencia a precisión
    % simple para reducir el uso de memoria durante el procesamiento.
    I_ref = single(I_ref);
    
    % Definimos el número de configuraciones del filtro DoG que serán
    % evaluadas y la tasa de cuadros de los videos generados.
    num_frames = 15;
    frame_rate = 5;

    % Número de niveles del mapa de colores.
    n = 256;

    % Mapa azul -> blanco.
    azul_blanco = [linspace(0,1,n)',linspace(0,1,n)',ones(n,1)];

    % Mapa blanco -> rojo.
    blanco_rojo = [ones(n,1),linspace(1,0,n)',linspace(1,0,n)'];

    % Mapa azul -> blanco -> rojo.
    azul_blanco_rojo = [linspace(0,1,n/2)', linspace(0,1,n/2)', ones(n/2,1); ones(n/2,1), linspace(1,0,n/2)', linspace(1,0,n/2)'];

    % Definimos las rutas de los dos videos que almacenarán los resultados
    % del filtrado DoG.
    video_filename_1 = fullfile(ruta,'Filtro DoG.mp4');
    video_filename_2 = fullfile(ruta,'Filtro DoG dividido.mp4');

    % Creamos el primer video, destinado a mostrar la respuesta completa
    % del filtro DoG para cada combinación de sigma_1 y sigma_2.
    video_1 = VideoWriter(video_filename_1,'MPEG-4');
    video_1.FrameRate = frame_rate;
    video_1.Quality = calidad_de_video;
    open(video_1);

    % Creamos el segundo video, destinado a mostrar por separado las
    % componentes positiva y negativa de la respuesta del filtro DoG.
    video_2 = VideoWriter(video_filename_2,'MPEG-4');
    video_2.FrameRate = frame_rate;
    video_2.Quality = calidad_de_video;
    open(video_2);

    % Creamos una figura no visible para representar la respuesta completa
    % del filtro DoG y generar los cuadros del primer video.
    fig_1 = figure('Visible',"off",'Units','pixels','Position',[100 100 800 800]);

    % Creamos los ejes asociados a la primera figura.
    ax1 = axes(fig_1);

    % Inicializamos la imagen con una matriz de ceros y expresamos las
    % coordenadas espaciales normalizadas con respecto a la longitud de onda.
    h1 = imagesc(ax1,x/lambda,x/lambda,zeros(size(I_ref),'like',I_ref));

    % Etiquetamos los ejes espaciales normalizados.
    xlabel(ax1,'x/λ','FontWeight','bold');
    ylabel(ax1,'y/λ','FontWeight','bold');

    % Agregamos la barra de color correspondiente a la respuesta del filtro.
    cb1 = colorbar(ax1);
    ylabel(cb1,'Respuesta DoG [u. a.]','FontWeight','bold');

    % Aplicamos el mapa de colores divergente azul-blanco-rojo.
    colormap(ax1,azul_blanco_rojo);

    % Ajustamos la orientación y el formato de los ejes.
    set(ax1,'YDir','normal');
    set(ax1,'FontSize',15,'FontWeight','bold');

    % Conservamos la misma escala en ambos ejes y ajustamos sus límites
    % al dominio espacial representado.
    axis(ax1,'equal');
    axis(ax1,'tight');

    % Creamos una segunda figura no visible con dos paneles para representar
    % por separado las respuestas positiva y negativa del filtro DoG.
    fig_2 = figure('Visible',"off",'Units','pixels','Position',[100 100 1600 800]);

    % Dividimos la segunda figura horizontalmente en dos regiones.
    tiledlayout(fig_2,1,2,'TileSpacing','compact','Padding','compact');

    % Creamos el primer panel, destinado a representar la componente
    % positiva de la respuesta del filtro DoG.
    ax2 = nexttile;
    h2 = imagesc(ax2,x/lambda,x/lambda,zeros(size(I_ref),'like',I_ref));

    % Etiquetamos los ejes espaciales normalizados.
    xlabel(ax2,'x/λ','FontWeight','bold');
    ylabel(ax2,'y/λ','FontWeight','bold');

    % Agregamos la barra de color correspondiente a la respuesta del filtro.
    cb2 = colorbar(ax2);
    ylabel(cb2,'Respuesta DoG [u. a.]','FontWeight','bold');

    % Aplicamos el mapa de colores divergente.
    colormap(ax2,blanco_rojo);

    % Ajustamos la orientación y el formato de los ejes.
    set(ax2,'YDir','normal');
    set(ax2,'FontSize',15,'FontWeight','bold');

    % Conservamos la misma escala espacial en ambos ejes.
    axis(ax2,'equal');
    axis(ax2,'tight');

    % Creamos el segundo panel, destinado a representar la componente
    % negativa de la respuesta del filtro DoG.
    ax3 = nexttile;
    h3 = imagesc(ax3,x/lambda,x/lambda,zeros(size(I_ref),'like',I_ref));

    % Etiquetamos los ejes espaciales normalizados.
    xlabel(ax3,'x/λ','FontWeight','bold');
    ylabel(ax3,'y/λ','FontWeight','bold');

    % Agregamos la barra de color correspondiente a la respuesta del filtro.
    cb3 = colorbar(ax3);
    ylabel(cb3,'Respuesta DoG [u. a.]','FontWeight','bold');

    % Aplicamos el mapa de colores divergente.
    colormap(ax3,azul_blanco);

    % Ajustamos la orientación y el formato de los ejes.
    set(ax3,'YDir','normal');
    set(ax3,'FontSize',15,'FontWeight','bold');

    % Conservamos la misma escala espacial en ambos ejes.
    axis(ax3,'equal');
    axis(ax3,'tight');

    % Recorremos las diferentes escalas espaciales utilizadas para construir
    % el filtro DoG y generamos un cuadro de video para cada configuración.
    for i = 1:num_frames

        sigma1 = 0.5*i;
        sigma2 = 2*sigma1;

        % Aplicamos ambos filtros gaussianos.
        I1 = imgaussfilt(I_ref,sigma1);
        I2 = imgaussfilt(I_ref,sigma2);

        % Calculamos la diferencia de gaussianas.
        DoG = I1 - I2;

        % if i == num_frames
        % 
        %     graficos_campo_plano_de_Fourier_con_filtro(sigma1,sigma2,resolucion,lambda,filename_19,azul_blanco_rojo,DoG,num_prueba,x)
        % 
        % end

        % Las gaussianas ya no son necesarias. Reutilizamos sus variables
        % para almacenar las componentes positiva y negativa.
        I1 = max(DoG,0);
        I2 = min(DoG,0);

        % Actualizamos la imagen de la primera figura con la respuesta
        % completa del filtro DoG.
        h1.CData = DoG;

        % Calculamos un límite de visualización a partir del percentil 99.5
        % del valor absoluto de la respuesta, reduciendo la influencia de
        % valores extremos sobre la escala de color.
        limite = prctile(abs(DoG(:)),99.5);

        % Establecemos límites simétricos alrededor de cero para representar
        % de manera comparable las respuestas positivas y negativas.
        clim(ax1,[-limite limite]);

        % Indicamos en el título el número de simulación y los valores de
        % sigma_1 y sigma_2 utilizados en la configuración actual.
        title(ax1,sprintf('Simulación %g (\\sigma_1/dx = %g, \\sigma_2/dx = %g)',num_prueba,sigma1,sigma2),'FontWeight','bold');

        % Actualizamos la figura antes de capturar el cuadro correspondiente.
        drawnow

        % Capturamos la figura y agregamos el cuadro al primer video.
        frame_1 = getframe(fig_1);
        writeVideo(video_1,frame_1);

        clear frame_1

        % Actualizamos los dos paneles de la segunda figura con las
        % componentes positiva y negativa de la respuesta del filtro.
        h2.CData = I1;
        h3.CData = I2;

        % Ajustamos las escalas de color de ambos paneles de acuerdo con
        % las amplitudes de las respectivas componentes.
        clim(ax2,[0 limite]);
        clim(ax3,[-limite 0]);

        % Indicamos los parámetros del filtro utilizados en el panel
        % correspondiente a la respuesta positiva.
        title(ax2,sprintf('Simulación %g (\\sigma_1/dx = %g, \\sigma_2/dx = %g)',num_prueba,sigma1,sigma2),'FontWeight','bold');

        % Indicamos los mismos parámetros en el panel correspondiente a la
        % respuesta negativa.
        title(ax3,sprintf('Simulación %g (\\sigma_1/dx = %g, \\sigma_2/dx = %g)',num_prueba,sigma1,sigma2),'FontWeight','bold');

        % Actualizamos la segunda figura antes de capturar el cuadro.
        drawnow

        % Capturamos ambos paneles y agregamos el cuadro al segundo video.
        frame_2 = getframe(fig_2);
        writeVideo(video_2,frame_2);

        clear frame_2 I1 I2 DoG

    end

    % Cerramos ambos archivos de video una vez procesadas todas las
    % configuraciones del filtro DoG.
    close(video_1);
    close(video_2);

    % Cerramos las figuras auxiliares utilizadas para generar los videos.
    close(fig_1);
    close(fig_2);

end