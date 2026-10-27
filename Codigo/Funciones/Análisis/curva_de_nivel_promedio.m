function [x_prom,y_prom] = curva_de_nivel_promedio(puntos)

    %----------------------------------------------------------------------
    % Extraemos las coordenadas de los puntos del contorno.
    %----------------------------------------------------------------------
    
    % Verificamos que existan puntos.
    if isempty(puntos)
    
        x_prom = [];
        y_prom = [];
    
        return
    
    end
    
    % Extraemos las coordenadas cartesianas.
    X = puntos(1,:);
    Y = puntos(2,:);
    
    %----------------------------------------------------------------------
    % Convertimos las coordenadas cartesianas a polares.
    %----------------------------------------------------------------------
    
    [theta,r] = cart2pol(X,Y);
    
    %----------------------------------------------------------------------
    % Calculamos el radio promedio de cada sector angular.
    %----------------------------------------------------------------------
    
    num_sectores = 2^11;
    
    % Definimos los bordes de los sectores.
    bordes = linspace(-pi,pi,num_sectores+1);
    
    % Calculamos los ángulos centrales.
    theta_prom = (bordes(1:end-1)+bordes(2:end))/2;
    
    % Identificamos el sector correspondiente a cada punto.
    indices = discretize(theta,bordes);
    
    % Convertimos los vectores a columnas.
    indices = indices(:);
    r = r(:);

    % Identificamos los índices válidos.
    validos = ~isnan(indices) & isfinite(r);

    % Calculamos el radio promedio de cada sector.
    r_prom = accumarray(indices(validos),r(validos), [num_sectores 1],@mean,NaN);

    %----------------------------------------------------------------------
    % Eliminamos los sectores sin datos.
    %----------------------------------------------------------------------
    
    sectores_validos = isfinite(r_prom);
    
    theta_prom = theta_prom(sectores_validos);
    r_prom = r_prom(sectores_validos);
    
    %----------------------------------------------------------------------
    % Suavizamos los radios mediante un promedio móvil.
    %----------------------------------------------------------------------
    
    r_prom = smoothdata(r_prom,'movmean',30);
    
    %----------------------------------------------------------------------
    % Reconstruimos la curva promedio.
    %----------------------------------------------------------------------
    
    x_prom = r_prom(:)'.*cos(theta_prom(:)');
    y_prom = r_prom(:)'.*sin(theta_prom(:)');
    
    % Cerramos la curva agregando el primer punto al final.
    if ~isempty(x_prom)
    
        x_prom(end+1) = x_prom(1);
        y_prom(end+1) = y_prom(1);
    
    end

end