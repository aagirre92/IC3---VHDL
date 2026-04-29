library IEEE;
use IEEE.std_logic_1164.all;

entity gen is 
	port(
		out1, out2, out3	:	out	std_logic;
		clk					:	in std_logic
	);
end entity gen;


architecture rtl of gen is

	type t_state is (S0,S1,S2);
	
	signal state_out1			:	t_state;
	signal state_out2			:	t_state;

	signal out1_int, out2_int	:	std_logic; -- Auxiliares!
begin

	-- Generar salida
	-- aquí pongo los valores PRESENTES (valores de la salida en cada uno de los estados, igual que el diagrama de Moore)
	-- a diferencia del ejercicio_6_9_v2.vhd
	-- MEJOR ASÍ...MÁS FÁCIL E INTUITIVO
	out1_generar_salida: process (state_out1) is
	begin
		case state_out1 is
			when S0 	=> out1_int <='1';
			when S1 	=> out1_int <='1';
			when S2 	=> out1_int <='0';
			when others => out1_int <='X';
			
		end case;
	end process out1_generar_salida;

	-- Genrar el siguiente estado;
	out1_next_state: process (clk) is
	
		begin
			
			if rising_edge(clk) then
				case state_out1 is
					when S0 => state_out1 <= S1;
					when S1 => state_out1 <= S2;
					when S2 => state_out1 <= S0;
					when others => state_out1 <= S0;
				end case;
			end if;
		end process out1_next_state;
		

	-- Generar salida
	out2_generar_salida: process (state_out2) is
	begin
		case state_out2 is
			when S0 	=> out2_int <='0';
			when S1 	=> out2_int <='1';
			when S2 	=> out2_int <='1';
			when others => out2_int <='X';
			
		end case;
	end process out2_generar_salida;

	-- Genrar el siguiente estado;
	out2_next_state: process (clk) is
	
		begin
			
			if falling_edge(clk) then
				case state_out2 is
					when S0 => state_out2 <= S1;
					when S1 => state_out2 <= S2;
					when S2 => state_out2 <= S0;
					when others => state_out2 <= S0;
				end case;
			end if;
		end process out2_next_state;

	
	-- Acuerdate: NO se pueden leer los outputs (hay que crear señales auxiliares internas...)
	out3 <= out1_int and out2_int;
	
	out1 <= out1_int;
	out2 <= out2_int;	

end architecture rtl;