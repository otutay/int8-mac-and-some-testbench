-------------------------------------------------------------------------------
-- Title      : ramController
-- Project    :
-------------------------------------------------------------------------------
-- File       : ramController.vhd
-- Author     : osmant  <otutaysalgir@gmail.com>
-- Company    :
-- Created    : 2020-01-19
-- Last update: 2020-01-19
-- Platform   :
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: ram controller for write and reads
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
use work.ramControllerPckg.all;

entity ramController is

  port (
    iClk : in std_logic;
    iRst : in std_logic
    );

end entity ramController;

architecture rtl of ramController is

  component ram is
    generic (
      cRamPerformance : tPerfEnum;
      cRamInitFile    : string);
    port (
      iClk : in  std_logic;
      iRst : in  std_logic;
      iRam : in  tRamInData;
      oRam : out tRamOutData);
  end component ram;

  signal ramInputs  : tRamInDataArray  := cRamInDataArray;
  signal ramOutputs : tRamOutDataArray := cRamOutDataArray;

begin  -- architecture rtl

  ramGen : for it in 0 to cRamNum-1 generate
    ram_1 : ram
      generic map (
        cRamPerformance => highPerf,
        cRamInitFile    => "dummy")
      port map (
        iClk => iClk,
        iRst => iRst,
        iRam => ramIn(it),
        oRam => ramOut(it));
  end generate ramGen;


end architecture rtl;
