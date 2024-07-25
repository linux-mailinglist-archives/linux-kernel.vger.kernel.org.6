Return-Path: <linux-kernel+bounces-261948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ACD9E93BE28
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 10:48:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59E621F22BF0
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 08:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1E2E19644B;
	Thu, 25 Jul 2024 08:47:53 +0000 (UTC)
Received: from andre.telenet-ops.be (andre.telenet-ops.be [195.130.132.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF76416DEC9
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 08:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.132.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721897273; cv=none; b=rNfMY0XAfjqurHdDNqo+AvqahEEO6RcNuHQNQHOGtBlPJ8p/NpY22dQYAdVOF3PUhmCxtfEQGIOgUQbxnTbKdrF2QSN9HPGYMBY9IN4u+5uYOCA4c9xwg4zk9do7oNcMtoJ18tQaM9kXYu92MKKyTbARTXLGKCxOQhMBA/R5DVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721897273; c=relaxed/simple;
	bh=fE+ZMxTKe06uqX35T/HyWywJfmS7ICF4Ix7MrZ+YRlc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YI9bqnC9/CynG9a5drpuAbVVxpb7b89SEiIbKcFMXi/hUfWmsSADrC18uFDCMzqxr5XW9cRcjX9QEMyIBrToI+dQJkzCzV30p1TKX+fhx5V/hIEXTHssjTwAJlt4R0fyLsljrNv9pOsh/ArgS10/0fjfemKJcBvPv8gXzMC5POM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.132.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:9697:b0ae:59fa:9dc8])
	by andre.telenet-ops.be with bizsmtp
	id rkno2C00E30uYn301knoXz; Thu, 25 Jul 2024 10:47:49 +0200
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1sWu8F-003PO8-Jz;
	Thu, 25 Jul 2024 10:47:48 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1sWu8a-00AbjW-HM;
	Thu, 25 Jul 2024 10:47:48 +0200
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andy Shevchenko <andy@kernel.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [GIT PULL] auxdisplay updates for v6.11
Date: Thu, 25 Jul 2024 10:47:41 +0200
Message-Id: <20240725084741.2519888-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

	Hi Linus,

The following changes since commit 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0:

  Linux 6.10-rc1 (2024-05-26 15:20:12 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/geert/linux-m68k.git tags/auxdisplay-for-v6.11-tag1

for you to fetch changes up to 2ccfe94bc3ac980d2d1df9f7a0b2c6d2137abe55:

  auxdisplay: ht16k33: Drop reference after LED registration (2024-06-11 16:58:52 +0300)

----------------------------------------------------------------
auxdisplay updates for v6.11

  - Add support for configuring the boot message on line displays,
  - Miscellaneous fixes and improvements.

As Andy is on holidays[1], and after checking with him earlier today,
I imported his branch, tagged it, and am sending a PR.

All of this has been in linux-next for a while, through Andy's
auxdisplay repo.

Thanks for pulling!

[1] https://lore.kernel.org/CAHp75VehHDikSSPJhc4c8t7jp81bQ_Z+pkqYnM_F87xdJP4Xew@mail.gmail.com/

----------------------------------------------------------------
Andy Shevchenko (1):
      auxdisplay: charlcd: Provide a forward declaration

Chris Packham (1):
      auxdisplay: linedisp: Support configuring the boot message

Erick Archer (1):
      auxdisplay: Use sizeof(*pointer) instead of sizeof(type)

Jeff Johnson (2):
      auxdisplay: linedisp: add missing MODULE_DESCRIPTION() macro
      auxdisplay: hd44780: add missing MODULE_DESCRIPTION() macro

Markus Elfring (1):
      auxdisplay: ht16k33: Drop reference after LED registration

 drivers/auxdisplay/Kconfig          |  2 +-
 drivers/auxdisplay/arm-charlcd.c    |  2 +-
 drivers/auxdisplay/charlcd.h        |  2 ++
 drivers/auxdisplay/hd44780.c        |  2 +-
 drivers/auxdisplay/hd44780_common.c |  1 +
 drivers/auxdisplay/ht16k33.c        |  1 +
 drivers/auxdisplay/line-display.c   | 11 ++++++++++-
 7 files changed, 17 insertions(+), 4 deletions(-)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

