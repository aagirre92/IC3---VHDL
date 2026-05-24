library IEEE;
use IEEE.std_logic_1164.all;

entity divisor_frecuencia_6 is port(
clk6 : out std_logic;
clk, reset_n: in std_logic );
end entity divisor_frecuencia_6;

architecture rtl of divisor_frecuencia_6 is

	signal out6	:	std_logic;

begin

-- 3Ton, 3Toff

process(clk,reset_n) is 

	variable counter	:	integer range 0 to 2 := 0;
begin

	if (reset_n = '0') then
		counter:=0;
		out6 <= '0';
	elsif(rising_edge(clk)) then
	
		if (counter=2) then
			out6 <= not out6;
			counter:=0;
		else
			counter:=counter+1;
		end if;

	end if;


end process;


-- OUTPUT

clk6 <= out6;


end architecture rtl;


