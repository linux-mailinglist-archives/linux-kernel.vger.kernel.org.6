Return-Path: <linux-kernel+bounces-336051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90A0E97EE81
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 17:49:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FB1A1F2276C
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 15:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF32619C578;
	Mon, 23 Sep 2024 15:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pDIMwsBi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 108A2198857
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 15:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727106558; cv=none; b=MNTOdJLg9XF0SlcQPYHbMS9Um4t+n+ZXwi6KGU/DRQsNt/0AFEQe37Hb06iI1jojxtNFRzgfD7nA0CuT4+AW/YKYhPvZJEcKQWJr2HrHGCg6Edf0n+ljBMxMTQEFWx9UCIoLcIUuS9FciPWhuThr3ttu/R8MyrGk1jqEZx+VJjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727106558; c=relaxed/simple;
	bh=xhyeYLYCAD6s2OD7CpEwaawWTa2/Lyk9MTKGGbg4rPc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=WVofHhs9pOjIoRgfSBmt7D9EMXkKubFhf+pLcc8seaj2RUPsvVmsvSmjHrCkN2NtUgWzscjnuDwQViY6HuowMuK26bXMwjHlaLQBvGlgA9VL0tNaMJFxnSZfgCCSUA5GgpiKSxH7g4YkcVpV8HGWfgZ972BIqihmojmhXReOq3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pDIMwsBi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E76FDC4CEC4;
	Mon, 23 Sep 2024 15:49:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727106557;
	bh=xhyeYLYCAD6s2OD7CpEwaawWTa2/Lyk9MTKGGbg4rPc=;
	h=Date:From:To:Cc:Subject:From;
	b=pDIMwsBix9zbF8g/jrdgfCM6YOt9t913M5duRsqv15lGoRssXRb/DvlrmMbfkzIIW
	 s/W3Mt+xgI7g5ufNhxdz+OFZkVI55laiI6Sm8MhkiMrbyxsOWczSi5wWBG3oo5SDD3
	 t771/FWxFQCCOaaSwjfgwrhjcq+sPUOcdyCFnzQj0WSgXGdJOdxucvIKG5I9/sKwGR
	 Yz0usOJ/V771mONUgAd3e11SFQZmo/zvySoYo2lGURqZply6HSWsfY0PM2gC8/xiz2
	 nQ16li4nksHYuo3SNkyQ6w6L7PoGnn/LxOf8tCealJ0YLLQ/hghcuqyvNuuc08yhU/
	 NHR+p81ENsdQQ==
Date: Mon, 23 Sep 2024 16:49:13 +0100
From: Lee Jones <lee@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] MFD for v6.12
Message-ID: <20240923154913.GA7545@google.com>
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

The following changes since commit 8400291e289ee6b2bf9779ff1c83a291501f017b:

  Linux 6.11-rc1 (2024-07-28 14:19:55 -0700)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git tags/mfd-next-6.12

for you to fetch changes up to 91dba615c3431daf0132349812f6adc83e123eaf:

  mfd: atc260x: Convert a bunch of commas to semicolons (2024-09-23 16:20:55 +0100)

----------------------------------------------------------------
- Added support for the Analog Devices ADP5585 GPIO and PWM functions.
- Added parsing of GPIO hogs for the ADP5585.
- Fixed module autoloading in the MAX14577 driver.
- Simplified and cleaned up the CROS_EC driver.
- Made the Lenovo Yoga Tab 3 X90F DMI match less strict in the INTEL_SOC_PMIC_CHTWC driver.
- Added support for the RK806 PMIC on the I2C bus.
- Removed the remaining header file for the DS1WM driver.
- Added compatible strings for various devices in the device tree bindings.
- Fixed a comma-related issue in the 88PM860X_CORE driver.
- Constified read-only regmap structs in various drivers.
- Used scoped variables with memory allocators to simplify error paths in the MT6360 and SYSCON drivers.
- Added Intel Arrow Lake-H and Panther Lake LPSS PCI IDs.

----------------------------------------------------------------
Chen Ni (2):
      mfd: 88pm860x-core: Convert comma to semicolon
      mfd: atc260x: Convert a bunch of commas to semicolons

Chris Morgan (1):
      mfd: axp20x: Add ADC, BAT, and USB cells for AXP717

Clark Wang (1):
      pwm: adp5585: Add Analog Devices ADP5585 support

Detlev Casanova (2):
      mfd: rk8xx: Add support for rk806 on i2c bus
      dt-bindings: mfd: syscon: Add rk3576 QoS register compatible

Haibo Chen (3):
      mfd: adp5585: Add Analog Devices ADP5585 core support
      gpio: adp5585: Add Analog Devices ADP5585 support
      dt-bindings: mfd: adp5585: Add parsing of hogs

Hans de Goede (1):
      mfd: intel_soc_pmic_chtwc: Make Lenovo Yoga Tab 3 X90F DMI match less strict

Ilpo Järvinen (2):
      mfd: intel-lpss: Add Intel Arrow Lake-H LPSS PCI IDs
      mfd: intel-lpss: Add Intel Panther Lake LPSS PCI IDs

Javier Carrasco (24):
      mfd: da9062-core: Constify read-only regmap structs
      mfd: fsl-imx25-tsadc: Constify struct regmap_config
      mfd: hi655x-pmic: Constify struct regmap_config
      mfd: wcd934x: Constify struct regmap_config
      mfd: tps6105x: Constify struct regmap_config
      mfd: rohm-bd9576: Constify read-only regmap structs
      mfd: intel-m10-bmc: Constify struct regmap_config
      mfd: 88pm80x: Constify read-only regmap structs
      mfd: bd9571mwv: Constify struct regmap_irq_chip
      mfd: intel_soc_pmic_bxtwc: Constify struct regmap_irq_chip
      mfd: retu: Constify read-only regmap structs
      mfd: rk8xx-core: Constify struct regmap_irq_chip
      mfd: rohm-bd71828: Constify read-only regmap structs
      mfd: rohm-bd718x7: Constify struct regmap_irq_chip
      mfd: tps65086: Constify struct regmap_irq_chip
      mfd: tps65090: Constify struct regmap_irq_chip
      mfd: tps65218: Constify struct regmap_irq_chip
      mfd: tps65219: Constify read-only regmap structs
      mfd: tps65910: Constify struct regmap_irq_chip
      mfd: tps65912: Constify struct regmap_irq_chip
      mfd: twl6040: Constify struct regmap_irq_chip
      mfd: gateworks-gsc: Constify struct regmap_bus
      mfd: mc13xxx-spi: Constify struct regmap_bus
      mfd: sprd-sc27xx-spi: Constify struct regmap_bus

Jinjie Ruan (2):
      mfd: max77620: Use for_each_child_of_node_scoped()
      mfd: qcom-spmi-pmic: Use for_each_child_of_node_scoped()

Krzysztof Kozlowski (2):
      mfd: mt6360: Use scoped variables with memory allocators to simplify error paths
      mfd: syscon: Use scoped variables with memory allocators to simplify error paths

Laurent Pinchart (1):
      dt-bindings: mfd: Add Analog Devices ADP5585

Lee Jones (1):
      Merge branches 'ib-mfd-for-iio-power-6.12' and 'ib-mfd-gpio-pwm-6.12' into ibs-for-mfd-merged

Liao Chen (1):
      mfd: max14577: Provide MODULE_DEVICE_TABLE() to fix module autoloading

Lukas Bulwahn (1):
      MAINTAINERS: Repair file entry in MARVELL 88PM886 PMIC DRIVER

Mukesh Ojha (1):
      dt-bindings: mfd: qcom,tcsr: Add compatible for sa8775p

Rob Herring (Arm) (1):
      mfd: tc3589x: Drop vendorless compatible string from match table

Siddharth Vadapalli (1):
      dt-bindings: mfd: syscon: Add ti,j784s4-acspcie-proxy-ctrl compatible

Tzung-Bi Shih (2):
      mfd: cros_ec: Simplify and clean-up cros_ec_dev_init()
      mfd: cros_ec: Update module description

Wilken Gottwalt (1):
      mfd: ds1wm: Remove remaining header file

 .../devicetree/bindings/mfd/adi,adp5585.yaml       |  99 +++++++++
 .../devicetree/bindings/mfd/qcom,tcsr.yaml         |   1 +
 Documentation/devicetree/bindings/mfd/syscon.yaml  |   3 +
 .../devicetree/bindings/trivial-devices.yaml       |   4 -
 MAINTAINERS                                        |  13 +-
 drivers/gpio/Kconfig                               |   7 +
 drivers/gpio/Makefile                              |   1 +
 drivers/gpio/gpio-adp5585.c                        | 229 +++++++++++++++++++++
 drivers/mfd/88pm800.c                              |   2 +-
 drivers/mfd/88pm805.c                              |   4 +-
 drivers/mfd/88pm860x-core.c                        |  10 +-
 drivers/mfd/Kconfig                                |  12 ++
 drivers/mfd/Makefile                               |   1 +
 drivers/mfd/adp5585.c                              | 205 ++++++++++++++++++
 drivers/mfd/atc260x-core.c                         |   4 +-
 drivers/mfd/axp20x.c                               |  25 ++-
 drivers/mfd/bd9571mwv.c                            |   4 +-
 drivers/mfd/cros_ec_dev.c                          |  15 +-
 drivers/mfd/da9062-core.c                          |  12 +-
 drivers/mfd/fsl-imx25-tsadc.c                      |   2 +-
 drivers/mfd/gateworks-gsc.c                        |   2 +-
 drivers/mfd/hi655x-pmic.c                          |   2 +-
 drivers/mfd/intel-lpss-pci.c                       |  39 ++++
 drivers/mfd/intel-m10-bmc-pmci.c                   |   2 +-
 drivers/mfd/intel-m10-bmc-spi.c                    |   2 +-
 drivers/mfd/intel_soc_pmic_bxtwc.c                 |  14 +-
 drivers/mfd/intel_soc_pmic_chtwc.c                 |   1 -
 drivers/mfd/max14577.c                             |   1 +
 drivers/mfd/max77620.c                             |   5 +-
 drivers/mfd/mc13xxx-spi.c                          |   2 +-
 drivers/mfd/mt6360-core.c                          |  23 +--
 drivers/mfd/qcom-spmi-pmic.c                       |   5 +-
 drivers/mfd/retu-mfd.c                             |  12 +-
 drivers/mfd/rk8xx-core.c                           |   6 +-
 drivers/mfd/rk8xx-i2c.c                            |  25 +++
 drivers/mfd/rohm-bd71828.c                         |   8 +-
 drivers/mfd/rohm-bd718x7.c                         |   2 +-
 drivers/mfd/rohm-bd9576.c                          |   6 +-
 drivers/mfd/sprd-sc27xx-spi.c                      |   2 +-
 drivers/mfd/syscon.c                               |  20 +-
 drivers/mfd/tc3589x.c                              |   2 -
 drivers/mfd/tps6105x.c                             |   2 +-
 drivers/mfd/tps65086.c                             |   2 +-
 drivers/mfd/tps65090.c                             |   2 +-
 drivers/mfd/tps65218.c                             |   2 +-
 drivers/mfd/tps65219.c                             |   4 +-
 drivers/mfd/tps65910.c                             |   6 +-
 drivers/mfd/tps65912-core.c                        |   2 +-
 drivers/mfd/twl6040.c                              |   2 +-
 drivers/mfd/wcd934x.c                              |   2 +-
 drivers/pwm/Kconfig                                |   7 +
 drivers/pwm/Makefile                               |   1 +
 drivers/pwm/pwm-adp5585.c                          | 184 +++++++++++++++++
 include/linux/mfd/88pm80x.h                        |   2 +-
 include/linux/mfd/adp5585.h                        | 126 ++++++++++++
 include/linux/mfd/axp20x.h                         |  26 +++
 include/linux/mfd/ds1wm.h                          |  29 ---
 57 files changed, 1089 insertions(+), 144 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/adi,adp5585.yaml
 create mode 100644 drivers/gpio/gpio-adp5585.c
 create mode 100644 drivers/mfd/adp5585.c
 create mode 100644 drivers/pwm/pwm-adp5585.c
 create mode 100644 include/linux/mfd/adp5585.h
 delete mode 100644 include/linux/mfd/ds1wm.h

-- 
Lee Jones [李琼斯]

