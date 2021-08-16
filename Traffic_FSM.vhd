library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Traffic_FSM is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           Red_w : out STD_LOGIC;
           Green_w : out STD_LOGIC;
           Red_c : out STD_LOGIC;
           Yellow_c : out STD_LOGIC;
           Green_c : out STD_LOGIC);
end Traffic_FSM;


architecture Behavioral of Traffic_FSM is

type my_state is(start,walk,stop_walk,pre_drive,drive,stop_drive);

signal current_state : my_state;
signal count : STD_LOGIC_VECTOR (15 downto 0) := (others => '0');



begin


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


process(clk)
begin
    if rising_edge(clk) then
        if rst = '1' then
            current_state <= start;
            Red_w    <= '1';
            Green_w  <= '0';
            Red_c    <= '1';
            Yellow_c <= '0';
            Green_c  <= '0';   
        else
            case current_state is
                when start =>
                       Red_w    <= '1';
                       Green_w  <= '0';
                       Red_c    <= '1';
                       Yellow_c <= '0';
                       Green_c  <= '0'; 
                    if count=100 then
                       current_state <= walk;
                    end if;
                when walk =>
                       Red_w    <= '0';
                       Green_w  <= '1';
                       Red_c    <= '1';
                       Yellow_c <= '0';
                       Green_c  <= '0';
                     if count=1000 then
                       current_state <= stop_walk;
                     end if;
                when stop_walk =>
                       Red_w    <= '1';
                       Green_w  <= '0';
                       Red_c    <= '1';
                       Yellow_c <= '0';
                       Green_c  <= '0';  
                     if count=1100 then
                       current_state <= pre_drive;
                     end if;
                when pre_drive =>
                       Red_w    <= '1';
                       Green_w  <= '0';
                       Red_c    <= '0';
                       Yellow_c <= '1';
                       Green_c  <= '0';  
                     if count=1200 then
                       current_state <= drive;
                     end if;
                when drive =>
                       Red_w    <= '1';
                       Green_w  <= '0';
                       Red_c    <= '0';
                       Yellow_c <= '0';
                       Green_c  <= '1';  
                     if count=2200 then
                       current_state <= stop_drive;
                     end if;
                when stop_drive =>
                       Red_w    <= '1';
                       Green_w  <= '0';
                       Red_c    <= '1';
                       Yellow_c <= '0';
                       Green_c  <= '0';  
                     if count=2300 then
                       current_state <= start;
                     end if;
                when others =>
                       Red_w    <= '1';
                       Green_w  <= '0';
                       Red_c    <= '1';
                       Yellow_c <= '0';
                       Green_c  <= '0';  
            end case;
        end if;
    end if;
end process;

end Behavioral;
