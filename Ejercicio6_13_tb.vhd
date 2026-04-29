-- Ejercicio 6.13 TB
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity tb_ej613 is
end entity tb_ej613;

architecture tb of tb_ej613 is

	--todo
	constant 	PERIODO		:		 	time := 10 ns;
	signal 		Clock		:			std_logic:='0';
	signal		Clear		:			std_logic:='0';
	signal		Count		:			std_logic:='0';
	signal		Down		:			std_logic:='0';
	signal		Q			:			std_logic_vector(3 downto 0);
	
	-- CLAVE
	FUNCTION to_string(dato : std_logic_vector) RETURN STRING IS
		VARIABLE cadena : STRING(1 TO dato'length):=(OTHERS => ' ');
		VARIABLE pos : INTEGER := 0;
	BEGIN
		FOR i IN dato'RANGE LOOP
			pos := pos + 1;
			cadena(pos) := std_logic'image(dato(i))(2); --aquí está la clave! el dato en std_logic es '1' (empezando el índice en 1)
		END LOOP;
		RETURN cadena;
	END FUNCTION;
	
begin

	-- UUT
	
	uut: entity work.udcounter(rtl) port map (Clock => Clock, Clear => Clear, Count => Count, Down => Down, Q => Q);
	
	-- Señal de reloj
	
	Clock <= not Clock after PERIODO/2; --OJO CUIDAO QUE ES T/2 AQUÍ
	
	process is
	
	variable n_errores	:	integer:=0;
	
	procedure check(
		valor_esperado		:		in			std_logic_vector(3 downto 0);
		valor_actual		:		in			std_logic_vector(3 downto 0)
	) is
	
	begin
	
		if not(valor_esperado = valor_actual) then
			n_errores:=n_errores+1;
			report "NOK: Valor esperado: " & to_string(valor_esperado) & "|| valor actual: " & to_string(valor_actual);
		else
			report "OKEI: Valor esperado: " & to_string(valor_esperado) & "|| valor actual: " & to_string(valor_actual);
		end if;
		
	
	end procedure check;
	
	begin
		
		Clear <= '0';
		wait for (PERIODO/4); -- 2.5ns
		
		Clear <= '1'; -- reseteado
		wait for (PERIODO/2); -- 2.5 +5 = 7.5ns
		check("0000",Q);
		
		-- Count up
		
		for i in 1 to 5 loop
			report "Count UP iteracion " & integer'image(i) & "/5";
			Clear <= '0';
			Count <= '1';
			wait for PERIODO;
			check(std_logic_vector(to_unsigned(i,4)),Q);		
		end loop;
		
		-- Count down
		
		for i in 4 downto 1 loop
			report "Count DOWN iteracion " & integer'image(i) & "/5";
			Clear <= '0';
			Count <= '1';
			Down <= '1';
			wait for PERIODO;
			check(std_logic_vector(to_unsigned(i,4)),Q);		
		end loop;
		
		
		-- Final report
		if (n_errores = 0) then
		
			report "FIN DEL TEST. ALLES GUT";
		else
			report "FIN - NUMERO DE ERRORES: " & integer'image(n_errores);
		end if;
		
		wait;
	
	
	end process;

end architecture tb;
