function contornos = separar_contornos(C,niveles)

    % Inicializamos una celda por cada nivel.
    contornos = cell(numel(niveles),1);
    
    idx = 1;
    
    while idx < size(C,2)
    
        nivel_actual = C(1,idx);
        N = C(2,idx);
    
        % Identificamos el nivel correspondiente.
        [diferencia,k] = min(abs(niveles-nivel_actual));
    
        if diferencia < 1e-10
    
            % Extraemos los puntos del contorno.
            puntos = C(:,idx+1:idx+N);
    
            % Almacenamos los puntos.
            contornos{k} = [contornos{k},puntos];
    
        end
    
        idx = idx + N + 1;
    
    end

end