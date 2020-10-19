library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity SyndromeCalculation is
 port (
    input       :   in std_logic_vector(6 downto 0);
    output      :   out std_logic_vector(2 downto 0));
end entity SyndromeCalculation;

architecture Behavioral of SyndromeCalculation is

begin

output    <=  (input(5) xor input(4) xor input(3) xor input(2)) & (input(6) xor input(4) xor input(3) xor input(1)) & (input(6) xor input(5) xor input(3) xor input(0));

end architecture Behavioral;