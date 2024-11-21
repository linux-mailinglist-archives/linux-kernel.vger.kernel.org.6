Return-Path: <linux-kernel+bounces-417557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B03A9D559D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 23:45:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE00B1F22F67
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 22:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D0691D4323;
	Thu, 21 Nov 2024 22:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tvODRiPf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD191DC734;
	Thu, 21 Nov 2024 22:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732229134; cv=none; b=YfvWOz2PWkvDtyO0QLOZj5Fokur82iAZhMZr0+2NwvoMOfGiyC3I72O6nEqmMYTPqZYeiYz/hVTzCzn9XNfImOW+hHvNDaN5YLogV7o1lEll0u/DlRlnQFjKFkK7yTyaZExuLgcRe/puKBP+Mwr/83LyJjgw2Skucc0UKAgHw9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732229134; c=relaxed/simple;
	bh=UGVPbbriJpyCjTegqutBllOv/HV+nPwaeAl8OUP348s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tnSABAeL8Pjcx8dtDFX0u/SckDPT6ElwQh0ei9c4t6czACT+jyDmtoZ8lRzvc3QK/MvIt7abaf0yNGLBU1RptMY6Ac52rH6sVHrM9KkvSZXlVY6+LkMv55pmxm/fktcz7q93y4TV3VsL4BqdHGr7uNdyTSmLKTe26PItNnNh12E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tvODRiPf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 918D6C4CECD;
	Thu, 21 Nov 2024 22:45:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732229133;
	bh=UGVPbbriJpyCjTegqutBllOv/HV+nPwaeAl8OUP348s=;
	h=From:To:Cc:Subject:Date:From;
	b=tvODRiPfnqGs+f3D2bgEH3C/fOuKf7RFLWX0KoUcqnjwQnCXC8SKVlxHYZAHaXjjJ
	 dM1c6w51LrI9XiFOdKITh6NEEp2OZ7FS1ODokT0pOWDzTNMEXlNw3AtrnS+7KezoFb
	 9crzvkK64L8eZiJtcNsxkWzp7wZiD/aMg/VJ12svOEdn3IPlswyIyTrxpv1WGmnQ3D
	 6g868nhnMEKpdsiL1IJN4a5n0oW9VmHm6VaHv0M5pm520+sc8Kvx8ymdhLhcFKNcyE
	 E+LPMvAG1YMGwsd2DxO51WKjuU0bJ3XvFsDZ0vNF/KqUr7Fe+e97FXguREPwH5+3+i
	 GgABAE1yBqfYQ==
From: Stephen Boyd <sboyd@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Michael Turquette <mturquette@baylibre.com>,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] clk changes for the merge window
Date: Thu, 21 Nov 2024 14:45:31 -0800
Message-ID: <20241121224532.2065186-1-sboyd@kernel.org>
X-Mailer: git-send-email 2.47.0.371.ga323438b13-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following changes since commit cdfd5daf90af8363fb1f58e08c829a775b2e2fc5:

  dt-bindings: clock: renesas,r9a08g045-vbattb: Document VBATTB (2024-11-03 11:43:21 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-for-linus

for you to fetch changes up to 21a5352dc702d8e6dc874e0eb6ba6d81291a788a:

  Merge branches 'clk-marvell', 'clk-adi', 'clk-qcom' and 'clk-devm' into clk-next (2024-11-18 20:01:35 -0800)

----------------------------------------------------------------
The core framework gained a clk provider helper, a clk consumer helper, and
some unit tests for the assigned clk rates feature in DeviceTree. On the vendor
driver side, we gained a whole pile of SoC driver support detailed below. The
majority in the diffstat is Qualcomm, but there's also quite a few Samsung and
Mediatek clk driver additions in here as well. The top vendors is quite common,
but the sheer amount of new drivers is uncommon, so I'm anticipating a larger
number of fixes for clk drivers this cycle.

Core:
 - devm_clk_bulk_get_all_enabled() to return number of clks acquired
 - devm_clk_hw_register_gate_parent_hw() helper to modernize drivers
 - KUnit tests for clk-assigned-rates{,-u64}

New Drivers:
 - Marvell PXA1908 SoC clks
 - Mobileye EyeQ5, EyeQ6L and EyeQ6H clk driver
 - TWL6030 clk driver
 - Nuvoton Arbel BMC NPCM8XX SoC clks
 - MediaTek MT6735 SoC clks
 - MediaTek MT7620, MT7628 and MT7688 MMC clks
 - Add a driver for gated fixed rate clocks
 - Global clock controllers for Qualcomm QCS8300 and IPQ5424 SoCs
 - Camera, display and video clock controllers for Qualcomm SA8775P SoCs
 - Global, display, GPU, TCSR, and RPMh clock controllers for Qualcomm SAR2130P
 - Global, camera, display, GPU, and video clock controllers for Qualcomm
   SM8475 SoCs
 - RTC power domain and Battery Backup Function (VBATTB) clock support for the
   Renesas RZ/G3S SoC
 - Qualcomm IPQ9574 alpha PLLs
 - Support for i.MX91 CCM in the i.MX93 driver
 - Microchip LAN969X SoC clks
 - Cortex-A55 core clocks and Interrupt Control Unit (ICU) clock and reset on
   Renesas RZ/V2H(P)
 - Samsung ExynosAutov920 clk drivers for PERIC1, MISC, HSI0 and HSI1
 - Samsung Exynos8895 clk drivers for FSYS0/1, PERIC0/1, PERIS and TOP

Updates:
 - Convert more clk bindings to YAML
 - Various clk driver cleanups: NULL checks, add const, etc.
 - Remove END/NUM #defines that count number of clks in various binding headers
 - Continue moving reset drivers to drivers/reset via auxiliary bus

----------------------------------------------------------------
Andre Przywara (1):
      clk: sunxi-ng: d1: Fix PLL_AUDIO0 preset

Andreas Kemnade (5):
      clk: twl: remove is_prepared
      clk: twl: add TWL6030 support
      dt-bindings: clock: ti: Convert interface.txt to json-schema
      dt-bindings: clock: ti: Convert divider.txt to json-schema
      dt-bindings: clock: ti: Convert mux.txt to json-schema

Andy Shevchenko (1):
      clk: mmp: Switch to use struct u32_fract instead of custom one

Arnd Bergmann (2):
      clk: qcom: remove unused data from gcc-ipq5424.c
      clk: amlogic: axg-audio: fix Kconfig dependency on RESET_MESON_AUX

Biju Das (1):
      clk: renesas: rzg2l: Fix FOUTPOSTDIV clk

Bjorn Andersson (5):
      Merge branch '20240818204348.197788-1-danila@jiaxyga.com' into clk-for-6.13
      Merge branch '20241011-sa8775p-mm-v4-resend-patches-v5-0-4a9f17dc683a@quicinc.com' into clk-for-6.13
      Merge branch '20241027-sar2130p-clocks-v5-0-ecad2a1432ba@linaro.org' into clk-for-6.13
      Merge branch '20241028060506.246606-3-quic_srichara@quicinc.com' into clk-for-6.13
      Merge branch '20240822-qcs8300-gcc-v2-1-b310dfa70ad8@quicinc.com' into clk-for-6.13

Changhuang Liang (1):
      clk: starfive: jh7110-pll: Mark the probe function as __init

Charles Han (1):
      clk: clk-apple-nco: Add NULL check in applnco_probe

Christophe JAILLET (2):
      clk: sunxi-ng: Constify struct ccu_reset_map
      clk: mediatek: mt6735-apmixedsys: Fix an error handling path in clk_mt6735_apmixed_probe()

Chuan Liu (6):
      clk: meson: s4: pll: hifi_pll support fractional multiplier
      clk: meson: Support PLL with fixed fractional denominators
      clk: meson: c3: pll: fix frac maximum value for hifi_pll
      clk: meson: s4: pll: fix frac maximum value for hifi_pll
      clk: meson: mpll: Delete a useless spinlock from the MPLL
      clk: Fix invalid execution of clk_set_rate

Claudiu Beznea (6):
      clk: renesas: rzg2l-cpg: Move PM domain power on in rzg2l_cpg_pd_setup()
      clk: renesas: rzg2l-cpg: Use GENPD_FLAG_* flags instead of local ones
      clk: renesas: r9a08g045: Mark the watchdog and always-on PM domains as IRQ safe
      clk: renesas: r9a08g045: Add power domain for RTC
      clk: Add devm_clk_hw_register_gate_parent_hw()
      clk: renesas: vbattb: Add VBATTB clock driver

Cristian Ciocaltea (1):
      clk: Provide devm_clk_bulk_get_all_enabled() helper

Daniel Machon (4):
      dt-bindings: clock: add support for lan969x
      clk: lan966x: make clk_names const char * const
      clk: lan966x: prepare driver for lan969x support
      clk: lan966x: add support for lan969x SoC clock driver

Danila Tikhonov (10):
      dt-bindings: clock: qcom,gcc-sm8450: Add SM8475 GCC bindings
      dt-bindings: clock: qcom,sm8450-dispcc: Add SM8475 DISPCC bindings
      dt-bindings: clock: qcom,sm8450-gpucc: Add SM8475 GPUCC bindings
      dt-bindings: clock: qcom,sm8450-videocc: Add SM8475 VIDEOCC bindings
      dt-bindings: clock: qcom,sm8450-camcc: Add SM8475 CAMCC bindings
      clk: qcom: gcc-sm8450: Add SM8475 support
      clk: qcom: dispcc-sm8450: Add SM8475 support
      clk: qcom: gpucc-sm8450: Add SM8475 support
      clk: qcom: videocc-sm8450: Add SM8475 support
      clk: qcom: camcc-sm8450: Add SM8475 support

David Hunter (1):
      clk: clk-qoriq: Replace of_node_put() with __free()

Devi Priya (1):
      clk: qcom: clk-alpha-pll: Add NSS HUAYRA ALPHA PLL support for ipq9574

Dmitry Baryshkov (9):
      dt-bindings: clock: qcom,rpmhcc: Add SAR2130P compatible
      dt-bindings: clock: qcom: document SAR2130P Global Clock Controller
      dt-bindings: clock: qcom,sm8550-tcsr: Add SAR2130P compatible
      dt-bindings: clock: qcom,sm8550-dispcc: Add SAR2130P compatible
      clk: qcom: rcg2: add clk_rcg2_shared_floor_ops
      clk: qcom: rpmh: add support for SAR2130P
      clk: qcom: add support for GCC on SAR2130P
      clk: qcom: tcsrcc-sm8550: add SAR2130P support
      clk: qcom: dispcc-sm8550: enable support for SAR2130P

Dong Aisheng (1):
      clk: imx: clk-scu: fix clk enable state save and restore

Dr. David Alan Gilbert (1):
      clk: Remove unused clk_hw_rate_is_protected

Duje Mihanović (5):
      dt-bindings: clock: Add Marvell PXA1908 clock bindings
      clk: mmp: Add Marvell PXA1908 APBC driver
      clk: mmp: Add Marvell PXA1908 APBCP driver
      clk: mmp: Add Marvell PXA1908 APMU driver
      clk: mmp: Add Marvell PXA1908 MPMU driver

Fabrizio Castro (1):
      clk: renesas: r9a09g057: Add clock and reset entries for ICU

Gabor Juhos (1):
      clk: qcom: gcc-qcs404: fix initial rate of GPLL3

Geert Uytterhoeven (3):
      clk: renesas: r8a779h0: Drop CLK_PLL2_DIV2 to clarify ZCn clocks
      Merge tag 'renesas-r9a08g045-dt-binding-defs-tag2' into renesas-clk-for-v6.13
      Merge tag 'renesas-r9a08g045-dt-binding-defs-tag3' into renesas-clk-for-v6.13

Gustavo A. R. Silva (2):
      clk: clk-loongson2: Fix memory corruption bug in struct loongson2_clk_provider
      clk: clk-loongson2: Fix potential buffer overflow in flexible-array member access

Harry Austen (6):
      clk: clocking-wizard: simplify probe/remove with devres helpers
      clk: clocking-wizard: use newer clk_hw API
      clk: clocking-wizard: use devres versions of clk_hw API
      clk: clocking-wizard: move clock registration to separate function
      dt-bindings: clock: xilinx: describe whether dynamic reconfig is enabled
      clk: clocking-wizard: move dynamic reconfig setup behind flag

Heiko Stuebner (4):
      dt-bindings: clocks: add binding for gated-fixed-clocks
      clk: clk-gpio: update documentation for gpio-gate clock
      clk: clk-gpio: use dev_err_probe for gpio-get failure
      clk: clk-gpio: add driver for gated-fixed-clocks

Imran Shaik (2):
      dt-bindings: clock: qcom: Add GCC clocks for QCS8300
      clk: qcom: Add support for Global Clock Controller on QCS8300

Inbaraj E (2):
      clk: samsung: fsd: do not define number of clocks in bindings
      dt-bindings: clock: samsung: remove define with number of clocks for FSD

Ivaylo Ivanov (3):
      clk: samsung: clk-pll: Add support for pll_{1051x,1052x}
      clk: samsung: Introduce Exynos8895 clock driver
      dt-bindings: clock: actions,owl-cmu: convert to YAML

Javier Carrasco (1):
      clk: cdce925: make regmap_cdce925_bus constant

Jerome Brunet (5):
      clk: meson: meson8b: remove spinlock
      Merge tag 'v6.12-rc1' into clk-meson-next
      Merge branch 'v6.13/bindings' into clk-meson-next
      Merge tag 'reset-amlogic-aux' into clk-meson-next
      clk: amlogic: axg-audio: use the auxiliary reset driver

Johan Hovold (2):
      clk: qcom: clk-alpha-pll: drop lucid-evo pll enabled warning
      clk: qcom: clk-alpha-pll: fix lucid 5lpe pll enabled check

Johan Jonker (1):
      dt-bindings: clock: convert rockchip,rk3328-cru.txt to YAML

Jonathan Marek (1):
      clk: qcom: videocc-sm8550: depend on either gcc-sm8550 or gcc-sm8650

Konrad Dybcio (3):
      clk: qcom: Make GCC_6125 depend on QCOM_GDSC
      dt-bindings: clk: qcom,sm8450-gpucc: add SAR2130P compatibles
      clk: qcom: add SAR2130P GPU Clock Controller support

Krzysztof Kozlowski (4):
      clk: qcom: constify static 'struct qcom_icc_hws_data'
      Merge branch 'for-v6.13/clk-dt-bindings' into next/clk
      Merge tag 'samsung-clk-fixes-6.12' into next/clk
      Merge branch 'for-v6.13/clk-dt-bindings' into next/clk

Lad Prabhakar (1):
      clk: renesas: r9a09g057: Add CA55 core clocks

Li Zetao (1):
      clk: tegra: use clamp() in tegra_bpmp_clk_determine_rate()

Lorenzo Bianconi (7):
      dt-bindings: clock: airoha: Update reg mapping for EN7581 SoC.
      clk: en7523: remove REG_PCIE*_{MEM,MEM_MASK} configuration
      clk: en7523: move clock_register in hw_init callback
      clk: en7523: introduce chip_scu regmap
      clk: en7523: fix estimation of fixed rate for EN7581
      clk: en7523: move en7581_reset_register() in en7581_clk_hw_init()
      clk: en7523: map io region in a single block

Lukas Bulwahn (1):
      clk: mediatek: drop two dead config options

Manikanta Mylavarapu (4):
      clk: qcom: ipq5332: remove q6 bring up clocks
      clk: qcom: ipq9574: remove q6 bring up clocks
      dt-bindings: clock: qcom: gcc-ipq5332: remove q6 bring up clock macros
      dt-bindings: clock: qcom: gcc-ipq9574: remove q6 bring up clock macros

Marek Vasut (1):
      clk: renesas: Remove duplicate and trailing empty lines

Neil Armstrong (1):
      dt-bindings: clock: convert amlogic,meson8b-clkc.txt to dtschema

Nuno Sa (2):
      dt-bindings: clock: axi-clkgen: include AXI clk
      clk: clk-axi-clkgen: make sure to enable the AXI bus clock

Pablo Sun (1):
      clk: mediatek: clk-mt8188-topckgen: Remove univpll from parents of mfg_core_tmp

Peng Fan (4):
      clk: imx: lpcg-scu: SW workaround for errata (e10858)
      clk: imx: fracn-gppll: correct PLL initialization flow
      clk: imx: fracn-gppll: fix pll power up
      clk: imx: lpcg-scu: Skip HDMI LPCG clock save/restore

Pengfei Li (4):
      clk: imx93: Move IMX93_CLK_END macro to clk driver
      dt-bindings: clock: imx93: Drop IMX93_CLK_END macro definition
      dt-bindings: clock: Add i.MX91 clock support
      clk: imx: add i.MX91 clk

Peter Griffin (1):
      clk: samsung: gs101: make all ufs related clocks critical

Richard Zhu (2):
      dt-bindings: clock: nxp,imx95-blk-ctl: Add compatible string for i.MX95 HSIO BLK CTRL
      clk: imx95-blk-ctl: Add one clock gate for HSIO block

Rob Herring (Arm) (1):
      clk: sunxi-ng: Use of_property_present() for non-boolean properties

Robert Marko (1):
      clk: lan966x: make it selectable for ARCH_LAN969X

Ryan Walklin (1):
      clk: sunxi-ng: h616: Add sigma-delta modulation settings for audio PLL

Sergio Paracuellos (3):
      clk: ralink: mtmips: fix clock plan for Ralink SoC RT3883
      clk: ralink: mtmips: fix clocks probe order in oldest ralink SoCs
      clk: ralink: mtmips: add mmc related clocks for SoCs MT7620, MT7628 and MT7688

Sricharan Ramabadhran (2):
      dt-bindings: clock: Add Qualcomm IPQ5424 GCC binding
      clk: qcom: add Global Clock controller (GCC) driver for IPQ5424 SoC

Stephen Boyd (17):
      clk: test: Add test managed of_clk_add_hw_provider()
      of: kunit: Extract some overlay boiler plate into macros
      clk: test: Add KUnit tests for clock-assigned-rates{-u64} DT properties
      Merge tag 'renesas-clk-for-v6.13-tag1' of git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers into clk-renesas
      clk: Allow kunit tests to run without OF_OVERLAY enabled
      Merge tag 'samsung-clk-6.13' of https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux into clk-samsung
      Merge tag 'clk-microchip-6.13' of https://git.kernel.org/pub/scm/linux/kernel/git/at91/linux into clk-microchip
      Merge tag 'renesas-clk-for-v6.13-tag2' of git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers into clk-renesas
      Merge tag 'clk-imx-6.13' of git://git.kernel.org/pub/scm/linux/kernel/git/abelvesa/linux into clk-imx
      Merge tag 'clk-meson-v6.13-1' of https://github.com/BayLibre/clk-meson into clk-amlogic
      Merge tag 'sunxi-clk-for-6.13' of https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux into clk-allwinner
      Merge tag 'v6.13-rockchip-clk1' of git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip into clk-bindings
      Merge tag 'qcom-clk-for-6.13' of https://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux into clk-qcom
      Merge branches 'clk-cleanup', 'clk-mediatek', 'clk-kunit', 'clk-xilinx' and 'clk-fixed-gate' into clk-next
      Merge branches 'clk-mobileye', 'clk-twl', 'clk-nuvoton', 'clk-renesas' and 'clk-bindings' into clk-next
      Merge branches 'clk-samsung', 'clk-microchip', 'clk-imx', 'clk-amlogic' and 'clk-allwinner' into clk-next
      Merge branches 'clk-marvell', 'clk-adi', 'clk-qcom' and 'clk-devm' into clk-next

Sunyeal Hong (1):
      clk: samsung: exynosautov920: add peric1, misc and hsi0/1 clock support

Taniya Das (3):
      clk: qcom: Add support for Video clock controller on SA8775P
      clk: qcom: Add support for Camera Clock Controller on SA8775P
      clk: qcom: Add support for Display clock Controllers on SA8775P

Théo Lebrun (12):
      Revert "dt-bindings: clock: mobileye,eyeq5-clk: add bindings"
      dt-bindings: clock: add Mobileye EyeQ6L/EyeQ6H clock indexes
      clk: divider: Introduce CLK_DIVIDER_EVEN_INTEGERS flag
      clk: eyeq: add driver
      dt-bindings: soc: mobileye: set `#clock-cells = <1>` for all compatibles
      dt-bindings: clock: eyeq: add more Mobileye EyeQ5/EyeQ6H clocks
      clk: fixed-factor: add clk_hw_register_fixed_factor_index() function
      clk: eyeq: require clock index with phandle in all cases
      clk: eyeq: add fixed factor clocks infrastructure
      clk: eyeq: add EyeQ5 fixed factor clocks
      clk: eyeq: add EyeQ6H central fixed factor clocks
      clk: eyeq: add EyeQ6H west fixed factor clocks

Tomer Maimon (3):
      dt-bindings: reset: npcm: add clock properties
      reset: npcm: register npcm8xx clock auxiliary bus device
      clk: npcm8xx: add clock controller

Uwe Kleine-König (1):
      clk: Drop explicit initialization of struct i2c_device_id::driver_data to 0

Varada Pavani (2):
      clk: samsung: Fix block comment style warnings reported by checkpatch
      clk: samsung: Fix errors reported by checkpatch

Yang Yingliang (1):
      clk: imx: imx8-acm: Fix return value check in clk_imx_acm_attach_pm_domains()

Yassine Oudjana (4):
      dt-bindings: clock: Add MediaTek MT6735 clock and reset bindings
      clk: mediatek: Add drivers for MediaTek MT6735 main clock and reset drivers
      dt-bindings: clock: mediatek: Add bindings for MT6735 syscon clock and reset controllers
      clk: mediatek: Add drivers for MT6735 syscon clock and reset controllers

Zichen Xie (1):
      clk: sophgo: avoid integer overflow in sg2042_pll_recalc_rate()

 .../devicetree/bindings/clock/actions,owl-cmu.txt  |   52 -
 .../devicetree/bindings/clock/actions,owl-cmu.yaml |   60 +
 .../devicetree/bindings/clock/adi,axi-clkgen.yaml  |   22 +-
 .../bindings/clock/airoha,en7523-scu.yaml          |   23 +-
 .../bindings/clock/amlogic,meson8-clkc.yaml        |   45 +
 .../bindings/clock/amlogic,meson8b-clkc.txt        |   51 -
 .../bindings/clock/gated-fixed-clock.yaml          |   49 +
 .../devicetree/bindings/clock/imx93-clock.yaml     |    1 +
 .../devicetree/bindings/clock/marvell,pxa1908.yaml |   48 +
 .../bindings/clock/mediatek,apmixedsys.yaml        |    4 +-
 .../bindings/clock/mediatek,infracfg.yaml          |    8 +-
 .../bindings/clock/mediatek,pericfg.yaml           |    1 +
 .../devicetree/bindings/clock/mediatek,syscon.yaml |    4 +
 .../bindings/clock/mediatek,topckgen.yaml          |    4 +-
 .../bindings/clock/microchip,lan966x-gck.yaml      |   13 +-
 .../bindings/clock/mobileye,eyeq5-clk.yaml         |   51 -
 .../bindings/clock/nxp,imx95-blk-ctl.yaml          |    5 +-
 .../devicetree/bindings/clock/qcom,gcc-sm8450.yaml |    4 +-
 .../bindings/clock/qcom,ipq5332-gcc.yaml           |   41 +-
 .../bindings/clock/qcom,qcs8300-gcc.yaml           |   66 +
 .../devicetree/bindings/clock/qcom,rpmhcc.yaml     |    1 +
 .../bindings/clock/qcom,sa8775p-camcc.yaml         |   62 +
 .../bindings/clock/qcom,sa8775p-dispcc.yaml        |   79 +
 .../bindings/clock/qcom,sa8775p-videocc.yaml       |   62 +
 .../bindings/clock/qcom,sar2130p-gcc.yaml          |   65 +
 .../bindings/clock/qcom,sm8450-camcc.yaml          |    1 +
 .../bindings/clock/qcom,sm8450-dispcc.yaml         |    1 +
 .../bindings/clock/qcom,sm8450-gpucc.yaml          |    3 +
 .../bindings/clock/qcom,sm8450-videocc.yaml        |    1 +
 .../bindings/clock/qcom,sm8550-dispcc.yaml         |    1 +
 .../bindings/clock/qcom,sm8550-tcsr.yaml           |    1 +
 .../bindings/clock/rockchip,rk3328-cru.txt         |   58 -
 .../bindings/clock/rockchip,rk3328-cru.yaml        |   74 +
 .../bindings/clock/samsung,exynos8895-clock.yaml   |  239 ++
 .../devicetree/bindings/clock/ti/composite.txt     |    4 +-
 .../devicetree/bindings/clock/ti/divider.txt       |  115 -
 .../devicetree/bindings/clock/ti/interface.txt     |   55 -
 Documentation/devicetree/bindings/clock/ti/mux.txt |   78 -
 .../bindings/clock/ti/ti,divider-clock.yaml        |  193 ++
 .../bindings/clock/ti/ti,interface-clock.yaml      |   71 +
 .../devicetree/bindings/clock/ti/ti,mux-clock.yaml |  125 +
 .../bindings/clock/xlnx,clocking-wizard.yaml       |    6 +
 .../bindings/reset/nuvoton,npcm750-reset.yaml      |   18 +
 .../bindings/soc/mobileye/mobileye,eyeq5-olb.yaml  |   24 +-
 MAINTAINERS                                        |   28 +-
 drivers/clk/.kunitconfig                           |    1 +
 drivers/clk/Kconfig                                |   25 +-
 drivers/clk/Makefile                               |   16 +
 drivers/clk/clk-apple-nco.c                        |    3 +
 drivers/clk/clk-axi-clkgen.c                       |   22 +-
 drivers/clk/clk-cdce706.c                          |    2 +-
 drivers/clk/clk-cdce925.c                          |    2 +-
 drivers/clk/clk-devres.c                           |    9 +-
 drivers/clk/clk-divider.c                          |   16 +-
 drivers/clk/clk-en7523.c                           |  315 +-
 drivers/clk/clk-eyeq.c                             |  859 +++++
 drivers/clk/clk-fixed-factor.c                     |   11 +
 drivers/clk/clk-gpio.c                             |  205 +-
 drivers/clk/clk-lan966x.c                          |   78 +-
 drivers/clk/clk-loongson2.c                        |    6 +-
 drivers/clk/clk-npcm8xx.c                          |  430 +++
 drivers/clk/clk-qoriq.c                            |    6 +-
 drivers/clk/clk-si514.c                            |    2 +-
 drivers/clk/clk-twl.c                              |   69 +-
 drivers/clk/clk.c                                  |    8 +-
 drivers/clk/clk_kunit_helpers.c                    |   30 +
 drivers/clk/clk_test.c                             |  321 ++
 drivers/clk/imx/clk-fracn-gppll.c                  |   10 +-
 drivers/clk/imx/clk-imx8-acm.c                     |    4 +-
 drivers/clk/imx/clk-imx93.c                        |   63 +-
 drivers/clk/imx/clk-imx95-blk-ctl.c                |   20 +
 drivers/clk/imx/clk-lpcg-scu.c                     |   41 +-
 drivers/clk/imx/clk-scu.c                          |    2 +-
 drivers/clk/kunit_clk_assigned_rates.h             |    8 +
 drivers/clk/kunit_clk_assigned_rates_multiple.dtso |   16 +
 ...kunit_clk_assigned_rates_multiple_consumer.dtso |   20 +
 drivers/clk/kunit_clk_assigned_rates_null.dtso     |   14 +
 .../kunit_clk_assigned_rates_null_consumer.dtso    |   18 +
 drivers/clk/kunit_clk_assigned_rates_one.dtso      |   14 +
 .../clk/kunit_clk_assigned_rates_one_consumer.dtso |   18 +
 .../clk/kunit_clk_assigned_rates_u64_multiple.dtso |   16 +
 ...t_clk_assigned_rates_u64_multiple_consumer.dtso |   20 +
 drivers/clk/kunit_clk_assigned_rates_u64_one.dtso  |   14 +
 .../kunit_clk_assigned_rates_u64_one_consumer.dtso |   18 +
 drivers/clk/kunit_clk_assigned_rates_without.dtso  |   13 +
 .../kunit_clk_assigned_rates_without_consumer.dtso |   17 +
 drivers/clk/kunit_clk_assigned_rates_zero.dtso     |   12 +
 .../kunit_clk_assigned_rates_zero_consumer.dtso    |   16 +
 drivers/clk/mediatek/Kconfig                       |   52 +-
 drivers/clk/mediatek/Makefile                      |    5 +
 drivers/clk/mediatek/clk-mt6735-apmixedsys.c       |  137 +
 drivers/clk/mediatek/clk-mt6735-imgsys.c           |   57 +
 drivers/clk/mediatek/clk-mt6735-infracfg.c         |  107 +
 drivers/clk/mediatek/clk-mt6735-mfgcfg.c           |   61 +
 drivers/clk/mediatek/clk-mt6735-pericfg.c          |  124 +
 drivers/clk/mediatek/clk-mt6735-topckgen.c         |  394 +++
 drivers/clk/mediatek/clk-mt6735-vdecsys.c          |   79 +
 drivers/clk/mediatek/clk-mt6735-vencsys.c          |   53 +
 drivers/clk/mediatek/clk-mt8188-topckgen.c         |    9 +-
 drivers/clk/meson/Kconfig                          |    1 +
 drivers/clk/meson/axg-audio.c                      |  109 +-
 drivers/clk/meson/axg.c                            |    6 -
 drivers/clk/meson/c3-pll.c                         |    1 +
 drivers/clk/meson/clk-mpll.c                       |   11 -
 drivers/clk/meson/clk-mpll.h                       |    1 -
 drivers/clk/meson/clk-pll.c                        |    8 +-
 drivers/clk/meson/clk-pll.h                        |    1 +
 drivers/clk/meson/g12a.c                           |    6 -
 drivers/clk/meson/gxbb.c                           |    6 -
 drivers/clk/meson/meson8b.c                        |   10 -
 drivers/clk/meson/s4-pll.c                         |   13 +-
 drivers/clk/mmp/Makefile                           |    2 +-
 drivers/clk/mmp/clk-frac.c                         |   57 +-
 drivers/clk/mmp/clk-of-mmp2.c                      |   26 +-
 drivers/clk/mmp/clk-of-pxa168.c                    |    4 +-
 drivers/clk/mmp/clk-of-pxa1928.c                   |    6 +-
 drivers/clk/mmp/clk-of-pxa910.c                    |    4 +-
 drivers/clk/mmp/clk-pxa1908-apbc.c                 |  130 +
 drivers/clk/mmp/clk-pxa1908-apbcp.c                |   82 +
 drivers/clk/mmp/clk-pxa1908-apmu.c                 |  121 +
 drivers/clk/mmp/clk-pxa1908-mpmu.c                 |  112 +
 drivers/clk/mmp/clk.h                              |   10 +-
 drivers/clk/qcom/Kconfig                           |   88 +-
 drivers/clk/qcom/Makefile                          |    7 +
 drivers/clk/qcom/camcc-sa8775p.c                   | 1868 ++++++++++
 drivers/clk/qcom/camcc-sm8450.c                    |  294 +-
 drivers/clk/qcom/clk-alpha-pll.c                   |   23 +-
 drivers/clk/qcom/clk-alpha-pll.h                   |    1 +
 drivers/clk/qcom/clk-rcg.h                         |    1 +
 drivers/clk/qcom/clk-rcg2.c                        |   48 +-
 drivers/clk/qcom/clk-rpmh.c                        |   13 +
 drivers/clk/qcom/common.h                          |    2 +-
 drivers/clk/qcom/dispcc-sm8450.c                   |   66 +-
 drivers/clk/qcom/dispcc-sm8550.c                   |   18 +-
 drivers/clk/qcom/dispcc0-sa8775p.c                 | 1481 ++++++++
 drivers/clk/qcom/dispcc1-sa8775p.c                 | 1481 ++++++++
 drivers/clk/qcom/gcc-ipq5332.c                     |  382 +-
 drivers/clk/qcom/gcc-ipq5424.c                     | 3291 ++++++++++++++++++
 drivers/clk/qcom/gcc-ipq9574.c                     |  328 +-
 drivers/clk/qcom/gcc-qcs404.c                      |    1 +
 drivers/clk/qcom/gcc-qcs8300.c                     | 3640 ++++++++++++++++++++
 drivers/clk/qcom/gcc-sar2130p.c                    | 2366 +++++++++++++
 drivers/clk/qcom/gcc-sm8450.c                      |  181 +-
 drivers/clk/qcom/gpucc-sar2130p.c                  |  502 +++
 drivers/clk/qcom/gpucc-sm8450.c                    |   50 +-
 drivers/clk/qcom/tcsrcc-sm8550.c                   |   18 +-
 drivers/clk/qcom/videocc-sa8775p.c                 |  576 ++++
 drivers/clk/qcom/videocc-sm8450.c                  |   48 +-
 drivers/clk/ralink/clk-mtmips.c                    |   56 +-
 drivers/clk/renesas/Kconfig                        |    5 +
 drivers/clk/renesas/Makefile                       |    1 +
 drivers/clk/renesas/clk-r8a73a4.c                  |    1 -
 drivers/clk/renesas/clk-r8a7778.c                  |    1 -
 drivers/clk/renesas/clk-vbattb.c                   |  205 ++
 drivers/clk/renesas/r8a779a0-cpg-mssr.c            |    1 -
 drivers/clk/renesas/r8a779h0-cpg-mssr.c            |   10 +-
 drivers/clk/renesas/r9a08g045-cpg.c                |   54 +-
 drivers/clk/renesas/r9a09g011-cpg.c                |    1 -
 drivers/clk/renesas/r9a09g057-cpg.c                |   18 +
 drivers/clk/renesas/rcar-cpg-lib.c                 |    1 -
 drivers/clk/renesas/rcar-gen3-cpg.c                |    1 -
 drivers/clk/renesas/renesas-cpg-mssr.c             |    2 -
 drivers/clk/renesas/rzg2l-cpg.c                    |   52 +-
 drivers/clk/renesas/rzg2l-cpg.h                    |   10 +-
 drivers/clk/renesas/rzv2h-cpg.h                    |    5 +
 drivers/clk/samsung/Makefile                       |    1 +
 drivers/clk/samsung/clk-exynos-audss.c             |    2 +-
 drivers/clk/samsung/clk-exynos3250.c               |    2 +-
 drivers/clk/samsung/clk-exynos4.c                  |    2 +-
 drivers/clk/samsung/clk-exynos4412-isp.c           |    2 +-
 drivers/clk/samsung/clk-exynos5250.c               |    2 +-
 drivers/clk/samsung/clk-exynos5260.c               |    4 +-
 drivers/clk/samsung/clk-exynos5410.c               |    2 +-
 drivers/clk/samsung/clk-exynos5420.c               |    6 +-
 drivers/clk/samsung/clk-exynos7.c                  |    2 +-
 drivers/clk/samsung/clk-exynos8895.c               | 2803 +++++++++++++++
 drivers/clk/samsung/clk-exynosautov920.c           |  290 ++
 drivers/clk/samsung/clk-fsd.c                      |   23 +-
 drivers/clk/samsung/clk-gs101.c                    |   10 +-
 drivers/clk/samsung/clk-pll.c                      |    2 +
 drivers/clk/samsung/clk-pll.h                      |    2 +
 drivers/clk/samsung/clk-s3c64xx.c                  |    2 +-
 drivers/clk/samsung/clk-s5pv210-audss.c            |    2 +-
 drivers/clk/samsung/clk.c                          |    2 +-
 drivers/clk/sophgo/clk-sg2042-pll.c                |    2 +-
 drivers/clk/starfive/clk-starfive-jh7110-pll.c     |    2 +-
 drivers/clk/sunxi-ng/ccu-sun20i-d1-r.c             |    2 +-
 drivers/clk/sunxi-ng/ccu-sun20i-d1.c               |    4 +-
 drivers/clk/sunxi-ng/ccu-sun4i-a10.c               |    2 +-
 drivers/clk/sunxi-ng/ccu-sun50i-a100-r.c           |    2 +-
 drivers/clk/sunxi-ng/ccu-sun50i-a100.c             |    2 +-
 drivers/clk/sunxi-ng/ccu-sun50i-a64.c              |    2 +-
 drivers/clk/sunxi-ng/ccu-sun50i-h6-r.c             |    4 +-
 drivers/clk/sunxi-ng/ccu-sun50i-h6.c               |    2 +-
 drivers/clk/sunxi-ng/ccu-sun50i-h616.c             |   46 +-
 drivers/clk/sunxi-ng/ccu-sun5i.c                   |    2 +-
 drivers/clk/sunxi-ng/ccu-sun6i-a31.c               |    2 +-
 drivers/clk/sunxi-ng/ccu-sun6i-rtc.c               |    2 +-
 drivers/clk/sunxi-ng/ccu-sun8i-a23.c               |    2 +-
 drivers/clk/sunxi-ng/ccu-sun8i-a33.c               |    2 +-
 drivers/clk/sunxi-ng/ccu-sun8i-a83t.c              |    2 +-
 drivers/clk/sunxi-ng/ccu-sun8i-de2.c               |    8 +-
 drivers/clk/sunxi-ng/ccu-sun8i-h3.c                |    4 +-
 drivers/clk/sunxi-ng/ccu-sun8i-r.c                 |    6 +-
 drivers/clk/sunxi-ng/ccu-sun8i-r40.c               |    2 +-
 drivers/clk/sunxi-ng/ccu-sun8i-v3s.c               |    4 +-
 drivers/clk/sunxi-ng/ccu-sun9i-a80-de.c            |    2 +-
 drivers/clk/sunxi-ng/ccu-sun9i-a80-usb.c           |    2 +-
 drivers/clk/sunxi-ng/ccu-sun9i-a80.c               |    2 +-
 drivers/clk/sunxi-ng/ccu-suniv-f1c100s.c           |    2 +-
 drivers/clk/sunxi-ng/ccu_common.h                  |    2 +-
 drivers/clk/sunxi-ng/ccu_reset.h                   |    2 +-
 drivers/clk/tegra/clk-bpmp.c                       |    2 +-
 drivers/clk/xilinx/clk-xlnx-clock-wizard.c         |  291 +-
 drivers/reset/Kconfig                              |   16 +-
 drivers/reset/Makefile                             |    3 +-
 drivers/reset/amlogic/Kconfig                      |   27 +
 drivers/reset/amlogic/Makefile                     |    4 +
 .../reset/{ => amlogic}/reset-meson-audio-arb.c    |    0
 drivers/reset/amlogic/reset-meson-aux.c            |  136 +
 drivers/reset/amlogic/reset-meson-common.c         |  142 +
 drivers/reset/amlogic/reset-meson.c                |  105 +
 drivers/reset/amlogic/reset-meson.h                |   28 +
 drivers/reset/reset-meson.c                        |  159 -
 drivers/reset/reset-npcm.c                         |   78 +-
 include/dt-bindings/clock/fsd-clk.h                |    7 -
 include/dt-bindings/clock/imx93-clock.h            |    6 +-
 include/dt-bindings/clock/marvell,pxa1908.h        |   88 +
 .../dt-bindings/clock/mediatek,mt6735-apmixedsys.h |   16 +
 include/dt-bindings/clock/mediatek,mt6735-imgsys.h |   15 +
 .../dt-bindings/clock/mediatek,mt6735-infracfg.h   |   25 +
 include/dt-bindings/clock/mediatek,mt6735-mfgcfg.h |    8 +
 .../dt-bindings/clock/mediatek,mt6735-pericfg.h    |   37 +
 .../dt-bindings/clock/mediatek,mt6735-topckgen.h   |   79 +
 .../dt-bindings/clock/mediatek,mt6735-vdecsys.h    |    9 +
 .../dt-bindings/clock/mediatek,mt6735-vencsys.h    |   11 +
 include/dt-bindings/clock/mobileye,eyeq5-clk.h     |   65 +-
 include/dt-bindings/clock/qcom,gcc-sm8450.h        |    3 +
 include/dt-bindings/clock/qcom,ipq5332-gcc.h       |   20 -
 include/dt-bindings/clock/qcom,ipq5424-gcc.h       |  156 +
 include/dt-bindings/clock/qcom,ipq9574-gcc.h       |   18 -
 include/dt-bindings/clock/qcom,qcs8300-gcc.h       |  234 ++
 include/dt-bindings/clock/qcom,sa8775p-camcc.h     |  108 +
 include/dt-bindings/clock/qcom,sa8775p-dispcc.h    |   87 +
 include/dt-bindings/clock/qcom,sa8775p-videocc.h   |   47 +
 include/dt-bindings/clock/qcom,sar2130p-gcc.h      |  185 +
 include/dt-bindings/clock/qcom,sar2130p-gpucc.h    |   33 +
 include/dt-bindings/clock/samsung,exynos8895.h     |  453 +++
 include/dt-bindings/clock/samsung,exynosautov920.h |   47 +
 .../dt-bindings/reset/mediatek,mt6735-infracfg.h   |   27 +
 include/dt-bindings/reset/mediatek,mt6735-mfgcfg.h |    9 +
 .../dt-bindings/reset/mediatek,mt6735-pericfg.h    |   31 +
 .../dt-bindings/reset/mediatek,mt6735-vdecsys.h    |    9 +
 include/dt-bindings/reset/qcom,ipq5424-gcc.h       |  310 ++
 include/dt-bindings/reset/qcom,sar2130p-gpucc.h    |   14 +
 include/kunit/clk.h                                |    4 +
 include/kunit/of.h                                 |   14 +-
 include/linux/clk-provider.h                       |   37 +-
 include/linux/clk.h                                |   21 +-
 include/soc/amlogic/reset-meson-aux.h              |   23 +
 include/soc/nuvoton/clock-npcm8xx.h                |   18 +
 261 files changed, 27959 insertions(+), 2315 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/clock/actions,owl-cmu.txt
 create mode 100644 Documentation/devicetree/bindings/clock/actions,owl-cmu.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/amlogic,meson8-clkc.yaml
 delete mode 100644 Documentation/devicetree/bindings/clock/amlogic,meson8b-clkc.txt
 create mode 100644 Documentation/devicetree/bindings/clock/gated-fixed-clock.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/marvell,pxa1908.yaml
 delete mode 100644 Documentation/devicetree/bindings/clock/mobileye,eyeq5-clk.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,qcs8300-gcc.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,sa8775p-camcc.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,sa8775p-dispcc.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,sa8775p-videocc.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,sar2130p-gcc.yaml
 delete mode 100644 Documentation/devicetree/bindings/clock/rockchip,rk3328-cru.txt
 create mode 100644 Documentation/devicetree/bindings/clock/rockchip,rk3328-cru.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/samsung,exynos8895-clock.yaml
 delete mode 100644 Documentation/devicetree/bindings/clock/ti/divider.txt
 delete mode 100644 Documentation/devicetree/bindings/clock/ti/interface.txt
 delete mode 100644 Documentation/devicetree/bindings/clock/ti/mux.txt
 create mode 100644 Documentation/devicetree/bindings/clock/ti/ti,divider-clock.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/ti/ti,interface-clock.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/ti/ti,mux-clock.yaml
 create mode 100644 drivers/clk/clk-eyeq.c
 create mode 100644 drivers/clk/clk-npcm8xx.c
 create mode 100644 drivers/clk/kunit_clk_assigned_rates.h
 create mode 100644 drivers/clk/kunit_clk_assigned_rates_multiple.dtso
 create mode 100644 drivers/clk/kunit_clk_assigned_rates_multiple_consumer.dtso
 create mode 100644 drivers/clk/kunit_clk_assigned_rates_null.dtso
 create mode 100644 drivers/clk/kunit_clk_assigned_rates_null_consumer.dtso
 create mode 100644 drivers/clk/kunit_clk_assigned_rates_one.dtso
 create mode 100644 drivers/clk/kunit_clk_assigned_rates_one_consumer.dtso
 create mode 100644 drivers/clk/kunit_clk_assigned_rates_u64_multiple.dtso
 create mode 100644 drivers/clk/kunit_clk_assigned_rates_u64_multiple_consumer.dtso
 create mode 100644 drivers/clk/kunit_clk_assigned_rates_u64_one.dtso
 create mode 100644 drivers/clk/kunit_clk_assigned_rates_u64_one_consumer.dtso
 create mode 100644 drivers/clk/kunit_clk_assigned_rates_without.dtso
 create mode 100644 drivers/clk/kunit_clk_assigned_rates_without_consumer.dtso
 create mode 100644 drivers/clk/kunit_clk_assigned_rates_zero.dtso
 create mode 100644 drivers/clk/kunit_clk_assigned_rates_zero_consumer.dtso
 create mode 100644 drivers/clk/mediatek/clk-mt6735-apmixedsys.c
 create mode 100644 drivers/clk/mediatek/clk-mt6735-imgsys.c
 create mode 100644 drivers/clk/mediatek/clk-mt6735-infracfg.c
 create mode 100644 drivers/clk/mediatek/clk-mt6735-mfgcfg.c
 create mode 100644 drivers/clk/mediatek/clk-mt6735-pericfg.c
 create mode 100644 drivers/clk/mediatek/clk-mt6735-topckgen.c
 create mode 100644 drivers/clk/mediatek/clk-mt6735-vdecsys.c
 create mode 100644 drivers/clk/mediatek/clk-mt6735-vencsys.c
 create mode 100644 drivers/clk/mmp/clk-pxa1908-apbc.c
 create mode 100644 drivers/clk/mmp/clk-pxa1908-apbcp.c
 create mode 100644 drivers/clk/mmp/clk-pxa1908-apmu.c
 create mode 100644 drivers/clk/mmp/clk-pxa1908-mpmu.c
 create mode 100644 drivers/clk/qcom/camcc-sa8775p.c
 create mode 100644 drivers/clk/qcom/dispcc0-sa8775p.c
 create mode 100644 drivers/clk/qcom/dispcc1-sa8775p.c
 create mode 100644 drivers/clk/qcom/gcc-ipq5424.c
 create mode 100644 drivers/clk/qcom/gcc-qcs8300.c
 create mode 100644 drivers/clk/qcom/gcc-sar2130p.c
 create mode 100644 drivers/clk/qcom/gpucc-sar2130p.c
 create mode 100644 drivers/clk/qcom/videocc-sa8775p.c
 create mode 100644 drivers/clk/renesas/clk-vbattb.c
 create mode 100644 drivers/clk/samsung/clk-exynos8895.c
 create mode 100644 drivers/reset/amlogic/Kconfig
 create mode 100644 drivers/reset/amlogic/Makefile
 rename drivers/reset/{ => amlogic}/reset-meson-audio-arb.c (100%)
 create mode 100644 drivers/reset/amlogic/reset-meson-aux.c
 create mode 100644 drivers/reset/amlogic/reset-meson-common.c
 create mode 100644 drivers/reset/amlogic/reset-meson.c
 create mode 100644 drivers/reset/amlogic/reset-meson.h
 delete mode 100644 drivers/reset/reset-meson.c
 create mode 100644 include/dt-bindings/clock/marvell,pxa1908.h
 create mode 100644 include/dt-bindings/clock/mediatek,mt6735-apmixedsys.h
 create mode 100644 include/dt-bindings/clock/mediatek,mt6735-imgsys.h
 create mode 100644 include/dt-bindings/clock/mediatek,mt6735-infracfg.h
 create mode 100644 include/dt-bindings/clock/mediatek,mt6735-mfgcfg.h
 create mode 100644 include/dt-bindings/clock/mediatek,mt6735-pericfg.h
 create mode 100644 include/dt-bindings/clock/mediatek,mt6735-topckgen.h
 create mode 100644 include/dt-bindings/clock/mediatek,mt6735-vdecsys.h
 create mode 100644 include/dt-bindings/clock/mediatek,mt6735-vencsys.h
 create mode 100644 include/dt-bindings/clock/qcom,ipq5424-gcc.h
 create mode 100644 include/dt-bindings/clock/qcom,qcs8300-gcc.h
 create mode 100644 include/dt-bindings/clock/qcom,sa8775p-camcc.h
 create mode 100644 include/dt-bindings/clock/qcom,sa8775p-dispcc.h
 create mode 100644 include/dt-bindings/clock/qcom,sa8775p-videocc.h
 create mode 100644 include/dt-bindings/clock/qcom,sar2130p-gcc.h
 create mode 100644 include/dt-bindings/clock/qcom,sar2130p-gpucc.h
 create mode 100644 include/dt-bindings/clock/samsung,exynos8895.h
 create mode 100644 include/dt-bindings/reset/mediatek,mt6735-infracfg.h
 create mode 100644 include/dt-bindings/reset/mediatek,mt6735-mfgcfg.h
 create mode 100644 include/dt-bindings/reset/mediatek,mt6735-pericfg.h
 create mode 100644 include/dt-bindings/reset/mediatek,mt6735-vdecsys.h
 create mode 100644 include/dt-bindings/reset/qcom,ipq5424-gcc.h
 create mode 100644 include/dt-bindings/reset/qcom,sar2130p-gpucc.h
 create mode 100644 include/soc/amlogic/reset-meson-aux.h
 create mode 100644 include/soc/nuvoton/clock-npcm8xx.h

-- 
https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
https://git.kernel.org/pub/scm/linux/kernel/git/sboyd/spmi.git

