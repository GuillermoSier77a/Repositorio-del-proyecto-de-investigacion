function graficos_campo_plano_de_Fourier_con_filtro(sigma1,sigma2,resolucion,lambda,filename_19,azul_blanco_rojo,I_ref,num_prueba,x)

    % Generamos los gráficos auxiliares
    
    % Creamos una figura no visible para representar la distribución de
    % irradiancia obtenida en el plano de Fourier ubicado en z = 2f.
    fig_0 = figure('Visible',"off","Units", 'normalized', 'Position', [0, 0, 1, 1]);
    
    % Representamos la distribución de irradiancia en el plano de Fourier
    % utilizando coordenadas espaciales normalizadas respecto a R_0.
    imagesc(x/lambda,x/lambda,I_ref);
    
    % Calculamos un límite de visualización a partir del percentil 99.5
    % del valor absoluto de la respuesta, reduciendo la influencia de
    % valores extremos sobre la escala de color.
    limite = prctile(abs(I_ref(:)),99.5);

    % Establecemos límites simétricos alrededor de cero para representar
    % de manera comparable las respuestas positivas y negativas.
    clim([-limite limite]);

    % Orientamos el eje vertical de manera que sus valores aumenten de
    % abajo hacia arriba.
    set(gca,'YDir','normal') 
    
    % Indicamos en el título el número de simulación y la posición del
    % plano representado.
    title(sprintf('Simulación %g (\\sigma_1/dx = %g, \\sigma_2/dx = %g)',num_prueba,sigma1,sigma2),'FontWeight','bold');
    
    % Etiquetamos los ejes espaciales normalizados respecto a R_0.
    xlabel('x/λ','FontWeight','bold');
    ylabel('y/λ','FontWeight','bold');
    
    % Configuramos el tamaño y el grosor de la fuente de los ejes.
    set(gca,'FontSize',15,'FontWeight','bold')
    
    % Establecemos la misma escala espacial en ambos ejes y ajustamos sus
    % límites al intervalo de los datos mostrados.
    axis equal
    axis tight
    
    % Agregamos una barra de color y aplicamos el mapa de colores
    % seleccionado para representar los valores de irradiancia.
    cb = colorbar;
    
    % Aplicamos el mapa de colores divergente azul-blanco-rojo.
    colormap(azul_blanco_rojo);
    
    
    % Etiquetamos la barra de color indicando la magnitud representada.
    ylabel(cb,'Respuesta DoG [u. a.]','FontWeight','bold');
    
    % Exportamos la distribución de irradiancia en el plano de Fourier
    % con una resolución de resolucion dpi.
    exportgraphics(fig_0,filename_19,'Resolution',resolucion)
    
    % Cerramos la figura una vez exportada.
    close(fig_0)

end