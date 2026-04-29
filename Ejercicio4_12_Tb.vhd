library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;


entity bp_ejercicio4_12 is
end entity bp_ejercicio4_12;

architecture bp of bp_ejercicio4_12 is

signal x,y : std_logic_vector(2 downto 0):= (others => '0');



begin
	-- INSPECCION VISUAL (OK)
	-- UUT
	
	UUT: entity work.codGray(rtl) port map (x => x, y => y);
	
	
	--x(2) <= not x(2) after 40 ns;
	--x(1) <= not x(1) after 20 ns;
	--x(0) <= not x(0) after 10 ns;
	
	-- BP FULL
	
	process is
	
		variable n_errors	:	integer:=0;
		
		function to_string (slv : std_logic_vector) return string is
			-- Normalize the vector to a predictable 1-to-length range
			alias norm_slv : std_logic_vector(1 to slv'length) is slv;
			variable result : string(1 to slv'length);
		begin
			for i in norm_slv'range loop
				case norm_slv(i) is
					when 'U' => result(i) := 'U';
					when 'X' => result(i) := 'X';
					when '0' => result(i) := '0';
					when '1' => result(i) := '1';
					when 'Z' => result(i) := 'Z';
					when 'W' => result(i) := 'W';
					when 'L' => result(i) := 'L';
					when 'H' => result(i) := 'H';
					when '-' => result(i) := '-';
				end case;
			end loop;
			return result;
		end function;
	
		procedure check (
			valor_esperado	:	in		std_logic_vector(2 downto 0);
			valor_actual	:	in		std_logic_vector(2 downto 0)
		) is
		
		
		begin
		
			if (valor_esperado /= valor_actual) then
			
				report "NOK - Valor Esperado: " & to_string(valor_esperado) & " y valor actual: " & to_string(valor_actual) & " NO coinciden";
				n_errors:=n_errors +1;
			
			else
			
				report "OK - Valor Esperado: " & to_string(valor_esperado) & " y valor actual: " & to_string(valor_actual) & " coinciden";
			
			end if;
		
		end procedure check;
	
	
	begin
	
	
		for i in 0 to 7 loop
			x <= std_logic_vector(to_unsigned(i,3));
			wait for 10 ns;
			case i is
				when 0 => check("000",y);
				when 1 => check("001",y);
				when 2 => check("011",y);
				when 3 => check("010",y);
				when 4 => check("110",y);
				when 5 => check("111",y);
				when 6 => check("101",y);
				when 7 => check("100",y);
			
			end case;
		
		end loop;
	
	
	
	
	end process;

end architecture bp;


