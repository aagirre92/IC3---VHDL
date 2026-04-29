-- Banco de pruebas del divisor de frecuencia por 3
-- fichero: bp_divisor_frecuencia_3.vhd
library IEEE;
use IEEE.std_logic_1164.all;

entity bp_divisor_frecuencia_3 is
end entity bp_divisor_frecuencia_3;

architecture bp_divisor_frecuencia_3 of bp_divisor_frecuencia_3 is
    constant PERIODO      : time      := 100 ns; -- Reloj
    signal   clk          : std_logic := '0';    -- Entradas UUT
    signal   clk3, resetn : std_logic;

begin
    -- Instanciar y conectar UUT
    uut : entity work.divisor_frecuencia_3(rtl) port map (resetn => resetn, clk => clk, clk3 => clk3);

    resetn <= '1',
              '0' after (PERIODO/4),
              '1' after (PERIODO + PERIODO/4);

    clk <= not clk after (PERIODO/2);

end architecture bp_divisor_frecuencia_3;
