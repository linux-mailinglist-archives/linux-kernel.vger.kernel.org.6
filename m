Return-Path: <linux-kernel+bounces-293341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D81F6957E2E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 08:32:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17A611C21B43
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 06:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D31DE1EB4A7;
	Tue, 20 Aug 2024 06:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cOQU7yse";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WrQxC1sS"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B291E4EFF
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 06:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724135413; cv=none; b=r1tHcTq8MJ+MpL55pBWJT77pWXkaMdsma3BNpC1KpB7n00QdDSY3jUPFXzWnkym/NfCmvmdPyOoaMFXtjyg7c5tJ+DN4SB2u4t9cwzBCXm9l6xHkCNjEDSvdPfqQUayOrIIpfTT2tfX1+sEQjzfvepfSSX2Z/jIolUPS4zU2XAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724135413; c=relaxed/simple;
	bh=1c1EohtOFTkv/3gZxIc0vQk/ntHg84KrPkKocOc813o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ozPRAQL7o+x9eHmjWcAhoM7+CYK3h1noQSfHxCQqOHRS6sKY+ThZ1S6lTERPvMIGWDT86TpRWvtW5TcC/r0Cwdd1AlMNSOcCHsFmVfX0Tm4NDpBIc9JCtbHR2l4OuqV60uUU7Ct95tKMfG3XTrayaMAsbJnz+jsXL59S+YvNuUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cOQU7yse; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WrQxC1sS; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1724135409;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aNeK2H/ne/glar5xPRr97ZgYSDkKLjqfRfr1orQbwpk=;
	b=cOQU7ysexHsB2UMbERyDAVw0C7yeZ3E8Rfl9BfE0qTwDcgkhL0wtOl+REwrIZBmJy7de+O
	Cs8ni1CdE9phelfLUoVC5XjsNH69Cjfgeqz8lK0NfDnmy9X59k8nmciddyDT9Pc/U0vMZ2
	YPOqfpPrT2BvsQLl+AAGPX6NC0t09k1cDzAKSFi10sJ39mbeb5/0FxLW3KQToOlNIKI1Y1
	dDwlnm0PGmIXfA1jv2pMK/gfxhrobueTeINet7qhCDsTJLPQGjUkqJt1dn2BcXNcp9zEFe
	YDgyIM3h7rvo214645m2x/sNbchwVzrJDjDGwGklBHhv5wx/LokgWI47CFt4HA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1724135409;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aNeK2H/ne/glar5xPRr97ZgYSDkKLjqfRfr1orQbwpk=;
	b=WrQxC1sS6ePSRUNqKSxQBnFfr5a6DbCdZJ+8eeky5vfLPyKysrAVv2w/NJ+KDL02n6tbIg
	tQU1Y2+FuuN0peBw==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH printk v8 15/35] printk: nbcon: Do not rely on proxy headers
Date: Tue, 20 Aug 2024 08:35:41 +0206
Message-Id: <20240820063001.36405-16-john.ogness@linutronix.de>
In-Reply-To: <20240820063001.36405-1-john.ogness@linutronix.de>
References: <20240820063001.36405-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The headers kernel.h, serial_core.h, and console.h allow for the
definitions of many types and functions from other headers.
Rather than relying on these as proxy headers, explicitly
include all headers providing needed definitions. Also sort the
list alphabetically to be able to easily detect duplicates.

Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: John Ogness <john.ogness@linutronix.de>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Petr Mladek <pmladek@suse.com>
---
 kernel/printk/internal.h          |  8 ++++++--
 kernel/printk/nbcon.c             | 13 ++++++++++++-
 kernel/printk/printk_ringbuffer.h |  2 ++
 3 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/kernel/printk/internal.h b/kernel/printk/internal.h
index dc8bc0890fd2..ccb916688178 100644
--- a/kernel/printk/internal.h
+++ b/kernel/printk/internal.h
@@ -2,11 +2,12 @@
 /*
  * internal.h - printk internal definitions
  */
-#include <linux/percpu.h>
 #include <linux/console.h>
-#include "printk_ringbuffer.h"
+#include <linux/percpu.h>
+#include <linux/types.h>
 
 #if defined(CONFIG_PRINTK) && defined(CONFIG_SYSCTL)
+struct ctl_table;
 void __init printk_sysctl_init(void);
 int devkmsg_sysctl_set_loglvl(const struct ctl_table *table, int write,
 			      void *buffer, size_t *lenp, loff_t *ppos);
@@ -43,6 +44,9 @@ enum printk_info_flags {
 	LOG_CONT	= 8,	/* text is a fragment of a continuation line */
 };
 
+struct printk_ringbuffer;
+struct dev_printk_info;
+
 extern struct printk_ringbuffer *prb;
 
 __printf(4, 0)
diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
index 61f0ae6a4809..e8ddcb6f7053 100644
--- a/kernel/printk/nbcon.c
+++ b/kernel/printk/nbcon.c
@@ -2,13 +2,24 @@
 // Copyright (C) 2022 Linutronix GmbH, John Ogness
 // Copyright (C) 2022 Intel, Thomas Gleixner
 
-#include <linux/kernel.h>
+#include <linux/atomic.h>
+#include <linux/bug.h>
 #include <linux/console.h>
 #include <linux/delay.h>
+#include <linux/errno.h>
 #include <linux/export.h>
+#include <linux/init.h>
+#include <linux/irqflags.h>
+#include <linux/minmax.h>
+#include <linux/percpu.h>
+#include <linux/preempt.h>
 #include <linux/slab.h>
+#include <linux/smp.h>
+#include <linux/stddef.h>
 #include <linux/string.h>
+#include <linux/types.h>
 #include "internal.h"
+#include "printk_ringbuffer.h"
 /*
  * Printk console printing implementation for consoles which does not depend
  * on the legacy style console_lock mechanism.
diff --git a/kernel/printk/printk_ringbuffer.h b/kernel/printk/printk_ringbuffer.h
index 52626d0f1fa3..bd2a892deac1 100644
--- a/kernel/printk/printk_ringbuffer.h
+++ b/kernel/printk/printk_ringbuffer.h
@@ -5,6 +5,8 @@
 
 #include <linux/atomic.h>
 #include <linux/dev_printk.h>
+#include <linux/stddef.h>
+#include <linux/types.h>
 
 /*
  * Meta information about each stored message.
-- 
2.39.2


