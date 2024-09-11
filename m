Return-Path: <linux-kernel+bounces-324212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F3FF97498E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 07:14:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C4E4B24B67
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 05:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1024613AD05;
	Wed, 11 Sep 2024 05:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FdFovYyA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NDb7wmuk"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 930F17DA76
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 05:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726031637; cv=none; b=rvAavjyOFvgBSmA3qHVQBSuuIleEyFGb2XHYc+9X3q2TFiodelPqbz7FU7zwvsqT6iD4VK6WCBTBpka8Nd8Ff3YOtXEiPZBjOjTJGFgvJeuRfE2x2jkERTIIzjXRMfHt8d/rcKcbngCuKKdFgCk3H3LC+KpGqmSfAEJUFtKs6Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726031637; c=relaxed/simple;
	bh=7kNqdXwdUO9/IpfBmIdMGRUAVzjRp2Kc3/vJYDgks9A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LBtF8vYYkvD4maQoZEtthiCBD82XmwGpz8UmdPGOeuA5XD1/dRIMDAcW8pFqW4unv0S3PiG3y0Qdpqlh2cBXM9P6vf5xgOssnguNs5wOTXD3WrFow6yAQqzhVUyHDeWGNj3bQ34xxCceX7SZThtySXKECddmgFDGuJoDGAUya9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FdFovYyA; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NDb7wmuk; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1726031632;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F4fL5hcjRXOThZ7KBgdAy6TEeH1clm4HbG/CjFmZlDE=;
	b=FdFovYyATS9pTzzS4D8tcN5BrKTRO8ws4H8aT9mVXpMwrilnwvjlUAd/r6q2BkmFlzRP3K
	NYr/8Cpr1w7Du0RBGdVt7hrsJpRIYVMS3ojP1NEVlH5qI6g9yavBD0wF1zcJAgYaX2vA69
	3JQls7R44Q+WD/7qJZR28gYvDspWWCweeTR34J7AAEuXBI33fKM/XvONcX5NtxhahK9wiT
	SJ48Zd436Ef+y6TL8NiAKoUrn/1gz4NKPB3N2pyUDCoatah5Ik0VDkG2hPiKGuH/KQ++2R
	WNCYUHMmswXnWZxxP4zpu0T9/E8llGr1sqdMyt90pHYFSy2WYot5zVOzrm5h8A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1726031632;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F4fL5hcjRXOThZ7KBgdAy6TEeH1clm4HbG/CjFmZlDE=;
	b=NDb7wmukiM1q8phUYl04XH84C14C30GeHoaWMQDVJld3b17zQMXQ83M36ns1ZTxVI1fLdE
	dkUKEV6sj6y2T4Dg==
Date: Wed, 11 Sep 2024 07:13:32 +0200
Subject: [PATCH v2 06/15] delay: Rework udelay and ndelay
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240911-devel-anna-maria-b4-timers-flseep-v2-6-b0d3f33ccfe0@linutronix.de>
References: <20240911-devel-anna-maria-b4-timers-flseep-v2-0-b0d3f33ccfe0@linutronix.de>
In-Reply-To: <20240911-devel-anna-maria-b4-timers-flseep-v2-0-b0d3f33ccfe0@linutronix.de>
To: Frederic Weisbecker <frederic@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>

udelay() as well as ndelay() are defines and no functions and are using
constants to be able to transform a sleep time into loops and to prevent
too long udelays/ndelays. There was a compiler error with non-const 8 bit
arguments which was fixed by commit a87e553fabe8 ("asm-generic: delay.h fix
udelay and ndelay for 8 bit args"). When using a function, the non-const 8
bit argument is type casted and the problem would be gone.

Transform udelay() and ndelay() into proper functions, remove the no longer
and confusing division, add defines for the magic values and add some
explanations as well.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
---
v2: New in v2 (as suggested by Thomas)
---
 include/asm-generic/delay.h | 64 +++++++++++++++++++++++++--------------------
 1 file changed, 36 insertions(+), 28 deletions(-)

diff --git a/include/asm-generic/delay.h b/include/asm-generic/delay.h
index 70a1b20f3e1a..40d30dc2488b 100644
--- a/include/asm-generic/delay.h
+++ b/include/asm-generic/delay.h
@@ -2,6 +2,8 @@
 #ifndef __ASM_GENERIC_DELAY_H
 #define __ASM_GENERIC_DELAY_H
 
+#include <vdso/time64.h>
+
 /* Undefined functions to get compile-time errors */
 extern void __bad_udelay(void);
 extern void __bad_ndelay(void);
@@ -12,13 +14,18 @@ extern void __const_udelay(unsigned long xloops);
 extern void __delay(unsigned long loops);
 
 /*
- * Implementation details:
- *
- * * The weird n/20000 thing suppresses a "comparison is always false due to
- *   limited range of data type" warning with non-const 8-bit arguments.
- * * 0x10c7 is 2**32 / 1000000 (rounded up) -> udelay
- * * 0x5 is 2**32 / 1000000000 (rounded up) -> ndelay
+ * The microseconds/nanosecond delay multiplicators are used to convert a
+ * constant microseconds/nanoseconds value to a value which can be used by the
+ * architectures specific implementation to transform it into loops.
+ */
+#define UDELAY_CONST_MULT	((unsigned long)DIV_ROUND_UP(1ULL << 32, USEC_PER_SEC))
+#define NDELAY_CONST_MULT	((unsigned long)DIV_ROUND_UP(1ULL << 32, NSEC_PER_SEC))
+
+/*
+ * The maximum constant udelay/ndelay value picked out of thin air to prevent
+ * too long constant udelays/ndelays.
  */
+#define DELAY_CONST_MAX   20000
 
 /**
  * udelay - Inserting a delay based on microseconds with busy waiting
@@ -45,17 +52,17 @@ extern void __delay(unsigned long loops);
  * #. cache behaviour affecting the time it takes to execute the loop function.
  * #. CPU clock rate changes.
  */
-#define udelay(n)							\
-	({								\
-		if (__builtin_constant_p(n)) {				\
-			if ((n) / 20000 >= 1)				\
-				 __bad_udelay();			\
-			else						\
-				__const_udelay((n) * 0x10c7ul);		\
-		} else {						\
-			__udelay(n);					\
-		}							\
-	})
+static __always_inline void udelay(unsigned long usec)
+{
+	if (__builtin_constant_p(usec)) {
+		if (usec >= DELAY_CONST_MAX)
+			__bad_udelay();
+		else
+			__const_udelay(usec * UDELAY_CONST_MULT);
+	} else {
+		__udelay(usec);
+	}
+}
 
 /**
  * ndelay - Inserting a delay based on nanoseconds with busy waiting
@@ -63,16 +70,17 @@ extern void __delay(unsigned long loops);
  *
  * See udelay() for basic information about ndelay() and it's variants.
  */
-#define ndelay(n)							\
-	({								\
-		if (__builtin_constant_p(n)) {				\
-			if ((n) / 20000 >= 1)				\
-				__bad_ndelay();				\
-			else						\
-				__const_udelay((n) * 5ul);		\
-		} else {						\
-			__ndelay(n);					\
-		}							\
-	})
+static __always_inline void ndelay(unsigned long nsec)
+{
+	if (__builtin_constant_p(nsec)) {
+		if (nsec >= DELAY_CONST_MAX)
+			__bad_udelay();
+		else
+			__const_udelay(nsec * NDELAY_CONST_MULT);
+	} else {
+		__udelay(nsec);
+	}
+}
+#define ndelay(x) ndelay(x)
 
 #endif /* __ASM_GENERIC_DELAY_H */

-- 
2.39.2


