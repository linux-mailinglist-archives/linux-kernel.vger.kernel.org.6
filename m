Return-Path: <linux-kernel+bounces-315088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FF4996BDDC
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 15:08:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BB8F1F26B0A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 13:08:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28D2A1DCB28;
	Wed,  4 Sep 2024 13:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Nzr4EQHY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PtBCvLOn"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF081DC1AB
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 13:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725455139; cv=none; b=GrRyh42mDk7I1oN7GW9/tT0LqOSWufN6pGyrIUhtuLCep5ua5YxQaceUDGBvFoaJvc3rJIzqeGRX6oSAYL5PjzdCs8J3rfHlJjUT/pQbMgv6w0kDI90XfxKl8oYAz179PwAltuKdM0n9sHl1QBEDlXXc006x9beKOmAbOcaNBCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725455139; c=relaxed/simple;
	bh=Y0mUmw49im+/GxQ7ebJqx9Ja6vnn3XngWh6DjT6xiJ4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aPiCTcaV1aMRzaQaRk5jUwlzMNGzuEfjz4OPxWluXp1ODYm2n4X4j4eyy0PaHjSLtK5bb1qE6tDaanZy+CGySRivCrQjlYy+qGcOGEhORF6lGhE5I04/bMSB+c/7iTcpg2wwMm/glyru3ppeECxSuAHAOPSuuC8o76LxIpD1Q7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Nzr4EQHY; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PtBCvLOn; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725455135;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QzFZJPN6OCoOjFijLF5zzv1PdmAEslKaMmEzLI7TVjw=;
	b=Nzr4EQHYlyIMIpic/3BDET4263SCnG8oHigCRvoTDervAgGX+aK63HtpD0ngLnvVRfTlUi
	WK/Ar03LRiNzXTffIcBX5AA4h/3RB551yrXtCMnd6fCey1WKVbdD2IUFy3w01Rmtn3EGKq
	Njb77TJqkCxBhCJR64zGsD4J2+8r736BIjMHLFCQnCEg+uyoDeDT1y/HgqFtWXBTFE7JYr
	Ej3wMfSsBShL7dRo9r6RMcEYKknlLZsnoPegtcSLg+tTvYArR5KF2FTWLSIixan03JdxDT
	Dn5TGLNoHiEUmOFw66ShxDY6dW97DTXQ8piTrNLB3CPpNsduColNKJIONyVS4A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725455135;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QzFZJPN6OCoOjFijLF5zzv1PdmAEslKaMmEzLI7TVjw=;
	b=PtBCvLOnizTzndJBtagTZ7VBAzA4O6RNpa0ih7NZnIM6jaDbMrwbJxW5KlYtO3/RMTqV/x
	e7EG/X0WJ44wa1BA==
Date: Wed, 04 Sep 2024 15:04:57 +0200
Subject: [PATCH 07/15] timers: Adjust flseep() to reflect reality
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240904-devel-anna-maria-b4-timers-flseep-v1-7-e98760256370@linutronix.de>
References: <20240904-devel-anna-maria-b4-timers-flseep-v1-0-e98760256370@linutronix.de>
In-Reply-To: <20240904-devel-anna-maria-b4-timers-flseep-v1-0-e98760256370@linutronix.de>
To: Frederic Weisbecker <frederic@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>

fsleep() simply implements the recommondations of the outdated
documentation in "Documentation/timers/timers-howto.rst". This should be a
user friendly interface to choose always the best timeout function
approach:

- udelay() for very short sleep durations shorter than 10 microseconds
- usleep_range() for sleep durations until 20 milliseconds
- msleep() for the others

The actual implementation has several problems:

- It does not take into account that HZ resolution also has an impact on
  granularity of jiffies and has also an impact on the granularity of the
  buckets of timer wheel levels. This means that accuracy for the timeout
  does not have an upper limit. When executing fsleep(20000) on a HZ=100
  system, the possible additional slack will be 50% as the granularity of
  the buckets in the lowest level is 10 milliseconds.

- The upper limit of usleep_range() is twice the requested timeout. When no
  other interrupts occur in this range, the maximum value is used. This
  means that the requested sleep length has then an additional delay of
  100%.

Change the thresholds for the decisions in fsleep() to make sure the
maximum slack which is added to the sleep duration is 25%.

Note: Outdated documentation will be updated in a followup patch.

Cc: Heiner Kallweit <hkallweit1@gmail.com>
Cc: David S. Miller <davem@davemloft.net>
Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
---
 include/linux/delay.h | 29 +++++++++++++++++++++++++----
 1 file changed, 25 insertions(+), 4 deletions(-)

diff --git a/include/linux/delay.h b/include/linux/delay.h
index 23623fa79768..b49a63c85c43 100644
--- a/include/linux/delay.h
+++ b/include/linux/delay.h
@@ -11,6 +11,7 @@
 
 #include <linux/math.h>
 #include <linux/sched.h>
+#include <linux/jiffies.h>
 
 extern unsigned long loops_per_jiffy;
 
@@ -102,15 +103,35 @@ static inline void ssleep(unsigned int seconds)
 	msleep(seconds * 1000);
 }
 
-/* see Documentation/timers/timers-howto.rst for the thresholds */
+static const unsigned int max_slack_shift = 2;
+#define USLEEP_RANGE_UPPER_BOUND	((TICK_NSEC << max_slack_shift) / NSEC_PER_USEC)
+
+/**
+ * fsleep - flexible sleep which autoselects the best mechanism
+ * @usecs:	requested sleep duration in microseconds
+ *
+ * flseep() selects the best mechanism that will provide maximum 25% slack
+ * to the requested sleep duration. Therefore it uses:
+ *
+ * * udelay() loop for sleep durations <= 10 microseconds to avoid hrtimer
+ *   overhead for really short sleep durations.
+ * * usleep_range() for sleep durations which would lead with the usage of
+ *   msleep() to a slack larger than 25%. This depends on the granularity of
+ *   jiffies.
+ * * msleep() for all other sleep durations.
+ *
+ * Note: When %CONFIG_HIGH_RES_TIMERS is not set, all sleeps are processed with
+ * the granularity of jiffies and the slack might exceed 25% especially for
+ * short sleep durations.
+ */
 static inline void fsleep(unsigned long usecs)
 {
 	if (usecs <= 10)
 		udelay(usecs);
-	else if (usecs <= 20000)
-		usleep_range(usecs, 2 * usecs);
+	else if (usecs < USLEEP_RANGE_UPPER_BOUND)
+		usleep_range(usecs, usecs + (usecs >> max_slack_shift));
 	else
-		msleep(DIV_ROUND_UP(usecs, 1000));
+		msleep(DIV_ROUND_UP(usecs, USEC_PER_MSEC));
 }
 
 #endif /* defined(_LINUX_DELAY_H) */

-- 
2.39.2


