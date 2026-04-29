-- Banco de pruebas ejercicio 6.10

library IEEE;
use IEEE.std_logic_1164.all;

entity bp_ej610 is
end entity bp_ej610;

architecture bp of bp_ej610 is
    constant PERIODO      				: time      := 100 ns; -- Reloj
    signal   clk          				: std_logic := '0';    -- Entradas UUT
	signal   X						    : std_logic;
	signal   Y						    : std_logic;
	signal   reset						: std_logic;
	signal   state						: std_logic_vector(1 downto 0);

-- Function to cast std_logic_vector to string (para usarlo en report)

function slv_to_string (slv : std_logic_vector) return string is
        variable result : string (1 to slv'length);
        variable j      : integer := 1;
    begin
        -- Iteramos sobre el rango del vector original
        for i in slv'range loop
            case slv(i) is
                when 'U' => result(j) := 'U';
                when 'X' => result(j) := 'X';
                when '0' => result(j) := '0';
                when '1' => result(j) := '1';
                when 'Z' => result(j) := 'Z';
                when 'W' => result(j) := 'W';
                when 'L' => result(j) := 'L';
                when 'H' => result(j) := 'H';
                when '-' => result(j) := '-';
                when others => result(j) := '?';
            end case;
            j := j + 1;
        end loop;
        
        return result;
end function;
	
begin
    -- Instanciar y conectar UUT
	
	uut : entity work.circuitocontadorej610(rtl) port map (clk => clk, reset => reset, X => X, Y => Y, state => state);


    reset <= '0', '1' after (PERIODO/4), '0' after (PERIODO + PERIODO/4);
	
	
	clk <= not clk after (PERIODO/2); -- Señal de reloj
	
	
	process is
	
		variable n_errores_state	: integer :=0;
		variable n_errores_output	: integer :=0;
		
		procedure check (
			expected_state	:	in	std_logic_vector(1 downto 0);
			actual_state	:	in	std_logic_vector(1 downto 0);
			expected_Y		:	in	std_logic;
			actual_Y		:	in	std_logic
		) is
	
		begin -- Procedure code
		
			-- 1) Comprobar estado
			if (expected_state /= actual_state) then
			
				report "Error: Expected state is " & slv_to_string(expected_state) & " whereas actual state is " & slv_to_string(actual_state);
				n_errores_state := n_errores_state + 1;
				
			else 
				report "OK: Expected state is " & slv_to_string(expected_state) & " and actual state is " & slv_to_string(actual_state);

			end if;
			
			-- 2) Comprobar output
			
			if (expected_Y /= actual_Y) then
			
				report "Error: Expected output is " & std_logic'image(expected_Y) & " whereas actual output is " & std_logic'image(actual_Y);
				n_errores_output := n_errores_output + 1;
				
			else
			
				report "OK: Expected output is " & std_logic'image(expected_Y) & " and actual output is " & std_logic'image(actual_Y); 
				
			end if;
	
		end procedure;
		
	begin -- process
	
		-- Test 1
		X <= '0'; wait for PERIODO;
		check("00",state,'0',Y);
		
		-- Test 2
		X <= '1'; wait for PERIODO;
		check("01",state,'0',Y);
		
		-- Test 3
		X <= '1'; wait for PERIODO;
		check("10",state,'0',Y);
		
		-- Test 4
		X <= '1'; wait for PERIODO;
		check("11",state,'1',Y);
		
		-- Test 5
		X <= '1'; wait for PERIODO;
		check("11",state,'1',Y);
		
		-- Test 6
		X <= '0'; wait for PERIODO;
		check("00",state,'0',Y);
	
		wait; -- Test bench
	end process;
	

end architecture bp;


