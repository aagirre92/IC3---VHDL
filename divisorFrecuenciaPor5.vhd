library IEEE;
use IEEE.std_logic_1164.all;

entity divisor_frecuencia_5 is port(
clk5 : out std_logic;
clk, reset_n: in std_logic );
end entity divisor_frecuencia_5;

architecture rtl of divisor_frecuencia_5 is

	signal clk_pos,clk_neg	:	std_logic;

begin

-- 2.5Ton, 2.5Toff

-- clk_pos: 2 Ton, 3 Toff (contador desde 0 hasta 4)
-- clk_neg: clk_pos retrasada T/2


clk_pos_process:process(clk,reset_n) is 

	variable counter	:	integer range 0 to 4 := 0;
begin

	if (reset_n = '0') then
		counter:=0;
		clk_pos <= '0';
	elsif(rising_edge(clk)) then
		if (counter=4) then
			clk_pos <= '1';
			counter := 0;
		
		elsif(counter=1) then
			clk_pos<='0';
			counter := counter +1; --incrementa esto cabron, sino se queda en 1 todo el rato
		else
			counter:=counter+1;
		end if;
	end if;


end process clk_pos_process;

clk_neg_process:process(clk,reset_n) is 

begin

	if (reset_n = '0') then
		clk_neg <= '0';
	elsif(falling_edge(clk)) then
		clk_neg <= clk_pos; -- Retrasada T/2
	end if;


end process clk_neg_process;

-- OUTPUT

clk5 <= clk_pos or clk_neg;


end architecture rtl;


