library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Conversion is
  port(
    switches : in unsigned(7 downto 0);
    LEDs : out unsigned(7 downto 0);
    clk : in std_logic;
    seg : out std_logic_vector (6 downto 0);
    dig : out std_logic_vector (3 downto 0)
  );
end entity Conversion;

architecture Behavioural of Conversion is
component Digits
  port(
    value : in  std_logic_vector(3 downto 0);          
    digit : out std_logic_vector(6 downto 0)
  );
end component;
  signal dig0 : unsigned(3 downto 0);
  signal dig1 : unsigned(3 downto 0);
  signal dig2 : unsigned(3 downto 0);
  signal dig3 : unsigned(3 downto 0);
  signal digA : unsigned(3 downto 0);
  signal curr : unsigned(1 downto 0);
begin
  LEDs <= switches;
  
  display: process(clk)
    variable count : unsigned(15 downto 0);
  begin
    if rising_edge(clk) then
      count := count + 1;
      if count = "1111111111111111" then
        curr <= curr + 1;
      end if;
    end if;
  end process display;
  
  Inst_Digits1: Digits port map(
    value => STD_LOGIC_VECTOR(digA),
    digit => seg
  );
  
  with curr select
    dig <= 
      "0111" when "00",
      "1011" when "01",
      "1101" when "10",
      "1110" when "11",
      "1111" when others;
      
  with curr select
    digA <= dig0 when "00",
            dig1 when "01",
            dig2 when "10",
            dig3 when "11",
            "0000" when others;
            
  dig0 <= switches mod "1010";
  dig1 <= switches / "00001010" mod "1010";
  dig2 <= switches / "01100100" mod "1010";
end Behavioural;
