-------------------------------------------------------------------------------
-- Title      : multPckg
-- Project    :
-------------------------------------------------------------------------------
-- File       : multPckg.vhd
-- Author     : osmant  <otutaysalgir@gmail.com>
-- Company    :
-- Created    : 2019-12-15
-- Last update: 2020-01-20
-- Platform   :
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: mult package
-------------------------------------------------------------------------------
-- Copyright (c) 2019
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2019-12-15  1.0      otutay  Created
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package multPckg is
  -- type tOpState is (ADD, MULTIPLY);         -- operand state
  constant cDataBitW    : integer := 8;
  constant cWeightBitW  : integer := 8;
  constant cSumBitW     : integer := 48;
  constant cMultOutBitW : integer := 48;
  constant cPreAddBitW  : integer := 27;
  constant cMult2BitW   : integer := 18;
  -- a1 and a2 will be data and weight for multiply operation
  --
  constant cMacLatency  : integer := 5;

  type tMultIn is record
    a1     : signed(cDataBitW-1 downto 0);
    a2     : signed(cDataBitW-1 downto 0);
    w      : signed(cWeightBitW-1 downto 0);
    pSum   : signed(cSumBitW-1 downto 0);
    is8Bit : std_logic;
    dv     : std_logic;
  end record tMultIn;
  constant cMultIn : tMultIn := ((others => '0'), (others => '0'), (others => '0'), (others => '0'), '0', '0');

  type tMultOut is record
    data : signed(cMultOutBitW-1 downto 0);
    dv   : std_logic;
  end record tMultOut;
  constant cMultOut : tMultOut := ((others => '0'), '0');

  -- function log2 (
  --   constant depth : integer)
  --   return integer;


end package multPckg;

package body multPckg is

  -- function log2 (
  --   constant depth : integer)
  --   return integer is
  --   variable temp : integer := depth;
  --   variable retVal : integer := 0;
  -- begin  -- function log2
  --   while temp > 1 loop
  --     retVal := retVal+1;
  --     temp := temp/2;
  --   end loop;
  --   return retVal;

  -- end function log2;

end package body multPckg;
