library IEEE;
use IEEE.std_logic_1164.all;

entity bp_p3 is
end entity bp_p3;

architecture bp of bp_p3 is

	constant 				CLK_PERIOD	:	time:=10 ns;
	signal 					clk			: 	std_logic:='0';
	signal 					load	:	std_logic;
	signal 					d			:	std_logic_vector(3 downto 0);
	signal 					q			:	std_logic_vector(3 downto 0);


begin

	-- uut
	
	uut: entity work.desplazador(rtl) port map (q => q, d => d, clk => clk, load => load);
	
	
	process is
	
	begin
	
		-- Ponemos el load a 1 para cargar d
		load <= '1';
		d <= "0001";
		wait for CLK_PERIOD;
		
		-- Ponemos el load a 0 (empiezan las rotaciones)
		load <= '0';
		wait for CLK_PERIOD;
		
		
		-- Rotaciones
		for i in 0 to 7 loop
			report "Empezando rotacion nº " & integer'image(i+1) & "/8";
			wait for CLK_PERIOD;
		end loop;
		
		-- Finalmente cargamos 0000
		load <= '1';
		d <= "0000";
		wait for CLK_PERIOD; -- let the clock tik
		
		wait; -- end process 
	
	end process;
	
	
	
	clk <= not clk after (CLK_PERIOD/2);


end architecture bp;
