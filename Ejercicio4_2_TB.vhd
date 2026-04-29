library  IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.andoni_string_utils.all;

entity tb_comparador is
end entity tb_comparador;

architecture rtl of tb_comparador is

	signal x			:		std_logic_vector(3 downto 0):=(others => '0'); --empezamos en 0000
	signal y			:		std_logic;
	constant PERIODO	:		time:= 10 ns;

begin

	-- UUT
	
	uut: entity work.comparador(rtl) port map (x => x, y=>y);
	
	-- Tests
	
	-- Entradas (solo test visual)
	--x(3) <= not x(3) after 8*PERIODO;
	--x(2) <= not x(2) after 4*PERIODO;
	--x(1) <= not x(1) after 2*PERIODO;
	--x(0) <= not x(0) after PERIODO;
	
	-- Tests con mensaje de error al final
	
	process is
	
		variable n_errors	:	integer:=0;
		
		procedure check(
			expected_value		:		in		std_logic;
			actual_value		:		in		std_logic
		) is --aquí no hay <---OJO FIJARSE BIEN
		
		begin
		
			if not expected_value = actual_value then
			
				report "NOK: Expected value is " & std_logic'image(expected_value) & " and actual value is " &
				std_logic'image(actual_value);
				
				n_errors:=n_errors+1;
			
			
			else
				report "OK: Expected value is " & std_logic'image(expected_value) & " and actual value is " &
				std_logic'image(actual_value);	
			end if;
		
		end procedure check;
	
	begin
	
		-- Actual tests
		
		for i in 0 to 15 loop
			--Entrada
			x <= std_logic_vector(to_unsigned(i,4));
			wait for PERIODO; --para que actualice x e y
			
			report "Test " & integer'image(i) & "/15";
			report "Entrada: " & to_string(x);
			
			-- Check
			if i < 5 then
				check('1',y);
			else
				check('0',y);
			end if;
			
			
		
		end loop;
		
		
		if not (n_errors=0) then
		
			report "STOP - OJO! Han habido un total de " & integer'image(n_errors) & " errores";
			
		else
		
			report "STOP - Tests OK";
		
		end if;
		
		wait; -- Paramos
		
	end process;
	
	
	
	

end architecture rtl;
