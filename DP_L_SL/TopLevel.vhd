----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:23:03 03/27/2020 
-- Design Name: 
-- Module Name:    TopLevel - Behavioral 
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

entity TopLevel is
	port (
				clk, Enter, displayButt, resetButt : in std_logic;
				Input : in std_logic_vector(7 downto 0);	
					Anode_Sel : out std_logic_vector(3 downto 0);
					SegA_G : out std_logic_vector(6 downto 0)				
			);
end TopLevel;

architecture Behavioral of TopLevel is
	component DedicatedProcessor is
		port(
					clk			: in std_logic; 
					reset,resetButt			: in std_logic;
					Enter			: in std_logic;
					displayButt : in std_logic;
					Input 		: in std_logic_vector(7 downto 0);
					LOut			: out std_logic_vector(7 downto 0);
					sLOut 		: out std_logic_vector(7 downto 0);
					displayFromControl : out std_logic

					
			 );
	end COMPONENT;
	
	component Seven_Segment is
	  Port 
			  (
					clk : in std_logic;
					SS_In1 : in std_logic_vector(7 downto 0);
					SS_In2 : in std_logic_Vector(7 downto 0);
					
					An_Out : out std_logic_Vector(3 downto 0);
					SS_Out : out std_logic_Vector(6 downto 0)
			  );
	end component;
	
	component mux2_16 is
		port(
				A, B : in std_logic_vector(15 downto 0 );
				sel  : in std_logic;
				Output : out std_logic_vector(15 downto 0 )
			);
	end component;
	
	COMPONENT myDCM
	PORT(
		CLKIN_IN : IN std_logic;
		RST_IN : IN std_logic;          
		CLKIN_IBUFG_OUT : OUT std_logic;
		CLK0_OUT : OUT std_logic;
		LOCKED_OUT : OUT std_logic
		);
	END COMPONENT;
	
	signal finalInput, lout_and_sout, sevenseinput :  std_logic_vector(15 downto 0);
	signal lout, sout :  std_logic_vector(7 downto 0);
	signal finaldisplay, displayFromControl, locked, notLocked, someSig1, someSig2, clk_50 : std_logic;
begin
		
		finalInput <= X"00" & Input;
		lout_and_sout <=    lout & sout ;
		
		DedPortmap : DedicatedProcessor port map(
																clk			=> clk_50,
																reset			=> notlocked,
																Enter			=> Enter,
																displayButt => displayButt,
																Input 		=> Input,
																LOut		   => lout,
																sLOut 	   => sout,
																displayFromControl => displayFromControl,
																resetButt => resetButt
															);
		
		mux2Portmap :  mux2_16 port map(
												A			=> finalInput,
												B 			=> lout_and_sout,
												sel  		=> finaldisplay,
												Output 	=> sevenseinput
											);
		
		finaldisplay <= displayFromControl or displayButt;
		
		SevenSegMap : Seven_Segment Port map(
															clk 		=> clk_50,
															SS_In1	=> sevenseinput(7 downto 0),
															SS_In2 	=> sevenseinput(15 downto 8),
															
															An_Out 	=>	Anode_Sel,
															SS_Out 	=> SegA_G
													  );
													  
		Inst_myDCM: myDCM PORT MAP(
		CLKIN_IN => clk,
		RST_IN =>  someSig1 ,
		CLKIN_IBUFG_OUT => clk_50 ,
		CLK0_OUT =>  someSig2,
		LOCKED_OUT => locked 
	);

	notlocked <= not locked;

end Behavioral;

