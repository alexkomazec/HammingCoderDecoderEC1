library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity HammingDecoder_tb is
end;

architecture bench of HammingDecoder_tb is

COMPONENT HammingDecoder7bit
PORT (
    input                           :   in      std_logic_vector(13 downto 0);
    output                          :   out     std_logic_vector(7 downto 0)
);
END COMPONENT;

signal input    :   std_logic_vector(13 downto 0);
signal output   :   std_logic_vector(7 downto 0);


begin

uut: HammingDecoder7bit port map ( 
    input   =>  input,
    output  =>  output);

stimulus: process
begin
    
    input   <= "00000000000000";

wait;
end process;

end;