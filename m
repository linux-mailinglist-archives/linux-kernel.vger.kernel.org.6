Return-Path: <linux-kernel+bounces-412902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F02A9D10DC
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 13:47:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17D821F21A9E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 12:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5F031991BB;
	Mon, 18 Nov 2024 12:47:33 +0000 (UTC)
Received: from albert.telenet-ops.be (albert.telenet-ops.be [195.130.137.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 298C518EFDE
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 12:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.137.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731934053; cv=none; b=HR/JfWIMTO6/7xvml7tF1+AA5sVlhnnMryE4bCkpso59xr62iWp1yYPADz0PW2zsOHVjCQFpXjrbbD+02eVTN8PtxblxO/g5fYCh1dStwgVez6j0TbWACuNpJYItJcx3XhlzYKENWU94Yx2jZhKxEcx9xpwCXa0kxXx3DOwI54g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731934053; c=relaxed/simple;
	bh=7aZsjxaVStHdLdFrr1YMq6ZzlzYrk8LLz29hzjmM+hQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qIvQZVInc4O53J6P7e+mM9tnqljMhCrCK41mb0qYWqez8znYIR0tiaM9ItRmxCS9270sxW78em50nJ+XCuevG9L59JsOsr62rOfQuUtWPmJM99CEePj1+uC6ZMgcSIArm6ZNpVG/QvacAMuCmmP2t5zzc/+l5Ojq7vaWA/VPz6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.137.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:5694:511b:a530:b0e])
	by albert.telenet-ops.be with cmsmtp
	id eCnM2D00H56PXV606CnMnA; Mon, 18 Nov 2024 13:47:21 +0100
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1tD19f-007SfA-6e;
	Mon, 18 Nov 2024 13:47:21 +0100
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1tD1A1-00E19l-CP;
	Mon, 18 Nov 2024 13:47:21 +0100
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Greg Ungerer <gerg@linux-m68k.org>,
	linux-m68k@lists.linux-m68k.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [GIT PULL] m68k updates for v6.13
Date: Mon, 18 Nov 2024 13:47:20 +0100
Message-Id: <20241118124720.3341025-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

	Hi Linus,

The following changes since commit 8cf0b93919e13d1e8d4466eb4080a4c4d9d66d7b:

  Linux 6.12-rc2 (2024-10-06 15:32:27 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/geert/linux-m68k.git tags/m68k-for-v6.13-tag1

for you to fetch changes up to 647619b6bd27d2b7c3c6055f3f0d996e61884202:

  m68k: defconfig: Update defconfigs for v6.12-rc1 (2024-11-11 13:53:58 +0100)

----------------------------------------------------------------
m68k updates for v6.13

  - Revive SCSI and early console support on MVME147,
  - Fix early kernel parameters using static keys,
  - Prevent and improve handling of kernel configurations that lack
    specific platform, CPU, or MMU support, to avoid build failures,
  - Miscellaneous fixes and improvements,
  - Defconfig updates.

Thanks for pulling!

----------------------------------------------------------------
Arnd Bergmann (2):
      m68k: Move Sun 3 into a top-level platform option
      m68k: Select M68020 as fallback for classic

Daniel Palmer (3):
      m68k: mvme147: Make mvme147_sched_init() __init
      m68k: mvme147: Fix SCSI controller IRQ numbers
      m68k: mvme147: Reinstate early console

Geert Uytterhoeven (2):
      m68k: Make sure NR_IRQS is never zero
      m68k: defconfig: Update defconfigs for v6.12-rc1

Jean-Michel Hautbois (1):
      m68k: Initialize jump labels early during setup_arch()

Thorsten Blum (1):
      m68k: kernel: Use str_read_write() helper function

 arch/m68k/Kconfig                    | 11 +++++------
 arch/m68k/Kconfig.cpu                | 36 +++++++++++++++++++++++-------------
 arch/m68k/Kconfig.machine            | 25 -------------------------
 arch/m68k/configs/amiga_defconfig    |  1 +
 arch/m68k/configs/apollo_defconfig   |  1 +
 arch/m68k/configs/atari_defconfig    |  1 +
 arch/m68k/configs/bvme6000_defconfig |  1 +
 arch/m68k/configs/hp300_defconfig    |  1 +
 arch/m68k/configs/mac_defconfig      |  1 +
 arch/m68k/configs/multi_defconfig    |  1 +
 arch/m68k/configs/mvme147_defconfig  |  1 +
 arch/m68k/configs/mvme16x_defconfig  |  1 +
 arch/m68k/configs/q40_defconfig      |  1 +
 arch/m68k/configs/sun3_defconfig     |  1 +
 arch/m68k/configs/sun3x_defconfig    |  1 +
 arch/m68k/include/asm/irq.h          |  4 +---
 arch/m68k/include/asm/mvme147hw.h    |  4 ++--
 arch/m68k/kernel/Makefile            | 12 ++----------
 arch/m68k/kernel/early_printk.c      |  5 ++++-
 arch/m68k/kernel/setup_mm.c          |  6 +++++-
 arch/m68k/kernel/time.c              |  4 ++--
 arch/m68k/kernel/traps.c             | 16 ++++++++--------
 arch/m68k/mvme147/config.c           | 34 ++++++++++++++++++++++++++++++++--
 arch/m68k/mvme147/mvme147.h          |  6 ++++++
 24 files changed, 102 insertions(+), 73 deletions(-)
 create mode 100644 arch/m68k/mvme147/mvme147.h

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

