----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:55:34 03/27/2020 
-- Design Name: 
-- Module Name:    mux2_16 - Behavioral 
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity mux2_16 is
	port(
				A, B : in std_logic_vector(15 downto 0 );
				sel  : in std_logic;
				Output : out std_logic_vector(15 downto 0 )
			);
end mux2_16;

architecture Behavioral of mux2_16 is

begin
	with sel select Output <= 
			A when '0',
			B when '1',
			x"0000"	when others;
			
end Behavioral;

