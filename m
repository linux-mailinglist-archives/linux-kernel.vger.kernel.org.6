Return-Path: <linux-kernel+bounces-574256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F763A6E2B5
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 19:52:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C43216FF1E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 18:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB68D266F00;
	Mon, 24 Mar 2025 18:52:09 +0000 (UTC)
Received: from baptiste.telenet-ops.be (baptiste.telenet-ops.be [195.130.132.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99ABB1FCFDC
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 18:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.132.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742842329; cv=none; b=YDVc59MsQVBhZ0VVMPS3yftzS0IR3WOlq0xEQXUfW9XaMsCcGWEK7LF3sbQCvuQ1OQao1rpBSnM+/giUM7oJcHA2yuWLAU94iRiBjgfsROXYg9ucYBx3gP3C5QsKk9FLT2ydoPSx9d2rY761r0yJV3bmSM1LHXY9hmCW/nYTPRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742842329; c=relaxed/simple;
	bh=c3aKlu7+7ehGOVtkRnzGy3jinX6zgOcsCNdKmeosbz8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=g6kNiJ46k0VUQFAV0grjFroEmEZARldIF/AvpohL2r8Z8QcHuatCAgeh4XS8l38BP/gObqBSzmqTG+iWO6KzHD/EkZPMHRyr75U+YpkKpZj8rGsNDqVsjWi8IP4u482Y8BiZ1dk6d/UEhN9Vyfrg9xg9mkp31zY1zFHKDJk5q6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.132.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:3869:6636:1af3:7cec])
	by baptiste.telenet-ops.be with cmsmtp
	id Uis32E00G0LH2Jv01is3tA; Mon, 24 Mar 2025 19:52:04 +0100
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.97)
	(envelope-from <geert@linux-m68k.org>)
	id 1twmta-0000000FRgv-2c4g;
	Mon, 24 Mar 2025 19:52:03 +0100
Received: from geert by rox.of.borg with local (Exim 4.97)
	(envelope-from <geert@linux-m68k.org>)
	id 1twmu3-000000018CO-2FUh;
	Mon, 24 Mar 2025 19:52:03 +0100
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Greg Ungerer <gerg@linux-m68k.org>,
	linux-m68k@lists.linux-m68k.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [GIT PULL] m68k updates for v6.15
Date: Mon, 24 Mar 2025 19:51:45 +0100
Message-ID: <20250324185145.269783-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

	Hi Linus,

The following changes since commit 2014c95afecee3e76ca4a56956a936e23283f05b:

  Linux 6.14-rc1 (2025-02-02 15:39:26 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/geert/linux-m68k.git tags/m68k-for-v6.15-tag1

for you to fetch changes up to c94cf023dce30d5f28323a9f28ee2912f248a68f:

  m68k: defconfig: Update defconfigs for v6.14-rc1 (2025-03-17 14:25:57 +0100)

----------------------------------------------------------------
m68k updates for v6.15

  - Miscellaneous fixes and improvements,
  - Defconfig updates.

Thanks for pulling!

----------------------------------------------------------------
Geert Uytterhoeven (2):
      m68k: sun3: Fix DEBUG_MMU_EMU build
      m68k: defconfig: Update defconfigs for v6.14-rc1

Thorsten Blum (2):
      m68k: sun3: Use str_read_write() helper in mmu_emu_handle_fault()
      m68k: setup: Remove size argument when calling strscpy()

 arch/m68k/configs/amiga_defconfig    |  2 +-
 arch/m68k/configs/apollo_defconfig   |  2 +-
 arch/m68k/configs/atari_defconfig    |  2 +-
 arch/m68k/configs/bvme6000_defconfig |  2 +-
 arch/m68k/configs/hp300_defconfig    |  2 +-
 arch/m68k/configs/mac_defconfig      |  2 +-
 arch/m68k/configs/multi_defconfig    |  2 +-
 arch/m68k/configs/mvme147_defconfig  |  2 +-
 arch/m68k/configs/mvme16x_defconfig  |  2 +-
 arch/m68k/configs/q40_defconfig      |  2 +-
 arch/m68k/configs/sun3_defconfig     |  2 +-
 arch/m68k/configs/sun3x_defconfig    |  2 +-
 arch/m68k/include/asm/processor.h    | 14 ++++++++++++++
 arch/m68k/kernel/setup_mm.c          |  3 +--
 arch/m68k/sun3/mmu_emu.c             |  7 ++++---
 15 files changed, 31 insertions(+), 17 deletions(-)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

