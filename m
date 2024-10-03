Return-Path: <linux-kernel+bounces-348546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE80498E8DE
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 05:32:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F384B1C24C2C
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 03:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1849222619;
	Thu,  3 Oct 2024 03:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="od+Ha1Jq"
Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D136F481DD
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 03:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727926350; cv=none; b=EQvEXcsKfOOov9T6mWgSnxUDb5DkL2dsWFj5p8KoZsIpao5jtXaj8EplCf+VIYXLwOowpDNGcO6k3koUzCfSZSPyne2TqolbuXNSKsr1mDzRjMz5mnzR7/x4itfGJ33n5m/sH8R4RyFSSd8UBm5dxa3bhbglWn3zx0DnvD+W12M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727926350; c=relaxed/simple;
	bh=q4KJ1nLWZH6qD+XzexD2DL2YopndIuoxu1wm3w0N8Cc=;
	h=To:Cc:Message-Id:From:Subject:Date; b=JJIbv+NtwM6ZZCLETvjxydeOwdKBIYm4EP9w5kdfWj8Kljsk4jRCmNmpmA30dLdTz+eDRBnrkVm34a73CMeamMFl/A3MBsN0x7nvzM9buNSjLjNOIaiN7BJCRv3t2OcAxuPr/ahbg1fCu/vhc2Spjlp5yHwsDB3DwPgjO26dORw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=od+Ha1Jq; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 14954138024C;
	Wed,  2 Oct 2024 23:32:28 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 02 Oct 2024 23:32:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
	:feedback-id:from:from:in-reply-to:message-id:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm2; t=1727926348; x=1728012748; bh=36nwp6Rh4Zskv
	YpZUpbGmM8YFVLC0s1vC4mI0IdxrzI=; b=od+Ha1JqhMzEyEsO/7NI/pxtLrfhr
	iNOFqRUjFakMW9E/smCLl9ZvzRuZbTMSsLpoDIAtcYi+ByBAqzXzUIvIlzjsTMZ2
	o1rDdV/U8K9XsDrx0PivD//RRfnwmzrd/Oj3f8sfwqmoYraFViqboXnUBCIw9x8K
	wVszSLE5SlKaT+T1Vrx+rTk61Cld0ws49udeqoQDrpT10ABoK4A2pVZYJPEc1BLF
	6unyUPIkjkEc0MxxH212oN9TRWHmsT4ejxEQGr7JxAhWKQzbiAFOp41zfeFTHDoz
	HfB/pwsEvO+dHosIfg3eVAYoJKd2Ty/t9nj6Tt7NrlrHrWDP7NHFyS/dw==
X-ME-Sender: <xms:SxD-ZovompBL-_1-q4tWyObfTYJcRZFlr_PYtGCHb9atbKPa1zp1JQ>
    <xme:SxD-ZlcB_PC8GRtNa4ZbZJmp17iAAaBMcePelplhvOtm3LNg5zyj-VoyFHK2UeVH8
    WfrLfoqadK_dtqqFNE>
X-ME-Received: <xmr:SxD-ZjwUFarz2Cz6NrjdyfhRxP7fMgjUizzgBbBbh4PnGPrQwkSzUEKSoUbk7vrcnlFitN18pxlAjkrTSzwfqBqtOsMgSeo1Nvc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddvtddgjeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepvfevkffhufffsedttdertddttddtnecuhfhrohhm
    pefhihhnnhcuvfhhrghinhcuoehfthhhrghinheslhhinhhugidqmheikehkrdhorhhgqe
    enucggtffrrghtthgvrhhnpeehfffggeefveegvedtiefffeevuedtgefhueehieetffej
    fefggeevfeeuvdduleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehfthhhrghinheslhhinhhugidqmheikehkrdhorhhgpdhnsggprhgtphht
    thhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgvggvrhhtsehlihhnuh
    igqdhmieekkhdrohhrghdprhgtphhtthhopegurghnihgvlhestdigtdhfrdgtohhmpdhr
    tghpthhtohepshhtrggslhgvsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuh
    igqdhmieekkheslhhishhtshdrlhhinhhugidqmheikehkrdhorhhgpdhrtghpthhtohep
    lhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:SxD-ZrPxWk_8720lc3tQ4mwmyA9RuoNaIKuQJx7ShOntc5ydhF9lkw>
    <xmx:SxD-Zo9_J8aZTqiEGPwUZ6WC_PHOL3n-uufrzD1a-3L48xX0-jF2zA>
    <xmx:SxD-ZjVmJvZ8BuuQKLtKi_5TTHQbXmp6S1Zu6qrCKtVRmc4gEJTF7w>
    <xmx:SxD-Zhe0pu8dNRMpHfQ4I64vUm5BGweaPLZ3jywMKDRZiOOks8JTkQ>
    <xmx:TBD-ZsYOnBOZSpeu1cq6u7easd2VYAsjwY7fhgg6PAhoHbcIR0Ckk7wp>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Oct 2024 23:32:25 -0400 (EDT)
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: "Daniel Palmer" <daniel@0x0f.com>,
    stable@kernel.org,
    linux-m68k@lists.linux-m68k.org,
    linux-kernel@vger.kernel.org
Message-Id: <b6112556472c657762f064ec5328f153e3ed03cd.1727926187.git.fthain@linux-m68k.org>
From: Finn Thain <fthain@linux-m68k.org>
Subject: [PATCH] m68k: mvme147: Reinstate early console
Date: Thu, 03 Oct 2024 13:29:47 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

From: Daniel Palmer <daniel@0x0f.com>

Commit a38eaa07a0ce ("m68k/mvme147: config.c - Remove unused functions"),
removed the console functionality for the mvme147 instead of wiring it
up to an early console. Put the console write function back and wire it up
like mvme16x does so it's possible to see Linux boot on this fine hardware
once more.

Cc: Daniel Palmer <daniel@0x0f.com>
Cc: stable@kernel.org
Fixes: a38eaa07a0ce ("m68k/mvme147: config.c - Remove unused functions")
Signed-off-by: Daniel Palmer <daniel@0x0f.com>
Reviewed-by: Finn Thain <fthain@linux-m68k.org>
---
 arch/m68k/kernel/early_printk.c |  3 +++
 arch/m68k/mvme147/config.c      | 27 +++++++++++++++++++++++++++
 arch/m68k/mvme147/mvme147.h     |  6 ++++++
 3 files changed, 36 insertions(+)
 create mode 100644 arch/m68k/mvme147/mvme147.h

diff --git a/arch/m68k/kernel/early_printk.c b/arch/m68k/kernel/early_printk.c
index 3cc944df04f6..d9399be89ad3 100644
--- a/arch/m68k/kernel/early_printk.c
+++ b/arch/m68k/kernel/early_printk.c
@@ -14,6 +14,7 @@
 
 
 #include "../mvme16x/mvme16x.h"
+#include "../mvme147/mvme147.h"
 
 asmlinkage void __init debug_cons_nputs(const char *s, unsigned n);
 
@@ -24,6 +25,8 @@ static void __ref debug_cons_write(struct console *c,
       defined(CONFIG_COLDFIRE))
 	if (MACH_IS_MVME16x)
 		mvme16x_cons_write(c, s, n);
+	else if (MACH_IS_MVME147)
+		mvme147_scc_write(c, s, n);
 	else
 		debug_cons_nputs(s, n);
 #endif
diff --git a/arch/m68k/mvme147/config.c b/arch/m68k/mvme147/config.c
index e2560c6d10b4..536244a181ef 100644
--- a/arch/m68k/mvme147/config.c
+++ b/arch/m68k/mvme147/config.c
@@ -33,6 +33,7 @@
 #include <asm/mvme147hw.h>
 #include <asm/config.h>
 
+#include "mvme147.h"
 
 static void mvme147_get_model(char *model);
 extern void mvme147_sched_init(void);
@@ -177,3 +178,29 @@ static u64 mvme147_read_clk(struct clocksource *cs)
 
 	return ticks;
 }
+
+#define SCC_DELAY do { __asm__ __volatile__ ("nop; nop;"); } while (0)
+
+static void scc_write(char ch)
+{
+	do {
+		SCC_DELAY;
+	} while (!(in_8(M147_SCC_A_ADDR) & BIT(2)));
+	SCC_DELAY;
+	out_8(M147_SCC_A_ADDR, 8);
+	SCC_DELAY;
+	out_8(M147_SCC_A_ADDR, ch);
+}
+
+void mvme147_scc_write(struct console *co, const char *str, unsigned int count)
+{
+	unsigned long flags;
+
+	local_irq_save(flags);
+	while (count--)	{
+		if (*str == '\n')
+			scc_write('\r');
+		scc_write(*str++);
+	}
+	local_irq_restore(flags);
+}
diff --git a/arch/m68k/mvme147/mvme147.h b/arch/m68k/mvme147/mvme147.h
new file mode 100644
index 000000000000..140bc98b0102
--- /dev/null
+++ b/arch/m68k/mvme147/mvme147.h
@@ -0,0 +1,6 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+struct console;
+
+/* config.c */
+void mvme147_scc_write(struct console *co, const char *str, unsigned int count);
-- 
2.39.5


