Return-Path: <linux-kernel+bounces-252359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E237931229
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 12:21:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C29A21F2377D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 10:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9EF118735D;
	Mon, 15 Jul 2024 10:21:25 +0000 (UTC)
Received: from albert.telenet-ops.be (albert.telenet-ops.be [195.130.137.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE37D18734D
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 10:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.137.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721038885; cv=none; b=sWw3uiqAILdSkHz1kBzIDJIODPxZKVxc6cDnJ4YH+KZtrIGAQuXKhealWQ9Y3zoPjKluo59DKsIPBW5mdAEtzrXZQUZDXSN36qPCl8TM2LLxY3JmHzcpcPf015hMXEyGB3fJb18w2u8GgH2AaMG8mAkbsYj/bxOhuULHF/23a+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721038885; c=relaxed/simple;
	bh=C1QtMWGDWxteec68T6p2bieWFdYfthvIwzc3RFXK7a4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tDexJcXw81uKqTsswWZI9Osprc9FZHjrk7MZVI9SKngMmoI1XwoD1+I/sB+4VHnJAqbzjAM5igZ5wHjacPcTJ995fI7N8zbdZwr41IHdksuY1w3MHK/jp7Z0hh/ycNU46W2mn2/KeniJJ2Eh9HYqX+WqWRAi14UWTstzZzBH55I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.137.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:dd46:82df:8d7c:6f14])
	by albert.telenet-ops.be with bizsmtp
	id nmME2C00D2v92cJ06mMECR; Mon, 15 Jul 2024 12:21:15 +0200
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1sTIpH-002C0h-W7;
	Mon, 15 Jul 2024 12:21:14 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1sTIpW-007P4E-JR;
	Mon, 15 Jul 2024 12:21:14 +0200
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Greg Ungerer <gerg@linux-m68k.org>,
	linux-m68k@lists.linux-m68k.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [GIT PULL] m68k updates for v6.11
Date: Mon, 15 Jul 2024 12:21:10 +0200
Message-Id: <20240715102110.1764643-1-geert@linux-m68k.org>
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

  git://git.kernel.org/pub/scm/linux/kernel/git/geert/linux-m68k.git tags/m68k-for-v6.11-tag1

for you to fetch changes up to 21b9e722ad28c19c2bc83f18f540b3dbd89bf762:

  m68k: cmpxchg: Fix return value for default case in __arch_xchg() (2024-07-09 09:19:31 +0200)

----------------------------------------------------------------
m68k updates for v6.11

  - Fix bootup lock-ups on Warp1260, Atari TT, and MegaSTe,
  - Miscellaneous fixes and improvements,
  - Defconfig updates.

Thanks for pulling!

----------------------------------------------------------------
Eero Tamminen (1):
      m68k: atari: Fix TT bootup freeze / unexpected (SCU) interrupt messages

Geert Uytterhoeven (1):
      m68k: defconfig: Update defconfigs for v6.10-rc1

Jeff Johnson (1):
      m68k: emu: Add missing MODULE_DESCRIPTION() macros

Jiapeng Chong (1):
      zorro: Use str_plural() in amiga_zorro_probe()

Paolo Pisati (1):
      m68k: amiga: Turn off Warp1260 interrupts during boot

Thorsten Blum (1):
      m68k: cmpxchg: Fix return value for default case in __arch_xchg()

 arch/m68k/amiga/config.c             | 9 +++++++++
 arch/m68k/atari/ataints.c            | 6 +-----
 arch/m68k/configs/amiga_defconfig    | 1 +
 arch/m68k/configs/apollo_defconfig   | 1 +
 arch/m68k/configs/atari_defconfig    | 1 +
 arch/m68k/configs/bvme6000_defconfig | 1 +
 arch/m68k/configs/hp300_defconfig    | 1 +
 arch/m68k/configs/mac_defconfig      | 1 +
 arch/m68k/configs/multi_defconfig    | 1 +
 arch/m68k/configs/mvme147_defconfig  | 1 +
 arch/m68k/configs/mvme16x_defconfig  | 1 +
 arch/m68k/configs/q40_defconfig      | 1 +
 arch/m68k/configs/sun3_defconfig     | 1 +
 arch/m68k/configs/sun3x_defconfig    | 1 +
 arch/m68k/emu/nfblock.c              | 1 +
 arch/m68k/emu/nfcon.c                | 1 +
 arch/m68k/include/asm/cmpxchg.h      | 2 +-
 drivers/zorro/zorro.c                | 3 ++-
 include/uapi/linux/zorro_ids.h       | 3 +++
 19 files changed, 30 insertions(+), 7 deletions(-)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

