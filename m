Return-Path: <linux-kernel+bounces-253883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 959D093283D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 16:23:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F43A1F2387F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 14:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57EF519B59B;
	Tue, 16 Jul 2024 14:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZeI001Rg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A37419B5A0
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 14:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721139766; cv=none; b=d2cygOB+W3lw1Q4KB/cdflgTBsGbXPDvWs9elMjUOaFampPvEHwGrPr1jPpi1lNaMK0/mxjh/rfIIyFoFHZQrCbSgXQybf9pjJZmu81BrHCaYQ/tojRZAewQm4iq6FsuZjZjn2V4VF0cHwZhv5POOZHF9CwoNo0IkZhZIvu9aLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721139766; c=relaxed/simple;
	bh=gr6iI4eifLhO3zZLLszmA1qsf82eyd2nZa2Q9lzbaJw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=JxM2QoJPIJweVK5mbGGgnD9MMoPdOLY5KpF/E9gT02CZ7QPKpj8Docp3rQR705yMTD2YR4aGjRS7eaYn21W1HrGEJGx+U08VXuSx1mO2TepsKSZfEKtq0ve+ukIFvaX3jji2XDXqkFcpzl1l9ssW9shDfbpKweQ5B6F1kL8TrrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZeI001Rg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 358AEC4AF09;
	Tue, 16 Jul 2024 14:22:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721139766;
	bh=gr6iI4eifLhO3zZLLszmA1qsf82eyd2nZa2Q9lzbaJw=;
	h=Date:From:To:Cc:Subject:From;
	b=ZeI001Rgk55X6j8mfbIsmBxb9ganAMosB3nH1W3OyUu8teKNiwQQtK11EkuuVo6sq
	 YBQa4jGcdvgNzGrFRdG/17NKJrhRqvBgHxC7Y+XKAvc3ACg1Te3lJP+fdcghNgy07E
	 ZdczE01jkwC0Ei/sVXS99m9xXF+HXNFLYg1Bx8hIXabLgYNoWKAko9cW+PRPvj7HKd
	 Dy6pqto1KvCGmBGjINOQd7kDlGnHCZRVK5qWcd/33VWeMSclFodhAvchVD/wmX89PJ
	 ikxEAJMG4SsJFGTTEBmRW5nO3vCSexAmfaWL6qNRx82rdqKiu9575EnPRKL36JAzj1
	 7E2hw/DB67HAg==
Date: Tue, 16 Jul 2024 15:22:42 +0100
From: Lee Jones <lee@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Pavel Machek <pavel@ucw.cz>
Subject: [GIT PULL] LEDs for v6.11
Message-ID: <20240716142242.GW501857@google.com>
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

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/lee/leds.git leds-next-6.11

for you to fetch changes up to b0eed397623f897d3ccac9bda2bd2f53331b571a:

  leds: leds-lp5569: Enable chip after chip configuration (2024-07-12 08:32:37 +0100)

----------------------------------------------------------------
 - Core Frameworks
   - Add new Trigger for Input Events
   - Add new led_mc_set_brightness() call to adapt colour/brightness for mutli-colour LEDs
   - Add new lled_mc_trigger_event() call to call the above based on given trigger conditions
   - Add new led_get_color_name() call, a wrapper around the existing led_colors[] array
   - Add a new flag to avoid automatic renaming of LED devices

 - New Drivers
   - Add support for Silergy SY7802 Flash LED Controller
   - Add support for Texas Instruments LP5569 LED Controller
   - Add support for ChromeOS EC LED Controller

 - New Device Support
   - Add support for KTD202{6,7} to Kinetic KTD2026/7 LEDs

 - Fix-ups
   - Replace ACPI/DT firmware helpers with agnostic variants
   - Make use of resource managed devm_* API calls
   - Device Tree binding adaptions/conversions/creation
   - Constify/staticise applicable data structures
   - Trivial; spelling, whitespace, coding-style adaptions
   - Drop i2c_device_id::driver_data where the value is unused
   - Utilise centrally provided helpers and macros to aid simplicity/duplication
   - Use generic platform device properties instead of OF/ACPI specific ones
   - Consolidate/de-duplicate various functionality
   - Remove superfluous/duplicated/unused sections
   - Make use of the new *_scoped() guard APIs
   - Improve/simplify error handling

 - Bug Fixes
   - Flush pending brightness changes before activating the trigger
   - Repair incorrect device naming preventing matches
   - Prevent memory leaks by correctly free resources during error handling routines
   - Repair locking issue causing circular dependency splats and lock-ups
   - Unregister sysfs entries before deactivating triggers to prevent use-after issues
   - Supply a bunch of MODULE_DESCRIPTIONs to silence modpost warnings
   - Use correct return codes expected by the callers
   - Omit set_brightness() error message for a LEDs that support only HW triggers

----------------------------------------------------------------
André Apitzsch (2):
      dt-bindings: leds: Add Silergy SY7802 flash LED
      leds: sy7802: Add support for Silergy SY7802 flash LED controller

Andy Shevchenko (6):
      leds: spi-byte: Call of_node_put() on error path
      leds: spi-byte: Get rid of custom led_init_default_state_get()
      leds: spi-byte: Make use of device properties
      leds: spi-byte: Utilise temporary variable for struct device
      leds: spi-byte: Use devm_mutex_init() for mutex initialization
      leds: spi-byte: Move OF ID table closer to their user

Anjelique Melendez (1):
      leds: rgb: leds-qcom-lpg: Add PPG check for setting/clearing PBS triggers

Aryabhatta Dey (1):
      docs: leds: leds-blinkm.rst: Fix 'dasy-chain' typo

Bastien Curutchet (4):
      leds: pca9532: Use defines to select PWM instance
      leds: pca9532: Use PWM1 for hardware blinking
      leds: pca9532: Explicitly disable hardware blink when PWM1 is unavailable
      leds: pca9532: Change default blinking frequency to 1Hz

Christian Marangi (26):
      dt-bindings: leds-lp55xx: Limit pwr-sel property to ti,lp8501
      dt-bindings: leds-lp55xx: Add new ti,lp5569 compatible
      leds: leds-lp55xx: Generalize stop_all_engine OP
      leds: leds-lp55xx: Generalize probe/remove functions
      leds: leds-lp55xx: Generalize load_engine function
      leds: leds-lp55xx: Generalize load_engine_and_select_page function
      leds: leds-lp55xx: Generalize run_engine function
      leds: leds-lp55xx: Generalize update_program_memory function
      leds: leds-lp55xx: Generalize firmware_loaded function
      leds: leds-lp55xx: Generalize led_brightness function
      leds: leds-lp55xx: Generalize multicolor_brightness function
      leds: leds-lp55xx: Generalize set_led_current function
      leds: leds-lp55xx: Generalize turn_off_channels function
      leds: leds-lp55xx: Generalize stop_engine function
      leds: leds-lp55xx: Generalize sysfs engine_load and engine_mode
      leds: leds-lp55xx: Generalize sysfs engine_leds
      leds: leds-lp55xx: Generalize sysfs master_fader
      leds: leds-lp55xx: Support ENGINE program up to 128 bytes
      leds: leds-lp55xx: Drop deprecated defines
      leds: leds-lp5569: Add support for Texas Instruments LP5569
      leds: leds-lp5569: Convert to sysfs_emit API
      leds: leds-lp5523: Convert to sysfs_emit API
      leds: leds-lp55xx: Convert mutex lock/unlock to guard API
      leds: leds-lp5569: Fix typo in driver name
      leds: leds-lp5569: Better handle enabling clock internal setting
      leds: leds-lp5569: Enable chip after chip configuration

Christophe JAILLET (1):
      leds: is31fl319x: Constify struct regmap_config

Dan Carpenter (1):
      leds: flash: leds-qcom-flash: Test the correct variable in init

Hans de Goede (7):
      leds: rgb: leds-ktd202x: Initialize mutex earlier
      leds: core: Add led_mc_set_brightness() function
      leds: trigger: Add led_mc_trigger_event() function
      leds: trigger: Unregister sysfs attributes before calling deactivate()
      leds: trigger: Call synchronize_rcu() before calling trig->activate()
      leds: trigger: Add new LED Input events trigger
      leds: trigger: input-events: Rewrite to fix a serious locking issue

Ilpo Järvinen (1):
      leds: ss4200: Convert PCIBIOS_* return codes to errnos

Javier Carrasco (1):
      leds: mt6360: Fix memory leak in mt6360_init_isnk_properties()

Jeff Johnson (3):
      leds: rt4505: Add MODULE_DESCRIPTION()
      leds: simatic-ipc-leds: Add missing MODULE_DESCRIPTION() macros
      leds: bcm63138: Add MODULE_DESCRIPTION()

Kate Hsuan (3):
      leds: rgb: leds-ktd202x: Get device properties through fwnode to support ACPI
      leds: rgb: leds-ktd202x: I2C ID tables for KTD2026 and 2027
      power: supply: power-supply-leds: Add charging_orange_full_green trigger for RGB LED

Lee Jones (3):
      Merge branches 'ib-leds-mfd-6.11', 'ib-leds-platform-power-6.11' and 'ib-mfd-leds-platform-6.11' into ibs-for-leds-merged
      leds: core: Omit set_brightness error message for a LED supporting hw trigger only
      MAINTAINERS: Update LED's active maintainer tree

Luca Ceresoli (1):
      Revert "leds: led-core: Fix refcount leak in of_led_get()"

Marilene A Garcia (1):
      leds: tlc591xx: Replace of_node_put to __free

MarileneGarcia (1):
      leds: powernv: Replace of_node_put to __free

Markus Elfring (1):
      leds: ncp5623: Use common error handling code in ncp5623_probe()

Thomas Weißschuh (10):
      leds: class: Warn about name collisions earlier
      leds: class: Add flag to avoid automatic renaming of LED devices
      platform/chrome: cros_kbd_led_backlight: allow binding through MFD
      mfd: cros_ec: Register keyboard backlight subdevice
      leds: core: Introduce led_get_color_name() function
      leds: multicolor: Use led_get_color_name() function
      leds: core: Unexport led_colors[] array
      leds: Add ChromeOS EC driver
      mfd: cros_ec: Register LED subdevice
      leds: triggers: Flush pending brightness before activating trigger

Uwe Kleine-König (1):
      leds: Drop explicit initialization of struct i2c_device_id::driver_data to 0

 .../devicetree/bindings/leds/leds-lp55xx.yaml      |  11 +
 .../devicetree/bindings/leds/silergy,sy7802.yaml   | 100 +++
 Documentation/leds/leds-blinkm.rst                 |   2 +-
 MAINTAINERS                                        |   7 +-
 drivers/leds/Kconfig                               |  32 +-
 drivers/leds/Makefile                              |   2 +
 drivers/leds/blink/leds-bcm63138.c                 |   1 +
 drivers/leds/flash/Kconfig                         |  11 +
 drivers/leds/flash/Makefile                        |   1 +
 drivers/leds/flash/leds-as3645a.c                  |   4 +-
 drivers/leds/flash/leds-mt6360.c                   |   5 +-
 drivers/leds/flash/leds-qcom-flash.c               |  10 +-
 drivers/leds/flash/leds-rt4505.c                   |   1 +
 drivers/leds/flash/leds-sy7802.c                   | 539 +++++++++++++++
 drivers/leds/led-class-multicolor.c                |   3 +-
 drivers/leds/led-class.c                           |  10 +-
 drivers/leds/led-core.c                            |  62 +-
 drivers/leds/led-triggers.c                        |  35 +-
 drivers/leds/leds-an30259a.c                       |   4 +-
 drivers/leds/leds-bd2802.c                         |   2 +-
 drivers/leds/leds-blinkm.c                         |   2 +-
 drivers/leds/leds-cros_ec.c                        | 277 ++++++++
 drivers/leds/leds-is31fl319x.c                     |   4 +-
 drivers/leds/leds-lm3530.c                         |   2 +-
 drivers/leds/leds-lm3532.c                         |   2 +-
 drivers/leds/leds-lm3642.c                         |   2 +-
 drivers/leds/leds-lm3697.c                         |   2 +-
 drivers/leds/leds-lp3944.c                         |   2 +-
 drivers/leds/leds-lp3952.c                         |   2 +-
 drivers/leds/leds-lp5521.c                         | 410 +----------
 drivers/leds/leds-lp5523.c                         | 763 ++-------------------
 drivers/leds/leds-lp5562.c                         | 274 +-------
 drivers/leds/leds-lp5569.c                         | 544 +++++++++++++++
 drivers/leds/leds-lp55xx-common.c                  | 760 ++++++++++++++++++--
 drivers/leds/leds-lp55xx-common.h                  | 163 +++--
 drivers/leds/leds-lp8501.c                         | 313 +--------
 drivers/leds/leds-lp8860.c                         |   2 +-
 drivers/leds/leds-pca9532.c                        |  81 ++-
 drivers/leds/leds-powernv.c                        |  28 +-
 drivers/leds/leds-spi-byte.c                       |  63 +-
 drivers/leds/leds-ss4200.c                         |   7 +-
 drivers/leds/leds-tlc591xx.c                       |  18 +-
 drivers/leds/leds-turris-omnia.c                   |   2 +-
 drivers/leds/leds.h                                |   1 -
 drivers/leds/rgb/Kconfig                           |   1 -
 drivers/leds/rgb/leds-ktd202x.c                    |  80 ++-
 drivers/leds/rgb/leds-ncp5623.c                    |  16 +-
 drivers/leds/rgb/leds-qcom-lpg.c                   |   8 +-
 .../leds/simple/simatic-ipc-leds-gpio-apollolake.c |   1 +
 drivers/leds/simple/simatic-ipc-leds-gpio-core.c   |   1 +
 .../simple/simatic-ipc-leds-gpio-elkhartlake.c     |   1 +
 drivers/leds/simple/simatic-ipc-leds-gpio-f7188x.c |   1 +
 drivers/leds/simple/simatic-ipc-leds.c             |   1 +
 drivers/leds/trigger/Kconfig                       |  16 +
 drivers/leds/trigger/Makefile                      |   1 +
 drivers/leds/trigger/ledtrig-input-events.c        | 165 +++++
 drivers/leds/trigger/ledtrig-timer.c               |   5 -
 drivers/mfd/cros_ec_dev.c                          |  18 +
 drivers/platform/chrome/Kconfig                    |   2 +-
 drivers/platform/chrome/cros_kbd_led_backlight.c   |  40 +-
 drivers/power/supply/power_supply_leds.c           |  23 +
 include/linux/leds.h                               |  37 +
 include/linux/power_supply.h                       |   2 +
 63 files changed, 3110 insertions(+), 1875 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/leds/silergy,sy7802.yaml
 create mode 100644 drivers/leds/flash/leds-sy7802.c
 create mode 100644 drivers/leds/leds-cros_ec.c
 create mode 100644 drivers/leds/leds-lp5569.c
 create mode 100644 drivers/leds/trigger/ledtrig-input-events.c

-- 
Lee Jones [李琼斯]

