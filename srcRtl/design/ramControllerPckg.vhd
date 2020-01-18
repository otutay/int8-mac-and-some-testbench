-------------------------------------------------------------------------------
-- Title      : ramControllerPckg
-- Project    :
-------------------------------------------------------------------------------
-- File       : ramControllerPckg.vhd
-- Author     : osmant  <otutaysalgir@gmail.com>
-- Company    :
-- Created    : 2020-01-19
-- Last update: 2020-01-19
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


end package ramControllerPckg;

package body ramControllerPckg is



end package body ramControllerPckg;
