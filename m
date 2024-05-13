Return-Path: <linux-kernel+bounces-177494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D5748C3FAE
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 13:19:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86CCC280A1D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 11:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64B2614F126;
	Mon, 13 May 2024 11:19:04 +0000 (UTC)
Received: from weierstrass.telenet-ops.be (weierstrass.telenet-ops.be [195.130.137.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 876DF14D297
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 11:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.137.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715599144; cv=none; b=dgEUB1SjSC8rxdr/EUTnCHb+XuU51JXhcobQYpn5kaeHry/GMLtBdgzHt0osB3UrIZC51pPhLBVdfY4OL74ZXFN867COq1LYISUVAu6ohe63Zi5xvfR27EVynG/hlext6aZC70Z8/MgCUnCCV+eVLERv3yO3pb/GUDEiCrQlXmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715599144; c=relaxed/simple;
	bh=RChba25Ai+3pi3SylBL8EN8VNmPke8+6xM3Q/AA48Q8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fhSTyJF8E/JccG59afNtsnFBP9AYvB6UGb77VbXrzUg2yq6w+6lwW4mJA0d9UTVUEO37fFqGzBs/NWkPbMYyj88RpGA7kDH/+7XdLiVoa38G6oCAHiaTILCDQnzE/roHe2DEDFQfrVsjnMHA2GaY0DlXaaCHi3LCSJgnogEzunM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.137.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [IPv6:2a02:1800:110:4::f00:19])
	by weierstrass.telenet-ops.be (Postfix) with ESMTPS id 4VdH716R13z4x0sm
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 13:18:53 +0200 (CEST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:c85e:4b6d:1f91:1410])
	by laurent.telenet-ops.be with bizsmtp
	id NbJm2C00K5V4kqY01bJm6W; Mon, 13 May 2024 13:18:46 +0200
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1s6Tgq-002tkG-0n;
	Mon, 13 May 2024 13:18:46 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1s6The-008YWx-47;
	Mon, 13 May 2024 13:18:46 +0200
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Greg Ungerer <gerg@linux-m68k.org>,
	linux-m68k@lists.linux-m68k.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [GIT PULL] m68k updates for v6.10
Date: Mon, 13 May 2024 13:18:43 +0200
Message-Id: <20240513111843.2039350-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

	Hi Linus,

The following changes since commit 4cece764965020c22cff7665b18a012006359095:

  Linux 6.9-rc1 (2024-03-24 14:10:05 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/geert/linux-m68k.git tags/m68k-for-v6.10-tag1

for you to fetch changes up to ec8c8266373f6283a3e99b036aea7b9428480625:

  m68k: defconfig: Update defconfigs for v6.9-rc1 (2024-05-08 17:43:25 +0200)

----------------------------------------------------------------
m68k updates for v6.10

  - Fix invalid context sleep and reboot hang on Mac,
  - Fix spinlock race in kernel thread creation,
  - Miscellaneous fixes and improvements,
  - Defconfig updates.

Thanks for pulling!

----------------------------------------------------------------
Andy Shevchenko (1):
      zorro: Use helpers from ioport.h

Dawei Li (1):
      m68k: Calculate THREAD_SIZE from THREAD_SIZE_ORDER

Finn Thain (2):
      macintosh/via-macii: Fix "BUG: sleeping function called from invalid context"
      m68k: mac: Fix reboot hang on Mac IIci

Geert Uytterhoeven (2):
      m68k: Move ARCH_HAS_CPU_CACHE_ALIASING
      m68k: defconfig: Update defconfigs for v6.9-rc1

Michael Schmitz (1):
      m68k: Fix spinlock race in kernel thread creation

Niklas Schnelle (1):
      m68k: Let GENERIC_IOMAP depend on HAS_IOPORT

Thorsten Blum (1):
      m68k: amiga: Use str_plural() to fix Coccinelle warning

 arch/m68k/Kconfig                    |  4 ++--
 arch/m68k/amiga/config.c             |  2 +-
 arch/m68k/configs/amiga_defconfig    |  4 +---
 arch/m68k/configs/apollo_defconfig   |  4 +---
 arch/m68k/configs/atari_defconfig    |  4 +---
 arch/m68k/configs/bvme6000_defconfig |  4 +---
 arch/m68k/configs/hp300_defconfig    |  4 +---
 arch/m68k/configs/mac_defconfig      |  4 +---
 arch/m68k/configs/multi_defconfig    |  4 +---
 arch/m68k/configs/mvme147_defconfig  |  4 +---
 arch/m68k/configs/mvme16x_defconfig  |  4 +---
 arch/m68k/configs/q40_defconfig      |  4 +---
 arch/m68k/configs/sun3_defconfig     |  4 +---
 arch/m68k/configs/sun3x_defconfig    |  4 +---
 arch/m68k/include/asm/thread_info.h  |  9 +++++----
 arch/m68k/kernel/entry.S             |  4 +++-
 arch/m68k/mac/misc.c                 | 36 ++++++++++++++++++------------------
 drivers/macintosh/via-macii.c        | 11 +++--------
 drivers/zorro/zorro.c                | 14 ++++----------
 19 files changed, 48 insertions(+), 80 deletions(-)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

