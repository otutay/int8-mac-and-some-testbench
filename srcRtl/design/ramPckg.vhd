-------------------------------------------------------------------------------
-- Title      : ramPckg
-- Project    :
-------------------------------------------------------------------------------
-- File       : ramPckg.vhd
-- Author     : osmant  <otutaysalgir@gmail.com>
-- Company    :
-- Created    : 2019-12-22
-- Last update: 2019-12-28
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
USE std.textio.all;

package ramPckg is
  constant cRamWidth            : integer := 8;   -- dataBitW
  constant cRamDepth            : integer := 16;  -- ram depth
  type tPerfEnum is (highPerf, lowLatency);       -- ram performance enum
  function log2 (constant depth : integer) return integer;


  type tRamArray is array (cRamDepth-1 downto 0) of std_logic_vector(cRamWidth-1 downto 0);

  type tRamData is record
    addr : std_logic_vector(log2(cRamDepth)-1 downto 0);
    data : std_logic_vector(cRamWidth-1 downto 0);
    wEn  : std_logic;
    en   : std_logic;
  end record tRamData;
  constant cRamData : tRamData := ((others => '0'), (others => '0'), '0', '0');


end package ramPckg;

package body ramPckg is

 function log2 (constant depth : integer) return integer is
    variable temp   : integer := depth;
    variable retVal : integer := 0;
  begin  -- function log2
    while temp > 1 loop
      retVal := retVal+1;
      temp   := temp/2;
    end loop;
    return retVal;

  end function log2;


end package body ramPckg;
