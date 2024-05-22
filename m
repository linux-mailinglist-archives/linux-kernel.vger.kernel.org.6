Return-Path: <linux-kernel+bounces-186019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8247E8CBEE1
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 12:03:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC4421F22FE1
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 10:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BFB780C0C;
	Wed, 22 May 2024 10:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OcbE7SC4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 299FE17BB5
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 10:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716372177; cv=none; b=uNHnz93aWRDAwYjMbro1D6AG4R+VbR0n0BHR2VkexqpUdSC/FEGAFUZe/E8B0n5pjfs381A8Ni9I6xNcD0jXtWqgy3gm19sSiVaXL9nbT+ml3/Op97dfeIMpYEUkgMcKZkgc7JZvkznnhjK7lculwyHOHm1uzP8dtdIg7azr6KY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716372177; c=relaxed/simple;
	bh=moq8Hyotp47wsK2NBvnh7qshrFG+HNLao4drYLeLVQE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=d9nT7UZ6I1uUqZI8ylq6JjlLTPvvVBwPPyCoNTUqJgqOoWWwy8+SbEqMsCYPE/Z6m/ox9pd/onHhetxB92RNIu6ThajeLSR/8jH/6I5+98SGzlZJ9eROnrMVkhKlT/Euc9J2lTO3tV9lZTagyBmNc/5OM0t5U5NARBvSl4WKSeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OcbE7SC4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2198FC2BD11;
	Wed, 22 May 2024 10:02:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716372176;
	bh=moq8Hyotp47wsK2NBvnh7qshrFG+HNLao4drYLeLVQE=;
	h=Date:From:To:Cc:Subject:From;
	b=OcbE7SC47JQgtga5zKIYClgrRU7kXkKbyABg71gaiyZVXW53mwruLsHLUtttczORl
	 ipFwjVi//AJF9MLmkyHupLMdYwfPo5Po7ZyHiblQFEfoC/ji3QtsqVSIotyOKnPK4l
	 vscani4er4qEblSx16Ay9HH62GxhVBNcfmWXLdyNn+XAvG3g9ZsAuDzt6DTa6bWwUc
	 hIu/c1JkJ+WqaAb8qShR03xCFtXkLHvGxrQk0RdInlhBU93+Do551xEiGlAt4mKeBP
	 c5dNjnHVQNDmU4VCnGWYpdtyCUKxKYe+wK3XJ3H/ws+e5YJqNAGCL/KBvzfcGBl7e4
	 WutKBbBpJ6RlQ==
Date: Wed, 22 May 2024 11:02:53 +0100
From: Lee Jones <lee@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] MFD for v6.10
Message-ID: <20240522100253.GB6035@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Good morning Linus,

The following changes since commit 4cece764965020c22cff7665b18a012006359095:

  Linux 6.9-rc1 (2024-03-24 14:10:05 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/lee/mfd tags/mfd-next-6.10

for you to fetch changes up to 1482489b5196f4203576ae1dc2ba4ce3ada381c7:

  dt-bindings: mfd: Use full path to other schemas (2024-05-10 15:39:18 +0100)

----------------------------------------------------------------
 - New Device Support
   - Add support for X-Powers AXP717 PMIC to AXP22X
   - Add support for Rockchip RK816 PMIC to RK8XX
   - Add support for TI TPS65224 PMIC to TPS6594

 - New Functionality
   - Add Power Off functionality to Rohm BD71828
   - Allow I2C SMBus access in Renesas RSMU

 - Fix-ups
   - Device Tree binding adaptions/conversions/creation
   - Shift Intel support over to MSI interrupts
   - Generify adding platform data away from being ACPI specific
   - Use device core supplied attribute to register sysfs entries
   - Replace hand-rolled functionality with generic APIs
   - Utilise centrally provided helpers and macros
   - Clean-up error handling
   - Remove superfluous/duplicated/unused sections
   - Trivial; spelling, whitespace, coding-style adaptions
   - More Maple Tree conversions

----------------------------------------------------------------
Alex Bee (5):
      dt-bindings: mfd: Add rk816 binding
      mfd: rk8xx: Add RK816 support
      pinctrl: rk805: Add rk816 pinctrl support
      regulator: rk808: Support apply_bit for rk808_set_suspend_voltage_range
      regulator: rk808: Add RK816 support

Andre Przywara (4):
      regulator: axp20x: fix typo-ed identifier
      dt-bindings: mfd: x-powers,axp152: Document AXP717
      mfd: axp20x: Add support for AXP717 PMIC
      regulator: axp20x: add support for the AXP717

Andreas Kemnade (4):
      dt-bindings: mfd: twl: Convert trivial subdevices to json-schema
      dt-bindings: mfd: Add ROHM BD71828 system-power-controller property
      mfd: rohm-bd71828: Add power off functionality
      dt-bindings: mfd: Add ROHM BD71879

Andy Shevchenko (8):
      mfd: intel-lpss: Switch over to MSI interrupts
      mfd: kempld: Replace ACPI code with agnostic one
      mfd: kempld: Use device core to create driver-specific device attributes
      mfd: kempld: Simplify device registration
      mfd: kempld: Use PLATFORM_DEVID_NONE instead of -1
      mfd: kempld: Drop duplicate NULL check in ->exit()
      mfd: kempld: Remove dead code
      mfd: kempld: Remove custom DMI matching code

Bhargav Raviprakash (6):
      mfd: tps6594: Use volatile_table instead of volatile_reg
      dt-bindings: mfd: ti,tps6594: Add TI TPS65224 PMIC
      mfd: tps6594-i2c: Add TI TPS65224 PMIC I2C
      mfd: tps6594-spi: Add TI TPS65224 PMIC SPI
      mfd: tps6594-core: Add TI TPS65224 PMIC core
      misc: tps6594-pfsm: Add TI TPS65224 PMIC PFSM

Charles Keepax (1):
      mfd: cs42l43: Update patching revision check

Christophe JAILLET (2):
      mfd: ocelot-spi: Use spi_sync_transfer()
      mfd: ssbi: Remove unused field 'slave' from 'struct ssbi'

Colin Ian King (1):
      mfd: timberdale: Remove redundant assignment to variable err

Herman van Hazendonk (1):
      dt-bindings: mfd: qcom: pm8xxx: Add pm8901 compatible

Ilpo Järvinen (1):
      mfd: intel-m10-bmc: Change staging size to a variable

Jean Delvare (1):
      mfd: Tidy Kconfig dependency's parentheses

Krzysztof Kozlowski (2):
      dt-bindings: mfd: allwinner,sun6i-a31-prcm: Use hyphens in node names
      dt-bindings: mfd: Use full path to other schemas

Lee Jones (1):
      Merge branches 'ib-mfd-misc-pinctrl-regulator-6.10', 'ib-mfd-pinctrl-regulator-6.10' and 'ib-mfd-regulator-6.10' into ibs-for-mfd-merged

Luca Weiss (1):
      dt-bindings: mfd: qcom,spmi-pmic: Add pbs to SPMI device types

Matti Vaittinen (1):
      mfd: bd71828: Remove commented code lines

Min Li (1):
      mfd: rsmu: support I2C SMBus access

Nathan Morrisson (1):
      dt-bindings: mfd: Convert lp873x.txt to json-schema

Nirmala Devi Mal Nadar (3):
      mfd: tps6594: Add register definitions for TI TPS65224 PMIC
      regulator: tps6594-regulator: Add TI TPS65224 PMIC regulators
      pinctrl: pinctrl-tps6594: Add TPS65224 PMIC pinctrl and GPIO

Rob Herring (1):
      dt-bindings: mfd: syscon: Add missing simple syscon compatibles

Rob Herring (Arm) (1):
      dt-bindings: mfd: aspeed: Drop 'oneOf' for pinctrl node

Rohit Agarwal (1):
      dt-bindings: mfd: qcom,tcsr: Add compatible for SDX75

Siddharth Vadapalli (1):
      dt-bindings: mfd: syscon: Add ti,am62p-cpsw-mac-efuse compatible

wangkaiyuan (1):
      mfd: axp20x: Convert to use Maple Tree register cache

 .../arm/altera/socfpga-sdram-controller.txt        |  12 -
 Documentation/devicetree/bindings/arm/apm/scu.txt  |  17 -
 .../bindings/arm/marvell/armada-37xx.txt           |  32 --
 .../bindings/input/twl4030-pwrbutton.txt           |  21 --
 .../devicetree/bindings/mfd/actions,atc260x.yaml   |   6 +-
 .../bindings/mfd/allwinner,sun6i-a31-prcm.yaml     |  14 +-
 .../bindings/mfd/aspeed,ast2x00-scu.yaml           |  16 +-
 .../devicetree/bindings/mfd/brcm,cru.yaml          |   8 +-
 .../devicetree/bindings/mfd/brcm,iproc-cdru.txt    |  16 -
 .../devicetree/bindings/mfd/brcm,iproc-mhb.txt     |  18 --
 .../devicetree/bindings/mfd/brcm,misc.yaml         |   2 +-
 .../bindings/mfd/canaan,k210-sysctl.yaml           |   6 +-
 .../devicetree/bindings/mfd/delta,tn48m-cpld.yaml  |   4 +-
 Documentation/devicetree/bindings/mfd/iqs62x.yaml  |   4 +-
 .../devicetree/bindings/mfd/kontron,sl28cpld.yaml  |  10 +-
 Documentation/devicetree/bindings/mfd/lp873x.txt   |  67 ----
 .../devicetree/bindings/mfd/max77650.yaml          |   8 +-
 .../devicetree/bindings/mfd/maxim,max77686.yaml    |   2 +-
 .../devicetree/bindings/mfd/maxim,max77693.yaml    |   2 +-
 .../devicetree/bindings/mfd/qcom,spmi-pmic.yaml    |   4 +
 .../devicetree/bindings/mfd/qcom,tcsr.yaml         |   1 +
 .../devicetree/bindings/mfd/qcom-pm8xxx.yaml       |   1 +
 .../devicetree/bindings/mfd/richtek,rt4831.yaml    |   4 +-
 .../devicetree/bindings/mfd/ricoh,rn5t618.yaml     |   6 +-
 .../devicetree/bindings/mfd/rockchip,rk805.yaml    |   2 +-
 .../devicetree/bindings/mfd/rockchip,rk808.yaml    |   2 +-
 .../devicetree/bindings/mfd/rockchip,rk816.yaml    | 274 ++++++++++++++++
 .../devicetree/bindings/mfd/rockchip,rk817.yaml    |   2 +-
 .../devicetree/bindings/mfd/rockchip,rk818.yaml    |   2 +-
 .../devicetree/bindings/mfd/rohm,bd71815-pmic.yaml |   2 +-
 .../devicetree/bindings/mfd/rohm,bd71828-pmic.yaml |  13 +-
 .../devicetree/bindings/mfd/rohm,bd71837-pmic.yaml |   2 +-
 .../devicetree/bindings/mfd/rohm,bd9571mwv.yaml    |   2 +-
 .../devicetree/bindings/mfd/rohm,bd9576-pmic.yaml  |   2 +-
 .../devicetree/bindings/mfd/samsung,s2mpa01.yaml   |   2 +-
 .../devicetree/bindings/mfd/samsung,s2mps11.yaml   |  12 +-
 .../devicetree/bindings/mfd/samsung,s5m8767.yaml   |   4 +-
 .../devicetree/bindings/mfd/st,stmfx.yaml          |   2 +-
 .../devicetree/bindings/mfd/st,stpmic1.yaml        |   4 +-
 .../devicetree/bindings/mfd/stericsson,ab8500.yaml |  48 +--
 .../bindings/mfd/stericsson,db8500-prcmu.yaml      |  40 +--
 Documentation/devicetree/bindings/mfd/syscon.yaml  |  16 +
 .../devicetree/bindings/mfd/ti,lp8732.yaml         | 112 +++++++
 .../devicetree/bindings/mfd/ti,tps65086.yaml       |   4 +-
 .../devicetree/bindings/mfd/ti,tps6594.yaml        |   1 +
 Documentation/devicetree/bindings/mfd/ti,twl.yaml  |  72 ++++-
 .../devicetree/bindings/mfd/x-powers,axp152.yaml   |   2 +
 Documentation/devicetree/bindings/rtc/twl-rtc.txt  |  11 -
 .../devicetree/bindings/watchdog/twl4030-wdt.txt   |  10 -
 drivers/fpga/intel-m10-bmc-sec-update.c            |   3 +-
 drivers/mfd/Kconfig                                |  16 +-
 drivers/mfd/axp20x-i2c.c                           |   2 +
 drivers/mfd/axp20x-rsb.c                           |   1 +
 drivers/mfd/axp20x.c                               |  90 ++++++
 drivers/mfd/cs42l43.c                              |  36 ++-
 drivers/mfd/intel-lpss-pci.c                       |   2 +-
 drivers/mfd/intel-m10-bmc-pmci.c                   |   1 +
 drivers/mfd/intel-m10-bmc-spi.c                    |   1 +
 drivers/mfd/kempld-core.c                          | 227 +++----------
 drivers/mfd/ocelot-spi.c                           |   5 +-
 drivers/mfd/rk8xx-core.c                           | 104 ++++++
 drivers/mfd/rk8xx-i2c.c                            |  45 ++-
 drivers/mfd/rohm-bd71828.c                         |  36 ++-
 drivers/mfd/rsmu_i2c.c                             | 107 ++++++-
 drivers/mfd/rsmu_spi.c                             |   8 +-
 drivers/mfd/ssbi.c                                 |   1 -
 drivers/mfd/timberdale.c                           |   1 -
 drivers/mfd/tps6594-core.c                         | 253 +++++++++++++--
 drivers/mfd/tps6594-i2c.c                          |  20 +-
 drivers/mfd/tps6594-spi.c                          |  20 +-
 drivers/misc/tps6594-pfsm.c                        |  48 ++-
 drivers/pinctrl/pinctrl-rk805.c                    |  69 ++++
 drivers/pinctrl/pinctrl-tps6594.c                  | 277 +++++++++++++---
 drivers/regulator/Kconfig                          |   4 +-
 drivers/regulator/axp20x-regulator.c               |  94 +++++-
 drivers/regulator/rk808-regulator.c                | 218 ++++++++++++-
 drivers/regulator/tps6594-regulator.c              | 334 ++++++++++++++++----
 include/linux/mfd/axp20x.h                         |  98 +++++-
 include/linux/mfd/intel-m10-bmc.h                  |   1 +
 include/linux/mfd/rk808.h                          | 144 +++++++++
 include/linux/mfd/rohm-bd71828.h                   |   5 +-
 include/linux/mfd/tps6594.h                        | 351 ++++++++++++++++++++-
 82 files changed, 2805 insertions(+), 741 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/altera/socfpga-sdram-controller.txt
 delete mode 100644 Documentation/devicetree/bindings/arm/apm/scu.txt
 delete mode 100644 Documentation/devicetree/bindings/arm/marvell/armada-37xx.txt
 delete mode 100644 Documentation/devicetree/bindings/input/twl4030-pwrbutton.txt
 delete mode 100644 Documentation/devicetree/bindings/mfd/brcm,iproc-cdru.txt
 delete mode 100644 Documentation/devicetree/bindings/mfd/brcm,iproc-mhb.txt
 delete mode 100644 Documentation/devicetree/bindings/mfd/lp873x.txt
 create mode 100644 Documentation/devicetree/bindings/mfd/rockchip,rk816.yaml
 create mode 100644 Documentation/devicetree/bindings/mfd/ti,lp8732.yaml
 delete mode 100644 Documentation/devicetree/bindings/rtc/twl-rtc.txt
 delete mode 100644 Documentation/devicetree/bindings/watchdog/twl4030-wdt.txt

-- 
Lee Jones [李琼斯]

