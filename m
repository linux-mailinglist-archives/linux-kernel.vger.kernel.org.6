Return-Path: <linux-kernel+bounces-416969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A5AA9D4D11
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 13:42:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4075283FE8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 12:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C8BE1D7E4C;
	Thu, 21 Nov 2024 12:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QLgq2nzD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 788291D63D5
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 12:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732192895; cv=none; b=AzAagu/M0aHi6eweeq2MUEpp3byPtAZNys23UE/k5e1emut+xJtqLquQVTo+z+8QdelZYzjsrnOCCKxMdJW2LUM3PkHSoEPZT9ZAQWJ1bfkzTkd6VaXTBIjJ0RgBvr7gSFMFX6IrClKhH9YicVrhOm+WHOHRcwDjDcjh9KhdIrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732192895; c=relaxed/simple;
	bh=DeN8zvbfqSKGmLsH0Xup7/rqdjcaoWdJdn+y4qfjH4I=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=LeP2mbzHkP/9N9zegYdA344QrYCEMRKeDtKgu8TC5BZCoQHkPSg5JN1yiGFJ5x0Gf+TO9HNEjYib0+0LPPGIq68krGgwwYijawXl6s13tCRO+BvTfxoGt8LiP5PyiAe8hU6NTwiI3+EX4RzdJ+ZcqcPo96l6tDkwQlE9zhoeU4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QLgq2nzD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18CCEC4CECC;
	Thu, 21 Nov 2024 12:41:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732192894;
	bh=DeN8zvbfqSKGmLsH0Xup7/rqdjcaoWdJdn+y4qfjH4I=;
	h=Date:From:To:Cc:Subject:From;
	b=QLgq2nzDWS5sier59fqDYLie8bmNnuu/OEbmLFbvAef0XmKAXiFsq8rzca/Y1B10b
	 WIDLU9wIIsx/jOUFU6f7QMBmtziKrZzO8dqAaZLnEuTXDEgw60Z5w4R2egZdA7TM38
	 3E1iUKzI8Il0P0rfziOkX6yHe/rVFPnYqvY7LG1+lRFRRRSagD0f2Ijh88SUKHT5Wx
	 a6mb13eT7Gb+IHauz5AWs9uQgi2vWK0NPEHqJifhIZKY0A/9ie6+N0T0rsZVBDn+rw
	 iWukxTjJyCXm9lgKKX1wK0flybwGQ8fvSmDQF9Nv4CRxipQTbqe4Vl/gmww3Rg1ah8
	 55TQEHEgKneoQ==
Date: Thu, 21 Nov 2024 12:41:31 +0000
From: Lee Jones <lee@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Pavel Machek <pavel@ucw.cz>
Subject: [GIT PULL] LEDs for v6.13
Message-ID: <20241121124131.GB7052@google.com>
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

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/lee/leds.git tags/leds-next-6.13

for you to fetch changes up to e8501858035b1f95468da525e7357c8c33811b88:

  leds: ss4200: Fix the wrong format specifier for 'blinking' (2024-11-12 14:39:26 +0000)

----------------------------------------------------------------
- Removed unused local header files from various drivers.
- Reverted platform driver removal to the original method for consistency.
- Introduced ordered workqueues for LED events, replacing the less efficient system_wq.
- Switched to a safer iteration macro in several drivers to prevent potential memory leaks.
- Fixed a refcounting bug in the mt6360 flash LED driver.
- Fixed an uninitialized variable in the mt6370_mc_pattern_clear() function.
- Resolved Smatch warnings in the leds-bcm6328 driver.
- Addressed a potential NULL pointer dereference in the brightness_show() function.
- Fixed an incorrect format specifier in the ss4200 driver.
- Prevented a resource leak in the max5970 driver's probe function.
- Added support for specifying the number of serial shift bits in the device tree for the BCM63138 family.
- Implemented multicolor brightness control in the lp5562 driver.
- Added a device tree property to override the default LED pin polarity.
- Added a property to specify the default brightness value when the LED is initially on.
- Set missing timing properties for the ktd2692 driver.
- Documented the "rc-feedback" trigger for controlling LEDs based on remote control activity.
- Converted text bindings to YAML for the pca955x driver to enable device tree validation.
- Removed redundant checks for invalid channel numbers in the lp55xx driver.
- Updated the MAINTAINERS file with current contact information.

----------------------------------------------------------------
Benedikt Niedermayr (1):
      MAINTAINERS: Replace Siemens IPC related bouncing maintainers

Daniel Golle (1):
      dt-bindings: leds: Add 'active-high' property

Dipendra Khadka (1):
      leds: bcm6328: Replace divide condition with comparison for shift value

Dmitry Rokosov (1):
      leds: Introduce ordered workqueue for LEDs events instead of system_wq

George Stark (2):
      dt-bindings: leds: pwm: Add default-brightness property
      leds: pwm: Add optional DT property default-brightness

Heiko Stuebner (1):
      dt-bindings: leds: Document "rc-feedback" trigger

Javier Carrasco (25):
      leds: flash: mt6360: Fix device_for_each_child_node() refcounting in error paths
      leds: flash: mt6370: Switch to device_for_each_child_node_scoped()
      leds: flash: leds-qcom-flash: Switch to device_for_each_child_node_scoped()
      leds: aw200xx: Switch to device_for_each_child_node_scoped()
      leds: cr0014114: Switch to device_for_each_child_node_scoped()
      leds: el15203000: Switch to device_for_each_child_node_scoped()
      leds: gpio: Switch to device_for_each_child_node_scoped()
      leds: lm3532: Switch to device_for_each_child_node_scoped()
      leds: lm3697: Switch to device_for_each_child_node_scoped()
      leds: lp50xx: Switch to device_for_each_child_node_scoped()
      leds: max77650: Switch to device_for_each_child_node_scoped()
      leds: ns2: Switch to device_for_each_child_node_scoped()
      leds: pca963x: Switch to device_for_each_child_node_scoped()
      leds: pwm: Switch to device_for_each_child_node_scoped()
      leds: sun50i-a100: Switch to device_for_each_child_node_scoped()
      leds: tca6507: Switch to device_for_each_child_node_scoped()
      leds: rgb: ktd202x: Switch to device_for_each_child_node_scoped()
      leds: rgb: mt6370: Switch to device_for_each_child_node_scoped()
      leds: flash: Remove unused local leds.h
      leds: multicolor: Remove unused local leds.h
      leds: gpio: Remove unused local leds.h
      leds: lp50xx: Remove unused local leds.h
      leds: pwm: Remove unused local leds.h
      leds: turris-omnia: Remove unused local leds.h
      leds: max5970: Fix unreleased fwnode_handle in probe function

Julia Lawall (1):
      leds: leds-gpio-register: Reorganize kerneldoc parameter names

Linus Walleij (4):
      dt-bindings: leds: bcm63138: Add shift register bits
      leds: bcm63138: Use scopes and guards
      leds: bcm63138: Handle shift register config
      leds: bcm63138: Add some register defines

Michal Vokáč (2):
      leds: lp5562: Add multicolor brightness control
      leds: lp55xx: Remove redundant test for invalid channel number

Mukesh Ojha (1):
      leds: class: Protect brightness_show() with led_cdev->led_access mutex

Raymond Hackley (1):
      leds: ktd2692: Set missing timing properties

Ricky CX Wu (1):
      dt-bindings: leds: pca955x: Convert text bindings to YAML

Suraj Sonawane (1):
      leds: rgb: leds-mt6370-rgb: Fix uninitialized variable 'ret' in mt6370_mc_pattern_clear

Uwe Kleine-König (1):
      leds: Switch back to struct platform_driver::remove()

WangYuli (1):
      leds: rgb: leds-group-multicolor: Correct the typo 'acccess'

Zhu Jun (1):
      leds: ss4200: Fix the wrong format specifier for 'blinking'

 Documentation/devicetree/bindings/leds/common.yaml |  16 +++
 .../devicetree/bindings/leds/leds-bcm63138.yaml    |  11 ++
 .../devicetree/bindings/leds/leds-pca955x.txt      |  89 ------------
 .../devicetree/bindings/leds/leds-pwm.yaml         |   6 +
 .../devicetree/bindings/leds/nxp,pca955x.yaml      | 158 +++++++++++++++++++++
 MAINTAINERS                                        |  12 +-
 drivers/leds/blink/leds-bcm63138.c                 |  29 ++--
 drivers/leds/blink/leds-lgm-sso.c                  |   2 +-
 drivers/leds/flash/leds-aat1290.c                  |   2 +-
 drivers/leds/flash/leds-ktd2692.c                  |   3 +-
 drivers/leds/flash/leds-max77693.c                 |   2 +-
 drivers/leds/flash/leds-mt6360.c                   |   5 +-
 drivers/leds/flash/leds-mt6370-flash.c             |  11 +-
 drivers/leds/flash/leds-qcom-flash.c               |   6 +-
 drivers/leds/flash/leds-rt8515.c                   |   2 +-
 drivers/leds/flash/leds-sgm3140.c                  |   2 +-
 drivers/leds/led-class-flash.c                     |   1 -
 drivers/leds/led-class-multicolor.c                |   2 -
 drivers/leds/led-class.c                           |  26 +++-
 drivers/leds/led-core.c                            |   6 +-
 drivers/leds/leds-88pm860x.c                       |   2 +-
 drivers/leds/leds-adp5520.c                        |   2 +-
 drivers/leds/leds-aw200xx.c                        |   7 +-
 drivers/leds/leds-bcm6328.c                        |   4 +-
 drivers/leds/leds-cht-wcove.c                      |   2 +-
 drivers/leds/leds-clevo-mail.c                     |   2 +-
 drivers/leds/leds-cr0014114.c                      |   4 +-
 drivers/leds/leds-da903x.c                         |   2 +-
 drivers/leds/leds-da9052.c                         |   2 +-
 drivers/leds/leds-el15203000.c                     |  14 +-
 drivers/leds/leds-gpio-register.c                  |   2 +-
 drivers/leds/leds-gpio.c                           |  11 +-
 drivers/leds/leds-lm3532.c                         |  18 +--
 drivers/leds/leds-lm3533.c                         |   2 +-
 drivers/leds/leds-lm3697.c                         |  18 +--
 drivers/leds/leds-lp50xx.c                         |  23 +--
 drivers/leds/leds-lp5562.c                         |  25 ++++
 drivers/leds/leds-lp55xx-common.c                  |   3 -
 drivers/leds/leds-max5970.c                        |   5 +-
 drivers/leds/leds-max77650.c                       |  18 +--
 drivers/leds/leds-mc13783.c                        |   2 +-
 drivers/leds/leds-mt6323.c                         |   2 +-
 drivers/leds/leds-ns2.c                            |   7 +-
 drivers/leds/leds-pca963x.c                        |  11 +-
 drivers/leds/leds-powernv.c                        |   4 +-
 drivers/leds/leds-pwm.c                            |  33 +++--
 drivers/leds/leds-rb532.c                          |   2 +-
 drivers/leds/leds-regulator.c                      |   2 +-
 drivers/leds/leds-sc27xx-bltc.c                    |   2 +-
 drivers/leds/leds-ss4200.c                         |   2 +-
 drivers/leds/leds-sun50i-a100.c                    |  29 ++--
 drivers/leds/leds-sunfire.c                        |   4 +-
 drivers/leds/leds-tca6507.c                        |   7 +-
 drivers/leds/leds-turris-omnia.c                   |   1 -
 drivers/leds/leds-wm831x-status.c                  |   2 +-
 drivers/leds/leds-wm8350.c                         |   2 +-
 drivers/leds/rgb/leds-group-multicolor.c           |   2 +-
 drivers/leds/rgb/leds-ktd202x.c                    |   8 +-
 drivers/leds/rgb/leds-mt6370-rgb.c                 |  39 ++---
 .../leds/simple/simatic-ipc-leds-gpio-apollolake.c |   2 +-
 .../simple/simatic-ipc-leds-gpio-elkhartlake.c     |   2 +-
 drivers/leds/simple/simatic-ipc-leds-gpio-f7188x.c |   2 +-
 include/linux/leds.h                               |   3 +-
 63 files changed, 397 insertions(+), 330 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/leds/leds-pca955x.txt
 create mode 100644 Documentation/devicetree/bindings/leds/nxp,pca955x.yaml
 
-- 
Lee Jones [李琼斯]

