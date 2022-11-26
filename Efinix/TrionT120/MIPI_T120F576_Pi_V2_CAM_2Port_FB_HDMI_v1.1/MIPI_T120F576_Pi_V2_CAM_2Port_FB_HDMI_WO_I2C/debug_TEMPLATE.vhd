------------- Begin Cut here for COMPONENT Declaration ------
component edb_top
  port (
         bscan_CAPTURE : in  std_logic;
         bscan_DRCK    : in  std_logic;
         bscan_RESET   : in  std_logic;
         bscan_RUNTEST : in  std_logic;
         bscan_SEL     : in  std_logic;
         bscan_SHIFT   : in  std_logic;
         bscan_TCK     : in  std_logic;
         bscan_TDI     : in  std_logic;
         bscan_TMS     : in  std_logic;
         bscan_UPDATE  : in  std_logic;
         bscan_TDO     : out std_logic;
         VIO_0_clk     : in  std_logic;
         VIO_0_MIPI_TYPE : in  std_logic_vector(5 downto 0);
         VIO_0_MIPI_HSYNC : in  std_logic;
         VIO_0_MIPI_VSYNC : in  std_logic;
         VIO_0_MIPI_SCNT : in  std_logic_vector(3 downto 0);
         VIO_0_MIPI_DATA : in  std_logic_vector(62 downto 0);
         VIO_0_MIPI_VALID : in  std_logic;
         VIO_0_MIPI_VC : in  std_logic_vector(1 downto 0);
         VIO_0_MIPI_ERROR : in  std_logic_vector(17 downto 0);
         VIO_0_I2C_STATE : in  std_logic_vector(2 downto 0);
         VIO_0_I2C_REG_DOUT : in  std_logic_vector(9 downto 0);
         VIO_0_PROBE_TRIGGER : out std_logic;
         VIO_0_RED_GAIN : out std_logic_vector(2 downto 0);
         VIO_0_GREEN_GAIN : out std_logic_vector(2 downto 0);
         VIO_0_BLUE_GAIN : out std_logic_vector(2 downto 0);
         VIO_0_X_WIN   : out std_logic_vector(10 downto 0);
         VIO_0_X_START : out std_logic_vector(10 downto 0);
         VIO_0_Y_WIN   : out std_logic_vector(10 downto 0);
         VIO_0_Y_START : out std_logic_vector(10 downto 0);
         VIO_0_X_POINTER : out std_logic_vector(10 downto 0);
         VIO_0_Y_POINTER : out std_logic_vector(10 downto 0);
         VIO_0_RED_BACK : out std_logic_vector(9 downto 0);
         VIO_0_GREEN_BACK : out std_logic_vector(9 downto 0);
         VIO_0_BLUE_BACK : out std_logic_vector(9 downto 0);
         VIO_0_MIPI_CLEAR : out std_logic;
         VIO_0_I2C_REG_WE : out std_logic;
         VIO_0_I2C_REG_DIN : out std_logic_vector(7 downto 0);
         VIO_0_I2C_REG_ADDR : out std_logic_vector(9 downto 0);
         VIO_0_I2C_REG_RECONFIG : out std_logic
       );
end component ;
---------------------- End COMPONENT Declaration ------------

-- The following code must appear in the VHDL architecture
-- body. Substitute your own instance name and net names.

------------- Begin Cut here for INSTANTIATION Template -----
edb_top_inst : edb_top
port map (
           bscan_CAPTURE => jtag_inst1_CAPTURE,
           bscan_DRCK    => jtag_inst1_DRCK,
           bscan_RESET   => jtag_inst1_RESET,
           bscan_RUNTEST => jtag_inst1_RUNTEST,
           bscan_SEL     => jtag_inst1_SEL,
           bscan_SHIFT   => jtag_inst1_SHIFT,
           bscan_TCK     => jtag_inst1_TCK,
           bscan_TDI     => jtag_inst1_TDI,
           bscan_TMS     => jtag_inst1_TMS,
           bscan_UPDATE  => jtag_inst1_UPDATE,
           bscan_TDO     => jtag_inst1_TDO,
           VIO_0_clk     => #INSERT_YOUR_CLOCK_NAME,
           VIO_0_MIPI_TYPE => VIO_0_MIPI_TYPE,
           VIO_0_MIPI_HSYNC => VIO_0_MIPI_HSYNC,
           VIO_0_MIPI_VSYNC => VIO_0_MIPI_VSYNC,
           VIO_0_MIPI_SCNT => VIO_0_MIPI_SCNT,
           VIO_0_MIPI_DATA => VIO_0_MIPI_DATA,
           VIO_0_MIPI_VALID => VIO_0_MIPI_VALID,
           VIO_0_MIPI_VC => VIO_0_MIPI_VC,
           VIO_0_MIPI_ERROR => VIO_0_MIPI_ERROR,
           VIO_0_I2C_STATE => VIO_0_I2C_STATE,
           VIO_0_I2C_REG_DOUT => VIO_0_I2C_REG_DOUT,
           VIO_0_PROBE_TRIGGER => VIO_0_PROBE_TRIGGER,
           VIO_0_RED_GAIN => VIO_0_RED_GAIN,
           VIO_0_GREEN_GAIN => VIO_0_GREEN_GAIN,
           VIO_0_BLUE_GAIN => VIO_0_BLUE_GAIN,
           VIO_0_X_WIN   => VIO_0_X_WIN,
           VIO_0_X_START => VIO_0_X_START,
           VIO_0_Y_WIN   => VIO_0_Y_WIN,
           VIO_0_Y_START => VIO_0_Y_START,
           VIO_0_X_POINTER => VIO_0_X_POINTER,
           VIO_0_Y_POINTER => VIO_0_Y_POINTER,
           VIO_0_RED_BACK => VIO_0_RED_BACK,
           VIO_0_GREEN_BACK => VIO_0_GREEN_BACK,
           VIO_0_BLUE_BACK => VIO_0_BLUE_BACK,
           VIO_0_MIPI_CLEAR => VIO_0_MIPI_CLEAR,
           VIO_0_I2C_REG_WE => VIO_0_I2C_REG_WE,
           VIO_0_I2C_REG_DIN => VIO_0_I2C_REG_DIN,
           VIO_0_I2C_REG_ADDR => VIO_0_I2C_REG_ADDR,
           VIO_0_I2C_REG_RECONFIG => VIO_0_I2C_REG_RECONFIG
         );
------------------------ End INSTANTIATION Template ---------

--------------------------------------------------------------------------------
-- Copyright (C) 2013-2019 Efinix Inc. All rights reserved.              
--
-- This   document  contains  proprietary information  which   is        
-- protected by  copyright. All rights  are reserved.  This notice       
-- refers to original work by Efinix, Inc. which may be derivitive       
-- of other work distributed under license of the authors.  In the       
-- case of derivative work, nothing in this notice overrides the         
-- original author's license agreement.  Where applicable, the           
-- original license agreement is included in it's original               
-- unmodified form immediately below this header.                        
--                                                                       
-- WARRANTY DISCLAIMER.                                                  
--     THE  DESIGN, CODE, OR INFORMATION ARE PROVIDED “AS IS” AND        
--     EFINIX MAKES NO WARRANTIES, EXPRESS OR IMPLIED WITH               
--     RESPECT THERETO, AND EXPRESSLY DISCLAIMS ANY IMPLIED WARRANTIES,  
--     INCLUDING, WITHOUT LIMITATION, THE IMPLIED WARRANTIES OF          
--     MERCHANTABILITY, NON-INFRINGEMENT AND FITNESS FOR A PARTICULAR    
--     PURPOSE.  SOME STATES DO NOT ALLOW EXCLUSIONS OF AN IMPLIED       
--     WARRANTY, SO THIS DISCLAIMER MAY NOT APPLY TO LICENSEE.           
--                                                                       
-- LIMITATION OF LIABILITY.                                              
--     NOTWITHSTANDING ANYTHING TO THE CONTRARY, EXCEPT FOR BODILY       
--     INJURY, EFINIX SHALL NOT BE LIABLE WITH RESPECT TO ANY SUBJECT    
--     MATTER OF THIS AGREEMENT UNDER TORT, CONTRACT, STRICT LIABILITY   
--     OR ANY OTHER LEGAL OR EQUITABLE THEORY (I) FOR ANY INDIRECT,      
--     SPECIAL, INCIDENTAL, EXEMPLARY OR CONSEQUENTIAL DAMAGES OF ANY    
--     CHARACTER INCLUDING, WITHOUT LIMITATION, DAMAGES FOR LOSS OF      
--     GOODWILL, DATA OR PROFIT, WORK STOPPAGE, OR COMPUTER FAILURE OR   
--     MALFUNCTION, OR IN ANY EVENT (II) FOR ANY AMOUNT IN EXCESS, IN    
--     THE AGGREGATE, OF THE FEE PAID BY LICENSEE TO EFINIX HEREUNDER    
--     (OR, IF THE FEE HAS BEEN WAIVED, $100), EVEN IF EFINIX SHALL HAVE 
--     BEEN INFORMED OF THE POSSIBILITY OF SUCH DAMAGES.  SOME STATES DO 
--     NOT ALLOW THE EXCLUSION OR LIMITATION OF INCIDENTAL OR            
--     CONSEQUENTIAL DAMAGES, SO THIS LIMITATION AND EXCLUSION MAY NOT   
--     APPLY TO LICENSEE.                                                
--
--------------------------------------------------------------------------------
