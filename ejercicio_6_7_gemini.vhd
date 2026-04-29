library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity divisor_frecuencia_3 is
    port ( clk3        : out std_logic;
           clk, resetn : in  std_logic );
end divisor_frecuencia_3;

architecture rtl of divisor_frecuencia_3 is

    -- Señales internas
    signal contador : integer range 0 to 2;
    signal clk_pos  : std_logic;
    signal clk_neg  : std_logic;

begin

    -- 1. Proceso síncrono al flanco de SUBIDA (rising_edge)
    process (clk, resetn)
    begin
        -- Reset asíncrono activo a nivel bajo
        if resetn = '0' then
            contador <= 0;
            clk_pos  <= '0';
        elsif rising_edge(clk) then
            -- Contador módulo 3 (0, 1, 2)
            if contador = 2 then
                contador <= 0;
                clk_pos  <= '1'; -- Activamos la señal un ciclo entero de reloj
            else
                contador <= contador + 1;
                clk_pos  <= '0';
            end if;
        end if;
    end process;

    -- 2. Proceso síncrono al flanco de BAJADA (falling_edge)
    process (clk, resetn)
    begin
        if resetn = '0' then
            clk_neg <= '0';
        elsif falling_edge(clk) then
            -- Desplazamos la señal clk_pos medio ciclo de reloj
            clk_neg <= clk_pos;
        end if;
    end process;

    -- 3. Lógica combinacional de salida
    -- Al sumar (OR) ambas señales desfasadas medio ciclo, 
    -- logramos los 1.5 ciclos en alto y 1.5 en bajo (50% duty cycle).
    clk3 <= clk_pos or clk_neg;

end architecture rtl;
