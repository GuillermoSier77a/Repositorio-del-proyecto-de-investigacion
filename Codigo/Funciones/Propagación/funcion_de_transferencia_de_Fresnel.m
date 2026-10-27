function [H] = funcion_de_transferencia_de_Fresnel(M,L,lambda,z)

    % Calcula el intervalo de muestreo espacial a partir del tamaño
    % de la ventana y del número de muestras
    dx = L/M; 
    
    % Define el vector de frecuencias espaciales en el eje x
    fx = linspace(-1/(2*dx),1/(2*dx)-1/L,M);
    
    % Genera las matrices de frecuencias espaciales FX y FY
    % correspondientes a los ejes x e y
    [FX,FY] = meshgrid(fx,fx);
    
    % Calcula la función de transferencia de Fresnel en el dominio
    % de las frecuencias espaciales
    H = exp(1j*2*pi*z/lambda)*exp(-1j*pi*lambda*z*(FX.^2+FY.^2));
    
    % Reordena el espectro de la función de transferencia para
    % hacer coincidir su distribución con la de la transformada de Fourier
    H = fftshift(H); 

end