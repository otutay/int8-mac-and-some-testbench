-------------------------------------------------------------------------------
-- Title      : funcPckg
-- Project    :
-------------------------------------------------------------------------------
-- File       : funcPckg.vhd
-- Author     : osmant  <otutaysalgir@gmail.com>
-- Company    :
-- Created    : 2019-12-22
-- Last update: 2020-02-09
-- Platform   :
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: functions pckg
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

package funcPckg is
  function log2 (constant depth      : integer) return integer;
  function log2floor (constant depth : integer) return integer;
end package funcPckg;

package body funcPckg is
  function log2floor (constant depth : integer) return integer is
    variable temp   : integer := depth;
    variable retVal : integer := 0;
  begin  -- function log2
    while temp > 1 loop
      retVal := retVal+1;
      temp   := temp/2;
    end loop;
    return retVal;


  end function log2floor;


 function log2 (constant depth : integer) return integer is
    variable temp   : integer := depth;
    variable retVal : integer := 1;
  begin  -- function log2
    while temp > 1 loop
      retVal := retVal+1;
      temp   := temp/2;
    end loop;
    return retVal;
  end function log2;

end package body funcPckg;
