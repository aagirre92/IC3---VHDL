library IEEE;
use IEEE.std_logic_1164.all;

entity contador is
	port (
		count		:		out		std_logic_vector(3 downto 0);
		clk, reset	:		in		std_logic
	);
	
end entity contador;

architecture rtl of contador is

	type t_state is (S0,S1,S2,S3,S4,S5,S6,S7,S8,S9);
	signal state : t_state;


begin

	assign_output : process(state) is
	
	begin
	
		case state is
		
			when S0 => count <= "0000";
			when S1 => count <= "0001";
			when S2 => count <= "0010";
			when S3 => count <= "0011";
			when S4 => count <= "0100";
			when S5 => count <= "0101";
			when S6 => count <= "0110";
			when S7 => count <= "0111";
			when S8 => count <= "1000";
			when S9 => count <= "1001";
			
		
		end case;
	
	end process assign_output;
	
	state_machine  :  process(reset,clk) is
	
	begin
	
		if (reset = '1') then
		
			-- count <= "0000"; OJO, SI PONEMOS ESTO NO VA A FUNCIONAR (https://gemini.google.com/share/92fe838b561f)
			state <= S0;
			
		elsif (rising_edge(clk)) then
		
			case state is
			
				when S0 => state <= S1;
				when S1 => state <= S2;
				when S2 => state <= S3;
				when S3 => state <= S4;
				when S4 => state <= S5;
				when S5 => state <= S6;
				when S6 => state <= S7;
				when S7 => state <= S8;
				when S8 => state <= S9;
				when S9 => state <= S0;
			
			
			end case;
		
		
		end if;
	
	end process state_machine;

end architecture rtl;