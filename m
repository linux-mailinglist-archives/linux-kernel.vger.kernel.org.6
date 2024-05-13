Return-Path: <linux-kernel+bounces-177416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AEAA8C3E41
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 11:39:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99C471F22390
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 09:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DEEE1487F2;
	Mon, 13 May 2024 09:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PtMF78SF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A8A2F875
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 09:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715593152; cv=none; b=YHk0kNYv20SQ2t7nOANjKQjQGUTm/QhEdwfLjp8eugEvOCJbJo/DeJcHBP5FhPkyarLdL4iX1A0aytiQatRpRCOUjrhqYZsjnyWNI1QUPjqXyBzuzhUhiE878XG2rhbTxwIoUyorslmM7gl3u3JVA9abpeqIw8ASX/Vl6j2bka4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715593152; c=relaxed/simple;
	bh=RMaVpGtWTDF/EyWq1wtwfA7IKJ8BrYaDxt7v9A3r8z0=;
	h=Message-ID:From:To:Cc:Subject:Date; b=cA6UqOsROgfHgkq7GFMa8XN56tMioZkO+7T5iSJV/BzrhcgZzU7htmrH9Qdul/jkirkSalleClEKh0vilseAalnXfF7ayALktGoIrtHrvMisGUS2ylCyPOfD/RHQdoL8MrMKwmrZWc/WjKGzNjjYfY6C/2fTiZsoP1Qyykqyd3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PtMF78SF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FE68C113CC;
	Mon, 13 May 2024 09:39:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715593152;
	bh=RMaVpGtWTDF/EyWq1wtwfA7IKJ8BrYaDxt7v9A3r8z0=;
	h=From:To:Cc:Subject:Date:From;
	b=PtMF78SF7OqWjVe3bp821bf54Bp10rQHjrQTtOTnbPAptL8zLpQ8parXEY0m5gX0i
	 a7gCHJTh5ETqHzgWnrUA628/HN8m70SSGGAXWFWezzdJetZ4iSy4g8Cfzo/L1xiNzR
	 Aoxz5OsfyfCEFSGB7rGnQV4oZY3vxMoXF95ik3gfUVri6O5N1k6zbEauWNtw9Q1X16
	 SnUvsrkeRUdoEASsZ0ZjbqJ65DoDZJkJzV1LJgwej6i5rADzNyk4foO1hlBKhw5LKQ
	 8k/63hky6EK6eAvIUm52ewjFp1XzngLQmt+604aCQsehwrPw9tVkLl/mOHFZZF9XGZ
	 bU1OtgIC1SaJA==
Message-ID: <969a662f066e8d49507ad947e3d7477a.broonie@kernel.org>
From: Mark Brown <broonie@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] regulator updates for v6.10
Date: Mon, 13 May 2024 10:38:55 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The following changes since commit fec50db7033ea478773b159e0e2efb135270e3b7:

  Linux 6.9-rc3 (2024-04-07 13:22:46 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-v6.10

for you to fetch changes up to 4e70b26c873dfff317039458a6ea66314bbdce99:

  regulator: sun20i: Add Allwinner D1 LDOs driver (2024-05-09 17:44:01 +0200)

----------------------------------------------------------------
regulator: Updates for v6.10

There's one API update here, a new API factoring out a common pattern
for reference voltage supplies.  These are supplies uses as a reference
by analogue circuits where the consumer requests and enables the supply,
reads the voltage to calibrate the user and then never touches it again.
This is factored out into a single operation which just returns the
voltage and uses devm_ to manage the request and enable portion.

Otherwise this has been a very quiet release, we've got some new device
support, some small fixes, housekeeping and cleanup work but nothing
substantial.

There's also some non-regulator changes in here, a number of users for
the new reference voltage API were merged along with it and some MFD
changes were pulled in as dependencies for new driver work.

Highlights:

 - Add a new API for single operation handling of reference voltages.
 - Support for Allwinner AXP717 and D1, and NXP PCA9561A.

----------------------------------------------------------------
Alina Yu (1):
      regulator: rtq2208: Fix LDO discharge register and add vsel setting

Andre Przywara (4):
      regulator: axp20x: fix typo-ed identifier
      dt-bindings: mfd: x-powers,axp152: Document AXP717
      mfd: axp20x: Add support for AXP717 PMIC
      regulator: axp20x: add support for the AXP717

Bo Liu (13):
      regulator: da9121: convert to use maple tree register cache
      regulator: da9211: convert to use maple tree register cache
      regulator: isl9305: convert to use maple tree register cache
      regulator: max8973: convert to use maple tree register cache
      regulator: mt6311: convert to use maple tree register cache
      regulator: pca9450: convert to use maple tree register cache
      regulator: pf8x00: convert to use maple tree register cache
      regulator: pfuze100: convert to use maple tree register cache
      regulator: rtmv20: convert to use maple tree register cache
      regulator: rtq6752: convert to use maple tree register cache
      regulator: tps51632: convert to use maple tree register cache
      regulator: tps62360: convert to use maple tree register cache
      regulator: rpi-panel-attiny: convert to use maple tree register cache

David Lechner (8):
      regulator: devres: add API for reference voltage supplies
      hwmon: (adc128d818) Use devm_regulator_get_enable_read_voltage()
      hwmon: (da9052) Use devm_regulator_get_enable_read_voltage()
      regulator: devres: fix devm_regulator_get_enable_read_voltage() return
      hwmon: (adc128d818) simplify final return in probe
      iio: addac: ad74115: Use devm_regulator_get_enable_read_voltage()
      iio: frequency: admv1013: Use devm_regulator_get_enable_read_voltage()
      staging: iio: impedance-analyzer: ad5933: Use devm_regulator_get_enable_read_voltage()

Joy Zou (2):
      regulator: dt-bindings: pca9450: add pca9451a support
      regulator: pca9450: add pca9451a support

Luca Weiss (1):
      dt-bindings: regulator: qcom,usb-vbus-regulator: Add PM7250B compatible

Mark Brown (4):
      add pmic pca9451a support
      regulator: convert to use maple tree register
      regulator: Merge axp20x changes
      regulator: new API for voltage reference supplies

Rob Herring (Arm) (1):
      regulator: dt-bindings: fixed-regulator: Add a preferred node name

Samuel Holland (2):
      regulator: dt-bindings: Add Allwinner D1 system LDOs
      regulator: sun20i: Add Allwinner D1 LDOs driver

Uwe Kleine-König (1):
      regulator: Mention regulator id in error message about dummy supplies

 .../devicetree/bindings/mfd/x-powers,axp152.yaml   |   2 +
 .../regulator/allwinner,sun20i-d1-system-ldos.yaml |  37 ++++
 .../bindings/regulator/fixed-regulator.yaml        |   7 +
 .../bindings/regulator/nxp,pca9450-regulator.yaml  |   1 +
 .../regulator/qcom,usb-vbus-regulator.yaml         |   1 +
 Documentation/driver-api/driver-model/devres.rst   |   1 +
 drivers/hwmon/adc128d818.c                         |  57 ++----
 drivers/hwmon/da9052-hwmon.c                       |  38 ++--
 drivers/iio/addac/ad74115.c                        |  40 ++---
 drivers/iio/frequency/admv1013.c                   |  40 ++---
 drivers/mfd/axp20x-i2c.c                           |   2 +
 drivers/mfd/axp20x-rsb.c                           |   1 +
 drivers/mfd/axp20x.c                               |  90 ++++++++++
 drivers/regulator/Kconfig                          |   8 +
 drivers/regulator/Makefile                         |   1 +
 drivers/regulator/axp20x-regulator.c               |  94 +++++++++-
 drivers/regulator/core.c                           |   4 +-
 drivers/regulator/da9121-regulator.c               |   4 +-
 drivers/regulator/da9211-regulator.c               |   2 +-
 drivers/regulator/devres.c                         |  59 +++++++
 drivers/regulator/isl9305.c                        |   2 +-
 drivers/regulator/max8973-regulator.c              |   2 +-
 drivers/regulator/mt6311-regulator.c               |   2 +-
 drivers/regulator/pca9450-regulator.c              | 196 ++++++++++++++++++++-
 drivers/regulator/pf8x00-regulator.c               |   2 +-
 drivers/regulator/pfuze100-regulator.c             |   2 +-
 drivers/regulator/rpi-panel-attiny-regulator.c     |   2 +-
 drivers/regulator/rtmv20-regulator.c               |   2 +-
 drivers/regulator/rtq2208-regulator.c              | 100 +++++++----
 drivers/regulator/rtq6752-regulator.c              |   2 +-
 drivers/regulator/sun20i-regulator.c               | 157 +++++++++++++++++
 drivers/regulator/tps51632-regulator.c             |   2 +-
 drivers/regulator/tps62360-regulator.c             |   2 +-
 drivers/staging/iio/impedance-analyzer/ad5933.c    |  26 +--
 include/linux/mfd/axp20x.h                         |  98 ++++++++++-
 include/linux/regulator/consumer.h                 |   7 +
 include/linux/regulator/pca9450.h                  |   1 +
 37 files changed, 879 insertions(+), 215 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/regulator/allwinner,sun20i-d1-system-ldos.yaml
 create mode 100644 drivers/regulator/sun20i-regulator.c

