Return-Path: <linux-kernel+bounces-412993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29A179D1217
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 14:38:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 239BCB2B6A3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 13:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37E321B3957;
	Mon, 18 Nov 2024 13:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mPz+9Tpi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9111C19E993
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 13:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731936780; cv=none; b=DxHP9fxky5/L5Nc4DPzvFpcSnJ5c5joMDW5jA6+sYKRwuxSOCsptsoGYvaCsWqROSerQljhmm6+EGiMDkRIgXJCfKAxWmBifefKOlFrt/QE5jeJn+NfKNJXAeCMCKFwmqvlZjJvA958DpCSDxhmCZ9TAyXjMoufmQkkMCF2a9lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731936780; c=relaxed/simple;
	bh=Ob8jjzmqU/Z4HwMJThJsv/Lrok+I4ndZkdIqLGqqR1M=;
	h=Message-ID:From:To:Cc:Subject:Date; b=cF6AiYvlsub2TQCl9oGdbxpbKkUV2T4Z6juzQd4lalqbXvJPij3uoZS0E85MJQLsf85LEV4ixMN2S1e8aF2TkNviuWs20Ufm9qSkNyL6ZZsyPRu1V6XmSKiJWa61XS/7CKLvFL2lljY+LiJtk07t8XZ37oiBDk46uKjVw3GTRxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mPz+9Tpi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE1A3C4CECC;
	Mon, 18 Nov 2024 13:32:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731936780;
	bh=Ob8jjzmqU/Z4HwMJThJsv/Lrok+I4ndZkdIqLGqqR1M=;
	h=From:To:Cc:Subject:Date:From;
	b=mPz+9TpitT6dRZlIJIyLLMYVlNeaPk0kcZu5AOxlDQj72PpSnPCvrCkWo2huhnkum
	 8tLV48+1RXkf75jmUFmi33Kb3JhI7QoRetybNVX72YF80uZROgrQNeMJ6thRpjhwbN
	 BHDOhN8Y5gVoe6Sc4LRO1UzpjeBdCLB6E94SPaoZtnYq7Dq62hB7jW64rBt7pxdnGr
	 y1YLZOtl/RFQLlneqjbzL7lo8OQf+YrFryk7KqVR8ZZMCGKtl9nDYpFLvFQl3I2M4M
	 9EZ1xOIzCpwpKVGQLy2sSSBjVA70/T3d/v9EWK2PQv+Ji2E0oe+RCI5Udj2iBmqIPG
	 GqwadSksSnRtw==
Message-ID: <bd78e37c1570dc055bb19e393670d9a7.broonie@kernel.org>
From: Mark Brown <broonie@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] regulator updates for v6.13
Date: Mon, 18 Nov 2024 13:32:49 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The following changes since commit 42f7652d3eb527d03665b09edac47f85fb600924:

  Linux 6.12-rc4 (2024-10-20 15:19:38 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-v6.13

for you to fetch changes up to 21ccadc64dae18bd092f1255bdbaf595f53381d5:

  regulator: dt-bindings: qcom,rpmh: Correct PM8550VE supplies (2024-11-13 13:53:14 +0000)

----------------------------------------------------------------
regulator: Updates for v6.13

This was a quite quiet release for regulators on the drivers front, but
we do have two small but useful core improvements:

 - Improve handling of cases where DT platforms specify both DT and
   init_data based configuration for a single regulator.
 - A helper of_regulator_get_optional() to simplify writing generic
   bindings for regulator consumers in subsystems.

There's also some YAML conversions for the DT bindings which are a big
part of the diffstat.

----------------------------------------------------------------
Anna-Maria Behnsen (1):
      regulator: core: Use fsleep() to get best sleep mechanism

Bartosz Golaszewski (1):
      regulator: dt-bindings: qcom,qca6390-pmu: add more properties for wcn6855

Chen-Yu Tsai (2):
      regulator: Add of_regulator_get_optional() for pure DT regulator lookup
      regulator: Add devres version of of_regulator_get_optional()

Dragan Simic (3):
      regulator: rk808: Perform trivial code cleanups
      regulator: rk808: Use dev_err_probe() in the probe path
      regulator: rk808: Restrict DVS GPIOs to the RK808 variant only

Heiko Stuebner (1):
      regulator: dt-bindings: vctrl-regulator: convert to YAML

Jerome Brunet (5):
      regulator: core: do not silently ignore provided init_data
      regulator: core: add callback to perform runtime init
      regulator: core: remove machine init callback from config
      regulator: doc: add missing documentation for init_cb
      regulator: doc: remove documentation comment for regulator_init

Marek Vasut (1):
      regulator: dt-bindings: lltc,ltc3676: convert to YAML

Mark Brown (3):
      Add of_regulator_get_optional() and Fix MTK Power
      regulator: Merge up v6.12-rc2
      regulator: init_data handling update

Markus Elfring (1):
      regulator: Call of_node_put() only once in rzg2l_usb_vbus_regulator_probe()

Melody Olvera (1):
      regulator: dt-bindings: qcom,rpmh: Correct PM8550VE supplies

Min-Hua Chen (1):
      regulator: qcom-smd: make smd_vreg_rpm static

Patrick Rudolph (1):
      regulator: max5970: Drop unused structs

Uwe Kleine-König (2):
      regulator: isl6271a: Drop explicit initialization of struct i2c_device_id::driver_data to 0
      regulator: Switch back to struct platform_driver::remove()

 .../bindings/regulator/lltc,ltc3676.yaml           | 167 +++++++++++++++++++++
 .../devicetree/bindings/regulator/ltc3676.txt      |  94 ------------
 .../bindings/regulator/qcom,qca6390-pmu.yaml       |  12 ++
 .../bindings/regulator/qcom,rpmh-regulator.yaml    |   2 +-
 .../bindings/regulator/vctrl-regulator.yaml        |  80 ++++++++++
 .../devicetree/bindings/regulator/vctrl.txt        |  49 ------
 drivers/regulator/arizona-ldo1.c                   |  12 +-
 drivers/regulator/bd9571mwv-regulator.c            |   2 +-
 drivers/regulator/core.c                           | 121 ++++++---------
 drivers/regulator/db8500-prcmu.c                   |   2 +-
 drivers/regulator/devres.c                         |  39 +++++
 drivers/regulator/internal.h                       |  18 ++-
 drivers/regulator/isl6271a-regulator.c             |   4 +-
 drivers/regulator/max5970-regulator.c              |  21 +--
 drivers/regulator/of_regulator.c                   |  51 ++++++-
 drivers/regulator/qcom_smd-regulator.c             |   2 +-
 drivers/regulator/renesas-usb-vbus-regulator.c     |   7 +-
 drivers/regulator/rk808-regulator.c                |  41 +++--
 drivers/regulator/stm32-vrefbuf.c                  |   2 +-
 drivers/regulator/uniphier-regulator.c             |   2 +-
 drivers/regulator/userspace-consumer.c             |   2 +-
 drivers/regulator/virtual.c                        |   2 +-
 drivers/regulator/wm8350-regulator.c               |   6 +-
 include/linux/mfd/max5970.h                        |  12 --
 include/linux/regulator/consumer.h                 |  37 +++++
 include/linux/regulator/driver.h                   |   7 +
 include/linux/regulator/machine.h                  |   5 +-
 27 files changed, 490 insertions(+), 309 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/regulator/lltc,ltc3676.yaml
 delete mode 100644 Documentation/devicetree/bindings/regulator/ltc3676.txt
 create mode 100644 Documentation/devicetree/bindings/regulator/vctrl-regulator.yaml
 delete mode 100644 Documentation/devicetree/bindings/regulator/vctrl.txt

