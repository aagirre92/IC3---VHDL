library IEEE;
use IEEE.std_logic_1164.all;


entity circuitocontadorej610 is 
	port (
		Y		:		out		std_logic;
		state	:		out		std_logic_vector(1 downto 0);
		X		:		in		std_logic;
		reset	:		in		std_logic;
		clk		:		in		std_logic
	);
end entity circuitocontadorej610;

architecture rtl of circuitocontadorej610 is

	signal internal_state	:	std_logic_vector(1 downto 0);

begin

	-- Señales de salida en cada estado
	actualizar_signals: process (internal_state) is
	begin
		case internal_state is
			when "00" 	=> Y <= '0';
			when "01" 	=> Y <= '0';
			when "10" 	=> Y <= '0';
			when "11" 	=> Y <= '1';
			when others => Y <= '0';
			
		end case;
	
	end process actualizar_signals;

	-- Maquina de estados
	
	state_machine: process (clk,reset) is
	
	begin
	
		if (reset = '1') then
		
			internal_state <= "00";
		elsif (rising_edge(clk)) then
		
			case internal_state is
			
				when "00" =>
				
					if (X = '1') then
						internal_state <= "01";
					end if;
					
				when "01" =>
				
					if (X = '1') then
						internal_state <= "10";
					else
						internal_state <= "00";
					end if;
					
				when "10" =>
				
					if (X = '1') then
						internal_state <= "11";
					else
						internal_state <= "00";
					end if;
					
				when "11" =>
				
					if (X = '0') then
						internal_state <= "00";
					end if;
					
				when others =>
					
					internal_state <= "00"; --al inicio
					
			end case;
		
		end if;
	
	end process state_machine;
	
	state <= internal_state;
	
	

end architecture rtl;