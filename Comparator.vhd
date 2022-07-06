library ieee;	
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;  

package storage is
type bcd is array (3 downto 0) of unsigned(3 downto 0);
type matrix is array(63 downto 0) of bcd;  
end storage;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use Work.storage.all; 

entity Comparator is 
	port ( en_in : in std_logic_vector(63 downto 0);
		lock : in std_logic_vector(63 downto 0);
		input_stream : in matrix;
		index : in unsigned(1 downto 0); 
		en_out : out std_logic_vector(63 downto 0);
		lock_out : out std_logic_vector(63 downto 0);
		output : out unsigned(3 downto 0);
		clk : in std_logic;
		counter : out unsigned(7 downto 0));
end Comparator;


architecture Behavioral of Comparator is
begin
Comparator : process(clk)
variable tmp : unsigned(3 downto 0) := "1001";
variable count : unsigned(7 downto 0) := "00000000";
begin	 
	if clk = '1' then 
		for i in 0 to 63 loop 
			if (en_in(i)='1' and lock(i)='0') then
				if (index="00") then
					if (input_stream(i)(0) <= tmp) then
						tmp := input_stream(i)(0);
					end if;
				elsif (index="01") then
					if (input_stream(i)(1) <= tmp) then
						tmp := input_stream(i)(1);
					end if;
				elsif (index="10") then
					if (input_stream(i)(2) <= tmp) then
						tmp := input_stream(i)(2);
					end if;
				else
					if (input_stream(i)(3) <= tmp) then
						tmp := input_stream(i)(3);
					end if;
				end if;
			end if;
		end loop;
		lock_out <= lock;
		en_out <= en_in;
		for j in 0 to 63 loop
			if (en_in(j) = '1' and input_stream(j)(0) = tmp) then
				lock_out(j) <= '1';
			end if;
		end loop;
		for k in 0 to 63 loop
			if (input_stream(k)(to_integer(index)) = tmp) then
				en_out(k) <= '1';
				count := count + 1;
			else
				en_out(k) <= '0';
			end if;
		end loop;	
	end if;
	output <= tmp;
	counter <= count;
end process;
end Behavioral;