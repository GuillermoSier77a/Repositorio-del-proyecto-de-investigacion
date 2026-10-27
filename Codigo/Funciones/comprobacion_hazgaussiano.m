function comprobacion_hazgaussiano(comp_con_tuyek_G,comp_sin_tuyek_G,resolucion,z_R,filename_0,vector_z,comp_con_tuyek,comp_sin_tuyek)

% Se crea una figura no visible destinada a representar la evolución del
% coeficiente de correlación a lo largo de la propagación.
fig_2 = figure('Visible',"off",'Units','normalized','Position',[0, 0, 1, 1]);

% ================================================================
% Curva de correlación
% ================================================================

% Se representa el coeficiente de correlación en función de la distancia
% de propagación normalizada respecto a la distancia focal. Se consideran
% los valores comprendidos desde la posición de la lente hasta el final
% del intervalo de propagación.

rojo_oscuro = [0.839, 0.153, 0.157];
rojo_claro  = [1.000, 0.596, 0.588];

azul_oscuro = [0.122, 0.467, 0.706];
azul_claro  = [0.620, 0.792, 0.882];

cct = plot(vector_z/z_R,comp_con_tuyek,'Color',rojo_oscuro,'Marker','none','MarkerSize',6,'MarkerFaceColor','k','MarkerEdgeColor','none','LineWidth',3,'DisplayName','Dominio pequeño con ventana de Tukey');

hold on

cctG = plot(vector_z/z_R,comp_con_tuyek_G,'Color',rojo_claro,'Marker','none','MarkerSize',6,'MarkerFaceColor','k','MarkerEdgeColor','none','LineWidth',3,'DisplayName','Dominio grande con ventana de Tukey','LineStyle','--');

hold on

cst = plot(vector_z/z_R,comp_sin_tuyek,'Color',azul_oscuro,'Marker','none','MarkerSize',6,'MarkerFaceColor','k','MarkerEdgeColor','none','LineWidth',3,'DisplayName','Dominio pequeño sin ventana de Tukey');

hold on

cstG = plot(vector_z/z_R,comp_sin_tuyek_G,'Color',azul_claro,'Marker','none','MarkerSize',6,'MarkerFaceColor','k','MarkerEdgeColor','none','LineWidth',3,'DisplayName','Dominio grande sin ventana de Tukey','LineStyle','--');

% ================================================================
% Ejes
% ================================================================

% Se indica en el título el número correspondiente a la simulación.
% title(['Simulación ',num2str(num_prueba)],'FontWeight','bold');

% Se etiqueta el eje horizontal mediante la distancia de propagación
% normalizada respecto a la distancia focal.
xlabel('z/z_R','FontWeight','bold');

% Se etiqueta el eje vertical con la magnitud representada.
ylabel('R','FontWeight','bold');

% Se aplica la configuración general definida para los ejes.
configurar_ejes()

% ================================================================
% Leyenda
% ================================================================

% Se genera una leyenda para identificar las posiciones de la lente y
% del plano de Fourier.
legend([cct cctG cst cstG],'Location','west','FontWeight','bold','Box','on');

% ================================================================
% Exportación
% ================================================================

% Se exporta la gráfica del coeficiente de correlación utilizando una
% resolución igual al valor de la variable resolucion.
exportgraphics(fig_2,filename_0,'Resolution',resolucion);

% Se cierra la figura una vez exportada.
close(fig_2)

end