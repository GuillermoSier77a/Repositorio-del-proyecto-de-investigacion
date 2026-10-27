% Cerramos todas las figuras, vaciamos el workspace y depuramos la
% ventana de comando.
close all; clear; clc;

% Tamaño total de la ventana de cálculo [cm]
L = 1;                

% Número de muestras espaciales en cada dirección
M = 2^11;

% Ancho del intervalo de muestreo
dx = L/M;                               

% Vector de coordenadas espaciales para los ejes x y y
x = -L/2:dx:L/2-dx;

num_granos = 100;

ang_mayor = 2*pi;
ang_menor = 0;

% Genera las posiciones espaciales de los centros de los granos
% del difusor a lo largo del intervalo definido por x.
x_grano = linspace(min(x),max(x),num_granos);

% Calcula el tamaño espacial de cada grano del difusor.
size_grano_del_difusor = (max(x_grano)-min(x_grano))/(numel(x_grano)-1);

disp(size_grano_del_difusor/(532*10^-7))

% Genera una malla bidimensional con las posiciones de los granos
% del difusor en las direcciones X y Y.
[X_grano,Y_grano] = meshgrid(x_grano,x_grano);

% Genera una malla bidimensional utilizando todas las posiciones
% espaciales definidas en x.
[X_anillo,Y_anillo] = meshgrid(x,x);

% Invertimos Y para que el difusor tenga la misma orientación que la mostrada con imagesc.
Y_anillo = flipud(Y_anillo);

% Genera una matriz de fases aleatorias distribuidas uniformemente
% entre ang_menor y ang_mayor.
angulo = ang_menor + (ang_mayor-ang_menor)*rand(size(X_grano));

% Interpola la matriz de fases definida sobre la malla de los granos
% para obtener una fase sobre toda la malla del anillo.
% Se utiliza interpolación 'nearest', por lo que cada punto de la malla
% del anillo recibe la fase del grano más cercano.
fase_nearest = interp2(X_grano,Y_grano,angulo,X_anillo,Y_anillo,'nearest');
fase_linear = interp2(X_grano,Y_grano,angulo,X_anillo,Y_anillo,'linear');
fase_cubic = interp2(X_grano,Y_grano,angulo,X_anillo,Y_anillo,'cubic');
fase_spline = interp2(X_grano,Y_grano,angulo,X_anillo,Y_anillo,'spline');
fase_makima = interp2(X_grano,Y_grano,angulo,X_anillo,Y_anillo,'makima');

% irradiancia obtenida en el plano de Fourier ubicado en z = 2f.
fig_0 = figure('Visible',"on","Units", 'normalized', 'Position', [0, 0, 1, 1]);

% Representamos la distribución de irradiancia en el plano de Fourier
% utilizando coordenadas espaciales normalizadas respecto a R_0.
imagesc(x/size_grano_del_difusor,x/size_grano_del_difusor,fase_nearest/pi);

% Orientamos el eje vertical de manera que sus valores aumenten de
% abajo hacia arriba.
set(gca,'YDir','normal') 

% Indicamos en el título el número de simulación y la posición del
% plano representado.
% title(['Simulación ',num2str(num_prueba),' (z = 2f)'],'FontWeight','bold');

% Etiquetamos los ejes espaciales normalizados respecto a R_0.
xlabel('x/α','FontWeight','bold');
ylabel('y/α','FontWeight','bold');

% Establecemos la misma escala espacial en ambos ejes y ajustamos sus
% límites al intervalo de los datos mostrados.
axis equal
axis tight

% Agregamos una barra de color y aplicamos el mapa de colores
% seleccionado para representar los valores de irradiancia.
cb = colorbar;
colormap(gca, 'parula')

% Etiquetamos la barra de color indicando la magnitud representada.
ylabel(cb,'θ/π [rad]','FontWeight','bold')

% Configuramos el tamaño y el grosor de la fuente de los ejes.
set(gca,'FontSize',15,'FontWeight','bold')

% Exportamos la distribución de irradiancia en el plano de Fourier
% con una resolución de resolucion dpi.
exportgraphics(fig_0,'/Users/guillermo/Desktop/UNAM/Tesis/Figuras/Métodos de interpolación/Difusor.png','Resolution',300)

% Cerramos la figura una vez exportada.
%close(fig_0)

% Se agrupan las distribuciones de fase obtenidas mediante los diferentes
% métodos de interpolación.
fases = {
    angulo/pi
    fase_nearest/pi
    fase_linear/pi
    fase_cubic/pi
    fase_spline/pi
    fase_makima/pi
    };

% Se definen los nombres de los métodos de interpolación.
nombres = {
    'Sin interpolar'
    'Nearest'
    'Linear'
    'Cubic'
    'Spline'
    'Makima'
    };

% % Se crea una figura para comparar las distribuciones de fase.
% fig = figure('Visible',"on","Units", 'normalized', 'Position', [0, 0, 1, 1]);
% 
% % Se define el número de intervalos del histograma.
% num_bins = 200;
% 
% % Se obtienen conjuntamente todos los valores de fase válidos para definir
% % los mismos límites de los intervalos en todos los histogramas.
% fases_validas = [];
% 
% for g = 1:numel(fases)
% 
%     % Se extraen los valores de fase correspondientes al método actual.
%     fase = fases{g};
% 
%     % Se conservan únicamente los valores finitos.
%     fase = fase(isfinite(fase));
% 
%     % Se agregan al vector utilizado para determinar los límites comunes.
%     fases_validas = [fases_validas; fase(:)];
% end
% 
% % Se definen bordes comunes para todos los histogramas.
% bin_edges = linspace(min(fases_validas), ...
%     max(fases_validas), ...
%     num_bins + 1);
% 
% % Se mantienen todos los histogramas en los mismos ejes.
% hold on
% 
% % Se grafican las distribuciones de fase.
% for g = 1:numel(fases)
% 
%     % Se extrae la distribución correspondiente.
%     fase = fases{g};
% 
%     % Se eliminan valores NaN e Inf.
%     fase = fase(isfinite(fase));
% 
%     % Se grafica el histograma normalizado como densidad de probabilidad.
%     histogram(fase, ...
%         'BinEdges',bin_edges, ...
%         'Normalization','count', ...
%         'DisplayStyle','stairs', ...
%         'LineWidth',3, ...
%         'DisplayName',nombres{g});
% end
% 
% % Se etiquetan los ejes.
% xlabel('θ/π [rad]','FontWeight','bold');
% ylabel('Frecuencia','FontWeight','bold');
% 
% % Se agrega la leyenda.
% legend('Location','northwest','FontWeight','bold');
% 
% % Se agrega una cuadrícula.
% grid on
% grid minor
% box on
% 
% % Se configura el formato de los ejes.
% set(gca,'FontSize',15,'LineWidth',1,'FontWeight','bold');
% 
% hold off
% 
% fases_totales = [
%     angulo(:)/pi;
%     fase_nearest(:)/pi;
%     fase_linear(:)/pi;
%     fase_cubic(:)/pi;
%     fase_spline(:)/pi;
%     fase_makima(:)/pi
%     ];
% 
% % Se eliminan posibles valores NaN e Inf.
% fases_totales = fases_totales(isfinite(fases_totales));
% 
% % Se ajustan los límites del eje horizontal al intervalo completo
% % ocupado por las distribuciones de fase.
% xlim([min(fases_totales) max(fases_totales)]);
% % Exportamos la distribución de irradiancia en el plano de Fourier
% % con una resolución de resolucion dpi.
% exportgraphics(fig,'/Users/guillermo/Desktop/UNAM/Tesis/Figuras/Métodos de interpolación/Comparación de histogramas.png','Resolution',300)
% % Cerramos la figura una vez exportada.
% %close(fig)