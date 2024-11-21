Return-Path: <linux-kernel+bounces-416972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C00349D4D15
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 13:44:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45CD1B27506
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 12:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B649D1D6DB6;
	Thu, 21 Nov 2024 12:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lDNs9vWS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D791D3644
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 12:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732193043; cv=none; b=i3a9ePjzfBlPw4tmdEX5lvVJcI694wW8F3qgRyXS5bR7E7/bBSdY+Ri0jHGnTHxX5kMJladfkS3I7CIBgFACKdzhHAUDVMpDJJbkgVq9YrmLZz6bRJOrTlgHt2D/ZboTqN8YgwBblWihR7U50E9MvAYiBj2tutxpoj99o+BxgT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732193043; c=relaxed/simple;
	bh=53esgrAnmt6HNtLTmQiYxPj8MuMWJ+xwI5VIL+xLOCs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=QokFJSm/OQeGuuH6FyiBV9wU66QfBOX91X//ZEuGNr6u2Yk43vN/lrL2q/YflQuPn6yrbe+F1BilsucXDQiHsjTlg3xHbC6mC9uMYVAZOlqz9ie/W+eGebk5gJq6xPpWL+Cne9DAOwf0p6bXJ3aWwL91eFH+6NrRbUqkOuENkNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lDNs9vWS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2754C4CECD;
	Thu, 21 Nov 2024 12:44:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732193042;
	bh=53esgrAnmt6HNtLTmQiYxPj8MuMWJ+xwI5VIL+xLOCs=;
	h=Date:From:To:Cc:Subject:From;
	b=lDNs9vWSfDcs8G9k9m6Yn/Tl3559xijA5O3NvhmVev7fKIsUH1khLPhske/Ozx8Gw
	 B756dzzTAEyq00UTqARZtVlJrSbMKbRpsNYWrwxuDn5V9DGxr9wr4q6nIOtFZ/dMGC
	 xqkuKuRJEjuG7lRxAvOxnGv3xbKd2PQ+6fH+Sluy6emHmXtwbX4xthyoVCIeV6LOW9
	 eDDWVbC+xx2Q1DqY/XTmEt7kwZ096lV6dj/5334fca6FcDsAH9npBpu8w0Y07jZZbJ
	 U3+Sw1gNTfRIsY3ZaPqUc9CI15ZbhNiYoXjf+mNSbK5mCs8ymHgPUrlE59YXSf0vgo
	 R/0GFsVTYBLGg==
Date: Thu, 21 Nov 2024 12:43:58 +0000
From: Lee Jones <lee@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Daniel Thompson <danielt@kernel.org>
Subject: [GIT PULL] Backlight for v6.13
Message-ID: <20241121124358.GC7052@google.com>
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

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/lee/backlight.git tags/backlight-next-6.13

for you to fetch changes up to 3adec6f907b698b32ab62f70da31b41abed00c59:

  MAINTAINERS: Use Daniel Thompson's korg address for Backlight work (2024-11-11 16:42:02 +0000)

----------------------------------------------------------------
- Improved handling of LCD power states and interactions with the fbdev subsystem.
- Introduced new LCD_POWER_ constants to decouple the LCD subsystem from fbdev.
- Clarified the semantics of the lcd_ops.controls_device callback.
- Removed unnecessary includes and dependencies.
- Removed unused notifier functionality.
- Simplified code with scoped for-each loops.
- Fixed module autoloading for the ktz8866 driver.
- Updated device tree bindings to yaml format.
- Minor cleanups and improvements in various drivers.

----------------------------------------------------------------
Daniel Thompson (1):
      MAINTAINERS: Use Daniel Thompson's korg address for Backlight work

Dr. David Alan Gilbert (1):
      backlight: Remove notifier

Frank Li (1):
      dt-bindings: backlight: Convert zii,rave-sp-backlight.txt to yaml

Jinjie Ruan (1):
      backlight: 88pm860x_bl: Simplify with scoped for each OF child loop

Liao Chen (1):
      backlight: ktz8866: Fix module autoloading

Thomas Zimmermann (28):
      backlight: lcd: Rearrange code in fb_notifier_callback()
      backlight: lcd: Test against struct fb_info.lcd_dev
      backlight: lcd: Add LCD_POWER_ constants for power states
      backlight: corgi_lcd: Use lcd power constants
      backlight: hx8357: Use lcd power constants
      backlight: ili922x: Use lcd power constants
      backlight: ili9320: Use lcd power constants
      backlight: jornada720_lcd: Include <linux/io.h> for IOMEM() macro
      backlight: jornada720_lcd: Use lcd power constants
      backlight: l4f00242t03: Use lcd power constants
      backlight: lms283gf05: Use lcd power constants
      backlight: lms501kf03: Remove unnecessary include of <linux/backlight.h>
      backlight: lms501kf03: Use lcd power constants
      backlight: ltv350qv: Use lcd power constants
      backlight: otm3225a: Use lcd power constants
      backlight: platform_lcd: Remove include statement for <linux/backlight.h>
      backlight: platform_lcd: Remove match_fb from struct plat_lcd_data
      backlight: platform_lcd: Use lcd power constants
      backlight: tdo24m: Use lcd power constants
      fbdev: clps711x-fb: Replace check_fb in favor of struct fb_info.lcd_dev
      fbdev: clps711x-fb: Use lcd power constants
      fbdev: imxfb: Replace check_fb in favor of struct fb_info.lcd_dev
      fbdev: imxfb: Use lcd power constants
      fbdev: omap: Use lcd power constants
      HID: picoLCD: Replace check_fb in favor of struct fb_info.lcd_dev
      backlight: lcd: Replace check_fb with controls_device
      backlight: lcd: Remove struct fb_videomode from set_mode callback
      backlight: lcd: Do not include <linux/fb.h> in lcd header

 .../leds/backlight/zii,rave-sp-backlight.txt       | 23 ----------
 .../leds/backlight/zii,rave-sp-backlight.yaml      | 36 ++++++++++++++++
 MAINTAINERS                                        |  2 +-
 drivers/hid/hid-picolcd_fb.c                       |  4 ++
 drivers/hid/hid-picolcd_lcd.c                      |  6 ---
 drivers/video/backlight/88pm860x_bl.c              |  5 +--
 drivers/video/backlight/backlight.c                | 42 ------------------
 drivers/video/backlight/corgi_lcd.c                | 17 ++++----
 drivers/video/backlight/hx8357.c                   |  2 +-
 drivers/video/backlight/ili922x.c                  |  7 ++-
 drivers/video/backlight/ili9320.c                  | 15 +++----
 drivers/video/backlight/jornada720_lcd.c           | 10 ++---
 drivers/video/backlight/ktz8866.c                  |  1 +
 drivers/video/backlight/l4f00242t03.c              | 32 +++++++-------
 drivers/video/backlight/lcd.c                      | 50 ++++++++++++++++------
 drivers/video/backlight/lms283gf05.c               |  2 +-
 drivers/video/backlight/lms501kf03.c               | 24 +++++------
 drivers/video/backlight/ltv350qv.c                 | 15 +++----
 drivers/video/backlight/otm3225a.c                 |  2 +-
 drivers/video/backlight/platform_lcd.c             | 20 +++------
 drivers/video/backlight/tdo24m.c                   | 19 ++++----
 drivers/video/fbdev/clps711x-fb.c                  | 29 ++++++-------
 drivers/video/fbdev/imxfb.c                        | 32 +++++---------
 drivers/video/fbdev/omap/lcd_ams_delta.c           |  8 ++--
 include/linux/backlight.h                          | 20 ---------
 include/linux/fb.h                                 | 13 ++++++
 include/linux/lcd.h                                | 29 ++++++++++---
 include/video/platform_lcd.h                       |  3 --
 28 files changed, 221 insertions(+), 247 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/leds/backlight/zii,rave-sp-backlight.txt
 create mode 100644 Documentation/devicetree/bindings/leds/backlight/zii,rave-sp-backlight.yaml

-- 
Lee Jones [李琼斯]

