library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity bp_sumadorcompleto is
end entity bp_sumadorcompleto;

architecture bp of bp_sumadorcompleto is
	constant N : integer :=3;
	signal A,B,S :  std_logic_vector(N-1 downto 0);
	signal Cin, Cout : std_logic;

begin

-- uut

uut : entity work.sumador_n_bits(estructural) 
		generic map (N => N)
		port map (A => A, B => B, Cin => Cin, Cout => Cout, S => S);
		

	process is
	
		procedure check (
			actual_value : in std_logic_vector(N-1 downto 0);
			expected_value : in std_logic_vector(N-1 downto 0)
		) is
		
		begin --procedure
		
			if not (actual_value = expected_value) then
			
				report "ERROR: Expected Value: " & integer'image(to_integer(unsigned(expected_value))) &
				" Actual Value: " & integer'image(to_integer(unsigned(actual_value)));
			
			else
			
				report "OK: Expected Value: " & integer'image(to_integer(unsigned(expected_value))) &
				" Actual Value: " & integer'image(to_integer(unsigned(actual_value)));		
			
			end if;
		
		end procedure;
		
		begin --process
		-- Test 1
		A <= "001"; B <= "011"; Cin <= '0';
		wait for 10 ns;
		check(S,"100");
		
		
		-- Test 2: 5 + 5 = 10
        A <= "010"; B <= "100"; Cin <= '0';
        wait for 10 ns;
        check(S, "110");		
		
		wait; --tb
	
	
	end process;


end architecture bp;