-------------------------------------------------------------------------------
-- Title      : im2col
-- Project    :
-------------------------------------------------------------------------------
-- File       : im2Col.vhd
-- Author     : osmant  <otutaysalgir@gmail.com>
-- Company    :
-- Created    : 2019-12-30
-- Last update: 2020-01-03
-- Platform   :
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: im2col for paralllell operation one row at a clk
-------------------------------------------------------------------------------
-- Copyright (c) 2019
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2019-12-30  1.0      otutay  Created
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library work;
use work.tilePckg.all;
use work.funcPckg.all;

entity im2Col is

  port (
    iClk  : in  std_logic;
    iRst  : in  std_logic;
    iData : in  tIm2ColIn;
    oData : out tIm2ColOut
    );

end entity im2Col;

architecture rtl of im2Col is
  alias clk      : std_logic is iClk;
  signal count   : unsigned(log2(cMaxKerWidth)-1 downto 0) := to_unsigned(1, log2(cMaxKerWidth));
  signal doCalc  : std_logic                               := '0';
  signal dataIn  : tIm2ColIn                               := cIm2ColIn;
  signal dataOut : tIm2ColOut                              := cIm2ColOut;
begin  -- architecture rtl

  InputRegPro : process (clk) is
  begin  -- process calcPro
    if clk'event and clk = '1' then     -- rising clock edge
      if(iRst = '1') then
        dataIn <= cIm2ColIn;
      elsif (iData.dv = '1') then
        dataIn <= iData;
      elsif(doCalc = '1') then
        dataIn.startAddrX <= dataIn.startAddrX + 1;
      end if;
    end if;
  end process InputRegPro;

  calcPro : process (clk) is
  begin  -- process calcPro
    if clk'event and clk = '1' then     -- rising clock edge
      if(doCalc = '1') then
        dataOut    <= calcAddr(dataIn);
        dataOut.dv <= '1';
        dataOut.done <= '0';
        if(count = dataIn.kerWidth) then
          dataOut.done <= '1';
        end if;
      else
        dataOut    <= cIm2ColOut;
      end if;
    end if;
  end process calcPro;

  countPro : process (clk) is
  begin  -- process countPro
    if clk'event and clk = '1' then     -- rising clock edge
      if (iRst = '1') then
        count <= to_unsigned(1, log2(cMaxKerWidth));
      elsif(doCalc = '1') then
        count <= count + 1;
      end if;
    end if;
  end process countPro;

  calcStartPro : process (clk) is
  begin  -- process calcStartPro
    if clk'event and clk = '1' then     -- rising clock edge
      if(iRst = '1') then
        doCalc <= '0';
      elsif(iData.dv = '1') then
        doCalc <= '1';
      elsif(count = dataIn.kerWidth) then
        doCalc <= '0';
      end if;
    end if;
  end process calcStartPro;

end architecture rtl;
