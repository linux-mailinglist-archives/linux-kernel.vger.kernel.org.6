Return-Path: <linux-kernel+bounces-252660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29B8E931677
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 16:15:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1DBA286F01
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 14:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 883F818D4DD;
	Mon, 15 Jul 2024 14:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YC75zNpg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B21101E89C
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 14:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721052918; cv=none; b=eas/eo1uy3jZNDGBdhkWh0btDLjmkKScDiv4ZtsiHerfDv7xYAttSJU2mhgVDoK/PwHsd7GYJixp8JIbjIyXmJSynP9ros8Ksvoek3LEh4umcZqkuwZyXMOjaOEEb7oavqOtaSY3z+PdzBHUIdAUTLR+fRByFZnsa/7orJaFXTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721052918; c=relaxed/simple;
	bh=kan1aIUgfPiS2+5N3DTFX+ibqh6HC2dHQ62U57g3mp0=;
	h=Message-ID:From:To:Cc:Subject:Date; b=ASiSbR7VMgxSZkVvavAGyum4ZII5ZkRD+eA7BufAUe/LCX3FtH+GyxvcFMWxcN68lGUXBEZCcoKn2Xbi0jdg6Hs6LEos+CdJdaJpPaqdZaX70bIk+rVYZA+n+pcQnr4Up4YM43GthSNk3iC0iH2PeMIvtN/m6lSdEIjFXYChOMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YC75zNpg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E56A2C4AF0A;
	Mon, 15 Jul 2024 14:15:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721052918;
	bh=kan1aIUgfPiS2+5N3DTFX+ibqh6HC2dHQ62U57g3mp0=;
	h=From:To:Cc:Subject:Date:From;
	b=YC75zNpgd0swJ7DjUS7iXgqddYkWE+nd7AR2FCeEHYK7SUOpFPD0pOnt2+1zUuCZh
	 CPm6H8ZknTrx4oEQ++K8Dh0hYBvUvYRu0uCTKxmdIXyq5xQm7/EYzSMGPoxzXuwDeR
	 pso1K0jNrCL0puujZzmvstkXJ6o2eTpXENg6xABKKyeso9WJ1uvCy9cMzzWGsWlIbv
	 KNMMvG+04uMzZ8GpL/XEY214dK+THUwNJYBkSlFfZVOvlJEwkQc3NMh95i3b9HraMb
	 S5z5TGcg532ozUwcGilOMbsFdR+l/R1KPml8G5uZGE2S3py5+30oGm7Kh0iGy0aiDy
	 DCdx/n0oeS4lw==
Message-ID: <3ada1d9c3010145c1dcfd5c65f12a3fd.broonie@kernel.org>
From: Mark Brown <broonie@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] regulator updates for v6.11
Date: Mon, 15 Jul 2024 15:14:59 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The following changes since commit f2661062f16b2de5d7b6a5c42a9a5c96326b8454:

  Linux 6.10-rc5 (2024-06-23 17:08:54 -0400)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-v6.11

for you to fetch changes up to ef0b29e744965e8abc14260503a559366219035c:

  regulator: dt-bindings: pca9450: Make interrupt optional (2024-07-08 12:50:21 +0100)

----------------------------------------------------------------
regulator: Updates for v6.11

This s a very quiet release for the regulator API, we have a few new
devices (most of which are just ID updates) and one new fairly
specialist core feature for use in interrupt context.

 - An API allowing lockless enable/disable for regulators acquired in
   exclusive mode, for use in interrupt contexts.
 - A rewrite of the MedaTek DVFSRC regulator driver which apparently
   never worked.
 - Support for Mediaktek MT6312, Qualcomm QCA6390 and WCN7850, Renesas
   RZ/G2L USB VBUS regulator and ST Microelectronics STM32MP13.

----------------------------------------------------------------
Alina Yu (3):
      regulator: rtq2208: Fix LDO to be compatible with both fixed and adjustable vout
      regulator: rtq2208: Add fixed LDO VOUT property and check that matches the constraints
      regulator: dt-bindings: rtq2208: Add specified fixed LDO VOUT property

Andreas Kemnade (2):
      dt-bindings: regulator: twl-regulator: convert to yaml
      dt-bindings: mfd: twl: Fix example

AngeloGioacchino Del Regno (3):
      regulator: Remove mtk-dvfsrc-regulator.c
      regulator: Add refactored mtk-dvfsrc-regulator driver
      regulator: Add bindings for MediaTek DVFSRC Regulators

Bartosz Golaszewski (2):
      regulator: dt-bindings: describe the PMU module of the QCA6390 package
      regulator: dt-bindings: describe the PMU module of the WCN7850 package

Biju Das (2):
      regulator: core: Add helper for allow HW access to enable/disable regulator
      regulator: Add Renesas RZ/G2L USB VBUS regulator driver

Chen-Yu Tsai (1):
      regulator: dt-bindings: mt6315: Document MT6319 PMIC

Christophe JAILLET (1):
      regulator: consumer: Reorder fields in 'struct regulator_bulk_data'

Dr. David Alan Gilbert (1):
      regulator: max77503: remove unused struct 'max77503_dev'

Frieder Schrempf (2):
      regulator: pca9450: Make IRQ optional
      regulator: dt-bindings: pca9450: Make interrupt optional

Javier Carrasco (2):
      regulator: da9121: Constify struct regmap_config
      regulator: max77857: Constify struct regmap_config

Jeff Johnson (1):
      regulator: add missing MODULE_DESCRIPTION() macro

Mark Brown (5):
      ARM: st: add new compatible for PWR regulators on
      Fix issue when using devm_of_regulator_put_matches and
      regulator: Merge up fixes
      regulator: Merge up v6.10-rc4
      Add USB VBUS regulator for RZ/G2L

Patrick Delaunay (2):
      regulator: stm32-pwr: add support of STM32MP13
      regulator: st,stm32mp1-pwr-reg: add compatible for STM32MP13

Robert Marko (1):
      regulator: userspace-consumer: quiet device deferral

Stanislav Jakubek (2):
      dt-bindings: regulator: ti,tps65132: document VIN supply
      dt-bindings: regulator: sprd,sc2731-regulator: convert to YAML

Uwe Kleine-König (1):
      regulator: Drop explicit initialization of struct i2c_device_id::driver_data to 0

 Documentation/devicetree/bindings/mfd/ti,twl.yaml  | 167 +++++++++++++-
 .../mediatek,mt6873-dvfsrc-regulator.yaml          |  43 ++++
 .../bindings/regulator/mt6315-regulator.yaml       |   6 +-
 .../bindings/regulator/nxp,pca9450-regulator.yaml  |   1 -
 .../bindings/regulator/qcom,qca6390-pmu.yaml       | 185 +++++++++++++++
 .../bindings/regulator/richtek,rtq2208.yaml        |  11 +-
 .../bindings/regulator/sprd,sc2731-regulator.txt   |  43 ----
 .../bindings/regulator/sprd,sc2731-regulator.yaml  |  67 ++++++
 .../bindings/regulator/st,stm32mp1-pwr-reg.yaml    |   7 +-
 .../devicetree/bindings/regulator/ti,tps65132.yaml |   3 +
 .../bindings/regulator/twl-regulator.txt           |  80 -------
 Documentation/power/regulator/consumer.rst         |   6 +
 drivers/regulator/Kconfig                          |   9 +
 drivers/regulator/Makefile                         |   1 +
 drivers/regulator/core.c                           |  28 +++
 drivers/regulator/da9121-regulator.c               |   7 +-
 drivers/regulator/da9210-regulator.c               |   4 +-
 drivers/regulator/lp3971.c                         |   2 +-
 drivers/regulator/lp3972.c                         |   2 +-
 drivers/regulator/lp8755.c                         |   2 +-
 drivers/regulator/max1586.c                        |   2 +-
 drivers/regulator/max20411-regulator.c             |   5 +-
 drivers/regulator/max77503-regulator.c             |   8 -
 drivers/regulator/max77857-regulator.c             |   2 +-
 drivers/regulator/max8649.c                        |   2 +-
 drivers/regulator/max8893.c                        |   4 +-
 drivers/regulator/max8952.c                        |   4 +-
 drivers/regulator/mcp16502.c                       |   2 +-
 drivers/regulator/mt6311-regulator.c               |   4 +-
 drivers/regulator/mtk-dvfsrc-regulator.c           | 248 ++++++++++-----------
 drivers/regulator/pca9450-regulator.c              |  41 ++--
 drivers/regulator/pf8x00-regulator.c               |   8 +-
 drivers/regulator/pv88060-regulator.c              |   4 +-
 drivers/regulator/pv88090-regulator.c              |   4 +-
 drivers/regulator/renesas-usb-vbus-regulator.c     |  74 ++++++
 drivers/regulator/rt4831-regulator.c               |   1 +
 drivers/regulator/rtq2208-regulator.c              |  44 +++-
 drivers/regulator/slg51000-regulator.c             |   4 +-
 drivers/regulator/stm32-pwr.c                      |   1 +
 drivers/regulator/sy8106a-regulator.c              |   4 +-
 drivers/regulator/tps6286x-regulator.c             |  11 +-
 drivers/regulator/tps6287x-regulator.c             |  10 +-
 drivers/regulator/userspace-consumer.c             |   6 +-
 include/linux/regulator/consumer.h                 |  13 +-
 44 files changed, 833 insertions(+), 347 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/regulator/mediatek,mt6873-dvfsrc-regulator.yaml
 create mode 100644 Documentation/devicetree/bindings/regulator/qcom,qca6390-pmu.yaml
 delete mode 100644 Documentation/devicetree/bindings/regulator/sprd,sc2731-regulator.txt
 create mode 100644 Documentation/devicetree/bindings/regulator/sprd,sc2731-regulator.yaml
 delete mode 100644 Documentation/devicetree/bindings/regulator/twl-regulator.txt
 create mode 100644 drivers/regulator/renesas-usb-vbus-regulator.c

