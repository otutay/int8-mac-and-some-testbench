-------------------------------------------------------------------------------
-- Title      : ram vhd
-- Project    :
-------------------------------------------------------------------------------
-- File       : ram.vhd
-- Author     : osmant  <otutaysalgir@gmail.com>
-- Company    :
-- Created    : 2019-12-22
-- Last update: 2019-12-28
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
    cRamInitFile    : string                  -- leave blank if not used -- not
                                              -- supported
    );

  port (
    iClk   : in std_logic;              -- clk
    iRst   : in std_logic;              -- rst
    iRamIn : in tRamData
    );
end entity ram;

architecture rtl of ram is
  alias clk         : std_logic is iClk;
  signal addr       : std_logic_vector(log2(cRamDepth)-1 downto 0) := (others => '0');
  signal dataIn     : std_logic_vector(cRamWidth-1 downto 0)       := (others => '0');
  signal ramBlock   : tRamArray                                    := (others => (others => '0'));
  signal ramData    : std_logic_vector(cRamWidth-1 downto 0)       := (others => '0');
  signal wEn        : std_logic                                    := '0';
  signal en         : std_logic                                    := '0';
  signal dataOutReg : std_logic_vector(cRamWidth-1 downto 0);  -- : =(others       => '0');
  signal dataOut    : std_logic_vector(cRamWidth-1 downto 0);  -- : =(others       => '0');


begin  -- architecture rtl
  inputRegPro : process (clk) is
  begin  -- process inputRegPro
    if clk'event and clk = '1' then     -- rising clock edge
      dataIn <= iRamIn.data;
      addr   <= iRamIn.addr;
      en     <= iRamIn.en;
      wEn    <= iRamIn.wEn;
    end if;
  end process inputRegPro;

  ramReadWritePro : process (clk) is
  begin  -- process ramReadWritePro
    if clk'event and clk = '1' then     -- rising clock edge
      if(en = '1') then
        if (wEn = '1') then
          ramBlock(to_integer(unsigned(addr))) <= dataIn;
        else
          ramData <= ramBlock(to_integer(unsigned(addr)));
        end if;
      end if;
    end if;
  end process ramReadWritePro;

  lowLatencyGen : if cRamPerformance = lowLatency generate
    dataOut <= ramData;
  end generate lowLatencyGen;

  highPerfGen : if cRamPerformance = highPerf generate
    OutDataPro : process (clk) is
    begin  -- process OutDataPro,
      if clk'event and clk = '1' then   -- rising clock edge
        if(iRst = '1') then
          dataOutReg <= (others => '0');
        else
          dataOutReg <= ramData;
        end if;
      end if;
    end process OutDataPro;
    dataOut <= dataOutReg;
  end generate highPerfGen;

end architecture rtl;
