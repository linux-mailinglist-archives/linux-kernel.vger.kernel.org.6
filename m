Return-Path: <linux-kernel+bounces-363484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 78D9299C309
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 10:24:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F25E1C228E1
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 08:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98DCF158D81;
	Mon, 14 Oct 2024 08:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="M0ystn3b";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VIcrpJ1c"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD32155C98;
	Mon, 14 Oct 2024 08:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728894171; cv=none; b=FvjOgVmjlw/TsPQy0Q1HxtTdxpLn4utEi87dnEtTg0RCoj09FJGLd0FqzXjwmShWBqb/vNB2vtY8fyDBpROVBM0WiuFH6afqSQriU2zhiNeAC6V9+CK3dqadcK28Bk3XZYkPGlwGPpdQSVHQ5QF5tE4R28+1x+0rrVUsCnlCmnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728894171; c=relaxed/simple;
	bh=mliOT04cAh0Q6sqAuNHbuq0J5E8JkqPoIqygnaYqzZc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bfF5YBvDXUpwlJQdLlFyv22CnI+F/Fpf5bB57p/bpDMOpZd7wAWktrqsjfwF+QlxpBono+7DvJ0Jr+epxgmOh54iw230ie04nSdNdHpkmG3UWKCqBjEuuKpI6DtwLEBBcvx/9YPM5cGFI5nLqmcN4OAK0QV/W8WTTABhW5HTJmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=M0ystn3b; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VIcrpJ1c; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728894166;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F26ftp0OugXu3D3/MI+RurcrPxczoX+xyN50is4hTYs=;
	b=M0ystn3bumIXHy9z1o3sSXgyQoP8aozHFUTgRjIUo+IH/HMHLBWUmmzDBkcA0eHSDl0BV/
	BgWJeuCMBRihoABB0qtMtyDDzksS8iGnF0GcKuM13jgn9AaQRXWCGrVh30Lljn4gY4cQ3c
	/OVkVWIs8QuAyIHao1kaCqKhkv01TzavqWm+TDNtrrqNXerCkPX97C6Ctg+OWk2DGT1H8S
	pqmZIsUZe4PblDIVfTB72jEPkxelJfK4PAfafizMek86zakqsQ8ijX9RfsOTa5wECN3Elr
	NySoK+lzy7fmIo+4fYk3WZbshbt9miXTboL7ciGSZ1k4xZI5KJG7yVBoQSNz+g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728894166;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F26ftp0OugXu3D3/MI+RurcrPxczoX+xyN50is4hTYs=;
	b=VIcrpJ1cZk5Ja9vWRi+0ahqJk2cq0HNo1EWN49MYzamPW/538Ge9rKVFbNsMwieim2u9Su
	fnNqRyv1VOWHPeDw==
Date: Mon, 14 Oct 2024 10:22:24 +0200
Subject: [PATCH v3 07/16] timers: Adjust flseep() to reflect reality
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241014-devel-anna-maria-b4-timers-flseep-v3-7-dc8b907cb62f@linutronix.de>
References: <20241014-devel-anna-maria-b4-timers-flseep-v3-0-dc8b907cb62f@linutronix.de>
In-Reply-To: <20241014-devel-anna-maria-b4-timers-flseep-v3-0-dc8b907cb62f@linutronix.de>
To: Frederic Weisbecker <frederic@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, rust-for-linux@vger.kernel.org, 
 Alice Ryhl <aliceryhl@google.com>, 
 FUJITA Tomonori <fujita.tomonori@gmail.com>, Andrew Lunn <andrew@lunn.ch>, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>, 
 Miguel Ojeda <ojeda@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>

fsleep() simply implements the recommendations of the outdated
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
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
---
 include/linux/delay.h | 29 +++++++++++++++++++++++++----
 1 file changed, 25 insertions(+), 4 deletions(-)

diff --git a/include/linux/delay.h b/include/linux/delay.h
index 2de509e4adce..89866bab100d 100644
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
2.39.5


