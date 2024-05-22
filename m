Return-Path: <linux-kernel+bounces-186023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D9AAB8CBEEB
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 12:04:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 087131C21839
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 10:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF80981219;
	Wed, 22 May 2024 10:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oGch9krJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC50F7E572
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 10:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716372267; cv=none; b=BJ6tmTglY8M3N4zF/H9ysACsnRTepLoFBBfmH8HOloeMhuEBewpiobpmFlN4epelErSYWsWI0PBABQiBxxZGpRuOFCQeYVyZBZYbdpCwo3Lx9TQgFndjbFVqYLu574RrmoAA/86uGURGb7tF/VNaOzcI7O5frFct14r9i1werko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716372267; c=relaxed/simple;
	bh=r2aTjwr63X9DEKuVZ3pWPxsKeT7TlJApCdsq8TPv88Y=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=PgE3hr7ZTBAujGrUt1jXRxfR10zlroevYAesSj30vaJi5kf5EPlFmj2o1U5QX3LCJxypaGKW7c2Tbu5cglxcCxQaqJ6oC1YuC1uxLA2ztTRH7aIZNdOqCpgg1NK9CJ6xoNPsSKAhnXTBt+AIxKpvsDBtHFKjD/Gf5M4iKWeqZ/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oGch9krJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CAD5C2BD11;
	Wed, 22 May 2024 10:04:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716372267;
	bh=r2aTjwr63X9DEKuVZ3pWPxsKeT7TlJApCdsq8TPv88Y=;
	h=Date:From:To:Cc:Subject:From;
	b=oGch9krJcdMaGxQoxvjCupdPwWwsSCrkOLXU2PBC2cdBiwt0FQ4HLbcRKRIwFxakR
	 wRvV/O2Vlg9aPThoLMMGnajBgD1CrUpUhpHhIgiY6T1TANeHiQThPBoGZlHM4gfsMU
	 Gd8Rm0JufaoxZogEUx5bjdFp9ZIDTtIp0mSgVBP5XQ59qNSVB//yDlwnhm+zAZumeP
	 rdfkN0cXG6my4kr+Fd+dTUXgTfO/4QcXJ2JiSfPBFuQkb2ZrSVR/ApF+6b1xpHqLw9
	 7jfxFV9SAQzR8NcbUrSvv6hRp0o3/wH2O5ajyGlKDSCnnMPExJSFM5HfxpVYNEN6wE
	 4u+Vret6OrP/w==
Date: Wed, 22 May 2024 11:04:23 +0100
From: Lee Jones <lee@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Daniel Thompson <daniel.thompson@linaro.org>
Subject: [GIT PULL] Backlight for v6.10
Message-ID: <20240522100423.GC6035@google.com>
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

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/lee/backlight tags/backlight-next-6.10

for you to fetch changes up to 1fd949f653ee1a3c1776ef8a5295ae072c9b67f2:

  backlight: sky81452-backlight: Remove unnecessary call to of_node_get() (2024-05-10 15:44:29 +0100)

----------------------------------------------------------------
 - Fix-ups
   - FB Backlight interaction overhaul
   - Remove superfluous code and simplify overall
   - Constify various structs and struct attributes

 - Bug Fixes
   - Repair LED flickering
   - Fix signedness bugs

----------------------------------------------------------------
Dan Carpenter (1):
      backlight: mp3309c: Fix signedness bug in mp3309c_parse_fwnode()

Flavio Suligoi (1):
      backlight: mp3309c: Fix LEDs flickering in PWM mode

Krzysztof Kozlowski (20):
      backlight: lcd: Constify lcd_ops
      backlight: ams369fg06: Constify lcd_ops
      backlight: corgi_lcd: Constify lcd_ops
      backlight: hx8357: Constify lcd_ops
      backlight: ili922x: Constify lcd_ops
      backlight: ili9320: Constify lcd_ops
      backlight: jornada720_lcd: Constify lcd_ops
      backlight: l4f00242t03: Constify lcd_ops
      backlight: lms283gf05: Constify lcd_ops
      backlight: lms501kf03: Constify lcd_ops
      backlight: ltv350qv: Constify lcd_ops
      backlight: otm3225a: Constify lcd_ops
      backlight: platform_lcd: Constify lcd_ops
      backlight: tdo24m: Constify lcd_ops
      HID: picoLCD: Constify lcd_ops
      fbdev: clps711x: Constify lcd_ops
      fbdev: imx: Constify lcd_ops
      fbdev: omap: lcd_ams_delta: Constify lcd_ops
      const_structs.checkpatch: add lcd_ops
      backlight: otm3225a: Drop driver owner assignment

Lee Jones (1):
      Merge branches 'ib-backlight-auxdisplay-staging-omap-6.9', 'ib-backlight-auxdisplay-hid-fb-6.9' and 'ib-backlight-hid-fbdev-lcd-scripts-6.10' into ibs-for-backlight-merged

Ricardo B. Marliere (2):
      backlight: Make backlight_class constant
      backlight: lcd: Make lcd_class constant

Shresth Prasad (1):
      backlight: sky81452-backlight: Remove unnecessary call to of_node_get()

Thomas Zimmermann (16):
      backlight: Match backlight device against struct fb_info.bl_dev
      auxdisplay: ht16k33: Remove struct backlight_ops.check_fb
      hid: hid-picolcd: Fix initialization order
      hid: hid-picolcd: Remove struct backlight_ops.check_fb
      backlight: aat2870-backlight: Remove struct backlight.check_fb
      backlight: pwm-backlight: Remove struct backlight_ops.check_fb
      fbdev: sh_mobile_lcdc_fb: Remove struct backlight_ops.check_fb
      fbdev: ssd1307fb: Init backlight before registering framebuffer
      fbdev: ssd1307fb: Remove struct backlight_ops.check_fb
      backlight: Add controls_device callback to struct backlight_ops
      auxdisplay: ht16k33: Replace use of fb_blank with backlight helper
      backlight: omap1: Remove unused struct omap_backlight_config.set_power
      backlight: omap1: Replace FB_BLANK_ states with simple on/off
      fbdev: omap2/omapfb: Replace use of fb_blank with backlight helpers
      staging: fbtft: Remove reference to fb_blank
      backlight: Remove fb_blank from struct backlight_properties

Uwe Kleine-König (1):
      backlight: lp8788: Drop support for platform data

 drivers/auxdisplay/ht16k33.c                       |  15 +-
 drivers/hid/hid-picolcd_backlight.c                |   7 -
 drivers/hid/hid-picolcd_core.c                     |  14 +-
 drivers/hid/hid-picolcd_fb.c                       |   6 +
 drivers/hid/hid-picolcd_lcd.c                      |   2 +-
 drivers/staging/fbtft/fb_ssd1351.c                 |   4 +-
 drivers/staging/fbtft/fbtft-core.c                 |   5 +-
 drivers/video/backlight/aat2870_bl.c               |   7 -
 drivers/video/backlight/ams369fg06.c               |   2 +-
 drivers/video/backlight/backlight.c                |  39 +++---
 drivers/video/backlight/bd6107.c                   |  12 +-
 drivers/video/backlight/corgi_lcd.c                |   2 +-
 drivers/video/backlight/gpio_backlight.c           |  12 +-
 drivers/video/backlight/hx8357.c                   |   2 +-
 drivers/video/backlight/ili922x.c                  |   2 +-
 drivers/video/backlight/ili9320.c                  |   2 +-
 drivers/video/backlight/jornada720_lcd.c           |   2 +-
 drivers/video/backlight/l4f00242t03.c              |   2 +-
 drivers/video/backlight/lcd.c                      |  27 ++--
 drivers/video/backlight/lms283gf05.c               |   2 +-
 drivers/video/backlight/lms501kf03.c               |   2 +-
 drivers/video/backlight/lp8788_bl.c                | 151 ++-------------------
 drivers/video/backlight/ltv350qv.c                 |   2 +-
 drivers/video/backlight/lv5207lp.c                 |  12 +-
 drivers/video/backlight/mp3309c.c                  |   9 +-
 drivers/video/backlight/omap1_bl.c                 |  47 +++----
 drivers/video/backlight/otm3225a.c                 |   3 +-
 drivers/video/backlight/platform_lcd.c             |   2 +-
 drivers/video/backlight/pwm_bl.c                   |  12 --
 drivers/video/backlight/sky81452-backlight.c       |   8 +-
 drivers/video/backlight/tdo24m.c                   |   2 +-
 drivers/video/fbdev/atmel_lcdfb.c                  |   1 -
 drivers/video/fbdev/clps711x-fb.c                  |   2 +-
 drivers/video/fbdev/core/fb_backlight.c            |   6 +
 drivers/video/fbdev/imxfb.c                        |   2 +-
 drivers/video/fbdev/omap/lcd_ams_delta.c           |   2 +-
 .../fbdev/omap2/omapfb/displays/panel-dsi-cm.c     |   7 +-
 .../omap2/omapfb/displays/panel-sony-acx565akm.c   |  10 +-
 drivers/video/fbdev/sh_mobile_lcdcfb.c             |   7 -
 drivers/video/fbdev/ssd1307fb.c                    |  31 ++---
 include/linux/backlight.h                          |  41 ++----
 include/linux/fb.h                                 |   9 ++
 include/linux/lcd.h                                |   6 +-
 include/linux/mfd/lp8788.h                         |  36 -----
 include/linux/platform_data/omap1_bl.h             |   1 -
 include/linux/pwm_backlight.h                      |   1 -
 scripts/const_structs.checkpatch                   |   1 +
 47 files changed, 161 insertions(+), 418 deletions(-)

-- 
Lee Jones [李琼斯]

