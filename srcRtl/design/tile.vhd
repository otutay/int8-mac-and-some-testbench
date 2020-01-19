-------------------------------------------------------------------------------
-- Title      : tile vhd file
-- Project    :
-------------------------------------------------------------------------------
-- File       : tile.vhd
-- Author     : osmant  <otutaysalgir@gmail.com>
-- Company    :
-- Created    : 2019-12-19
-- Last update: 2020-01-20
-- Platform   :
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: combines the 5 mult add operation and do a limited convolution
-- operation. Convolution data is a square matrix
-------------------------------------------------------------------------------
-- Copyright (c) 2019
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2019-12-19  1.0      otutay  Created
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library work;
use work.multPckg.all;
use work.tilePckg.all;
use work.ramPckg.all;

entity tile is

  port (
    iClk  : in std_logic;
    iRst  : in std_logic;
    iData : in signed(31 downto 0)
    );

end entity tile;
architecture rtl of tile is

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

  signal macIn  : tMultInArray  := cMultInArray;
  signal macOut : tMultOutArray := cMultOutArray;

begin  -- architecture rtl

end architecture rtl;
