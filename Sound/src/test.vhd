library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.ALL;

entity Test is
end Test;
 
architecture behavior OF Test is 
  component Sound
    port(
      clk : in std_logic;
      switches : in unsigned(7 downto 0);
      leds : out unsigned(7 downto 0);
      analog : out std_logic
    );
end component Sound;
--Inputs
  signal switches : unsigned(7 downto 0) := "01000010";
  signal clk : std_logic := '0';
--Outputs
  signal leds : unsigned(7 downto 0);
  signal analog : std_logic := '0';
 
  constant clk_period : time := 5 ns;
 
begin
-- Instantiate the Unit Under Test (UUT)
  uut: Sound port map (
    clk      => clk, 
    switches => switches, 
    leds     => leds,
    analog   => analog
  );

  clck_process: process begin
    clk <= '0';
    wait for clk_period/2;
    clk <= '1';
    wait for clk_period/2;
  end process clck_process;
 

-- Stimulus process
  stim_proc: process begin		
    -- hold reset state for 100 ns.
    wait for 100 ns;
    
    wait for clk_period*10;
    
    
    wait;
  end process stim_proc;
end;
