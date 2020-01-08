-------------------------------------------------------------------------------
-- Title      : tilePckg.vhd
-- Project    :
-------------------------------------------------------------------------------
-- File       : tilePckg.vhd
-- Author     : osmant  <otutaysalgir@gmail.com>
-- Company    :
-- Created    : 2019-12-21
-- Last update: 2020-01-08
-- Platform   :
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: tile definition package
-------------------------------------------------------------------------------
-- Copyright (c) 2019
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2019-12-21  1.0      otutay  Created
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library work;
use work.multPckg.all;
use work.ramPckg.all;
use work.funcPckg.all;

package tilePckg is
  constant cTileNum      : integer := 12;
  constant cNumOfMultAdd : integer := 12;
  constant cMaxKerWidth  : integer := 4;

  type tMultInArray is array (0 to cNumOfMultAdd-1) of tMultIn;
  constant cMultInArray : tMultInArray := (others => (cMultIn));

  type tMultOutArray is array (0 to cNumOfMultAdd-1) of tMultOut;
  constant cMultOutArray : tMultOutArray := (others => (cMultOut));


  type tRamInDataArray is array (0 to cTileNum-1) of tRamInData;
  constant cRamInDataArray :tRamInDataArray :=(others => cRamInData);

  type tRamOutDataArray is array (0 to cTileNum-1) of tRamOutData;
  constant cRamOutDataArray : tRamOutDataArray := (others => cRamOutData);

  type tIm2ColIn is record
    kerWidth   : unsigned(log2(cMaxKerWidth)-1 downto 0);  -- maximum kernel size of 4
    startAddrX : unsigned(log2(cTileNum)-1 downto 0);
    startAddrY : unsigned(log2(cRamDepth)-1 downto 0);
    dv         : std_logic;
  end record tIm2ColIn;
  constant cIm2ColIn : tIm2ColIn := ((others => '0'), (others => '0'), (others => '0'), '0');

  type tAddrArray is array (0 to cMaxKerWidth-1) of unsigned(log2(cTileNum)-1 downto 0);
  constant cAddrArray : tAddrArray := (others => (others => '0'));

  type tIm2ColOut is record
    xAddr : tAddrArray;
    yAddr : unsigned(log2(cRamDepth)-1 downto 0);
    dv    : std_logic;
    done  : std_logic;
  end record tIm2ColOut;
  constant cIm2ColOut : tIm2ColOut := (cAddrArray, (others => '0'), '0', '0');

  function calcAddr (signal addr : tIm2ColIn) return tIm2ColOut;

end package tilePckg;
package body tilePckg is

  function calcAddr (signal addr : tIm2ColIn) return tIm2ColOut is
    variable outData : tIm2ColOut;
  begin  -- function calcAddr
    outData.yAddr := addr.startAddrY + 1;
    addrXGen : for it in 0 to outData.xAddr'high loop
      outData.xAddr(it) := addr.startAddrX + to_unsigned(it, log2(cTileNum));
    end loop addrXGen;
    return outData;
  end function calcAddr;
end package body tilePckg;
