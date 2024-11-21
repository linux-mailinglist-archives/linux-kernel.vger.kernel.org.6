Return-Path: <linux-kernel+bounces-416964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D54C19D4D08
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 13:40:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B566B2251C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 12:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C90E51D799D;
	Thu, 21 Nov 2024 12:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="spt+K9LB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0741D47C0
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 12:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732192824; cv=none; b=gtJ92+dqMhkUGvrXdC7F9zZfgykObMjPRn6sch+s09eH4IiYshdH3LAzpW9JQFPLsMPdGcV4pBUNAqh1L+MoIswbQhWM/v1JRgpNkyyPE9hrxZWnhUrnqmq5csvXw4769Yc7KaeEZaqiHrKpnstiIJey9vKNNGR0yavokf16FCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732192824; c=relaxed/simple;
	bh=8ELcMJnEaMv4VsLTx4vhxvj4ANoM6ePiojsCsDdJ5Cc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=pTCmc83DB+ilFUfHlpOTNBWd/BzycizE53BZls42L9tNxVYjxyRkoYTb2zKCUjTfY+ZudjIFAF8BMAWqh60VWx/JGtV+fSJjEZUj2x5K6TXhe67PFEOJDGGkt1l407d0icvOkY6UYt5GPigMHGAF8vGeTcT5Y7rSLich+JHZ2eY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=spt+K9LB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7110EC4CECC;
	Thu, 21 Nov 2024 12:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732192824;
	bh=8ELcMJnEaMv4VsLTx4vhxvj4ANoM6ePiojsCsDdJ5Cc=;
	h=Date:From:To:Cc:Subject:From;
	b=spt+K9LBUzef+QSAmPvHfe2/tI+mb64GmpNdlnjJJKdqSCU4Oy6dUDNhgAik9O3r8
	 tMEbo8l1HtVRdxaduE3iXNnuSW49OertGba6HDF9TnM3U4A3FZ5X4aieQiVlqU/DCJ
	 24uWefAhTQvlG8HazRQZJ5MItz3g86vBqDbDjIV+xLZMIwLVx13QkPyiyQobVsqN0O
	 Ogty1qG586DEU35uhcU+DI2xCOpGVmCKFPBJo9UM8U5VNh1cQq9piszv8SlxqB+teV
	 sKlPmwrfdvoDHjquRYVaywCVHbE+cyVUvnBZ9kN3ZzWslEr2ghPAVpGyyxV6y3F2Z1
	 mdCPtRWs8g3SQ==
Date: Thu, 21 Nov 2024 12:40:20 +0000
From: Lee Jones <lee@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] MFD for v6.13
Message-ID: <20241121124020.GA7052@google.com>
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

The following changes since commit 9852d85ec9d492ebef56dc5f229416c925758edc:

  Linux 6.12-rc1 (2024-09-29 15:06:19 -0700)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git tags/mfd-next-6.13

for you to fetch changes up to 8ece9d248b851b97e1e0779caa2ca98df9bc41f7:

  dt-bindings: mfd: bd71828: Use charger resistor in mOhm instead of MOhm (2024-11-12 15:06:33 +0000)

----------------------------------------------------------------
- Several drivers, including atmel-flexcom/rk8xx-core, palmas, and
  tps65010, have undergone minor code improvements to enhance consistency and
  fix race conditions.

- The syscon driver now utilizes the regmap max_register_is_0 capability
  for consistent register map configuration across syscons of all sizes.

- New device support has been added for QCS8300, qcs615, SA8255p, and
  samsung,s2dos05, expanding the range of compatible hardware.

- The cros_ec driver now supports loading cros_ec_ucsi on supported ECs
  and avoids loading the charger with UCSI, streamlining functionality.

- The bd96801 driver now utilizes the more modern maple tree register
  cache, improving performance.

- The da9052-spi driver has undergone a fix to change the read-mask to
  write-mask, preventing potential issues.

- Unused declarations in max77693 have been removed, and support for
  samsung,s2dos05 has been added, enhancing code clarity and device compatibility.

- Error handling in cs42l43 has been fixed to avoid unbalanced regulator
  put and ensure proper synchronization during driver removal.

- The wcd934x driver now uses MODULE_DEVICE_TABLE() instead of
  MODULE_ALIAS(), improving code consistency.

- Documentation for qcom,tcsr, syscon, and atmel-smc has been updated
  and reorganized for better clarity and maintainability.

- The intel_soc_pmic_bxtwc driver has undergone significant improvements,
  including the use of IRQ domains for various devices, fixing IRQ domain names
  duplication, and code refactoring for better consistency and maintainability.

- The ipaq-micro driver has received a fix for a missing break statement in
  the default case, enhancing code robustness.

- Support for the AXP323 PMIC has been added to the axp20x driver, along
  with ensuring a clear relationship between IDs and model names, and allowing
  multiple regulators, broadening hardware compatibility.

- The cs42l43 driver now disables IRQs during suspend for improved power
  management.

- The adp5585 driver has reduced its dependencies by dropping the obsolete
  dependency on COMPILE_TEST.

- Initial support for the MT6328 PMIC has been added to the mt6397 driver,
  expanding the range of supported hardware.

- The rtc-bd70528 driver has been simplified by dropping the IC name from
  IRQ, improving code readability.

- Documentation for qcom,spmi-pmic, ti,twl, and zii,rave-sp has been
  updated to enhance clarity and incorporate new features.

- The rt5033 driver has received a fix for a missing regmap_del_irq_chip()
  in the error handling path.

- New device support has been added for MSM8917, and the
  intel_soc_pmic_crc driver now supports non-ACPI instantiated i2c_client.

- The 88pm886 driver has added support for the RTC cell, and the tqmx86
  driver has improved its GPIO IRQ setup and added I2C IRQ support,
  increasing functionality.

- The sprd,sc2731 DT schema has been updated and converted to YAML format
  for better readability and maintainability.

----------------------------------------------------------------
Abhishek Pandit-Subedi (1):
      mfd: cros_ec: Don't load charger with UCSI

Andre Przywara (5):
      dt-bindings: mfd: x-powers,axp152: Document AXP323
      mfd: axp20x: Ensure relationship between IDs and model names
      mfd: axp20x: Allow multiple regulators
      mfd: axp20x: Add support for AXP323
      regulator: axp20x: add support for the AXP323

Andreas Kemnade (3):
      dt-bindings: mfd: twl: Add charger node also for TWL603x
      mfd: twl-core: Add a clock subdevice for the TWL6030
      dt-bindings: mfd: bd71828: Use charger resistor in mOhm instead of MOhm

Andy Shevchenko (9):
      mfd: intel_soc_pmic_bxtwc: Use IRQ domain for USB Type-C device
      mfd: intel_soc_pmic_bxtwc: Use IRQ domain for TMU device
      mfd: intel_soc_pmic_bxtwc: Use IRQ domain for PMIC devices
      mfd: intel_soc_pmic_bxtwc: Fix IRQ domain names duplication
      mfd: intel_soc_pmic_bxtwc: Switch to use ATTRIBUTE_GROUPS()
      mfd: intel_soc_pmic_bxtwc: Don't use "proxy" headers
      mfd: intel_soc_pmic_bxtwc: Use temporary variable for struct device
      mfd: intel_soc_pmic_bxtwc: Deduplicate error messages
      mfd: ipaq-micro: Add missing break for the default case

AngeloGioacchino Del Regno (1):
      dt-bindings: mfd: mediatek: mt6397: Add start-year property to RTC

Barnabás Czémán (1):
      dt-bindings: mfd: qcom,tcsr: Add compatible for MSM8917

Charles Keepax (2):
      mfd: cs42l43: Fix issues in probe error paths
      mfd: cs42l43: Disable IRQs during suspend

Chris Packham (1):
      dt-bindings: mfd: Add Realtek RTL9300 switch peripherals

Christophe JAILLET (1):
      mfd: cgbc-core: Fix error handling paths in cgbc_init_device()

Conor Dooley (1):
      dt-bindings: mfd: syscon: Document the non simple-mfd syscon on PolarFire SoC

Dragan Simic (1):
      mfd: rk8xx-core: Check "system-power-controller" first

Dzmitry Sankouski (3):
      mfd: max77693: Remove unused max77693_irq_source declarations
      dt-bindings: mfd: Add support for the samsung,s2dos05
      mfd: sec-core: Add support for the Samsung s2dos05

Frank Li (1):
      dt-bindings: mfd: Convert zii,rave-sp.txt to yaml format

Gregor Herburger (1):
      mfd: tqmx86: Add I2C IRQ support

Hans de Goede (2):
      mfd: intel_soc_pmic_*: Consistently use filename as driver name
      mfd: intel_soc_pmic_crc: Add support for non ACPI instantiated i2c_client

Jean Delvare (1):
      mfd: adp5585: Drop obsolete dependency on COMPILE_TEST

Jingyi Wang (1):
      dt-bindings: mfd: qcom,tcsr: Add compatible for QCS8300

Jinjie Ruan (1):
      mfd: tps65010: Use IRQF_NO_AUTOEN flag in request_irq() to fix race

Jishnu Prakash (1):
      dt-bindings: mfd: qcom,spmi-pmic: Document PMICs added in SM8750

Julia Lawall (1):
      mfd: atmel-smc: Reorganize kerneldoc parameter names

Karel Balej (1):
      mfd: 88pm886: Add the RTC cell

Krzysztof Kozlowski (1):
      mfd: palmas: Constify strings with regulator names

Lee Jones (1):
      Merge branches 'ib-dt-mfd-input-leds-power-rtc-6.13' and 'ib-mfd-gpio-i2c-watchdog-6.13' into ibs-for-mfd-merged

Macpaul Lin (2):
      dt-bindings: mfd: mediatek: mt6397: Convert to DT schema format
      dt-bindings: mfd: mediatek: mt6397: Add ADC, CODEC and Regulators for MT6359

Marcus Folkesson (1):
      mfd: da9052-spi: Change read-mask to write-mask

Mark Brown (1):
      mfd: bd96801: Use maple tree register cache

Masahiro Yamada (1):
      mfd: wcd934x: Replace MODULE_ALIAS() with MODULE_DEVICE_TABLE()

Matthias Schiffer (4):
      mfd: tqmx86: Add board definitions for TQMx120UC, TQMx130UC and TQMxE41S
      mfd: tqmx86: Improve gpio_irq module parameter description
      mfd: tqmx86: Refactor GPIO IRQ setup
      mfd: tqmx86: Make IRQ setup errors non-fatal

Matti Vaittinen (2):
      mfd: bd96801: Add ERRB IRQ
      mfd: rtc: bd7xxxx Drop IC name from IRQ

Nikunj Kela (1):
      dt-bindings: mfd: qcom,tcsr: Document support for SA8255p

Nishanth Menon (1):
      mfd: syscon: Use regmap max_register_is_0 as needed

Pavan Holla (2):
      mfd: cros_ec: Load cros_ec_ucsi on supported ECs
      platform/chrome: Update EC feature flags

Ryan Chen (1):
      dt-bindings: mfd: aspeed: Support for AST2700

Shen Lichuan (1):
      mfd: atmel-flexcom/rk8xx-core: Convert comma to semicolon

Stanislav Jakubek (1):
      dt-bindings: mfd: sprd,sc2731: Convert to YAML

Thomas Richard (5):
      mfd: Add Congatec Board Controller driver
      gpio: Congatec Board Controller gpio driver
      i2c: Congatec Board Controller i2c bus driver
      watchdog: Congatec Board Controller watchdog timer driver
      MAINTAINERS: Add entry for Congatec Board Controller

Uwe Kleine-König (1):
      mfd: Switch back to struct platform_driver::remove()

Yassine Oudjana (1):
      mfd: mt6397: Add initial support for MT6328

Zhang Changzhong (1):
      mfd: rt5033: Fix missing regmap_del_irq_chip()

lijuang (1):
      dt-bindings: mfd: qcom,tcsr: Add compatible for qcs615

 .../bindings/iio/adc/sprd,sc2720-adc.yaml          |  17 -
 .../bindings/input/mediatek,pmic-keys.yaml         |   2 +-
 .../devicetree/bindings/leds/leds-mt6323.txt       |  63 --
 .../devicetree/bindings/leds/sprd,sc2731-bltc.yaml |  31 -
 .../bindings/mfd/aspeed,ast2x00-scu.yaml           |   8 +-
 .../devicetree/bindings/mfd/mediatek,mt6397.yaml   | 598 +++++++++++++++
 Documentation/devicetree/bindings/mfd/mt6397.txt   | 110 ---
 .../devicetree/bindings/mfd/qcom,spmi-pmic.yaml    |   2 +
 .../devicetree/bindings/mfd/qcom,tcsr.yaml         |   4 +
 .../bindings/mfd/realtek,rtl9301-switch.yaml       | 114 +++
 .../devicetree/bindings/mfd/rohm,bd71828-pmic.yaml |  13 +-
 .../devicetree/bindings/mfd/samsung,s2dos05.yaml   |  99 +++
 .../devicetree/bindings/mfd/sprd,sc2731.yaml       | 252 +++++++
 .../devicetree/bindings/mfd/sprd,sc27xx-pmic.txt   |  40 -
 Documentation/devicetree/bindings/mfd/syscon.yaml  |   2 +
 Documentation/devicetree/bindings/mfd/ti,twl.yaml  |  32 +-
 .../devicetree/bindings/mfd/x-powers,axp152.yaml   |   3 +
 .../devicetree/bindings/mfd/zii,rave-sp.txt        |  39 -
 .../devicetree/bindings/mfd/zii,rave-sp.yaml       |  63 ++
 .../bindings/power/reset/mt6323-poweroff.txt       |  20 -
 .../bindings/power/supply/sc2731-charger.yaml      |  21 +-
 .../bindings/power/supply/sc27xx-fg.yaml           |  38 +-
 .../bindings/regulator/sprd,sc2731-regulator.yaml  |  21 -
 .../devicetree/bindings/rtc/rtc-mt6397.txt         |  31 -
 .../devicetree/bindings/rtc/sprd,sc2731-rtc.yaml   |  16 -
 MAINTAINERS                                        |  19 +-
 drivers/gpio/Kconfig                               |  10 +
 drivers/gpio/Makefile                              |   1 +
 drivers/gpio/gpio-cgbc.c                           | 196 +++++
 drivers/i2c/busses/Kconfig                         |  10 +
 drivers/i2c/busses/Makefile                        |   1 +
 drivers/i2c/busses/i2c-cgbc.c                      | 406 ++++++++++
 drivers/mfd/88pm886.c                              |   1 +
 drivers/mfd/Kconfig                                |  14 +-
 drivers/mfd/Makefile                               |   1 +
 drivers/mfd/ab8500-sysctrl.c                       |   2 +-
 drivers/mfd/atmel-flexcom.c                        |   2 +-
 drivers/mfd/atmel-smc.c                            |   4 +-
 drivers/mfd/axp20x-i2c.c                           |   1 +
 drivers/mfd/axp20x.c                               |  58 +-
 drivers/mfd/cgbc-core.c                            | 420 +++++++++++
 drivers/mfd/cros_ec_dev.c                          |  27 +-
 drivers/mfd/cs42l43.c                              |  65 +-
 drivers/mfd/da9052-spi.c                           |   2 +-
 drivers/mfd/exynos-lpass.c                         |   4 +-
 drivers/mfd/fsl-imx25-tsadc.c                      |   2 +-
 drivers/mfd/hi655x-pmic.c                          |   8 +-
 drivers/mfd/intel-lpss-acpi.c                      |   2 +-
 drivers/mfd/intel_soc_pmic_bxtwc.c                 | 177 +++--
 drivers/mfd/intel_soc_pmic_chtwc.c                 |   2 +-
 drivers/mfd/intel_soc_pmic_crc.c                   |   9 +-
 drivers/mfd/ipaq-micro.c                           |   1 +
 drivers/mfd/kempld-core.c                          |   2 +-
 drivers/mfd/mcp-sa11x0.c                           |   2 +-
 drivers/mfd/mt6397-core.c                          |  32 +
 drivers/mfd/mt6397-irq.c                           |  23 +
 drivers/mfd/mxs-lradc.c                            |   2 +-
 drivers/mfd/omap-usb-host.c                        |   2 +-
 drivers/mfd/omap-usb-tll.c                         |   2 +-
 drivers/mfd/pcf50633-adc.c                         |   2 +-
 drivers/mfd/qcom-pm8xxx.c                          |   2 +-
 drivers/mfd/rk8xx-core.c                           |   6 +-
 drivers/mfd/rohm-bd71828.c                         |  12 +-
 drivers/mfd/rohm-bd96801.c                         | 277 ++++++-
 drivers/mfd/rt5033.c                               |   4 +-
 drivers/mfd/sec-core.c                             |  11 +
 drivers/mfd/sm501.c                                |   2 +-
 drivers/mfd/stm32-timers.c                         |   2 +-
 drivers/mfd/syscon.c                               |   5 +
 drivers/mfd/ti_am335x_tscadc.c                     |   2 +-
 drivers/mfd/tps65010.c                             |   8 +-
 drivers/mfd/tps65911-comparator.c                  |   2 +-
 drivers/mfd/tqmx86.c                               | 115 ++-
 drivers/mfd/twl-core.c                             |  26 +-
 drivers/mfd/twl4030-audio.c                        |   2 +-
 drivers/mfd/wcd934x.c                              |   2 +-
 drivers/platform/x86/intel/bxtwc_tmu.c             |  22 +-
 drivers/regulator/axp20x-regulator.c               |  13 +-
 drivers/rtc/rtc-bd70528.c                          |   5 +-
 drivers/usb/typec/tcpm/wcove.c                     |   4 -
 drivers/watchdog/Kconfig                           |  10 +
 drivers/watchdog/Makefile                          |   1 +
 drivers/watchdog/cgbc_wdt.c                        | 211 ++++++
 include/dt-bindings/clock/aspeed,ast2700-scu.h     | 163 ++++
 include/dt-bindings/reset/aspeed,ast2700-scu.h     | 124 ++++
 include/linux/mfd/axp20x.h                         |   4 +-
 include/linux/mfd/cgbc.h                           |  44 ++
 include/linux/mfd/max77693-private.h               |  11 -
 include/linux/mfd/mt6328/core.h                    |  53 ++
 include/linux/mfd/mt6328/registers.h               | 822 +++++++++++++++++++++
 include/linux/mfd/mt6397/core.h                    |  11 +-
 include/linux/mfd/palmas.h                         |   4 +-
 include/linux/mfd/samsung/core.h                   |   1 +
 include/linux/platform_data/cros_ec_commands.h     |  32 +
 sound/soc/codecs/cs42l43.c                         |  42 --
 95 files changed, 4442 insertions(+), 764 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/leds/leds-mt6323.txt
 create mode 100644 Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml
 delete mode 100644 Documentation/devicetree/bindings/mfd/mt6397.txt
 create mode 100644 Documentation/devicetree/bindings/mfd/realtek,rtl9301-switch.yaml
 create mode 100644 Documentation/devicetree/bindings/mfd/samsung,s2dos05.yaml
 create mode 100644 Documentation/devicetree/bindings/mfd/sprd,sc2731.yaml
 delete mode 100644 Documentation/devicetree/bindings/mfd/sprd,sc27xx-pmic.txt
 delete mode 100644 Documentation/devicetree/bindings/mfd/zii,rave-sp.txt
 create mode 100644 Documentation/devicetree/bindings/mfd/zii,rave-sp.yaml
 delete mode 100644 Documentation/devicetree/bindings/power/reset/mt6323-poweroff.txt
 delete mode 100644 Documentation/devicetree/bindings/rtc/rtc-mt6397.txt
 create mode 100644 drivers/gpio/gpio-cgbc.c
 create mode 100644 drivers/i2c/busses/i2c-cgbc.c
 create mode 100644 drivers/mfd/cgbc-core.c
 create mode 100644 drivers/watchdog/cgbc_wdt.c
 create mode 100644 include/dt-bindings/clock/aspeed,ast2700-scu.h
 create mode 100644 include/dt-bindings/reset/aspeed,ast2700-scu.h
 create mode 100644 include/linux/mfd/cgbc.h
 create mode 100644 include/linux/mfd/mt6328/core.h
 create mode 100644 include/linux/mfd/mt6328/registers.h

-- 
Lee Jones [李琼斯]

