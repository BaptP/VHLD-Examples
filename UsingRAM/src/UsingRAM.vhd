----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:39:07 02/13/2017 
-- Design Name: 
-- Module Name:    UsingRAM - Behavioral 
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

entity UsingRAM is
    Port ( clk : in  STD_LOGIC;
           LEDs : out  STD_LOGIC_VECTOR (7 downto 0));
end UsingRAM;

architecture Behavioral of UsingRAM is
	COMPONENT counter30
	  PORT (
		 clk : IN STD_LOGIC;
                 sclr : IN STD_LOGIC;
		 q : OUT STD_LOGIC_VECTOR(29 DOWNTO 0)
	  );
	END COMPONENT;
	COMPONENT memory
	  PORT (
		 clka : IN STD_LOGIC;
		 wea : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
		 addra : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
		 dina : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 douta : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
	  );
	END COMPONENT;
	signal count : STD_LOGIC_VECTOR(29 downto 0);
	signal addr : STD_LOGIC_VECTOR(9 downto 0);
begin

addrCounter : counter30
  port map (
    clk => clk,
    sclr => '0',
    q => count(29 downto 0)
  );
rom : memory
  port map (
    clka => clk,
    wea => "0",
    addra => addr,
    dina => "11111111",
    douta => LEDs
  );
  
  addr <= "000"&count(26 downto 20);
end Behavioral;

