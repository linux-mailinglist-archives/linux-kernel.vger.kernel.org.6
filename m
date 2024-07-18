Return-Path: <linux-kernel+bounces-256714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D500393526A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 22:25:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 062D01F2209E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 20:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB7D6145B0B;
	Thu, 18 Jul 2024 20:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tv98B0pj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A6131442E8;
	Thu, 18 Jul 2024 20:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721334321; cv=none; b=OXzsia/D2z67QO4CpedhpDizAgCeHowH4upYQLUZ71BTtlzmYCtO/chxd4PgHHiyXp3/u5DoEr5+r6EnI9R9UT7WrRftYVC94VCrYxTojw4ZQAFpnhf8bjMqdPT9IEqAxI/RdM8amMFq0QPHzxhg6NymaoLv8+DjIbVUq2JKwpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721334321; c=relaxed/simple;
	bh=D98m4XV13CuIHlkgCeWcukkoKvK18wEtw/l3eMEOS60=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SZi5xHwHlsU6CCHfD9GBDSultDb36NjgIqaRKubziO9pHs0dEQ9Os92Z5u65f1uNBIQoZbQlHQingXIsn0mHkdFB6Abi5Ny/8F5twEzzDER/tIT2clcLblxRdiRk4FoxcP/LKexaxOUb9ng9irh7u1mlD7hV1o1S7UG3giMFsVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tv98B0pj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB40BC116B1;
	Thu, 18 Jul 2024 20:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721334321;
	bh=D98m4XV13CuIHlkgCeWcukkoKvK18wEtw/l3eMEOS60=;
	h=From:To:Cc:Subject:Date:From;
	b=Tv98B0pjAlr306pwt6KfdI6AIEEqo7U5KLrDp753gKslnL2QGzG0vKr2nVGWXZsLH
	 u98RneaaHZ635INiLiluDXdrQlPMTOveUuSzeCncQvwpD7/LGcnkq2vC02B9tRGdR6
	 sKXWdt32gGf2MdRO8BeLWVE5MGkn0sYDr1NCMFS/2YJ17RuNXSAZAHn3bnus51fPwu
	 JA3v4r7+jnYDxnfjeUvZsCnBTSCVW81s+S2PPMb/B51kcLiT8qN6UutootjyADb05B
	 l7frZPw9DHosjtspwzKuJv/1M0S/wolMnCm6hrxHi4L1OgzGvpJSlW0b6F1Rz9yUNI
	 h/0YjSF7hyaYA==
From: Stephen Boyd <sboyd@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Michael Turquette <mturquette@baylibre.com>,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] clk changes for the merge window
Date: Thu, 18 Jul 2024 13:25:18 -0700
Message-ID: <20240718202519.3609846-1-sboyd@kernel.org>
X-Mailer: git-send-email 2.45.2.1089.g2a221341d9-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following changes since commit d1f1570f3d6db5d35642092a671812e62bfba79d:

  dt-bindings: interconnect: Add Qualcomm IPQ9574 support (2024-07-06 13:13:14 -0500)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-for-linus

for you to fetch changes up to 589eb11498fbf7de7a1bc8ff1f4b7592687dfd46:

  Merge branches 'clk-qcom', 'clk-rockchip', 'clk-sophgo' and 'clk-thead' into clk-next (2024-07-16 11:24:25 -0700)

I see that you already fixed the qcom clk driver build failure in your tree.
That needs to be fixed up when pulling this tag. I thought we had that flag day
under control because it was one vendor in the clk tree but I was wrong. I'll
keep that in mind next time.

---8<---
diff --git a/drivers/clk/qcom/camcc-sm8650.c b/drivers/clk/qcom/camcc-sm8650.c
index 1b28e086e519..a37e52a67ed4 100644
--- a/drivers/clk/qcom/camcc-sm8650.c
+++ b/drivers/clk/qcom/camcc-sm8650.c
@@ -3570,7 +3570,7 @@ static int cam_cc_sm8650_probe(struct platform_device *pdev)
 	qcom_branch_set_clk_en(regmap, 0x132ec); /* CAM_CC_GDSC_CLK */
 	qcom_branch_set_clk_en(regmap, 0x13308); /* CAM_CC_SLEEP_CLK */
 
-	ret = qcom_cc_really_probe(pdev, &cam_cc_sm8650_desc, regmap);
+	ret = qcom_cc_really_probe(&pdev->dev, &cam_cc_sm8650_desc, regmap);
 
 	pm_runtime_put(&pdev->dev);

----------------------------------------------------------------
This a large collection of clk driver updates and a handful of new SoC
clk driver support. We have the usual Qualcomm clk drivers, along with
clk drivers for the Sophgo and T-Head vendors, all to support some new
SoCs.

Nothing in particular stands out to me in the updates. There's the
interconnect clk driver which exposes clks as interconnects, crossing
subsystems. There's a bunch of janitorial things that are improving
drivers in general like kmemdup_array() or fixing error paths. But
overall the updates look normal to fix the description data which is
usually the stuff that's wrong and/or untested.

I really wanted to land a bunch of KUnit clk code that I've been working
on whenever I get some free time but it turned into a pumpkin at the
last minute so I dropped those patches. I'll let it soak in linux-next
after the merge window closes. I have a suspicion that we're going to
need to totally rework the clk framework to fix structural issues like
locking, clk rate setting, and runtime PM usage. Having a bunch of unit
tests for that will help make sure that all keeps working.

Core:
 - Skip gate basic type KUnit tests on s390 due to lack of MMIO emulation

New Drivers:
 - AP sub-system clock controller in the T-Head TH1520
 - Sophgo Sophon sg2042 clk driver
 - Qualcomm SM7150 camera, display and video clk drivers
 - Qualcomm QCM2290 GPU clk driver
 - Qualcomm QCS8386/QCS8084 NSS clk driver
 - Qualcomm SM8650 camera and video drivers

Updates:
 - Add reset support to Airoha EN7581 clk driver
 - Add MODULE_DESCRIPTIONs to various clk drivers
 - Introduce helper logic to expose clock controllers as simple
   interconnect providers
 - Use the interconnect helper above on Qualcomm ipq9574
 - Add CLK_SET_RATE_PARENT to the remaining USB pipe clocks on Qualcomm
   X1Elite
 - Improve error handling in Qualcomm kpss-xcc driver
 - Mark Qualcomm SC8280XP LPASS clock controller regmap_config const
 - Export more clocks for Rockchip rk3128 peripherals
 - Convert Rockchip clk drivers to use kmemdup_array()
 - Drop CLK_NR_CLKS from Rockchip rk3128 and rk3188 binding headers
 - Make qcom_cc_really_probe() take a struct device to allow reuse in
   non-platform-drivers
 - Introduce prepare-only branch clock ops in the qcom clk driver to
   support clocks on buses that take locks
 - Describe parent/child relationship for Qualcomm SC7280 camera GDSCs
 - Support Qualcomm Huayra 2290 alpha PLL
 - Adjust the highest SDCC clock frequency on Qualcomm IPQ6018 to match
   HS200 support
 - Add missing PCIe PIPE clocks on Qualcomm IPQ9574
 - Fix various configurations and properties in the Qualcomm SA8775P,
   X1E80100 and SM7280 drivers
 - Park Qualcomm SM8350 GPU RCGs on XO while disabled
 - Remove unused CONFIG_QCOM_RPMCC Kconfig symbol
 - exynos-clkout: Remove usage of of_device_id table as .of_match_table,
   because the driver is instantiated as MFD cell, not as standalone platform
   driver.  Populated .of_match_table confused people few times to convert the
   code to device_get_match_data(), which broke the driver
 - Mark one Samsung UFS clock as critical, because having it off stops the
   system from shutdown
 - Use kmemdup_array() when applicable
 - Remove unused 'struct gates_data' from old sunxi driver library
 - Add GPADC clock and reset for Allwinner H616
 - Minor Amlogic S4 clock fixes
 - DT bindings Yaml conversion of the Amlogic AXG audio controller
 - Amlogic C3 clock controllers support
 - Amlogic clk flag added to skip init of already enabled PLLs and avoid relocking
 - Amlogic A1 DT bindings updates for system pll support
 - Add missing MODULE_DESCRIPTION where necessary
 - Remove obsolete clock DT binding header files
 - Add Battery Backup (VBATTB) and I2C clocks, resets, and power
   domains on Renesas RZ/G3S
 - Add audio clocks on Renesas R-Car V4M
 - Add video capture (ISPCS, CSI-2, VIN) clocks on Renesas R-Car V4M

----------------------------------------------------------------
Abel Vesa (2):
      clk: qcom: gcc-x1e80100: Fix halt_check for all pipe clocks
      clk: qcom: gcc-x1e80100: Set parent rate for USB3 sec and tert PHY pipe clks

Alex Bee (6):
      clk: rockchip: rk3128: Export PCLK_MIPIPHY
      clk: rockchip: rk3128: Add hclk_vio_h2p to critical clocks
      clk: rockchip: rk3128: Drop CLK_NR_CLKS usage
      dt-bindings: clock: rk3128: Drop CLK_NR_CLKS
      dt-bindings: clock: rk3128: Add HCLK_SFC
      clk: rockchip: rk3128: Add HCLK_SFC

Alexander Stein (1):
      dt-bindings: clock: meson: Convert axg-audio-clkc to YAML format

Alexandru Gagniuc (2):
      dt-bindings: clock: Add PCIe pipe related clocks for IPQ9574
      clk: qcom: gcc-ipq9574: Add PCIe pipe clocks

Alper Nebi Yasak (1):
      clk: mediatek: mt8173-infracfg: Handle unallocated infracfg when module

Andy Shevchenko (2):
      clk: samsung: Switch to use kmemdup_array()
      clk: rockchip: Switch to use kmemdup_array()

AngeloGioacchino Del Regno (2):
      clk: mediatek: Add a module description where missing
      dt-bindings: clock: mediatek: Document reset cells for MT8188 sys

Audra Mitchell (1):
      clk: disable clk gate tests for s390

Bjorn Andersson (3):
      Merge branch '20240606-topic-rb1_gpu-v4-1-4bc0c19da4af@linaro.org' into clk-for-6.11
      Merge branch '20240602114439.1611-1-quic_jkona@quicinc.com' into clk-for-6.11
      Merge branch '20240430064214.2030013-3-quic_varada@quicinc.com' into clk-for-6.11

Chen Ni (1):
      clk: qcom: kpss-xcc: Return of_clk_add_hw_provider to transfer the error

Chen Wang (4):
      dt-bindings: clock: sophgo: add pll clocks for SG2042
      dt-bindings: clock: sophgo: add RP gate clocks for SG2042
      dt-bindings: clock: sophgo: add clkgen for SG2042
      clk: sophgo: Add SG2042 clock driver

Chen-Yu Tsai (1):
      Merge branch 'sunxi/shared-clk-ids-for-6.11' into sunxi/clk-for-6.11

Chris Morgan (1):
      clk: sunxi-ng: h616: Add clock/reset for GPADC

Christian Marangi (1):
      dt-bindings: clock: mediatek: add syscon compatible for mt7622 pciesys

Christophe JAILLET (1):
      clk: qcom: Constify struct pll_vco

Chukun Pan (1):
      clk: qcom: gcc-ipq6018: update sdcc max clock frequency

Claudiu Beznea (2):
      clk: renesas: r9a08g045: Add clock, reset and power domain support for the VBATTB IP
      clk: renesas: r9a08g045: Add clock, reset and power domain support for I2C

Danila Tikhonov (8):
      clk: qcom: Fix SM_GCC_7150 dependencies
      clk: qcom: gcc-sm7150: constify clk_init_data structures
      dt-bindings: clock: qcom: Add SM7150 DISPCC clocks
      clk: qcom: Add Display Clock Controller driver for SM7150
      dt-bindings: clock: qcom: Add SM7150 CAMCC clocks
      clk: qcom: Add Camera Clock Controller driver for SM7150
      dt-bindings: clock: qcom: Add SM7150 VIDEOCC clocks
      clk: qcom: Add Video Clock Controller driver for SM7150

Dmitry Baryshkov (4):
      dt-bindings: clk: qcom,dispcc-sm8x50: describe additional DP clocks
      dt-bindings: clock: qcom,gcc-other: rename to qcom,mdm-mdm9607
      dt-bindings: clock: qcom,gcc: sort out power-domains support
      dt-bindings: clock: add schema for qcom,gcc-mdm9615

Dmitry Rokosov (3):
      clk: meson: add 'NOINIT_ENABLED' flag to eliminate init for enabled PLL
      dt-bindings: clock: meson: a1: pll: introduce new syspll bindings
      dt-bindings: clock: meson: a1: peripherals: support sys_pll input

Dr. David Alan Gilbert (1):
      clk: sunxi: Remove unused struct 'gates_data'

Drew Fustini (2):
      dt-bindings: clock: Document T-Head TH1520 AP_SUBSYS controller
      clk: thead: Add support for T-Head TH1520 AP_SUBSYS clocks

Elliot Berman (1):
      clk: qcom: Remove QCOM_RPMCC symbol

Frank Li (1):
      dt-bindings: clock: qoriq-clock: convert to yaml format

Gabriel Fernandez (2):
      clk: stm32mp2: use of STM32 access controller
      clk: stm32mp25: add security clocks

Geert Uytterhoeven (6):
      clk: renesas: r8a77970: Use common cpg_lock
      clk: renesas: cpg-lib: Use DEFINE_SPINLOCK() for global spinlock
      clk: renesas: rcar-gen2: Use DEFINE_SPINLOCK() for static spinlock
      clk: renesas: r8a779h0: Fix PLL2/PLL4 multipliers in comments
      clk: renesas: Drop "Renesas" from individual driver descriptions
      dt-bindings: clock: rcar-gen2: Remove obsolete header files

Heiko Stuebner (1):
      Merge branch 'v6.11-shared/clkids' into v6.11-clk/next

Javier Carrasco (4):
      clk: qcom: lpasscc-sc8280xp: Constify struct regmap_config
      clk: xilinx: Constify struct regmap_config
      clk: lpc32xx: Constify struct regmap_config
      clk: sunxi-ng r40: Constify struct regmap_config

Jeff Johnson (6):
      clk: qcom: add missing MODULE_DESCRIPTION() macros
      clk: sophgo: add missing MODULE_DESCRIPTION() macro
      clk: sprd: add missing MODULE_DESCRIPTION() macro
      clk: test: add missing MODULE_DESCRIPTION() macros
      clk: sunxi-ng: add missing MODULE_DESCRIPTION() macros
      clk: vexpress-osc: add missing MODULE_DESCRIPTION() macro

Jerome Brunet (4):
      Merge branch 'v6.11/bindings' into v6.11/drivers
      Merge branch 'v6.11/bindings' into v6.11/drivers
      Merge branch 'v6.11/bindings' into v6.11/drivers
      clk: meson: add missing MODULE_DESCRIPTION() macros

Johan Jonker (2):
      clk: rockchip: rk3188: Drop CLK_NR_CLKS usage
      dt-bindings: clock: rk3188-cru-common: remove CLK_NR_CLKS

Konrad Dybcio (2):
      clk: qcom: clk-alpha-pll: Add HUAYRA_2290 support
      clk: qcom: Add QCM2290 GPU clock controller driver

Krzysztof Kozlowski (17):
      clk: sifive: prci: fix module autoloading
      dt-bindings: clock: qcom,sm8450-videocc: reference qcom,gcc.yaml
      dt-bindings: clock: qcom,videocc: reference qcom,gcc.yaml
      dt-bindings: clock: qcom,dispcc-sc8280xp: reference qcom,gcc.yaml
      dt-bindings: clock: qcom,dispcc-sm6350: reference qcom,gcc.yaml
      dt-bindings: clock: qcom,dispcc-sm8x50: reference qcom,gcc.yaml
      dt-bindings: clock: qcom,gpucc-sdm660: reference qcom,gcc.yaml
      dt-bindings: clock: qcom,gpucc: reference qcom,gcc.yaml
      dt-bindings: clock: qcom,msm8998-gpucc: reference qcom,gcc.yaml
      dt-bindings: clock: qcom,qcm2290-dispcc: reference qcom,gcc.yaml
      dt-bindings: clock: qcom,sc7180-dispcc: reference qcom,gcc.yaml
      dt-bindings: clock: qcom,sc7280-dispcc: reference qcom,gcc.yaml
      dt-bindings: clock: qcom,sdm845-dispcc: reference qcom,gcc.yaml
      dt-bindings: clock: qcom,sm6115-dispcc: reference qcom,gcc.yaml
      dt-bindings: clock: qcom,sm8450-dispcc: reference qcom,gcc.yaml
      dt-bindings: clock: qcom,sm8550-dispcc: reference qcom,gcc.yaml
      dt-bindings: clock: qcom,sm8450-gpucc: reference qcom,gcc.yaml

Kuninori Morimoto (1):
      clk: renesas: r8a779h0: Add Audio clocks

Lad Prabhakar (1):
      dt-bindings: clock: renesas,rzg2l-cpg: Update description for #reset-cells

Li Qiang (1):
      clk/sophgo: Using BUG() instead of unreachable() in mmux_get_parent_id()

Lorenzo Bianconi (5):
      dt-bindings: clock: airoha: Add reset support to EN7581 clock binding
      clk: en7523: Add reset-controller support for EN7581 SoC
      clk: en7523: Remove pcie prepare/unpreare callbacks for EN7581 SoC
      clk: en7523: Remove PCIe reset open drain configuration for EN7581
      clk: en7523: fix rate divider for slic and spi clocks

Lukas Bulwahn (1):
      clk: qcom: select right config in CLK_QCM2290_GPUCC definition

Luo Jie (5):
      clk: qcom: branch: Add clk_branch2_prepare_ops
      dt-bindings: clock: add qca8386/qca8084 clock and reset definitions
      clk: qcom: common: commonize qcom_cc_really_probe
      clk: qcom: add clock controller driver for qca8386/qca8084
      clk: qcom: nsscc-qca8k: Fix the MDIO functions undefined issue

Marek Szyprowski (1):
      clk: samsung: exynos-clkout: Remove misleading of_match_table/MODULE_DEVICE_TABLE

Marek Vasut (1):
      dt-bindings: clock: r8a7779: Remove duplicate newline

Nathan Chancellor (1):
      clk: sophgo: Avoid -Wsometimes-uninitialized in sg2042_clk_pll_set_rate()

Niklas Söderlund (3):
      clk: renesas: r8a779h0: Add ISPCS clocks
      clk: renesas: r8a779h0: Add CSI-2 clocks
      clk: renesas: r8a779h0: Add VIN clocks

Peter Griffin (1):
      clk: samsung: gs101: mark gout_hsi2_ufs_embd_i_clk_unipro as critical

Rob Herring (Arm) (1):
      dt-bindings: clock: milbeaut: Drop providers and consumers from example

Satya Priya Kakitapalli (1):
      dt-bindings: clock: qcom: Add AHB clock for SM8150

Stanislav Jakubek (1):
      dt-bindings: clock: sprd,sc9860-clk: convert to YAML

Stephen Boyd (12):
      Merge tag 'renesas-clk-for-v6.11-tag2' of git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers into clk-renesas
      Merge tag 'clk-meson-v6.11-1' of https://github.com/BayLibre/clk-meson into clk-amlogic
      Merge tag 'sunxi-clk-for-6.11' of https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux into clk-allwinner
      Merge tag 'samsung-clk-6.11' of https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux into clk-samsung
      Merge tag 'qcom-clk-for-6.11' of https://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux into clk-qcom
      clk: qcom: Park shared RCGs upon registration
      Merge tag 'v6.11-rockchip-clk1' of git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip into clk-rockchip
      Merge tag 'riscv-sg2042-clk-for-v6.11' of https://github.com/sophgo/linux into clk-sophgo
      Merge tag 'qcom-clk-for-6.11-2' of https://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux into clk-qcom
      Merge branches 'clk-stm', 'clk-cleanup', 'clk-kunit' and 'clk-mediatek' into clk-next
      Merge branches 'clk-renesas', 'clk-amlogic', 'clk-allwinner' and 'clk-samsung' into clk-next
      Merge branches 'clk-qcom', 'clk-rockchip', 'clk-sophgo' and 'clk-thead' into clk-next

Taniya Das (10):
      clk: qcom: sc7280: Update the transition delay for GDSC
      clk: qcom: gcc-sc7280: Update force mem core bit for UFS ICE clock
      clk: qcom: camcc-sc7280: Add parent dependency to all camera GDSCs
      clk: qcom: gpucc-sm8350: Park RCG's clk source at XO during disable
      clk: qcom: gcc-sa8775p: Remove support for UFS hw ctl clocks
      clk: qcom: gcc-sa8775p: Update the GDSC wait_val fields and flags
      clk: qcom: gcc-sa8775p: Set FORCE_MEM_CORE_ON for gcc_ufs_phy_ice_core_clk
      clk: qcom: gpucc-sa8775p: Remove the CLK_IS_CRITICAL and ALWAYS_ON flags
      clk: qcom: gpucc-sa8775p: Park RCG's clk source at XO during disable
      clk: qcom: gpucc-sa8775p: Update wait_val fields for GPU GDSC's

Thorsten Blum (1):
      clk: mxs: Use clamp() in clk_ref_round_rate() and clk_ref_set_rate()

Varadarajan Narayanan (4):
      interconnect: icc-clk: Specify master/slave ids
      interconnect: icc-clk: Add devm_icc_clk_register
      clk: qcom: common: Add interconnect clocks support
      clk: qcom: ipq9574: Use icc-clk for enabling NoC related clocks

Xianwei Zhao (7):
      clk: meson: s4: fix fixed_pll_dco clock
      clk: meson: s4: fix pwm_j_div parent clock
      dt-bindings: clock: add Amlogic C3 PLL clock controller
      dt-bindings: clock: add Amlogic C3 SCMI clock controller support
      dt-bindings: clock: add Amlogic C3 peripherals clock controller
      clk: meson: c3: add support for the C3 SoC PLL clock
      clk: meson: c3: add c3 clock peripherals controller driver

 .../bindings/clock/airoha,en7523-scu.yaml          |   25 +-
 .../clock/amlogic,a1-peripherals-clkc.yaml         |    9 +-
 .../bindings/clock/amlogic,a1-pll-clkc.yaml        |    9 +-
 .../bindings/clock/amlogic,axg-audio-clkc.txt      |   59 -
 .../bindings/clock/amlogic,axg-audio-clkc.yaml     |  201 ++
 .../clock/amlogic,c3-peripherals-clkc.yaml         |  120 +
 .../bindings/clock/amlogic,c3-pll-clkc.yaml        |   59 +
 .../bindings/clock/fsl,qoriq-clock-legacy.yaml     |   84 +
 .../devicetree/bindings/clock/fsl,qoriq-clock.yaml |  207 ++
 .../bindings/clock/mediatek,mt7622-pciesys.yaml    |   10 +-
 .../bindings/clock/mediatek,mt8188-sys-clock.yaml  |    3 +
 .../devicetree/bindings/clock/milbeaut-clock.yaml  |   29 +-
 .../bindings/clock/qcom,dispcc-sc8280xp.yaml       |   20 +-
 .../bindings/clock/qcom,dispcc-sm6350.yaml         |   20 +-
 .../bindings/clock/qcom,dispcc-sm8x50.yaml         |   46 +-
 .../bindings/clock/qcom,gcc-apq8064.yaml           |    3 +-
 .../bindings/clock/qcom,gcc-apq8084.yaml           |    1 +
 .../bindings/clock/qcom,gcc-ipq4019.yaml           |    3 +-
 .../bindings/clock/qcom,gcc-ipq6018.yaml           |    3 +-
 .../bindings/clock/qcom,gcc-ipq8064.yaml           |    3 +-
 .../bindings/clock/qcom,gcc-ipq8074.yaml           |    1 +
 .../{qcom,gcc-other.yaml => qcom,gcc-mdm9607.yaml} |    4 +-
 .../bindings/clock/qcom,gcc-mdm9615.yaml           |   50 +
 .../bindings/clock/qcom,gcc-msm8660.yaml           |    3 +-
 .../bindings/clock/qcom,gcc-msm8909.yaml           |    1 +
 .../bindings/clock/qcom,gcc-msm8916.yaml           |    1 +
 .../bindings/clock/qcom,gcc-msm8953.yaml           |    1 +
 .../bindings/clock/qcom,gcc-msm8974.yaml           |    1 +
 .../bindings/clock/qcom,gcc-msm8976.yaml           |    1 +
 .../bindings/clock/qcom,gcc-msm8994.yaml           |    1 +
 .../bindings/clock/qcom,gcc-msm8996.yaml           |    1 +
 .../bindings/clock/qcom,gcc-msm8998.yaml           |    1 +
 .../bindings/clock/qcom,gcc-qcm2290.yaml           |    1 +
 .../devicetree/bindings/clock/qcom,gcc-qcs404.yaml |    1 +
 .../devicetree/bindings/clock/qcom,gcc-sc7180.yaml |    1 +
 .../devicetree/bindings/clock/qcom,gcc-sc7280.yaml |    1 +
 .../bindings/clock/qcom,gcc-sc8180x.yaml           |    1 +
 .../bindings/clock/qcom,gcc-sc8280xp.yaml          |    1 +
 .../devicetree/bindings/clock/qcom,gcc-sdm660.yaml |    1 +
 .../devicetree/bindings/clock/qcom,gcc-sdm845.yaml |    1 +
 .../devicetree/bindings/clock/qcom,gcc-sdx55.yaml  |    1 +
 .../devicetree/bindings/clock/qcom,gcc-sdx65.yaml  |    1 +
 .../devicetree/bindings/clock/qcom,gcc-sm6115.yaml |    1 +
 .../devicetree/bindings/clock/qcom,gcc-sm6125.yaml |    1 +
 .../devicetree/bindings/clock/qcom,gcc-sm6350.yaml |    1 +
 .../devicetree/bindings/clock/qcom,gcc-sm8150.yaml |    1 +
 .../devicetree/bindings/clock/qcom,gcc-sm8250.yaml |    1 +
 .../devicetree/bindings/clock/qcom,gcc-sm8350.yaml |    1 +
 .../devicetree/bindings/clock/qcom,gcc-sm8450.yaml |    1 +
 .../devicetree/bindings/clock/qcom,gcc.yaml        |    1 -
 .../bindings/clock/qcom,gpucc-sdm660.yaml          |   20 +-
 .../devicetree/bindings/clock/qcom,gpucc.yaml      |   20 +-
 .../bindings/clock/qcom,ipq5018-gcc.yaml           |    3 +-
 .../bindings/clock/qcom,ipq5332-gcc.yaml           |    3 +-
 .../bindings/clock/qcom,ipq9574-gcc.yaml           |    3 +-
 .../bindings/clock/qcom,msm8998-gpucc.yaml         |   20 +-
 .../bindings/clock/qcom,qca8k-nsscc.yaml           |   86 +
 .../bindings/clock/qcom,qcm2290-dispcc.yaml        |   20 +-
 .../bindings/clock/qcom,qcm2290-gpucc.yaml         |   77 +
 .../bindings/clock/qcom,qdu1000-gcc.yaml           |    1 +
 .../bindings/clock/qcom,sa8775p-gcc.yaml           |    1 +
 .../bindings/clock/qcom,sc7180-dispcc.yaml         |   20 +-
 .../bindings/clock/qcom,sc7280-dispcc.yaml         |   20 +-
 .../bindings/clock/qcom,sdm845-dispcc.yaml         |   20 +-
 .../devicetree/bindings/clock/qcom,sdx75-gcc.yaml  |    1 +
 .../devicetree/bindings/clock/qcom,sm4450-gcc.yaml |    1 +
 .../bindings/clock/qcom,sm6115-dispcc.yaml         |   20 +-
 .../devicetree/bindings/clock/qcom,sm6375-gcc.yaml |    1 +
 .../bindings/clock/qcom,sm7150-camcc.yaml          |   60 +
 .../bindings/clock/qcom,sm7150-dispcc.yaml         |   75 +
 .../devicetree/bindings/clock/qcom,sm7150-gcc.yaml |    1 +
 .../bindings/clock/qcom,sm7150-videocc.yaml        |   58 +
 .../bindings/clock/qcom,sm8450-camcc.yaml          |    7 +-
 .../bindings/clock/qcom,sm8450-dispcc.yaml         |   20 +-
 .../bindings/clock/qcom,sm8450-gpucc.yaml          |   20 +-
 .../bindings/clock/qcom,sm8450-videocc.yaml        |   26 +-
 .../bindings/clock/qcom,sm8550-dispcc.yaml         |   20 +-
 .../devicetree/bindings/clock/qcom,sm8550-gcc.yaml |    1 +
 .../devicetree/bindings/clock/qcom,sm8650-gcc.yaml |    1 +
 .../devicetree/bindings/clock/qcom,videocc.yaml    |   36 +-
 .../bindings/clock/qcom,x1e80100-gcc.yaml          |    1 +
 .../devicetree/bindings/clock/qoriq-clock.txt      |  212 --
 .../bindings/clock/renesas,rzg2l-cpg.yaml          |    2 +-
 .../bindings/clock/sophgo,sg2042-clkgen.yaml       |   61 +
 .../bindings/clock/sophgo,sg2042-pll.yaml          |   53 +
 .../bindings/clock/sophgo,sg2042-rpgate.yaml       |   49 +
 .../devicetree/bindings/clock/sprd,sc9860-clk.txt  |   63 -
 .../devicetree/bindings/clock/sprd,sc9860-clk.yaml |  159 +
 .../bindings/clock/thead,th1520-clk-ap.yaml        |   53 +
 MAINTAINERS                                        |    3 +
 drivers/clk/Kconfig                                |    2 +
 drivers/clk/Makefile                               |    1 +
 drivers/clk/clk-en7523.c                           |  254 +-
 drivers/clk/clk-fractional-divider_test.c          |    3 +-
 drivers/clk/clk-gate_test.c                        |    3 +-
 drivers/clk/clk_test.c                             |    3 +-
 drivers/clk/mediatek/clk-mt2701-aud.c              |    2 +
 drivers/clk/mediatek/clk-mt2701-bdp.c              |    2 +
 drivers/clk/mediatek/clk-mt2701-eth.c              |    2 +
 drivers/clk/mediatek/clk-mt2701-g3d.c              |    2 +
 drivers/clk/mediatek/clk-mt2701-hif.c              |    2 +
 drivers/clk/mediatek/clk-mt2701-img.c              |    2 +
 drivers/clk/mediatek/clk-mt2701-mm.c               |    2 +
 drivers/clk/mediatek/clk-mt2701-vdec.c             |    2 +
 drivers/clk/mediatek/clk-mt2701.c                  |    2 +
 drivers/clk/mediatek/clk-mt2712-apmixedsys.c       |    2 +
 drivers/clk/mediatek/clk-mt2712-bdp.c              |    2 +
 drivers/clk/mediatek/clk-mt2712-img.c              |    2 +
 drivers/clk/mediatek/clk-mt2712-jpgdec.c           |    2 +
 drivers/clk/mediatek/clk-mt2712-mfg.c              |    2 +
 drivers/clk/mediatek/clk-mt2712-mm.c               |    2 +
 drivers/clk/mediatek/clk-mt2712-vdec.c             |    2 +
 drivers/clk/mediatek/clk-mt2712-venc.c             |    2 +
 drivers/clk/mediatek/clk-mt2712.c                  |    2 +
 drivers/clk/mediatek/clk-mt6765-audio.c            |    2 +
 drivers/clk/mediatek/clk-mt6765-cam.c              |    2 +
 drivers/clk/mediatek/clk-mt6765-img.c              |    2 +
 drivers/clk/mediatek/clk-mt6765-mipi0a.c           |    2 +
 drivers/clk/mediatek/clk-mt6765-mm.c               |    2 +
 drivers/clk/mediatek/clk-mt6765-vcodec.c           |    2 +
 drivers/clk/mediatek/clk-mt6765.c                  |    2 +
 drivers/clk/mediatek/clk-mt6779-aud.c              |    3 +-
 drivers/clk/mediatek/clk-mt6779-cam.c              |    3 +-
 drivers/clk/mediatek/clk-mt6779-img.c              |    2 +
 drivers/clk/mediatek/clk-mt6779-ipe.c              |    2 +
 drivers/clk/mediatek/clk-mt6779-mfg.c              |    2 +
 drivers/clk/mediatek/clk-mt6779-mm.c               |    2 +
 drivers/clk/mediatek/clk-mt6779-vdec.c             |    2 +
 drivers/clk/mediatek/clk-mt6779-venc.c             |    2 +
 drivers/clk/mediatek/clk-mt6779.c                  |    2 +
 drivers/clk/mediatek/clk-mt6795-mm.c               |    2 +-
 drivers/clk/mediatek/clk-mt6797-img.c              |    2 +
 drivers/clk/mediatek/clk-mt6797-mm.c               |    2 +
 drivers/clk/mediatek/clk-mt6797-vdec.c             |    2 +
 drivers/clk/mediatek/clk-mt6797-venc.c             |    2 +
 drivers/clk/mediatek/clk-mt6797.c                  |    2 +
 drivers/clk/mediatek/clk-mt7622-aud.c              |    2 +
 drivers/clk/mediatek/clk-mt7622-eth.c              |    2 +
 drivers/clk/mediatek/clk-mt7622-hif.c              |    2 +
 drivers/clk/mediatek/clk-mt7629-eth.c              |    2 +
 drivers/clk/mediatek/clk-mt7629-hif.c              |    2 +
 drivers/clk/mediatek/clk-mt7629.c                  |    2 +
 drivers/clk/mediatek/clk-mt7981-apmixed.c          |    2 +
 drivers/clk/mediatek/clk-mt7981-eth.c              |    2 +
 drivers/clk/mediatek/clk-mt7981-infracfg.c         |    2 +
 drivers/clk/mediatek/clk-mt7981-topckgen.c         |    2 +
 drivers/clk/mediatek/clk-mt7986-apmixed.c          |    2 +
 drivers/clk/mediatek/clk-mt7986-topckgen.c         |    2 +
 drivers/clk/mediatek/clk-mt7988-apmixed.c          |    2 +
 drivers/clk/mediatek/clk-mt7988-infracfg.c         |    2 +
 drivers/clk/mediatek/clk-mt7988-topckgen.c         |    2 +
 drivers/clk/mediatek/clk-mt8167-apmixedsys.c       |    2 +
 drivers/clk/mediatek/clk-mt8167-aud.c              |    2 +
 drivers/clk/mediatek/clk-mt8167-img.c              |    2 +
 drivers/clk/mediatek/clk-mt8167-mfgcfg.c           |    2 +
 drivers/clk/mediatek/clk-mt8167-mm.c               |    2 +
 drivers/clk/mediatek/clk-mt8167-vdec.c             |    2 +
 drivers/clk/mediatek/clk-mt8167.c                  |    2 +
 drivers/clk/mediatek/clk-mt8173-infracfg.c         |   12 +-
 drivers/clk/mediatek/clk-mt8183-apmixedsys.c       |    2 +
 drivers/clk/mediatek/clk-mt8183-audio.c            |    2 +
 drivers/clk/mediatek/clk-mt8183-cam.c              |    2 +
 drivers/clk/mediatek/clk-mt8183-img.c              |    2 +
 drivers/clk/mediatek/clk-mt8183-ipu0.c             |    2 +
 drivers/clk/mediatek/clk-mt8183-ipu1.c             |    2 +
 drivers/clk/mediatek/clk-mt8183-ipu_adl.c          |    2 +
 drivers/clk/mediatek/clk-mt8183-ipu_conn.c         |    2 +
 drivers/clk/mediatek/clk-mt8183-mfgcfg.c           |    2 +
 drivers/clk/mediatek/clk-mt8183-mm.c               |    2 +
 drivers/clk/mediatek/clk-mt8183-vdec.c             |    2 +
 drivers/clk/mediatek/clk-mt8183-venc.c             |    2 +
 drivers/clk/mediatek/clk-mt8183.c                  |    2 +
 drivers/clk/mediatek/clk-mt8186-apmixedsys.c       |    2 +
 drivers/clk/mediatek/clk-mt8186-cam.c              |    2 +
 drivers/clk/mediatek/clk-mt8186-img.c              |    2 +
 drivers/clk/mediatek/clk-mt8186-imp_iic_wrap.c     |    2 +
 drivers/clk/mediatek/clk-mt8186-infra_ao.c         |    2 +
 drivers/clk/mediatek/clk-mt8186-ipe.c              |    2 +
 drivers/clk/mediatek/clk-mt8186-mdp.c              |    2 +
 drivers/clk/mediatek/clk-mt8186-mfg.c              |    2 +
 drivers/clk/mediatek/clk-mt8186-mm.c               |    2 +
 drivers/clk/mediatek/clk-mt8186-topckgen.c         |    2 +
 drivers/clk/mediatek/clk-mt8186-vdec.c             |    2 +
 drivers/clk/mediatek/clk-mt8186-venc.c             |    2 +
 drivers/clk/mediatek/clk-mt8186-wpe.c              |    2 +
 drivers/clk/mediatek/clk-mt8188-adsp_audio26m.c    |    2 +
 drivers/clk/mediatek/clk-mt8188-apmixedsys.c       |    2 +
 drivers/clk/mediatek/clk-mt8188-cam.c              |    3 +-
 drivers/clk/mediatek/clk-mt8188-ccu.c              |    3 +-
 drivers/clk/mediatek/clk-mt8188-img.c              |    3 +-
 drivers/clk/mediatek/clk-mt8188-imp_iic_wrap.c     |    2 +
 drivers/clk/mediatek/clk-mt8188-infra_ao.c         |    2 +
 drivers/clk/mediatek/clk-mt8188-ipe.c              |    2 +
 drivers/clk/mediatek/clk-mt8188-mfg.c              |    2 +
 drivers/clk/mediatek/clk-mt8188-peri_ao.c          |    2 +
 drivers/clk/mediatek/clk-mt8188-topckgen.c         |    2 +
 drivers/clk/mediatek/clk-mt8188-vdec.c             |    2 +
 drivers/clk/mediatek/clk-mt8188-vdo0.c             |    2 +
 drivers/clk/mediatek/clk-mt8188-vdo1.c             |    2 +
 drivers/clk/mediatek/clk-mt8188-venc.c             |    3 +-
 drivers/clk/mediatek/clk-mt8188-vpp0.c             |    2 +
 drivers/clk/mediatek/clk-mt8188-vpp1.c             |    2 +
 drivers/clk/mediatek/clk-mt8188-wpe.c              |    3 +-
 drivers/clk/mediatek/clk-mt8192-aud.c              |    2 +
 drivers/clk/mediatek/clk-mt8192-cam.c              |    2 +
 drivers/clk/mediatek/clk-mt8192-img.c              |    2 +
 drivers/clk/mediatek/clk-mt8192-imp_iic_wrap.c     |    2 +
 drivers/clk/mediatek/clk-mt8192-ipe.c              |    2 +
 drivers/clk/mediatek/clk-mt8192-mdp.c              |    2 +
 drivers/clk/mediatek/clk-mt8192-mfg.c              |    2 +
 drivers/clk/mediatek/clk-mt8192-mm.c               |    2 +
 drivers/clk/mediatek/clk-mt8192-msdc.c             |    2 +
 drivers/clk/mediatek/clk-mt8192-scp_adsp.c         |    2 +
 drivers/clk/mediatek/clk-mt8192-vdec.c             |    2 +
 drivers/clk/mediatek/clk-mt8192-venc.c             |    2 +
 drivers/clk/mediatek/clk-mt8192.c                  |    2 +
 drivers/clk/mediatek/clk-mt8195-apmixedsys.c       |    2 +
 drivers/clk/mediatek/clk-mt8195-apusys_pll.c       |    2 +
 drivers/clk/mediatek/clk-mt8195-cam.c              |    2 +
 drivers/clk/mediatek/clk-mt8195-ccu.c              |    2 +
 drivers/clk/mediatek/clk-mt8195-img.c              |    2 +
 drivers/clk/mediatek/clk-mt8195-imp_iic_wrap.c     |    2 +
 drivers/clk/mediatek/clk-mt8195-infra_ao.c         |    2 +
 drivers/clk/mediatek/clk-mt8195-ipe.c              |    2 +
 drivers/clk/mediatek/clk-mt8195-mfg.c              |    2 +
 drivers/clk/mediatek/clk-mt8195-peri_ao.c          |    2 +
 drivers/clk/mediatek/clk-mt8195-scp_adsp.c         |    2 +
 drivers/clk/mediatek/clk-mt8195-topckgen.c         |    2 +
 drivers/clk/mediatek/clk-mt8195-vdec.c             |    2 +
 drivers/clk/mediatek/clk-mt8195-vdo0.c             |    2 +
 drivers/clk/mediatek/clk-mt8195-vdo1.c             |    2 +
 drivers/clk/mediatek/clk-mt8195-venc.c             |    2 +
 drivers/clk/mediatek/clk-mt8195-vpp0.c             |    2 +
 drivers/clk/mediatek/clk-mt8195-vpp1.c             |    2 +
 drivers/clk/mediatek/clk-mt8195-wpe.c              |    2 +
 drivers/clk/mediatek/clk-mt8365-apmixedsys.c       |    2 +
 drivers/clk/mediatek/clk-mt8365-apu.c              |    2 +
 drivers/clk/mediatek/clk-mt8365-cam.c              |    2 +
 drivers/clk/mediatek/clk-mt8365-mfg.c              |    2 +
 drivers/clk/mediatek/clk-mt8365-mm.c               |    2 +
 drivers/clk/mediatek/clk-mt8365-vdec.c             |    2 +
 drivers/clk/mediatek/clk-mt8365-venc.c             |    2 +
 drivers/clk/mediatek/clk-mt8365.c                  |    2 +
 drivers/clk/meson/Kconfig                          |   27 +
 drivers/clk/meson/Makefile                         |    2 +
 drivers/clk/meson/a1-peripherals.c                 |    3 +-
 drivers/clk/meson/a1-pll.c                         |    3 +-
 drivers/clk/meson/axg-aoclk.c                      |    3 +-
 drivers/clk/meson/axg.c                            |    3 +-
 drivers/clk/meson/c3-peripherals.c                 | 2366 +++++++++++++
 drivers/clk/meson/c3-pll.c                         |  747 ++++
 drivers/clk/meson/clk-pll.c                        |   46 +-
 drivers/clk/meson/clk-pll.h                        |    1 +
 drivers/clk/meson/g12a-aoclk.c                     |    3 +-
 drivers/clk/meson/g12a.c                           |    3 +-
 drivers/clk/meson/gxbb-aoclk.c                     |    2 +
 drivers/clk/meson/gxbb.c                           |    3 +-
 drivers/clk/meson/meson-aoclk.c                    |    2 +
 drivers/clk/meson/meson-clkc-utils.c               |    1 +
 drivers/clk/meson/meson-eeclk.c                    |    2 +
 drivers/clk/meson/s4-peripherals.c                 |    5 +-
 drivers/clk/meson/s4-pll.c                         |    8 +-
 drivers/clk/mxs/clk-ref.c                          |   14 +-
 drivers/clk/nxp/clk-lpc32xx.c                      |    2 +-
 drivers/clk/qcom/Kconfig                           |   62 +-
 drivers/clk/qcom/Makefile                          |    6 +
 drivers/clk/qcom/apss-ipq6018.c                    |    2 +-
 drivers/clk/qcom/camcc-sc7180.c                    |    2 +-
 drivers/clk/qcom/camcc-sc7280.c                    |   26 +-
 drivers/clk/qcom/camcc-sc8280xp.c                  |    6 +-
 drivers/clk/qcom/camcc-sdm845.c                    |    2 +-
 drivers/clk/qcom/camcc-sm6350.c                    |    4 +-
 drivers/clk/qcom/camcc-sm7150.c                    | 2061 +++++++++++
 drivers/clk/qcom/camcc-sm8250.c                    |    6 +-
 drivers/clk/qcom/camcc-sm8450.c                    |    2 +-
 drivers/clk/qcom/camcc-sm8550.c                    |    2 +-
 drivers/clk/qcom/camcc-sm8650.c                    | 3591 ++++++++++++++++++++
 drivers/clk/qcom/camcc-x1e80100.c                  |    2 +-
 drivers/clk/qcom/clk-alpha-pll.c                   |   47 +
 drivers/clk/qcom/clk-alpha-pll.h                   |    3 +
 drivers/clk/qcom/clk-branch.c                      |    7 +
 drivers/clk/qcom/clk-branch.h                      |    1 +
 drivers/clk/qcom/clk-cbf-8996.c                    |    7 +-
 drivers/clk/qcom/clk-rcg2.c                        |   32 +
 drivers/clk/qcom/common.c                          |   43 +-
 drivers/clk/qcom/common.h                          |   11 +-
 drivers/clk/qcom/dispcc-qcm2290.c                  |    2 +-
 drivers/clk/qcom/dispcc-sc7180.c                   |    2 +-
 drivers/clk/qcom/dispcc-sc7280.c                   |    2 +-
 drivers/clk/qcom/dispcc-sc8280xp.c                 |    2 +-
 drivers/clk/qcom/dispcc-sdm845.c                   |    2 +-
 drivers/clk/qcom/dispcc-sm6115.c                   |    2 +-
 drivers/clk/qcom/dispcc-sm6125.c                   |    4 +-
 drivers/clk/qcom/dispcc-sm6350.c                   |    4 +-
 drivers/clk/qcom/dispcc-sm6375.c                   |    4 +-
 drivers/clk/qcom/dispcc-sm7150.c                   | 1006 ++++++
 drivers/clk/qcom/dispcc-sm8250.c                   |    2 +-
 drivers/clk/qcom/dispcc-sm8450.c                   |    4 +-
 drivers/clk/qcom/dispcc-sm8550.c                   |    4 +-
 drivers/clk/qcom/dispcc-sm8650.c                   |    4 +-
 drivers/clk/qcom/dispcc-x1e80100.c                 |    2 +-
 drivers/clk/qcom/ecpricc-qdu1000.c                 |    2 +-
 drivers/clk/qcom/gcc-ipq5018.c                     |    2 +-
 drivers/clk/qcom/gcc-ipq6018.c                     |    4 +-
 drivers/clk/qcom/gcc-ipq8074.c                     |    2 +-
 drivers/clk/qcom/gcc-ipq9574.c                     |  109 +
 drivers/clk/qcom/gcc-mdm9607.c                     |    2 +-
 drivers/clk/qcom/gcc-mdm9615.c                     |    2 +-
 drivers/clk/qcom/gcc-msm8917.c                     |    2 +-
 drivers/clk/qcom/gcc-msm8939.c                     |    2 +-
 drivers/clk/qcom/gcc-msm8953.c                     |    2 +-
 drivers/clk/qcom/gcc-msm8976.c                     |    3 +-
 drivers/clk/qcom/gcc-msm8996.c                     |    2 +-
 drivers/clk/qcom/gcc-msm8998.c                     |    4 +-
 drivers/clk/qcom/gcc-qcm2290.c                     |    2 +-
 drivers/clk/qcom/gcc-qcs404.c                      |    2 +-
 drivers/clk/qcom/gcc-qdu1000.c                     |    2 +-
 drivers/clk/qcom/gcc-sa8775p.c                     |  156 +-
 drivers/clk/qcom/gcc-sc7180.c                      |    2 +-
 drivers/clk/qcom/gcc-sc7280.c                      |   15 +-
 drivers/clk/qcom/gcc-sc8180x.c                     |    4 +-
 drivers/clk/qcom/gcc-sc8280xp.c                    |    2 +-
 drivers/clk/qcom/gcc-sdm660.c                      |    2 +-
 drivers/clk/qcom/gcc-sdm845.c                      |    2 +-
 drivers/clk/qcom/gcc-sdx55.c                       |    2 +-
 drivers/clk/qcom/gcc-sdx65.c                       |    2 +-
 drivers/clk/qcom/gcc-sdx75.c                       |    2 +-
 drivers/clk/qcom/gcc-sm4450.c                      |    2 +-
 drivers/clk/qcom/gcc-sm6115.c                      |    8 +-
 drivers/clk/qcom/gcc-sm6125.c                      |    2 +-
 drivers/clk/qcom/gcc-sm6350.c                      |    2 +-
 drivers/clk/qcom/gcc-sm6375.c                      |    6 +-
 drivers/clk/qcom/gcc-sm7150.c                      |  394 +--
 drivers/clk/qcom/gcc-sm8150.c                      |    2 +-
 drivers/clk/qcom/gcc-sm8250.c                      |    2 +-
 drivers/clk/qcom/gcc-sm8350.c                      |    2 +-
 drivers/clk/qcom/gcc-sm8450.c                      |    2 +-
 drivers/clk/qcom/gcc-sm8550.c                      |    2 +-
 drivers/clk/qcom/gcc-sm8650.c                      |    2 +-
 drivers/clk/qcom/gcc-x1e80100.c                    |   48 +-
 drivers/clk/qcom/gpucc-msm8998.c                   |    4 +-
 drivers/clk/qcom/gpucc-qcm2290.c                   |  423 +++
 drivers/clk/qcom/gpucc-sa8775p.c                   |   43 +-
 drivers/clk/qcom/gpucc-sc7180.c                    |    2 +-
 drivers/clk/qcom/gpucc-sc7280.c                    |    9 +-
 drivers/clk/qcom/gpucc-sc8280xp.c                  |    2 +-
 drivers/clk/qcom/gpucc-sdm660.c                    |    4 +-
 drivers/clk/qcom/gpucc-sdm845.c                    |    2 +-
 drivers/clk/qcom/gpucc-sm6115.c                    |    6 +-
 drivers/clk/qcom/gpucc-sm6125.c                    |    4 +-
 drivers/clk/qcom/gpucc-sm6350.c                    |    2 +-
 drivers/clk/qcom/gpucc-sm6375.c                    |    4 +-
 drivers/clk/qcom/gpucc-sm8150.c                    |    2 +-
 drivers/clk/qcom/gpucc-sm8250.c                    |    4 +-
 drivers/clk/qcom/gpucc-sm8350.c                    |    9 +-
 drivers/clk/qcom/gpucc-sm8450.c                    |    4 +-
 drivers/clk/qcom/gpucc-sm8550.c                    |    2 +-
 drivers/clk/qcom/gpucc-sm8650.c                    |    4 +-
 drivers/clk/qcom/gpucc-x1e80100.c                  |    2 +-
 drivers/clk/qcom/kpss-xcc.c                        |    4 +-
 drivers/clk/qcom/lcc-ipq806x.c                     |    2 +-
 drivers/clk/qcom/lcc-msm8960.c                     |    2 +-
 drivers/clk/qcom/lpass-gfm-sm8250.c                |    1 +
 drivers/clk/qcom/lpassaudiocc-sc7280.c             |    4 +-
 drivers/clk/qcom/lpasscc-sc8280xp.c                |    4 +-
 drivers/clk/qcom/lpasscorecc-sc7180.c              |    4 +-
 drivers/clk/qcom/lpasscorecc-sc7280.c              |    2 +-
 drivers/clk/qcom/mmcc-msm8960.c                    |    2 +-
 drivers/clk/qcom/mmcc-msm8974.c                    |    2 +-
 drivers/clk/qcom/mmcc-msm8994.c                    |    6 +-
 drivers/clk/qcom/mmcc-msm8996.c                    |    8 +-
 drivers/clk/qcom/mmcc-msm8998.c                    |    2 +-
 drivers/clk/qcom/mmcc-sdm660.c                     |    6 +-
 drivers/clk/qcom/nsscc-qca8k.c                     | 2221 ++++++++++++
 drivers/clk/qcom/tcsrcc-sm8550.c                   |    2 +-
 drivers/clk/qcom/videocc-sc7180.c                  |    2 +-
 drivers/clk/qcom/videocc-sc7280.c                  |    9 +-
 drivers/clk/qcom/videocc-sdm845.c                  |    3 +-
 drivers/clk/qcom/videocc-sm7150.c                  |  357 ++
 drivers/clk/qcom/videocc-sm8150.c                  |    4 +-
 drivers/clk/qcom/videocc-sm8250.c                  |    4 +-
 drivers/clk/qcom/videocc-sm8350.c                  |    2 +-
 drivers/clk/qcom/videocc-sm8450.c                  |    2 +-
 drivers/clk/qcom/videocc-sm8550.c                  |  158 +-
 drivers/clk/renesas/Kconfig                        |    4 +-
 drivers/clk/renesas/r8a77970-cpg-mssr.c            |    5 +-
 drivers/clk/renesas/r8a779h0-cpg-mssr.c            |   28 +-
 drivers/clk/renesas/r9a08g045-cpg.c                |   26 +
 drivers/clk/renesas/rcar-cpg-lib.c                 |    2 +-
 drivers/clk/renesas/rcar-gen2-cpg.c                |    4 +-
 drivers/clk/renesas/rcar-gen3-cpg.c                |    2 -
 drivers/clk/renesas/rcar-gen4-cpg.c                |    2 -
 drivers/clk/rockchip/clk-cpu.c                     |    5 +-
 drivers/clk/rockchip/clk-pll.c                     |    8 +-
 drivers/clk/rockchip/clk-rk3128.c                  |   24 +-
 drivers/clk/rockchip/clk-rk3188.c                  |   18 +-
 drivers/clk/samsung/clk-cpu.c                      |    4 +-
 drivers/clk/samsung/clk-exynos-clkout.c            |    7 +-
 drivers/clk/samsung/clk-gs101.c                    |    2 +-
 drivers/clk/samsung/clk-pll.c                      |    8 +-
 drivers/clk/sifive/sifive-prci.c                   |    1 +
 drivers/clk/sophgo/Kconfig                         |   28 +
 drivers/clk/sophgo/Makefile                        |    4 +
 drivers/clk/sophgo/clk-cv1800.c                    |    1 +
 drivers/clk/sophgo/clk-cv18xx-ip.c                 |    2 +-
 drivers/clk/sophgo/clk-sg2042-clkgen.c             | 1152 +++++++
 drivers/clk/sophgo/clk-sg2042-pll.c                |  567 ++++
 drivers/clk/sophgo/clk-sg2042-rpgate.c             |  291 ++
 drivers/clk/sophgo/clk-sg2042.h                    |   18 +
 drivers/clk/sprd/common.c                          |    1 +
 drivers/clk/stm32/clk-stm32-core.c                 |    2 +-
 drivers/clk/stm32/clk-stm32-core.h                 |    2 +-
 drivers/clk/stm32/clk-stm32mp13.c                  |    2 +-
 drivers/clk/stm32/clk-stm32mp25.c                  |  516 +--
 drivers/clk/sunxi-ng/ccu-sun20i-d1-r.c             |    1 +
 drivers/clk/sunxi-ng/ccu-sun20i-d1.c               |    1 +
 drivers/clk/sunxi-ng/ccu-sun4i-a10.c               |    1 +
 drivers/clk/sunxi-ng/ccu-sun50i-a100-r.c           |    1 +
 drivers/clk/sunxi-ng/ccu-sun50i-a100.c             |    1 +
 drivers/clk/sunxi-ng/ccu-sun50i-a64.c              |    1 +
 drivers/clk/sunxi-ng/ccu-sun50i-h6-r.c             |    1 +
 drivers/clk/sunxi-ng/ccu-sun50i-h6.c               |    1 +
 drivers/clk/sunxi-ng/ccu-sun50i-h616.c             |    6 +
 drivers/clk/sunxi-ng/ccu-sun50i-h616.h             |    2 +-
 drivers/clk/sunxi-ng/ccu-sun6i-a31.c               |    1 +
 drivers/clk/sunxi-ng/ccu-sun6i-rtc.c               |    1 +
 drivers/clk/sunxi-ng/ccu-sun8i-a23.c               |    1 +
 drivers/clk/sunxi-ng/ccu-sun8i-a33.c               |    1 +
 drivers/clk/sunxi-ng/ccu-sun8i-a83t.c              |    1 +
 drivers/clk/sunxi-ng/ccu-sun8i-de2.c               |    1 +
 drivers/clk/sunxi-ng/ccu-sun8i-h3.c                |    1 +
 drivers/clk/sunxi-ng/ccu-sun8i-r.c                 |    1 +
 drivers/clk/sunxi-ng/ccu-sun8i-r40.c               |    3 +-
 drivers/clk/sunxi-ng/ccu-sun8i-v3s.c               |    1 +
 drivers/clk/sunxi-ng/ccu-sun9i-a80-de.c            |    1 +
 drivers/clk/sunxi-ng/ccu-sun9i-a80-usb.c           |    1 +
 drivers/clk/sunxi-ng/ccu-sun9i-a80.c               |    1 +
 drivers/clk/sunxi-ng/ccu-suniv-f1c100s.c           |    1 +
 drivers/clk/sunxi-ng/ccu_common.c                  |    1 +
 drivers/clk/sunxi/clk-sunxi.c                      |   11 -
 drivers/clk/thead/Kconfig                          |   12 +
 drivers/clk/thead/Makefile                         |    2 +
 drivers/clk/thead/clk-th1520-ap.c                  | 1089 ++++++
 drivers/clk/versatile/clk-vexpress-osc.c           |    1 +
 drivers/clk/xilinx/xlnx_vcu.c                      |    2 +-
 drivers/interconnect/icc-clk.c                     |   24 +-
 .../clock/amlogic,a1-peripherals-clkc.h            |    1 +
 include/dt-bindings/clock/amlogic,a1-pll-clkc.h    |    1 +
 .../clock/amlogic,c3-peripherals-clkc.h            |  212 ++
 include/dt-bindings/clock/amlogic,c3-pll-clkc.h    |   40 +
 include/dt-bindings/clock/amlogic,c3-scmi-clkc.h   |   27 +
 include/dt-bindings/clock/qcom,ipq9574-gcc.h       |    4 +
 include/dt-bindings/clock/qcom,qca8k-nsscc.h       |  101 +
 include/dt-bindings/clock/qcom,qcm2290-gpucc.h     |   32 +
 include/dt-bindings/clock/qcom,sm7150-camcc.h      |  113 +
 include/dt-bindings/clock/qcom,sm7150-dispcc.h     |   59 +
 include/dt-bindings/clock/qcom,sm7150-videocc.h    |   28 +
 include/dt-bindings/clock/qcom,sm8650-camcc.h      |  195 ++
 include/dt-bindings/clock/qcom,sm8650-videocc.h    |   23 +
 include/dt-bindings/clock/r8a7779-clock.h          |    1 -
 include/dt-bindings/clock/r8a7790-clock.h          |  158 -
 include/dt-bindings/clock/r8a7791-clock.h          |  161 -
 include/dt-bindings/clock/r8a7792-clock.h          |   98 -
 include/dt-bindings/clock/r8a7793-clock.h          |  159 -
 include/dt-bindings/clock/r8a7794-clock.h          |  137 -
 include/dt-bindings/clock/rk3128-cru.h             |    4 +-
 include/dt-bindings/clock/rk3188-cru-common.h      |    2 -
 include/dt-bindings/clock/sophgo,sg2042-clkgen.h   |  111 +
 include/dt-bindings/clock/sophgo,sg2042-pll.h      |   14 +
 include/dt-bindings/clock/sophgo,sg2042-rpgate.h   |   58 +
 include/dt-bindings/clock/sun50i-h616-ccu.h        |    1 +
 include/dt-bindings/clock/thead,th1520-clk-ap.h    |   96 +
 include/dt-bindings/reset/airoha,en7581-reset.h    |   66 +
 include/dt-bindings/reset/qcom,qca8k-nsscc.h       |   76 +
 include/dt-bindings/reset/sun50i-h616-ccu.h        |    1 +
 include/linux/interconnect-clk.h                   |    4 +
 476 files changed, 20914 insertions(+), 2241 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/clock/amlogic,axg-audio-clkc.txt
 create mode 100644 Documentation/devicetree/bindings/clock/amlogic,axg-audio-clkc.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/amlogic,c3-peripherals-clkc.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/amlogic,c3-pll-clkc.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/fsl,qoriq-clock-legacy.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/fsl,qoriq-clock.yaml
 rename Documentation/devicetree/bindings/clock/{qcom,gcc-other.yaml => qcom,gcc-mdm9607.yaml} (87%)
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,gcc-mdm9615.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,qca8k-nsscc.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,qcm2290-gpucc.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,sm7150-camcc.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,sm7150-dispcc.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,sm7150-videocc.yaml
 delete mode 100644 Documentation/devicetree/bindings/clock/qoriq-clock.txt
 create mode 100644 Documentation/devicetree/bindings/clock/sophgo,sg2042-clkgen.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/sophgo,sg2042-pll.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/sophgo,sg2042-rpgate.yaml
 delete mode 100644 Documentation/devicetree/bindings/clock/sprd,sc9860-clk.txt
 create mode 100644 Documentation/devicetree/bindings/clock/sprd,sc9860-clk.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/thead,th1520-clk-ap.yaml
 create mode 100644 drivers/clk/meson/c3-peripherals.c
 create mode 100644 drivers/clk/meson/c3-pll.c
 create mode 100644 drivers/clk/qcom/camcc-sm7150.c
 create mode 100644 drivers/clk/qcom/camcc-sm8650.c
 create mode 100644 drivers/clk/qcom/dispcc-sm7150.c
 create mode 100644 drivers/clk/qcom/gpucc-qcm2290.c
 create mode 100644 drivers/clk/qcom/nsscc-qca8k.c
 create mode 100644 drivers/clk/qcom/videocc-sm7150.c
 create mode 100644 drivers/clk/sophgo/clk-sg2042-clkgen.c
 create mode 100644 drivers/clk/sophgo/clk-sg2042-pll.c
 create mode 100644 drivers/clk/sophgo/clk-sg2042-rpgate.c
 create mode 100644 drivers/clk/sophgo/clk-sg2042.h
 create mode 100644 drivers/clk/thead/Kconfig
 create mode 100644 drivers/clk/thead/Makefile
 create mode 100644 drivers/clk/thead/clk-th1520-ap.c
 create mode 100644 include/dt-bindings/clock/amlogic,c3-peripherals-clkc.h
 create mode 100644 include/dt-bindings/clock/amlogic,c3-pll-clkc.h
 create mode 100644 include/dt-bindings/clock/amlogic,c3-scmi-clkc.h
 create mode 100644 include/dt-bindings/clock/qcom,qca8k-nsscc.h
 create mode 100644 include/dt-bindings/clock/qcom,qcm2290-gpucc.h
 create mode 100644 include/dt-bindings/clock/qcom,sm7150-camcc.h
 create mode 100644 include/dt-bindings/clock/qcom,sm7150-dispcc.h
 create mode 100644 include/dt-bindings/clock/qcom,sm7150-videocc.h
 create mode 100644 include/dt-bindings/clock/qcom,sm8650-camcc.h
 create mode 100644 include/dt-bindings/clock/qcom,sm8650-videocc.h
 delete mode 100644 include/dt-bindings/clock/r8a7790-clock.h
 delete mode 100644 include/dt-bindings/clock/r8a7791-clock.h
 delete mode 100644 include/dt-bindings/clock/r8a7792-clock.h
 delete mode 100644 include/dt-bindings/clock/r8a7793-clock.h
 delete mode 100644 include/dt-bindings/clock/r8a7794-clock.h
 create mode 100644 include/dt-bindings/clock/sophgo,sg2042-clkgen.h
 create mode 100644 include/dt-bindings/clock/sophgo,sg2042-pll.h
 create mode 100644 include/dt-bindings/clock/sophgo,sg2042-rpgate.h
 create mode 100644 include/dt-bindings/clock/thead,th1520-clk-ap.h
 create mode 100644 include/dt-bindings/reset/airoha,en7581-reset.h
 create mode 100644 include/dt-bindings/reset/qcom,qca8k-nsscc.h

-- 
https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
https://git.kernel.org/pub/scm/linux/kernel/git/sboyd/spmi.git

