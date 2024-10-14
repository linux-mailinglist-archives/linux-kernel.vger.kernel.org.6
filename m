Return-Path: <linux-kernel+bounces-363482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 166BD99C306
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 10:24:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0A8228345C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 08:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEFC3158531;
	Mon, 14 Oct 2024 08:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pmhoyqKY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ania52HS"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D67315575E;
	Mon, 14 Oct 2024 08:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728894170; cv=none; b=UETpqQ5umLmExaPi8yNuS6mOhOufF8Ef8aEe9+zWVNc4Izlq5Wp50GHDJofMUTkPaho4XHB5AB24M8guyuVgfYt/DE67uVb9n1WelJWMgZ50JRgT1kmUvrp24KWG0BOQ7qzrDP1gkehwgwB+aciD9JMMogkwY1OE7m6fbeG3vHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728894170; c=relaxed/simple;
	bh=nQNvsQI/LKOxp28gKqTsbBASM5OGfHUopU7DTfBEIvg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HpO9H8tpdhiuqyKKwCTwnR6HZf71G1aQe8TqiIGashvvLehCiNwlxpve0RsZfRlt0viMtAYIGDNu15gEvk3N9eI84GdVTaSkRlvN+oadmncD9zhbZZtFiFmfBdMk9M7RzzLjvemjRZI/vR+nWdc9Hqn2idrXKO7N1GYulIjdhig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pmhoyqKY; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ania52HS; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728894166;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ry+dtPsZBklLhcJ65uITnod4UvodhQ0YRrocNcHCAkI=;
	b=pmhoyqKY6/Hp+Nbkc7dId8BgCrzDJ6QT1UuIAFnkO98NXVGsIeP2puUTcKXXoRAgtnRv4t
	v3JHN9LN6hTMcmamRJFwfGd8KT8qrZTuj08JTdvPeKqS2pgHTR+9I17zcGqGJfBZ8ROWNc
	XhN942L6KWxiyE5G9R/l70YbCDsVuSmwwXTP2GgoyCi1ko4JzQ5G3fka/yloL2+fN7qQAH
	HLmBr6Ja4ZNW51iuRnX3Wax4vr+CKfwna0Qy03RlhGPzmFEqsktP97h9E/TUMImncdfLfj
	flm50SQ/4XzMxPXUkYOtd1xHBiIyJIhkiynMFJzjkL5mnz7GG2QV5bfF+2WBIA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728894166;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ry+dtPsZBklLhcJ65uITnod4UvodhQ0YRrocNcHCAkI=;
	b=Ania52HS0L2fPfnAAHtSDj1YuoBZ8Em64TR+UWoTyfZqGcr76FyIrr3kqQKG5cEckfBvAu
	iGEBM4FwulsR7AAA==
Date: Mon, 14 Oct 2024 10:22:23 +0200
Subject: [PATCH v3 06/16] delay: Rework udelay and ndelay
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241014-devel-anna-maria-b4-timers-flseep-v3-6-dc8b907cb62f@linutronix.de>
References: <20241014-devel-anna-maria-b4-timers-flseep-v3-0-dc8b907cb62f@linutronix.de>
In-Reply-To: <20241014-devel-anna-maria-b4-timers-flseep-v3-0-dc8b907cb62f@linutronix.de>
To: Frederic Weisbecker <frederic@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, rust-for-linux@vger.kernel.org, 
 Alice Ryhl <aliceryhl@google.com>, 
 FUJITA Tomonori <fujita.tomonori@gmail.com>, Andrew Lunn <andrew@lunn.ch>, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>, 
 Miguel Ojeda <ojeda@kernel.org>

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
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
---
v3: Fix build error for i386 (missing linux/math.h include).

v2: New in v2 (as suggested by Thomas)
---
 include/asm-generic/delay.h | 65 ++++++++++++++++++++++++++-------------------
 1 file changed, 37 insertions(+), 28 deletions(-)

diff --git a/include/asm-generic/delay.h b/include/asm-generic/delay.h
index a8cee41cc51b..76cf237b6e4c 100644
--- a/include/asm-generic/delay.h
+++ b/include/asm-generic/delay.h
@@ -2,6 +2,9 @@
 #ifndef __ASM_GENERIC_DELAY_H
 #define __ASM_GENERIC_DELAY_H
 
+#include <linux/math.h>
+#include <vdso/time64.h>
+
 /* Undefined functions to get compile-time errors */
 extern void __bad_udelay(void);
 extern void __bad_ndelay(void);
@@ -12,13 +15,18 @@ extern void __const_udelay(unsigned long xloops);
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
@@ -45,17 +53,17 @@ extern void __delay(unsigned long loops);
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
@@ -63,16 +71,17 @@ extern void __delay(unsigned long loops);
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
2.39.5


