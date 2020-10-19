library ieee;
library work;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.ram_pkg.all;

entity DataPath is
generic (
    RAM_WIDTH : integer:= 14;   
    RAM_DEPTH : integer:= 292 );   
Port (
	Clock,Reset                     : in    std_logic;
	IRload,PCload,INmux,Aload,JNZmux: in    std_logic;
    ram_addr                        : in    std_logic_vector(3 downto 0);
    write_ram_enable                : in    std_logic;
	Aneq0                           : out   std_logic;
    RAM_Data                        : in    std_logic_vector(7 downto 0);
	IRtoCU                          : out   std_logic_vector(2 downto 0);
	OUTPUT                          : out   std_logic_vector(7 downto 0);
	INPUT                           : in    std_logic_vector(7 downto 0));
end DataPath;


architecture Behavioral of DataPath is

COMPONENT A_register PORT(
    Clear               : in std_logic;
	Load                : in std_logic;
    write_ram_enable    : in std_logic;
	clk                 : in std_logic;
	D                   : in std_logic_vector(7 downto 0);
	A                   : out std_logic_vector(7 downto 0) );
END COMPONENT;

COMPONENT IR_register PORT(
    Clear               : in std_logic;
    Load                : in std_logic;
    write_ram_enable    : in std_logic;
    clk                 : in std_logic;
    D                   : in std_logic_vector(7 downto 0);
    IR                  : out std_logic_vector(7 downto 0) );
END COMPONENT;

COMPONENT PC_register PORT(
    Clear               : in std_logic;
    Load                : in std_logic;
    write_ram_enable    : in std_logic;
    clk                 : in std_logic;
    D                   : in std_logic_vector(3 downto 0);
    PC                  : out std_logic_vector(3 downto 0) );
END COMPONENT;

COMPONENT Increment_4bits PORT(
input1          : in std_logic_vector(3 downto 0);
output1         : out std_logic_vector(3 downto 0) );
END COMPONENT;

COMPONENT decrement_8bits PORT(
    input1      : in std_logic_vector(7 downto 0);
    output1     : out std_logic_vector(7 downto 0));
END COMPONENT;

COMPONENT Mux_2to1 PORT(
    x1          : in std_logic_vector(3 downto 0);
    x2          : in std_logic_vector(3 downto 0);
    sel         : in std_logic;
    y           : out std_logic_vector(3 downto 0));
END COMPONENT;

COMPONENT Mux_2to1_8bits PORT(
    x1          : in std_logic_vector(7 downto 0);
    x2          : in std_logic_vector(7 downto 0);
    sel         : in std_logic;
    y           : out std_logic_vector(7 downto 0));
END COMPONENT;

COMPONENT ORgate PORT(
    in1         : in std_logic_vector(7 downto 0);
    out1        : out std_logic ); 
END COMPONENT;

COMPONENT HammingEncoder PORT(
	input                           :   in      std_logic_vector(7 downto 0);
    output                          :   out     std_logic_vector(13 downto 0));
END COMPONENT;

COMPONENT HammingDecoder7bit PORT(
	input                  :   in      std_logic_vector(13 downto 0);
    output                 :   out     std_logic_vector(7 downto 0)); 
END COMPONENT;

COMPONENT RAM_14bits PORT(
    addra : in std_logic_vector((clogb2(RAM_DEPTH)-1) downto 0);
    dina  : in std_logic_vector(RAM_WIDTH-1 downto 0);		    
    clka  : in std_logic;                       			    
    wea   : in std_logic;                       			    
    douta : out std_logic_vector(RAM_WIDTH-1 downto 0));   		
END COMPONENT;

signal A_MUX_S,A_OR_DEC_OUT_S,DEC_MUX_S : std_logic_vector(7 downto 0);
signal IR_75_S                          : std_logic_vector(7 downto 5);
signal IR_30_S                          : std_logic_vector(3 downto 0);
signal IR_ROM_S                         : std_logic_vector(7 downto 0);
signal PC_MUX_S,PC_INC_ADD_S            : std_logic_vector(3 downto 0);
signal INC_MUX_S                        : std_logic_vector(3 downto 0);
signal ham_enc_out                      : std_logic_vector(13 downto 0);
signal ham_dec_in                       : std_logic_vector(13 downto 0);
signal none                             : std_logic;
signal non_used                         : std_logic_vector(3 downto 0);
signal mux_out                          : std_logic_vector(3 downto 0); 
signal mux_in                           : std_logic_vector(3 downto 0);


begin

A : A_register PORT MAP( 
    Clear               =>Reset,
    Load                =>Aload,
    write_ram_enable    =>write_ram_enable,
    clk                 =>Clock,
    D                   =>A_MUX_S,
    A                   =>A_OR_DEC_OUT_S);

IR : IR_register PORT MAP(
    Clear               =>Reset,
    load                =>IRload,
    write_ram_enable    =>write_ram_enable,
    clk                 =>Clock,
    D                   =>IR_ROM_S,
    IR(7 downto 5)      =>IRtoCU,
    IR(4)               =>none,
    IR(3 downto 0)      =>IR_30_S);

PC : PC_register PORT MAP(
    Clear               =>Reset,
    Load                =>PCload,
    write_ram_enable    =>write_ram_enable,
    clk                 =>Clock,
    D                   =>PC_MUX_S,
    PC                  =>mux_in);

INC : Increment_4bits PORT MAP(
    input1          => mux_out,
    output1         => INC_MUX_S);

MUX4bit : Mux_2to1 PORT MAP(
    x1              =>IR_30_S,
    x2              =>INC_MUX_S,
    sel             =>JNZmux,
    y               =>PC_MUX_S);

MUX8bit : Mux_2to1_8bits PORT MAP(
    x1              =>INPUT,
    x2              =>DEC_MUX_S,
    sel             =>INmux,
    y               =>A_MUX_S);

ORG : ORgate PORT MAP(
    in1             =>A_OR_DEC_OUT_S,
    out1            =>Aneq0 );

HDEC : HammingDecoder7bit PORT MAP(
    input             =>ham_dec_in,
    output            =>IR_ROM_S );

HENC : HammingEncoder PORT MAP(
    input             =>RAM_Data,
    output            =>ham_enc_out );

RAM : RAM_14bits PORT MAP(
    addra(3 downto 0)                       => mux_out,
    addra((clogb2(RAM_DEPTH)-1) downto 4)   => non_used,
    dina                                    => ham_enc_out,
    clka                                    => Clock,
    wea                                     => write_ram_enable,
    douta                                   => ham_dec_in);

DEC : decrement_8bits PORT MAP(
    input1          =>A_OR_DEC_OUT_S,
    output1         =>DEC_MUX_S);

mux_out <= ram_addr when (write_ram_enable = '1') else mux_in;

OUTPUT              <=A_OR_DEC_OUT_S;

end Behavioral;