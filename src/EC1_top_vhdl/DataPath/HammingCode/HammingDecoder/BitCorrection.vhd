library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity BitCorrection is
 port (
    input1                  :   in  std_logic_vector(2 downto 0);
    input2                  :   in  std_logic_vector(6 downto 0);
    output                  :   out std_logic_vector(3 downto 0));
end entity BitCorrection;

architecture Behavioral of BitCorrection is
signal output_s    :   std_logic_vector(3 downto 0);
begin

process(input2,input1) is
begin

     case input1 is
     
                when "100" =>
                    output_s      <=  input2(6)&input2(5)&input2(4)&(not(input2(3)));
                when "101" =>
                    output_s      <=  input2(6)&input2(5)&(not(input2(4)))&(input2(3));
                when "110" =>         
                    output_s      <=  input2(6)&(not(input2(5)))&input2(4)&(input2(3));
                when "111" =>         
                    output_s      <=  (not(input2(6)))&input2(5)&input2(4)&(input2(3));                    
                when others =>
                    output_s      <=   input2(6 downto 3);
                end case;
                
    end process;

output<=output_s;

end architecture Behavioral;