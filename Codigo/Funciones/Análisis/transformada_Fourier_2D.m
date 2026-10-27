function transformada_Fourier_2D(u2_ref,dx,x_norm,num_prueba,estilo,radio_exterior,lambda)
    
    % Calculamos la transformada de Fourier bidimensional.
    F = fftshift(fft2(ifftshift(u2_ref)))*dx^2;

    % Localizamos los índices del vector x más cercanos a los extremos
    % espaciales -radio_exterior y +radio_exterior. Estos índices delimitan
    % la región que contiene el anillo del campo inicial.
    [~,anillo_izquierdo] = min(abs(x_norm + radio_exterior/lambda));
    [~,anillo_derecho]   = min(abs(x_norm - radio_exterior/lambda));

    % Generamos los gráficos auxiliares

    % Creamos una figura no visible para representar la distribución de
    % irradiancia obtenida en el plano de Fourier ubicado en z = 2f.
    fig_0 = figure('Visible',"on","Units", 'normalized', 'Position', [0, 0, 1, 1]);

    I_ref = abs(F).^2;

    disp(x_norm(anillo_derecho)*lambda)

    % Representamos la distribución de irradiancia en el plano de Fourier
    % utilizando coordenadas espaciales normalizadas respecto a R_0.
    imagesc(x_norm,x_norm,I_ref);

    % Orientamos el eje vertical de manera que sus valores aumenten de
    % abajo hacia arriba.
    set(gca,'YDir','normal') 

    % Indicamos en el título el número de simulación y la posición del
    % plano representado.
    title(['Simulación ',num2str(num_prueba),' (z = f)'],'FontWeight','bold');

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
    colormap(gca, estilo)

    % Etiquetamos la barra de color indicando la magnitud representada.
    ylabel(cb,'I [U.A.]','FontWeight','bold')

    % % Exportamos la distribución de irradiancia en el plano de Fourier
    % % con una resolución de resolucion dpi.
    % exportgraphics(fig_0,filename_13,'Resolution',resolucion)
    % 
    % % Cerramos la figura una vez exportada.
    % close(fig_0)

end