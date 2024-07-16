Return-Path: <linux-kernel+bounces-253863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7726593280F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 16:14:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 948591C226B0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 14:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2D5019B3E3;
	Tue, 16 Jul 2024 14:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YALbmgf7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF2419B3C4
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 14:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721139248; cv=none; b=HP4B4hNW3es/Fo+DIs6B3dro1hqubMVX2k/HziluWC0WGe28Uu7u9cyUTDADjCrPEZN3xm5UYUhTjFw6ZjyR13JseoTkthVzMN5KmUDO1hI+9xpztOrrZifoGLXqMhcnWS1moQYILqsVEar+l1u4Io57AeKCjj/JOHDVu+XBRcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721139248; c=relaxed/simple;
	bh=9MUu+mx9LpwvG55EanJpggshO2DHPiQjC1LhJYNJmCg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=mX9EGzUq3oiA81448y8vXgltWcoc5WtKyJ8R4mcwKaJ2q7iW19scj9wlQSZQKsBPV3+uZJ/h3yWRtn2dD2NebQPveTgs+5NO8MKTt+lUjsJ5lImfwfhz2UrTTg4eHoGl8PPkpbPw0cS7UNXbfxmGXgXxJC/H+6L6uJhpJ+9v9WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YALbmgf7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D643C4AF0D;
	Tue, 16 Jul 2024 14:14:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721139247;
	bh=9MUu+mx9LpwvG55EanJpggshO2DHPiQjC1LhJYNJmCg=;
	h=Date:From:To:Cc:Subject:From;
	b=YALbmgf7Jt/K42sEJfkQQ4qu/chixaNa8fbkYxP4cpatfvg7nj/aaTkopXRvHtr30
	 WXMD3WvTkok87+O/1SBrA8wMsWvtoFTPr53o3moF9UkMFYwERvZcdzzCga2Splvv9L
	 z8kB6KTnNkplxvHFX5iXL0tY32O6w+GetRJWEYivl3buP/RXWx/jCU8y6nKc6C6zJw
	 /UrUglQyG/YuZcuHG+AIe0RT75Fq3yeSLRyHhPJR/K0jb7/ZNuSBEJTYicmCxE8mcb
	 IOS6VGeCAQ40nO5sHStu1ER5sd7Usq7um9FWMoLF94Edg6GLyCRShurAXSvCH85j87
	 nMxS8zmXh9ndg==
Date: Tue, 16 Jul 2024 15:14:04 +0100
From: Lee Jones <lee@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] MFD for v6.11
Message-ID: <20240716141404.GU501857@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Good afternoon Linus,

The following changes since commit 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0:

  Linux 6.10-rc1 (2024-05-26 15:20:12 -0700)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git tags/mfd-next-6.11

for you to fetch changes up to c298391abf6505c4040632b310a14f6bd9b7afff:

  mfd: timberdale: Attach device properties to TSC2007 board info (2024-07-11 16:38:23 +0100)

----------------------------------------------------------------
 - New Drivers
   - Add support for ROHM BD96801 Power Management IC
   - Add support for Cirrus Logic CS40L50 Haptic Driver with Waveform Memory
   - Add support for Marvell 88PM886 Power Management IC

 - New Device Support
   - Add support for Keyboard Backlight to ChromeOS Embedded Controller
   - Add support for LEDs to ChromeOS Embedded Controller
   - Add support for Charge Control to ChromeOS Embedded Controller
   - Add support for the HW Monitoring Service to ChromeOS Embedded Controller
   - Add support for AUXADCs to MediaTek MT635{7,8,9} Power Management ICs

 - New Functionality
   - Allow Syscon consumers to supply their own Regmaps on registration

 - Fix-ups
   - Constify/staticise applicable data structures
   - Remove superfluous/duplicated/unused sections
   - Device Tree binding adaptions/conversions/creation
   - Trivial; spelling, whitespace, coding-style adaptions
   - Utilise centrally provided helpers and macros to aid simplicity/duplication
   - Drop i2c_device_id::driver_data where the value is unused
   - Replace ACPI/DT firmware helpers with agnostic variants
   - Move over to GPIOD (descriptor-based) APIs
   - Annotate a bunch of __counted_by() cases
   - Straighten out some includes

 - Bug Fixes
   - Ensure potentially asserted recent lines are deasserted during initialisation
   - Avoid "<module>.ko is added to multiple modules" warnings
   - Supply a bunch of MODULE_DESCRIPTIONs to silence modpost warnings
   - Fix Wvoid-pointer-to-enum-cast warnings

----------------------------------------------------------------
Abel Vesa (1):
      dt-bindings: mfd: qcom-spmi-pmic: Document SMB2360 PMIC

Andrew Davis (1):
      mfd: tps65912: Use devm helper functions to simplify probe

Andy Shevchenko (4):
      mfd: omap-usb-host: Remove unused linux/gpio.h
      mfd: menelaus: Remove unused linux/gpio.h
      mfd: core: Make use of device_set_node()
      mfd: lm3533: Move to new GPIO descriptor-based APIs

AngeloGioacchino Del Regno (2):
      dt-bindings: mfd: mediatek,mt8195-scpsys: Add support for MT8188
      mfd: mt6397-core: Add support for AUXADCs on MT6357/58/59 PMICs

Aradhya Bhatia (1):
      dt-bindings: mfd: syscon: Add ti,am625-dss-oldi-io-ctrl compatible

Arnd Bergmann (1):
      mfd: rsmu: Split core code into separate module

Bryan Brattlof (1):
      dt-bindings: mfd: syscon: Add TI's opp table compatible

Cristian Ciocaltea (2):
      dt-bindings: mfd: rk817: Fixup clocks and reference dai-common
      dt-bindings: mfd: rk817: Merge support for RK809

Dmitry Torokhov (1):
      mfd: timberdale: Attach device properties to TSC2007 board info

Etienne Carriere (1):
      dt-bindings: mfd: Dual licensing for st,stpmic1 bindings

Hans de Goede (1):
      mfd: intel_soc_pmic_crc: Use PWM_LOOKUP_WITH_MODULE() for the PWM lookup

Ilpo Järvinen (1):
      mfd: intel-lpss: Rename SPI intel_lpss_platform_info structs

James Ogletree (5):
      firmware: cs_dsp: Add write sequence interface
      dt-bindings: input: cirrus,cs40l50: Add initial DT binding
      mfd: cs40l50: Add support for CS40L50 core driver
      Input: cs40l50 - Add support for the CS40L50 haptic driver
      ASoC: cs40l50: Support I2S streaming to CS40L50

Javier Carrasco (2):
      mfd: omap-usb-tll: Annotate struct usbtll_omap with __counted_by
      mfd: omap-usb-tll: Use struct_size to allocate tll

Jeff Johnson (2):
      mfd: qcom-pm8008: Add missing MODULE_DESCRIPTION() macro
      mfd: Add missing MODULE_DESCRIPTION() macros

Johan Hovold (11):
      dt-bindings: mfd: pm8008: Add reset gpio
      mfd: pm8008: Fix regmap irq chip initialisation
      mfd: pm8008: Deassert reset on probe
      mfd: pm8008: Mark regmap structures as const
      mfd: pm8008: Use lower case hex notation
      mfd: pm8008: Rename irq chip
      mfd: pm8008: Drop unused driver data
      dt-bindings: mfd: pm8008: Drop redundant descriptions
      dt-bindings: mfd: pm8008: Rework binding
      mfd: pm8008: Rework to match new DT binding
      regulator: add pm8008 pmic regulator driver

Karel Balej (5):
      dt-bindings: mfd: Add entry for Marvell 88PM886 PMIC
      mfd: Add driver for Marvell 88PM886 PMIC
      regulator: Add regulators driver for Marvell 88PM886 PMIC
      input: Add onkey driver for Marvell 88PM886 PMIC
      MAINTAINERS: Add myself for Marvell 88PM886 PMIC

Konrad Dybcio (1):
      dt-bindings: mfd: qcom,spmi-pmic: Document PMC8380

Krzysztof Kozlowski (14):
      dt-bindings: mfd: syscon: Drop hwlocks
      dt-bindings: soc: sprd: sc9863a-glbregs: Document SC9863A syscon
      dt-bindings: soc: intel: lgm-syscon: Move to dedicated schema
      dt-bindings: soc: microchip: sparx5-cpu-syscon: Move to dedicated schema
      dt-bindings: soc: ti: am654-serdes-ctrl: Move to dedicated schema
      dt-bindings: mfd: mediatek,mt8195-scpsys: Add mediatek,mt8365-scpsys
      mfd: max14577: Fix Wvoid-pointer-to-enum-cast warning (again)
      mfd: mxs-lradc: Fix Wvoid-pointer-to-enum-cast warning (again)
      mfd: wm8994: Fix Wvoid-pointer-to-enum-cast warning (again)
      mfd: arizona: Simplify with spi_get_device_match_data()
      mfd: madera: Simplify with spi_get_device_match_data()
      dt-bindings: mfd: Explain lack of child dependency in simple-mfd
      dt-bindings: mfd: syscon: Split and enforce documenting MFD children
      dt-bindings: mfd: syscon: Add APM poweroff mailbox

Lee Jones (7):
      Merge branch 'ib-mfd-dt-soc-6.11' into ibs-for-mfd-merged
      Merge branch 'ib-mfd-firmware-input-sound-soc-6.11' into ibs-for-mfd-merged
      Merge branch 'ib-mfd-input-regulator-6.11' into ibs-for-mfd-merged
      Merge branch 'ib-mfd-leds-platform-6.11' into ibs-for-mfd-merged
      Merge branch 'ib-mfd-regulator-pm8008-6.11' into ibs-for-mfd-merged
      Merge branch 'ib-mfd-regulator-watchdog-6.11' into ibs-for-mfd-merged
      Merge branch 'ib-mfd-soc-samsung-6.11' into ibs-for-mfd-merged

Matti Vaittinen (7):
      dt-bindings: ROHM BD96801 PMIC regulators
      dt-bindings: mfd: bd96801 PMIC core
      mfd: support ROHM BD96801 PMIC core
      regulator: bd96801: ROHM BD96801 PMIC regulators
      watchdog: ROHM BD96801 PMIC WDG driver
      MAINTAINERS: Add ROHM BD96801 'scalable PMIC' entries
      watchdog: bd96801_wdt: Add missing include for FIELD_*()

Peter Griffin (2):
      mfd: syscon: Add of_syscon_register_regmap() API
      soc: samsung: exynos-pmu: update to use of_syscon_register_regmap()

Rob Herring (Arm) (1):
      dt-bindings: mfd: syscon: Add more simple compatibles

Simon Horman (1):
      mfd: idt8a340_reg: Start comments with '/*'

Thomas Weißschuh (11):
      leds: class: Warn about name collisions earlier
      leds: class: Add flag to avoid automatic renaming of LED devices
      platform/chrome: cros_kbd_led_backlight: allow binding through MFD
      mfd: cros_ec: Register keyboard backlight subdevice
      leds: core: Introduce led_get_color_name() function
      leds: multicolor: Use led_get_color_name() function
      leds: core: Unexport led_colors[] array
      leds: Add ChromeOS EC driver
      mfd: cros_ec: Register LED subdevice
      mfd: cros_ec: Register charge control subdevice
      mfd: cros_ec: Register hardware monitoring subdevice

Uwe Kleine-König (1):
      mfd: Drop explicit initialization of struct i2c_device_id::driver_data to 0

Wolfram Sang (6):
      mfd: tmio: Remove obsolete platform_data
      mfd: tmio: Remove obsolete io accessors
      mmc: tmio/sdhi: Fix includes
      mfd: tmio: Update include files
      mfd: tmio: Sanitize comments
      mfd: tmio: Move header to platform_data

Yang Li (1):
      mfd: tps6594-core: Remove unneeded semicolon in tps6594_check_crc_mode()

 .../devicetree/bindings/arm/amlogic/analog-top.txt |  20 -
 .../devicetree/bindings/arm/amlogic/assist.txt     |  17 -
 .../devicetree/bindings/arm/amlogic/bootrom.txt    |  17 -
 .../devicetree/bindings/arm/amlogic/pmu.txt        |  18 -
 .../devicetree/bindings/arm/atmel-sysregs.txt      |  29 -
 Documentation/devicetree/bindings/arm/axis.txt     |  16 -
 .../bindings/arm/cpu-enable-method/al,alpine-smp   |  10 -
 .../arm/freescale/fsl,vf610-mscm-cpucfg.txt        |  14 -
 .../bindings/arm/marvell/marvell,dove.txt          |  15 -
 .../devicetree/bindings/arm/spear-misc.txt         |   9 -
 .../bindings/clock/ti-keystone-pllctrl.txt         |  20 -
 .../devicetree/bindings/input/cirrus,cs40l50.yaml  |  68 ++
 .../bindings/mfd/marvell,88pm886-a1.yaml           |  76 ++
 .../bindings/mfd/mediatek,mt8195-scpsys.yaml       |   2 +
 Documentation/devicetree/bindings/mfd/mfd.txt      |  15 +-
 .../devicetree/bindings/mfd/qcom,pm8008.yaml       | 144 ++--
 .../devicetree/bindings/mfd/qcom,spmi-pmic.yaml    |   2 +
 .../devicetree/bindings/mfd/rockchip,rk809.yaml    | 288 -------
 .../devicetree/bindings/mfd/rockchip,rk817.yaml    |  70 +-
 .../devicetree/bindings/mfd/rohm,bd96801-pmic.yaml | 173 ++++
 .../devicetree/bindings/mfd/syscon-common.yaml     |  71 ++
 Documentation/devicetree/bindings/mfd/syscon.yaml  | 278 ++++---
 Documentation/devicetree/bindings/mips/mscc.txt    |  17 -
 .../devicetree/bindings/mtd/atmel-nand.txt         |   9 -
 .../bindings/net/hisilicon-hip04-net.txt           |  10 -
 .../bindings/regulator/rohm,bd96801-regulator.yaml |  63 ++
 .../bindings/soc/intel/intel,lgm-syscon.yaml       |  57 ++
 .../soc/microchip/microchip,sparx5-cpu-syscon.yaml |  49 ++
 .../bindings/soc/sprd/sprd,sc9863a-glbregs.yaml    |  55 ++
 .../bindings/soc/ti/ti,am654-serdes-ctrl.yaml      |  42 +
 MAINTAINERS                                        |  32 +-
 arch/sh/boards/board-sh7757lcr.c                   |   2 +-
 arch/sh/boards/mach-ap325rxa/setup.c               |   2 +-
 arch/sh/boards/mach-ecovec24/setup.c               |   2 +-
 arch/sh/boards/mach-kfr2r09/setup.c                |   2 +-
 arch/sh/boards/mach-migor/setup.c                  |   2 +-
 arch/sh/boards/mach-se/7724/setup.c                |   2 +-
 drivers/firmware/cirrus/cs_dsp.c                   | 278 +++++++
 drivers/input/misc/88pm886-onkey.c                 |  98 +++
 drivers/input/misc/Kconfig                         |  17 +
 drivers/input/misc/Makefile                        |   2 +
 drivers/input/misc/cs40l50-vibra.c                 | 555 +++++++++++++
 drivers/leds/Kconfig                               |  15 +
 drivers/leds/Makefile                              |   1 +
 drivers/leds/led-class-multicolor.c                |   2 +-
 drivers/leds/led-class.c                           |   9 +-
 drivers/leds/led-core.c                            |  12 +-
 drivers/leds/leds-cros_ec.c                        | 277 +++++++
 drivers/leds/leds.h                                |   1 -
 drivers/mfd/88pm800.c                              |   2 +-
 drivers/mfd/88pm805.c                              |   2 +-
 drivers/mfd/88pm860x-core.c                        |   2 +-
 drivers/mfd/88pm886.c                              | 148 ++++
 drivers/mfd/Kconfig                                |  56 ++
 drivers/mfd/Makefile                               |  12 +-
 drivers/mfd/aat2870-core.c                         |   2 +-
 drivers/mfd/act8945a.c                             |   2 +-
 drivers/mfd/arizona-core.c                         |   1 +
 drivers/mfd/arizona-spi.c                          |   9 +-
 drivers/mfd/as3722.c                               |   4 +-
 drivers/mfd/axp20x-i2c.c                           |  24 +-
 drivers/mfd/bd9571mwv.c                            |   2 +-
 drivers/mfd/cros_ec_dev.c                          |  20 +
 drivers/mfd/cs40l50-core.c                         | 570 +++++++++++++
 drivers/mfd/cs40l50-i2c.c                          |  68 ++
 drivers/mfd/cs40l50-spi.c                          |  68 ++
 drivers/mfd/da9055-i2c.c                           |   2 +-
 drivers/mfd/intel-lpss-pci.c                       | 162 ++--
 drivers/mfd/intel_soc_pmic_bxtwc.c                 |   1 +
 drivers/mfd/intel_soc_pmic_crc.c                   |   4 +-
 drivers/mfd/lm3533-core.c                          |  28 +-
 drivers/mfd/lp3943.c                               |   2 +-
 drivers/mfd/lp873x.c                               |   4 +-
 drivers/mfd/lp87565.c                              |   4 +-
 drivers/mfd/lp8788.c                               |   2 +-
 drivers/mfd/madera-spi.c                           |   9 +-
 drivers/mfd/max14577.c                             |   2 +-
 drivers/mfd/max8907.c                              |   2 +-
 drivers/mfd/max8925-i2c.c                          |   4 +-
 drivers/mfd/menelaus.c                             |   3 +-
 drivers/mfd/mfd-core.c                             |   6 +-
 drivers/mfd/mt6397-core.c                          |  10 +
 drivers/mfd/mxs-lradc.c                            |   2 +-
 drivers/mfd/omap-usb-host.c                        |   1 -
 drivers/mfd/omap-usb-tll.c                         |   7 +-
 drivers/mfd/pcf50633-gpio.c                        |   1 +
 drivers/mfd/qcom-pm8008.c                          | 170 ++--
 drivers/mfd/retu-mfd.c                             |   4 +-
 drivers/mfd/rohm-bd96801.c                         | 273 +++++++
 drivers/mfd/rsmu_core.c                            |   2 +
 drivers/mfd/rt4831.c                               |   1 +
 drivers/mfd/ssbi.c                                 |   1 +
 drivers/mfd/stw481x.c                              |   4 +-
 drivers/mfd/syscon.c                               |  48 ++
 drivers/mfd/timberdale.c                           |  18 +-
 drivers/mfd/tps6105x.c                             |   4 +-
 drivers/mfd/tps6507x.c                             |   2 +-
 drivers/mfd/tps65086.c                             |   2 +-
 drivers/mfd/tps65090.c                             |   4 +-
 drivers/mfd/tps6586x.c                             |   4 +-
 drivers/mfd/tps65912-core.c                        |  21 +-
 drivers/mfd/tps65912-i2c.c                         |  10 +-
 drivers/mfd/tps65912-spi.c                         |   8 -
 drivers/mfd/tps6594-core.c                         |   2 +-
 drivers/mfd/twl6040.c                              |   6 +-
 drivers/mfd/vexpress-sysreg.c                      |   1 +
 drivers/mfd/wl1273-core.c                          |   2 +-
 drivers/mfd/wm8350-i2c.c                           |   6 +-
 drivers/mfd/wm8400-core.c                          |   2 +-
 drivers/mfd/wm8994-core.c                          |   2 +-
 drivers/mmc/host/renesas_sdhi_core.c               |   2 +-
 drivers/mmc/host/renesas_sdhi_internal_dmac.c      |   5 +-
 drivers/mmc/host/renesas_sdhi_sys_dmac.c           |   5 +-
 drivers/mmc/host/tmio_mmc_core.c                   |   3 +-
 drivers/mmc/host/uniphier-sd.c                     |   2 +-
 drivers/platform/chrome/Kconfig                    |   2 +-
 drivers/platform/chrome/cros_kbd_led_backlight.c   |  40 +-
 drivers/regulator/88pm886-regulator.c              | 392 +++++++++
 drivers/regulator/Kconfig                          |  25 +
 drivers/regulator/Makefile                         |   3 +
 drivers/regulator/bd96801-regulator.c              | 908 +++++++++++++++++++++
 drivers/regulator/qcom-pm8008-regulator.c          | 198 +++++
 drivers/soc/samsung/exynos-pmu.c                   |  38 +-
 drivers/watchdog/Kconfig                           |  13 +
 drivers/watchdog/Makefile                          |   1 +
 drivers/watchdog/bd96801_wdt.c                     | 417 ++++++++++
 include/dt-bindings/mfd/qcom-pm8008.h              |  19 -
 include/dt-bindings/mfd/st,stpmic1.h               |   2 +-
 include/linux/firmware/cirrus/cs_dsp.h             |  27 +
 include/linux/leds.h                               |  11 +
 include/linux/mfd/88pm886.h                        |  69 ++
 include/linux/mfd/cs40l50.h                        | 137 ++++
 include/linux/mfd/idt8a340_reg.h                   |   8 +-
 include/linux/mfd/lm3533.h                         |   5 +-
 include/linux/mfd/rohm-bd96801.h                   | 215 +++++
 include/linux/mfd/rohm-generic.h                   |   1 +
 include/linux/mfd/syscon.h                         |   8 +
 include/linux/mfd/tmio.h                           | 133 ---
 include/linux/mfd/tps65912.h                       |   1 -
 include/linux/platform_data/tmio.h                 |  64 ++
 sound/soc/codecs/Kconfig                           |  11 +
 sound/soc/codecs/Makefile                          |   2 +
 sound/soc/codecs/cs40l50-codec.c                   | 307 +++++++
 143 files changed, 6720 insertions(+), 1184 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/amlogic/analog-top.txt
 delete mode 100644 Documentation/devicetree/bindings/arm/amlogic/assist.txt
 delete mode 100644 Documentation/devicetree/bindings/arm/amlogic/bootrom.txt
 delete mode 100644 Documentation/devicetree/bindings/arm/amlogic/pmu.txt
 delete mode 100644 Documentation/devicetree/bindings/arm/freescale/fsl,vf610-mscm-cpucfg.txt
 delete mode 100644 Documentation/devicetree/bindings/arm/spear-misc.txt
 delete mode 100644 Documentation/devicetree/bindings/clock/ti-keystone-pllctrl.txt
 create mode 100644 Documentation/devicetree/bindings/input/cirrus,cs40l50.yaml
 create mode 100644 Documentation/devicetree/bindings/mfd/marvell,88pm886-a1.yaml
 delete mode 100644 Documentation/devicetree/bindings/mfd/rockchip,rk809.yaml
 create mode 100644 Documentation/devicetree/bindings/mfd/rohm,bd96801-pmic.yaml
 create mode 100644 Documentation/devicetree/bindings/mfd/syscon-common.yaml
 create mode 100644 Documentation/devicetree/bindings/regulator/rohm,bd96801-regulator.yaml
 create mode 100644 Documentation/devicetree/bindings/soc/intel/intel,lgm-syscon.yaml
 create mode 100644 Documentation/devicetree/bindings/soc/microchip/microchip,sparx5-cpu-syscon.yaml
 create mode 100644 Documentation/devicetree/bindings/soc/sprd/sprd,sc9863a-glbregs.yaml
 create mode 100644 Documentation/devicetree/bindings/soc/ti/ti,am654-serdes-ctrl.yaml
 create mode 100644 drivers/input/misc/88pm886-onkey.c
 create mode 100644 drivers/input/misc/cs40l50-vibra.c
 create mode 100644 drivers/leds/leds-cros_ec.c
 create mode 100644 drivers/mfd/88pm886.c
 create mode 100644 drivers/mfd/cs40l50-core.c
 create mode 100644 drivers/mfd/cs40l50-i2c.c
 create mode 100644 drivers/mfd/cs40l50-spi.c
 create mode 100644 drivers/mfd/rohm-bd96801.c
 create mode 100644 drivers/regulator/88pm886-regulator.c
 create mode 100644 drivers/regulator/bd96801-regulator.c
 create mode 100644 drivers/regulator/qcom-pm8008-regulator.c
 create mode 100644 drivers/watchdog/bd96801_wdt.c
 delete mode 100644 include/dt-bindings/mfd/qcom-pm8008.h
 create mode 100644 include/linux/mfd/88pm886.h
 create mode 100644 include/linux/mfd/cs40l50.h
 create mode 100644 include/linux/mfd/rohm-bd96801.h
 delete mode 100644 include/linux/mfd/tmio.h
 create mode 100644 include/linux/platform_data/tmio.h
 create mode 100644 sound/soc/codecs/cs40l50-codec.c

-- 
Lee Jones [李琼斯]

