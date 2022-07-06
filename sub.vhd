use work.storage.all;	  	 
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library IEEE;
use IEEE.STD_LOGIC_1164.all;   
use ieee.numeric_std.all;
use Work.storage.all;

entity sub is
	port(
	en_in : in std_logic_vector(63 downto 0);
	lock : in std_logic_vector(63 downto 0);
	min_digit_in : in unsigned(3 downto 0);	  
	digit_ind_in : in unsigned(1 downto 0);	   
	input_records_in : in matrix;
	input_records_out : out matrix;
	clk : in std_logic);
end sub;

--}} End of automatically maintained section

architecture sub of sub is
begin
	
	process(clk)			   						  
	variable tmp : unsigned(3 downto 0);
	begin
		if clk = '1' then 	 
			input_records_out <= input_records_in;
			for i in 0 to 63 loop
				if (en_in(i) = '1') and (lock(i) = '0') then	  					   				
			
					input_records_out(i)(to_integer(digit_ind_in)) <= input_records_in(i)(to_integer(digit_ind_in)) - min_digit_in;
					
				end if;
			end loop;
		end if;
	end process;
	 -- enter your statements here --

end sub;
	
	