function [anillo_y_difusor, grosor, R_0, sigma] = U_0_anillo_con_difusor_sharp(x,fase_del_difusor,radio_exterior,amplitud,R_0)

    % Calculamos el grosor del anillo como la diferencia entre su radio
    % exterior y su radio interior R_0.
    grosor = 2*(radio_exterior-R_0);

    sigma = grosor/2;
    
    % Construimos la malla espacial correspondiente al campo óptico con la
    % resolución definida por el vector x.
    [X_anillo,Y_anillo] = meshgrid(x,x);

    % Calculamos la distancia radial de cada punto de la malla respecto al
    % origen para definir posteriormente la geometría del anillo.
    R = hypot(X_anillo,Y_anillo);
    
    % Anillo gaussiano
    % Genera una distribución de amplitud con perfil gaussiano en la
    % dirección radial, centrada en el radio R_0.
    anillo = amplitud * exp(-(R - R_0).^2 / sigma^2);

    % Anillo rect
    % Genera una alternativa de anillo con amplitud constante.
    % Esta sección está comentada y, por lo tanto, no se ejecuta.
    % anillo = zeros(size(X_anillo));
    % anillo(R > radio_interior & R < radio_exterior) = amplitud;

    % Incorporamos el difusor al anillo multiplicando su distribución de
    % amplitud por el factor de fase compleja. El campo resultante conserva
    % la geometría anular y presenta una fase aleatoria espacialmente
    % distribuida dentro de dicha región.
    anillo_y_difusor = anillo.*exp(1j*fase_del_difusor);
    
end