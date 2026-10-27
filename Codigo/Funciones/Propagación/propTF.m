function [u2] = propTF(u1,H)
    
    % Calcula la transformada bidimensional de Fourier del campo de
    % entrada, desplazando previamente su origen al centro
    U1 = fft2(fftshift(u1));
    
    % Multiplica el espectro del campo de entrada por la función
    % de transferencia de Fresnel
    U2 = H.*U1; 
    
    % Calcula la transformada inversa de Fourier y desplaza el origen
    % nuevamente para obtener el campo propagado en el dominio espacial
    u2 = ifftshift(ifft2(U2));
    
end