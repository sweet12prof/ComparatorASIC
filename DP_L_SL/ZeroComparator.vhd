----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    05:15:44 03/27/2020 
-- Design Name: 
-- Module Name:    ZeroComparator - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ZeroComparator is
	port( 
			A 		: in std_logic_vector(7 downto 0);
			Zero 	: out std_logic
		 );
end ZeroComparator;

architecture Behavioral of ZeroComparator is

begin
	Zero <= '1' when (A = x"00") else '0';
end Behavioral;

