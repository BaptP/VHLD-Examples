library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.ALL;

entity Sound is
  port(
    clk : in std_logic;
    switches : in unsigned(7 downto 0);
    leds : out unsigned(7 downto 0);
    analog : out std_logic
  );
end Sound;

architecture Behavioral of Sound is
  component DAC is
    port(    
      clk : in  std_logic;
      fre : in  unsigned(7 downto 0);
      sig : out std_logic
    );
  end component DAC;
  
  component counter30 is
    port(
      clk  : in  std_logic;
      sclr : in  std_logic;
      q    : out std_logic_vector(29 downto 0)
    );
  end component counter30;
  
  component memory is
    port (
      clka  : in  std_logic;
      wea   : in  std_logic_vector(0 downto 0);
      addra : in  std_logic_vector(9 downto 0);
      dina  : in  std_logic_vector(7 downto 0);
      douta : out std_logic_vector(7 downto 0)
    );
  end component;
  
  signal phase : unsigned(3 downto 0) := "0000";
  signal index : std_logic_vector(9 downto 0) := "0000000000";
  signal reset : std_logic := '1';
  signal value : std_logic_vector(7 downto 0) := "00000000";
  signal count : std_logic_vector(29 downto 0) := (others => '0');
  signal chang : unsigned(7 downto 0) := "00000000";
begin
  leds <= switches;
  
  out1 : DAC port map(
    clk => clk,
    fre => unsigned(value),
    sig => analog
  );
  
  counter : counter30 port map(
    clk  => clk,
    sclr => reset,
    q    => count
  );
  
  freq : process(clk, chang)
    variable nwPha : unsigned(3 downto 0) := "0000";
  begin
    if rising_edge(clk) then
      if chang = "00000000"  then
        reset <= '1';
        phase <= nwPha;
      else
        nwPha := phase + "00000001";
        reset <= '0';
      end if;
    end if;
  end process;
  
  ram : memory
  port map (
    clka => clk,
    wea => "0",
    addra => index,
    dina => "11111111",
    douta => value
  );
  
  index <= "000000" & std_logic_vector(phase);
  chang <= unsigned(count(14 downto 7)) xor switches;
  --analog <= phase;
  
end Behavioral;