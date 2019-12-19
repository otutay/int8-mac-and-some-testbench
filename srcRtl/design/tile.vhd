-------------------------------------------------------------------------------
-- Title      : tile vhd file
-- Project    :
-------------------------------------------------------------------------------
-- File       : tile.vhd
-- Author     : osmant  <otutaysalgir@gmail.com>
-- Company    :
-- Created    : 2019-12-19
-- Last update: 2019-12-19
-- Platform   :
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: combines the 5 mult add operation and do a limited convolution
-- operation
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

entity tile is

  port (
    iClk : in std_logic;
    iRst : in std_logic
    );

end entity tile;
architecture rtl of tile is
  component mac is
    port (
      iClk  : in  std_logic;
      iRst  : in  std_logic;
      iData : in  tMultIn;
      oData : out signed(cMultOutBitW-1 downto 0));
  end component mac;


  signal iData : tMultIn;
  signal oData : signed(cMultOutBitW-1 downto 0);

begin  -- architecture rtl
  mac_1 : mac
    port map (
      iClk  => iClk,
      iRst  => iRst,
      iData => iData,
      oData => oData);


end architecture rtl;
