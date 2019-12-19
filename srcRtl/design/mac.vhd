-------------------------------------------------------------------------------
-- Title      : mac vhd file
-- Project    :
-------------------------------------------------------------------------------
-- File       : mac.vhd
-- Author     : osmant  <otutaysalgir@gmail.com>
-- Company    :
-- Created    : 2019-12-12
-- Last update: 2019-12-19
-- Platform   :
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: doing the  preadd, multiply and postadd functions
-------------------------------------------------------------------------------
-- Copyright (c) 2019
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2019-12-12  1.0      otutay  Created

-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library work;
use work.multPckg.all;
-- Library UNIMACRO;
-- use UNIMACRO.vcomponents.all;

entity mac is

  port (
    iClk  : in  std_logic;                            -- clk input
    iRst  : in  std_logic;                            -- rset input
    iData : in  tMultIn;
    oData : out signed(cMultOutBitW-1 downto 0)
    );
end entity mac;
architecture rtl of mac is
  alias clk                     : std_logic is iClk;  -- clk For processes
  signal ai1                    : signed(cPreAddBitW-1 downto 0)  := (others => '0');
  signal di1                    : signed(cPreAddBitW-1 downto 0)  := (others => '0');
  signal bi1                    : signed(cMult2BitW-1 downto 0)   := (others => '0');
  signal bi2                    : signed(cMult2BitW-1 downto 0)   := (others => '0');
  signal preAdd                 : signed(cPreAddBitW-1 downto 0)  := (others => '0');
  signal postAddi1              : signed(cMultOutBitW-1 downto 0) := (others => '0');
  signal postAddi2              : signed(cMultOutBitW-1 downto 0) := (others => '0');
  signal postAddi3              : signed(cMultOutBitW-1 downto 0) := (others => '0');
  signal mult                   : signed(cMultOutBitW-1 downto 0) := (others => '0');
  signal macOut                 : signed(cMultOutBitW-1 downto 0) := (others => '0');
--
  -- vivado specific attributes
  attribute USE_DSP48           : string;
  attribute USE_DSP48 of ai1    : signal is "YES";
  attribute USE_DSP48 of di1    : signal is "YES";
  attribute USE_DSP48 of bi1    : signal is "YES";
  attribute USE_DSP48 of preAdd : signal is "YES";
  attribute USE_DSP48 of mult   : signal is "YES";
  attribute USE_DSP48 of macOut : signal is "YES";

begin  -- architecture mult

  inRegPro : process (clk) is
  begin  -- process macPro
    if clk'event and clk = '1' then     -- rising clock edge
      ai1 <= iData.a1 & to_signed(0, cPreAddBitW-cDataBitW);
      di1 <= resize(iData.a2, cPreAddBitW);

      bi1 <= resize(iData.w, cMult2BitW);
      bi2 <= bi1;

      postAddi1 <= iData.pSum;
      postAddi2 <= postAddi1;
      postAddi3 <= postAddi2;
    end if;
  end process inRegPro;


  macPro : process (clk) is
  begin  -- process macPro
    if clk'event and clk = '1' then     -- rising clock edge
      preAdd <= ai1 + di1;
      mult   <= preAdd*bi2;
      macOut <= mult+postAddi3;
    end if;
  end process macPro;

  outPro : process (clk) is
  begin  -- process outPro
    if clk'event and clk = '1' then     -- rising clock edge
      oData <= macOut;
    end if;
  end process outPro;

end architecture rtl;
