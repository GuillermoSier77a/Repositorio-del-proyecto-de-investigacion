function [anillo_y_difusor, grosor, radio_exterior] = anillo_con_difusor(fase_del_difusor,x,sigma,amplitud,R_0)
    
    % Radio exterior del anillo.
    % Se consideran dos desviaciones estándar sigma respecto al radio R_0.
    radio_exterior = R_0 + sigma;   
    
    % Radio interior del anillo.
    % Se consideran dos desviaciones estándar sigma hacia el interior respecto a R_0.
    radio_interior = R_0 - sigma;  
    
    % Definimos el ancho del anillo como la distancia radial entre 
    % los puntos donde la irradiancia disminuye a 1/e de su valor máximo.
    grosor = radio_exterior-radio_interior;
    
    % Genera una malla bidimensional utilizando todas las posiciones
    % espaciales definidas en x.
    [X_anillo,Y_anillo] = meshgrid(x,x);
    
    % Calcula la distancia radial de cada punto de la malla respecto
    % al centro del sistema de coordenadas.
    R = hypot(X_anillo,Y_anillo);
    
    % Anillo gaussiano

    % Genera una distribución de amplitud con perfil gaussiano en la
    % dirección radial, centrada en el radio R_0.
    anillo = amplitud * exp(-(R - R_0).^2 / sigma^2);

    % % Anillo rect
    % 
    % % Genera una alternativa de anillo con amplitud constante.
    % % Esta sección está comentada y, por lo tanto, no se ejecuta.
    % 
    % anillo = zeros(size(X_anillo));
    % anillo(R > radio_interior & R < radio_exterior) = amplitud;
    
    % Combina la amplitud del anillo con la fase del difusor.
    % exp(1j*fase) representa el factor de fase complejo.
    % El resultado es el campo óptico complejo del anillo con difusor.
    anillo_y_difusor = anillo.*exp(1j*fase_del_difusor);
   
end