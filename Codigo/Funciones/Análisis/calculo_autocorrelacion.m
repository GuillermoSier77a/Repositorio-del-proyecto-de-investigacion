function [autocorrelacion] = calculo_autocorrelacion(I1)

    % Normalizamos la irradiancia de referencia para que
    % la suma de todos sus elementos sea igual a 1

    I1 = I1/sum(I1(:));

    % Calculamos la transformada de Fourier bidimensional de la
    % distribución de irradiancia normalizada en el plano de Fourier.
    F = fft2(I1);
    
    % Calculamos la autocorrelación espacial bidimensional mediante el
    % teorema de Wiener-Khinchin, obteniendo la transformada inversa
    % del espectro de potencia. Posteriormente, desplazamos el origen
    % de la autocorrelación al centro de la matriz.
    autocorrelacion = fftshift(real(ifft2(F .* conj(F))));
    
    % Calculamos el valor absoluto de la autocorrelación.
    autocorrelacion = abs(autocorrelacion);
    
    % Normalizamos la autocorrelación respecto a su valor máximo,
    % de manera que su valor central sea igual a la unidad.
    autocorrelacion = autocorrelacion/max(autocorrelacion(:));

end