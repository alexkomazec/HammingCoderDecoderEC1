library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity EC1_tb is
end;

architecture bench of EC1_tb is

COMPONENT EC1
PORT (
        Clock                               :   in std_logic;
        Reset                               :   in std_logic;
        Input_A                             :   in std_logic_vector(7 downto 0);
        IR_opcode                           :   out std_logic_vector(2 downto 0);
        Output                              :   out std_logic_vector(7 downto 0);
        Aneq0                               :   out std_logic;
        Halt                                :   out std_logic;
        ram_addr                            :   in  std_logic_vector(3 downto 0);
        RAM_Data                            :   in  std_logic_vector(7 downto 0);
        write_ram_enable                    :   in  std_logic
);
END COMPONENT;

signal Clock                                :   std_logic;
signal Reset                                :   std_logic;
signal Q_state                              :   std_logic_vector(2 downto 0);
signal Input_A                              :   std_logic_vector(7 downto 0);
signal Output                               :   std_logic_vector(7 downto 0);
signal Aneq0                                :   std_logic;
signal Halt                                 :   std_logic ;
signal IR_ROM_P                             :   std_logic_vector(7 downto 0);
signal PC_MUX_P                             :   std_logic_vector(3 downto 0);
signal RAM_Data                             :   std_logic_vector(7 downto 0);
signal write_ram_enable                     :   std_logic;
signal ram_addr                             :   std_logic_vector(3 downto 0);

begin

uut: EC1 port map ( 
    Clock               =>  Clock,
    Reset               =>  Reset,
    ram_addr            =>  ram_addr,
    write_ram_enable    =>  write_ram_enable,
    Input_A             =>  Input_A,
    Output              =>  Output,
    Aneq0               =>  Aneq0,
    Halt                =>  Halt,
    RAM_Data            =>  RAM_Data);

stimulus: process
begin
    Reset               <= '1','0' after 15 ns;
    ram_addr            <= "0000","0001" after 150 ns, "0010" after 350 ns, "0011" after 550 ns, "0100" after 750 ns, "0101" after 950 ns;
    RAM_Data            <= "01100000";--"10000000" after 150 ns, "10100000" after 350 ns,"11000001" after 550 ns,"11111111" after 750 ns,"00000000" after 950 ns,"00000000" after 1150 ns,"00000000" after 1350 ns,"00000000" after 1550 ns,"00000000" after 1750 ns,"00000000" after 1950 ns,"00000000" after 2150 ns,"00000000" after 2350 ns,"00000000" after 2550 ns,"00000000" after 2750 ns,"00000000" after 2950 ns;
                          --input      output                    dec                      jnz                       halt
    write_ram_enable    <= '1','0' after 3000 ns;
    Input_A             <= x"03";
wait;
end process;

clk_gen: process
begin
    Clock <= '0', '1' after 100 ns;
    wait for 200 ns;
end process;


end;