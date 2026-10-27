function graficos_campo_fuente(resolucion,radio_exterior,lambda,estilo,I1,filename_11,num_prueba,x)

% Localizamos los índices del vector x más cercanos a los extremos
% espaciales -radio_exterior y +radio_exterior. Estos índices delimitan
% la región que contiene el anillo del campo inicial.
[~,anillo_izquierdo] = min(abs(x + radio_exterior));
[~,anillo_derecho]   = min(abs(x - radio_exterior));

% Creamos una segunda figura no visible para representar la distribución
% de irradiancia del campo inicial en z = 0.
fig_4 = figure('Visible',"off","Units", 'normalized', 'Position', [0, 0, 1, 1]);

% Representamos únicamente la región espacial comprendida entre
% -radio_exterior y +radio_exterior. Las coordenadas se convierten a
% milímetros multiplicándolas por 10.
imagesc(x(anillo_izquierdo:anillo_derecho)/lambda,x(anillo_izquierdo:anillo_derecho)/lambda,I1(anillo_izquierdo:anillo_derecho,anillo_izquierdo:anillo_derecho));

% Orientamos el eje vertical de manera que sus valores aumenten de
% abajo hacia arriba.
set(gca,'YDir','normal')

% Indicamos en el título el número de simulación y que la distribución
% corresponde al campo inicial ubicado en z = 0.
title(['Simulación ',num2str(num_prueba),' (z = 0)'],'FontWeight','bold');

% Etiquetamos los ejes espaciales expresados en milímetros.
xlabel('x/λ','FontWeight','bold');
ylabel('y/λ','FontWeight','bold');

% Configuramos el tamaño y el grosor de la fuente de los ejes.
set(gca,'FontSize',15,'FontWeight','bold')

% Establecemos la misma escala espacial en ambos ejes y ajustamos sus
% límites a la región mostrada.
axis equal
axis tight

% Agregamos una barra de color y aplicamos el mapa de colores
% seleccionado para representar los valores de irradiancia.
cb = colorbar;
colormap(gca, estilo)

% Etiquetamos la barra de color indicando la magnitud representada.
ylabel(cb,'I [u. a.]','FontWeight','bold')

% Exportamos la distribución de irradiancia del campo inicial con una
% resolución de resolucion dpi.
exportgraphics(fig_4,filename_11,'Resolution',resolucion)

% Cerramos la figura una vez exportada.
close(fig_4)

end