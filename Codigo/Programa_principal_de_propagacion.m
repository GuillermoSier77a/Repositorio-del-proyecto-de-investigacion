% PROGRAMA PRINCIPAL DE SIMULACIÓN Y ANÁLISIS DE PROPAGACIÓN ÓPTICA

% Este programa simula la propagación de distintos campos ópticos mediante
% el método de la función de transferencia de Fresnel a través de un sistema
% que incluye una lente positiva. Durante la propagación se calcula la
% distribución transversal de irradiancia y la potencia óptica en cada
% plano, así como el coeficiente de correlación de Pearson con respecto al
% patrón de irradiancia obtenido en el plano de Fourier de la lente.

% A partir del patrón de irradiancia en el plano de Fourier se calcula su
% autocorrelación espacial y se obtienen parámetros característicos de su
% estructura. Asimismo, se realiza un análisis mediante filtrado pasa bandas
% basado en diferencias de gaussianas (DoG).

% El programa genera un video de la evolución del patrón de irradiancia y
% su perfil transversal durante la propagación, además de las gráficas
% correspondientes a los campos, la potencia y la autocorrelación.

% Para cada simulación se generan archivos TXT y CSV que funcionan como
% bitácora, en los cuales se almacenan los parámetros de propagación y los
% resultados numéricos obtenidos. Cuando se realizan múltiples simulaciones,
% el programa analiza conjuntamente los resultados y genera gráficas
% comparativas.

%--------------------------------------------------------------------------

% Cerramos todas las figuras, vaciamos el workspace y depuramos la
% ventana de comando.
close all; clear; clc;

% Añadimos al path de MATLAB la carpeta "Funciones" y todos sus
% subdirectorios para permitir el acceso a las funciones auxiliares.
addpath(genpath(fullfile(pwd,'Funciones')));

% Iniciamos el cronómetro para medir el tiempo total de ejecución.
tic_nucleo = tic;

% Número de simulaciones que se realizarán
numero_de_series = 50; % 50

% Número de simulaciones que se realizarán
numero_de_simulaciones = 40; %40

% Variable que indica si las condiciones de la simulación son válidas
validez = 1;

% Ruta principal donde se almacenarán todos los resultados
nombre_de_la_carpeta = 'Diferentes tamaños de grano (anillo)';
ruta_nucleo = fullfile(fileparts(fileparts(matlab.desktop.editor.getActiveFilename)),nombre_de_la_carpeta);

% Si la carpeta ya existe, eliminarla junto con todo su contenido
% Esto permite comenzar cada ejecución con una carpeta de resultados limpia
if isfolder(ruta_nucleo)
    rmdir(ruta_nucleo,'s');   % 's' = elimina la carpeta y todo lo que contiene
end

for j = 1:numero_de_series

    % Iniciamos el cronómetro para medir el tiempo total de ejecución.
    tic_total = tic;

    disp(['Serie ',num2str(j),'/',num2str(numero_de_series),'.'])
    
    ruta_base = fullfile(ruta_nucleo,sprintf('Serie %d',j));
    mkdir(ruta_base);

    % Ruta donde se crearán las carpetas individuales de cada simulación
    ruta_de_carpeta_de_simulaciones = fullfile(ruta_base,'Simulaciones');

    % -------------------------------------------------------------------------
    % Bucle principal: se ejecuta una simulación por cada valor de i
    % -------------------------------------------------------------------------
    
    for i = 1:numero_de_simulaciones
    
        % Iniciamos un cronómetro para medir el tiempo de la simulación
        tic;
    
        % Número identificador de la simulación actual
        num_prueba = i;
    
        % Creación de la carpeta
    
        % Se crea una carpeta independiente para almacenar los resultados
        % correspondientes a la simulación actual
        ruta = fullfile(ruta_de_carpeta_de_simulaciones,sprintf('Simulación %d',num_prueba));
        mkdir(ruta);
    
        % Nombre de los archivos
    
        % Gráfica de validación.
        % filename_0 = fullfile(ruta,'Validación de la propagación.png');
    
        % Gráfica de la potencia normalizada.
        filename_1 = fullfile(ruta,'Evolución de la potencia óptica.png');
    
        % Gráfica de los coeficientes de correlación promedio.
        filename_2 = fullfile(ruta,'Evolución de la invariancia.png');
    
        % Gráficas relacionadas con la autocorrelación
        filename_3_0 = fullfile(ruta,'Perfil de autocorrelación.png');
    
        filename_3_1 = fullfile(ruta,'Curvas de nivel de la autocorrelación.png');
    
        filename_3_2 = fullfile(ruta,'Curvas promediadas.png');
        
        % Archivo GIF.
        % filename_4 = fullfile(ruta,'Propagación.gif');
    
        % Archivo TXT con los parámetros y resultados utilizados en la simulación.
        filename_5 = fullfile(ruta,'Parámetros y resultados de propagación.txt');
    
        % Archivo CSV con los parámetros y resultados utilizados en la simulación.
        filename_6 = fullfile(ruta,'Parámetros y resultados de propagación.csv');
    
        % Archivo CSV con las áreas de las curvas de nivel.
        filename_7 = fullfile(ruta,'Datos para superficie.csv');
    
        % Gráfica del tiempo de cómputo.
        filename_8 = fullfile(ruta_base,'Tiempo de cómputo.png');
    
        % Gráfica de la evolución de la potencia promedio normalizada.
        filename_9 = fullfile(ruta_base,'Evolución de potencias promedio.png');
    
        % Gráfica de la evolución de los coeficientes de correlación promedio.
        filename_10 = fullfile(ruta_base,'Evolución de coeficientes de correlación promedio.png');
    
        % Gráfica del campo inicial.
        filename_11 = fullfile(ruta,'Campo inicial.png');
    
        % Gráfica del campo en el plano de Fourier.
        filename_12 = fullfile(ruta,'Campo en el plano de Fourier.png');
    
        % Gráfica del campo en el plano de la lente.
        filename_13 = fullfile(ruta,'Campo en el plano de la lente.png');
    
        % Gráfica del campo en z=3f.
        filename_14 = fullfile(ruta,'Campo en z=3f.png');
    
        % Gráfica de la evolución de los anchos de los picos.
        filename_15 = fullfile(ruta_base,'Evolución de A_{0.5}.png');
    
        % Gráfica de la superficie.
        % filename_16 = fullfile(ruta_base,'Superficie.png');
    
        % Gráfica de hiperuniformidad.
        % filename_17 = fullfile(ruta,'var(r).png');
    
        % Gráficas que tienen que ver con la envolvente.
        filename_18_1 = fullfile(ruta,'Perfil de irradiancia.png');
    
        filename_18_2 = fullfile(ruta,'Perfil de irradiancia sin envolvente.png');
    
        filename_18_3 = fullfile(ruta,'Envolvente.png');
    
        % Gráfica de la respuesta del filtro máxima.
        % filename_19 = fullfile(ruta,'Filtro máximo.png');
    
        % Gráfica de la irradiancia en el plano de Fourier.
        % filename_20 = fullfile(ruta,'Perfil de irradiancia en el plano de Fourier.png');
    
        % Gráfica del número de fluctuaciones.
        filename_21 = fullfile(ruta_base,'Número de fluctuaciones.png');
    
        % Gráfica de la r_{cm}.
        filename_22 = fullfile(ruta_base,'r_{cm}.png');
    
        % Gráfica de la r_{∇}.
        filename_23 = fullfile(ruta_base,'r_{∇}.png');
    
        % Gráfica de la l_{ec}.
        filename_24 = fullfile(ruta_base,'l_{ec}.png');
    
        % Gráfica de la evolución de ψ.
        filename_25 = fullfile(ruta_base,'Evolución de ψ.png');
    
        % Nombre del archivo de video donde se almacenará la propagación.
        video_filename = fullfile(ruta,'Video de propagación.mp4');
    
        % Estilo-------------------------------------------------------------------
    
        % Seleccionamos el mapa de colores que se utilizará en las gráficas
        estilo = 'parula';                            
    
        % Resolución utilizada posteriormente para guardar las gráficas
        resolucion = 300;
    
        % Lente--------------------------------------------------------------------
    
        % Distancia focal de la lente [cm]
        distancia_focal = 15; 
    
        % Radio de la pupila circular [cm]
        r_pupila = 2.54/2;     
    
        % Fuente de luz------------------------------------------------------------
    
        % Longitud de onda de la fuente de luz [cm]
        lambda = 532*10^-7;   
    
        % Número de onda
        k = 2*pi/lambda;       
    
        % Parámetros de propagación------------------------------------------------
    
        % Selección del tipo de propagación:
    
        % 1 = propagación paralela
        % 2 = propagación transversal
    
        propagacion = 1;   
    
        % -------------------------------------------------------------------------
        % Parámetros para propagación paralela
        % -------------------------------------------------------------------------
        if propagacion == 1
    
            % Tamaño total de la ventana de cálculo [cm]
            L = 1.5;
    
            % Ancho del intervalo de muestreo
            dx = 6.8313e-04; 
    
            % Número de muestras espaciales en cada dirección
            M = round(L/dx);
    
            % Número de frames de propagación (debe ser múltiplo de 3)
            numero_de_frames = 6*3;
    
            % Distancia máxima de propagación [cm]
            z_max = 3*distancia_focal;
    
            % % Distancia de Rayleigh
            % z_R = (k*0.1^2)/2;
            % % Distancia máxima de propagación [cm]
            % z_max = 4.8*z_R;         
    
            % Tamaño de paso de propagación
            paso_z = z_max/numero_de_frames;                                     
    
            % Vector de coordenadas espaciales para los ejes x y y
            x = ((0:M-1)-floor(M/2))*dx;
    
            x_norm = x/lambda;
            
            % Índice correspondiente aproximadamente al centro de la matriz
            ordenada = floor(M/2)+1;
            
            % Vector de posiciones de propagación en z
            vector_z = 0:paso_z:z_max;
            
            % Crear una ventana de Tukey para reducir efectos de borde
            w = single(tukeywin(M,0.1));
            
            % Construir la ventana bidimensional a partir del producto exterior
            soporte = w*w.';
    
            clear w
            
            % Se calcula la función de transferencia de Fresnel
            H = funcion_de_transferencia_de_Fresnel(M,L,lambda,paso_z);
    
            % -------------------------------------------------------------------------
            % Índice de la lente, el plano focal y en z=3f
            % -------------------------------------------------------------------------
    
            % Encontramos el índice del elemento de vector_z más cercano a la
            % posición de la lente
            [~,posicion_de_la_lente] = min(abs(vector_z - distancia_focal));
    
            % Encontramos el índice del elemento de vector_z más cercano al plano
            % de Fourier, situado a una distancia 2f
            [~,posicion_del_plano_de_Fourier] = min(abs(vector_z - 2*distancia_focal));
    
            % Encontramos el índice del elemento de vector_z más cercano a la
            % posición 3f
            [~,posicion_3f] = min(abs(vector_z - 3*distancia_focal));
    
        % -------------------------------------------------------------------------
        % Parámetros para propagación transversal
        % -------------------------------------------------------------------------
        elseif propagacion == 2
            % Pendiente.
        end
        
        % Elección del campo a propagar--------------------------------------------
            
        % Lista de campos disponibles:
        
        % 1 = Haz gaussiano.
        % 2 = Anillo gaussiano con difusor.
        % 3 = Rejilla de fase sinusoidal (problema de la tarea 3)
        % 4 = Rejilla de amplitud horizontal
        % 5 = Haz Bessel
        % 6 = Haz Mathieu
        % 7 = Haz Weber
        % 8 = Deltas simétricas.
        % 9 = Deltas asimétricas
        % 10 = Vórtice
        % 11 = Haz gaussiano con difusor
    
        % Seleccionar el tipo de campo inicial
        campo_propagado = 2;
        
        switch campo_propagado
        
            %----------------------------------------------------------------------
            case 1  % Haz gaussiano
            %----------------------------------------------------------------------
        
                % Radio de la cintura del haz [cm]
                w_0 = 1/10;
    
                radio_exterior = w_0;
                size_grano_del_difusor_x = NaN;
                size_grano_del_difusor_y = NaN;
                R_0 = NaN;
                grosor = NaN;
                num_granos = NaN;
                ang_mayor = NaN;
                ang_menor = NaN;
    
                % Amplitud del campo
                amplitud = 1;
        
                % Generar el campo gaussiano
                [u1] = haz_gaussiano_exp(x,w_0,amplitud);
    
            %----------------------------------------------------------------------
            case 2  % Anillo gaussiano con difusor
            %----------------------------------------------------------------------
        
                % Número de granos utilizados para generar el difusor
                % num_granos = round(M*i/numero_de_simulaciones); % NO UNIFORME
                num_granos = round((max(x)-min(x))/(i*dx)+1); % UNIFORME
                % num_granos = M/2;
    
                % Número de granos en las direcciones x y y
                % num_granos_x = 2^11;
                % num_granos_y = 2^11;
        
                % Radio central del anillo gaussiano [cm]
                % radi = linspace(0.0100,0.3,numero_de_simulaciones);
                % radi = linspace(0,0.05-2*dx,numero_de_simulaciones); % Transición
                % R_0 = radi(i);
                R_0 = 0.05;
    
                % Desviación estándar del anillo gaussiano [cm]
                sigma = 4*dx;
                % anchos = linspace(2*dx,R_0,numero_de_simulaciones);
                % sigma = anchos(i);
    
                % Amplitud del campo
                amplitud = 1;
        
                % Límites angulares del difusor
                ang_mayor = 2*pi;
                ang_menor = 0;
    
                % if num_prueba == 1
                %     [fase_del_difusor, size_grano_del_difusor] = difusor(ang_mayor,ang_menor,x,num_granos);
                % end
    
                [fase_del_difusor, size_grano_del_difusor] = difusor(ang_mayor,ang_menor,x,num_granos);
    
                size_grano_del_difusor_x = size_grano_del_difusor;
                size_grano_del_difusor_y = size_grano_del_difusor;
    
                % Generar el anillo gaussiano con difusor
                [u1, grosor, radio_exterior] = anillo_con_difusor(fase_del_difusor,x,sigma,amplitud,R_0);
               
                % Transición
                % radio_exterior = 0.05;
                % [u1, grosor, R_0, sigma] = U_0_anillo_con_difusor_sharp(x,fase_del_difusor,radio_exterior,amplitud,R_0);
                % R_0 = radio_exterior; % solo en la serie diferentes radios (haz)

                % Alternativa para utilizar granos rectangulares
                % [u1, grosor] = U_0_anillo_con_difusor_granos_rectangulares(ang_mayor,ang_menor,x,sigma,amplitud,num_granos_x,num_granos_y,R_0);
    
                %disp(' ')
                %disp('¡Espera! Estoy haciéndote la vida más fácil.')
                %disp(' ')

                I_rapida = u1;
    
                FT_lente = lente(x,distancia_focal,k,r_pupila);
    
                for g = 1:posicion_del_plano_de_Fourier
                    if g ~= 1
                        I_rapida = I_rapida.*soporte;
                        I_rapida = propTF(I_rapida,H);
                    end
    
                    if g == posicion_de_la_lente
                        I_rapida = I_rapida.*FT_lente;
                    end
                end
    
                I_rapida = single(abs(I_rapida).^2);
    
            %----------------------------------------------------------------------
            case 3  % Rejilla de fase sinusoidal
            %----------------------------------------------------------------------
        
                % Diámetro de la pupila [cm]
                D = 1;
        
                % Distancia focal de la lente [cm]
                f = 100;
        
                % Parámetro Delta [cm]
                Delta = 1;
        
                % Posición característica [cm]
                X = 0.01;
        
                % Generar la rejilla de fase sinusoidal
                u1 = fase_sinusoidal(x,Delta,X);
    
            %----------------------------------------------------------------------
            case 4  % Rejilla de amplitud horizontal
            %----------------------------------------------------------------------
        
                % Número de franjas
                N = 30;
        
                % Separación entre las franjas [cm]
                Lambda = L/(magnificacion*N);
        
                % Grosor de las franjas [cm]
                X = Lambda/2;
        
                % Generar la rejilla de amplitud horizontal
                u1 = rejilla_horizontal(x,X,Lambda,N,L/magnificacion);
        
            %----------------------------------------------------------------------
            case 5  % Haz Bessel
            %----------------------------------------------------------------------
        
                % Radio central del anillo [cm]
                R_0 = 0.05;
        
                % Desviación estándar del anillo [cm]
                sigma = 20*10^-4;
        
                % Amplitud del campo
                amplitud = 1;
        
                % Generar el campo tipo Bessel
                u1 = haz_bessel(x,sigma,amplitud,R_0);
        
            %----------------------------------------------------------------------
            case 6  % Haz Mathieu
            %----------------------------------------------------------------------
        
                % Radio central del anillo [cm]
                R_0 = 0.1;
        
                % Desviación estándar del anillo [cm]
                sigma = 0.001;
        
                % Amplitud del campo
                amplitud = 1;
        
                % Parámetros del haz de Mathieu
                m = 10;
                q = 20;
        
                % Generar el campo tipo Mathieu
                [u1, grosor] = haz_mathieu(x,sigma,amplitud,R_0,m,q);
        
            %----------------------------------------------------------------------
            case 7  % Haz Weber
            %----------------------------------------------------------------------
        
                % Radio central del anillo [cm]
                R_0 = 0.1;
        
                % Desviación estándar del anillo [cm]
                sigma = 0.001;
        
                % Amplitud del campo
                amplitud = 1;
        
                % Parámetro del haz de Weber
                a = 20;
        
                % Generar el campo tipo Weber
                [u1, grosor] = haz_weber(x,sigma,amplitud,R_0,a);
        
            %----------------------------------------------------------------------
            case 8  % Deltas simétricas
            %----------------------------------------------------------------------
        
                % Radio central del anillo [cm]
                R_0 = 0.05;
        
                % Desviación estándar del anillo
                sigma = (10)*10^-4;
        
                % Amplitud del campo
                amplitud = 1;
        
                % Número de deltas
                N = 6;
        
                % Grosor angular de cada delta [rad]
                dphi = (1.5*i)*pi/180;
    
                % Generar el campo con deltas simétricas
                [u1, grosor, radio_exterior] = deltas_simetricas(x,sigma,amplitud,R_0,dphi,N);
                size_grano_del_difusor_x = NaN;
                size_grano_del_difusor_y = NaN;
                num_granos = NaN;
                ang_mayor = NaN;
                ang_menor = NaN;
    
            %----------------------------------------------------------------------
            case 9  % Deltas asimétricas
            %----------------------------------------------------------------------
        
                % Radio central del anillo [cm]
                R_0 = 0.1;
        
                % Desviación estándar del anillo
                sigma = 0.001;
        
                % Amplitud del campo
                amplitud = 1;
        
                % Grosor angular de la delta [rad]
                dphi = 2*pi/180;
    
                % Número de deltas 
                N = 2*pi/180;
        
                % Generar el campo con deltas asimétricas
                [u1, grosor] = anillo_deltas_3(x,sigma,amplitud,R_0,dphi);
        
            %----------------------------------------------------------------------
            case 10  % Vórtice
            %----------------------------------------------------------------------
        
                % Radio central del anillo [cm]
                R_0 = 0.1;
        
                % Desviación estándar del anillo [cm]
                sigma = 0.001;
        
                % Amplitud del campo
                amplitud = 1;
        
                % Carga topológica o parámetro azimutal
                m = 5;
        
                % Generar el campo de vórtice
                u1 = anillo_vortices(x,sigma,amplitud,R_0,m);
        
            %----------------------------------------------------------------------
            case 11  % Haz gaussiano con difusor
            %----------------------------------------------------------------------
        
                % Número de granos utilizados en el difusor
                num_granos = 1000;
        
                % Número de granos en las direcciones x y y
                num_granos_x = 2^11;
                num_granos_y = 100*i;
        
                % Radio de la cintura del haz [cm]
                w_0 = 0.005*20;
        
                % Amplitud del campo
                amplitud = 1;
        
                % Límites angulares del difusor
                ang_mayor = 2*pi;
                ang_menor = 0;
        
                % Generar el haz gaussiano con difusor
                [u1] = haz_gaussiano_con_difusor(ang_mayor,ang_menor,x,amplitud,num_granos,w_0);
        
                % Alternativa para utilizar granos rectangulares
                
                % [u1] = haz_gaussiano_con_difusor_granos_rectuangulares(ang_mayor,ang_menor,x,amplitud,num_granos_x,num_granos_y,w_0);
        
            %----------------------------------------------------------------------
            otherwise
            %----------------------------------------------------------------------
        
                % Mostrar un error si se selecciona una opción inexistente
                error('El valor de campo_propagado debe estar entre 1 y 11.');
        
        end
    
        % Propagador---------------------------------------------------------------
    
        % Mostramos en la ventana de comandos el inicio de la simulación
        %disp(['Iniciando simulación ',num2str(num_prueba),'/',num2str(numero_de_simulaciones),'...'])
    
        % La ventana tiene que estar contenida en el cuadrado inscrito en la
        % pupila.
    
        % Además, el anillo debe ser suficientemente pequeño para estar
        % contenido en la ventana.
    
        % (L <= sqrt(2)*r_pupila) && (2*radio_exterior <= L)
    
        if (L <= sqrt(2)*r_pupila) && (2*radio_exterior <= L)
    
            % Reproduce el sonido asociado al inicio de una simulación válida
            % tono
    
            %disp(' ')
            %disp('Se han satisfecho los criterios de muestreo.')
            %disp(' ')
    
            % % Creamos el objeto encargado de generar el video
            % video = VideoWriter(video_filename,'MPEG-4');
            % 
            % % Número de cuadros por segundo del video (fps)
            % video.FrameRate = 5;                            
            % 
            % % Calidad del video
            % calidad_de_video = 100;
            % video.Quality = calidad_de_video;
            % 
            % % Abrimos el archivo de video para comenzar a escribir frames
            % open(video);
            % 
            % % ---------------------------------------------------------------------
            % % Esqueleto del video
            % % ---------------------------------------------------------------------
            % 
            % % Creamos una figura invisible que contendrá la animación
            % fig = figure('Visible',"off","Units", 'pixels', 'Position', [100, 100, 1600, 800]);
            % 
            % % Dividimos la figura en dos paneles
            % tl = tiledlayout(fig,1,2, 'TileSpacing','compact', 'Padding','compact');
            % 
            % % ---------------------------------------------------------------------
            % % Subfigura izquierda
            % % ---------------------------------------------------------------------
            % 
            % % Seleccionamos el primer panel
            % ax1 = nexttile(tl);
            % 
            % % Creamos una imagen inicialmente llena de ceros.
            % % Posteriormente CData será reemplazado por la irradiancia.
            % hImg = imagesc(ax1,x_norm,x_norm,zeros(M,'single'));
            % 
            % % Colocamos el eje y en orientación ascendente
            % set(ax1,'YDir','normal')
            % 
            % % Etiquetas de los ejes
            % xlabel(ax1,'x/λ','FontWeight','bold');
            % ylabel(ax1,'y/λ','FontWeight','bold');
            % 
            % % Aplicamos el mapa de colores
            % colormap(ax1,estilo)
            % 
            % % Creamos la barra de color
            % cb1 = colorbar(ax1);
            % ylabel(cb1,'I [u. a.]','FontWeight','bold')
            % 
            % % Tamaño de letra de los elementos de la gráfica
            % set(ax1,'FontSize',15,'FontWeight','bold')
            % 
            % % Mantenemos la misma escala en ambos ejes
            % axis(ax1,'equal')
            % 
            % % Ajustamos los límites a los datos
            % axis(ax1,'tight')
            % 
            % % Relación de aspecto cuadrada
            % pbaspect(ax1,[1 1 1])
            % 
            % % Título que será actualizado durante la propagación
            % t1 = title(ax1,'');
            % 
            % % ---------------------------------------------------------------------
            % % Subfigura derecha
            % % ---------------------------------------------------------------------
            % 
            % % Seleccionamos el segundo panel
            % ax2 = nexttile(tl);
            % 
            % % Creamos el perfil de irradiancia inicial.
            % % Posteriormente YData será actualizado en cada frame.
            % hPlot = plot(ax2,x_norm,zeros(size(x),'single'), 'LineWidth',1, 'Color','r');
            % 
            % % hold on
            % % 
            % % % Creamos el perfil de irradiancia teórico.
            % % % Posteriormente YData será actualizado en cada frame.
            % % hPlot_2 = plot(ax2,x_norm,zeros(size(x),'single'), 'LineWidth',3, 'Color','b','LineStyle','--');
            % % 
            % % legend(ax2,[hPlot,hPlot_2],{'Numérico','Analítico'},'Location','northwest');
            % 
            % % Etiqueta del eje horizontal
            % xlabel(ax2,'x/λ','FontWeight','bold');
            % ylabel(ax2,'I [u. a.]','FontWeight','bold')
            % 
            % % Tamaño de letra
            % set(ax2,'FontSize',15,'FontWeight','bold')
            % 
            % % Ajustamos los límites de la gráfica
            % axis(ax2,'tight')
            % 
            % % Relación de aspecto cuadrada
            % pbaspect(ax2,[1 1 1])
            % 
            % % Activamos cuadrícula principal y secundaria
            % grid(ax2,'on')
            % grid(ax2,'minor')
            % 
            % % Título que será actualizado durante la propagación
            % t2 = title(ax2,'');
    
            % ---------------------------------------------------------------------
            % Definición de variables auxiliares
            % ---------------------------------------------------------------------
    
            % % Vector donde se almacenará el CCP entre campo y la expresión analítica en cada z
            % comprobacion = zeros(1,length(vector_z));
    
            % Vector donde se almacenará la potencia total del campo en cada z
            Potencia = nan(1,length(vector_z));
    
            % Vector para almacenar la correlación con respecto al plano de Fourier
            pearson = nan(1,length(vector_z)-posicion_de_la_lente+1);
    
            % ---------------------------------------------------------------------
            % Propagación paralela
            % ---------------------------------------------------------------------
            if propagacion == 1
    
                % Recorremos todos los planos de propagación
                for g = 1:length(vector_z)
    
                    % Mostramos en pantalla el progreso de la simulación
                    %disp(['Frame ',num2str(g),'/',num2str(length(vector_z)),'.'])
    
                    % -------------------------------------------------------------
                    % Primer frame: campo inicial
                    % -------------------------------------------------------------
                    if g == 1
    
                        % Calculamos la irradiancia inicial:
                        I1 = single(abs(u1).^2); 
    
                        % % Actualizamos la imagen 2D
                        % set(hImg,'CData',I1);
    
                        % % Actualizamos el título indicando el frame y la posición z
                        % t1.String = sprintf(['Simulación ',num2str(num_prueba),' (z = 0)']);
                        % 
                        % % Mostramos el perfil horizontal correspondiente a la
                        % % fila central de la matriz
                        % set(hPlot,'YData',I1(ordenada,:));
                        % 
                        % % % Radio de curvatura del frente de onda
                        % % R_z = 0;
                        % % p_z = 0;
                        % % 
                        % % % Generar el campo gaussiano teórico
                        % % u1_teorico = haz_gaussiano_teorico(x,z_R,p_z,k,w_0,R_z);
                        % % 
                        % % % Calculamos la irradiancia inicial:
                        % % I1_teorico = single(abs(u1_teorico).^2); 
                        % % 
                        % % % Mostramos el perfil horizontal teórico
                        % % set(hPlot_2,'YData',I1_teorico(ordenada,:));
                        % % 
                        % % Campo_A = I1/sum(I1(:));
                        % % Campo_B = I1_teorico/sum(I1_teorico(:));
                        % % comprobacion(g) = corr2(Campo_A,Campo_B);
                        % 
                        % % Título del perfil
                        % t2.String = sprintf(['Simulación ',num2str(num_prueba),' (y = ',num2str(x(ordenada)),', z = 0)']);
                         
                        % Potencia total del campo inicial.
                        % La suma de la irradiancia se multiplica por dx^2,
                        % correspondiente al área de cada elemento de muestreo.
                        Potencia(g) = sum(I1,'all')*dx^2;
                         
                        %disp(' ')
                        %disp('Generando el gráfico del patrón de irradiancia en el plano fuente...')
                        %disp(' ')
    
                        % Generamos las gráficas de los campos ópticos en el plano fuente.
    
                        if j == -10
                            graficos_campo_fuente(resolucion,radio_exterior,lambda,estilo,I1,filename_11,num_prueba,x)
                        end

                        clear I1
    
                        % Descomentar la siguiente línea para generar un GIF:
                        % imwrite(A,map,filename_4,'gif','LoopCount',Inf,'DelayTime',0.2); % Frame 0
    
                    % -------------------------------------------------------------
                    % Frames posteriores: propagación del campo
                    % -------------------------------------------------------------
                    else
    
                        % Aplicamos la ventana de Tukey para reducir efectos de
                        % borde antes de realizar la siguiente propagación
                        u1 = u1.*soporte;
    
                        % Propagamos el campo una distancia paso_z utilizando
                        % la función de transferencia de Fresnel (H)
                        u1 = propTF(u1,H); 
    
                        % Calculamos la irradiancia del campo propagado
                        I1 = single(abs(u1).^2);      
    
                        % if g == posicion_de_la_lente
                        % 
                        %     %disp(' ')
                        %     %disp('Generando el gráfico del patrón de irradiancia en el plano de la lente...')
                        %     %disp(' ')
                        % 
                        %     % Generamos las gráficas de los campos ópticos en
                        %     % el plano de la lente.
                        %     % graficos_lente(resolucion,lambda,filename_13,estilo,I1,num_prueba,x);
                        % 
                        % elseif g == posicion_3f
                        % 
                        %     %disp(' ')
                        %     %disp('Generando el gráfico del patrón de irradiancia en z=3f...')
                        %     %disp(' ')
                        % 
                        %     % Generamos las gráficas de los campos ópticos en z=3f.
                        %     % graficos_z_3f(resolucion,lambda,estilo,filename_14,I1,num_prueba,x);
                        % 
                        % end
    
                        % % Actualizamos la imagen 2D
                        % set(hImg,'CData',I1); 
                        % 
                        % % Actualizamos el título
                        % t1.String = sprintf(['Simulación ',num2str(num_prueba),' (z = ',num2str(vector_z(g)/distancia_focal),'f)']);
                        % 
                        % % Actualizamos el perfil central de irradiancia
                        % set(hPlot,'YData',I1(ordenada,:));
                        % 
                        % % % Radio de curvatura del frente de onda
                        % % p_z = vector_z(g);
                        % % R_z = p_z*(1+(z_R/p_z)^2);
                        % % 
                        % % % Generar el campo gaussiano teórico
                        % % u1_teorico = haz_gaussiano_teorico(x,z_R,p_z,k,w_0,R_z);
                        % % 
                        % % % Calculamos la irradiancia inicial:
                        % % I1_teorico = single(abs(u1_teorico).^2); 
                        % % 
                        % % % Mostramos el perfil horizontal teórico
                        % % set(hPlot_2,'YData',I1_teorico(ordenada,:));
                        % % 
                        % % Campo_A = I1/sum(I1(:));
                        % % Campo_B = I1_teorico/sum(I1_teorico(:));
                        % % comprobacion(g) = corr2(Campo_A,Campo_B);
                        % 
                        % % Actualizamos el título del perfil
                        % t2.String = sprintf(['Simulación ',num2str(num_prueba),' (y = ',num2str(x(ordenada)),', z = ',num2str(vector_z(g)/distancia_focal),'f)']);
    
                    end
    
                    % -------------------------------------------------------------
                    % Capturamos el frame actual
                    % -------------------------------------------------------------
    
                    % % Actualizamos la figura antes de capturarla
                    % drawnow
                    % 
                    % % Capturamos la figura como un frame
                    % frame = getframe(fig);
                    % 
                    % % % Descomentar las siguientes líneas para generar un GIF:
                    % % img = frame2im(frame);
                    % % [A,map] = rgb2ind(img,256);
                    % 
                    % % Escribimos el frame actual en el video MP4
                    % writeVideo(video,frame);
                    % 
                    % clear frame
    
                    % -------------------------------------------------------------
                    % Cálculo de la potencia
                    % -------------------------------------------------------------
    
                    if g ~= 1  
    
                        % Potencia total del campo propagado
                        Potencia(g) = sum(I1,'all')*dx^2;
    
                        % Descomentar la siguiente línea para generar un GIF:
                        % imwrite(A,map,filename_4,'gif','WriteMode','append','DelayTime',0.2); % Frames siguientes
    
                        % ---------------------------------------------------------
                        % Plano de Fourier
                        % ---------------------------------------------------------
                        if g == posicion_del_plano_de_Fourier
    
                            % La irradiancia en este plano se utiliza como
                            % referencia para calcular la correlación.
    
                            % Guardamos el campo de referencia y el vector espacial
                            % save(fullfile(ruta,'Campo en el plano de Fourier'),'I1')
                            % save(fullfile(ruta,'Vector x'),'x')
    
                            % %disp(' ')
                            % %disp('Aplicando el filtro DoG en el plano de Fourier...')
                            % %disp(' ')
    
                            % Realizamos el análisis de las imágenes obtenidas mediante un filtro
                            % pasa bandas basado en una diferencia de gaussianas (DoG).
                            % filtro_DoG(resolucion,filename_19,lambda,x,I1,ruta,calidad_de_video,num_prueba);
                            % filtro_DoG_videos(resolucion,filename_19,lambda,x,I1,ruta,calidad_de_video,num_prueba);
    
                            %disp(' ')
                            %disp('Generando el gráfico del patrón de irradiancia en el plano de Fourier...')
    
                            % Generamos las gráficas de los campos ópticos en
                            % el plano de Fourier.
                            % graficos_perfil_de_irradiancia(I1(ordenada,:),resolucion,lambda,filename_20,num_prueba,x)
    
                            if j == -10
                                graficos_campo_plano_de_Fourier(resolucion,lambda,filename_12,estilo,I1,num_prueba,x);
                            end   

                            % Descomentar para serie diferentes tamaños de grano.
                            % autocorrelacion = calculo_autocorrelacion(I1);
                            % 
                            % [Rq,Rgrad,Lrug,filas_maximos,columnas_maximos,maximos] = rugosidad_autocorrelacion(autocorrelacion_deltas,dx);
                            % 
                            % graficos_autocorrelacion_3d(filas_maximos,columnas_maximos,maximos,autocorrelacion_deltas,estilo,lambda,filename_3_3,num_prueba,resolucion,x);

                            [delta_irradiancias,envolvente] = quitar_envolvente(size_grano_del_difusor_x,size_grano_del_difusor_y,distancia_focal,I1,lambda,x);
    
                            % graficos_envolvente(ruta,delta_irradiancias,envolvente,I1,estilo,lambda,filename_18_1,filename_18_2,filename_18_3,num_prueba,resolucion,x);

                            autocorrelacion_deltas = calculo_autocorrelacion(delta_irradiancias);

                            % Calculamos los contornos, las curvas promedio y sus áreas.
                            [niveles,curvas_promedio,area05] = calculo_curvas_de_nivel(filename_7,autocorrelacion_deltas,lambda,x);

                            [Rq,Rgrad,Lrug,filas_maximos,columnas_maximos,maximos] = rugosidad_autocorrelacion(autocorrelacion_deltas,dx);

                            if  j == -10
                                graficos_autocorrelacion_3d(filas_maximos,columnas_maximos,maximos,autocorrelacion_deltas,estilo,lambda,filename_3_0,num_prueba,resolucion,x)
                            end

                            % Generamos las figuras utilizando los resultados calculados.
                            % graficos_curvas_de_nivel(curvas_promedio,estilo,lambda,filename_3_1,filename_3_2,num_prueba,resolucion,x,autocorrelacion,niveles);

                            % Calculamos la varianza en función del radio de la ventana.
                            % [psi,b,R2,radios,varianzas] = varianza_hiperuniformidad(delta_irradiancias,dx,lambda);
                            psi = NaN;
    
                            clear niveles curvas_promedio delta_irradiancias envolvente autocorrelacion_deltas autocorrelacion
    
                            % %disp(' ')
                            % %disp('Generando gráfico de hiperuniformidad...')
                            % %disp(' ')
    
                            % graficos_varianza_hiperuniformidad(psi,b,R2,radios,varianzas,num_prueba,filename_17,resolucion)

                        end
    
                        % ---------------------------------------------------------
                        % Planos posteriores al plano de Fourier
                        % ---------------------------------------------------------
                        if g >= posicion_de_la_lente
    
                            % Calculamos la correlación con respecto a la irradiancia del plano de Fourier
                            pearson(g-posicion_de_la_lente+1) = corr2(I_rapida,I1);
    
                        end
                        
                        clear I1
    
                        % ---------------------------------------------------------
                        % Aplicación de la lente
                        % ---------------------------------------------------------
    
                        if g == posicion_de_la_lente
                            
                            % Al llegar a la posición de la lente, multiplicamos
                            % el campo propagado por la función de transmitancia
                            % de la lente.
                            u1 = u1.*FT_lente;
    
                        end
    
                    end
                
                end
                
            end
    
            % % Cerramos el archivo de video
            % close(video);
            % 
            % % Cerramos la figura utilizada para generar el video y liberamos
            % % los recursos gráficos asociados
            % close(fig);
    
            clear u1 soporte I1 I_rapida H 
    
            %disp(' ')
       
            % ---------------------------------------------------------------------
            % Análisis posterior a la propagación
            % ---------------------------------------------------------------------
       
            % %disp('Generando gráfico de comprobación...')
    
            % % Generamos la gráfica de comprobación de la validéz de la propagación.
            % graficos_comprobacion(resolucion,z_R,filename_0,num_prueba,vector_z,comprobacion);
    
            %disp('Generando gráfico de evolución de la potencia...')
    
            % Se normaliza la potencia óptica respecto a su valor en el plano
            % inicial de propagación.
            potencia_norm = Potencia/Potencia(1);
    
            % Generamos la gráfica de la evolución de la potencia durante la
            % propagación y calculamos su valor promedio.
            % graficos_potencia(potencia_norm,resolucion,distancia_focal,filename_1,num_prueba,vector_z);
    
            % Se calcula el valor promedio de la potencia óptica normalizada a lo
            % largo de todo el intervalo de propagación considerado.
            promedio_de_potencia = mean(potencia_norm);
    
            %disp(' ')
            %disp('Generando gráfico de evolución de los coeficientes de correlación...')
    
            % Generamos la gráfica de la evolución del coeficiente de correlación
            % durante la propagación y calculamos su valor promedio.
            % graficos_pearson(resolucion,distancia_focal,filename_2,num_prueba,vector_z,pearson,posicion_de_la_lente);
    
            % Se calcula el valor promedio del coeficiente de correlación a lo largo
            % del intervalo de propagación considerado.
            promedio_de_pearson = mean(pearson);
    
            % Detenemos el cronómetro y obtenemos el tiempo total de ejecución
            tiempo = toc;
        
            %disp(' ')
            %disp('Generando bitácoras de propagación...')
            
            % Guardamos los parámetros y resultados en un archivo TXT
            archivo_txt(Rq,Rgrad,Lrug,numel(maximos),area05,psi,promedio_de_potencia,promedio_de_pearson,size_grano_del_difusor_x,size_grano_del_difusor_y,...
                filename_5,num_prueba,lambda,distancia_focal,L,M,paso_z,dx,num_granos,...
                R_0,grosor,amplitud,ang_mayor,ang_menor,tiempo);
       
            % Guardamos los parámetros y resultados en un archivo CSV
            archivo_csv(numel(maximos),Rq,Rgrad,Lrug,area05,psi,promedio_de_potencia,promedio_de_pearson,size_grano_del_difusor_x,size_grano_del_difusor_y,filename_6,num_prueba,lambda,distancia_focal,L,M,paso_z,dx,num_granos,R_0,grosor,amplitud,ang_mayor,ang_menor,tiempo);
    
            %disp(' ')
            
            % Indicamos que la simulación terminó correctamente
            %disp(['Simulación ',num2str(num_prueba),'/',num2str(numero_de_simulaciones),' exitosa.'])
    
        else
            
            % Si no se cumplen las condiciones de propagación, se reproduce un
            % sonido indicando que ocurrió un error
            sonido_de_falla
    
            %disp(' ')
            %disp('¡ERROR!')
            %disp(' ')
            %disp('No se han satisfecho los criterios de muestreo.')
            %disp(' ')
            %disp('Verifica los parámetros de propagación.')
    
            % Marcamos la simulación como no válida
            validez = 0;
        
        end
    end
    % -------------------------------------------------------------------------
    % Análisis final de todas las simulaciones
    % -------------------------------------------------------------------------

    % Si todas las simulaciones fueron consideradas válidas
    if validez == 1

        if numero_de_simulaciones ~= 1

            %disp(' ')
            %disp('Generando videos comparativos...')

            if j == -10
                % Hacemos videos comparativos de los resultados numéricos de todas las simulaciones
                videos_comparativos(ruta_base,ruta_de_carpeta_de_simulaciones,numero_de_simulaciones)
            end
            
            %disp(' ')
            %disp('Generando gráficos comparativos...')

            % Generamos las gráficas potencia y coeficiente de correlación promedio y tiempo de ejecución
            % graficos_comparativos(filename_25,filename_21,filename_22,filename_23,filename_24,filename_15,filename_9,filename_10,filename_8,resolucion,numero_de_simulaciones,ruta_de_carpeta_de_simulaciones)

        end

        % Calculamos el tiempo total de ejecución de todo el programa.
        tiempo_total = toc(tic_total);

        % Mostramos el tiempo total de cómputo en minutos.
        disp(['Tiempo de cómputo: ',num2str(tiempo_total/60),' min.'])

    end

end

if numero_de_series ~= 1
    graficos_promediados(numero_de_simulaciones,numero_de_series,ruta_nucleo,resolucion,filename_8,filename_9,filename_10,filename_15,filename_21,filename_22,filename_23,filename_24,filename_25);
end

% Calculamos el tiempo total de ejecución de todo el programa.
tiempo_nucleo = toc(tic_nucleo);

% Mostramos un mensaje indicando que la simulación terminó.

%disp(' ')
%disp('¡LISTO!')
%disp(' ')

% Mostramos el tiempo total de cómputo en minutos.
disp(['Tiempo de cómputo total: ',num2str(tiempo_nucleo/60),' min.'])

% Reproduce el sonido indicando que todas las simulaciones terminaron
terminado