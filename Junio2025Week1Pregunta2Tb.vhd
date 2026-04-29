library IEEE;
use IEEE.std_logic_1164.all;

entity bp_counter is
end entity bp_counter;

architecture bp of bp_counter is

	constant			T			:		time:=100 ns;
	signal				clk			:		std_logic:='0';
	signal				reset		:		std_logic;
	signal 				sync_clr	:		std_logic:='0'; -- no lo usamos
	signal				en,load		:		std_logic;
	signal				d,q			:		std_logic_vector(3 downto 0);
	
begin


	clk 			<=	not clk after (T/2);
	reset 			<=	'1','0' after (T+T/4);
	load			<=	'0','1' after (2*T),'0' after (3*T);
	en				<=	'0','1' after (3*T),'0' after (5*T);
	d				<=	"0010";
	
	--UUT
	
	uut: entity work.contador(rtl) port map (clk => clk, reset => reset, load => load, en => en, sync_clr => sync_clr, d => d, q => q);


end architecture bp;