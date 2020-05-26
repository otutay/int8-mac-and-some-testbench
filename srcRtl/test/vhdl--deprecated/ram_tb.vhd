-------------------------------------------------------------------------------
-- Title      : Testbench for design "ram"
-- Project    :
-------------------------------------------------------------------------------
-- File       : ram_tb.vhd
-- Author     : osmant  <otutaysalgir@gmail.com>
-- Company    :
-- Created    : 2020-01-09
-- Last update: 2020-01-09
-- Platform   :
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: testing read write and far address consecutive read
-------------------------------------------------------------------------------
-- Copyright (c) 2020
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2020-01-09  1.0      otutay  Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library work;
use work.ramPckg.all;
use work.funcPckg.all;
-------------------------------------------------------------------------------

entity ram_tb is

end entity ram_tb;

-------------------------------------------------------------------------------

architecture rtl of ram_tb is
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
  -- component generics
  constant cRamPerformance : tPerfEnum   := highPerf;
  constant cRamInitFile    : string      := "dummy";
  constant clkPeriod       : time        := 5 ns;
  -- component ports
  signal iClk              : std_logic   := '0';
  signal iRst              : std_logic   := '0';
  signal iRam              : tRamInData  := cRamInData;
  signal oRam              : tRamOutData := cRamOutData;

  signal dummyData : tRamInData                             := cRamInData;
  signal counter   : unsigned(log2(cRamDepth-1)-1 downto 0) := (others => '0');
  signal readWrite : std_logic_vector(2 downto 0)           := "001";
  -- clock
begin
    clk_process : process
  begin
        iClk <= '0';
        wait for clkPeriod/2;
        iClk <= '1';
        wait for clkPeriod/2;
  end process;

  ram_1 : ram
    generic map (
      cRamPerformance => highPerf,
      cRamInitFile    => cRamInitFile)
    port map (
      iClk => iClk,
      iRst => iRst,
      iRam => iRam,
      oRam => oRam);

  dummyProcesses : process (iClk) is
  begin  -- process ramProcesses
    if iClk'event and iClk = '1' then   -- rising clock edge      iRam
      if (readWrite(0) = '1') then
        counter <= counter + 1;
      end if;

      readWrite      <= readWrite(readWrite'high-1 downto 0) & readWrite(readWrite'high);
      dummyData.data <= std_logic_vector(resize(unsigned(counter), cRamWidth));
      if(readWrite(1) = '1' or readWrite(0) = '1') then
        dummyData.addr <= std_logic_vector(counter);
      else
        dummyData.addr <= std_logic_vector(32 - counter);
      end if;
    end if;
  end process dummyProcesses;

  ramProcess : process (iClk) is
  begin  -- process ramProcess
    if iClk'event and iClk = '1' then   -- rising clock edge
      iRam.en   <= '1';
      iRam.wEn  <= readWrite(2);
      iRam.addr <= dummyData.addr;
      iRam.data <= dummyData.data;
    end if;
  end process ramProcess;

end architecture rtl;
