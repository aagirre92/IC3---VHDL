library IEEE;
use IEEE.std_logic_1164.all;

entity gen is 
	port(
		out1, out2, out3	:	out	std_logic;
		clk					:	in std_logic
	);
end entity gen;


architecture rtl_v2 of gen is

	type t_state is (S0,S1,S2);
	
	signal state_out1			:	t_state;
	signal state_out2			:	t_state;

	signal out1_int, out2_int	:	std_logic; -- Auxiliares!
begin

	-- Si lo hago así (estados y señales en el mismo process) tengo que poner
	-- el valor SIGUIENTE que va a tener la señal
	out1_process: process (clk) is
	
		begin
			
			if rising_edge(clk) then
				case state_out1 is
					when S0 => 
						out1_int <='1'; -- valor de la señal en S1
						state_out1 <= S1;
						
					when S1 => 
						out1_int <='0'; -- valor de la señal en S2
						state_out1 <= S2;
						
					
					when S2 => 
						out1_int <='1'; -- valor de la señal en S0
						state_out1 <= S0;
						
					when others => 
						out1_int <='X';
						state_out1 <= S0; 
						
				end case;
			end if;
		end process out1_process;
		


	-- Si lo hago así (estados y señales en el mismo process) tengo que poner
	-- el valor SIGUIENTE que va a tener la señal
	out2_process: process (clk) is
	
		begin
			
			if falling_edge(clk) then
				case state_out2 is
					when S0 => 
						out2_int <='1'; -- valor de la señal en S1
						state_out2 <= S1;
					when S1 => 
						out2_int <='1'; -- valor de la señal en S2
						state_out2 <= S2; 
					when S2 => 
						out2_int <='0'; -- valor de la señal en S0
						state_out2 <= S0;
					when others => 
						out2_int <='X';
						state_out2 <= S0; 
				end case;
			end if;
		end process out2_process;

	
	-- Acuerdate: NO se pueden leer los outputs (hay que crear señales auxiliares internas...)
	out3 <= out1_int and out2_int;
	
	out1 <= out1_int;
	out2 <= out2_int;	

end architecture rtl_v2;