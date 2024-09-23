Return-Path: <linux-kernel+bounces-336213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C536797F0A5
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 20:30:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B06EB21C86
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 18:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26A8C1A0705;
	Mon, 23 Sep 2024 18:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D45OuOUa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 788C2101DE;
	Mon, 23 Sep 2024 18:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727116200; cv=none; b=EYmajcLJzCPb4UMIVGGv4WiJxJNzkIMwfgPTGJGYw6IxPRP7xqFYxGUcgugjWhIxQHIbE40X0bl8Ra1111X2P72GqatLQkxUChh40bZTrzDnbtvQ9MyxjayvP6E6fb8OzCC6DcUDm7P2F6wc3A9gKL0qRBNgwVD1vAyE1ey+BdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727116200; c=relaxed/simple;
	bh=UORlMUFrlw/lgISbboU0TYZP4sLP4q/xyDa+LrX1CJA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BnUYGYc2pYFxmbeVt7Xrpt3SjEHsGxMOxI61oWQFwQG0+2n8LZEm4/cH7gZhhLC8OI2ldfrmk70568fV4bgXd07r+XqSiCommYnJclGks+oa6hhErFo5QCnDpe191c3qK+/EEuMOclrJ3QAL8YoN4f9QPWroKm6YjrQLSJDmib0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D45OuOUa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A58A4C4CEC4;
	Mon, 23 Sep 2024 18:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727116199;
	bh=UORlMUFrlw/lgISbboU0TYZP4sLP4q/xyDa+LrX1CJA=;
	h=From:To:Cc:Subject:Date:From;
	b=D45OuOUa0rRoZGyPfIynPwYRBgts1Xypqn6LaOA0REqI43TdsUi38zEzwkO8XLTL5
	 mYjWEfaMFkv5qbeMzIeXiSiLGRFxkY40rhAMWCcCz8C9whOtHv+oQR7xVcZcJbA7O6
	 PosaG4v06nXGqTYJIj8oaG8mk7XtclCiNQUB0ow605Kn4hvkfqbv9f4KG2e5u9W/EA
	 tXafLHgJyKUwe++qy/kb+udHX6Zxlsx57f6pzbUz6h6QwioUtkV9lA8ggBKeELsQKX
	 IPsZXubB4joNx4rptB3ELlCjgxCjkeRgr1aV9F5DrA5RmOKTYvGLfrdTrXms+ULwT3
	 A9hbrMpHHvnJw==
From: Stephen Boyd <sboyd@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Michael Turquette <mturquette@baylibre.com>,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] clk changes for the merge window
Date: Mon, 23 Sep 2024 11:29:56 -0700
Message-ID: <20240923182958.818256-1-sboyd@kernel.org>
X-Mailer: git-send-email 2.46.0.792.g87dc391469-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following changes since commit 997daa8de64ccbb4dc68d250510893597d485de4:

  dt-bindings: clock: add ExynosAuto v920 SoC CMU bindings (2024-08-23 09:16:41 +0200)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-for-linus

for you to fetch changes up to f00b45db02ae4e0288bb719a9935b966733c7e91:

  clk: Switch back to struct platform_driver::remove() (2024-09-21 14:12:05 -0700)

----------------------------------------------------------------
The core clk framework is left largely untouched this time around except for
support for the newly ratified DT property 'assigned-clock-rates-u64'. I'm much
more excited about the support for loading DT overlays from KUnit tests so that
we can test how the clk framework parses DT nodes during clk registration. The
clk framework has some places that are highly DeviceTree dependent so this
charts the path to extend the KUnit tests to cover even more framework code in
the future. I've got some more tests on the list that use the DT overlay
support, but they uncovered issues with clk unregistration that I'm still
working on fixing.

Outside the core, the clk driver update pile is dominated by Qualcomm and
Renesas SoCs, making it fairly usual. Looking closer, there are fixes for
things all over the place, like adding missing clk frequencies or moving
defines for the number of clks out of DT binding headers into the drivers.
There are even conversions of DT bindings to YAML and migration away from
strings to describe clk topology. Overall it doesn't look unusual so I expect
the new drivers to be where we'll have fixes in the coming weeks.

Core:
 - KUnit tests for clk registration and fixed rate basic clk type
 - A couple more devm helpers, one consumer and one provider
 - Support for assigned-clock-rates-u64

New Drivers:
 - Camera, display and GPU clocks on Qualcomm SM4450
 - Camera clocks on Qualcomm SM8150
 - Rockchip rk3576 clks
 - Microchip SAM9X7 clks
 - Renesas RZ/V2H(P) (R9A09G057) clks

Updates:
 - Mark a bunch of struct freq_tbl const to reduce .data usage
 - Add Qualcomm MSM8226 A7PLL and Regera PLL support
 - Fix the Qualcomm Lucid 5LPE PLL configuration sequence to not reuse
   Trion, as they do differ
 - A number of fixes to the Qualcomm SM8550 display clock driver
 - Fold Qualcomm SM8650 display clock driver into SM8550 one
 - Add missing clocks and GDSCs needed for audio on Qualcomm MSM8998
 - Add missing USB MP resets, GPLL9, and QUPv3 DFS to Qualcomm SC8180X
 - Fix sdcc clk frequency tables on Qualcomm SC8180X
 - Drop the Qualcomm SM8150 gcc_cpuss_ahb_clk_src
 - Mark Qualcomm PCIe GDSCs as RET_ON on sm8250 and sm8540 to avoid them
   turning off during suspend
 - Use the HW_CTRL mechanism on Qualcomm SM8550 video clock controller
   GDSCs
 - Get rid of CLK_NR_CLKS defines in Rockchip DT binding headers
 - Some fixes for Rockchip rk3228 and rk3588
 - Exynos850: Add clock for Thermal Management Unit
 - Exynos7885: Fix duplicated ID in the header, add missing TOP PLLs and
   add clocks for USB block in the FSYS clock controller
 - ExynosAutov9: Add DPUM clock controller
 - ExynosAutov920: Add new (first) clock controllers: TOP and PERIC0
   (and a bit more complete bindings)
 - Use clk_hw pointer instead of fw_name for acm_aud_clk[0-1]_sel clocks
   on i.MX8Q as parents in ACM provider
 - Add i.MX95 NETCMIX support to the block control provider
 - Fix parents for ENETx_REF_SEL clocks on i.MX6UL
 - Add USB clocks, resets and power domains on Renesas RZ/G3S
 - Add Generic Timer (GTM), I2C Bus Interface (RIIC), SD/MMC Host
   Interface (SDHI) and Watchdog Timer (WDT) clocks and resets on
   Renesas RZ/V2H
 - Add PCIe, PWM, and CAN-FD clocks on Renesas R-Car V4M
 - Add LCD controller clocks and resets on Renesas RZ/G2UL
 - Add DMA clocks and resets on Renesas RZ/G3S
 - Add fractional multiplication PLL support on Renesas R-Car Gen4
 - Document support for the Renesas RZ/G2M v3.0 (r8a774a3) SoC
 - Support for the Microchip SAM9X7 SoC as follows:
 - Updates for the Microchip PLL drivers
 - DT binding documentation updates (for the new clock driver and for
   the slow clock controller that SAM9X7 is using)
 - A fix for the Microchip SAMA7G5 clock driver to avoid allocating more
   memory than necessary
 - Constify some Amlogic structs
 - Add SM1 eARC clocks for Amlogic
 - Introduce a symbol namespace for Amlogic clock specific symbols
 - Add reset controller support to audiomix block control on i.MX
 - Add CLK_SET_RATE_PARENT flag to all audiomix clocks and to
   i.MX7D lcdif_pixel_src clock
 - Fix parent clocks for earc_phy and audpll on i.MX8MP
 - Fix default parents for enet[12]_ref_sel on i.MX6UL
 - Add ops in composite 8M and 93 that allow no-op on disable
 - Add check for PCC present bit on composite 7ULP register
 - Fix fractional part for fracn-gppll on prepare in i.MX
 - Fix clock tree update for TF-A managed clocks on i.MX8M
 - Drop CLK_SET_PARENT_GATE for DRAM mux on i.MX7D
 - Add the SAI7 IPG clock for i.MX8MN
 - Mark the 'nand_usdhc_bus' clock as non-critical on i.MX8MM
 - Add LVDS bypass clocks on i.MX8QXP
 - Add muxes for MIPI and PHY ref clocks on i.MX
 - Reorder dc0_bypass0_clk, lcd_pxl and dc1_disp clocks on i.MX8QXP
 - Add 1039.5MHz and 800MHz rates to fracn-gppll table on i.MX
 - Add CLK_SET_RATE_PARENT for media_disp pixel clocks on i.MX8QXP
 - Add some module descriptions to the i.MX generic and the
   i.MXRT1050 driver
 - Fix return value for bypass for composite i.MX7ULP
 - Move Mediatek clk bindings to clock/
 - Convert some more clk bindings to dt schema

----------------------------------------------------------------
Adrian Alonso (1):
      clk: imx: imx8mn: add sai7_ipg_clk clock settings

Ajit Pandey (4):
      clk: qcom: clk-alpha-pll: Fix CAL_L_VAL override for LUCID EVO PLL
      clk: qcom: Add DISPCC driver support for SM4450
      clk: qcom: Add CAMCC driver support for SM4450
      clk: qcom: Add GPUCC driver support for SM4450

Alexander Shiyan (1):
      clk: rockchip: rk3588: Fix 32k clock name for pmu_24m_32k_100m_src_p

Andy Shevchenko (2):
      clk: mmp: Switch to use kmemdup_array()
      clk: visconti: Switch to use kmemdup_array()

AngeloGioacchino Del Regno (2):
      clk: mediatek: reset: Remove unused mtk_register_reset_controller()
      clk: qcom: gcc-msm8998: Add Q6 BIMC and LPASS core, ADSP SMMU clocks

Animesh Agarwal (2):
      dt-bindings: clock: nxp,lpc3220-clk: Convert bindings to DT schema
      dt-bindings: clock: nxp,lpc3220-usb-clk: Convert bindings to dtschema

Arnd Bergmann (1):
      clk: rockchip: remove unused mclk_pdm0_p/pdm0_p definitions

Bartosz Golaszewski (1):
      clk: provide devm_clk_get_optional_enabled_with_rate()

Biju Das (1):
      clk: renesas: r9a07g043: Add LCDC clock and reset entries

Bjorn Andersson (8):
      Merge branch '20240730-sc8180x-usb-mp-v2-1-a7dc4265b553@quicinc.com' into clk-for-6.12
      clk: qcom: gcc-sc8180x: Add missing USB MP resets
      Merge branch '20240731062916.2680823-7-quic_skakitap@quicinc.com' into clk-for-6.12
      Merge branch '20240717-dispcc-sm8550-fixes-v2-7-5c4a3128c40b@linaro.org' into clk-for-6.12
      clk: qcom: camcc-sm8150: Correct qcom_cc_really_probe() argument
      Merge branch '20240611133752.2192401-1-quic_ajipan@quicinc.com' into clk-for-6.12
      Merge branch '20240814-lpass-v1-1-a5bb8f9dfa8b@freebox.fr' into clk-for-6.12
      Merge branch '20240730054817.1915652-2-quic_varada@quicinc.com' into clk-for-6.12

Christophe JAILLET (1):
      clk: qcom: Constify struct freq_tbl

Claudiu Beznea (3):
      clk: renesas: r9a08g045: Add DMA clocks and resets
      clk: at91: sama7g5: Allocate only the needed amount of memory for PLLs
      clk: renesas: r9a08g045: Add clocks, resets and power domains for USB

Cong Dang (2):
      clk: renesas: r8a779h0: Add PWM clock
      clk: renesas: r8a779h0: Add CANFD clock

David Hunter (1):
      da8xx-cfgchip.c: replace of_node_put with __free improves cleanup

David Lechner (1):
      clk: ti: dra7-atl: Fix leak of of_nodes

David Virag (4):
      clk: samsung: exynos7885: Update CLKS_NR_FSYS after bindings fix
      clk: samsung: exynos7885: Add missing MUX clocks from PLLs in CMU_TOP
      clk: samsung: clk-pll: Add support for pll_1418x
      clk: samsung: exynos7885: Add USB related clocks to CMU_FSYS

Detlev Casanova (1):
      dt-bindings: clock, reset: Add support for rk3576

Dmitry Baryshkov (8):
      clk: qcom: dispcc-sm8550: fix several supposed typos
      clk: qcom: dispcc-sm8550: use rcg2_ops for mdss_dptx1_aux_clk_src
      clk: qcom: dispcc-sm8550: make struct clk_init_data const
      clk: qcom: dispcc-sm8650: Update the GDSC flags
      clk: qcom: dispcc-sm8550: use rcg2_shared_ops for ESC RCGs
      clk: qcom: fold dispcc-sm8650 info dispcc-sm8550
      clk: qcom: dispcc-sm8250: use CLK_SET_RATE_PARENT for branch clocks
      clk: qcom: dispcc-sm8250: use special function for Lucid 5LPE PLL

Elaine Zhang (2):
      clk: rockchip: Add new pll type pll_rk3588_ddr
      clk: rockchip: Add clock controller for the RK3576

Fei Shao (1):
      clk: mediatek: reset: Return regmap's error code

Geert Uytterhoeven (19):
      clk: renesas: r8a779a0: cpg_pll_configs should be __initconst
      clk: renesas: r8a779f0: cpg_pll_configs should be __initconst
      clk: renesas: r8a779g0: cpg_pll_configs should be __initconst
      clk: renesas: r8a779h0: Initial clock descriptions should be __initconst
      clk: renesas: rcar-gen4: Removed unused SSMODE_* definitions
      clk: renesas: rcar-gen4: Clarify custom PLL clock support
      clk: renesas: rcar-gen4: Use FIELD_GET()
      clk: renesas: rcar-gen4: Use defines for common CPG registers
      clk: renesas: rcar-gen4: Add support for fractional multiplication
      clk: renesas: rcar-gen4: Add support for variable fractional PLLs
      clk: renesas: rcar-gen4: Add support for fixed variable PLLs
      clk: renesas: rcar-gen4: Add support for fractional 9.24 PLLs
      clk: renesas: r8a779a0: Use defines for PLL control registers
      clk: renesas: r8a779f0: Model PLL1/2/3/6 as fractional PLLs
      clk: renesas: r8a779g0: Model PLL1/3/4/6 as fractional PLLs
      clk: renesas: r8a779h0: Model PLL1/2/3/4/6 as fractional PLLs
      clk: renesas: rcar-gen4: Remove unused variable PLL2 clock type
      clk: renesas: rcar-gen4: Remove unused fixed PLL clock types
      clk: renesas: rcar-gen4: Remove unused default PLL2/3/4/6 configs

Heiko Stuebner (1):
      dt-bindings: clock, reset: fix top-comment indentation rk3576 headers

Huan Yang (1):
      clk: lmk04832: Use devm_clk_get_enabled() helpers

Jacky Bai (2):
      clk: imx: composite-93: keep root clock on when mcore enabled
      clk: imx: imx8mm: Change the 'nand_usdhc_bus' clock to non-critical one

Jagadeesh Kona (2):
      dt-bindings: clock: qcom: Drop required-opps in required on sm8650 videocc
      dt-bindings: clock: qcom: Drop required-opps in required on SM8650 camcc

Javier Carrasco (6):
      clk: meson: a1: peripherals: Constify struct regmap_config
      clk: meson: a1: pll: Constify struct regmap_config
      clk: meson: c3: peripherals: Constify struct regmap_config
      clk: meson: c3: pll: Constify struct regmap_config
      clk: meson: s4: peripherals: Constify struct regmap_config
      clk: meson: s4: pll: Constify struct regmap_config

Jeff Johnson (1):
      clk: imx: add missing MODULE_DESCRIPTION() macros

Jerome Brunet (6):
      Merge tag 'v6.11-rc1' into clk-meson-next
      dt-bindings: clock: axg-audio: add earcrx clock ids
      Merge branch 'v6.12/bindings' into clk-meson-next
      clk: meson: axg-audio: setup regmap max_register based on the SoC
      clk: meson: axg-audio: add sm1 earcrx clocks
      clk: meson: introduce symbol namespace for amlogic clocks

Johan Jonker (9):
      clk: rockchip: px30: Drop CLK_NR_CLKS CLKPMU_NR_CLKS usage
      clk: rockchip: rk3036: Drop CLK_NR_CLKS usage
      clk: rockchip: rk3228: Drop CLK_NR_CLKS usage
      clk: rockchip: rk3288: Drop CLK_NR_CLKS usage
      clk: rockchip: rk3308: Drop CLK_NR_CLKS usage
      clk: rockchip: rk3328: Drop CLK_NR_CLKS usage
      clk: rockchip: rk3368: Drop CLK_NR_CLKS usage
      clk: rockchip: rk3399: Drop CLK_NR_CLKS CLKPMU_NR_CLKS usage
      dt-bindings: clock: rockchip: remove CLK_NR_CLKS and CLKPMU_NR_CLKS

Jonas Karlman (1):
      clk: rockchip: Set parent rate for DCLK_VOP clock on RK3228

Krzysztof Kozlowski (9):
      Merge branch 'for-v6.12/clk-dt-bindings' into next/clk
      Merge branch 'for-v6.12/clk-dt-bindings' into next/clk
      Merge branch 'for-v6.12/clk-dt-bindings' into next/clk
      dt-bindings: clock: renesas,cpg-clocks: Add top-level constraints
      dt-bindings: clock: baikal,bt1-ccu-div: add top-level constraints
      dt-bindings: clock: cirrus,lochnagar: add top-level constraints
      dt-bindings: clock: st,stm32mp1-rcc: add top-level constraints
      clk: bcm: bcm53573: fix OF node leak in init
      dt-bindings: clock: rockchip,rk3588-cru: drop unneeded assigned-clocks

Kwanghoon Son (1):
      clk: samsung: exynosautov9: add dpum clock support

Lad Prabhakar (7):
      clk: renesas: rzg2l-cpg: Use devres API to register clocks
      clk: renesas: rzg2l-cpg: Refactor to use priv for clks and base in clock register functions
      dt-bindings: clock: renesas: Document RZ/V2H(P) SoC CPG
      clk: renesas: Add family-specific clock driver for RZ/V2H(P)
      clk: renesas: Add RZ/V2H(P) CPG driver
      clk: renesas: rzv2h: Add support for dynamic switching divider clocks
      clk: renesas: r9a09g057: Add clock and reset entries for GTM/RIIC/SDHI/WDT

Luca Weiss (3):
      dt-bindings: clock: qcom,a53pll: Allow opp-table subnode
      dt-bindings: clock: qcom,a53pll: Add msm8226-a7pll compatible
      clk: qcom: a53-pll: Add MSM8226 a7pll support

Manivannan Sadhasivam (2):
      clk: qcom: gcc-sm8250: Do not turn off PCIe GDSCs during gdsc_disable()
      clk: qcom: gcc-sm8450: Do not turn off PCIe GDSCs during gdsc_disable()

Marek Vasut (1):
      clk: imx: clk-imx8mp: Allow media_disp pixel clock reconfigure parent rate

Michel Alex (1):
      clk: imx6ul: fix clock parent for IMX6UL_CLK_ENETx_REF_SEL

Mike Tipton (1):
      clk: qcom: clk-rpmh: Fix overflow in BCM vote

Nikita Shubin (1):
      clk: fixed-rate: add devm_clk_hw_register_fixed_rate_parent_data()

Nuno Sá (1):
      clk: use clk_core_unlink_consumer() helper

Oliver F. Brown (1):
      clk: imx: imx8qxp: Add clock muxes for MIPI and PHY ref clocks

Oliver Rhodes (1):
      dt-bindings: clock: renesas,cpg-mssr: Document RZ/G2M v3.0 (r8a774a3) clock

Peng Fan (10):
      clk: imx: composite-8m: Enable gate clk with mcore_booted
      clk: imx: Remove CLK_SET_PARENT_GATE for DRAM mux for i.MX7D
      clk: imx: add CLK_SET_RATE_PARENT for lcdif_pixel_src for i.MX7D
      clk: imx: imx8qxp: Add LVDS bypass clocks
      clk: imx: imx8qxp: Register dc0_bypass0_clk before disp clk
      clk: imx: imx8qxp: Parent should be initialized earlier than the clock
      clk: imx: fracn-gppll: update rate table
      clk: imx: composite-7ulp: Use NULL instead of 0
      clk: clk-conf: support assigned-clock-rates-u64
      clk: scmi: add is_prepared hook

Pengfei Li (1):
      clk: imx: fracn-gppll: fix fractional part of PLL getting lost

Rayyan Ansari (1):
      dt-bindings: clock: qcom,qcs404-turingcc: convert to dtschema

Rob Herring (Arm) (5):
      clk: at91: Use of_property_count_u32_elems() to get property length
      clk: Use of_property_present()
      dt-bindings: clock: mediatek,apmixedsys: Fix "mediatek,mt6779-apmixed" compatible
      dt-bindings: Move Mediatek clock controllers to "clock" directory
      dt-bindings: clock: mediatek: Convert MediaTek clock syscons to schema

Sam Protsenko (1):
      clk: samsung: exynos850: Add TMU clock

Satya Priya Kakitapalli (7):
      clk: qcom: Add camera clock controller driver for SM8150
      clk: qcom: gcc-sc8180x: Register QUPv3 RCGs for DFS on sc8180x
      dt-bindings: clock: qcom: Add GPLL9 support on gcc-sc8180x
      clk: qcom: gcc-sc8180x: Add GPLL9 support
      clk: qcom: gcc-sc8180x: Fix the sdcc2 and sdcc4 clocks freq table
      clk: qcom: gcc-sm8150: De-register gcc_cpuss_ahb_clk_src
      clk: qcom: Fix SM_CAMCC_8150 dependencies

Sebastian Reichel (2):
      clk: rockchip: rk3588: drop unused code
      clk: rockchip: fix error for unknown clocks

Sebastien Laveze (1):
      clk: imx: imx6ul: fix default parent for enet*_ref_sel

Shengjiu Wang (5):
      dt-bindings: clock: imx8mp: Add #reset-cells property
      clk: imx: clk-audiomix: Add reset controller
      clk: imx: clk-audiomix: Add CLK_SET_RATE_PARENT flags for clocks
      clk: imx: clk-audiomix: Correct parent clock for earc_phy and audpll
      clk: imx: imx8: Use clk_hw pointer for self registered clock in clk_parent_data

Srinivas Kandagatla (2):
      dt-bindings: clock: Add x1e80100 LPASS AUDIOCC reset controller
      dt-bindings: clock: Add x1e80100 LPASSCC reset controller

Stephen Boyd (22):
      Merge tag 'clk-imx-6.11' of git://git.kernel.org/pub/scm/linux/kernel/git/abelvesa/linux into clk-imx
      of/platform: Allow overlays to create platform devices from the root node
      of: Add test managed wrappers for of_overlay_apply()/of_node_put()
      dt-bindings: vendor-prefixes: Add "test" vendor for KUnit and friends
      of: Add a KUnit test for overlays and test managed APIs
      platform: Add test managed platform_device/driver APIs
      clk: Add test managed clk provider/consumer APIs
      clk: Add KUnit tests for clk fixed rate basic type
      clk: Add KUnit tests for clks registered with struct clk_parent_data
      Merge tag 'renesas-clk-for-v6.12-tag1' of git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers into clk-renesas
      Merge tag 'clk-meson-v6.12-1' of https://github.com/BayLibre/clk-meson into clk-amlogic
      Merge tag 'clk-microchip-6.12' of https://git.kernel.org/pub/scm/linux/kernel/git/at91/linux into clk-microchip
      Merge tag 'renesas-clk-for-v6.12-tag2' of git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers into clk-renesas
      Merge tag 'clk-imx-6.12' of git://git.kernel.org/pub/scm/linux/kernel/git/abelvesa/linux into clk-imx2
      Merge branch 'clk-imx-old' into clk-imx
      Merge tag 'samsung-clk-6.12' of https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux into clk-samsung
      Merge tag 'v6.12-rockchip-clk1' of git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip into clk-rockchip
      Merge tag 'qcom-clk-for-6.12' of https://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux into clk-qcom
      Merge branches 'clk-kunit', 'clk-mediatek', 'clk-cleanup' and 'clk-bindings' into clk-next
      Merge branches 'clk-assigned-rates', 'clk-renesas' and 'clk-scmi' into clk-next
      Merge branches 'clk-amlogic', 'clk-microchip' and 'clk-imx' into clk-next
      Merge branches 'clk-devm', 'clk-samsung', 'clk-rockchip' and 'clk-qcom' into clk-next

Sunyeal Hong (2):
      clk: samsung: clk-pll: Add support for pll_531x
      clk: samsung: add top clock support for ExynosAuto v920 SoC

Taniya Das (1):
      clk: qcom: clk-alpha-pll: Add support for Regera PLL ops

Thorsten Blum (1):
      clk: hisilicon: Remove unnecessary local variable

Uwe Kleine-König (1):
      clk: Switch back to struct platform_driver::remove()

Varadarajan Narayanan (3):
      dt-bindings: usb: qcom,dwc3: Update ipq5332 clock details
      clk: qcom: ipq5332: Register gcc_qdss_tsctr_clk_src
      clk: qcom: ipq5332: Use icc-clk for enabling NoC related clocks

Varshini Rajendran (7):
      dt-bindings: clocks: atmel,at91sam9x5-sckc: add sam9x7
      dt-bindings: clocks: atmel,at91rm9200-pmc: add sam9x7 clock controller
      clk: at91: clk-sam9x60-pll: re-factor to support individual core freq outputs
      clk: at91: sam9x7: add support for HW PLL freq dividers
      clk: at91: sama7g5: move mux table macros to header file
      dt-bindings: clock: at91: Allow PLLs to be exported and referenced in DT
      clk: at91: sam9x7: add sam9x7 pmc driver

Vedang Nagar (1):
      clk: qcom: videocc-sm8550: Use HW_CTRL_TRIGGER flag for video GDSC's

Wei Fang (3):
      dt-bindings: clock: add i.MX95 NETCMIX block control
      dt-bindings: clock: add RMII clock selection
      clk: imx95: enable the clock of NETCMIX block control

Ye Li (1):
      clk: imx: composite-7ulp: Check the PCC present bit

Yoshihiro Shimoda (1):
      clk: renesas: r8a779h0: Add PCIe clock

Yuesong Li (1):
      clk:davinci: make use of dev_err_cast_probe()

Yuntao Liu (1):
      clk: starfive: Use pm_runtime_resume_and_get to fix pm_runtime_get_sync() usage

Zhipeng Wang (1):
      clk: imx: imx8mp: fix clock tree update of TF-A managed clocks

 Documentation/dev-tools/kunit/api/clk.rst          |   10 +
 Documentation/dev-tools/kunit/api/index.rst        |   21 +
 Documentation/dev-tools/kunit/api/of.rst           |   13 +
 .../dev-tools/kunit/api/platformdevice.rst         |   10 +
 .../bindings/arm/mediatek/mediatek,bdpsys.txt      |   24 -
 .../bindings/arm/mediatek/mediatek,camsys.txt      |   24 -
 .../bindings/arm/mediatek/mediatek,imgsys.txt      |   30 -
 .../bindings/arm/mediatek/mediatek,ipesys.txt      |   22 -
 .../bindings/arm/mediatek/mediatek,ipu.txt         |   43 -
 .../bindings/arm/mediatek/mediatek,jpgdecsys.txt   |   22 -
 .../bindings/arm/mediatek/mediatek,mcucfg.txt      |   23 -
 .../bindings/arm/mediatek/mediatek,mfgcfg.txt      |   25 -
 .../bindings/arm/mediatek/mediatek,mipi0a.txt      |   28 -
 .../bindings/arm/mediatek/mediatek,vcodecsys.txt   |   27 -
 .../bindings/arm/mediatek/mediatek,vdecsys.txt     |   29 -
 .../bindings/arm/mediatek/mediatek,vencltsys.txt   |   22 -
 .../bindings/arm/mediatek/mediatek,vencsys.txt     |   26 -
 .../bindings/clock/atmel,at91rm9200-pmc.yaml       |    2 +
 .../bindings/clock/atmel,at91sam9x5-sckc.yaml      |    4 +-
 .../bindings/clock/baikal,bt1-ccu-div.yaml         |    8 +-
 .../bindings/clock/cirrus,lochnagar.yaml           |    6 +-
 .../devicetree/bindings/clock/imx8mp-audiomix.yaml |    3 +
 .../bindings/clock/mediatek,apmixedsys.yaml        |    2 +-
 .../{arm/mediatek => clock}/mediatek,infracfg.yaml |    2 +-
 .../mediatek => clock}/mediatek,mt8186-clock.yaml  |    2 +-
 .../mediatek,mt8186-sys-clock.yaml                 |    2 +-
 .../mediatek => clock}/mediatek,mt8192-clock.yaml  |    2 +-
 .../mediatek,mt8192-sys-clock.yaml                 |    2 +-
 .../mediatek => clock}/mediatek,mt8195-clock.yaml  |    2 +-
 .../mediatek,mt8195-sys-clock.yaml                 |    2 +-
 .../{arm/mediatek => clock}/mediatek,pericfg.yaml  |    2 +-
 .../devicetree/bindings/clock/mediatek,syscon.yaml |   93 +
 .../bindings/clock/nxp,imx95-blk-ctl.yaml          |    1 +
 .../devicetree/bindings/clock/nxp,lpc3220-clk.txt  |   30 -
 .../devicetree/bindings/clock/nxp,lpc3220-clk.yaml |   51 +
 .../bindings/clock/nxp,lpc3220-usb-clk.txt         |   22 -
 .../bindings/clock/nxp,lpc3220-usb-clk.yaml        |   35 +
 .../devicetree/bindings/clock/qcom,a53pll.yaml     |    4 +
 .../bindings/clock/qcom,ipq5332-gcc.yaml           |    2 +
 .../bindings/clock/qcom,qcs404-turingcc.yaml       |   47 +
 .../bindings/clock/qcom,sc8280xp-lpasscc.yaml      |   13 +-
 .../bindings/clock/qcom,sm4450-camcc.yaml          |   63 +
 .../bindings/clock/qcom,sm4450-dispcc.yaml         |   71 +
 .../bindings/clock/qcom,sm8150-camcc.yaml          |   77 +
 .../bindings/clock/qcom,sm8450-camcc.yaml          |   19 +-
 .../bindings/clock/qcom,sm8450-gpucc.yaml          |    2 +
 .../bindings/clock/qcom,sm8450-videocc.yaml        |   11 +-
 .../devicetree/bindings/clock/qcom,turingcc.txt    |   19 -
 .../bindings/clock/renesas,cpg-clocks.yaml         |    8 +-
 .../bindings/clock/renesas,cpg-mssr.yaml           |    1 +
 .../bindings/clock/renesas,rzv2h-cpg.yaml          |   80 +
 .../bindings/clock/rockchip,rk3576-cru.yaml        |   56 +
 .../bindings/clock/rockchip,rk3588-cru.yaml        |    4 -
 .../devicetree/bindings/clock/st,stm32mp1-rcc.yaml |   10 +-
 .../devicetree/bindings/usb/qcom,dwc3.yaml         |    2 +-
 .../devicetree/bindings/vendor-prefixes.yaml       |    2 +
 drivers/base/dd.c                                  |    1 +
 drivers/clk/.kunitconfig                           |    2 +
 drivers/clk/Kconfig                                |   11 +
 drivers/clk/Makefile                               |   11 +-
 drivers/clk/at91/Makefile                          |    1 +
 drivers/clk/at91/clk-sam9x60-pll.c                 |   42 +-
 drivers/clk/at91/dt-compat.c                       |    5 +-
 drivers/clk/at91/pmc.h                             |   18 +
 drivers/clk/at91/sam9x60.c                         |    7 +
 drivers/clk/at91/sam9x7.c                          |  946 +++++++++
 drivers/clk/at91/sama7g5.c                         |   47 +-
 drivers/clk/axs10x/i2s_pll_clock.c                 |    2 +-
 drivers/clk/bcm/clk-bcm2711-dvp.c                  |    2 +-
 drivers/clk/bcm/clk-bcm53573-ilp.c                 |    2 +-
 drivers/clk/bcm/clk-bcm63xx-gate.c                 |    2 +-
 drivers/clk/bcm/clk-raspberrypi.c                  |    2 +-
 drivers/clk/clk-conf.c                             |   43 +-
 drivers/clk/clk-devres.c                           |   28 +
 drivers/clk/clk-fixed-factor.c                     |    2 +-
 drivers/clk/clk-fixed-mmio.c                       |    2 +-
 drivers/clk/clk-fixed-rate.c                       |    2 +-
 drivers/clk/clk-fixed-rate_test.c                  |  380 ++++
 drivers/clk/clk-fixed-rate_test.h                  |    8 +
 drivers/clk/clk-lmk04832.c                         |   43 +-
 drivers/clk/clk-palmas.c                           |    2 +-
 drivers/clk/clk-pwm.c                              |    2 +-
 drivers/clk/clk-s2mps11.c                          |    2 +-
 drivers/clk/clk-scmi.c                             |   16 +-
 drivers/clk/clk-scpi.c                             |    2 +-
 drivers/clk/clk.c                                  |    4 +-
 drivers/clk/clk_kunit_helpers.c                    |  207 ++
 drivers/clk/clk_parent_data_test.h                 |   10 +
 drivers/clk/clk_test.c                             |  453 +++-
 drivers/clk/davinci/da8xx-cfgchip.c                |    7 +-
 drivers/clk/hisilicon/clk-hi3519.c                 |    2 +-
 drivers/clk/hisilicon/clk-hi3559a.c                |    9 +-
 drivers/clk/hisilicon/crg-hi3516cv300.c            |    2 +-
 drivers/clk/hisilicon/crg-hi3798cv200.c            |    2 +-
 drivers/clk/imx/Kconfig                            |    1 +
 drivers/clk/imx/clk-composite-7ulp.c               |    7 +
 drivers/clk/imx/clk-composite-8m.c                 |   51 +-
 drivers/clk/imx/clk-composite-93.c                 |   15 +-
 drivers/clk/imx/clk-fracn-gppll.c                  |    6 +
 drivers/clk/imx/clk-imx6ul.c                       |    4 +-
 drivers/clk/imx/clk-imx7d.c                        |    6 +-
 drivers/clk/imx/clk-imx8-acm.c                     |   40 +-
 drivers/clk/imx/clk-imx8mm.c                       |    2 +-
 drivers/clk/imx/clk-imx8mn.c                       |    1 +
 drivers/clk/imx/clk-imx8mp-audiomix.c              |   88 +-
 drivers/clk/imx/clk-imx8mp.c                       |    8 +-
 drivers/clk/imx/clk-imx8qxp.c                      |   51 +-
 drivers/clk/imx/clk-imx95-blk-ctl.c                |   30 +
 drivers/clk/imx/clk-imxrt1050.c                    |    1 +
 drivers/clk/imx/clk.c                              |    1 +
 drivers/clk/imx/clk.h                              |    4 +
 drivers/clk/keystone/sci-clk.c                     |    2 +-
 drivers/clk/kunit_clk_fixed_rate_test.dtso         |   19 +
 drivers/clk/kunit_clk_parent_data_test.dtso        |   28 +
 drivers/clk/mediatek/clk-mt2701-aud.c              |    2 +-
 drivers/clk/mediatek/clk-mt2701-bdp.c              |    2 +-
 drivers/clk/mediatek/clk-mt2701-eth.c              |    2 +-
 drivers/clk/mediatek/clk-mt2701-g3d.c              |    2 +-
 drivers/clk/mediatek/clk-mt2701-hif.c              |    2 +-
 drivers/clk/mediatek/clk-mt2701-img.c              |    2 +-
 drivers/clk/mediatek/clk-mt2701-mm.c               |    2 +-
 drivers/clk/mediatek/clk-mt2701-vdec.c             |    2 +-
 drivers/clk/mediatek/clk-mt2712-apmixedsys.c       |    2 +-
 drivers/clk/mediatek/clk-mt2712-bdp.c              |    2 +-
 drivers/clk/mediatek/clk-mt2712-img.c              |    2 +-
 drivers/clk/mediatek/clk-mt2712-jpgdec.c           |    2 +-
 drivers/clk/mediatek/clk-mt2712-mfg.c              |    2 +-
 drivers/clk/mediatek/clk-mt2712-mm.c               |    2 +-
 drivers/clk/mediatek/clk-mt2712-vdec.c             |    2 +-
 drivers/clk/mediatek/clk-mt2712-venc.c             |    2 +-
 drivers/clk/mediatek/clk-mt2712.c                  |    2 +-
 drivers/clk/mediatek/clk-mt6765-audio.c            |    2 +-
 drivers/clk/mediatek/clk-mt6765-cam.c              |    2 +-
 drivers/clk/mediatek/clk-mt6765-img.c              |    2 +-
 drivers/clk/mediatek/clk-mt6765-mipi0a.c           |    2 +-
 drivers/clk/mediatek/clk-mt6765-mm.c               |    2 +-
 drivers/clk/mediatek/clk-mt6765-vcodec.c           |    2 +-
 drivers/clk/mediatek/clk-mt6779-aud.c              |    2 +-
 drivers/clk/mediatek/clk-mt6779-cam.c              |    2 +-
 drivers/clk/mediatek/clk-mt6779-img.c              |    2 +-
 drivers/clk/mediatek/clk-mt6779-ipe.c              |    2 +-
 drivers/clk/mediatek/clk-mt6779-mfg.c              |    2 +-
 drivers/clk/mediatek/clk-mt6779-mm.c               |    2 +-
 drivers/clk/mediatek/clk-mt6779-vdec.c             |    2 +-
 drivers/clk/mediatek/clk-mt6779-venc.c             |    2 +-
 drivers/clk/mediatek/clk-mt6779.c                  |    2 +-
 drivers/clk/mediatek/clk-mt6795-apmixedsys.c       |    2 +-
 drivers/clk/mediatek/clk-mt6795-infracfg.c         |    2 +-
 drivers/clk/mediatek/clk-mt6795-mfg.c              |    2 +-
 drivers/clk/mediatek/clk-mt6795-mm.c               |    2 +-
 drivers/clk/mediatek/clk-mt6795-pericfg.c          |    2 +-
 drivers/clk/mediatek/clk-mt6795-topckgen.c         |    2 +-
 drivers/clk/mediatek/clk-mt6795-vdecsys.c          |    2 +-
 drivers/clk/mediatek/clk-mt6795-vencsys.c          |    2 +-
 drivers/clk/mediatek/clk-mt6797-img.c              |    2 +-
 drivers/clk/mediatek/clk-mt6797-mm.c               |    2 +-
 drivers/clk/mediatek/clk-mt6797-vdec.c             |    2 +-
 drivers/clk/mediatek/clk-mt6797-venc.c             |    2 +-
 drivers/clk/mediatek/clk-mt7622-apmixedsys.c       |    2 +-
 drivers/clk/mediatek/clk-mt7622-aud.c              |    2 +-
 drivers/clk/mediatek/clk-mt7622-eth.c              |    2 +-
 drivers/clk/mediatek/clk-mt7622-hif.c              |    2 +-
 drivers/clk/mediatek/clk-mt7622-infracfg.c         |    2 +-
 drivers/clk/mediatek/clk-mt7622.c                  |    2 +-
 drivers/clk/mediatek/clk-mt7629-hif.c              |    2 +-
 drivers/clk/mediatek/clk-mt7981-eth.c              |    2 +-
 drivers/clk/mediatek/clk-mt7981-infracfg.c         |    2 +-
 drivers/clk/mediatek/clk-mt7981-topckgen.c         |    2 +-
 drivers/clk/mediatek/clk-mt7986-eth.c              |    2 +-
 drivers/clk/mediatek/clk-mt7986-infracfg.c         |    2 +-
 drivers/clk/mediatek/clk-mt7986-topckgen.c         |    2 +-
 drivers/clk/mediatek/clk-mt7988-eth.c              |    2 +-
 drivers/clk/mediatek/clk-mt7988-infracfg.c         |    2 +-
 drivers/clk/mediatek/clk-mt7988-topckgen.c         |    2 +-
 drivers/clk/mediatek/clk-mt7988-xfipll.c           |    2 +-
 drivers/clk/mediatek/clk-mt8135-apmixedsys.c       |    2 +-
 drivers/clk/mediatek/clk-mt8135.c                  |    2 +-
 drivers/clk/mediatek/clk-mt8167-aud.c              |    2 +-
 drivers/clk/mediatek/clk-mt8167-img.c              |    2 +-
 drivers/clk/mediatek/clk-mt8167-mfgcfg.c           |    2 +-
 drivers/clk/mediatek/clk-mt8167-mm.c               |    2 +-
 drivers/clk/mediatek/clk-mt8167-vdec.c             |    2 +-
 drivers/clk/mediatek/clk-mt8167.c                  |    2 +-
 drivers/clk/mediatek/clk-mt8173-apmixedsys.c       |    2 +-
 drivers/clk/mediatek/clk-mt8173-img.c              |    2 +-
 drivers/clk/mediatek/clk-mt8173-infracfg.c         |    2 +-
 drivers/clk/mediatek/clk-mt8173-mm.c               |    2 +-
 drivers/clk/mediatek/clk-mt8173-pericfg.c          |    2 +-
 drivers/clk/mediatek/clk-mt8173-topckgen.c         |    2 +-
 drivers/clk/mediatek/clk-mt8173-vdecsys.c          |    2 +-
 drivers/clk/mediatek/clk-mt8173-vencsys.c          |    2 +-
 drivers/clk/mediatek/clk-mt8183-audio.c            |    2 +-
 drivers/clk/mediatek/clk-mt8183-cam.c              |    2 +-
 drivers/clk/mediatek/clk-mt8183-img.c              |    2 +-
 drivers/clk/mediatek/clk-mt8183-ipu0.c             |    2 +-
 drivers/clk/mediatek/clk-mt8183-ipu1.c             |    2 +-
 drivers/clk/mediatek/clk-mt8183-ipu_adl.c          |    2 +-
 drivers/clk/mediatek/clk-mt8183-ipu_conn.c         |    2 +-
 drivers/clk/mediatek/clk-mt8183-mfgcfg.c           |    2 +-
 drivers/clk/mediatek/clk-mt8183-mm.c               |    2 +-
 drivers/clk/mediatek/clk-mt8183-vdec.c             |    2 +-
 drivers/clk/mediatek/clk-mt8183-venc.c             |    2 +-
 drivers/clk/mediatek/clk-mt8183.c                  |    2 +-
 drivers/clk/mediatek/clk-mt8186-apmixedsys.c       |    2 +-
 drivers/clk/mediatek/clk-mt8186-cam.c              |    2 +-
 drivers/clk/mediatek/clk-mt8186-img.c              |    2 +-
 drivers/clk/mediatek/clk-mt8186-imp_iic_wrap.c     |    2 +-
 drivers/clk/mediatek/clk-mt8186-infra_ao.c         |    2 +-
 drivers/clk/mediatek/clk-mt8186-ipe.c              |    2 +-
 drivers/clk/mediatek/clk-mt8186-mcu.c              |    2 +-
 drivers/clk/mediatek/clk-mt8186-mdp.c              |    2 +-
 drivers/clk/mediatek/clk-mt8186-mfg.c              |    2 +-
 drivers/clk/mediatek/clk-mt8186-mm.c               |    2 +-
 drivers/clk/mediatek/clk-mt8186-topckgen.c         |    2 +-
 drivers/clk/mediatek/clk-mt8186-vdec.c             |    2 +-
 drivers/clk/mediatek/clk-mt8186-venc.c             |    2 +-
 drivers/clk/mediatek/clk-mt8186-wpe.c              |    2 +-
 drivers/clk/mediatek/clk-mt8188-adsp_audio26m.c    |    2 +-
 drivers/clk/mediatek/clk-mt8188-apmixedsys.c       |    2 +-
 drivers/clk/mediatek/clk-mt8188-cam.c              |    2 +-
 drivers/clk/mediatek/clk-mt8188-ccu.c              |    2 +-
 drivers/clk/mediatek/clk-mt8188-img.c              |    2 +-
 drivers/clk/mediatek/clk-mt8188-imp_iic_wrap.c     |    2 +-
 drivers/clk/mediatek/clk-mt8188-infra_ao.c         |    2 +-
 drivers/clk/mediatek/clk-mt8188-ipe.c              |    2 +-
 drivers/clk/mediatek/clk-mt8188-mfg.c              |    2 +-
 drivers/clk/mediatek/clk-mt8188-peri_ao.c          |    2 +-
 drivers/clk/mediatek/clk-mt8188-topckgen.c         |    2 +-
 drivers/clk/mediatek/clk-mt8188-vdec.c             |    2 +-
 drivers/clk/mediatek/clk-mt8188-vdo0.c             |    2 +-
 drivers/clk/mediatek/clk-mt8188-vdo1.c             |    2 +-
 drivers/clk/mediatek/clk-mt8188-venc.c             |    2 +-
 drivers/clk/mediatek/clk-mt8188-vpp0.c             |    2 +-
 drivers/clk/mediatek/clk-mt8188-vpp1.c             |    2 +-
 drivers/clk/mediatek/clk-mt8188-wpe.c              |    2 +-
 drivers/clk/mediatek/clk-mt8192-apmixedsys.c       |    2 +-
 drivers/clk/mediatek/clk-mt8192-aud.c              |    2 +-
 drivers/clk/mediatek/clk-mt8192-cam.c              |    2 +-
 drivers/clk/mediatek/clk-mt8192-img.c              |    2 +-
 drivers/clk/mediatek/clk-mt8192-imp_iic_wrap.c     |    2 +-
 drivers/clk/mediatek/clk-mt8192-ipe.c              |    2 +-
 drivers/clk/mediatek/clk-mt8192-mdp.c              |    2 +-
 drivers/clk/mediatek/clk-mt8192-mfg.c              |    2 +-
 drivers/clk/mediatek/clk-mt8192-mm.c               |    2 +-
 drivers/clk/mediatek/clk-mt8192-msdc.c             |    2 +-
 drivers/clk/mediatek/clk-mt8192-scp_adsp.c         |    2 +-
 drivers/clk/mediatek/clk-mt8192-vdec.c             |    2 +-
 drivers/clk/mediatek/clk-mt8192-venc.c             |    2 +-
 drivers/clk/mediatek/clk-mt8192.c                  |    2 +-
 drivers/clk/mediatek/clk-mt8195-apmixedsys.c       |    2 +-
 drivers/clk/mediatek/clk-mt8195-apusys_pll.c       |    2 +-
 drivers/clk/mediatek/clk-mt8195-cam.c              |    2 +-
 drivers/clk/mediatek/clk-mt8195-ccu.c              |    2 +-
 drivers/clk/mediatek/clk-mt8195-img.c              |    2 +-
 drivers/clk/mediatek/clk-mt8195-imp_iic_wrap.c     |    2 +-
 drivers/clk/mediatek/clk-mt8195-infra_ao.c         |    2 +-
 drivers/clk/mediatek/clk-mt8195-ipe.c              |    2 +-
 drivers/clk/mediatek/clk-mt8195-mfg.c              |    2 +-
 drivers/clk/mediatek/clk-mt8195-peri_ao.c          |    2 +-
 drivers/clk/mediatek/clk-mt8195-scp_adsp.c         |    2 +-
 drivers/clk/mediatek/clk-mt8195-topckgen.c         |    2 +-
 drivers/clk/mediatek/clk-mt8195-vdec.c             |    2 +-
 drivers/clk/mediatek/clk-mt8195-vdo0.c             |    2 +-
 drivers/clk/mediatek/clk-mt8195-vdo1.c             |    2 +-
 drivers/clk/mediatek/clk-mt8195-venc.c             |    2 +-
 drivers/clk/mediatek/clk-mt8195-vpp0.c             |    2 +-
 drivers/clk/mediatek/clk-mt8195-vpp1.c             |    2 +-
 drivers/clk/mediatek/clk-mt8195-wpe.c              |    2 +-
 drivers/clk/mediatek/clk-mt8365-apu.c              |    2 +-
 drivers/clk/mediatek/clk-mt8365-cam.c              |    2 +-
 drivers/clk/mediatek/clk-mt8365-mfg.c              |    2 +-
 drivers/clk/mediatek/clk-mt8365-mm.c               |    2 +-
 drivers/clk/mediatek/clk-mt8365-vdec.c             |    2 +-
 drivers/clk/mediatek/clk-mt8365-venc.c             |    2 +-
 drivers/clk/mediatek/clk-mt8365.c                  |    2 +-
 drivers/clk/mediatek/clk-mt8516-aud.c              |    2 +-
 drivers/clk/mediatek/clk-mt8516.c                  |    2 +-
 drivers/clk/mediatek/reset.c                       |   61 +-
 drivers/clk/mediatek/reset.h                       |   10 -
 drivers/clk/meson/a1-peripherals.c                 |    3 +-
 drivers/clk/meson/a1-pll.c                         |    3 +-
 drivers/clk/meson/axg-aoclk.c                      |    1 +
 drivers/clk/meson/axg-audio.c                      |   39 +-
 drivers/clk/meson/axg-audio.h                      |    2 +
 drivers/clk/meson/axg.c                            |    1 +
 drivers/clk/meson/c3-peripherals.c                 |    3 +-
 drivers/clk/meson/c3-pll.c                         |    3 +-
 drivers/clk/meson/clk-cpu-dyndiv.c                 |    3 +-
 drivers/clk/meson/clk-dualdiv.c                    |    5 +-
 drivers/clk/meson/clk-mpll.c                       |    5 +-
 drivers/clk/meson/clk-phase.c                      |    8 +-
 drivers/clk/meson/clk-pll.c                        |    7 +-
 drivers/clk/meson/clk-regmap.c                     |   13 +-
 drivers/clk/meson/g12a-aoclk.c                     |    1 +
 drivers/clk/meson/g12a.c                           |    1 +
 drivers/clk/meson/gxbb-aoclk.c                     |    1 +
 drivers/clk/meson/gxbb.c                           |    1 +
 drivers/clk/meson/meson-aoclk.c                    |    3 +-
 drivers/clk/meson/meson-clkc-utils.c               |    3 +-
 drivers/clk/meson/meson-eeclk.c                    |    3 +-
 drivers/clk/meson/s4-peripherals.c                 |    3 +-
 drivers/clk/meson/s4-pll.c                         |    3 +-
 drivers/clk/meson/sclk-div.c                       |    3 +-
 drivers/clk/meson/vclk.c                           |    5 +-
 drivers/clk/meson/vid-pll-div.c                    |    3 +-
 drivers/clk/mmp/clk-audio.c                        |    2 +-
 drivers/clk/mmp/clk-mix.c                          |   10 +-
 drivers/clk/mvebu/armada-37xx-periph.c             |    2 +-
 drivers/clk/mvebu/armada-37xx-tbg.c                |    2 +-
 drivers/clk/mvebu/armada-37xx-xtal.c               |    2 +-
 drivers/clk/qcom/Kconfig                           |   51 +-
 drivers/clk/qcom/Makefile                          |    5 +-
 drivers/clk/qcom/a53-pll.c                         |    1 +
 drivers/clk/qcom/apcs-msm8916.c                    |    2 +-
 drivers/clk/qcom/apcs-sdx55.c                      |    2 +-
 drivers/clk/qcom/camcc-sm4450.c                    | 1688 +++++++++++++++
 drivers/clk/qcom/camcc-sm8150.c                    | 2159 ++++++++++++++++++++
 drivers/clk/qcom/clk-alpha-pll.c                   |   86 +-
 drivers/clk/qcom/clk-alpha-pll.h                   |    7 +
 drivers/clk/qcom/clk-cbf-8996.c                    |    2 +-
 drivers/clk/qcom/clk-rpmh.c                        |    2 +
 drivers/clk/qcom/dispcc-sm4450.c                   |  770 +++++++
 drivers/clk/qcom/dispcc-sm8250.c                   |   12 +-
 drivers/clk/qcom/dispcc-sm8550.c                   |  198 +-
 drivers/clk/qcom/dispcc-sm8650.c                   | 1796 ----------------
 drivers/clk/qcom/gcc-ipq5332.c                     |   36 +-
 drivers/clk/qcom/gcc-ipq6018.c                     |    2 +-
 drivers/clk/qcom/gcc-ipq806x.c                     |    4 +-
 drivers/clk/qcom/gcc-ipq8074.c                     |    4 +-
 drivers/clk/qcom/gcc-mdm9615.c                     |    4 +-
 drivers/clk/qcom/gcc-msm8660.c                     |    4 +-
 drivers/clk/qcom/gcc-msm8960.c                     |    8 +-
 drivers/clk/qcom/gcc-msm8994.c                     |   54 +-
 drivers/clk/qcom/gcc-msm8996.c                     |    2 +-
 drivers/clk/qcom/gcc-msm8998.c                     |   64 +-
 drivers/clk/qcom/gcc-sc8180x.c                     |  442 ++--
 drivers/clk/qcom/gcc-sm8250.c                      |    6 +-
 drivers/clk/qcom/gcc-sm8450.c                      |    4 +-
 drivers/clk/qcom/gpucc-sm4450.c                    |  805 ++++++++
 drivers/clk/qcom/lcc-ipq806x.c                     |    8 +-
 drivers/clk/qcom/lcc-msm8960.c                     |    8 +-
 drivers/clk/qcom/mmcc-apq8084.c                    |   50 +-
 drivers/clk/qcom/mmcc-msm8960.c                    |   30 +-
 drivers/clk/qcom/mmcc-msm8974.c                    |   52 +-
 drivers/clk/qcom/mmcc-msm8994.c                    |    8 +-
 drivers/clk/qcom/mmcc-msm8996.c                    |    8 +-
 drivers/clk/qcom/videocc-sm8550.c                  |    4 +-
 drivers/clk/renesas/Kconfig                        |    9 +
 drivers/clk/renesas/Makefile                       |    2 +
 drivers/clk/renesas/clk-mstp.c                     |    2 +-
 drivers/clk/renesas/r8a779a0-cpg-mssr.c            |   37 +-
 drivers/clk/renesas/r8a779f0-cpg-mssr.c            |   30 +-
 drivers/clk/renesas/r8a779g0-cpg-mssr.c            |   38 +-
 drivers/clk/renesas/r8a779h0-cpg-mssr.c            |   41 +-
 drivers/clk/renesas/r9a07g043-cpg.c                |   12 +
 drivers/clk/renesas/r9a08g045-cpg.c                |   20 +
 drivers/clk/renesas/r9a09g057-cpg.c                |  164 ++
 drivers/clk/renesas/rcar-gen4-cpg.c                |  208 +-
 drivers/clk/renesas/rcar-gen4-cpg.h                |   36 +-
 drivers/clk/renesas/rcar-usb2-clock-sel.c          |    2 +-
 drivers/clk/renesas/rzg2l-cpg.c                    |   71 +-
 drivers/clk/renesas/rzv2h-cpg.c                    |  853 ++++++++
 drivers/clk/renesas/rzv2h-cpg.h                    |  190 ++
 drivers/clk/rockchip/Kconfig                       |    7 +
 drivers/clk/rockchip/Makefile                      |    1 +
 drivers/clk/rockchip/clk-pll.c                     |    6 +-
 drivers/clk/rockchip/clk-px30.c                    |   10 +-
 drivers/clk/rockchip/clk-rk3036.c                  |    5 +-
 drivers/clk/rockchip/clk-rk3228.c                  |    7 +-
 drivers/clk/rockchip/clk-rk3288.c                  |    5 +-
 drivers/clk/rockchip/clk-rk3308.c                  |    5 +-
 drivers/clk/rockchip/clk-rk3328.c                  |    5 +-
 drivers/clk/rockchip/clk-rk3368.c                  |    5 +-
 drivers/clk/rockchip/clk-rk3399.c                  |   10 +-
 drivers/clk/rockchip/clk-rk3576.c                  | 1818 ++++++++++++++++
 drivers/clk/rockchip/clk-rk3588.c                  |   42 +-
 drivers/clk/rockchip/clk.c                         |    3 +-
 drivers/clk/rockchip/clk.h                         |   54 +
 drivers/clk/rockchip/rst-rk3576.c                  |  651 ++++++
 drivers/clk/samsung/Makefile                       |    1 +
 drivers/clk/samsung/clk-exynos-audss.c             |    2 +-
 drivers/clk/samsung/clk-exynos-clkout.c            |    2 +-
 drivers/clk/samsung/clk-exynos7885.c               |   93 +-
 drivers/clk/samsung/clk-exynos850.c                |    7 +-
 drivers/clk/samsung/clk-exynosautov9.c             |   83 +
 drivers/clk/samsung/clk-exynosautov920.c           | 1173 +++++++++++
 drivers/clk/samsung/clk-pll.c                      |   62 +-
 drivers/clk/samsung/clk-pll.h                      |    2 +
 drivers/clk/starfive/clk-starfive-jh7110-isp.c     |    2 +-
 drivers/clk/starfive/clk-starfive-jh7110-vout.c    |    4 +-
 drivers/clk/stm32/clk-stm32mp1.c                   |    2 +-
 drivers/clk/tegra/clk-tegra124-dfll-fcpu.c         |    2 +-
 drivers/clk/ti/adpll.c                             |    2 +-
 drivers/clk/ti/clk-dra7-atl.c                      |    1 +
 drivers/clk/versatile/clk-sp810.c                  |    2 +-
 drivers/clk/visconti/pll.c                         |    6 +-
 drivers/clk/x86/clk-fch.c                          |    2 +-
 drivers/clk/x86/clk-pmc-atom.c                     |    2 +-
 drivers/clk/xilinx/clk-xlnx-clock-wizard.c         |    2 +-
 drivers/clk/xilinx/xlnx_vcu.c                      |    2 +-
 drivers/of/.kunitconfig                            |    1 +
 drivers/of/Kconfig                                 |   10 +
 drivers/of/Makefile                                |    3 +
 drivers/of/kunit_overlay_test.dtso                 |    9 +
 drivers/of/of_kunit_helpers.c                      |   77 +
 drivers/of/overlay_test.c                          |  115 ++
 drivers/of/platform.c                              |    9 +-
 include/dt-bindings/clock/at91.h                   |    4 +
 include/dt-bindings/clock/axg-audio-clkc.h         |    7 +
 include/dt-bindings/clock/nxp,imx95-clock.h        |    3 +
 include/dt-bindings/clock/px30-cru.h               |    4 -
 include/dt-bindings/clock/qcom,gcc-msm8998.h       |    5 +
 include/dt-bindings/clock/qcom,gcc-sc8180x.h       |    5 +
 include/dt-bindings/clock/qcom,sm4450-camcc.h      |  106 +
 include/dt-bindings/clock/qcom,sm4450-dispcc.h     |   51 +
 include/dt-bindings/clock/qcom,sm4450-gpucc.h      |   62 +
 include/dt-bindings/clock/qcom,sm8150-camcc.h      |  135 ++
 include/dt-bindings/clock/qcom,sm8650-dispcc.h     |  103 +-
 include/dt-bindings/clock/renesas,r9a09g057-cpg.h  |   21 +
 include/dt-bindings/clock/rk3036-cru.h             |    2 -
 include/dt-bindings/clock/rk3228-cru.h             |    2 -
 include/dt-bindings/clock/rk3288-cru.h             |    2 -
 include/dt-bindings/clock/rk3308-cru.h             |    2 -
 include/dt-bindings/clock/rk3328-cru.h             |    2 -
 include/dt-bindings/clock/rk3368-cru.h             |    2 -
 include/dt-bindings/clock/rk3399-cru.h             |    4 -
 include/dt-bindings/clock/rockchip,rk3576-cru.h    |  592 ++++++
 include/dt-bindings/interconnect/qcom,ipq5332.h    |   46 +
 include/dt-bindings/reset/rockchip,rk3576-cru.h    |  564 +++++
 include/kunit/clk.h                                |   28 +
 include/kunit/of.h                                 |  115 ++
 include/kunit/platform_device.h                    |   20 +
 include/linux/clk-provider.h                       |   14 +
 include/linux/clk.h                                |   33 +
 lib/kunit/Makefile                                 |    4 +-
 lib/kunit/platform-test.c                          |  224 ++
 lib/kunit/platform.c                               |  302 +++
 437 files changed, 17725 insertions(+), 3552 deletions(-)
 create mode 100644 Documentation/dev-tools/kunit/api/clk.rst
 create mode 100644 Documentation/dev-tools/kunit/api/of.rst
 create mode 100644 Documentation/dev-tools/kunit/api/platformdevice.rst
 delete mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,bdpsys.txt
 delete mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,camsys.txt
 delete mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,imgsys.txt
 delete mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,ipesys.txt
 delete mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,ipu.txt
 delete mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,jpgdecsys.txt
 delete mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,mcucfg.txt
 delete mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,mfgcfg.txt
 delete mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,mipi0a.txt
 delete mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,vcodecsys.txt
 delete mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,vdecsys.txt
 delete mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,vencltsys.txt
 delete mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,vencsys.txt
 rename Documentation/devicetree/bindings/{arm/mediatek => clock}/mediatek,infracfg.yaml (96%)
 rename Documentation/devicetree/bindings/{arm/mediatek => clock}/mediatek,mt8186-clock.yaml (94%)
 rename Documentation/devicetree/bindings/{arm/mediatek => clock}/mediatek,mt8186-sys-clock.yaml (94%)
 rename Documentation/devicetree/bindings/{arm/mediatek => clock}/mediatek,mt8192-clock.yaml (98%)
 rename Documentation/devicetree/bindings/{arm/mediatek => clock}/mediatek,mt8192-sys-clock.yaml (94%)
 rename Documentation/devicetree/bindings/{arm/mediatek => clock}/mediatek,mt8195-clock.yaml (98%)
 rename Documentation/devicetree/bindings/{arm/mediatek => clock}/mediatek,mt8195-sys-clock.yaml (95%)
 rename Documentation/devicetree/bindings/{arm/mediatek => clock}/mediatek,pericfg.yaml (96%)
 create mode 100644 Documentation/devicetree/bindings/clock/mediatek,syscon.yaml
 delete mode 100644 Documentation/devicetree/bindings/clock/nxp,lpc3220-clk.txt
 create mode 100644 Documentation/devicetree/bindings/clock/nxp,lpc3220-clk.yaml
 delete mode 100644 Documentation/devicetree/bindings/clock/nxp,lpc3220-usb-clk.txt
 create mode 100644 Documentation/devicetree/bindings/clock/nxp,lpc3220-usb-clk.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,qcs404-turingcc.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,sm4450-camcc.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,sm4450-dispcc.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,sm8150-camcc.yaml
 delete mode 100644 Documentation/devicetree/bindings/clock/qcom,turingcc.txt
 create mode 100644 Documentation/devicetree/bindings/clock/renesas,rzv2h-cpg.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/rockchip,rk3576-cru.yaml
 create mode 100644 drivers/clk/at91/sam9x7.c
 create mode 100644 drivers/clk/clk-fixed-rate_test.c
 create mode 100644 drivers/clk/clk-fixed-rate_test.h
 create mode 100644 drivers/clk/clk_kunit_helpers.c
 create mode 100644 drivers/clk/clk_parent_data_test.h
 create mode 100644 drivers/clk/kunit_clk_fixed_rate_test.dtso
 create mode 100644 drivers/clk/kunit_clk_parent_data_test.dtso
 create mode 100644 drivers/clk/qcom/camcc-sm4450.c
 create mode 100644 drivers/clk/qcom/camcc-sm8150.c
 create mode 100644 drivers/clk/qcom/dispcc-sm4450.c
 delete mode 100644 drivers/clk/qcom/dispcc-sm8650.c
 create mode 100644 drivers/clk/qcom/gpucc-sm4450.c
 create mode 100644 drivers/clk/renesas/r9a09g057-cpg.c
 create mode 100644 drivers/clk/renesas/rzv2h-cpg.c
 create mode 100644 drivers/clk/renesas/rzv2h-cpg.h
 create mode 100644 drivers/clk/rockchip/clk-rk3576.c
 create mode 100644 drivers/clk/rockchip/rst-rk3576.c
 create mode 100644 drivers/clk/samsung/clk-exynosautov920.c
 create mode 100644 drivers/of/kunit_overlay_test.dtso
 create mode 100644 drivers/of/of_kunit_helpers.c
 create mode 100644 drivers/of/overlay_test.c
 create mode 100644 include/dt-bindings/clock/qcom,sm4450-camcc.h
 create mode 100644 include/dt-bindings/clock/qcom,sm4450-dispcc.h
 create mode 100644 include/dt-bindings/clock/qcom,sm4450-gpucc.h
 create mode 100644 include/dt-bindings/clock/qcom,sm8150-camcc.h
 mode change 100644 => 120000 include/dt-bindings/clock/qcom,sm8650-dispcc.h
 create mode 100644 include/dt-bindings/clock/renesas,r9a09g057-cpg.h
 create mode 100644 include/dt-bindings/clock/rockchip,rk3576-cru.h
 create mode 100644 include/dt-bindings/interconnect/qcom,ipq5332.h
 create mode 100644 include/dt-bindings/reset/rockchip,rk3576-cru.h
 create mode 100644 include/kunit/clk.h
 create mode 100644 include/kunit/of.h
 create mode 100644 include/kunit/platform_device.h
 create mode 100644 lib/kunit/platform-test.c
 create mode 100644 lib/kunit/platform.c

-- 
https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
https://git.kernel.org/pub/scm/linux/kernel/git/sboyd/spmi.git

