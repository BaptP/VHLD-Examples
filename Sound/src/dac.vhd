library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.ALL;

entity DAC is
  Port (
    clk : in  std_logic;
    fre : in  unsigned(7 downto 0);
    sig : out std_logic
  );
end DAC;

architecture Behavioral of DAC is
begin
  Emi : process (clk) 
    variable sum : unsigned(8 downto 0) := "010000000";
    variable prsig : std_logic := '0';
  begin
    if rising_edge(clk) then
      sum := (("0") & sum(7 downto 0)) + (("0") & fre);
      prsig := std_logic(sum(8));
      sig <= prsig;
    end if;
  end process Emi;
end Behavioral;
