LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
use ieee.numeric_std.all;

ENTITY input_ROM IS
END input_ROM;
ARCHITECTURE behavior OF input_ROM IS
COMPONENT dist_mem_gen_2
PORT(
a : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
spo : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
);
END COMPONENT;
COMPONENT dist_mem_gen_1
PORT(
clk : IN STD_LOGIC;
a : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
spo : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
we : IN STD_LOGIC;
d : IN STD_LOGIC_VECTOR(7 DOWNTO 0)
);
END COMPONENT;
signal rdaddress : std_logic_vector(15 downto 0) := (others => '0');
signal rdaddress_prv : std_logic_vector(15 downto 0) := (others => '0');
signal rdaddress_nxt : std_logic_vector(15 downto 0) := (others => '0');
signal data : std_logic_vector(7 downto 0) := (others => '0');
signal data_out : std_logic_vector(7 downto 0) := (others => '0');
signal data_prv : std_logic_vector(7 downto 0) := (others => '0');
signal data_nxt : std_logic_vector(7 downto 0) := (others => '0');
signal res_pixel: std_logic_vector(7 downto 0) := (others => '0');
signal write_enable: std_logic :='0';
signal clock : std_logic := '0';
constant clock_period : time := 4 ns;

--signal i: integer:=0;
--signal rdaddress_out : std_logic_vector(15 downto 0) := (others => '0');

BEGIN
-- ROM
uut: dist_mem_gen_2 PORT MAP (
spo => data,
a => rdaddress
);
uut_prv: dist_mem_gen_2 PORT MAP (
spo => data_prv,
a => rdaddress_prv
);
uut_nxt: dist_mem_gen_2 PORT MAP (
spo => data_nxt,
a => rdaddress_nxt
);

-- RAM
uut_out: dist_mem_gen_1 PORT MAP (
clk => clock,
spo => data_out,
a => rdaddress,
we => write_enable,
d => res_pixel
);

clock_process :process
begin
clock <= '0';
wait for clock_period/2;
clock <= '1';
wait for clock_period/2;
end process;


p1 : process

variable t0: std_logic_vector(7 downto 0) := (others=> '0');
variable t1: std_logic_vector(7 downto 0) := (others=> '0');
variable t2: std_logic_vector(7 downto 0) := (others=> '0');
variable t0_int: integer ;
variable t0_mul: std_logic_vector(8 downto 0) ;
variable result: integer;
begin

for i in 0 to 65535 loop
rdaddress <= std_logic_vector(to_unsigned(i, 16));
rdaddress_nxt<= std_logic_vector(to_unsigned((i+1) mod 65535, 16));
rdaddress_prv<= std_logic_vector(to_unsigned(((i-1)+ 65535)mod 65535, 16));
wait for 1ns ;
if i mod 256 = 0 then
t1:= data_nxt;
elsif i+1 mod 256 = 0 then
t2:= data_prv;
else
t1:= data_nxt;
t2:= data_prv;
end if;
t0:=data;
t0_int:=to_integer(unsigned(t0));
result:=to_integer(unsigned(t1))+to_integer(unsigned(t2))-(2*t0_int);
if result < 0 then
result:= 0;
elsif result > 255 then
result:= 255;
end if;
--t0_mul:= std_logic_vector(to_unsigned(2 * t0_int,8));
write_enable <= '1';
wait for 1 ns;
res_pixel<=std_logic_vector(to_unsigned(result,8));
wait for 1 ns;
write_enable <= '0';
wait for 1 ns;
end loop;
wait;

end process p1;
end behavior;



entity ten_bit_adder is
PORT (
A: IN STD_LOGIC_VECTOR(9 downto 0);
B: IN STD_LOGIC_VECTOR(9 downto 0);
Sum : OUT STD_LOGIC_VECTOR(9 downto 0);
);
end ten_bit_adder;
architecture behavioral of ten_bit_adder is
begin
process(A,B)
variable temp: std_logic_vector(10 downto 0):= (others=>'0');
begin
for i in 0 to 9 loop
temp(i+1):= (A(i) and B(i)) or (temp(i) and A(i)) or (B(i) and temp(i));
Sum(i)<=A(i) xor B(i) xor temp(i);
wait for 20ns;
end loop;
end process;
end behavioral;

entity complement is
PORT (
A: IN STD_LOGIC_VECTOR( 9 downto 0);
B: OUT STD_LOGIC_VECTOR( 9 downto 0);
);
end complement;
architecture behavioral of complement is

begin
process(A)
variable temp: std_logic_vector(9 downto 0);
begin
temp(0) := '1';
temp(9) := '1';
for i in 0 to 7 loop
temp(i+1):= not A(i);
end loop;
temp:= temp + "0000000001";
B<=temp;
end process;
end behavioral;

entity TestBench is
--  Port ( );
end TestBench;

architecture Behavioral of TestBench is
begin
end Behavioral;