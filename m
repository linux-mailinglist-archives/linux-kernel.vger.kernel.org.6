Return-Path: <linux-kernel+bounces-186028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E9818CBEF8
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 12:06:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81BC31C21BC2
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 10:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9881D82481;
	Wed, 22 May 2024 10:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l83kRea4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C8E823CA
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 10:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716372354; cv=none; b=E3jHmfx2Nwdf09Y9MKJ0REOIak2lNtV3sEEvHOcBj7giZMat3c/iOx3ixSL06ENLT1OKYvwerWz0skQru5FwLVBO1hUbaDOP87pyhAyUQbDhsyZhfsz/b7qHaqb5e1Nx5tWNyVBzFrn2z/oFVLx92mJyqrNk07lA2RGTyQjyjzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716372354; c=relaxed/simple;
	bh=jfAFk1AVL+1cNU/MR0f13O9MJ4SiqSbUIP/Zk4xMcWU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=E/Hu6j3lxhFyFWeq5MV8kLOiSF7nHia9iPp6H/J9WOcPskMJrl/E6ZEXOjo1maGZbiAy4yjf4+KxM6hDbWZuRbdKVYY8ti8+PQ+F4PmM9WyXD9CzOJnM/67MYFscK/3MmD/VV7EjlOj73OkCi2s3LatPUv8kv1IBR3qukORUetc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l83kRea4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81576C2BD11;
	Wed, 22 May 2024 10:05:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716372354;
	bh=jfAFk1AVL+1cNU/MR0f13O9MJ4SiqSbUIP/Zk4xMcWU=;
	h=Date:From:To:Cc:Subject:From;
	b=l83kRea4JahLC5f6Qc9QgZo9CU78mnwMlGPnZefxlChmPmh3Hd3+I6ey1bQxoHzeZ
	 4pR+TtoYVD6BHpu/knUG0hEfrtGl3JoQc1Upz948DU51UAtJoL9rPpmgLUl1ETvXA6
	 HW7UlxiA7V/cGktf8wUDMi30D+1oCPgieZZnp1GZSda+jjn4wNi6ViwODW+k5kxC3r
	 S1h26wOWTkq+kci+MfrvPQ7+OQyZAnD+DjRyd6zO4MiBi+msctUldgTBV0cxECAaRD
	 hLNwboylz4Xa6mg1I4f1ZVBFDhXL8rMf9ZjFbdI0i6/dHdi3uS4UynEJo4SUheO9LK
	 bq3Xr8V+DWvPg==
Date: Wed, 22 May 2024 11:05:50 +0100
From: Lee Jones <lee@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Pavel Machek <pavel@ucw.cz>
Subject: [GIT PULL] LEDs for v6.10
Message-ID: <20240522100550.GD6035@google.com>
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

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/lee/leds tags/leds-next-6.10

for you to fetch changes up to f2994f5341e03b8680a88abc5f1dee950033c3a9:

  leds: mt6370: Remove unused field 'reg_cfgs' from 'struct mt6370_priv' (2024-05-02 18:12:27 +0100)

----------------------------------------------------------------
 - Core Frameworks
   - Ensure seldom updated triggers have a brightness value before first update

 - New Device Support
   - Add support for Simatic IPC Device BX_59A to IPC LEDs Core
   - Add support for Qualcomm PMI8950 PWM to LPG Core

 - New Functionality
   - Add a bunch of new LED function identifiers
   - Add support for High Resolution Timers in LED Trigger Patten

 - Fix-ups
   - Shift out Audio Trigger to the Sound subsystem
   - Convert suitable calls to devm_* managed resources
   - Device Tree binding adaptions/conversions/creation
   - Remove superfluous code/variables/attributes and simplify overall
   - Use/convert to new/better APIs/helpers/MACROs instead of hand-rolling implementations

 - Bug Fixes
   - Repair enabling Torch Mode from V4L2 on the second LED
   - Ensure PWM is disabled when suspending

----------------------------------------------------------------
Andy Shevchenko (1):
      leds: sun50i-a100: Use match_string() helper to simplify the code

Arnd Bergmann (1):
      leds: apu: Remove duplicate DMI lookup data

ChiaEn Wu (1):
      leds: mt6360: Fix the second LED can not enable torch mode by V4L2

Christophe JAILLET (4):
      leds: aat1290: Remove unused field 'torch_brightness' from 'struct aat1290_led'
      leds: lp50xx: Remove unused field 'bank_modules' from 'struct lp50xx_led'
      leds: lp50xx: Remove unused field 'num_of_banked_leds' from 'struct lp50xx'
      leds: mt6370: Remove unused field 'reg_cfgs' from 'struct mt6370_priv'

Danila Tikhonov (1):
      dt-bindings: leds: qcom-lpg: Document PM6150L compatible

George Stark (8):
      locking/mutex: Introduce devm_mutex_init()
      leds: aw2013: Use devm API to cleanup module's resources
      leds: aw200xx: Use devm API to cleanup module's resources
      leds: lp3952: Use devm API to cleanup module's resources
      leds: lm3532: Use devm API to cleanup module's resources
      leds: nic78bx: Use devm API to cleanup module's resources
      leds: mlxreg: Use devm_mutex_init() for mutex initialization
      leds: an30259a: Use devm_mutex_init() for mutex initialization

Gianluca Boiano (2):
      leds: qcom-lpg: Add support for PMI8950 PWM
      dt-bindings: leds: leds-qcom-lpg: Add support for PMI8950 PWM

Heiner Kallweit (4):
      leds: trigger: Store brightness set by led_trigger_event()
      ALSA: control-led: Integrate mute led trigger
      leds: trigger: audio: Remove this trigger
      leds: trigger: netdev: Remove not needed call to led_set_brightness in deactivate

INAGAKI Hiroshi (2):
      dt-bindings: leds: Add LED_FUNCTION_MOBILE for mobile network
      dt-bindings: leds: Add LED_FUNCTION_SPEED_* for link speed on LAN/WAN

Laurent Pinchart (1):
      dt-bindings: leds: pca963x: Convert text bindings to YAML

Lee Jones (1):
      Merge branches 'ib-leds-mips-sound-6.10' and 'ib-leds-locking-6.10' into ibs-for-leds-merged

Martin Kurbanov (1):
      leds: trigger: pattern: Add support for hrtimer

Uwe Kleine-König (1):
      leds: pwm: Disable PWM when going to suspend

Xing Tong Wu (1):
      leds: simatic-ipc-leds-gpio: Add support for module BX-59A

 .../ABI/testing/sysfs-class-led-trigger-pattern    |  10 ++
 .../devicetree/bindings/leds/leds-qcom-lpg.yaml    |   8 +-
 .../devicetree/bindings/leds/nxp,pca963x.yaml      | 140 +++++++++++++++++++++
 Documentation/devicetree/bindings/leds/pca963x.txt |  52 --------
 arch/mips/configs/ci20_defconfig                   |   1 -
 drivers/leds/flash/leds-aat1290.c                  |   2 -
 drivers/leds/flash/leds-mt6360.c                   |  12 +-
 drivers/leds/led-triggers.c                        |   6 +-
 drivers/leds/leds-an30259a.c                       |  14 +--
 drivers/leds/leds-apu.c                            |   3 +-
 drivers/leds/leds-aw200xx.c                        |  32 +++--
 drivers/leds/leds-aw2013.c                         |  25 ++--
 drivers/leds/leds-lm3532.c                         |  29 +++--
 drivers/leds/leds-lp3952.c                         |  21 ++--
 drivers/leds/leds-lp50xx.c                         |   5 -
 drivers/leds/leds-mlxreg.c                         |  14 +--
 drivers/leds/leds-nic78bx.c                        |  23 ++--
 drivers/leds/leds-pwm.c                            |   8 +-
 drivers/leds/leds-sun50i-a100.c                    |  14 +--
 drivers/leds/rgb/leds-mt6370-rgb.c                 |   1 -
 drivers/leds/rgb/leds-qcom-lpg.c                   |   8 ++
 drivers/leds/simple/simatic-ipc-leds-gpio-core.c   |   1 +
 drivers/leds/simple/simatic-ipc-leds-gpio-f7188x.c |  52 +++++++-
 drivers/leds/trigger/Kconfig                       |   7 --
 drivers/leds/trigger/Makefile                      |   1 -
 drivers/leds/trigger/ledtrig-audio.c               |  67 ----------
 drivers/leds/trigger/ledtrig-netdev.c              |   2 -
 drivers/leds/trigger/ledtrig-pattern.c             | 126 +++++++++++++++----
 include/dt-bindings/leds/common.h                  |   3 +
 include/linux/leds.h                               |  29 ++---
 include/linux/mutex.h                              |  27 ++++
 kernel/locking/mutex-debug.c                       |  12 ++
 sound/core/Kconfig                                 |   1 -
 sound/core/control_led.c                           |  20 ++-
 34 files changed, 501 insertions(+), 275 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/leds/nxp,pca963x.yaml
 delete mode 100644 Documentation/devicetree/bindings/leds/pca963x.txt
 delete mode 100644 drivers/leds/trigger/ledtrig-audio.c

-- 
Lee Jones [李琼斯]

