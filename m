Return-Path: <linux-kernel+bounces-397289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEC569BDA06
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 00:58:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C41E1C2216E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 23:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A553216A38;
	Tue,  5 Nov 2024 23:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PCpB71Mx"
Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1804216A28
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 23:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730851102; cv=none; b=fz3chbunO0umY6M4sTfnqIF/Pl7XK9QW0HIkvl1WrxDuCHQIfTVC/CkItxRia2Z8Bk5YUZxQ9UwrM4jYl8859eKqx1GsbBCWSbUMNO9lK9w3tcPhjYujLU7wesbfQ+oumAWzX5+t5ZRNVRiouUcT0VmrV2FtejxdCgiuHJXm5ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730851102; c=relaxed/simple;
	bh=JtUF2H9w8fqLw+OadS7UHTS9qtXIn2XKlYlYS+esBA4=;
	h=To:Cc:Message-ID:From:Subject:Date; b=S8NBXveKUH+3Uqv6HK20UUf0KQ8vpdIkgZz1F9rFY/ybvdr3Dc40cnP3PHB7pGUhbH7iLgoPb4/qOpoGQbwQqnPYToIiL7rRMKQVY3Aq/81ZpTw8Od4i3/BVp3Wl5zxmy3ZpVPRzJz4XaFv6MgqWmABeF0ltA22pXCradxLFUGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PCpB71Mx; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id BA7FC11401B0;
	Tue,  5 Nov 2024 18:58:17 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Tue, 05 Nov 2024 18:58:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
	:feedback-id:from:from:in-reply-to:message-id:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1730851097; x=1730937497; bh=8ndbTcqqvH3rcUpcuPISyy7t255N
	OSgE5KUHC2VGzSU=; b=PCpB71MxcShoPNKJkCI0U0Mp+iWb0vgbJj9v8/AZ3N7I
	lXg8mJEIMJMQCi6s2ojc6b7R65oLTvYUg1m4dlIWlW8FD9bSp3JS01v893va4H0J
	+QB0JkRPMCkbVrGl9A5EYbaORZlUU3zJZTVYzkn6zXNlmrXYdDY0pTGmkkEYcaft
	OUPpxu6kppVPEWSLCTVUrgVYyXRjbPta31YMOF5P645RWXwWEAssU7WI8eldhDvk
	hbpgoxsX0BqgjKR9iB5zWW+R8ZJJI2xiNSn0BUkB+ZSay/4rjsFoZYe5EWRNWUHA
	iCJnvLPMo7CfPQ7Ka7FdGmJAcQR6zUjry5I7LzrIXA==
X-ME-Sender: <xms:GbEqZ9mC-b_Iw9ocF0MC4IHORuRwx-J4SsRLBvwJV1oBOuh9GcbCIw>
    <xme:GbEqZ43Izf5H9beXZUm9zJ6KADY798kEiwK52J5YR4WhnMbIA1dSjs-p3hGOA7MDD
    MjxbWEQ8PawflTravk>
X-ME-Received: <xmr:GbEqZzpqKX-yFLRuPogKwGwYaA4GZrmn8J6QfH63wgA25crdq-fB2MzqompzAQwFJTAJ_YKouHsjwe03LIyzKqQFEeSaiwAPe90>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrtddugddujecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefvvefkhffuffestddtredttddttdenucfhrhhomhep
    hfhinhhnucfvhhgrihhnuceofhhthhgrihhnsehlihhnuhigqdhmieekkhdrohhrgheqne
    cuggftrfgrthhtvghrnhepheffgfegfeevgeevtdeiffefveeutdeghfeuheeiteffjeef
    gfegveefuedvudelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepfhhthhgrihhnsehlihhnuhigqdhmieekkhdrohhrghdpnhgspghrtghpthht
    ohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghgvvghrtheslhhinhhugi
    dqmheikehkrdhorhhgpdhrtghpthhtohepuggrnhhivghlsedtgidtfhdrtghomhdprhgt
    phhtthhopehsthgrsghlvgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugi
    dqmheikehksehlihhsthhsrdhlihhnuhigqdhmieekkhdrohhrghdprhgtphhtthhopehl
    ihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:GbEqZ9nCbdgbPmTpeEURSY0Y2K5JfpLpgUwHQz7Tdph8n7lSg0UtlQ>
    <xmx:GbEqZ72wGs58WGBjmOSqjdbV1Lc5d-7vEed4gcW-xTShe2FNiuEqVg>
    <xmx:GbEqZ8uqSRH2DR-0hPAN0d-THuxjJK4Y8-WNoH78DWRpQ6P11lH6DQ>
    <xmx:GbEqZ_WrkXvc07D2AMH0lNwHiOW7wR2GaZmxiixKpKZnEmmZEz_XEg>
    <xmx:GbEqZ2Tk7sFizi360hax5GclOwOJijQN_GxhIBTLzCajmWyXxydtWZF5>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 5 Nov 2024 18:58:15 -0500 (EST)
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Daniel Palmer <daniel@0x0f.com>,
    stable@kernel.org,
    linux-m68k@lists.linux-m68k.org,
    linux-kernel@vger.kernel.org
Message-ID: <a82e8f0068a8722996a0ccfe666abb5e0a5c120d.1730850684.git.fthain@linux-m68k.org>
From: Finn Thain <fthain@linux-m68k.org>
Subject: [PATCH] m68k: mvme147: Reinstate early console
Date: Wed, 06 Nov 2024 10:51:24 +1100
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
Co-developed-by: Finn Thain <fthain@linux-m68k.org>
Signed-off-by: Finn Thain <fthain@linux-m68k.org>
Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
Changed since previous submission:
 - Added co-developed-by and reviewed-by tags.
 - Use a static scc_delay() function instead of a macro.

This revision produces the same object code as the previous one.
Hence it doesn't need further testing.
---
 arch/m68k/kernel/early_printk.c |  3 +++
 arch/m68k/mvme147/config.c      | 30 ++++++++++++++++++++++++++++++
 arch/m68k/mvme147/mvme147.h     |  6 ++++++
 3 files changed, 39 insertions(+)
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
index 8b5dc07f0811..cc2fb0a83cf0 100644
--- a/arch/m68k/mvme147/config.c
+++ b/arch/m68k/mvme147/config.c
@@ -32,6 +32,7 @@
 #include <asm/mvme147hw.h>
 #include <asm/config.h>
 
+#include "mvme147.h"
 
 static void mvme147_get_model(char *model);
 extern void mvme147_sched_init(void);
@@ -185,3 +186,32 @@ int mvme147_hwclk(int op, struct rtc_time *t)
 	}
 	return 0;
 }
+
+static void scc_delay(void)
+{
+	__asm__ __volatile__ ("nop; nop;");
+}
+
+static void scc_write(char ch)
+{
+	do {
+		scc_delay();
+	} while (!(in_8(M147_SCC_A_ADDR) & BIT(2)));
+	scc_delay();
+	out_8(M147_SCC_A_ADDR, 8);
+	scc_delay();
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
2.44.2


