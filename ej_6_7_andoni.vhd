library IEEE;
use IEEE.std_logic_1164.all;

-- Divisor frecuencia 3. Cuando se divide la frecuencia por un nº impar, hay que
-- considerar tanto el flanco de subida como el de bajada
-- Duty cycle también 50%

entity divisor_frecuencia_3 is 
	port (
		clk3		:	out	std_logic;
		clk,resetn	:	in	std_logic
	);
end entity divisor_frecuencia_3;

architecture rtl of divisor_frecuencia_3 is

	signal contador					:	integer range 0 to 2 :=0; -- Contador 0, 1, 2 (modulo 3)
	signal clk_rising, clk_falling	:	std_logic;


begin

	-- Rising edge
	rising_edge_detector: process (clk,resetn) is
	begin
	
		if (resetn = 0) then
			clk3 <= '0';
			contador <= '0';
			
		elsif (rising_edge(clk)) then
		
			contador <= contador + 1;
			
			if (contador > 2) then
			
				contador <= 0;
				clk_pos <= '1'; -- 
			
			else clk_pos <= '0';
				
		
		end if;

	end process rising_edge_detector;


	-- Falling edge
	falling_edge_detector: process (clk,resetn) is

	begin

		if (resetn = 0) then
			clk3 <= '0';
			
		elsif (falling_edge(clk)) then
		
			-- Falling edge
			
			if 
		
		end if;
		
		

	end process falling_edge_detector;


end architecture rtl;