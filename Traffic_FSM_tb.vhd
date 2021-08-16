library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;


entity Traffic_FSM_tb is

end Traffic_FSM_tb;

architecture Behavioral of Traffic_FSM_tb is

component Traffic_FSM
    Port ( 
           clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           Red_w : out STD_LOGIC;
           Green_w : out STD_LOGIC;
           Red_c : out STD_LOGIC;
           Yellow_c : out STD_LOGIC;
           Green_c : out STD_LOGIC
           );
end component;

signal clk : STD_LOGIC :='0';
signal rst : STD_LOGIC :='0';
signal Red_w : STD_LOGIC :='1';
signal Green_w : STD_LOGIC :='0';
signal Red_c : STD_LOGIC :='1';
signal Yellow_c : STD_LOGIC :='0';
signal Green_c : STD_LOGIC :='0';
signal count : STD_LOGIC_VECTOR (15 downto 0) := (others => '0');

constant clock_period : time := 10 ns;

begin

uut: Traffic_FSM Port map ( 
           clk => clk,
           rst => rst,
           Red_w => Red_w,
           Green_w => Green_w,
           Red_c => Red_c,
           Yellow_c => Yellow_c,
           Green_c => Green_c
           );

process (clk)
begin
   if clk='1' and clk'event then
      if rst='1' or count=2400 then
         count <= (others => '0');
      else
         count <= count + 1;
      end if;
   end if;
end process;


rst <= '1', '0' after clock_period*2;
clk <= not clk after 1 ns;

end Behavioral;
