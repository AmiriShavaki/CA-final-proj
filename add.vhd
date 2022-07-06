-------------------------------------------------------------------------------
--
-- Title       : add
-- Design      : add
-- Author      : thezed
-- Company     : elmos
--
-------------------------------------------------------------------------------
--
-- File        : H:\VHDL\project\add\src\add.vhd
-- Generated   : Mon Jul 12 16:19:19 2021
-- From        : interface description file
-- By          : Itf2Vhdl ver. 1.22
--
-------------------------------------------------------------------------------
--
-- Description : 
--
-------------------------------------------------------------------------------

--{{ Section below this comment is automatically maintained
--   and may be overwritten
--{entity {add} architecture {add}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;   
use ieee.numeric_std.all;
use Work.storage.all;

entity add is
	port( 
	clk : in std_logic;
	min : in unsigned(3 downto 0);
	counter	: in unsigned(7 downto 0);
	index : in unsigned(1 downto 0);
	out_lock : in std_logic_vector(63 downto 0);
	outputs : in matrix;
	new_lock : out std_logic_vector(63 downto 0);
	new_output : out matrix
	);
end add;

--}} End of automatically maintained section

architecture add_arch of add is	

begin	
	process(clk)
	variable tmp : unsigned (7 downto 0);
	begin
		if clk = '1' then
			
			tmp := counter;
			new_lock <= out_lock;
			new_output <= outputs;
			for i in 0 to 63 loop 
				if (out_lock(i) = '0' and tmp > 0) then	
					tmp := tmp - 1;
					new_output(i)(to_integer(index)) <= outputs(i)(to_integer(index)) + min;	 
					if (index = 0)then
						new_lock(i) <= '1';	 
					end if;
				end if;
					
			end loop; 
			
		end if;
  end process;

	 -- enter your statements here --

end add_arch;
