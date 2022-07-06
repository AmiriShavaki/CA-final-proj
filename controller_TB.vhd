library Sorter;
use Sorter.storage.all;
library ieee;
use ieee.NUMERIC_STD.all;
use ieee.std_logic_1164.all;

	-- Add your library and packages declaration here ...

entity controller_tb is
end controller_tb;

architecture TB_ARCHITECTURE of controller_tb is
	-- Component declaration of the tested unit
	component controller
	port(
		input_raw : in matrix;
		output_final : out matrix;
		debug_mind3 : out UNSIGNED(3 downto 0);
		inputen_debug : out STD_LOGIC_VECTOR(63 downto 0);
		ind3debug : out UNSIGNED(1 downto 0);
		clk_copy : out STD_LOGIC;
		counter_debug1 : out UNSIGNED(7 downto 0);
		counter_debug2 : out UNSIGNED(7 downto 0);
		counter_debug3 : out UNSIGNED(7 downto 0) );
	end component;

	-- Stimulus signals - signals mapped to the input and inout ports of tested entity
	signal input_raw : matrix := (("0110","0111","0011","0010"),("0101","0010","0100","0010"),("0011","0101","0110","0011"),("0011","1000","0010","0001"),
  ("0110","0101","0111","0101"),("1001","0110","0101","1001"),("0010","0100","0000","0011"),("0001","0001","0110","0010"),
  ("0010","0010","0111","0101"),("0101","0110","1001","0101"),("0101","0000","1001","1001"),("0101","0001","0110","0010"),
  ("1001","0000","0011","0101"),("1001","1001","0000","0101"),("0101","0110","0000","0101"),("0101","0000","1001","0000"),
  ("1001","0001","0000","1000"),("1000","0100","0111","0010"),("0010","0011","1000","0111"),("0010","0000","0010","0001"),
  ("1001","0001","0010","1000"),("1000","0110","0000","0100"),("0100","0111","1000","0010"),("1000","0100","0111","0011"),
  ("0100","1000","1000","0101"),("0001","0010","0011","0010"),("0001","0000","0000","0000"),("0001","0000","0000","0001"),
  ("0101","0001","1001","0000"),("0101","0000","1001","0010"),("0111","0100","0101","0000"),("0110","0000","0110","0001"),
  ("0111","0111","0111","0111"),("1001","1001","1001","1001"),("0101","0101","0101","0101"),("1001","0000","1001","0000"),
  ("1000","0000","1000","0000"),("1000","0001","1000","0110"),("0010","0010","0100","0101"),("0010","0010","0101","0110"),
  ("0011","0101","0110","0101"),("0011","0100","0111","0011"),("0011","0110","0101","0000"),("0011","0011","0011","0011"),
  ("0001","0000","1001","0001"),("0001","0000","1001","0010"),("0001","0000","1001","0011"),("0001","0000","1001","0100"),
  ("0010","0000","0101","0110"),("0010","0000","0101","0111"),("0010","0001","0101","0110"),("0010","0001","0101","1000"),
  ("0101","0111","0110","1001"),("0101","1000","0111","0000"),("0101","1000","0111","0001"),("0101","1000","0111","0010"),
  ("0101","0110","0111","0001"),("0101","0110","0111","0010"),("0101","0110","0111","0011"),("0101","0110","0111","0100"),
  ("0110","0000","0101","0001"),("0110","0000","0101","0010"),("0110","0001","0101","0011"),("0110","0001","0101","0100"));
	-- Observed signals - signals mapped to the output ports of tested entity
	signal output_final : matrix;
	signal debug_mind3 : UNSIGNED(3 downto 0);
	signal inputen_debug : STD_LOGIC_VECTOR(63 downto 0);
	signal ind3debug : UNSIGNED(1 downto 0);
	signal clk_copy : STD_LOGIC;
	signal counter_debug1 : UNSIGNED(7 downto 0);
	signal counter_debug2 : UNSIGNED(7 downto 0);
	signal counter_debug3 : UNSIGNED(7 downto 0);

	-- Add your code here ...

begin

	-- Unit Under Test port map
	UUT : controller
		port map (
			input_raw => input_raw,
			output_final => output_final,
			debug_mind3 => debug_mind3,
			inputen_debug => inputen_debug,
			ind3debug => ind3debug,
			clk_copy => clk_copy,
			counter_debug1 => counter_debug1,
			counter_debug2 => counter_debug2,
			counter_debug3 => counter_debug3
		);

	-- Add your stimulus here ...

end TB_ARCHITECTURE;

configuration TESTBENCH_FOR_controller of controller_tb is
	for TB_ARCHITECTURE
		for UUT : controller
			use entity work.controller(controller_arch);
		end for;
	end for;
end TESTBENCH_FOR_controller;

