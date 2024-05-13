Return-Path: <linux-kernel+bounces-177620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF8B38C41B6
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 15:21:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BD401C22FA1
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 13:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F681152502;
	Mon, 13 May 2024 13:21:05 +0000 (UTC)
Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [195.130.137.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F90152169
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 13:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.137.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715606465; cv=none; b=jxyVfyBZ7jme9639nI96OzoJnAgAgFws6Fz2khpLnHgzDmm9sgZnqerseE+OOeeTnhvwsDplgybs2fxTcc+OZCUXhRoIMFku/U/vqr8ubRIWkuqbP0y0FzJoLJ01RtqnfUNBp+yhrxZR0KtkD06WiunFmHWL3p+NCzq+5pRL1e8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715606465; c=relaxed/simple;
	bh=t+9d5z/RIWVL4mfXlBPmUVnjbCVQGratb2WunXgnKGA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Kn8uywEOSpG6qjQ2pshIPLDYAF9SbdbbmYyUAQuzAp3zdJqD2+JmPtDdXmTMETK9bmRBfg1KGct1Rb43m+7/U/sLHb9GWFrHkhqitRy12crDnRadi+IDLu4bw+MjINpVxa8uff8ijBY1IDKYhTZ0Exvkubbgrw9F7MHbuSWXXas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.137.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:c85e:4b6d:1f91:1410])
	by laurent.telenet-ops.be with bizsmtp
	id NdM02C0075V4kqY01dM0ZE; Mon, 13 May 2024 15:21:00 +0200
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1s6Vb7-00399r-Si;
	Mon, 13 May 2024 15:21:00 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1s6Vbw-008tqZ-1D;
	Mon, 13 May 2024 15:21:00 +0200
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Arnd Bergmann <arnd@arndb.de>
Cc: linux-sh@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 3/3] sh: setup: Add missing forward declaration for sh_fdt_init()
Date: Mon, 13 May 2024 15:20:55 +0200
Message-Id: <7e3ea09e706a075bceb6bfd172990676e79be1c2.1715606232.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1715606232.git.geert+renesas@glider.be>
References: <cover.1715606232.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

arch/sh/kernel/setup.c:244:12: warning: no previous prototype for 'sh_fdt_init' [-Wmissing-prototypes]

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/sh/include/asm/setup.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/sh/include/asm/setup.h b/arch/sh/include/asm/setup.h
index fc807011187fa1c0..84bb23a771f3538b 100644
--- a/arch/sh/include/asm/setup.h
+++ b/arch/sh/include/asm/setup.h
@@ -21,5 +21,6 @@
 void sh_mv_setup(void);
 void check_for_initrd(void);
 void per_cpu_trap_init(void);
+void sh_fdt_init(phys_addr_t dt_phys);
 
 #endif /* _SH_SETUP_H */
-- 
2.34.1


