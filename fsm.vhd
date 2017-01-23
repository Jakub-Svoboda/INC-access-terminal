-- fsm.vhd: Finite State Machine
-- Author(s): Jakub Svoboda
-- login: xsvobo0z	
-- kod1 = 33677733168 	 kod2 = 33677866584
library ieee;
use ieee.std_logic_1164.all;
-- ----------------------------------------------------------------------------
--                        Entity declaration
-- ----------------------------------------------------------------------------
entity fsm is
port(
   CLK         : in  std_logic;
   RESET       : in  std_logic;

   -- Input signals
   KEY         : in  std_logic_vector(15 downto 0);
   CNT_OF      : in  std_logic;

   -- Output signals
   FSM_CNT_CE  : out std_logic;
   FSM_MX_MEM  : out std_logic;
   FSM_MX_LCD  : out std_logic;
   FSM_LCD_WR  : out std_logic;
   FSM_LCD_CLR : out std_logic
);
end entity fsm;

-- ----------------------------------------------------------------------------
--                      Architecture declaration
-- ----------------------------------------------------------------------------

architecture behavioral of fsm is
   type t_state is (TEST1, TEST2, TEST3,TEST4, TEST5, TEST6, FIRST_7, FIRST_8, FIRST_9, FIRST_10, FIRST_11, SECOND_7, SECOND_8, SECOND_9, SECOND_10, SECOND_11, SHARP, PRINT_MESSAGE_BAD,PRINT_MESSAGE_OK, WRONG, FINISH);
   signal present_state, next_state : t_state;

begin
-- -------------------------------------------------------
sync_logic : process(RESET, CLK)
begin
   if (RESET = '1') then
      present_state <= TEST1;
   elsif (CLK'event AND CLK = '1') then
      present_state <= next_state;
   end if;
end process sync_logic;

-- -------------------------------------------------------
next_state_logic : process(present_state, KEY, CNT_OF)
begin
   case (present_state) is
   -- - - - - - - - - - - - - - - - - - - - - - -
   when TEST1 =>
      next_state <= TEST1;
		if (KEY(3) = '1') then
			next_state <= TEST2;
      elsif (KEY(15) = '1') then
         next_state <= PRINT_MESSAGE_BAD; 
		elsif (KEY(14 downto 0) /= "000000000000000")	then
			next_state <= WRONG;
      end if;
		
	 when TEST2 =>
      next_state <= TEST2;
		if (KEY(3) = '1') then
			next_state <= TEST3;
      elsif (KEY(15) = '1') then
         next_state <= PRINT_MESSAGE_BAD; 
		elsif (KEY(14 downto 0) /= "000000000000000")	then
			next_state <= WRONG;
      end if;	
   -- - - - - - - - - - - - - - - - - - - - - - -
   when TEST3 =>
      next_state <= TEST3;
		if (KEY(6) = '1') then
			next_state <= TEST4;
      elsif (KEY(15) = '1') then
         next_state <= PRINT_MESSAGE_BAD; 
		elsif (KEY(14 downto 0) /= "000000000000000")	then
			next_state <= WRONG;
      end if;	
   -- - - - - - - - - - - - - - - - - - - - - - -
	 when TEST4 =>
      next_state <= TEST4;
		if (KEY(7) = '1') then
			next_state <= TEST5;
      elsif (KEY(15) = '1') then
         next_state <= PRINT_MESSAGE_BAD; 
		elsif (KEY(14 downto 0) /= "000000000000000")	then
			next_state <= WRONG;
      end if;	
   -- - - - - - - - - - - - - - - - - - - - - - -
	
	when TEST5 =>
      next_state <= TEST5;
		if (KEY(7) = '1') then
			next_state <= TEST6;
      elsif (KEY(15) = '1') then
         next_state <= PRINT_MESSAGE_BAD; 
		elsif (KEY(14 downto 0) /= "000000000000000")	then
			next_state <= WRONG;
      end if;	
   -- - - - - - - - - - - - - - - - - - - - - - -
	--------Prvni rozdilna cislice kodu
	when TEST6 =>		
      next_state <= TEST6;
		if (KEY(7) = '1') then
				next_state <= FIRST_7;
			elsif (KEY(8) = '1')then
				next_state <= SECOND_7;
      elsif (KEY(15) = '1') then
         next_state <= PRINT_MESSAGE_BAD; 
		elsif (KEY(14 downto 0) /= "000000000000000")	then
			next_state <= WRONG;
      end if;	
   -- - - - - - - - - - - - - - - - - - - - - - -
	when FIRST_7 =>
      next_state <= FIRST_7;
		if (KEY(3) = '1') then
			next_state <= FIRST_8;
      elsif (KEY(15) = '1') then
         next_state <= PRINT_MESSAGE_BAD; 
		elsif (KEY(14 downto 0) /= "000000000000000")	then
			next_state <= WRONG;
      end if;	
	 -- - - - - - - - - - - - - - - - - - - - - - -
	when FIRST_8 =>
      next_state <= FIRST_8;
		if (KEY(3) = '1') then
			next_state <= FIRST_9;
      elsif (KEY(15) = '1') then
         next_state <= PRINT_MESSAGE_BAD; 
		elsif (KEY(14 downto 0) /= "000000000000000")	then
			next_state <= WRONG;
      end if;		
	 -- - - - - - - - - - - - - - - - - - - - - - -
	when FIRST_9 =>
      next_state <= FIRST_9;
		if (KEY(1) = '1') then
			next_state <= FIRST_10;
      elsif (KEY(15) = '1') then
         next_state <= PRINT_MESSAGE_BAD; 
		elsif (KEY(14 downto 0) /= "000000000000000")	then
			next_state <= WRONG;
      end if;		
	 -- - - - - - - - - - - - - - - - - - - - - - -
	when FIRST_10 =>
      next_state <= FIRST_10;
		if (KEY(6) = '1') then
			next_state <= FIRST_11;
      elsif (KEY(15) = '1') then
         next_state <= PRINT_MESSAGE_BAD; 
		elsif (KEY(14 downto 0) /= "000000000000000")	then
			next_state <= WRONG;
      end if;	
	 -- - - - - - - - - - - - - - - - - - - - - - -
	when FIRST_11 =>
      next_state <= FIRST_11;
		if (KEY(8) = '1') then
			next_state <= SHARP;
      elsif (KEY(15) = '1') then
         next_state <= PRINT_MESSAGE_BAD; 
		elsif (KEY(14 downto 0) /= "000000000000000")	then
			next_state <= WRONG;
      end if;	
	
	 -- - - - - - - - - - - - - - - - - - - - - - -
	------Stavy pro druhou variantu kodu
	when SECOND_7 =>
      next_state <= SECOND_7;
		if (KEY(6) = '1') then
			next_state <= SECOND_8;
      elsif (KEY(15) = '1') then
         next_state <= PRINT_MESSAGE_BAD; 
		elsif (KEY(14 downto 0) /= "000000000000000")	then
			next_state <= WRONG;
      end if;
	-- - - - - - - - - - - - - - - - - - - - - - - - -
	when SECOND_8 =>
      next_state <= SECOND_8;
		if (KEY(6) = '1') then
			next_state <= SECOND_9;
      elsif (KEY(15) = '1') then
         next_state <= PRINT_MESSAGE_BAD; 
		elsif (KEY(14 downto 0) /= "000000000000000")	then
			next_state <= WRONG;
      end if;
		-- - - - - - - - - - - - - - - - - - - - - - - - -
	when SECOND_9 =>
      next_state <= SECOND_9;
		if (KEY(5) = '1') then
			next_state <= SECOND_10;
      elsif (KEY(15) = '1') then
         next_state <= PRINT_MESSAGE_BAD; 
		elsif (KEY(14 downto 0) /= "000000000000000")	then
			next_state <= WRONG;
      end if;
		-- - - - - - - - - - - - - - - - - - - - - - - - -
	when SECOND_10 =>
      next_state <= SECOND_10;
		if (KEY(8) = '1') then
			next_state <= SECOND_11;
      elsif (KEY(15) = '1') then
         next_state <= PRINT_MESSAGE_BAD; 
		elsif (KEY(14 downto 0) /= "000000000000000")	then
			next_state <= WRONG;
      end if;	
		-- - - - - - - - - - - - - - - - - - - - - - - - -
	when SECOND_11 =>
      next_state <= SECOND_11;
		if (KEY(4) = '1') then
			next_state <= SHARP;
      elsif (KEY(15) = '1') then
         next_state <= PRINT_MESSAGE_BAD; 
		elsif (KEY(14 downto 0) /= "000000000000000")	then
			next_state <= WRONG;
      end if;	
	-- - - - - - - - - - - - - - - - - - - - - - - - - - - - 
	when WRONG =>
		next_state <= WRONG;
		if (KEY(15) = '1') then
			next_state <= PRINT_MESSAGE_BAD;
		end if;	
	-------------------------------------------	
	when SHARP =>
		next_state <= SHARP;
		if (KEY(15) = '1') then
			next_state <= PRINT_MESSAGE_OK;
		elsif (KEY(14 downto 0) /= "000000000000000") then
			next_state <= WRONG;
		end if;	
			
	--------------------------------------------
	when PRINT_MESSAGE_BAD =>
      next_state <= PRINT_MESSAGE_BAD;
      if (CNT_OF = '1') then
         next_state <= FINISH;
      end if;
	--------------------------------------------
	when PRINT_MESSAGE_OK =>
      next_state <= PRINT_MESSAGE_OK;
      if (CNT_OF = '1') then
         next_state <= FINISH;
      end if;	
   -- - - - - - - - - - - - - - - - - - - - - - -
   when FINISH =>
      next_state <= FINISH;
      if (KEY(15) = '1') then
         next_state <= TEST1; 
      end if;
   -- - - - - - - - - - - - - - - - - - - - - - -
   when others =>
      
			
			
   end case;
end process next_state_logic;

-- -------------------------------------------------------
output_logic : process(present_state, KEY)
begin
   FSM_CNT_CE     <= '0';
   FSM_MX_MEM     <= '0';
   FSM_MX_LCD     <= '0';
   FSM_LCD_WR     <= '0';
   FSM_LCD_CLR    <= '0';

   case (present_state) is
   -- - - - - - - - - - - - - - - - - - - - - - -
   when TEST1 =>
      if (KEY(14 downto 0) /= "000000000000000") then
         FSM_LCD_WR     <= '1';
      end if;
      if (KEY(15) = '1') then
         FSM_LCD_CLR    <= '1';
      end if;
   -- - - - - - - - - - - - - - - - - - - - - - -
		
   when PRINT_MESSAGE_BAD =>
      FSM_CNT_CE     <= '1';
      FSM_MX_LCD     <= '1';
      FSM_LCD_WR     <= '1';
	----------------------------------------------
	when PRINT_MESSAGE_OK =>
      FSM_MX_MEM		<= '1';
		FSM_CNT_CE     <= '1';
      FSM_MX_LCD     <= '1';
      FSM_LCD_WR     <= '1';	
   -- - - - - - - - - - - - - - - - - - - - - - -
   when FINISH =>
      if (KEY(15) = '1') then
         FSM_LCD_CLR    <= '1';
      end if;
   -- - - - - - - - - - - - - - - - - - - - - - -
   when others =>
		if (KEY(14 downto 0) /= "000000000000000") then
			FSM_LCD_WR <= '1';
		end if;
		if (KEY(15) = '1') then
			FSM_LCD_CLR	<= '1';
		end if;	
		
   end case;
end process output_logic;

end architecture behavioral;

