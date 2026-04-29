library IEEE;
use IEEE.std_logic_1164.all;
-- Los integer son sintetizables si se define su rango!
entity semaforo is
	generic (ClockFreqHz: integer); -- Video Jonas (https://www.youtube.com/watch?v=E-qEnSp1aCk&list=PLIbRYKjjYOPkhpxnkQ0fwTXnmgsiCMcVV&index=20)
	port (
		clk, reset				:		in		std_logic;
		r1,y1,g1,r2,y2,g2		:		out		std_logic
	);
	
end entity semaforo;

architecture rtl of semaforo is

	type t_state is (YY,RY,GR,YR,RG);
	signal state : t_state;


begin

	assign_output : process(state) is
	-- Aquí SÓLO ASIGNAMOS LAS SEÑALES DE SALIDA
	begin
	
		-- Defaults
		r1 <= '0';
		y1 <= '0';
		g1 <= '0';
		r2 <= '0';
		y2 <= '0';
		g2 <= '0';
	
		case state is
		
			when YY => 
			
				y1 <= '1';
				y2 <= '1';
				
			when RY => 
			
				r1 <= '1';
				y2 <= '1';
				
			when GR => 
			
				g1 <= '1';
				r2 <= '1';
				
			when YR => 
			
				y1 <= '1';
				r2 <= '1';
				
			when RG => 
			
				r1 <= '1';
				g2 <= '1';
		
		end case;
	
	end process assign_output;
	
	state_machine  :  process(reset,clk) is
	
		variable	counter	:	integer; -- estaría bien (ya que nos dicen que la freq son 60Hz poner un range from 0 to 60*85 = 5100)
	
	begin
	
		if (reset = '1') then
			counter := 0;
			state <= YY;
			
		elsif (rising_edge(clk)) then
		
			counter := counter + 1;
		
			case state is
			
				when YY => 
					counter:=0;
					state <= RY;
				when RY => 
					if (counter = ClockFreqHz*5) then
						state <= GR;
					end if;
				when GR => 
					if (counter = ClockFreqHz*50) then --5 + 45
						state <= YR;
					end if;
				when YR => 
					if (counter = ClockFreqHz*55) then --5 + 45 + 5
						state <= RG;
					end if;
				when RG => 
					if (counter = ClockFreqHz*85) then -- 5 + 45 + 5 + 30
						counter := 0; -- reseteo counter
						state <= RY;
					end if;

			
			end case;
		
		
		end if;
	
	end process state_machine;

end architecture rtl;