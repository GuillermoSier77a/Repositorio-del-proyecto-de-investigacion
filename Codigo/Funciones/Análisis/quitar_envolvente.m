function [delta_irradiancias,envolvente] = quitar_envolvente(size_grano_del_difusor_x,size_grano_del_difusor_y,distancia_focal,I2,lambda,x)

    % Normalizamos las coordenadas espaciales respecto a la longitud
    % de onda.
    x_norm = x/lambda;
    
    % Construimos una malla bidimensional de coordenadas espaciales
    % normalizadas.
    [X,Y] = meshgrid(x_norm,x_norm);
    
    % Calculamos la envolvente teórica de irradiancia mediante el
    % producto de dos funciones sinc cuadradas, considerando las
    % dimensiones de los granos del difusor y la distancia focal.
    envolvente = sinc(size_grano_del_difusor_x*X/distancia_focal).^2.*sinc(size_grano_del_difusor_y*Y/distancia_focal).^2;
    
    % Normalizamos la distribución de irradiancia respecto a su
    % valor máximo.
    I2 = I2/max(I2(:));
    
    % Definimos un umbral relativo para regularizar la envolvente
    % y evitar divisiones entre valores demasiado pequeños.
    umbral = 0.01;
    
    % Regularizamos la envolvente estableciendo un límite inferior
    % igual al umbral definido.
    envolvente_regularizada = max(envolvente,umbral);
    
    % Corregimos la distribución de irradiancia dividiéndola entre
    % la envolvente regularizada para reducir su modulación espacial.
    delta_irradiancias = I2./envolvente_regularizada;
    
    % Normalizamos la distribución de irradiancia corregida
    % respecto a su valor máximo.
    delta_irradiancias = delta_irradiancias/max(delta_irradiancias(:));

end