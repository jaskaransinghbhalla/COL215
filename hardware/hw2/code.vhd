LIBRARY ieee;
USE ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity tb_rom_block is
end tb_rom_block;

architecture behaviour of tb_rom_block is

component dist_mem_gen_0
port(
    a : in std_logic_vector(15 downto 0);
    spo: out std_logic_vector(7 downto 0)

   );
end component;

component dist_mem_gen_1
port(
    a : in std_logic_vector(15 downto 0);
    d : in std_logic_vector(7 downto 0);
    clk : in std_logic;
    we : in std_logic;
    spo : out std_logic_vector(7 downto 0)
    );
end component;

signal rom_rdaddress : std_logic_vector(15 downto 0) := "0000000000000000";
signal rom_data : std_logic_vector(7 downto 0) ;

signal i : integer := 0;
signal ram_rdaddress : std_logic_vector(15 downto 0);
signal ram_in_data : std_logic_vector(7 downto 0) ;
signal rclk : std_logic ;
signal enable : std_logic := '1';
signal ram_out_data : std_logic_vector(7 downto 0);

signal clock_cycle : integer := 0;

signal curr  : std_logic_vector (7 downto 0) ;
signal prev : std_logic_vector (7 downto 0);
signal next : std_logic_vector (7 downto 0);

signal curr_val : integer;
signal prev_val : integer;
signal next_val : integer;
signal data_val : integer;

constant clock_period : time := 1 ns;

begin

uut : dist_mem_gen_0 port map(

a => rom_rdaddress, spo => rom_data);

uut1 : dist_mem_gen_1  port map(
a => ram_rdaddress , d => ram_in_data, spo => ram_out_data , clk => rclk, we => enable);

clock_proc : process
begin
rclk <= '0';
wait for clock_period /2;
rclk <= '1';
wait for clock_period/2 ;
end process;

stim_proc  : process(rclk)
begin
if(i < 65536) then  
    if(i = 0) then 
        rom_rdaddress <= std_logic_vector(to_unsigned(i,16));
        curr  <= rom_data;
        i <= i + 1;
    else     
    rom_rdaddress <= std_logic_vector(to_unsigned(i,16));
    next <=rom_data;
    if(rising_edge(rclk)) then
        if(clock_cycle = 0) then 
         ram_rdaddress <= std_logic_vector(to_unsigned(i-1,16));
         if((i-1)mod 256 = 0 ) then
            curr_val <= to_integer(unsigned(curr ));
            next_val <= to_integer(unsigned(next));
            data_val <= (next_val - 2*curr_val);
            if(data_val < 0) then
                data_val <= 0;
            elsif(data_val > 255) then
                 data_val  <= 255;
            end if;
            ram_in_data <= std_logic_vector(to_unsigned(data_val,8));
         elsif((i-1)mod 256 = 255 )then
         curr_val <= to_integer(unsigned(curr ));
            prev_val <= to_integer(unsigned(prev));
            data_val <= prev_val - 2*curr_val;
            if(data_val < 0) then
                data_val <= 0;
            elsif(data_val > 255) then
                 data_val  <= 255;
            end if;
            ram_in_data <= std_logic_vector(to_unsigned(data_val,8));
         else
         curr_val <= to_integer(unsigned(curr ));
            next_val <= to_integer(unsigned(next));
            prev_val <= to_integer(unsigned(prev));
            data_val <= prev_val + next_val - 2*curr_val;
            if(data_val < 0) then
                data_val <= 0;
            elsif(data_val > 255) then
                 data_val  <= 255;
            end if;
            ram_in_data <= std_logic_vector(to_unsigned(data_val,8));
         end if;
         prev <= curr ;
         curr  <= next;
        i<= i+1;
        clock_cycle <= clock_cycle + 1;
        
        elsif (clock_cycle = 1) then
        clock_cycle <= clock_cycle + 1;
        
        elsif (clock_cycle = 2) then
        clock_cycle <= 0;
        end if;
     end if;   
end if;
end if;
end process;
end behaviour;