-------------------------------------------------------------------------------
-- Title      : tilePckg.vhd
-- Project    :
-------------------------------------------------------------------------------
-- File       : tilePckg.vhd
-- Author     : osmant  <otutaysalgir@gmail.com>
-- Company    :
-- Created    : 2019-12-21
-- Last update: 2019-12-22
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

package tilePckg is
  constant cDataBitW  : integer := 16;
  constant cNumOfMultAdd : integer := 4;

  type tMultInArray is array (0 to cNumOfMultAdd-1) of tMultIn;
  constant cMultInArray : tMultInArray := (others => (cMultIn));

  type tMultOutArray is array (0 to cNumOfMultAdd-1) of tMultOut;
  constant cMultOutArray : tMultOutArray := (others => (cMultOut));

  type tTileIn is record
    stride : unsigned(2 downto 0);
    start : std_logic;
  end record tTileIn;
  constant cTileIn : tTileIn :=((others => '0'),'0');


end package tilePckg;
package body tilePckg is



end package body tilePckg;
