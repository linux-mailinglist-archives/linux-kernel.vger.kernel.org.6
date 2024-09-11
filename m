Return-Path: <linux-kernel+bounces-324216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCE85974994
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 07:15:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 190FE1C24237
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 05:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9314E13D298;
	Wed, 11 Sep 2024 05:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="u1DOw1re";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eXA1Yii/"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31BD77E111
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 05:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726031637; cv=none; b=B2760odFcNyBM6mKLF0tSk6BzuADEwW+jThIt29HufzaoR8IV/+jz8tH6dWdEQ1b/XiXC2UxaCcsOpi0mNePODEcVE27XebLmSZZ7eVGDLBXwQl0KSewlChpDzFOjFsUI2YosNf5I7kesKdnOXejrZIrETlQI1LUre5BHbyKm3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726031637; c=relaxed/simple;
	bh=Y0mUmw49im+/GxQ7ebJqx9Ja6vnn3XngWh6DjT6xiJ4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SrRkzEuIRrqgetC3AH4Zm5BauIB72b81WKWOo4Ah4+2UbXfWn9yuhxbmvQnMf0kWMt+I2UQ3A11CJ48UTLflhxBiQfeVDWsKjIe4psXzjr/SAgMkqbjDCNkSxi385Do9SbwZ00EphKM3bolc91KtnGktyRYE/82fcqIM3K37aa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=u1DOw1re; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eXA1Yii/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1726031632;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QzFZJPN6OCoOjFijLF5zzv1PdmAEslKaMmEzLI7TVjw=;
	b=u1DOw1rekShoZKYrisI0JTDw0ueDxQ8yOvgBI4siUh5NJNxMPHdC4McmKm4TUvGmwX7DlO
	vJcjBXpn33sCGsQEDnO82zhG6Ga6RTeTX+zaDRY0T4jffoD2n9sefDTK3mMmxfYi00+Jq+
	xbWi/gzjF6T1YghA76QHhFNgDd/ajrbCfjZWY7j+bvbKU0IKdCbRHpRhLQEcatlM/ygwYC
	NmbAQX2W0t1j/cYn/G5g2mxAmWbTswen9SFKw0+P52MTBdIzBqLwih6YxbqpdRSzAfC5yR
	ngKRoPN9gFufCzHna6+XaoYCbrVffWPlFoBhBpXR9k0Px3gCrPNMRdfVQ8peoQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1726031632;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QzFZJPN6OCoOjFijLF5zzv1PdmAEslKaMmEzLI7TVjw=;
	b=eXA1Yii/JbU6EU7r0wGToYKKRGQcrldJLVEVG4g5V0MinWISWmtw5FCmF6Tv8TPhogPZcf
	EIKYD1cuMA5uvJDw==
Date: Wed, 11 Sep 2024 07:13:33 +0200
Subject: [PATCH v2 07/15] timers: Adjust flseep() to reflect reality
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240911-devel-anna-maria-b4-timers-flseep-v2-7-b0d3f33ccfe0@linutronix.de>
References: <20240911-devel-anna-maria-b4-timers-flseep-v2-0-b0d3f33ccfe0@linutronix.de>
In-Reply-To: <20240911-devel-anna-maria-b4-timers-flseep-v2-0-b0d3f33ccfe0@linutronix.de>
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


