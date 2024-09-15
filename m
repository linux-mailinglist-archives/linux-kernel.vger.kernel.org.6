Return-Path: <linux-kernel+bounces-330084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B48A979985
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 01:26:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86E64B22D08
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 23:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F4E212B176;
	Sun, 15 Sep 2024 23:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hHGswyVg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A4AC57CAC
	for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2024 23:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726442798; cv=none; b=aef4t1zLvyn9fxqVuurkFcAJ9A6q+5ObFzoGMJ6BhKo+eCtHelXl1oWgkGI3+LW2uKLgZY03B6Vt0c2KgdjC0VNDv3AxfMQubncYtSjMqgsR7yekKavjADXfEeU0LcAE6VovuzDmM1a7zwkF+3oAr0N5OX/I3g0yK4kRu0gTt18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726442798; c=relaxed/simple;
	bh=xDmTw960/Bh1OZXZzOCbSiW6H/1VG0Wn05MHRN715xs=;
	h=Message-ID:From:To:Cc:Subject:Date; b=sUdTzD99jD7rTbNPGlwZlAv3yIgKKEe/hApg8zjhqyqUtd7ElTqmrbXLLM5v5MYpQO4NBkSRHDL1y/iLhZUZP7TeB4JBSEFJmqFWOeOphQqUsIr2vYu76g48Xtz//Ut0xgEO3+I6Emi7ijf34GssBpJ9+tGFz8d68pg0xmGxsBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hHGswyVg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 763E4C4CEC3;
	Sun, 15 Sep 2024 23:26:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726442797;
	bh=xDmTw960/Bh1OZXZzOCbSiW6H/1VG0Wn05MHRN715xs=;
	h=From:To:Cc:Subject:Date:From;
	b=hHGswyVgPWKi0T76MHSSueB1FLeHDeBLIZ1aAyGstXjarQhG0s3/b7/gbvH5F85vW
	 TqD62Dduz4M8kmH0Ksa7dtgGweTJZLF8VIe9X1BicHD4JfIJ1fvdqE779ilqbQSBws
	 IUCV+N657idNAuEPTzwm5N7BLAPinkj1M47E/jBFOwrAVimOHMeLK/utfnoPzFYrM7
	 IglHjFQr+cCQYj29fdlCf42F4T5o07FSNtrKyGws+J8qwhTnzjIRsqiSlUD9w+h2eZ
	 satGXpCzW2FkDKJITzqlaK2aGqteWMDCKVrRPIlQTAd9RWHRrjwHFY9FIyuZPNcNP7
	 EW1NJujCRA87w==
Message-ID: <bc62e0a65070a84b3edaf3c03d6a4bd1.broonie@kernel.org>
From: Mark Brown <broonie@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] regulator updates for v6.12
Date: Mon, 16 Sep 2024 00:26:27 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The following changes since commit 8400291e289ee6b2bf9779ff1c83a291501f017b:

  Linux 6.11-rc1 (2024-07-28 14:19:55 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-v6.12

for you to fetch changes up to 4591a2271f2e4c320eaa63c348169e4e6e6f2852:

  regulator: sm5703: Remove because it is unused and fails to build (2024-09-13 19:08:14 +0100)

----------------------------------------------------------------
regulator: Updates for v6.12

This release is almost all cleanup work of various kinds, while the
diffstat for the core is quite large this is almost all cleanups and
documentation improvments with some small fixes rather than any new
feature work.  We do have support for a couple of new devices but these
are small additions to existing drivers rather than new drivers.

 - Removal of the SM5703 driver which does not have it's dependencies
   available.
 - Support for Allwinner AXP717, and Qualcomm WCN6855.

The Allwinner support shares some commits with the MFD tree.

----------------------------------------------------------------
Andre Przywara (3):
      dt-bindings: mfd: x-powers,axp152: add boost regulator
      mfd: axp20x: AXP717: Add support for boost regulator
      regulator: axp20x: AXP717: Add boost regulator

Andrei Simion (2):
      regulator: mcp16502: Add supplier for regulators
      regulator: dt-bindings: microchip,mcp16502: Add voltage input supply documentation

André Draszik (1):
      regulator: update some comments ([gs]et_voltage_vsel vs [gs]et_voltage_sel)

Andy Shevchenko (1):
      regulator: of: Refactor of_get_*regulator() to decrease indentation

Bartosz Golaszewski (3):
      regulator: dt-bindings: qcom,qca6390-pmu: fix the description for bt-enable-gpios
      regulator: dt-bindings: qcom,qca6390-pmu: document WCN6855
      regulator: dt-bindings: qcom,qca6390-pmu: document the swctrl-gpios property

Chen Ni (2):
      regulator: wm831x-isink: Convert comma to semicolon
      regulator: rt5120: Convert comma to semicolon

Chen-Yu Tsai (15):
      regulator: Clarify error message for "id == NULL" in _regulator_get()
      regulator: Return actual error in of_regulator_bulk_get_all()
      regulator: Fully clean up on error in of_regulator_bulk_get_all()
      regulator: core: Fix short description for _regulator_check_status_enabled()
      regulator: core: Fix regulator_is_supported_voltage() kerneldoc return value
      regulator: core: Fix incorrectly formatted kerneldoc "Return" sections
      regulator: core: Add missing kerneldoc "Return" sections
      regulator: of: Fix incorrectly formatted kerneldoc "Return" sections
      regulator: fixed: Fix incorrectly formatted kerneldoc "Return" section
      regulator: fixed-helper: Add missing "Return" kerneldoc section
      regulator: irq_helpers: Fix regulator_irq_map_event_simple() kerneldoc
      regulator: of: Fix kerneldoc format for of_regulator_bulk_get_all()
      regulator: Unify "negative error number" terminology in comments
      regulator: Move OF-specific regulator lookup code to of_regulator.c
      regulator: Split up _regulator_get()

Christophe JAILLET (6):
      regulator: bd9576: Constify struct linear_range
      regulator: mp5416: Constify struct regulator_desc
      regulator: da9211: Constify struct regulator_desc
      regulator: wm8400: Constify struct regulator_desc
      regulator: tps6287x: Constify struct regulator_desc
      regulator: sm5703: Remove because it is unused and fails to build

Dan Carpenter (1):
      regulator: bd96801: Delete unnecessary check in probe()

Jinjie Ruan (1):
      regulator: max8973: Use irq_get_trigger_type() helper

Krzysztof Kozlowski (24):
      regulator: bd718x7: Use scoped device node handling to simplify error paths
      regulator: bd96801: Use scoped device node handling to simplify error paths
      regulator: max8997: Use scoped device node handling to simplify error paths
      regulator: s5m8767: Use scoped device node handling to simplify error paths
      regulator: qcom-rpmh: Simplify with scoped for each OF child loop
      regulator: qcom-smd: Simplify with scoped for each OF child loop
      regulator: scmi: Simplify with scoped for each OF child loop
      regulator: s2mps11: use scoped memory allocation to simplify probe
      regulator: da9052: Constify static data
      regulator: da9055: Constify static data
      regulator: da9063: Constify static data
      regulator: da9121: Constify static data
      regulator: hi6421: Constify static data
      regulator: hi6421v600: Constify static data
      regulator: tps65023: Constify static data
      regulator: max77826: Drop unused 'rdesc' in 'struct max77826_regulator_info'
      regulator: max77826: Constify static data
      regulator: mtk-dvfsrc: Constify static data
      regulator: pcap: Constify static data
      regulator: pfuze100: Constify static data
      regulator: qcom-refgen: Constify static data
      regulator: hi6421v530: Drop unused 'eco_microamp'
      regulator: hi6421v530: Use container_of and constify static data
      regulator: max77650: Use container_of and constify static data

Macpaul Lin (1):
      regulator: dt-bindings: mediatek,mt6397-regulator: convert to YAML

Mark Brown (5):
      Add input voltage suppliers for PMIC MCP16502
      regulator: Use scoped device node handling to simplify
      regulator: Minor cleanups
      regulator: Add AXP717 boost support
      regulator: Few constifications of static data

Rob Herring (Arm) (3):
      regulator: Use of_property_read_bool()
      regulator: qcom_spmi: Drop unnecessary of_find_property() call
      regulator: qcom_spmi: Use of_property_read_bool()

Wei Fang (1):
      regulator: core: fix the broken behavior of regulator_dev_lookup()

Yu Jiaoliang (1):
      regulator: Fix typos in the comment

Yue Haibing (1):
      regulator: max77857: Make max77857_id static

 .../devicetree/bindings/mfd/x-powers,axp152.yaml   |   2 +-
 .../regulator/mediatek,mt6397-regulator.yaml       | 238 ++++++++++++++++
 .../bindings/regulator/microchip,mcp16502.yaml     |  20 ++
 .../bindings/regulator/mt6397-regulator.txt        | 220 ---------------
 .../bindings/regulator/qcom,qca6390-pmu.yaml       |  22 +-
 drivers/mfd/axp20x.c                               |   2 +
 drivers/regulator/Kconfig                          |   7 -
 drivers/regulator/Makefile                         |   1 -
 drivers/regulator/act8865-regulator.c              |   4 +-
 drivers/regulator/axp20x-regulator.c               |   4 +
 drivers/regulator/bd718x7-regulator.c              |  19 +-
 drivers/regulator/bd9576-regulator.c               |   8 +-
 drivers/regulator/bd96801-regulator.c              |  19 +-
 drivers/regulator/core.c                           | 310 +++++++++++----------
 drivers/regulator/da903x-regulator.c               |   2 +-
 drivers/regulator/da9052-regulator.c               |  22 +-
 drivers/regulator/da9055-regulator.c               |  28 +-
 drivers/regulator/da9063-regulator.c               |   4 +-
 drivers/regulator/da9121-regulator.c               |  20 +-
 drivers/regulator/da9211-regulator.c               |   2 +-
 drivers/regulator/devres.c                         |  18 +-
 drivers/regulator/fan53555.c                       |   2 +-
 drivers/regulator/fixed-helper.c                   |   2 +
 drivers/regulator/fixed.c                          |   8 +-
 drivers/regulator/helpers.c                        |   8 +-
 drivers/regulator/hi6421-regulator.c               |  14 +-
 drivers/regulator/hi6421v530-regulator.c           |  27 +-
 drivers/regulator/hi6421v600-regulator.c           |  10 +-
 drivers/regulator/internal.h                       |  13 +-
 drivers/regulator/irq_helpers.c                    |  17 +-
 drivers/regulator/max5970-regulator.c              |   2 +-
 drivers/regulator/max77650-regulator.c             |  31 +--
 drivers/regulator/max77802-regulator.c             |   4 +-
 drivers/regulator/max77826-regulator.c             |   4 +-
 drivers/regulator/max77857-regulator.c             |   2 +-
 drivers/regulator/max8973-regulator.c              |   7 +-
 drivers/regulator/max8997-regulator.c              |  16 +-
 drivers/regulator/mcp16502.c                       |  17 +-
 drivers/regulator/mp5416.c                         |   4 +-
 drivers/regulator/mt6357-regulator.c               |   2 +-
 drivers/regulator/mtk-dvfsrc-regulator.c           |  10 +-
 drivers/regulator/of_regulator.c                   | 150 ++++++++--
 drivers/regulator/pcap-regulator.c                 |  12 +-
 drivers/regulator/pfuze100-regulator.c             |  10 +-
 drivers/regulator/qcom-refgen-regulator.c          |   4 +-
 drivers/regulator/qcom-rpmh-regulator.c            |  17 +-
 drivers/regulator/qcom_smd-regulator.c             |  13 +-
 drivers/regulator/qcom_spmi-regulator.c            |  12 +-
 drivers/regulator/rt5120-regulator.c               |   4 +-
 drivers/regulator/s2mps11.c                        |  17 +-
 drivers/regulator/s5m8767.c                        |  17 +-
 drivers/regulator/scmi-regulator.c                 |   8 +-
 drivers/regulator/sm5703-regulator.c               | 170 -----------
 drivers/regulator/tps6287x-regulator.c             |   2 +-
 drivers/regulator/tps65023-regulator.c             |   6 +-
 drivers/regulator/wm831x-isink.c                   |   8 +-
 drivers/regulator/wm8400-regulator.c               |   2 +-
 include/linux/mfd/axp20x.h                         |   3 +
 58 files changed, 809 insertions(+), 818 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/regulator/mediatek,mt6397-regulator.yaml
 delete mode 100644 Documentation/devicetree/bindings/regulator/mt6397-regulator.txt
 delete mode 100644 drivers/regulator/sm5703-regulator.c

