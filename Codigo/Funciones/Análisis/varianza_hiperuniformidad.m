function [psi,b,R2,radios,varianzas] = varianza_hiperuniformidad(I2,dx,lambda)
    
    % Definimos el radio mínimo y máximo en píxeles.
    r_min = 3;
    r_max = floor(size(I2,1)/8);
    
    % Generamos radios aproximadamente logarítmicos.
    radios_pix = unique(round(logspace(log10(r_min),log10(r_max),50)));

    % Convertimos la irradiancia a precisión doble.
    I2 = double(I2);
    
    % Obtenemos las dimensiones de la matriz.
    [U,V] = size(I2);
    
    % Calculamos la transformada de Fourier de la irradiancia.
    F = fft2(I2);
    
    % Construimos las coordenadas centradas en píxeles.
    [X,Y] = meshgrid((1:V)-ceil(V/2),(1:U)-ceil(U/2));

    % Reservamos memoria.
    radios = radios_pix(:)*(dx/lambda);
    varianzas = zeros(size(radios));
    
    for j = 1:numel(radios_pix)
    
        r = radios_pix(j);
    
        % Definimos una ventana circular.
        ventana = double(X.^2 + Y.^2 <= r^2);
    
        % Calculamos su transformada de Fourier.
        W = fft2(ifftshift(ventana));
    
        % Convolucionamos la irradiancia con la ventana.
        J = real(ifft2(F.*W))*(dx/lambda)^2;
    
        % Excluimos ventanas que atraviesan los bordes.
        J = J(r+1:U-r,r+1:V-r);
    
        % Calculamos la varianza espacial.
        varianzas(j) = var(J(:),1);
    
    end

    % Ajustamos una ley de potencia.
    p = polyfit(log(radios),log(varianzas),1);

    % Exponente de crecimiento de la varianza.
    psi = p(1);
    b = exp(p(2));

    % Evaluamos el ajuste en coordenadas logarítmicas.
    y = log(varianzas);
    y_ajuste = polyval(p,log(radios));

    % Calculamos el coeficiente de determinación.
    SS_res = sum((y-y_ajuste).^2);
    SS_tot = sum((y-mean(y)).^2);

    R2 = 1-SS_res/SS_tot;
end
