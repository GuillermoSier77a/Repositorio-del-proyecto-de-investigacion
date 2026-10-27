% Cerramos todas las figuras, vaciamos el workspace y depuramos la
% ventana de comando.
close all; clear; clc;

% Añadimos al path de MATLAB la carpeta "Funciones" y todos sus
% subdirectorios para permitir el acceso a las funciones auxiliares.
addpath(genpath(fullfile(pwd,'Funciones')));

% Ruta principal donde se almacenarán todos los resultados
nombre_de_la_carpeta = 'Serie diferentes tamaños de grano (anillo)';
ruta_base2 = fullfile('/Users/guillermo/Desktop/UNAM/Tesis/Repositorio/',nombre_de_la_carpeta);

% Ruta donde se crearán las carpetas individuales de cada simulación
ruta_de_carpeta_de_simulaciones = fullfile(ruta_base2,'Simulaciones');

numero_de_simulaciones = 50;

resolucion = 300;

% Se genera un vector que identifica cada una de las simulaciones
% realizadas.

vector_pruebas2 = 1:numero_de_simulaciones;

% Se inicializan los vectores destinados a almacenar los parámetros y
% resultados obtenidos en cada simulación.
vector_radios2 = zeros(1,numero_de_simulaciones);
vector_grosor2 = zeros(1,numero_de_simulaciones);
vector_size_de_grano_x2 = zeros(1,numero_de_simulaciones);

vector_r_prom2 = zeros(1,numero_de_simulaciones);
vector_psi2 = zeros(1,numero_de_simulaciones);
vector_RCM2 = zeros(1,numero_de_simulaciones);
vector_RGRAD2 = zeros(1,numero_de_simulaciones);
vector_numero_de_maximos2 = zeros(1,numero_de_simulaciones);
vector_A052 = zeros(1,numero_de_simulaciones);

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

    vector_size_de_grano_x2(1,i) = datos(1,10);
    vector_radios2(1,i) = datos(1,12);
    vector_grosor2(1,i) = datos(1,13);

    vector_r_prom2(1,i) = datos(1,18);
    vector_A052(1,i) = datos(1,19);
    vector_psi2(1,i) = datos(1,20);
    vector_numero_de_maximos2(1,i) = datos(1,21);
    vector_RCM2(1,i) = datos(1,22);
    vector_RGRAD2(1,i) = datos(1,23);

end

%--------------------------------------------------------------------------

% Ruta principal donde se almacenarán todos los resultados
nombre_de_la_carpeta = 'Serie transición';
ruta_base = fullfile('/Users/guillermo/Desktop/UNAM/Tesis/Repositorio/',nombre_de_la_carpeta);

% Ruta donde se crearán las carpetas individuales de cada simulación
ruta_de_carpeta_de_simulaciones = fullfile(ruta_base,'Simulaciones');

numero_de_simulaciones = 50;

resolucion = 300;

% Se genera un vector que identifica cada una de las simulaciones
% realizadas.

vector_pruebas = 1:numero_de_simulaciones;

% Se inicializan los vectores destinados a almacenar los parámetros y
% resultados obtenidos en cada simulación.
vector_radios = zeros(1,numero_de_simulaciones);
vector_grosor = zeros(1,numero_de_simulaciones);
vector_size_de_grano_x = zeros(1,numero_de_simulaciones);

vector_r_prom = zeros(1,numero_de_simulaciones);
vector_psi = zeros(1,numero_de_simulaciones);
vector_RCM = zeros(1,numero_de_simulaciones);
vector_RGRAD = zeros(1,numero_de_simulaciones);
vector_numero_de_maximos = zeros(1,numero_de_simulaciones);
vector_A05 = zeros(1,numero_de_simulaciones);

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

    vector_r_prom(1,i) = datos(1,18);
    vector_A05(1,i) = datos(1,19);
    vector_psi(1,i) = datos(1,20);
    vector_numero_de_maximos(1,i) = datos(1,21);
    vector_RCM(1,i) = datos(1,22);
    vector_RGRAD(1,i) = datos(1,23);
 
end

leyx = 'Ω';
% leyx = 'R_0';
% leyx = 'α';

leyy = 'μ_R';
% leyy = 'A_{0.5}/λ^2';
% leyy = 'ψ';
% leyy = 'r_{∇}λ';
% leyy = 'r_{cm}';
% leyy = 'ρL^2';

% Archivo que contiene las gráficas comparativas entre simulaciones.
filename = fullfile(ruta_base,['Ajuste de la evolución de ',leyy,'.png']);

% ajuste_exponencial
% ajuste_exponencial_estirada
% ajuste_lineal
% ajuste_de_potencias

ajuste_exponencial_estirada(leyx,leyy,vector_grosor(1:end),vector_r_prom(1:end),filename,resolucion)

% % Archivo que contiene las gráficas comparativas entre simulaciones.
% filename_15 = fullfile(ruta_base,'Evolución de AC_{0.5}.png');
% 
% % Se crea una figura no visible destinada a representar la evolución
% % de la potencia óptica a lo largo de la propagación.
% fig_5 = figure('Visible',"on",'Units','normalized','Position',[0, 0, 1, 1]);
% 
% % Se representa la potencia óptica normalizada en función de la
% % distancia de propagación, expresada en unidades de la distancia focal.
% h1=plot(vector_size_de_grano_x,vector_RGRAD,'Color','r','Marker','o','MarkerSize',3,'MarkerFaceColor','k','MarkerEdgeColor','none','LineWidth',3);
% hold on
% h2=plot(vector_size_de_grano_x2,vector_RGRAD2,'Color','b','Marker','o','MarkerSize',3,'MarkerFaceColor','k','MarkerEdgeColor','none','LineWidth',3);
% 
% % Se etiqueta el eje horizontal mediante la distancia de propagación
% % normalizada respecto a la distancia focal.
% xlabel([leyx,'/λ'],'FontWeight','bold');
% 
% % Se etiqueta el eje vertical con la potencia óptica normalizada.
% ylabel([leyy],'FontWeight','bold');
% 
% % Se aplica la configuración general definida para los ejes.
% configurar_ejes()
% 
% legend([h1,h2], {'Haz','Anillo'},'Location','northeast');

% % Se exporta la gráfica de la potencia óptica normalizada utilizando
% % una resolución igual al valor de la variable resolucion.
% exportgraphics(fig_5,filename_15,'Resolution',resolucion);
% 
% % % Se cierra la figura una vez exportada.
% % close(fig_5)

terminado