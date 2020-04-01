----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    05:28:00 03/27/2020 
-- Design Name: 
-- Module Name:    Datapath - Behavioral 
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

entity Datapath is
	port(
			clk, reset, Xload, Yload, ZLoad, mux1Sel, mux2sel, displayOut, displayButt : in std_logic;
			Input : in std_logic_vector(7 downto 0);
			GreaterOutput, ZeroOutput, equalOutput : out std_logic;
			LOut, sLOut : out std_logic_vector(7 downto 0)
		);
end Datapath;

architecture Behavioral of Datapath is
	component GreaterComparator is
		port(
			A,B : in std_logic_vector(7 downto 0);
			greater : out std_logic
		);
	end component;
	
	component ZeroComparator is
	port( 
			A 		: in std_logic_vector(7 downto 0);
			Zero 	: out std_logic
		 );
	end component;
	
	component mux2 is
	port(
			A, B : in std_logic_vector(7 downto 0 );
			sel  : in std_logic;
			Output : out std_logic_vector(7 downto 0 )
		);
	end component;
	
	component registers is
	port(
				clk, reset, Load : in std_logic;
				D					  : in std_logic_vector(7 downto 0);
				Q					  : out std_logic_vector(7 downto 0)
		 );
	end component;
	signal Xout, LargeOutput, mux1Out, sLargeOutput, mux2Out  : std_logic_vector(7 downto 0);
	signal display	: std_logic;
begin
	
	XRegister : registers port map (
													clk   => clk, 
													reset	=> reset, 
													Load  => Xload,
													D	   => Input,				  
													Q		=> Xout			  
												);
	
	LargestRegister : registers port map (
													clk   => clk, 
													reset	=> reset, 
													Load  => Yload,
													D	   => Xout,				  
													Q		=> LargeOutput			  
												);
												
	SLargestRegister : registers port map (
													clk   => clk, 
													reset	=> reset, 
													Load  => Zload,
													D	   => mux1Out,				  
													Q		=> sLargeOutput			  
												);
	
	Firstmuxportmap					: mux2 port map(
													A      => Xout, 
													B  	 => LargeOutput,
													sel 	 => mux1Sel,
													Output => mux1Out 
												);
	
	
	Secondmux			: mux2 port map(
													A      => LargeOutput, 
													B  	 => sLargeOutput,
													sel 	 => mux2Sel,
													Output => mux2Out 
												);
												
												
	Greaterstatus 	: GreaterComparator port map(
																	A			=> xOut,
																	B 			=> mux2Out,
																	greater 	=> GreaterOutput
																);
	EqualOutput <= '1' when xOut = LargeOutput else '0';
																
	Zerostatus		: ZeroComparator port map( 
																A 		=> xOut,
																Zero 	=> zeroOutput
														);

	Lout 		<= LargeOutput when (display = '1' or displayButt = '1') else (others => '0');
	sLout		<= sLargeOutput when (display = '1' or displayButt = '1') else (others => '0');
	
	display <= displayOut;
		
end Behavioral;

