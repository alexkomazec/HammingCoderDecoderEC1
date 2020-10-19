library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity HammingDecoder7bit is

Port (
	input                  :   in      std_logic_vector(13 downto 0);
    output                 :   out     std_logic_vector(7 downto 0));
end HammingDecoder7bit;


architecture Behavioral of HammingDecoder7bit is

COMPONENT SyndromeCalculation PORT(
    input                   :   in std_logic_vector(6 downto 0);
    output                  :   out std_logic_vector(2 downto 0));
END COMPONENT;

COMPONENT BitCorrection PORT(
    input1                  :   in  std_logic_vector(2 downto 0);
    input2                  :   in  std_logic_vector(6 downto 0);
    output                  :   out std_logic_vector(3 downto 0));
END COMPONENT;

signal syn13to7_bc13to7     :   std_logic_vector(2 downto 0);
signal syn6to0_bc6to0       :   std_logic_vector(2 downto 0);
signal bc13to7_co           :   std_logic_vector(3 downto 0);
signal bc6to0_co            :   std_logic_vector(3 downto 0);

begin

SyndromeCalculation13to7 : SyndromeCalculation PORT MAP(
    input       =>  input(13 downto 7),
    output      =>  syn13to7_bc13to7);

SyndromeCalculation6to0 : SyndromeCalculation PORT MAP(
    input       =>  input(6 downto 0),
    output      =>  syn6to0_bc6to0);

BitCorrection13_7 : BitCorrection PORT MAP(
    input1      =>  syn13to7_bc13to7,
    input2      =>  input(13 downto 7),
    output      =>  bc13to7_co);

BitCorrection6_0 : BitCorrection PORT MAP(
    input1      =>  syn6to0_bc6to0,
    input2      =>  input(6 downto 0),
    output      =>  bc6to0_co);
    
output <=   bc13to7_co & bc6to0_co;

end Behavioral;