----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    06:13:40 03/27/2020 
-- Design Name: 
-- Module Name:    ControlUnit - Behavioral 
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

entity ControlUnit is
	port(
				clk, reset, Enter, GreaterOutput, EqualOutput, ZeroOutput, resetButt  : in std_logic;
				Xload, Yload, ZLoad, mux1Sel, mux2sel, regClr, displayOut : out std_logic
		);
end ControlUnit;

architecture Behavioral of ControlUnit is
	type state_type is (ST0, ST1, ST2, ST3, ST4, ST5, ST6);
	signal PS, NS : state_type;
	
	-- ST0 - Clear Reisters
	---ST1 - iNPUT num, if Enter, go to ST2 otherwise remain in ST1
	-- ST2 - IF X=0, LAST STATE ELSE iF X greater than Largest. IF YES ST3, no 
	-- ST3 - second Larest = Largest ///  Largest = num. go to 
	--
begin
	Sync_proc : process(clk, reset, NS)
						begin 
							if(reset = '1' OR resetButt = '1') then 
								PS <= ST0;
							elsif(rising_edge(clk)) then 
								PS <= NS;
							end if;
						end process;
	
	async_proc : process(GreaterOutput, ZeroOutput, Enter, PS)
						begin 
							Xload   <= '0'; 
							Yload   <= '0';
							ZLoad   <= '0';
							mux1Sel <= '0';
							mux2sel <= '0';
							regClr  <= '0';
							displayOut <= '0';
							case PS is 
								when ST0 => 
									regClr <= '1';
									NS <= ST1 ;
								when ST1 => 
									xLoad <= '1';
									if(Enter = '1') then 
										NS <= ST2;
									else 
										NS <= ST1;
									end if;
								
								when ST2 =>
									mux2sel <= '0';
									if (Enter = '1') then 
										NS <= ST2;
									else 
										if(ZeroOutput = '1') then 
											NS <= ST5;
										else 
											if(GreaterOutput = '1') then
											mux1Sel <= '1';
											Zload <= '1';
												NS <= st3;
												
											elsif(EqualOutput = '0') then
												NS <= ST4;
											else 
												NS <= ST1;
											end if;
										end if;
									end if;
								
								when ST3 => 
									Yload <= '1';
									NS <= ST1;
								
								when ST4 => 
									mux2sel <= '1';
									if(GreaterOutput = '1') then 
											NS <= ST6;
									else 
											NS <= ST1;
									end if;

								when ST6 => 
										mux1sel <= '0';
										Zload <= '1';
										NS <= ST1;
										
								when ST5 =>
									displayOut <= '1';
									NS <= ST5;
									
									
									
								when others =>
									Xload   <= '0'; 
									Yload   <= '0';
									ZLoad   <= '0';
									mux1Sel <= '0';
									mux2sel <= '0';
									regClr  <= '0';
									NS <= ST1;
							end case;
						end process;

end Behavioral;

