-- Banco de pruebas del divisor de frecuencia por 6
-- fichero: divisorFrecuenciaPor6TB.vhd
library IEEE;
use IEEE.std_logic_1164.all;

entity bp_divisor_frecuencia_6 is
end entity bp_divisor_frecuencia_6;

architecture bp_divisor_frecuencia_6 of bp_divisor_frecuencia_6 is
    constant PERIODO      : time      := 100 ns; -- Reloj
    signal   clk          : std_logic := '0';    -- Entradas UUT
    signal   clk6, reset_n : std_logic;

begin
    -- Instanciar y conectar UUT
    uut : entity work.divisor_frecuencia_6(rtl) port map (reset_n => reset_n, clk => clk, clk6 => clk6);

    reset_n <= '1',
              '0' after (PERIODO/4),
              '1' after (PERIODO + PERIODO/4);

    clk <= not clk after (PERIODO/2);

end architecture bp_divisor_frecuencia_6;


