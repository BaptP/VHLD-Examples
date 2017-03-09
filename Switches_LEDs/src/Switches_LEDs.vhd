
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;


entity Switches_LEDs is
  Port ( 
    switches : in  STD_LOGIC_VECTOR (7 downto 0);
    LEDs : out  STD_LOGIC_VECTOR (7 downto 0);
    clck : in STD_LOGIC;
    reset : in STD_LOGIC;
    seg : out STD_LOGIC_VECTOR (6 downto 0);
    dig : out STD_LOGIC_VECTOR (3 downto 0)
  );
end Switches_LEDs;

architecture Behavioral of Switches_LEDs is
  signal val : UNSIGNED(31 downto 0) := (others => '0');
  signal nVa : UNSIGNED(31 downto 0) := (others => '0');
  signal segD : STD_LOGIC_VECTOR (6 downto 0);
  signal preLEDs : STD_LOGIC_VECTOR (7 downto 0);

  signal digs : UNSIGNED (3 downto 0) := (others => '0'); 
  signal digt : STD_LOGIC_VECTOR (3 downto 0) := (others => '0');
  signal dig1 : UNSIGNED (3 downto 0) := (others => '0');
  signal dig2 : UNSIGNED (3 downto 0) := (others => '0');
  signal dig3 : UNSIGNED (3 downto 0) := (others => '0');
  signal ndig1 : UNSIGNED (3 downto 0) := (others => '0');
  signal ndig2 : UNSIGNED (3 downto 0) := (others => '0');
  signal ndig3 : UNSIGNED (3 downto 0) := (others => '0');
COMPONENT Digits
  PORT(
    value : IN std_logic_vector(3 downto 0);          
    digit : OUT std_logic_vector(6 downto 0)
  );
END COMPONENT;
begin
  clock : process(clck)
  begin
    if rising_edge(clck) then
      if val(24) /= nVa(24) OR reset = '0' then
        dig1 <= ndig1;
        dig2 <= ndig2;
        dig3 <= ndig3;
      end if;
      val <= nVa;
    end if;
  end process clock;
  
  nVa <= (others => '0') when reset='0' else val + 1;

  preLEDs <= STD_LOGIC_VECTOR(val(31 downto 24));
  LEDs <= preLEDs;

  ndig1 <= "0000" when reset = '0' OR preLEDs="11111111" else
           "0000" when dig1 = "1001" else dig1+1;
  ndig2 <= "0000" when reset = '0' OR preLEDs="11111111" else
           dig2 when dig1 /= "1001" else 
           dig2+1 when dig2 /= "1001" else "0000";
  ndig3 <= "0000" when reset = '0' OR preLEDs="11111111" else
           dig3 when dig2 /= "1001" OR dig1 /= "1001" else 
           dig3+1 when dig3 /= "1001" else "0000";


  Inst_Digits1: Digits port map(
    value => STD_LOGIC_VECTOR(digs),
    digit => segD
  );

  with val(18 downto 17) select
    digs <= dig1 when "00",
            dig2 when "01",
            dig3 when "10",
            "0000" when "11",
            "0000" when others;

  seg <= segD when switches(7) = '0' else switches(6 downto 0);
  --seg <= switches(6 downto 0);
  --seg <= Digits(val(31 downto 24));
  with val(18 downto 17) select
    digt <= 
      "0111" when "00",
      "1011" when "01",
      "1101" when "10",
      "1110" when "11",
      "1111" when others;
  dig <= "1111" when reset = '0' else digt;
end Behavioral;


