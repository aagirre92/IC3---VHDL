library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity contador is
port(
	q					:			out		std_logic_vector(3 downto 0);
	clk, reset			:			in		std_logic;
	sync_clr,en,load	:			in		std_logic;
	d					:			in		std_logic_vector(3 downto 0)
);
end entity contador;

architecture rtl of contador is

	signal qaux		:		unsigned(3 downto 0);

begin

	process (clk,reset) is
	
	begin
	
		if (reset = '1') then
		
			qaux <= (others=>'0');
			
		elsif(rising_edge(clk)) then
		
			if (sync_clr='1') then
			
				qaux <= (others=>'0');
			elsif (load='1') then
			
				qaux <= unsigned(d);
				
			elsif(en = '1') then
			
				qaux <= qaux + 1;
			
			end if;
		
		end if;
	
	end process;
	
	q <= std_logic_vector(qaux);



end architecture rtl;


