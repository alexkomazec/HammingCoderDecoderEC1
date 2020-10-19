library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity HammingEncoder_tb is
end;

architecture bench of HammingEncoder_tb is

COMPONENT HammingEncoder
PORT (
    input                           :   in      std_logic_vector(7 downto 0);
    output                          :   out     std_logic_vector(13 downto 0)
);
END COMPONENT;

signal input    :   std_logic_vector(7 downto 0);
signal output   :   std_logic_vector(13 downto 0);


begin

uut: HammingEncoder port map ( 
    input   =>  input,
    output  =>  output);

stimulus: process
begin
    
    input   <= "00000000","00010001" after 200 ns,"00100010" after 300 ns,"00110011" after 400 ns,"01000100" after 500 ns,"01010101" after 600 ns,"01100110" after 700 ns,"01110111" after 800 ns,"10001000" after 900 ns,"10011001" after 1000 ns,"10101010" after 1100 ns,"10111011" after 1200 ns,"11001100" after 1300 ns,"11011101" after 1400 ns,"11101110" after 1500 ns,"11111111" after 1600 ns;

wait;
end process;

end;