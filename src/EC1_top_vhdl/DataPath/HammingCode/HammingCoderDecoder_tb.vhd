library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity HammingCoderDecoder_tb is
end;

architecture bench of HammingCoderDecoder_tb is

COMPONENT HammingDecoder7bit
PORT (
    input                           :   in      std_logic_vector(13 downto 0);
    output                          :   out     std_logic_vector(7 downto 0)
);
END COMPONENT;

COMPONENT HammingEncoder
PORT (
    input                           :   in      std_logic_vector(7 downto 0);
    output                          :   out     std_logic_vector(13 downto 0)
);
END COMPONENT;


signal output_decoder   :   std_logic_vector(7 downto 0);
signal input_encoder    :   std_logic_vector(7 downto 0);
signal output_encoder   :   std_logic_vector(13 downto 0);



begin

uutdec: HammingDecoder7bit port map ( 
    input   =>  output_encoder,
    output  =>  output_decoder);

uutenc: HammingEncoder port map ( 
    input   =>  input_encoder,
    output  =>  output_encoder);

stimulus: process
begin
    
    input_encoder   <= "11111111";

wait;
end process;

end;