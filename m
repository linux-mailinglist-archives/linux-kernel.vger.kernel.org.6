Return-Path: <linux-kernel+bounces-543575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CF0BA4D71C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 09:58:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09C69171E1D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 08:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84C822036E6;
	Tue,  4 Mar 2025 08:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ihgPZ+//";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Frhz47KO"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69ED7202F64
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 08:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741078426; cv=none; b=S2d9dXlNnzSHKINrkkNbYGcWf2qMj4z60Vj0WHNbxNbvM0RnBM0yON2kj8g+Pfsb/wqyHM9KF7fz4kCGUbwiX4F2CFs2/rC+ngddlRgf0K0/HOkQ7nAJ1NMWz2KPgvAQlq+4muZsXnR/q7yZEKJcph9xdGQTX1o7SgfxsQIyoGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741078426; c=relaxed/simple;
	bh=jlK56uSiHS9HBiPQ7ODfCHJCe9/AMX6Ji6trtnXXyO8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WYBie4d4OEpZqGARlB+PGvcUky3J9aaY+h2BUQpuRe3c9dAJ18gQOXwhJIGo/AbZlKyQ3YysSziIuBzuL03Oo0Fdd16cL/gekqotXpebUliylcciJIZmnGKYzG33aw0Q2gBi5U8NzrHk4DlggaReE0eVJCusL/U/p/1EpCDqAgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ihgPZ+//; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Frhz47KO; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741078424;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JlUDYlBqaGiI3XiQxvwaaxz0o8oND0xT5D79MoyB0UQ=;
	b=ihgPZ+//NFxQQg32Iui3xrYE+mJMMc54Q2gwm8kHqUCkL4zvmNywc+QyANT2OMt+G/vL5l
	bCpidOsbAd1p62YwktbZL5EktjtKt3lXRIO6r242Ib5mkC7Nim3pn+8aom1ruoIBlvx/rH
	SqcQ+rCn833VrJwQQwM3tVNgq3TQ2b7lrj3/5QSsDJr6MNPRZv1t0KMK8nScVK9/aYz1q9
	+eH+sZuCYFaglVGz2GsjNHQV6k/iH5Xg1e6SjWD3M4Z5Pu+9/0JmHbbq/bXeu5HMyBO+9a
	ccW80HCgyHb2NxedNh9C+eAfZJ7M29tJPQjIhcQbCUkAjMgQDM01sjEayOkptA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741078424;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JlUDYlBqaGiI3XiQxvwaaxz0o8oND0xT5D79MoyB0UQ=;
	b=Frhz47KOn/UINqHzCJL1m45jlK2RZLnPu5LqYPli+xaNkNQsQrlEw9GgqeShlISUCmP7Rx
	83JYwpQmvejMkADw==
To: Borislav Petkov <bp@alien8.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	John Ogness <john.ogness@linutronix.de>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	x86@kernel.org,
	x86-cpuid@lists.linux.dev,
	LKML <linux-kernel@vger.kernel.org>,
	"Ahmed S. Darwish" <darwi@linutronix.de>
Subject: [PATCH v1 30/40] sizes.h: Cover all possible x86 cpu cache sizes
Date: Tue,  4 Mar 2025 09:51:41 +0100
Message-ID: <20250304085152.51092-31-darwi@linutronix.de>
In-Reply-To: <20250304085152.51092-1-darwi@linutronix.de>
References: <20250304085152.51092-1-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add size macros for 24/192/384 Kilobyes and 3/6/12/18/24 Megabytes.

With that, the x86 subsystem can avoid locally defining its own macros
for CPU cache sizs.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
---
 include/linux/sizes.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/linux/sizes.h b/include/linux/sizes.h
index c3a00b967d18..49039494076f 100644
--- a/include/linux/sizes.h
+++ b/include/linux/sizes.h
@@ -23,17 +23,25 @@
 #define SZ_4K				0x00001000
 #define SZ_8K				0x00002000
 #define SZ_16K				0x00004000
+#define SZ_24K				0x00006000
 #define SZ_32K				0x00008000
 #define SZ_64K				0x00010000
 #define SZ_128K				0x00020000
+#define SZ_192K				0x00030000
 #define SZ_256K				0x00040000
+#define SZ_384K				0x00060000
 #define SZ_512K				0x00080000
 
 #define SZ_1M				0x00100000
 #define SZ_2M				0x00200000
+#define SZ_3M				0x00300000
 #define SZ_4M				0x00400000
+#define SZ_6M				0x00600000
 #define SZ_8M				0x00800000
+#define SZ_12M				0x00c00000
 #define SZ_16M				0x01000000
+#define SZ_18M				0x01200000
+#define SZ_24M				0x01800000
 #define SZ_32M				0x02000000
 #define SZ_64M				0x04000000
 #define SZ_128M				0x08000000
-- 
2.48.1


