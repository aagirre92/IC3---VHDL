library IEEE;
use IEEE.std_logic_1164.all;

-- FlipFlop
entity flipflopD is
	port(
		q			:			out		std_logic;
		d,clk		:			in		std_logic
	);
end entity flipflopD;

architecture rtl of flipflopD is
begin

	process (clk) is
	begin
		if(rising_edge(clk)) then
			q <= d;
		end if;
	end process;
end architecture rtl;

library IEEE;
use IEEE.std_logic_1164.all;

--Mux2a1
entity mux2a1 is
port(
	y			:		out		std_logic;
	sel,x1,x0	:		in		std_logic
);
end entity mux2a1;

architecture rtl of mux2a1 is
begin
with sel select
	y <=	 x0 when '0',
			 x1 when '1',
			 '0' when others;
		
end architecture rtl;

library IEEE;
use IEEE.std_logic_1164.all;

--Desplazador
entity desplazador is
port(
	q				:			out			std_logic_vector(3 downto 0);
	d				:			in			std_logic_vector(3 downto 0);
	clk,load		:			in			std_logic
);
end entity desplazador;

architecture rtl of desplazador is

	signal muxout, qaux: std_logic_vector(3 downto 0);

begin

	q <= qaux;
	
	gen_desplazador: for i in 3 downto 0 generate
	
		inicial: if i= 3 generate
		
			mux3: entity work.mux2a1(rtl)
			port map(
				y   => muxout(i),
				x0  => qaux(0),
				x1  => d(i),
				sel => load
			);
		
		
		end generate inicial;
		
		intermedios: if i/=3 generate
		
			muxk: entity work.mux2a1(rtl)
			port map(
				y   => muxout(i),
				x0  => qaux(i+1),
				x1  => d(i),
				sel => load
			);	
		
		end generate intermedios;
	
		ffk: entity work.flipflopD(rtl)
			port map(
			
				q   => qaux(i),
				d   => muxout(i),
				clk => clk
			);
	
	
	end generate gen_desplazador;
end architecture rtl;
