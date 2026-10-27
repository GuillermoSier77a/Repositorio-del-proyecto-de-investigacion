function graficos_perfil_de_irradiancia(perfil,resolucion,lambda,filename_1,num_prueba,x)

% Se crea una figura no visible destinada a representar la evolución
% de la potencia óptica a lo largo de la propagación.
fig_1 = figure('Visible',"off",'Units','normalized','Position',[0, 0, 1, 1]);

% ================================================================
% Curva de potencia
% ================================================================

% Se representa la potencia óptica normalizada en función de la
% distancia de propagación, expresada en unidades de la distancia focal.
plot(x/lambda,perfil,'Color','r','LineWidth',1);

% ================================================================
% Ejes
% ================================================================

% Se indica en el título el número correspondiente a la simulación.
title(['Simulación ',num2str(num_prueba),' (y = 0, z = 2f)'],'FontWeight','bold');

% Se etiqueta el eje horizontal mediante la distancia de propagación
% normalizada respecto a la distancia focal.
xlabel('x/λ','FontWeight','bold');

% Se etiqueta el eje vertical con la potencia óptica normalizada.
ylabel('I [u. a.]','FontWeight','bold');

% Se aplica la configuración general definida para los ejes.
configurar_ejes()

% ================================================================
% Exportación
% ================================================================

% Se exporta la gráfica de la potencia óptica normalizada utilizando
% una resolución igual al valor de la variable resolucion.
exportgraphics(fig_1,filename_1,'Resolution',resolucion);

% Se cierra la figura una vez exportada.
close(fig_1)

end