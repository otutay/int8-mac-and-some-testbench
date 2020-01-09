-------------------------------------------------------------------------------
-- Title      : ramPckg
-- Project    :
-------------------------------------------------------------------------------
-- File       : ramPckg.vhd
-- Author     : osmant  <otutaysalgir@gmail.com>
-- Company    :
-- Created    : 2019-12-22
-- Last update: 2020-01-10
-- Platform   :
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: ramPackage for function def
-------------------------------------------------------------------------------
-- Copyright (c) 2019
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2019-12-22  1.0      otutay  Created
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library work;
use work.funcPckg.all;
USE std.textio.all;

package ramPckg is
  constant cRamWidth : integer := 8;         -- dataBitW
  constant cRamDepth : integer := 32;        -- ram depth
  type tPerfEnum is (highPerf, lowLatency);  -- ram performance enum

  type tRamArray is array (cRamDepth-1 downto 0) of std_logic_vector(cRamWidth-1 downto 0);

  type tRamInData is record
    addr : std_logic_vector(log2(cRamDepth-1)-1 downto 0);
    data : std_logic_vector(cRamWidth-1 downto 0);
    wEn  : std_logic;
    en   : std_logic;
  end record tRamInData;
  constant cRamInData : tRamInData := ((others => '0'), (others => '0'), '0', '0');

  type tRamOutData is record
    data : std_logic_vector(cRamWidth-1 downto 0);
    addr : std_logic_vector(log2(cRamDepth-1)-1 downto 0);
    dv   : std_logic;
  end record tRamOutData;
  constant cRamOutData : tRamOutData := ((others => '0'), (others => '0'), '0');
end package ramPckg;

package body ramPckg is

end package body ramPckg;
