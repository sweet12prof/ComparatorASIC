----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:02:08 03/27/2020 
-- Design Name: 
-- Module Name:    DedicatedProcessor - Behavioral 
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

entity DedicatedProcessor is
		port(
					clk, reset, Enter, displayButt, resetButt : in std_logic;
					Input : in std_logic_vector(7 downto 0);
					LOut	: out std_logic_vector(7 downto 0);
					sLOut : out std_logic_vector(7 downto 0);
					displayFromControl : out std_logic
					
					
			 );
end DedicatedProcessor;

architecture Behavioral of DedicatedProcessor is
	component Datapath is
	port(
			clk				: in std_logic;
			reset			   : in std_logic; 
			Xload 			: in std_logic;
			Yload 			: in std_logic;
			ZLoad 			: in std_logic;
			mux1Sel  		: in std_logic;
			mux2sel 			: in std_logic;
			displayOut     : in std_logic;
			displayButt		: in std_logic;
			Input 			: in std_logic_vector(7 downto 0);
			GreaterOutput, EqualOutput	: out std_logic; 
			ZeroOutput 		: out std_logic;
			LOut				: out std_logic_vector(7 downto 0);
			sLOut 			: out std_logic_vector(7 downto 0)
		);
	end component;
	
	component ControlUnit is
	port(
				clk			: in std_logic;
				reset			: in std_logic;
				Enter			: in std_logic;
			GreaterOutput, resetButt	: in std_logic;
				ZeroOutput, EqualOutput  : in std_logic;
				displayOut  : out std_logic;
				Xload			: out std_logic;
				Yload			: out std_logic;
				ZLoad			: out std_logic; 
				mux1Sel		: out std_logic; 
				mux2sel		: out std_logic; 
				regClr 		: out std_logic
		);
	end component;
	
	signal greaterOutput, EqualOutput, zeroOutput, Xload, Yload, ZLoad, mux1Sel, mux2sel, regClr, display : std_logic; 
	
begin
	ControlUnitMap : ControlUnit port map 
									(
										clk			=> clk,
										reset			=> reset,
										Enter			=> enter,
									GreaterOutput	=> greaterOutput,
										ZeroOutput  => zeroOutput,
										Xload			=> xLoad,		
										Yload			=> yLoad,	
										ZLoad			=> zLoad,	
										mux1Sel		=> mux1sel,	
										mux2sel		=> mux2sel,	
										regClr 		=> regClr,
										displayOut  => display,
										EqualOutput => EqualOutput,
										resetButt  => resetButt 
									);
									
		Datapathmap : Datapath port map(
														clk				=> clk,
														reset			   => regClr,
														Xload 			=> xload,
														Yload 			=> yload,
														ZLoad 			=> zload	,
														mux1Sel  		=> mux1sel,		
														mux2sel 			=> mux2sel,
														Input 			=> Input,
														GreaterOutput	=> GreaterOutput,
														ZeroOutput 	   =>	ZeroOutput,
														LOut				=> Lout,
														sLOut 			=> sLout,
														displayOut  => display,
														displayButt => displayButt,
														EqualOutput => EqualOutput
													);
		
		displayFromControl <= display;

end Behavioral;

