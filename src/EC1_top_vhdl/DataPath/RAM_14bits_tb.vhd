library ieee;
library work;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.ram_pkg.all;
USE std.textio.all;

entity RAM_14bits_tb is
generic (
    RAM_WIDTH : integer:= 14;                           -- Specify RAM data width
    RAM_DEPTH : integer:= 292                           -- Specify RAM depth (number of entries)
    );
end;

architecture bench of RAM_14bits_tb is

COMPONENT RAM_14bits
generic (
    RAM_WIDTH : integer:= RAM_WIDTH;                           -- Specify RAM data width
    RAM_DEPTH : integer:= RAM_DEPTH                            -- Specify RAM depth (number of entries)
    );

port (
        addra : in std_logic_vector((clogb2(RAM_DEPTH)-1) downto 0);        -- Address bus, width determined from RAM_DEPTH
        dina  : in std_logic_vector(RAM_WIDTH-1 downto 0);		            -- RAM input data
        clka  : in std_logic;                       			            -- Clock
        wea   : in std_logic;                       			            -- Write enable
        douta : out std_logic_vector(RAM_WIDTH-1 downto 0)   			    -- RAM output data
    );
END COMPONENT;

signal addra    :   std_logic_vector((clogb2(RAM_DEPTH)-1) downto 0);
signal dina     :   std_logic_vector(13 downto 0);
signal clka     :   std_logic;
signal wea      :   std_logic; 
signal douta    :   std_logic_vector(13 downto 0);


begin

uut: RAM_14bits port map ( 
    addra   =>  addra,
    dina    =>  dina,
    clka    =>  clka,
    wea     =>  wea,
    douta   =>  douta);

clk_gen: process
begin
    clka <= '0', '1' after 100 ns;
    wait for 200 ns;
end process;

stimulus: process
begin
    
    dina    <= "11111111111111";--"00010001" after 200 ns,"00100010" after 300 ns,"00110011" after 400 ns,"01000100" after 500 ns,"01010101" after 600 ns,"01100110" after 700 ns,"01110111" after 800 ns,"10001000" after 900 ns,"10011001" after 1000 ns,"10101010" after 1100 ns,"10111011" after 1200 ns,"11001100" after 1300 ns,"11011101" after 1400 ns,"11101110" after 1500 ns,"11111111" after 1600 ns;
    wea     <= '1','0' after 1350 ns;
    addra   <= "00000000","000000001" after 150 ns,"00000010" after 350 ns, "00000011" after 550 ns, "00000100" after 750 ns, "00000101" after 950 ns, "00000110" after 1150 ns, "00000111" after 1350 ns,"00000000" after 1550 ns,"00000001" after 1750 ns,"00000010" after 1950 ns, "00000011" after 2150 ns, "00000100" after 2350 ns, "00000101" after 2550 ns, "00000110" after 2750 ns;
   
wait;
end process;

end;