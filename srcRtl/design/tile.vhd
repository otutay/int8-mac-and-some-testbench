-------------------------------------------------------------------------------
-- Title      : tile vhd file
-- Project    :
-------------------------------------------------------------------------------
-- File       : tile.vhd
-- Author     : osmant  <otutaysalgir@gmail.com>
-- Company    :
-- Created    : 2019-12-19
-- Last update: 2020-01-08
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
  component mac is
    port (
      iClk  : in  std_logic;
      iRst  : in  std_logic;
      iData : in  tMultIn;
      oData : out tMultOut
      );
  end component mac;

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

  signal macIn  : tMultInArray     := cMultInArray;
  signal macOut : tMultOutArray    := cMultOutArray;
  signal ramIn  : tRamInDataArray  := cRamInDataArray;
  signal ramOut : tRamOutDataArray := cRamOutDataArray;
begin  -- architecture rtl


  ramGen : for it in 0 to cTileNum-1 generate
    ram_1 : entity work.ram
      generic map (
        cRamPerformance => highPerf,
        cRamInitFile    => "dummy")
      port map (
        iClk => iClk,
        iRst => iRst,
        iRam => ramIn(it),
        oRam => ramOut(it));
  end generate ramGen;
  macGen : for it in 0 to cNumOfMultAdd-1 generate
    mac_1 : mac
      port map (
        iClk  => iClk,
        iRst  => iRst,
        iData => macIn(it),
        oData => macOut(it)
        );
  end generate macGen;
end architecture rtl;
