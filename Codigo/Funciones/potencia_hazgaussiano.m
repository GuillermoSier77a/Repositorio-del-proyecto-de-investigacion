function potencia_hazgaussiano(pot_con_tukey_G,pot_sin_tukey_G,pot_con_tukey,pot_sin_tukey,resolucion,distancia_focal,filename_1,vector_z)

    % Colores
    
    % Se define el color verde utilizado para identificar la posición de la
    % lente dentro de la gráfica.
    verde   = [0.00, 0.60, 0.20];
    
    % Se crea una figura no visible destinada a representar la evolución
    % de la potencia óptica a lo largo de la propagación.
    fig_1 = figure('Visible',"off",'Units','normalized','Position',[0, 0, 1, 1]);
    
    % ================================================================
    % Curva de potencia
    % ================================================================
    
    % Se representa la potencia óptica normalizada en función de la
    % distancia de propagación, expresada en unidades de la distancia focal.
    % Definimos los colores.
    rojo_oscuro = [0.839, 0.153, 0.157];
    rojo_claro  = [1.000, 0.596, 0.588];

    azul_oscuro = [0.122, 0.467, 0.706];
    azul_claro  = [0.620, 0.792, 0.882];

    % Dominio pequeño con Tukey.
    pct = plot(vector_z/distancia_focal,pot_con_tukey,...
        'Color',rojo_oscuro,...
        'LineStyle','-',...
        'Marker','none',...
        'MarkerSize',6,...
        'MarkerFaceColor','k',...
        'MarkerEdgeColor','none',...
        'LineWidth',3,...
        'DisplayName','Dominio pequeño con ventana de Tukey');

    hold on

    % Dominio grande con Tukey.
    pctG = plot(vector_z/distancia_focal,pot_con_tukey_G,...
        'Color',rojo_claro,...
        'LineStyle','--',...
        'Marker','none',...
        'MarkerSize',6,...
        'MarkerFaceColor','k',...
        'MarkerEdgeColor','none',...
        'LineWidth',3,...
        'DisplayName','Dominio grande con ventana de Tukey');

    % Dominio pequeño sin Tukey.
    pst = plot(vector_z/distancia_focal,pot_sin_tukey,...
        'Color',azul_oscuro,...
        'LineStyle','-',...
        'Marker','none',...
        'MarkerSize',6,...
        'MarkerFaceColor','k',...
        'MarkerEdgeColor','none',...
        'LineWidth',3,...
        'DisplayName','Dominio pequeño sin ventana de Tukey');

    % Dominio grande sin Tukey.
    pstG = plot(vector_z/distancia_focal,pot_sin_tukey_G,...
        'Color',azul_claro,...
        'LineStyle','--',...
        'Marker','none',...
        'MarkerSize',6,...
        'MarkerFaceColor','k',...
        'MarkerEdgeColor','none',...
        'LineWidth',3,...
        'DisplayName','Dominio grande sin ventana de Tukey');

    hold off
    % % Se conserva la gráfica actual para incorporar las líneas verticales
    % % correspondientes a las posiciones características del sistema óptico.
    % hold on
    % 
    % % ================================================================
    % % Plano de Fourier
    % % ================================================================
    % 
    % % Se incorpora una línea vertical en z = 2f para indicar la posición
    % % del plano de Fourier dentro del intervalo de propagación.
    % h1 = xline(2,'--',...
    %     'Color','b',...
    %     'LineWidth',3,...
    %     'DisplayName','Plano focal');
    % 
    % % ================================================================
    % % Lente
    % % ================================================================
    % 
    % % Se incorpora una línea vertical en z = f para indicar la posición de
    % % la lente dentro del sistema óptico.
    % h0 = xline(1,'--','Color',verde,'LineWidth',3,'DisplayName','Lente');
    
    % ================================================================
    % Ejes
    % ================================================================
    
    % Se indica en el título el número correspondiente a la simulación.
    % title(['Simulación ',num2str(num_prueba)],'FontWeight','bold');
    
    % Se etiqueta el eje horizontal mediante la distancia de propagación
    % normalizada respecto a la distancia focal.
    xlabel('z/z_R','FontWeight','bold');
    
    % Se etiqueta el eje vertical con la potencia óptica normalizada.
    ylabel('P_{norm}','FontWeight','bold');
    
    % Se aplica la configuración general definida para los ejes.
    configurar_ejes()
    
    % ================================================================
    % Leyenda
    % ================================================================

    % Se genera una leyenda para identificar las posiciones de la lente y
    % del plano de Fourier.
    legend([pct pctG pst pstG],'Location','west','FontWeight','bold','Box','on');
    
    % ================================================================
    % Exportación
    % ================================================================
    
    % Se exporta la gráfica de la potencia óptica normalizada utilizando
    % una resolución igual al valor de la variable resolucion.
    exportgraphics(fig_1,filename_1,'Resolution',resolucion);
    
    % Se cierra la figura una vez exportada.
    close(fig_1)

end