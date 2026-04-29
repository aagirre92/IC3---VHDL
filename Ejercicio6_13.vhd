-- Ejercicio 6.13

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity udcounter is
port (
	Q			:			out		std_logic_vector(3 downto 0);
	Clock		:			in		std_logic;
	Clear		:			in		std_logic; -- reset asíncrono a nivel alto
	Count		:			in		std_logic;
	Down		:			in		std_logic
);
end entity udcounter;

architecture rtl of udcounter is

	signal qaux	:	unsigned(3 downto 0); -- no puedo leer el valor de una salida! acuérdate
	
begin
	
	process(Clock,Clear) is
	
	begin
	
		if (Clear = '1') then
		
			qaux <= "0000";
		
		elsif(rising_edge(Clock)) then
		
			if (Count = '1') then
			
				if (Down = '0') then
					-- Incrementa
					qaux <= qaux + 1;
				else
					-- Decrementa
					qaux <= qaux - 1;
				end if;
			
			end if;
		
		end if;
	
	end process;
	
	Q <= std_logic_vector(qaux);




end architecture rtl;
