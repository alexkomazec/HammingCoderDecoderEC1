library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity HammingEncoder is

Port (
	input                           :   in      std_logic_vector(7 downto 0);
    output                          :   out     std_logic_vector(13 downto 0));
end HammingEncoder;


architecture Behavioral of HammingEncoder is

COMPONENT HammingEncoder4bit PORT(
    input           :   in  std_logic_vector(3 downto 0);
    output          :   out std_logic_vector(6 downto 0));
END COMPONENT;


COMPONENT CodeWordConcatenation PORT(
    input1          :   in  std_logic_vector(6 downto 0);
    input2          :   in  std_logic_vector(6 downto 0);
    output          :   out std_logic_vector(13 downto 0));
END COMPONENT;

signal pc7to4_co    :   std_logic_vector(6 downto 0);
signal pc3to0_co    :   std_logic_vector(6 downto 0);


begin

HammingEncoder4bit_7to4 : HammingEncoder4bit PORT MAP(
    input   =>  input(7 downto 4),
    output  =>  pc7to4_co);

HammingEncoder4bit_3to0 : HammingEncoder4bit PORT MAP(
    input   =>  input(3 downto 0),
    output  =>  pc3to0_co);
    
CodeWordConcatenation6to0_13to0 : CodeWordConcatenation PORT MAP(
    input1      =>  pc3to0_co,
    input2      =>  pc7to4_co,
    output      =>  output);

end Behavioral;