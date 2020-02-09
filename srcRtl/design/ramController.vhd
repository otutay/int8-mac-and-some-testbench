-------------------------------------------------------------------------------
-- Title      : ramController
-- Project    :
-------------------------------------------------------------------------------
-- File       : ramController.vhd
-- Author     : osmant  <otutaysalgir@gmail.com>
-- Company    :
-- Created    : 2020-01-19
-- Last update: 2020-02-10
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
use work.funcPckg.all;

entity ramController is

  port (
    iClk  : in std_logic;
    iRst  : in std_logic;
    iData : in tRamControllerIn
    -- oData :
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

  signal ramIn      : tRamInDataArray                                := cRamInDataArray;
  signal ramOut     : tRamOutDataArray                               := cRamOutDataArray;
  signal commonAddr : std_logic_vector(log2(cRamDepth-1)-1 downto 0) := (others => '0');
  signal dummyVec   : std_logic_vector(2 downto 0)                   := (others => '0');
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
        oRam => ramOut(it)
        );
  end generate ramGen;
  -- FIXME need to write and read at the same time not to buffer all data to
  -- the rams.



  -- COMMENT write and read operations need to be starts with a reset.
  -- all buffer needs to write first and read all after a reset.
  -- for a dummy ram controller

  -- FIXME ram controller can be a little clever but will be added further.
  writeDataGen : for it in 0 to cRamNum-1 generate
      writeDataPro : process (iClk) is
      begin  -- process writeDataPro
        if iClk'event and iClk = '1' then  -- rising clock edge
          ramIn(it).data <= iData.data(it);
          ramIn(it).addr <= commonAddr;
          ramIn(it).wEn  <= iData.Wen;
          ramIn(it).En   <= iData.dv;
        end if;
      end process writeDataPro;
  end generate writeDataGen;

  dummyVec <= iRst & iData.wEn & idata.dv;
  commonAddrPro : process (iClk) is
  begin  -- process commonAddrPro
    if iClk'event and iClk = '1' then   -- rising clock edge
      case dummyVec is
        when "100" | "101" | "110" | "111" =>
          commonAddr <= (others => '0');
        when "011" | "001" =>
          commonAddr <= std_logic_vector(unsigned(commonAddr) + 1);
        when others =>
          assert dummyVec = "010"
            report("wrong settings on ram controller wen set but en not")
            severity WARNING;
     end case;
    end if;
  end process commonAddrPro;

end architecture rtl;
