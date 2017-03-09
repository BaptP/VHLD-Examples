--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   09:19:25 02/13/2017
-- Design Name:   
-- Module Name:   /am/rialto/home2/baptiste/Switche_LEDs/tb_Switch_LEDs.vhd
-- Project Name:  Switche_LEDs
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Switches_LEDs
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY Test IS
END Test;
 
ARCHITECTURE behavior OF Test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Switches_LEDs
    PORT(
         switches : IN  std_logic_vector(7 downto 0);
         LEDs : OUT  std_logic_vector(7 downto 0);
         clck : IN  std_logic;
         reset : IN  std_logic;
         seg : OUT  std_logic_vector(6 downto 0);
         dig : OUT  std_logic_vector(3 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal switches : std_logic_vector(7 downto 0) := (others => '0');
   signal clck : std_logic := '0';
   signal reset : std_logic := '0';

 	--Outputs
   signal LEDs : std_logic_vector(7 downto 0);
   signal seg : std_logic_vector(6 downto 0);
   signal dig : std_logic_vector(3 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
   constant clck_period : time := 5 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Switches_LEDs PORT MAP (
          switches => switches,
          LEDs => LEDs,
          clck => clck,
          reset => reset,
          seg => seg,
          dig => dig
        );

   -- Clock process definitions
   clck_process :process
   begin
		clck <= '0';
		wait for clck_period/2;
		clck <= '1';
		wait for clck_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for clck_period*10;

      -- insert stimulus here 
		
		wait for 1000 us;
		reset <= '0';
      wait for clck_period*10;
		reset <= '1';
		
      wait;
   end process;

END;
