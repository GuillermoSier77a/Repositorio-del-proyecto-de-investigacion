function graficos_promediados(numero_de_simulaciones,numero_de_series,ruta_nucleo,resolucion,filename_8,filename_9,filename_10,filename_15,filename_21,filename_22,filename_23,filename_24,filename_25)

    carpeta_graficos_promediados = fullfile(ruta_nucleo,'Gráficos promediados');

    % Si la carpeta ya existe, eliminarla junto con todo su contenido
    % Esto permite comenzar cada ejecución con una carpeta de resultados limpia
    if isfolder(carpeta_graficos_promediados)
        rmdir(carpeta_graficos_promediados,'s');   % 's' = elimina la carpeta y todo lo que contiene
    end

    mkdir(carpeta_graficos_promediados);

    nombres_archivos = {filename_8,filename_9,filename_10,filename_15,filename_21,filename_22,filename_23,filename_24,filename_25};

    for i = 1:numel(nombres_archivos)

        [~,nombre,extension] = fileparts(nombres_archivos{i});

        nombres_archivos{i} = fullfile(carpeta_graficos_promediados,[nombre,extension]);

    end

    % Se genera un vector que identifica cada una de las simulaciones
    % realizadas.
    vector_pruebas = 1:numero_de_simulaciones;

    % Se inicializan los vectores destinados a almacenar los parámetros y
    % resultados obtenidos en cada simulación.
    vector_radios = NaN(1,numero_de_simulaciones);
    vector_grosor = NaN(1,numero_de_simulaciones);
    vector_size_de_grano_x = NaN(1,numero_de_simulaciones);

    vector_p_prom = NaN(numero_de_series,numero_de_simulaciones);
    vector_r_prom = NaN(numero_de_series,numero_de_simulaciones);
    vector_A05 = NaN(numero_de_series,numero_de_simulaciones);
    vector_psi = NaN(numero_de_series,numero_de_simulaciones);
    vector_numero_de_maximos = NaN(numero_de_series,numero_de_simulaciones);
    vector_RCM = NaN(numero_de_series,numero_de_simulaciones);
    vector_RGRAD = NaN(numero_de_series,numero_de_simulaciones);
    vector_LEC = NaN(numero_de_series,numero_de_simulaciones);
    vector_tiempo = NaN(numero_de_series,numero_de_simulaciones);
        
    for j = 1:numero_de_series
        % Se recorren las carpetas correspondientes a cada simulación para
        % recuperar los parámetros y resultados almacenados en sus archivos CSV.
        carpeta_nucleo = fullfile(ruta_nucleo,sprintf('Serie %d',j));
        ruta_de_carpeta_de_simulaciones = fullfile(carpeta_nucleo,'Simulaciones');

        for i = 1:numero_de_simulaciones

            % Se construye la ruta de la carpeta correspondiente a la simulación
            % actual.
            carpeta = fullfile(ruta_de_carpeta_de_simulaciones,sprintf('Simulación %d',i));

            % Se construye la ruta del archivo que contiene los parámetros y
            % resultados obtenidos durante la propagación.
            archivo = fullfile(carpeta,'Parámetros y resultados de propagación.csv');

            % Se leen los datos almacenados en el archivo CSV de la simulación.
            datos = readmatrix(archivo);

            % Se extraen los parámetros geométricos del campo y del difusor,
            % así como los resultados del análisis de la propagación.

            vector_size_de_grano_x(1,i) = datos(1,10);
            vector_radios(1,i) = datos(1,12);
            vector_grosor(1,i) = datos(1,13);

            vector_p_prom(j,i) = datos(1,17);
            vector_r_prom(j,i) = datos(1,18);
            vector_A05(j,i) = datos(1,19);
            vector_psi(j,i) = datos(1,20);
            vector_numero_de_maximos(j,i) = datos(1,21);
            vector_RCM(j,i) = datos(1,22);
            vector_RGRAD(j,i) = datos(1,23);
            vector_LEC(j,i) = datos(1,24);
            vector_tiempo(j,i) = datos(1,25);

        end
    end

    vector_p_promP = mean(vector_p_prom,1);
    vector_r_promP = mean(vector_r_prom,1);
    vector_A05P = mean(vector_A05,1);
    vector_psiP = mean(vector_psi,1);
    vector_numero_de_maximosP = mean(vector_numero_de_maximos,1);
    vector_RCMP = mean(vector_RCM,1);
    vector_RGRADP = mean(vector_RGRAD,1);
    vector_LECP = mean(vector_LEC,1);
    vector_tiempoP = mean(vector_tiempo,1);

    vector_p_promD = std(vector_p_prom,0,1);
    vector_r_promD = std(vector_r_prom,0,1);
    vector_A05D = std(vector_A05,0,1);
    vector_psiD = std(vector_psi,0,1);
    vector_numero_de_maximosD = std(vector_numero_de_maximos,0,1);
    vector_RCMD = std(vector_RCM,0,1);
    vector_RGRADD = std(vector_RGRAD,0,1);
    vector_LECD = std(vector_LEC,0,1);
    vector_tiempoD = std(vector_tiempo,0,1);

    % Se crea una figura no visible para analizar el comportamiento de la
    % potencia óptica promedio en función del radio central R_0.
    fig_1 = figure('Visible',"off","Units", 'normalized', 'Position', [0, 0, 1, 1]);

    % Se representa la potencia óptica promedio obtenida durante la
    % propagación para cada valor del radio central.
    hold on
    for j=1:numero_de_series
        if j == 1
            plot(vector_size_de_grano_x,vector_p_prom(j,:),'LineWidth',1,'Color',[0.75 0.75 0.75],'Marker','none','MarkerFaceColor','k','MarkerSize',3,'MarkerEdgeColor','k','DisplayName','Series de simulaciones');

        else
            plot(vector_size_de_grano_x,vector_p_prom(j,:),'LineWidth',1,'Color',[0.75 0.75 0.75],'Marker','none','MarkerFaceColor','k','MarkerSize',3,'MarkerEdgeColor','k','HandleVisibility','off');

        end
    end
    errorbar(vector_size_de_grano_x,vector_p_promP,vector_p_promD,'LineWidth',1.5,'Color','r','Marker','o','MarkerFaceColor','k','MarkerSize',3,'MarkerEdgeColor','k','CapSize',8,'DisplayName','Media ± D. E.');
    hold off

    legend('show','Location','bestoutside');

    % Se etiquetan los ejes con las magnitudes correspondientes.
    xlabel('α/λ','FontWeight','bold');
    ylabel('μ_P','FontWeight','bold');

    % Se aplica la configuración general definida para los ejes.
    configurar_ejes()

    % Se exporta la gráfica utilizando la resolución especificada.
    exportgraphics(fig_1,nombres_archivos{2},'Resolution',resolucion)

    % Se cierra la figura una vez exportada.
    close(fig_1)

    % Se crea una figura no visible para analizar el comportamiento del
    % coeficiente de correlación promedio en función del radio central R_0.
    fig_2 = figure('Visible',"off","Units", 'normalized', 'Position', [0, 0, 1, 1]);

    % Se representa el coeficiente de correlación promedio obtenido durante
    % la propagación para cada valor del radio central.
    hold on
    for j=1:numero_de_series
        if j == 1
            plot(vector_size_de_grano_x,vector_r_prom(j,:),'LineWidth',1,'Color',[0.75 0.75 0.75],'Marker','none','MarkerFaceColor','k','MarkerSize',3,'MarkerEdgeColor','k','DisplayName','Series de simulaciones');

        else
            plot(vector_size_de_grano_x,vector_r_prom(j,:),'LineWidth',1,'Color',[0.75 0.75 0.75],'Marker','none','MarkerFaceColor','k','MarkerSize',3,'MarkerEdgeColor','k','HandleVisibility','off');

        end
    end
    errorbar(vector_size_de_grano_x,vector_r_promP,vector_r_promD,'LineWidth',1.5,'Color','r','Marker','o','MarkerFaceColor','k','MarkerSize',3,'MarkerEdgeColor','k','CapSize',8,'DisplayName','Media ± D. E.');
    hold off

    legend('show','Location','bestoutside');
    % Se etiquetan los ejes con las magnitudes correspondientes.
    xlabel('α/λ','FontWeight','bold');
    ylabel('μ_R','FontWeight','bold');

    % Se aplica la configuración general definida para los ejes.
    configurar_ejes()

    % Se exporta la gráfica utilizando la resolución especificada.
    exportgraphics(fig_2,nombres_archivos{3},'Resolution',resolucion)

    % Se cierra la figura una vez exportada.
    close(fig_2)
   
    % Se crea una figura no visible para comparar el tiempo de cómputo
    % requerido por cada una de las simulaciones.
    fig_3 = figure('Visible',"off","Units", 'normalized', 'Position', [0, 0, 1, 1]);

    % Se representa el tiempo de ejecución en función del número de
    % simulación.
    hold on
    for j=1:numero_de_series
        if j == 1
            plot(vector_pruebas,vector_tiempo(j,:),'LineWidth',1,'Color',[0.75 0.75 0.75],'Marker','none','MarkerFaceColor','k','MarkerSize',3,'MarkerEdgeColor','k','DisplayName','Series de simulaciones');

        else
            plot(vector_pruebas,vector_tiempo(j,:),'LineWidth',1,'Color',[0.75 0.75 0.75],'Marker','none','MarkerFaceColor','k','MarkerSize',3,'MarkerEdgeColor','k','HandleVisibility','off');

        end
    end
    errorbar(vector_pruebas,vector_tiempoP,vector_tiempoD,'LineWidth',1.5,'Color','r','Marker','o','MarkerFaceColor','k','MarkerSize',3,'MarkerEdgeColor','k','CapSize',8,'DisplayName','Media ± D. E.');
    hold off

    legend('show','Location','bestoutside');
    % Se etiquetan los ejes con el número de simulación y el tiempo de
    % ejecución expresado en minutos.
    xlabel('Simulación','FontWeight','bold');
    ylabel('t [min]','FontWeight','bold');

    % La siguiente instrucción permite agregar un título a la gráfica.
    % title('Tiempo de ejecución de las simulaciones');

    % Se aplica la configuración general definida para los ejes.
    configurar_ejes()

    % Se exporta la gráfica utilizando la resolución especificada.
    exportgraphics(fig_3,nombres_archivos{1},'Resolution',resolucion)

    % Se cierra la figura una vez exportada.
    close(fig_3)

    % % Se crea una figura no visible destinada a representar la evolución
    % % de la potencia óptica a lo largo de la propagación.
    % fig_4 = figure('Visible',"off",'Units','normalized','Position',[0, 0, 1, 1]);
    % 
    % % Se representa la potencia óptica normalizada en función de la
    % % distancia de propagación, expresada en unidades de la distancia focal.
    % plot(vector_size_de_grano_x,vector_psi,'Color','r','Marker','o','MarkerSize',3,'MarkerFaceColor','k','MarkerEdgeColor','k','LineWidth',3);
    % 
    % % Se etiqueta el eje horizontal mediante la distancia de propagación
    % % normalizada respecto a la distancia focal.
    % xlabel('α/λ','FontWeight','bold');
    % 
    % % Se etiqueta el eje vertical con la potencia óptica normalizada.
    % ylabel('ψ','FontWeight','bold');
    % 
    % % Se aplica la configuración general definida para los ejes.
    % configurar_ejes()
    % 
    % % Se exporta la gráfica de la potencia óptica normalizada utilizando
    % % una resolución igual al valor de la variable resolucion.
    % exportgraphics(fig_4,nombres_archivos{9},'Resolution',resolucion);
    % 
    % % Se cierra la figura una vez exportada.
    % close(fig_4)

    % Se crea una figura no visible destinada a representar la evolución
    % de la potencia óptica a lo largo de la propagación.
    fig_5 = figure('Visible',"off",'Units','normalized','Position',[0, 0, 1, 1]);

    % Se representa la potencia óptica normalizada en función de la
    % distancia de propagación, expresada en unidades de la distancia focal.
    hold on
    for j=1:numero_de_series
        if j == 1
            plot(vector_size_de_grano_x,vector_A05(j,:),'LineWidth',1,'Color',[0.75 0.75 0.75],'Marker','none','MarkerFaceColor','k','MarkerSize',3,'MarkerEdgeColor','k','DisplayName','Series de simulaciones');

        else
            plot(vector_size_de_grano_x,vector_A05(j,:),'LineWidth',1,'Color',[0.75 0.75 0.75],'Marker','none','MarkerFaceColor','k','MarkerSize',3,'MarkerEdgeColor','k','HandleVisibility','off');

        end
    end
    errorbar(vector_size_de_grano_x,vector_A05P,vector_A05D,'LineWidth',1.5,'Color','r','Marker','o','MarkerFaceColor','k','MarkerSize',3,'MarkerEdgeColor','k','CapSize',8,'DisplayName','Media ± D. E.');
    hold off

    legend('show','Location','bestoutside');

    % Se etiqueta el eje horizontal mediante la distancia de propagación
    % normalizada respecto a la distancia focal.
    xlabel('α/λ','FontWeight','bold');

    % Se etiqueta el eje vertical con la potencia óptica normalizada.
    ylabel('A_{0.5}/λ^2','FontWeight','bold');

    % Se aplica la configuración general definida para los ejes.
    configurar_ejes()
    
    % Se exporta la gráfica de la potencia óptica normalizada utilizando
    % una resolución igual al valor de la variable resolucion.
    exportgraphics(fig_5,nombres_archivos{4},'Resolution',resolucion);

    % Se cierra la figura una vez exportada.
    close(fig_5)

    % Se crea una figura no visible destinada a representar la evolución
    % de la potencia óptica a lo largo de la propagación.
    fig_6 = figure('Visible',"off",'Units','normalized','Position',[0, 0, 1, 1]);

    % Se representa la potencia óptica normalizada en función de la
    % distancia de propagación, expresada en unidades de la distancia focal.
    hold on
    for j=1:numero_de_series
        if j == 1
            plot(vector_size_de_grano_x,vector_numero_de_maximos(j,:),'LineWidth',1,'Color',[0.75 0.75 0.75],'Marker','none','MarkerFaceColor','k','MarkerSize',3,'MarkerEdgeColor','k','DisplayName','Series de simulaciones');

        else
            plot(vector_size_de_grano_x,vector_numero_de_maximos(j,:),'LineWidth',1,'Color',[0.75 0.75 0.75],'Marker','none','MarkerFaceColor','k','MarkerSize',3,'MarkerEdgeColor','k','HandleVisibility','off');

        end
    end
    errorbar(vector_size_de_grano_x,vector_numero_de_maximosP,vector_numero_de_maximosD,'LineWidth',1.5,'Color','r','Marker','o','MarkerFaceColor','k','MarkerSize',3,'MarkerEdgeColor','k','CapSize',8,'DisplayName','Media ± D. E.');
    hold off

    legend('show','Location','bestoutside');

    % Se etiqueta el eje horizontal mediante la distancia de propagación
    % normalizada respecto a la distancia focal.
    xlabel('α/λ','FontWeight','bold');

    % Se etiqueta el eje vertical con la potencia óptica normalizada.
    ylabel('ρL^2','FontWeight','bold');

    % Se aplica la configuración general definida para los ejes.
    configurar_ejes()

    % Se exporta la gráfica de la potencia óptica normalizada utilizando
    % una resolución igual al valor de la variable resolucion.
    exportgraphics(fig_6,nombres_archivos{5},'Resolution',resolucion);

    % Se cierra la figura una vez exportada.
    close(fig_6)

    % Se crea una figura no visible destinada a representar la evolución
    % de la potencia óptica a lo largo de la propagación.
    fig_7 = figure('Visible',"off",'Units','normalized','Position',[0, 0, 1, 1]);

    % Se representa la potencia óptica normalizada en función de la
    % distancia de propagación, expresada en unidades de la distancia focal.
    hold on
    for j=1:numero_de_series
        if j == 1
            plot(vector_size_de_grano_x,vector_RCM(j,:),'LineWidth',1,'Color',[0.75 0.75 0.75],'Marker','none','MarkerFaceColor','k','MarkerSize',3,'MarkerEdgeColor','k','DisplayName','Series de simulaciones');

        else
            plot(vector_size_de_grano_x,vector_RCM(j,:),'LineWidth',1,'Color',[0.75 0.75 0.75],'Marker','none','MarkerFaceColor','k','MarkerSize',3,'MarkerEdgeColor','k','HandleVisibility','off');

        end
    end
    errorbar(vector_size_de_grano_x,vector_RCMP,vector_RCMD,'LineWidth',1.5,'Color','r','Marker','o','MarkerFaceColor','k','MarkerSize',3,'MarkerEdgeColor','k','CapSize',8,'DisplayName','Media ± D. E.');
    hold off

    legend('show','Location','bestoutside');

    % Se etiqueta el eje horizontal mediante la distancia de propagación
    % normalizada respecto a la distancia focal.
    xlabel('α/λ','FontWeight','bold');

    % Se etiqueta el eje vertical con la potencia óptica normalizada.
    ylabel('r_{cm}','FontWeight','bold');

    % Se aplica la configuración general definida para los ejes.
    configurar_ejes()

    % Se exporta la gráfica de la potencia óptica normalizada utilizando
    % una resolución igual al valor de la variable resolucion.
    exportgraphics(fig_7,nombres_archivos{6},'Resolution',resolucion);

    % Se cierra la figura una vez exportada.
    close(fig_7)

    % Se crea una figura no visible destinada a representar la evolución
    % de la potencia óptica a lo largo de la propagación.
    fig_8 = figure('Visible',"off",'Units','normalized','Position',[0, 0, 1, 1]);

    % Se representa la potencia óptica normalizada en función de la
    % distancia de propagación, expresada en unidades de la distancia focal.
    hold on
    for j=1:numero_de_series
        if j == 1
            plot(vector_size_de_grano_x,vector_RGRAD(j,:),'LineWidth',1,'Color',[0.75 0.75 0.75],'Marker','none','MarkerFaceColor','k','MarkerSize',3,'MarkerEdgeColor','k','DisplayName','Series de simulaciones');

        else
            plot(vector_size_de_grano_x,vector_RGRAD(j,:),'LineWidth',1,'Color',[0.75 0.75 0.75],'Marker','none','MarkerFaceColor','k','MarkerSize',3,'MarkerEdgeColor','k','HandleVisibility','off');

        end
    end
    errorbar(vector_size_de_grano_x,vector_RGRADP,vector_RGRADD,'LineWidth',1.5,'Color','r','Marker','o','MarkerFaceColor','k','MarkerSize',3,'MarkerEdgeColor','k','CapSize',8,'DisplayName','Media ± D. E.');
    hold off

    legend('show','Location','bestoutside');

    % Se etiqueta el eje horizontal mediante la distancia de propagación
    % normalizada respecto a la distancia focal.
    xlabel('α/λ','FontWeight','bold');

    % Se etiqueta el eje vertical con la potencia óptica normalizada.
    ylabel('r_{∇}λ','FontWeight','bold');

    % Se aplica la configuración general definida para los ejes.
    configurar_ejes()

    % Se exporta la gráfica de la potencia óptica normalizada utilizando
    % una resolución igual al valor de la variable resolucion.
    exportgraphics(fig_8,nombres_archivos{7},'Resolution',resolucion);

    % Se cierra la figura una vez exportada.
    close(fig_8)

    % Se crea una figura no visible destinada a representar la evolución
    % de la potencia óptica a lo largo de la propagación.
    fig_9 = figure('Visible',"off",'Units','normalized','Position',[0, 0, 1, 1]);

    % Se representa la potencia óptica normalizada en función de la
    % distancia de propagación, expresada en unidades de la distancia focal.
    hold on
    for j=1:numero_de_series
        if j == 1
            plot(vector_size_de_grano_x,vector_LEC(j,:),'LineWidth',1,'Color',[0.75 0.75 0.75],'Marker','none','MarkerFaceColor','k','MarkerSize',3,'MarkerEdgeColor','k','DisplayName','Series de simulaciones');

        else
            plot(vector_size_de_grano_x,vector_LEC(j,:),'LineWidth',1,'Color',[0.75 0.75 0.75],'Marker','none','MarkerFaceColor','k','MarkerSize',3,'MarkerEdgeColor','k','HandleVisibility','off');

        end
    end
    errorbar(vector_size_de_grano_x,vector_LECP,vector_LECD,'LineWidth',1.5,'Color','r','Marker','o','MarkerFaceColor','k','MarkerSize',3,'MarkerEdgeColor','k','CapSize',8,'DisplayName','Media ± D. E.');
    hold off

    legend('show','Location','bestoutside');
    % Se etiqueta el eje horizontal mediante la distancia de propagación
    % normalizada respecto a la distancia focal.
    xlabel('α/λ','FontWeight','bold');

    % Se etiqueta el eje vertical con la potencia óptica normalizada.
    ylabel('l_{ec}/λ','FontWeight','bold');

    % Se aplica la configuración general definida para los ejes.
    configurar_ejes()

    % Se exporta la gráfica de la potencia óptica normalizada utilizando
    % una resolución igual al valor de la variable resolucion.
    exportgraphics(fig_9,nombres_archivos{8},'Resolution',resolucion);

    % Se cierra la figura una vez exportada.
    close(fig_9)

end