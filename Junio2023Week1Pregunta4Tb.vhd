library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.ALL;

-- La entidad de un testbench siempre está vacía
entity tb_control is
end entity tb_control;

architecture test of tb_control is

    -- Señales internas para conectar con nuestro circuito
    signal clk    : std_logic := '0';
    signal rst    : std_logic := '0';
    signal salida : std_logic;

    -- Definimos el periodo del reloj tal y como pide el enunciado
    constant CLK_PERIOD : time := 1 sec;

begin

    -- Instanciamos el circuito (Device Under Test - DUT)
    DUT: entity work.control
        port map (
            salida => salida,
            clk    => clk,
            rst    => rst
        );

    -- 1. Proceso Generador de Reloj
	clk <= not clk after (CLK_PERIOD/2);

    -- 2. Proceso de Estímulos (Simulando lo que haría un usuario)
    stim_process : process
    begin
        -- INICIO: Mantenemos el reset activo ('0') durante 2 segundos
        rst <= '0';
        wait for 2.2 sec; -- Un poco más de 2 ciclos para evitar flancos exactos
        
        -- PRUEBA 1: Funcionamiento normal
        -- Liberamos el reset ('1') para que el circuito empiece a funcionar
        rst <= '1';
        
        -- Esperamos 15 segundos. 
        -- Debería estar 8 seg en Estado A (salida = '0')
        -- Luego 4 seg en Estado B (salida = '1')
        -- Luego volver al Estado A
        wait for 15 sec; 

        -- PRUEBA 2: Interrupción con Reset
        -- Aplicamos reset mientras está contando (a mitad del estado A)
        rst <= '0';
        wait for 1.5 sec; -- Lo mantenemos pulsado 1.5 segundos
        
        -- Lo volvemos a soltar. La cuenta de 8 segundos debería empezar desde 0.
        rst <= '1';
        
        -- Esperamos otros 12 segundos para comprobar que hace la cuenta completa
        wait for 12 sec;

        -- Fin de la simulación (detiene el proceso)
        wait;
    end process stim_process;

end architecture test;
