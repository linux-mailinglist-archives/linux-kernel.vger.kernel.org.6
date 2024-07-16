Return-Path: <linux-kernel+bounces-253881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 95D1893282D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 16:21:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 209E8B21ECD
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 14:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8A2619B590;
	Tue, 16 Jul 2024 14:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LXbp5dZz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C8FB19B3FB
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 14:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721139645; cv=none; b=NtAuiPBSIhCSI46v6PsihaunkD+EA9YdWv70BWgNGCkX5sZzLvys1t/07chEWbZYECFcUrXBI2d3LfbBgDyx+ZzK+2HahslPM3DjwZWZ5i2rR/COgnqcRBcQSg5goEIbxa91l4UozvOM8OzgLHmv5OC4HQbCql2bjEaXzbBXuAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721139645; c=relaxed/simple;
	bh=YDCzt9Ym0E4AXnhOajxOlPxDcqhpZsHRx4t0TG99PwE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ugT5fzpzX2IwnEVMLvxQ9U7yEDLvzU972ldnrZNgclBCJkkvXzEt38XuhoETc6oDoFXBuI11v/qSjGR2JLMgemQeZO2clT2cbR9McvMg0kgv9LAcfH45ls7tOJy9xu0y6vMnPmK3tXBkj2M0R+yiZgJxcbtZDI0gErywHIV5naw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LXbp5dZz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1EF5C116B1;
	Tue, 16 Jul 2024 14:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721139644;
	bh=YDCzt9Ym0E4AXnhOajxOlPxDcqhpZsHRx4t0TG99PwE=;
	h=Date:From:To:Cc:Subject:From;
	b=LXbp5dZz+TDgd7oSYA24+umrvjAL1eE28+HI2ajUUBYtZSIa+Yw4qLBPsxlsSxEW6
	 Xu72SduAHd8+LBTXshSEznz/Fwu+jz6IquDn0cgs8Fi9ayirwWOm/63GQtZL1sJ4p/
	 +04XYoNV8LYiDO8JE91iMJUqGJMS/em7eizA6uiiT0GbECOcpCsRyPmJ3e8dtUWk4d
	 ry+j0UiCXZ/1vm+gZa4P8uCf71sXE10EUB8pXydqNeR0SQyTX3Ozs867Z8JkOGrXSq
	 vwLckkrNUdqgdkyOLmCUv62WS3HvPJ1gbgnR5a22f/aZkB2KKLqEmcFw3EMDphuPrT
	 +YQamUIAclEPw==
Date: Tue, 16 Jul 2024 15:20:41 +0100
From: Lee Jones <lee@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Daniel Thompson <daniel.thompson@linaro.org>
Subject: [GIT PULL] Backlight for v6.11
Message-ID: <20240716142041.GV501857@google.com>
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

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/lee/backlight.git backlight-next-6.11

for you to fetch changes up to 1df5aa3754cac2045998ca505edb84d994786c67:

  backlight: sky81452-backlight: Use backlight power constants (2024-07-04 16:45:25 +0100)

----------------------------------------------------------------
 - New Drivers
   - Add support for Texas Instruments LM3509 Backlight Driver

 - Fix-ups
   - Device Tree binding adaptions/conversions/creation
   - Drop i2c_device_id::driver_data where the value is unused
   - Make use of the new *_scoped() guard APIs
   - Decouple from fbdev by providing Backlight with its own BACKLIGHT_POWER_* constrains

 - Bug Fixes
   - Correctly assess return values (NULL vs IS_ERR())
   - Supply a bunch of MODULE_DESCRIPTIONs to silence modpost warnings

----------------------------------------------------------------
Dan Carpenter (1):
      backlight: lm3509_bl: Fix NULL vs IS_ERR() check in register() function

Javier Carrasco (1):
      backlight: lm3509_bl: Fix early returns in for_each_child_of_node()

Jeff Johnson (1):
      backlight: Add missing MODULE_DESCRIPTION() macros

Patrick Gansterer (2):
      dt-bindings: backlight: Add Texas Instruments LM3509
      backlight: Add new lm3509 backlight driver

Thomas Zimmermann (17):
      backlight: Add BACKLIGHT_POWER_ constants for power states
      backlight: aat2870-backlight: Use blacklight power constants
      backlight: ams369fb06: Use backlight power constants
      backlight: corgi-lcd: Use backlight power constants
      backlight: gpio-backlight: Use backlight power constants
      backlight: ipaq-micro-backlight: Use backlight power constants
      backlight: journada_bl: Use backlight power constants
      backlight: kb3886-bl: Use backlight power constants
      backlight: ktd253-backlight: Use backlight power constants
      backlight: led-backlight: Use backlight power constants
      backlight: lm3533-backlight: Use backlight power constants
      backlight: mp3309c: Use backlight power constants
      backlight: pandora-backlight: Use backlight power constants
      backlight: pcf50633-backlight: Use backlight power constants
      backlight: pwm-backlight: Use backlight power constants
      backlight: rave-sp-backlight: Use backlight power constants
      backlight: sky81452-backlight: Use backlight power constants

Uwe Kleine-König (1):
      backlight: Drop explicit initialization of struct i2c_device_id::driver_data to 0

 Documentation/ABI/stable/sysfs-class-backlight     |   7 +-
 .../bindings/leds/backlight/ti,lm3509.yaml         | 136 ++++++++
 drivers/video/backlight/Kconfig                    |   7 +
 drivers/video/backlight/Makefile                   |   1 +
 drivers/video/backlight/aat2870_bl.c               |   4 +-
 drivers/video/backlight/adp8870_bl.c               |   2 +-
 drivers/video/backlight/ams369fg06.c               |  23 +-
 drivers/video/backlight/bd6107.c                   |   2 +-
 drivers/video/backlight/corgi_lcd.c                |   4 +-
 drivers/video/backlight/gpio_backlight.c           |   9 +-
 drivers/video/backlight/ipaq_micro_bl.c            |   3 +-
 drivers/video/backlight/jornada720_bl.c            |   3 +-
 drivers/video/backlight/kb3886_bl.c                |   4 +-
 drivers/video/backlight/ktd253-backlight.c         |   5 +-
 drivers/video/backlight/ktz8866.c                  |   4 +-
 drivers/video/backlight/led_bl.c                   |   4 +-
 drivers/video/backlight/lm3509_bl.c                | 343 +++++++++++++++++++++
 drivers/video/backlight/lm3533_bl.c                |   3 +-
 drivers/video/backlight/lm3630a_bl.c               |   2 +-
 drivers/video/backlight/lm3639_bl.c                |   2 +-
 drivers/video/backlight/lv5207lp.c                 |   2 +-
 drivers/video/backlight/mp3309c.c                  |   6 +-
 drivers/video/backlight/pandora_bl.c               |   3 +-
 drivers/video/backlight/pcf50633-backlight.c       |   5 +-
 drivers/video/backlight/platform_lcd.c             |   1 +
 drivers/video/backlight/pwm_bl.c                   |   4 +-
 drivers/video/backlight/rave-sp-backlight.c        |   2 +-
 drivers/video/backlight/rt4831-backlight.c         |   1 +
 drivers/video/backlight/sky81452-backlight.c       |   2 +-
 include/linux/backlight.h                          |  20 +-
 30 files changed, 550 insertions(+), 64 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/leds/backlight/ti,lm3509.yaml
 create mode 100644 drivers/video/backlight/lm3509_bl.c

-- 
Lee Jones [李琼斯]

