-------------------------------------------------------------------------------
-- Title      : ramControllerPckg
-- Project    :
-------------------------------------------------------------------------------
-- File       : ramControllerPckg.vhd
-- Author     : osmant  <otutaysalgir@gmail.com>
-- Company    :
-- Created    : 2020-01-19
-- Last update: 2020-02-10
-- Platform   :
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: ram controller packages
-------------------------------------------------------------------------------
-- Copyright (c) 2020
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2020-01-19  1.0      otutay  Created
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library work;
use work.ramPckg.all;

package ramControllerPckg is
    constant cRamNum : integer := 12;

    type tRamInDataArray is array (0 to cRamNum-1) of tRamInData;
    constant cRamInDataArray : tRamInDataArray := (others => cRamInData);

    type tRamOutDataArray is array (0 to cRamNum-1) of tRamOutData;
    constant cRamOutDataArray : tRamOutDataArray := (others => cRamOutData);

    type tDataArray is array (0 to cRamNum-1) of std_logic_vector(cRamWidth-1 downto 0);
    constant cDataArray : tDataArray := (others => (others => '0'));

    -- type tRamEn is array (0 to cRamNum-1 ) of std_logic;
    -- constant cRamEn  : tRamEn := (others => '0');

    -- type tRamWEn is array (0 to cRamNum-1 ) of std_logic;
    -- constant cRamWEn  : tRamWEn := (others => '0');

    type tRamControllerIn is record
      data : tDataArray;
      wEn  : std_logic;
      dv   : std_logic;
      -- readAddr :
    end record tRamControllerIn;
    constant cRamControllerIn : tRamControllerIn := (cDataArray, '0', '0');

end package ramControllerPckg;

package body ramControllerPckg is



end package body ramControllerPckg;
