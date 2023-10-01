library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

ENTITY Gradient IS
    PORT ( clk : IN STD_LOGIC);
END Gradient;
ARCHITECTURE Behavioral OF Gradient IS
    COMPONENT dist_mem_gen_2
    PORT(
        clk: IN STD_LOGIC;
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
    signal address : std_logic_vector(15 downto 0) := (others => '0');    
    signal data : std_logic_vector(7 downto 0) := (others => '0');
    signal data_out : std_logic_vector(7 downto 0) := (others => '0');
    signal i: integer:=0;
    signal wr: std_logic := '1';
    signal res_pixel: std_logic_vector(7 downto 0) := (others => '0');
    signal enable : integer :=0;
    signal t0: std_logic_vector(7 downto 0) := (others=> '0');
    signal t1: std_logic_vector(7 downto 0) := (others=> '0');
    signal t2: std_logic_vector(7 downto 0) := (others=> '0');
    


BEGIN
uut: dist_mem_gen_2 PORT MAP (
	clk => clk,
        spo => data,
        a => rdaddress);

uut_out: dist_mem_gen_1 PORT MAP (
    clk => clk,
        spo => data_out,
        a => address,
        we => wr,
        d => res_pixel
    );



ROM : process(clk)      
    variable result: integer := 0;
begin
    if (i < 65536) then
	    if(rising_edge(clk)) then
	        if (enable = 0) then
            	rdaddress <= std_logic_vector(to_unsigned(i, 16));
            	
            	    result:=to_integer(unsigned(t1))+to_integer(unsigned(t2))-(2*to_integer(unsigned(t0)));
                                if (result < 0) then
                                    result:= 0;
                                elsif (result > 255) then
                                    result:= 255;
                                end if;
                                res_pixel<=std_logic_vector(to_unsigned(result,8));		
		        enable <= 1;
		    elsif (enable =1) then
		        --t0<=data;
		        enable <= 2;
		    elsif (enable =2) then
		        t0<=data;
		        rdaddress<= std_logic_vector(to_unsigned((i+1) mod 65536, 16));
		        enable <= 3;
		    elsif (enable =3) then
		        enable <= 4;
		    elsif (enable = 4) then
		        if i+1 mod 256 = 0 then
                                t1<= "00000000";
                else
                                t1<= data;
                            end if;
		        rdaddress<= std_logic_vector(to_unsigned(((i-1)+ 65536)mod 65536, 16));
		        enable <= 5;
		    elsif (enable =5) then
		       enable <= 6;
            elsif (enable =6) then
                if i mod 256 = 0 then
                                t2<= "00000000";
                else
                                t2<=data;
                end if;
		        
		        enable <= 0;
		        i <= i+1;
           	end if;
	    end if;
	end if;
end process;

RAM :process(clk)
begin
    if ( i > 0 and i <= 65536) then
        if(rising_edge(clk) and enable = 0) then
	    address <= std_logic_vector(to_unsigned(i-1, 16));				
        end if;
    end if;
end process;

end Behavioral;



-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;







-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;