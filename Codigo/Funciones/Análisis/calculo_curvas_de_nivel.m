function [niveles,curvas_promedio,area05] = calculo_curvas_de_nivel(filename_7,autocorrelacion,lambda,x)

    % Normalizamos las coordenadas espaciales respecto a la longitud
    % de onda.
    x_norm = x/lambda;
    
    % Definimos los niveles de autocorrelación.
    niveles = [0.5 0.5];
    % niveles = linspace(0,1,50);

    % Calculamos todos los contornos correspondientes a los niveles
    % de autocorrelación definidos.
    C = contourc(double(x_norm),double(x_norm), ...
        double(autocorrelacion),double(niveles));
    
    % Separamos los contornos por nivel.
    contornos = separar_contornos(C,niveles);
    
    % Inicializamos el vector de áreas.
    areas = NaN(size(niveles));
    
    % Inicializamos una celda para almacenar las coordenadas de las
    % curvas de nivel promedio.
    curvas_promedio = cell(size(niveles));
    
    % Calculamos las curvas promedio y sus áreas correspondientes.
    for i = 1:numel(niveles)
    
        [x_prom,y_prom] = curva_de_nivel_promedio(contornos{i});
    
        % Almacenamos las coordenadas de la curva promedio.
        curvas_promedio{i} = [x_prom(:),y_prom(:)];
    
        % Calculamos el área encerrada por la curva promedio.
        areas(i) = polyarea(x_prom,y_prom);
    
    end
    
    area05 = areas(1);
    
    % Creamos una tabla con las áreas normalizadas.
    T = table(areas(:),'VariableNames',{'Area_norm'});
    
    % Guardamos la tabla en un archivo CSV.
    writetable(T,filename_7);

end
