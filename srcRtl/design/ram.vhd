-------------------------------------------------------------------------------
-- Title      : ram vhd
-- Project    :
-------------------------------------------------------------------------------
-- File       : ram.vhd
-- Author     : osmant  <otutaysalgir@gmail.com>
-- Company    :
-- Created    : 2019-12-22
-- Last update: 2019-12-22
-- Platform   :
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: ram ins for vivado synthesis tool. same as vivado template.
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
library work;
use work.ramPckg.all;

entity ram is

  generic (
    cRamPerformance : tPerfEnum := highPerf;  -- highPerf, lowLatency
    cRamInitFile    : string                  -- leave blank if not used
    );

  port (
    iClk : in std_logic;                -- clk
    iRst : in std_logic               -- rst
    );
end entity ram;

architecture rtl of ram is
  signal addr       : std_logic_vector(log2(cRamDepth)-1 downto 0) := (others => '0');
  signal dataIn     : std_logic_vector(cRamWidth-1 downto 0)       := (others => '0');
  signal wEn        : std_logic                                    := '0';
  signal en         : std_logic                                    := '0';
  signal rst        : std_logic                                    := '0';
  signal outRegEn   : std_logic                                    := '0';
  signal dataOutReg : std_logic_vector(cRamWidth-1 downto 0) : =(others       => '0');
  signal dataOut    : std_logic_vector(cRamWidth-1 downto 0) : =(others       => '0');


begin  -- architecture rtl



end architecture rtl;
