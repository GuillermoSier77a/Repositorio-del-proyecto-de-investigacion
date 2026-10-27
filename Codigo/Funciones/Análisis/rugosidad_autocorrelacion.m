function [Rq,Rgrad,Lrug,filas_maximos,columnas_maximos,maximos] = rugosidad_autocorrelacion(autocorrelacion,dx)

    % Convertimos la matriz de autocorrelación a precisión doble.
    autocorrelacion = double(autocorrelacion);
    
    % Identificamos los máximos regionales de la autocorrelación.
    mascara = imregionalmax(autocorrelacion);
    
    % Obtenemos los índices de las filas y columnas correspondientes
    % a los máximos regionales identificados.
    [filas_maximos,columnas_maximos] = find(mascara);
    
    % Extraemos los valores de autocorrelación en dichos máximos.
    maximos = autocorrelacion(mascara);
    
    % Calculamos las derivadas espaciales de las fluctuaciones mediante
    % diferencias finitas, considerando el intervalo de muestreo dx.
    [dCdy,dCdx] = gradient(autocorrelacion,dx,dx);
    
    % Obtenemos las dimensiones de la matriz de fluctuaciones.
    [U,V] = size(autocorrelacion);
    
    % Construimos una malla de coordenadas centrada en la matriz,
    % expresada en unidades de píxeles.
    [X,Y] = meshgrid((1:V)-(V+1)/2,...
        (1:U)-(U+1)/2);
    
    % Calculamos la distancia radial de cada píxel respecto al centro.
    R = sqrt(X.^2+Y.^2);
    
    % Definimos el radio de exclusión alrededor del pico central
    % y el margen que se descartará en los bordes de la matriz.
    radio_exclusion = 30;
    margen = 10;
    
    % Construimos una máscara lógica para seleccionar la región de
    % análisis, excluyendo el pico central y los bordes de la matriz.
    mascara_1 = R > radio_exclusion & ...
        abs(X) < V/2-margen & ...
        abs(Y) < U/2-margen;
    
    % Conservamos las fluctuaciones dentro de la región de análisis
    % y anulamos los valores correspondientes a las regiones excluidas.
    % sup = autocorrelacion.*mascara_1;
    
    % Extraemos las fluctuaciones correspondientes a la región válida.
    residuos = autocorrelacion(mascara_1);
    
    % Calculamos la rugosidad cuadrática media como la desviación
    % estándar poblacional de las fluctuaciones seleccionadas.
    Rq = std(residuos,1);
    
    % Calculamos el cuadrado de la magnitud del gradiente espacial
    % de las fluctuaciones de la autocorrelación.
    grad2 = dCdx.^2+dCdy.^2;
    
    % Calculamos la rugosidad asociada al gradiente como la raíz
    % cuadrada del promedio de su magnitud al cuadrado.
    Rgrad = sqrt(mean(grad2(mascara_1)));
    
    % Estimamos una longitud espacial característica de las
    % fluctuaciones mediante el cociente entre ambas rugosidades.
    Lrug = Rq/Rgrad;

end