library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.ALL; -- Añadida la librería del enunciado

entity control is
port(
	salida		:		out			std_logic;
	clk, rst	:		in			std_logic
);
end entity control;

architecture rtl of control is

	signal contador			:		integer range 0 to 7;
	type t_state is (A,B);
	signal state: t_state;
	
	
begin


	output_assign:process(state) is
	
	
	begin
		case state is
		
			when A => salida <= '0';
			when B => salida <= '1';
		
		end case;
	end process output_assign;


	state_machine:process(clk) is
	
	begin

		if rising_edge(clk) then
		
			if (rst ='0') then
				contador <= 0;
				state <= A;
			else
							
				case state is
				
					when A =>
					
						if (contador = 7) then
							state <= B;
							contador <= 0;
						else
							contador <= contador + 1;
						end if;
					when B =>
					
						if (contador = 3) then
							state <= A;
							contador <= 0;
						else
							contador <= contador + 1;
						end if;				
				end case;
			
			end if;
		
		
		end if;

	end process state_machine;



end architecture rtl;