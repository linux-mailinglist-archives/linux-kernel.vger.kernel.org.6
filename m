Return-Path: <linux-kernel+bounces-181679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E3DE8C7F94
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 03:32:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 147B21C21FC1
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 01:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E02BA1392;
	Fri, 17 May 2024 01:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TKM8//+Z"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49DA98472;
	Fri, 17 May 2024 01:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715909517; cv=none; b=pTk06iS6O8BfWLSdmwsUQalKwNjCZ2Y7dORWK5XDX8LgDm+g6mIYmSoEEWSnrwJp4+pvHWxkkrs59hAsb9a5l4DpkxcabuzLXaxO4diWuJP1FPlAWI4oaI2p2nPC60ONm6+WHkTxQ3xf2NcJ1eqnUyRvWVygj9R31p5yArzkkCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715909517; c=relaxed/simple;
	bh=Nbnr5cLRRRbYIM1S/bNXBWkxT7CZena4u5Il3gfGJG8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZRHBVntRyZQQ7dXslFUFuUAFJAraLLSuLCwmB0bD6CLM8RQv8wOT+kIED80ui2ucpu7Z1pxPo4+0VsMm1yaeSDncTiWOsuOiBiGG3RhU3Yl1Ln/L1RsMsO6MOf5RnQxjdN6+28ThCjSfVzqhwffAN0ptICbTZ01fci+iDnKKxHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TKM8//+Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A157CC113CC;
	Fri, 17 May 2024 01:31:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715909516;
	bh=Nbnr5cLRRRbYIM1S/bNXBWkxT7CZena4u5Il3gfGJG8=;
	h=From:To:Cc:Subject:Date:From;
	b=TKM8//+ZHn/vBVzCkpnmvZiomgx37iT8rM9cddt2bvaH+2rtqX+R+6i0OrCdfAlLt
	 ML035Lql1pFknljYbb8OlRY1iYeJd+Xch6eFvlpagWxM9VnOCSO0muX62uYiZ5YLfk
	 tzdclcIy16g3sp78M3WsjIUtbEVlH+b893IzjFN3sHZZnZeYoywBbsTxUv2kqELDNY
	 ZMs7CQh0CBAF1O5MBbQH60gsPEFmhIBjAnGROiCa/2v6i2o9W1wBL5NEwKAL56wpPM
	 4YbCWoUAv1VIV84f7uMLrxsLuqpcYj6DDWolQRNs5KHDlWgrN/MO+Ekjp78oBejDeO
	 NW4rjdMNmIYqA==
From: Stephen Boyd <sboyd@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Michael Turquette <mturquette@baylibre.com>,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] clk changes for the merge window
Date: Thu, 16 May 2024 18:31:55 -0700
Message-ID: <20240517013155.1095253-1-sboyd@kernel.org>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following changes since commit 01aea123b11c7ebbdd64b2df3a4a5a7ad86a460d:

  dt-bindings: clock: google,gs101-clock: add HSI2 clock management unit (2024-04-29 19:06:57 +0200)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-for-linus

for you to fetch changes up to 03be434863b9606435be9ef43651d4c0cbbe6788:

  Merge branches 'clk-microchip', 'clk-samsung' and 'clk-qcom' into clk-next (2024-05-16 18:09:14 -0700)

----------------------------------------------------------------
I'm actually surprised this time. There aren't any new Qualcomm SoC clk
drivers. And there's zero diff in the core clk framework. Instead we have new
clk drivers for STM and Sophgo, with Samsung^WGoogle in third for the diffstat
because they introduced HSI0 and HSI2 clk drivers for Google's GS101 SoC (high
speed interface things like PCIe, UFS, and MMC). Beyond those big diffs there's
the usual updates to various clk drivers for incorrect parent descriptions or
mising MODULE_DEVICE_TABLE()s, etc. Nothing in particular stands out as super
interesting here.

New Drivers:
 - STM32MP257 SoC clk driver
 - Airoha EN7581 SoC clk driver
 - Sophgo CV1800B, CV1812H and SG2000 SoC clk driver
 - Loongson-2k0500 and Loongson-2k2000 SoC clk driver
 - Add HSI0 and HSI2 clock controllers for Google GS101
 - Add i.MX95 BLK CTL clock driver

Updates:
 - Allocate clk_ops dynamically for SCMI clk driver
 - Add support in qcom RCG and RCG2 for multiple configurations for the same frequency
 - Use above support for IPQ8074 NSS port 5 and 6 clocks to resolve issues
 - Fix the Qualcomm APSS IPQ5018 PLL to fix boot failures of some boards
 - Cleanups and fixes for Qualcomm Stromer PLLs
 - Reduce max CPU frequency on Qualcomm APSS IPQ5018
 - Fix Kconfig dependencies of Qualcomm SM8650 GPU and SC8280XP camera
   clk drivers
 - Make Qualcomm MSM8998 Venus clocks functional
 - Cleanup downstream remnants related to DisplayPort across Qualcomm
   SM8450, SM6350, SM8550, and SM8650
 - Reuse the Huayra APSS register map on Qualcomm MSM8996 CBF PLL
 - Use a specific Qualcomm QCS404 compatible for the otherwise generic
   HFPLL
 - Remove Qualcomm SM8150 CPUSS AHB clk as it is unused
 - Remove an unused field in the Qualcomm RPM clk driver
 - Add missing MODULE_DEVICE_TABLE to Qualcomm MSM8917 and MSM8953
   global clock controller drivers
 - Allow choice of manual or firmware-driven control over PLLs, needed
   to fully implement CPU clock controllers on Exynos850
 - Correct PLL clock IDs on ExynosAutov9
 - Propagate certain clock rates to allow setting proper SPI clock
   rates on Google GS101
 - Mark certain Google GS101 clocks critical
 - Convert old S3C64xx clock controller bindings to DT schema
 - Add new PLL rate and missing mux on Rockchip rk3568
 - Add missing reset line on Rockchip rk3588
 - Removal of an unused field in struct rockchip_mmc_clock
 - Amlogic s4/a1: add regmap maximum register for proper debugfs dump
 - Amlogic s4: add MODULE_DEVICE_TABLE() on pll and periph controllers
 - Amlogic pll driver: print clock name on lock error to help debug
 - Amlogic vclk: finish dsi clock path support
 - Amlogic license: fix occurence "GPL v2" as reported by checkpatch
 - Add PM runtime support to i.MX8MP Audiomix
 - Add DT schema for i.MX95 Display Master Block Control
 - Convert to platform remove callback returning void for i.MX8MP
   Audiomix
 - Add SPI (MSIOF) and external interrupt (INTC-EX) clocks on Renesas R-Car V4M
 - Add interrupt controller (PLIC) clock and reset on Renesas RZ/Five
 - Prepare power domain support for Renesas RZ/G2L family members, and add
   actual support on Renesas RZ/G3S SoC
 - Add thermal, serial (SCIF), and timer (CMT/TMU) clocks on Renesas R-Car V4M
 - Add additional constraints to Allwinner A64 PLL MIPI clock
 - Fix autoloading sunxi-ng clocks when build as a module

----------------------------------------------------------------
Abel Vesa (1):
      clk: qcom: clk-alpha-pll: Skip reconfiguring the running Lucid Evo

Alexandre Mergnat (1):
      clk: mediatek: mt8365-mm: fix DPI0 parent

André Draszik (2):
      clk: samsung: gs101: add support for cmu_hsi0
      clk: samsung: gs101: mark some apm UASC and XIU clocks critical

Arnd Bergmann (2):
      clk: ti: dpll: fix incorrect #ifdef checks
      clk: sophgo: avoid open-coded 64-bit division

Binbin Zhou (6):
      dt-bindings: clock: Add Loongson-2K expand clock index
      clk: clk-loongson2: Refactor driver for adding new platforms
      dt-bindings: clock: loongson2: Add Loongson-2K0500 compatible
      clk: clk-loongson2: Add Loongson-2K0500 clock support
      dt-bindings: clock: loongson2: Add Loongson-2K2000 compatible
      clk: clk-loongson2: Add Loongson-2K2000 clock support

Bjorn Andersson (1):
      Merge branch '20240315-apss-ipq-pll-ipq5018-hang-v2-1-6fe30ada2009@gmail.com' into clk-for-6.10

Catalin Popescu (1):
      clk: rs9: fix wrong default value for clock amplitude

Christian Marangi (3):
      clk: qcom: clk-rcg: introduce support for multiple conf for same freq
      clk: qcom: clk-rcg2: add support for rcg2 freq multi ops
      clk: qcom: gcc-ipq8074: rework nss_port5/6 clock to multiple conf

Christophe JAILLET (6):
      clk: nxp: Remove an unused field in struct lpc18xx_pll
      clk: highbank: Remove an unused field in struct hb_clk
      clk: gemini: Remove an unused field in struct clk_gemini_pci
      clk: qcom: rpm: Remove an unused field in struct rpm_cc
      clk: renesas: r8a7740: Remove unused div4_clk.flags field
      clk: rockchip: Remove an unused field in struct rockchip_mmc_clock

Claudiu Beznea (7):
      dt-bindings: clock: r9a07g043-cpg: Add power domain IDs
      dt-bindings: clock: r9a07g044-cpg: Add power domain IDs
      dt-bindings: clock: r9a07g054-cpg: Add power domain IDs
      dt-bindings: clock: r9a08g045-cpg: Add power domain IDs
      dt-bindings: clock: renesas,rzg2l-cpg: Update #power-domain-cells = <1> for RZ/G3S
      clk: renesas: rzg2l: Extend power domain support
      clk: renesas: r9a08g045: Add support for power domains

Cong Dang (2):
      clk: renesas: r8a779h0: Add MSIOF clocks
      clk: renesas: r8a779h0: Add INTC-EX clock

Conor Dooley (2):
      clock, reset: microchip: move all mpfs reset code to the reset subsystem
      clk, reset: microchip: mpfs: fix incorrect preprocessor conditions

Cristian Marussi (5):
      clk: scmi: Allocate CLK operations dynamically
      clk: scmi: Add support for state control restricted clocks
      clk: scmi: Add support for rate change restricted clocks
      clk: scmi: Add support for re-parenting restricted clocks
      clk: scmi: Add support for get/set duty_cycle operations

David Jander (1):
      clk: rockchip: rk3568: Add missing USB480M_PHY mux

Dmitry Baryshkov (4):
      clk: qcom: dispcc-sm8450: fix DisplayPort clocks
      clk: qcom: dispcc-sm6350: fix DisplayPort clocks
      clk: qcom: dispcc-sm8550: fix DisplayPort clocks
      clk: qcom: dispcc-sm8650: fix DisplayPort clocks

Dmitry Rokosov (5):
      clk: meson: a1: peripherals: determine maximum register in regmap config
      clk: meson: a1: pll: determine maximum register in regmap config
      clk: meson: s4: peripherals: determine maximum register in regmap config
      clk: meson: s4: pll: determine maximum register in regmap config
      clk: meson: pll: print out pll name when unable to lock it

Fabio Estevam (1):
      clk: imx: imx8mp: Switch to RUNTIME_PM_OPS()

Frank Oltmanns (2):
      clk: sunxi-ng: nkm: Support constraints on m/n ratio and parent rate
      clk: sunxi-ng: a64: Add constraints on PLL-MIPI's n/m ratio and parent rate

Gabor Juhos (11):
      clk: qcom: clk-alpha-pll: remove invalid Stromer register offset
      clk: qcom: clk-alpha-pll: reorder Stromer register offsets
      clk: qcom: clk-alpha-pll: fix kerneldoc of struct clk_alpha_pll
      clk: qcom: apss-ipq-pll: use stromer ops for IPQ5018 to fix boot failure
      clk: qcom: apss-ipq-pll: reuse Stromer reg offsets from 'clk_alpha_pll_regs'
      clk: qcom: apss-ipq-pll: move Huayra register map to 'clk_alpha_pll_regs'
      clk: qcom: apss-ipq-pll: constify match data structures
      clk: qcom: apss-ipq-pll: constify clk_init_data structures
      clk: qcom: clk-cbf-8996: use HUAYRA_APSS register map for cbf_pll
      clk: qcom: apss-ipq-pll: fix PLL rate for IPQ5018
      clk: qcom: clk-alpha-pll: fix rate setting for Stromer PLLs

Gabriel Fernandez (4):
      clk: stm32mp13: use platform device APIs
      dt-bindings: clocks: stm32mp25: add description of all parents
      clk: stm32: introduce clocks for STM32MP257 platform
      dt-bindings: clocks: stm32mp25: add access-controllers description

Geert Uytterhoeven (5):
      dt-bindings: clock: r9a07g043-cpg: Annotate RZ/G2UL-only core clocks
      clk: renesas: r8a779h0: Add thermal clock
      clk: renesas: r8a779h0: Add SCIF clocks
      clk: renesas: r8a779a0: Fix CANFD parent clock
      clk: renesas: shmobile: Remove unused CLK_ENABLE_ON_INIT

Heiko Stuebner (1):
      Merge branch 'v6.10-shared/clkids' into v6.10-clk/next

Inochi Amaoto (5):
      dt-bindings: clock: sophgo: Add clock controller of SG2000 series SoC
      clk: sophgo: Add clock support for CV1800 SoC
      clk: sophgo: Add clock support for CV1810 SoC
      clk: sophgo: Add clock support for SG2000 SoC
      clk: sophgo: Make synthesizer struct static

Jaewon Kim (1):
      clk: samsung: exynosautov9: fix wrong pll clock id value

Krzysztof Kozlowski (6):
      dt-bindings: clock: samsung,s3c6400-clock: convert to DT Schema
      clk: qcom: fix module autoloading
      clk: sunxi-ng: fix module autoloading
      Merge branch 'for-v6.10/clk-gs101-bindings' into next/clk
      clk: meson: s4: fix module autoloading
      clk: samsung: gs101: drop unused HSI2 clock parent data

Lad Prabhakar (1):
      clk: renesas: r9a07g043: Add clock and reset entry for PLIC

Lorenzo Bianconi (3):
      dt-bindings: clock: airoha: add EN7581 binding
      clk: en7523: Add en_clk_soc_data data structure
      clk: en7523: Add EN7581 support

Luca Weiss (2):
      dt-bindings: clock: qcom,hfpll: Convert to YAML
      clk: qcom: hfpll: Add QCS404-specific compatible

Lucas Stach (1):
      clk: rockchip: rk3568: Add PLL rate for 724 MHz

Marc Gonzalez (1):
      clk: qcom: mmcc-msm8998: fix venus clock issue

Marek Szyprowski (1):
      clk: samsung: Don't register clkdev lookup for the fixed rate clocks

Nathan Chancellor (4):
      clk: bcm: dvp: Assign ->num before accessing ->hws
      clk: bcm: rpi: Assign ->num before accessing ->hws
      clk: qcom: Fix SC_CAMCC_8280XP dependencies
      clk: qcom: Fix SM_GPUCC_8650 dependencies

Neil Armstrong (3):
      clk: meson: add vclk driver
      clk: meson: g12a: make VCLK2 and ENCL clock path configurable by CCF
      clk: meson: fix module license to GPL only

Nícolas F. R. A. Prado (1):
      clk: mediatek: pllfh: Don't log error for missing fhctl node

Paul Barker (2):
      clk: renesas: r9a07g043: Mark mod_clks and resets arrays as const
      clk: renesas: r9a07g044: Mark resets array as const

Peng Fan (4):
      dt-bindings: clock: add i.MX95 clock header
      dt-bindings: clock: support i.MX95 BLK CTL module
      dt-bindings: clock: support i.MX95 Display Master CSR module
      clk: imx: add i.MX95 BLK CTL clk driver

Peter Griffin (1):
      clk: samsung: gs101: add support for cmu_hsi2

Rob Herring (Arm) (1):
      dt-bindings: clock: fixed: Define a preferred node name

Sam Protsenko (2):
      clk: samsung: Implement manual PLL control for ARM64 SoCs
      clk: samsung: exynos850: Add CMU_CPUCL0 and CMU_CPUCL1

Sascha Hauer (1):
      dt-bindings: clock: rockchip: add USB480M_PHY mux

Satya Priya Kakitapalli (1):
      clk: qcom: gcc-sm8150: De-register gcc_cpuss_ahb_clk_src

Shengjiu Wang (1):
      clk: imx: imx8mp: Add pm_runtime support for power saving

Shreeya Patel (2):
      dt-bindings: reset: Define reset id used for HDMI Receiver
      clk: rockchip: rk3588: Add reset line for HDMI Receiver

Stephen Boyd (12):
      Merge tag 'renesas-clk-for-v6.10-tag1' of git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers into clk-renesas
      Merge tag 'sunxi-clk-for-6.10-1' of https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux into clk-allwinner
      Merge tag 'renesas-clk-for-v6.10-tag2' of git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers into clk-renesas
      Merge tag 'clk-imx-6.10' of git://git.kernel.org/pub/scm/linux/kernel/git/abelvesa/linux into clk-imx
      Merge tag 'clk-meson-v6.10-1' of https://github.com/BayLibre/clk-meson into clk-amlogic
      Merge tag 'v6.10-rockchip-clk1' of git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip into clk-rockchip
      Merge tag 'samsung-clk-6.10-2' of https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux into clk-samsung
      Merge tag 'qcom-clk-for-6.10' of https://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux into clk-qcom
      Merge branches 'clk-cleanup', 'clk-airoha', 'clk-mediatek', 'clk-sophgo' and 'clk-loongson' into clk-next
      Merge branches 'clk-stm', 'clk-renesas', 'clk-scmi' and 'clk-allwinner' into clk-next
      Merge branches 'clk-counted', 'clk-imx', 'clk-amlogic', 'clk-binding' and 'clk-rockchip' into clk-next
      Merge branches 'clk-microchip', 'clk-samsung' and 'clk-qcom' into clk-next

Thanh Quan (1):
      clk: renesas: r8a779h0: Add timer clocks

Tudor Ambarus (2):
      clk: samsung: gs101: propagate PERIC0 USI SPI clock rate
      clk: samsung: gs101: propagate PERIC1 USI SPI clock rate

Uwe Kleine-König (1):
      clk: imx: imx8mp: Convert to platform remove callback returning void

 .../bindings/clock/airoha,en7523-scu.yaml          |   31 +-
 .../devicetree/bindings/clock/fixed-clock.yaml     |    9 +
 .../bindings/clock/fixed-factor-clock.yaml         |    9 +
 .../bindings/clock/loongson,ls2k-clk.yaml          |    4 +-
 .../bindings/clock/nxp,imx95-blk-ctl.yaml          |   56 +
 .../clock/nxp,imx95-display-master-csr.yaml        |   64 +
 .../devicetree/bindings/clock/qcom,hfpll.txt       |   63 -
 .../devicetree/bindings/clock/qcom,hfpll.yaml      |   69 +
 .../bindings/clock/renesas,rzg2l-cpg.yaml          |   18 +-
 .../bindings/clock/samsung,s3c6400-clock.yaml      |   57 +
 .../bindings/clock/samsung,s3c64xx-clock.txt       |   76 -
 .../bindings/clock/sophgo,cv1800-clk.yaml          |    3 +-
 .../bindings/clock/st,stm32mp25-rcc.yaml           |  172 +-
 drivers/clk/Kconfig                                |    1 +
 drivers/clk/Makefile                               |    1 +
 drivers/clk/bcm/clk-bcm2711-dvp.c                  |    3 +-
 drivers/clk/bcm/clk-raspberrypi.c                  |    2 +-
 drivers/clk/clk-en7523.c                           |  191 +-
 drivers/clk/clk-gemini.c                           |    2 -
 drivers/clk/clk-highbank.c                         |    1 -
 drivers/clk/clk-loongson2.c                        |  584 +++---
 drivers/clk/clk-renesas-pcie.c                     |   10 +-
 drivers/clk/clk-scmi.c                             |  249 ++-
 drivers/clk/imx/Kconfig                            |    7 +
 drivers/clk/imx/Makefile                           |    1 +
 drivers/clk/imx/clk-imx8mp-audiomix.c              |  155 +-
 drivers/clk/imx/clk-imx95-blk-ctl.c                |  438 +++++
 drivers/clk/mediatek/clk-mt8365-mm.c               |    2 +-
 drivers/clk/mediatek/clk-pllfh.c                   |    2 +-
 drivers/clk/meson/Kconfig                          |    5 +
 drivers/clk/meson/Makefile                         |    1 +
 drivers/clk/meson/a1-peripherals.c                 |    1 +
 drivers/clk/meson/a1-pll.c                         |    1 +
 drivers/clk/meson/axg-aoclk.c                      |    2 +-
 drivers/clk/meson/axg-audio.c                      |    2 +-
 drivers/clk/meson/axg.c                            |    2 +-
 drivers/clk/meson/clk-cpu-dyndiv.c                 |    2 +-
 drivers/clk/meson/clk-dualdiv.c                    |    2 +-
 drivers/clk/meson/clk-mpll.c                       |    2 +-
 drivers/clk/meson/clk-phase.c                      |    2 +-
 drivers/clk/meson/clk-pll.c                        |    6 +-
 drivers/clk/meson/clk-regmap.c                     |    2 +-
 drivers/clk/meson/g12a-aoclk.c                     |    2 +-
 drivers/clk/meson/g12a.c                           |   78 +-
 drivers/clk/meson/gxbb-aoclk.c                     |    2 +-
 drivers/clk/meson/gxbb.c                           |    2 +-
 drivers/clk/meson/meson-aoclk.c                    |    2 +-
 drivers/clk/meson/meson-eeclk.c                    |    2 +-
 drivers/clk/meson/s4-peripherals.c                 |    2 +
 drivers/clk/meson/s4-pll.c                         |    2 +
 drivers/clk/meson/sclk-div.c                       |    2 +-
 drivers/clk/meson/vclk.c                           |  141 ++
 drivers/clk/meson/vclk.h                           |   51 +
 drivers/clk/meson/vid-pll-div.c                    |    2 +-
 drivers/clk/microchip/clk-mpfs.c                   |   92 +-
 drivers/clk/nxp/clk-lpc18xx-cgu.c                  |    1 -
 drivers/clk/qcom/Kconfig                           |    2 +
 drivers/clk/qcom/apss-ipq-pll.c                    |   79 +-
 drivers/clk/qcom/clk-alpha-pll.c                   |   24 +-
 drivers/clk/qcom/clk-alpha-pll.h                   |    5 +-
 drivers/clk/qcom/clk-cbf-8996.c                    |   13 +-
 drivers/clk/qcom/clk-rcg.h                         |   24 +-
 drivers/clk/qcom/clk-rcg2.c                        |  166 ++
 drivers/clk/qcom/clk-rpm.c                         |    1 -
 drivers/clk/qcom/common.c                          |   18 +
 drivers/clk/qcom/common.h                          |    2 +
 drivers/clk/qcom/dispcc-sm6350.c                   |   11 +-
 drivers/clk/qcom/dispcc-sm8450.c                   |   20 +-
 drivers/clk/qcom/dispcc-sm8550.c                   |   20 +-
 drivers/clk/qcom/dispcc-sm8650.c                   |   20 +-
 drivers/clk/qcom/gcc-ipq8074.c                     |  120 +-
 drivers/clk/qcom/gcc-msm8917.c                     |    1 +
 drivers/clk/qcom/gcc-msm8953.c                     |    1 +
 drivers/clk/qcom/gcc-sm8150.c                      |   61 -
 drivers/clk/qcom/hfpll.c                           |    6 +-
 drivers/clk/qcom/mmcc-msm8998.c                    |    8 +
 drivers/clk/renesas/clk-r8a73a4.c                  |    2 -
 drivers/clk/renesas/clk-r8a7740.c                  |   27 +-
 drivers/clk/renesas/clk-sh73a0.c                   |    2 -
 drivers/clk/renesas/r8a779a0-cpg-mssr.c            |    2 +-
 drivers/clk/renesas/r8a779h0-cpg-mssr.c            |   21 +
 drivers/clk/renesas/r9a07g043-cpg.c                |   13 +-
 drivers/clk/renesas/r9a07g044-cpg.c                |    2 +-
 drivers/clk/renesas/r9a08g045-cpg.c                |   41 +
 drivers/clk/renesas/rzg2l-cpg.c                    |  199 ++-
 drivers/clk/renesas/rzg2l-cpg.h                    |   67 +
 drivers/clk/rockchip/clk-mmc-phase.c               |    1 -
 drivers/clk/rockchip/clk-rk3568.c                  |    5 +
 drivers/clk/rockchip/rst-rk3588.c                  |    1 +
 drivers/clk/samsung/clk-exynos-arm64.c             |   56 +-
 drivers/clk/samsung/clk-exynos850.c                |  440 ++++-
 drivers/clk/samsung/clk-exynosautov9.c             |    8 +-
 drivers/clk/samsung/clk-gs101.c                    | 1192 +++++++++++--
 drivers/clk/samsung/clk.c                          |   11 +-
 drivers/clk/samsung/clk.h                          |   15 +-
 drivers/clk/sophgo/Kconfig                         |   11 +
 drivers/clk/sophgo/Makefile                        |    7 +
 drivers/clk/sophgo/clk-cv1800.c                    | 1537 ++++++++++++++++
 drivers/clk/sophgo/clk-cv1800.h                    |  123 ++
 drivers/clk/sophgo/clk-cv18xx-common.c             |   66 +
 drivers/clk/sophgo/clk-cv18xx-common.h             |   81 +
 drivers/clk/sophgo/clk-cv18xx-ip.c                 |  887 +++++++++
 drivers/clk/sophgo/clk-cv18xx-ip.h                 |  261 +++
 drivers/clk/sophgo/clk-cv18xx-pll.c                |  419 +++++
 drivers/clk/sophgo/clk-cv18xx-pll.h                |  118 ++
 drivers/clk/stm32/Kconfig                          |    7 +
 drivers/clk/stm32/Makefile                         |    1 +
 drivers/clk/stm32/clk-stm32-core.c                 |   11 +-
 drivers/clk/stm32/clk-stm32mp13.c                  |   72 +-
 drivers/clk/stm32/clk-stm32mp25.c                  | 1875 ++++++++++++++++++++
 drivers/clk/stm32/reset-stm32.c                    |   59 +-
 drivers/clk/stm32/reset-stm32.h                    |    7 +
 drivers/clk/stm32/stm32mp25_rcc.h                  |  712 ++++++++
 drivers/clk/sunxi-ng/ccu-sun20i-d1-r.c             |    1 +
 drivers/clk/sunxi-ng/ccu-sun20i-d1.c               |    1 +
 drivers/clk/sunxi-ng/ccu-sun4i-a10.c               |    1 +
 drivers/clk/sunxi-ng/ccu-sun50i-a100-r.c           |    1 +
 drivers/clk/sunxi-ng/ccu-sun50i-a100.c             |    1 +
 drivers/clk/sunxi-ng/ccu-sun50i-a64.c              |   13 +-
 drivers/clk/sunxi-ng/ccu-sun50i-h6-r.c             |    1 +
 drivers/clk/sunxi-ng/ccu-sun50i-h6.c               |    1 +
 drivers/clk/sunxi-ng/ccu-sun50i-h616.c             |    1 +
 drivers/clk/sunxi-ng/ccu-sun6i-a31.c               |    1 +
 drivers/clk/sunxi-ng/ccu-sun6i-rtc.c               |    1 +
 drivers/clk/sunxi-ng/ccu-sun8i-a23.c               |    1 +
 drivers/clk/sunxi-ng/ccu-sun8i-a33.c               |    1 +
 drivers/clk/sunxi-ng/ccu-sun8i-a83t.c              |    1 +
 drivers/clk/sunxi-ng/ccu-sun8i-de2.c               |    1 +
 drivers/clk/sunxi-ng/ccu-sun8i-h3.c                |    1 +
 drivers/clk/sunxi-ng/ccu-sun8i-r.c                 |    1 +
 drivers/clk/sunxi-ng/ccu-sun8i-r40.c               |    1 +
 drivers/clk/sunxi-ng/ccu-sun8i-v3s.c               |    1 +
 drivers/clk/sunxi-ng/ccu-sun9i-a80-de.c            |    1 +
 drivers/clk/sunxi-ng/ccu-sun9i-a80-usb.c           |    1 +
 drivers/clk/sunxi-ng/ccu-sun9i-a80.c               |    1 +
 drivers/clk/sunxi-ng/ccu-suniv-f1c100s.c           |    1 +
 drivers/clk/sunxi-ng/ccu_nkm.c                     |   21 +
 drivers/clk/sunxi-ng/ccu_nkm.h                     |    2 +
 drivers/clk/ti/dpll.c                              |   10 +-
 drivers/reset/reset-mpfs.c                         |   95 +-
 include/dt-bindings/clock/loongson,ls2k-clk.h      |   54 +-
 include/dt-bindings/clock/nxp,imx95-clock.h        |   28 +
 include/dt-bindings/clock/r9a07g043-cpg.h          |   58 +-
 include/dt-bindings/clock/r9a07g044-cpg.h          |   58 +
 include/dt-bindings/clock/r9a07g054-cpg.h          |   58 +
 include/dt-bindings/clock/r9a08g045-cpg.h          |   70 +
 include/dt-bindings/clock/rk3568-cru.h             |    1 +
 include/dt-bindings/reset/rockchip,rk3588-cru.h    |    2 +
 include/dt-bindings/reset/st,stm32mp25-rcc.h       |    2 +-
 include/soc/microchip/mpfs.h                       |   10 +-
 150 files changed, 10956 insertions(+), 1200 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/nxp,imx95-blk-ctl.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/nxp,imx95-display-master-csr.yaml
 delete mode 100644 Documentation/devicetree/bindings/clock/qcom,hfpll.txt
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,hfpll.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/samsung,s3c6400-clock.yaml
 delete mode 100644 Documentation/devicetree/bindings/clock/samsung,s3c64xx-clock.txt
 create mode 100644 drivers/clk/imx/clk-imx95-blk-ctl.c
 create mode 100644 drivers/clk/meson/vclk.c
 create mode 100644 drivers/clk/meson/vclk.h
 create mode 100644 drivers/clk/sophgo/Kconfig
 create mode 100644 drivers/clk/sophgo/Makefile
 create mode 100644 drivers/clk/sophgo/clk-cv1800.c
 create mode 100644 drivers/clk/sophgo/clk-cv1800.h
 create mode 100644 drivers/clk/sophgo/clk-cv18xx-common.c
 create mode 100644 drivers/clk/sophgo/clk-cv18xx-common.h
 create mode 100644 drivers/clk/sophgo/clk-cv18xx-ip.c
 create mode 100644 drivers/clk/sophgo/clk-cv18xx-ip.h
 create mode 100644 drivers/clk/sophgo/clk-cv18xx-pll.c
 create mode 100644 drivers/clk/sophgo/clk-cv18xx-pll.h
 create mode 100644 drivers/clk/stm32/clk-stm32mp25.c
 create mode 100644 drivers/clk/stm32/stm32mp25_rcc.h
 create mode 100644 include/dt-bindings/clock/nxp,imx95-clock.h

-- 
https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
https://git.kernel.org/pub/scm/linux/kernel/git/sboyd/spmi.git

