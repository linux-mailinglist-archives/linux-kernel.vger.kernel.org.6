Return-Path: <linux-kernel+bounces-252659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5EC8931672
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 16:15:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B1F11F22457
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 14:15:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4737B18EA65;
	Mon, 15 Jul 2024 14:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pMA/l+DY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FCBD18E777
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 14:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721052894; cv=none; b=Ii1osKPhAMibbnIMUabI0AY8Ha4Hs51AgTIVpmKEAc/fXFoNwaotQ7tEgD7PaFhG9TIp8KoEGP+U1p5xxWo/dsIqM9Y2Mbrkir3PCtYb7SSEZ+elvsQ2BSFBikqeA+wgkj2hrsGMqRD0Ueet4BlVd0a42z3yk9u1wkYj2xUQRFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721052894; c=relaxed/simple;
	bh=4jrGXyd/u4E81yonsm1UsgkaJOJzQx5CNRd79jvq/4s=;
	h=Message-ID:From:To:Cc:Subject:Date; b=qUe+di0zg9gM7kESs+PP2cGQbDRDT6MX/nsRx6ADyZiWIx6GverJkKYG+/j0tZDAYetXJ1nOnQkWJdsGAJx3CSJLqkWoMyn0P3af6x9G5uWOgSuS8IAPK1fPD3HvsykhFxQKhciasTpRtLyov7SCY3Vu/ZeIGQ4VbOHujP4Xf3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pMA/l+DY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 156EBC4AF0D;
	Mon, 15 Jul 2024 14:14:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721052894;
	bh=4jrGXyd/u4E81yonsm1UsgkaJOJzQx5CNRd79jvq/4s=;
	h=From:To:Cc:Subject:Date:From;
	b=pMA/l+DY4Y2Qysp2QbqWraeKF1xrSYGy18PlW99q/1V7MYCzVHNhiajtqd9w1df2e
	 u7/5DmuUcyKmghN/l984QQ7lYk1jfZIH1ugs/LDZxlRViNBKC4Fi60qVuZYJ7cQkb9
	 K88QES+Rg0XlF7T9zmhinbFIriS5N4HHFUi6ESemsDvR7+zSbH0Rv+SMkncItWgtUG
	 rPqEkq3ssEKoDocqUhUNnB9fw2VqjsI0EqIHdDSGgcd0LYmvIalOiBTesiEJopxLPf
	 WHcfVY7B97E1TuNlGSYY8vxzOxRD3Z2AY71cv+xOHzSb1G/oH6kQkf/nKHOPFsofBI
	 vAgKzziqNLMZA==
Message-ID: <bc8cbd2e0620ffd78a3a4f71b06a3a88.broonie@kernel.org>
From: Mark Brown <broonie@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] regmap updates for v6.11
Date: Mon, 15 Jul 2024 15:14:40 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The following changes since commit f2661062f16b2de5d7b6a5c42a9a5c96326b8454:

  Linux 6.10-rc5 (2024-06-23 17:08:54 -0400)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git tags/regmap-v6.11

for you to fetch changes up to c2bb8198fee88a428513f8d023c627ecd13aa694:

  regmap: kunit: Add test cases for regmap_multi_reg_(read,write}() (2024-07-11 12:45:55 +0100)

----------------------------------------------------------------
regmap: Updates for v6.11

There's one new feature here, a regmap_multi_reg_read() matching the
existing write function which has some IIO users coming.  This allows
atomic reads from multiple registers without the need to wrap a higher
level lock in the client driver just for regmap (which already has locks
anyway).  We also have one fix for the KUnit tests, and a bunch of
cleanups.

----------------------------------------------------------------
Andy Shevchenko (5):
      regmap: Switch to use kmemdup_array()
      regmap: cache: Use correct type of the rb_for_each() parameter
      regmap: cache: Switch to use kmemdup_array()
      regmap: maple: Switch to use kmemdup_array()
      regmap: kunit: Use array_size() and sizeof(*ptr) consistently

Guenter Roeck (2):
      regmap: Implement regmap_multi_reg_read()
      regmap: kunit: Add test cases for regmap_multi_reg_(read,write}()

Jeff Johnson (3):
      regmap: kunit: add missing MODULE_DESCRIPTION()
      regmap-i2c: add missing MODULE_DESCRIPTION() macro
      regmap: add missing MODULE_DESCRIPTION() macros

Mark Brown (4):
      regmap: Merge up fixes
      regmap: Switch to use kmemdup_array()
      regmap: Merge up v6.10-rc4
      regmap: Implement regmap_multi_reg_read()

Richard Fitzgerald (1):
      regmap: kunit: Fix memory leaks in gen_regmap() and gen_raw_regmap()

Thomas Weißschuh (2):
      const_structs.checkpatch: add regmap structs
      regmap-irq: handle const struct regmap_irq_sub_irq_map

 drivers/base/regmap/regcache-maple.c  |  13 ++-
 drivers/base/regmap/regcache.c        |   6 +-
 drivers/base/regmap/regmap-ac97.c     |   1 +
 drivers/base/regmap/regmap-i2c.c      |   1 +
 drivers/base/regmap/regmap-irq.c      |   2 +-
 drivers/base/regmap/regmap-kunit.c    | 158 +++++++++++++++++++++++++++-------
 drivers/base/regmap/regmap-ram.c      |   1 +
 drivers/base/regmap/regmap-raw-ram.c  |   1 +
 drivers/base/regmap/regmap-sccb.c     |   1 +
 drivers/base/regmap/regmap-slimbus.c  |   1 +
 drivers/base/regmap/regmap-spi-avmm.c |   1 +
 drivers/base/regmap/regmap-spmi.c     |   1 +
 drivers/base/regmap/regmap-w1.c       |   1 +
 drivers/base/regmap/regmap.c          | 105 ++++++++++++++--------
 include/linux/regmap.h                |   4 +-
 scripts/const_structs.checkpatch      |  10 +++
 16 files changed, 226 insertions(+), 81 deletions(-)

