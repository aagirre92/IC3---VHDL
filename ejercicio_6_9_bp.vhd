-- Banco de pruebas ejercicio 6.9

library IEEE;
use IEEE.std_logic_1164.all;

entity bp_ej69 is
end entity bp_ej69;

architecture bp of bp_ej69 is
    constant PERIODO      				: time      := 100 ns; -- Reloj
    signal   clk          				: std_logic := '0';    -- Entradas UUT
    signal   out1, out2, out3 			: std_logic;

begin
    -- Instanciar y conectar UUT
    --uut : entity work.gen(rtl) port map (clk => clk, out1 => out1, out2 => out2, out3 => out3);
	
	uut_v2 : entity work.gen(rtl_v2) port map (clk => clk, out1 => out1, out2 => out2, out3 => out3);


    clk <= not clk after (PERIODO/2);

end architecture bp;

