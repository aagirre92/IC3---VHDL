library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity bp_ej611 is
end entity bp_ej611;

architecture bp of bp_ej611 is

	constant 		PERIODO		:		time	:=	100 ns;
	signal			clk, reset	:		std_logic:='0';
	signal			count		:		std_logic_vector(3 downto 0);

begin

	-- uut
	
	uut: entity work.contador(rtl) port map (clk => clk, reset => reset, count => count);

	reset <= '0', '1' after (PERIODO/4), '0' after (PERIODO + PERIODO/4);
	
	clk <= not clk after (PERIODO/2);
	
	process is
	
		variable n_errores	:	integer:=0;
		
		procedure check (
			actual_count		:		in		std_logic_vector(3 downto 0);
			expected_count		:		in		std_logic_vector(3 downto 0)
		) is
		
		begin -- procedure
		
			if (actual_count /= expected_count) then
			
				report "Error - Actual count is " & integer'image(to_integer(unsigned(actual_count))) & " and expected is " & integer'image(to_integer(unsigned(expected_count)));
				n_errores:= n_errores + 1;
			end if;
		
		end procedure;
	
	
	begin --process
	
		-- Test 0: 0000
		wait for PERIODO;
		check(count,"0000");
		
		-- Test 1: 0001
		wait for PERIODO;
		check(count,"0001");
		
		-- Test 2: 0010
		wait for PERIODO;
		check(count,"0010");
		
		-- Test 3: 0011
		wait for PERIODO;
		check(count,"0011");
		
		-- Test 4: 0100
		wait for PERIODO;
		check(count,"0100");
		
		-- Test 5: 0101
		wait for PERIODO;
		check(count,"0101");
		
		-- Test 6: 0110
		wait for PERIODO;
		check(count,"0110");
		
		-- Test 7: 0111
		wait for PERIODO;
		check(count,"0111");
		
		-- Test 8: 1000
		wait for PERIODO;
		check(count,"1000");
		
		-- Test 9: 1001
		wait for PERIODO;
		check(count,"1001");
		
		-- Test 0, vuelta: 0000
		wait for PERIODO;
		check(count,"0000");
		
		-- Test 1: 0001 (a ver si imprime bien el fallo)
		--wait for PERIODO;
		--check(count,"0100");
		
		-- NO OLVIDAR EL WAIT Q SINO SIGUE
		report "TEST FINALIZADO UEUEEUEUEUEEE";
		
		-- Failure summary
		
		if not (n_errores = 0) then
			report "Ha habido " & integer'image(n_errores) & " fallos ueeeeeeeeeeeee";
		else
			report "tudo bem";
		end if;
		wait;
	
	end process;
end architecture bp;
