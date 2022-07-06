-------------------------------------------------------------------------------
--
-- Title       : controller
-- Design      : sorter
-- Author      : thezed
-- Company     : elmos
--
-------------------------------------------------------------------------------
--
-- File        : h:\final_proj\sorter\src\controller.vhd
-- Generated   : Tue Jul 13 23:08:27 2021
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
--{entity {controller} architecture {controller}}





	
use work.storage.all;
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity controller is 
	port(
	input_raw : in matrix;
	output_final : out matrix;
	debug_mind3 : out unsigned(3 downto 0);
	inputen_debug : out std_logic_vector(63 downto 0);
	ind3debug : out unsigned(1 downto 0);
	clk_copy : out std_logic;
	counter_debug1 : out unsigned(7 downto 0);
	counter_debug2 : out unsigned(7 downto 0);
	counter_debug3 : out unsigned(7 downto 0));
end controller;

architecture controller_arch of controller is
signal input_en : std_logic_vector(63 downto 0) := "1111111111111111111111111111111111111111111111111111111111111111";
signal input_lock : std_logic_vector(63 downto 0) := "0000000000000000000000000000000000000000000000000000000000000000";
signal input_records1 : matrix := input_raw;	
signal input_records2 : matrix := input_records1;   -- just a copy of input_records1
signal ind1 : unsigned(1 downto 0);          --oldest
signal ind2 : unsigned(1 downto 0);
signal ind3 : unsigned(1 downto 0) := "11";  --newest
signal clk : std_logic := '0';
signal en_out1 : std_logic_vector(63 downto 0);
signal lock_out1 : std_logic_vector(63 downto 0); 
signal lock_out_sub : std_logic_vector(63 downto 0);  
signal counter1 : unsigned(7 downto 0) := "00000000";	  --oldest
signal counter2 : unsigned(7 downto 0) := "00000000";
signal counter3 : unsigned(7 downto 0) := "00000000";	  --newest
signal min_digit1 : unsigned(3 downto 0); --oldest
signal min_digit2 : unsigned(3 downto 0); 
signal min_digit3 : unsigned(3 downto 0); --newest
signal output_lock1 : std_logic_vector(63 downto 0) := "0000000000000000000000000000000000000000000000000000000000000000";
signal output_lock2 : std_logic_vector(63 downto 0) := output_lock1;  -- just a copy of output_lock1
signal output_records1 : matrix;	 
signal output_records2 : matrix;
begin
	
	CTRLR : process
	begin
		for i in 0 to 63 loop
			for j in 3 downto 0 loop
				output_records1(i)(j) <= "0000";
			end loop;
		end loop;
				

		clk <= '1';
		wait for 100 ns;
		clk <= '0';
		wait for 100 ns;
		
		for i in 0 to 63 loop
			input_en <= "1111111111111111111111111111111111111111111111111111111111111111";
			for j in 3 downto 0 loop
				ind3 <= to_unsigned(j, ind3'length);
				clk <= '1';
				wait for 100 ns;					
				if ((i = 0 and j = 3) or (i = 63 and j = 0)) then	 
					lock_out_sub <= "1111111111111111111111111111111111111111111111111111111111111111";
        		else
          			lock_out_sub <= lock_out1; 
        		end if;
        
        		if ((i = 0 and j = 3)) then
          			counter1 <= "00000000";
        		else	   
					counter1 <= counter2;
        		end if;
				clk_copy <= clk;
				input_en <= en_out1;
				input_lock <= lock_out1;
				min_digit1 <= min_digit2;
       		 	min_digit2 <= min_digit3;
				
				counter2 <= counter3;
				ind1 <= ind2;
				ind2 <= ind3;
				output_lock1 <= output_lock2;
				output_records1 <= output_records2;
				input_records1 <= input_records2;
				debug_mind3 <= min_digit3;
				inputen_debug <= input_en;
				ind3debug <= ind3;
				counter_debug1 <= counter1;
				counter_debug2 <= counter2;
				counter_debug3 <= counter3;
				clk <= '0';
				wait for 100 ns; 
				clk_copy <= clk;
			end loop;
			output_final <= output_records2;
		end loop;
		output_final <= output_records2;
	end process;
	
	S1 : entity work.Comparator port map (
		en_in => input_en,
		lock => input_lock,
		input_stream => input_records2,
		index => ind3,
		clk => clk,
		en_out => en_out1,
		lock_out => lock_out1,
		output => min_digit3,
		counter => counter3
		);
		
	S2 : entity work.sub port map (
		en_in => en_out1,
		lock => lock_out_sub,
		min_digit_in => min_digit2,
		digit_ind_in => ind2,
		input_records_in => input_records1,
		input_records_out => input_records2,
		clk => clk
		);
		
	S3 : entity work.add port map (
		clk => clk,
		min => min_digit1,
		counter => counter1,
		index => ind1,
		out_lock => output_lock1,
		outputs => output_records1,
		new_lock => output_lock2,
		new_output => output_records2
		);
	
end controller_arch;
	
