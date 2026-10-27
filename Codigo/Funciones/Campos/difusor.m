function [fase_del_difusor, size_grano_del_difusor] = difusor(ang_mayor,ang_menor,x,num_granos)
    % Generamos el vector de coordenadas espaciales correspondiente a la malla
    % del difusor. El número de puntos por dimensión está determinado por
    % num_granos.
    x_grano = linspace(min(x),max(x),num_granos);
    
    % Calcula el tamaño espacial de cada grano del difusor.
    size_grano_del_difusor = abs(x_grano(1)-x_grano(2));
    
    % Construimos la malla bidimensional sobre la cual se generan los valores
    % aleatorios de fase del difusor.
    [X_grano,Y_grano] = meshgrid(x_grano,x_grano);
    
    % Construimos la malla espacial correspondiente al campo óptico con la
    % resolución definida por el vector x.
    [X_anillo,Y_anillo] = meshgrid(x,x);
    
    % Invertimos Y para que el difusor tenga la misma orientación que la mostrada con imagesc.
    Y_anillo = flipud(Y_anillo);
    
    % Generamos una distribución bidimensional de valores de fase aleatorios
    % uniformemente distribuidos entre los límites angulares ang_menor y
    % ang_mayor.
    angulo = ang_menor + (ang_mayor-ang_menor)*rand(size(X_grano));
    
    % Interpolamos la distribución aleatoria de fase sobre la malla espacial
    % del campo mediante interpolación por vecino más cercano. De esta manera,
    % cada grano conserva un valor de fase constante y se obtienen cambios
    % abruptos de fase entre granos adyacentes.
    fase_del_difusor = interp2(X_grano,Y_grano,angulo,X_anillo,Y_anillo,'nearest');
end