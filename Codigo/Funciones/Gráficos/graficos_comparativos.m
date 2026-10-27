function graficos_comparativos(filename_25,filename_21,filename_22,filename_23,filename_24,filename_15,filename_9,filename_10,filename_8,resolucion,numero_de_simulaciones,ruta_de_carpeta_de_simulaciones)

    % Se genera un vector que identifica cada una de las simulaciones
    % realizadas.
    vector_pruebas = 1:numero_de_simulaciones;

    % Se inicializan los vectores destinados a almacenar los parámetros y
    % resultados obtenidos en cada simulación.
    vector_radios = zeros(1,numero_de_simulaciones);
    vector_grosor = zeros(1,numero_de_simulaciones);
    vector_size_de_grano_x = zeros(1,numero_de_simulaciones);
    vector_p_prom = zeros(1,numero_de_simulaciones);
    vector_r_prom = zeros(1,numero_de_simulaciones);
    vector_A05 = zeros(1,numero_de_simulaciones);
    vector_psi = zeros(1,numero_de_simulaciones);
    vector_numero_de_maximos = zeros(1,numero_de_simulaciones);
    vector_RCM = zeros(1,numero_de_simulaciones);
    vector_RGRAD = zeros(1,numero_de_simulaciones);
    vector_LEC = zeros(1,numero_de_simulaciones);
    vector_tiempo = zeros(1,numero_de_simulaciones);
        
    % Se recorren las carpetas correspondientes a cada simulación para
    % recuperar los parámetros y resultados almacenados en sus archivos CSV.
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
        vector_p_prom(1,i) = datos(1,17);
        vector_r_prom(1,i) = datos(1,18);
        vector_A05(1,i) = datos(1,19);
        vector_psi(1,i) = datos(1,20);
        vector_numero_de_maximos(1,i) = datos(1,21);
        vector_RCM(1,i) = datos(1,22);
        vector_RGRAD(1,i) = datos(1,23);
        vector_LEC(1,i) = datos(1,24);
        vector_tiempo(1,i) = datos(1,25);
    
    end

    % Se crea una figura no visible para analizar el comportamiento de la
    % potencia óptica promedio en función del radio central R_0.
    fig_1 = figure('Visible',"off","Units", 'normalized', 'Position', [0, 0, 1, 1]);

    % Se representa la potencia óptica promedio obtenida durante la
    % propagación para cada valor del radio central.
    plot(vector_grosor,vector_p_prom,'LineWidth',3,'Color','r','Marker','o','MarkerFaceColor','k','MarkerSize',3,'MarkerEdgeColor','none');

    % Se etiquetan los ejes con las magnitudes correspondientes.
    xlabel('Ω/λ','FontWeight','bold');
    ylabel('μ_P','FontWeight','bold');

    % Se aplica la configuración general definida para los ejes.
    configurar_ejes()

    % Se exporta la gráfica utilizando la resolución especificada.
    exportgraphics(fig_1,filename_9,'Resolution',resolucion)

    % Se cierra la figura una vez exportada.
    close(fig_1)

    % Se crea una figura no visible para analizar el comportamiento del
    % coeficiente de correlación promedio en función del radio central R_0.
    fig_2 = figure('Visible',"off","Units", 'normalized', 'Position', [0, 0, 1, 1]);

    % Se representa el coeficiente de correlación promedio obtenido durante
    % la propagación para cada valor del radio central.
    plot(vector_grosor,vector_r_prom,'LineWidth',3,'Color','r','Marker','o','MarkerFaceColor','k','MarkerSize',3,'MarkerEdgeColor','none');
    hold on
    
    % Se etiquetan los ejes con las magnitudes correspondientes.
    xlabel('Ω/λ','FontWeight','bold');
    ylabel('μ_R','FontWeight','bold');

    % Se aplica la configuración general definida para los ejes.
    configurar_ejes()

    % Se exporta la gráfica utilizando la resolución especificada.
    exportgraphics(fig_2,filename_10,'Resolution',resolucion)

    % Se cierra la figura una vez exportada.
    close(fig_2)
   
    % Se crea una figura no visible para comparar el tiempo de cómputo
    % requerido por cada una de las simulaciones.
    fig_3 = figure('Visible',"off","Units", 'normalized', 'Position', [0, 0, 1, 1]);

    % Se representa el tiempo de ejecución en función del número de
    % simulación.
    plot(vector_pruebas,vector_tiempo,'LineWidth',3,'Color','r','Marker','o','MarkerFaceColor','k','MarkerSize',3,'MarkerEdgeColor','none');
    hold on

    % Se etiquetan los ejes con el número de simulación y el tiempo de
    % ejecución expresado en minutos.
    xlabel('Simulación','FontWeight','bold');
    ylabel('t [min]','FontWeight','bold');

    % La siguiente instrucción permite agregar un título a la gráfica.
    % title('Tiempo de ejecución de las simulaciones');

    % Se aplica la configuración general definida para los ejes.
    configurar_ejes()

    % Se exporta la gráfica utilizando la resolución especificada.
    exportgraphics(fig_3,filename_8,'Resolution',resolucion)

    % Se cierra la figura una vez exportada.
    close(fig_3)

    % % Se crea una figura no visible destinada a representar la evolución
    % % de la potencia óptica a lo largo de la propagación.
    % fig_4 = figure('Visible',"off",'Units','normalized','Position',[0, 0, 1, 1]);
    % 
    % % Se representa la potencia óptica normalizada en función de la
    % % distancia de propagación, expresada en unidades de la distancia focal.
    % plot(vector_grosor,vector_psi,'Color','r','Marker','o','MarkerSize',3,'MarkerFaceColor','k','MarkerEdgeColor','none','LineWidth',3);
    % 
    % % Se etiqueta el eje horizontal mediante la distancia de propagación
    % % normalizada respecto a la distancia focal.
    % xlabel('Ω/λ','FontWeight','bold');
    % 
    % % Se etiqueta el eje vertical con la potencia óptica normalizada.
    % ylabel('ψ','FontWeight','bold');
    % 
    % % Se aplica la configuración general definida para los ejes.
    % configurar_ejes()
    % 
    % % Se exporta la gráfica de la potencia óptica normalizada utilizando
    % % una resolución igual al valor de la variable resolucion.
    % exportgraphics(fig_4,filename_25,'Resolution',resolucion);
    % 
    % % Se cierra la figura una vez exportada.
    % close(fig_4)

    % Se crea una figura no visible destinada a representar la evolución
    % de la potencia óptica a lo largo de la propagación.
    fig_5 = figure('Visible',"off",'Units','normalized','Position',[0, 0, 1, 1]);

    % Se representa la potencia óptica normalizada en función de la
    % distancia de propagación, expresada en unidades de la distancia focal.
    plot(vector_grosor,vector_A05,'Color','r','Marker','o','MarkerSize',3,'MarkerFaceColor','k','MarkerEdgeColor','none','LineWidth',3);

    % Se etiqueta el eje horizontal mediante la distancia de propagación
    % normalizada respecto a la distancia focal.
    xlabel('Ω/λ','FontWeight','bold');

    % Se etiqueta el eje vertical con la potencia óptica normalizada.
    ylabel('A_{0.5}/λ^2','FontWeight','bold');

    % Se aplica la configuración general definida para los ejes.
    configurar_ejes()
    
    % Se exporta la gráfica de la potencia óptica normalizada utilizando
    % una resolución igual al valor de la variable resolucion.
    exportgraphics(fig_5,filename_15,'Resolution',resolucion);

    % Se cierra la figura una vez exportada.
    close(fig_5)

    % Se crea una figura no visible destinada a representar la evolución
    % de la potencia óptica a lo largo de la propagación.
    fig_6 = figure('Visible',"off",'Units','normalized','Position',[0, 0, 1, 1]);

    % Se representa la potencia óptica normalizada en función de la
    % distancia de propagación, expresada en unidades de la distancia focal.
    plot(vector_grosor,vector_numero_de_maximos,'Color','r','Marker','o','MarkerSize',3,'MarkerFaceColor','k','MarkerEdgeColor','none','LineWidth',3);

    % Se etiqueta el eje horizontal mediante la distancia de propagación
    % normalizada respecto a la distancia focal.
    xlabel('Ω/λ','FontWeight','bold');

    % Se etiqueta el eje vertical con la potencia óptica normalizada.
    ylabel('ρL^2','FontWeight','bold');

    % Se aplica la configuración general definida para los ejes.
    configurar_ejes()

    % Se exporta la gráfica de la potencia óptica normalizada utilizando
    % una resolución igual al valor de la variable resolucion.
    exportgraphics(fig_6,filename_21,'Resolution',resolucion);

    % Se cierra la figura una vez exportada.
    close(fig_6)

    % Se crea una figura no visible destinada a representar la evolución
    % de la potencia óptica a lo largo de la propagación.
    fig_7 = figure('Visible',"off",'Units','normalized','Position',[0, 0, 1, 1]);

    % Se representa la potencia óptica normalizada en función de la
    % distancia de propagación, expresada en unidades de la distancia focal.
    plot(vector_grosor,vector_RCM,'Color','r','Marker','o','MarkerSize',3,'MarkerFaceColor','k','MarkerEdgeColor','none','LineWidth',3);

    % Se etiqueta el eje horizontal mediante la distancia de propagación
    % normalizada respecto a la distancia focal.
    xlabel('Ω/λ','FontWeight','bold');

    % Se etiqueta el eje vertical con la potencia óptica normalizada.
    ylabel('r_{cm}','FontWeight','bold');

    % Se aplica la configuración general definida para los ejes.
    configurar_ejes()

    % Se exporta la gráfica de la potencia óptica normalizada utilizando
    % una resolución igual al valor de la variable resolucion.
    exportgraphics(fig_7,filename_22,'Resolution',resolucion);

    % Se cierra la figura una vez exportada.
    close(fig_7)

    % Se crea una figura no visible destinada a representar la evolución
    % de la potencia óptica a lo largo de la propagación.
    fig_8 = figure('Visible',"off",'Units','normalized','Position',[0, 0, 1, 1]);

    % Se representa la potencia óptica normalizada en función de la
    % distancia de propagación, expresada en unidades de la distancia focal.
    plot(vector_grosor,vector_RGRAD,'Color','r','Marker','o','MarkerSize',3,'MarkerFaceColor','k','MarkerEdgeColor','none','LineWidth',3);

    % Se etiqueta el eje horizontal mediante la distancia de propagación
    % normalizada respecto a la distancia focal.
    xlabel('Ω/λ','FontWeight','bold');

    % Se etiqueta el eje vertical con la potencia óptica normalizada.
    ylabel('r_{∇}λ','FontWeight','bold');

    % Se aplica la configuración general definida para los ejes.
    configurar_ejes()

    % Se exporta la gráfica de la potencia óptica normalizada utilizando
    % una resolución igual al valor de la variable resolucion.
    exportgraphics(fig_8,filename_23,'Resolution',resolucion);

    % Se cierra la figura una vez exportada.
    close(fig_8)

    % Se crea una figura no visible destinada a representar la evolución
    % de la potencia óptica a lo largo de la propagación.
    fig_9 = figure('Visible',"off",'Units','normalized','Position',[0, 0, 1, 1]);

    % Se representa la potencia óptica normalizada en función de la
    % distancia de propagación, expresada en unidades de la distancia focal.
    plot(vector_grosor,vector_LEC,'Color','r','Marker','o','MarkerSize',3,'MarkerFaceColor','k','MarkerEdgeColor','none','LineWidth',3);

    % Se etiqueta el eje horizontal mediante la distancia de propagación
    % normalizada respecto a la distancia focal.
    xlabel('Ω/λ','FontWeight','bold');

    % Se etiqueta el eje vertical con la potencia óptica normalizada.
    ylabel('l_{ec}/λ','FontWeight','bold');

    % Se aplica la configuración general definida para los ejes.
    configurar_ejes()

    % Se exporta la gráfica de la potencia óptica normalizada utilizando
    % una resolución igual al valor de la variable resolucion.
    exportgraphics(fig_9,filename_24,'Resolution',resolucion);

    % Se cierra la figura una vez exportada.
    close(fig_9)

end