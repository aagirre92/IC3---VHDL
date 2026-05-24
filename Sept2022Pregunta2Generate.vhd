library IEEE;
use IEEE.std_logic_1164.all;

entity detectorPar is
generic(
	n_bits	:	integer:=4
);
port(
	x		:	in	std_logic_vector(n_bits-1 downto 0);
	y		:	out	std_logic
);
end entity detectorPar;

architecture rtl of detectorPar is

	signal qaux	:	std_logic_vector(n_bits-1 downto 0);

begin
	y <= qaux(0);
	
	gen_detector	:	for	 i in (n_bits-2) downto 0 generate
	
		gen_detector_n: if i=(n_bits-2) generate
			
			xorn: entity work.xor2(rtl) port map (x0 => x(i+1),x1=>x(i),y0=>qaux(i+1));
		
		end generate gen_detector_n;
		
		gen_detector_i: if i/=(n_bits-2) generate
			
			xori: entity work.xor2(rtl) port map (x0 => qaux(i+2),x1=>x(i),y0=>qaux(i+1));
			
			gen_not_out: if i = 0 generate
				not_out:entity work.not1(rtl) port map (x0 => qaux(i+1), y0 => qaux(i));
			end generate gen_not_out;
			
		end generate gen_detector_i;			
	
	end generate gen_detector;
end architecture rtl;

