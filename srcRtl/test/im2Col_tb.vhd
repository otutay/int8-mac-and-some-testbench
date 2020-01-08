-------------------------------------------------------------------------------
-- Title      : Testbench for design "im2Col"
-- Project    :
-------------------------------------------------------------------------------
-- File       : im2Col_tb.vhd
-- Author     : osmant  <otutaysalgir@gmail.com>
-- Company    :
-- Created    : 2020-01-08
-- Last update: 2020-01-08
-- Platform   :
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description:
-------------------------------------------------------------------------------
-- Copyright (c) 2020
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2020-01-08  1.0      otutay  Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library work;
use work.tilePckg.all;
use work.funcPckg.all;
use work.ramPckg.all;
-------------------------------------------------------------------------------

entity im2Col_tb is

end entity im2Col_tb;

-------------------------------------------------------------------------------

architecture im2Col_tb of im2Col_tb is


  constant clkPeriod : time                  := 10 ns;
  -- component ports
  signal iClk        : std_logic             := '0';
  signal iRst        : std_logic             := '0';
  signal iData       : tIm2ColIn             := cIm2ColIn;
  signal oData       : tIm2ColOut            := cIm2ColOut;
  signal counter     : unsigned(31 downto 0) := (others => '0');
  -- clock
  component im2Col is
    port (
      iClk  : in  std_logic;
      iRst  : in  std_logic;
      iData : in  tIm2ColIn;
      oData : out tIm2ColOut);
  end component im2Col;

begin
  im2Col_1 : im2Col
    port map (
      iClk  => iClk,
      iRst  => iRst,
      iData => iData,
      oData => oData);

  clk_process : process
  begin
        iClk <= '0';
        wait for clkPeriod/2;
        iClk <= '1';
        wait for clkPeriod/2;
  end process;

  stimPro : process (iClk) is
  begin  -- process stimPro
    if iClk'event and iClk = '1' then   -- rising clock edge
      if counter < 50 then
        iRst <= '1';
      elsif counter < 75 then
        iRst <= '0';
      elsif counter = 100 then
        iData.dv         <= '1';
        iData.kerWidth   <= to_unsigned(3, log2(cMaxKerWidth));
        iData.startAddrX <= to_unsigned(1, log2(cTileNum));
        iData.startAddrY <= to_unsigned(1, log2(cRamDepth));
      elsif counter = 101 then
        iData <= cIm2ColIn;
      elsif counter = 103 then
        iData.dv         <= '1';
        iData.kerWidth   <= to_unsigned(2, log2(cMaxKerWidth));
        iData.startAddrX <= to_unsigned(0, log2(cTileNum));
        iData.startAddrY <= to_unsigned(0, log2(cRamDepth));
      elsif counter = 104 then
        iData <= cIm2ColIn;
      elsif counter = 105 then
        iData.dv         <= '1';
        iData.kerWidth   <= to_unsigned(4, log2(cMaxKerWidth));
        iData.startAddrX <= to_unsigned(5, log2(cTileNum));
        iData.startAddrY <= to_unsigned(6, log2(cRamDepth));
      elsif counter = 106 then
        iData <= cIm2ColIn;
      end if;
    end if;
  end process stimPro;


  counterPro : process (iClk) is
  begin  -- process counterPro
    if iClk'event and iClk = '1' then   -- rising clock edge
      counter <= counter + 1;
    end if;
  end process counterPro;



end architecture im2Col_tb;
