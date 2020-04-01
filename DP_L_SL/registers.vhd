----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    05:09:41 03/27/2020 
-- Design Name: 
-- Module Name:    registers - Behavioral 
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

entity registers is
	port(
				clk, reset, Load : in std_logic;
				D					  : in std_logic_vector(7 downto 0);
				Q					  : out std_logic_vector(7 downto 0)
		 );
end registers;

architecture Behavioral of registers is

begin
	process(clk, reset, Load)
		begin
			if(reset = '1') then 
				Q <= (others => '0');
			elsif(rising_edge(clk)) then 
				if(Load = '1') then 
					Q <= D;
				end if;
			end if;
		end process;

end Behavioral;

