library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.BCD_CONSTANTS.all;

entity BCDSum is
port( sum : out std_logic_vector (WIDTH-1 downto 0);
cout : out std_logic;
a, b : in std_logic_vector (WIDTH-1 downto 0);
cin : in std_logic );
end entity BCDSum;

architecture rtl of BCDSum is

begin

	process(a,b,cin) is
		variable unidades, decenas	:	unsigned(4 downto 0);
		variable acarreos			:	unsigned(4 downto 0):="00000";
		
	begin
		-- UNIDADES
		acarreos(0):=cin;
		unidades:=unsigned('0' & a(3 downto 0)) + unsigned('0' & b(3 downto 0)) + acarreos;
		
		if (unidades > "1001") then
		
			unidades:=unidades+6;
		
		end if;
	
		
	
		-- DECENAS
		acarreos(0):=unidades(4);
		
		decenas:=unsigned('0' & a(7 downto 4)) + unsigned('0' & b(7 downto 4)) + acarreos;
		
		if (decenas > "1001") then
		
			decenas:=decenas+6;
		
		end if;	
		
		-- SALIDAS
		
		cout <= decenas(4);
		sum <= std_logic_vector(decenas(3 downto 0)) & std_logic_vector(unidades(3 downto 0));
		
	end process;

end architecture rtl;
