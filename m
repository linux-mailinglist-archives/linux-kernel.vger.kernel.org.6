Return-Path: <linux-kernel+bounces-324222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E88197499C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 07:16:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7DA6B24909
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 05:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ED4714F9FE;
	Wed, 11 Sep 2024 05:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qUJUVXpo";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xGenxOzP"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2701613C816
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 05:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726031641; cv=none; b=CpIK6oe7qHmZScXyop5HRngPoD+4HhZvT/n5aTxrDTM8hNgM7FK9o8TXS+Cc7CtDgm4Ahv2H6vun3vNJa26p3Rgh4HSns7QJzAGeknciffkMfxsqRimKyDagwv7lOQ/vjP3LnqVF5WPIahxhIoLkxzEK/f3/vYXm48s5/BjX/q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726031641; c=relaxed/simple;
	bh=MnkTO+SoXn9ALpaHKD0yv6agPOoMrHkkYtt8oXOQSeI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jjV9pdqIKeVCMGCCGOdOQmpc2GXbWnRvBOP7CbDnylK1dWKQDcC7MYTuzXgazIjovImVveFG8NLFg36VfloVsOgxdr9nXK3xjxt9IoBSrJEp114vwd4VKPRZTmFQox8CYd4CnRZ3l0F44FeMtYHjoSmfdV4qZ7/FLIcjY73pz34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qUJUVXpo; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xGenxOzP; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1726031635;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vaCS8Wy4nmdabahzumttPewmZzyJlsqugb8Ai6FeVCc=;
	b=qUJUVXpo+w8k7UOLSozBCH3cfFvB+lbfSSFMDP2O1zhNoZTEAVIhcmdR4a89QDj36ng/1u
	e8UulYJWUTFbCNLJsLcFA6zarbw4i2GJMGH5VOFdzPDFWWYCefzSydjkRAYR1h7kT659mU
	PMdWCXNv4yZUNEmfKU4IBv755M6a3WdflUPaT3HD38w98Aq/xMhzn91F550TQBM8fy0FbK
	9NwhaKrws13IybhbCoUZZNu+nVkZ5CtxshASgdUeUTAxTAwNz1CvRl3GccEJf+BWG8Q/9i
	h76WpFCgvISispVKKYnZgyLBpEEWIxpMdibu4BhSbX1s23WH5vJj2anrWWesBA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1726031635;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vaCS8Wy4nmdabahzumttPewmZzyJlsqugb8Ai6FeVCc=;
	b=xGenxOzPtacHbWbO5o8pyUlGMMDPx3VtSeFvOvW5vBolYYgFOqfFIO4h2tGhk4uDqQpPyq
	0uat33lrr53ZjEBA==
Date: Wed, 11 Sep 2024 07:13:41 +0200
Subject: [PATCH v2 15/15] timers/Documentation: Cleanup delay/sleep
 documentation
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240911-devel-anna-maria-b4-timers-flseep-v2-15-b0d3f33ccfe0@linutronix.de>
References: <20240911-devel-anna-maria-b4-timers-flseep-v2-0-b0d3f33ccfe0@linutronix.de>
In-Reply-To: <20240911-devel-anna-maria-b4-timers-flseep-v2-0-b0d3f33ccfe0@linutronix.de>
To: Frederic Weisbecker <frederic@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>

The documentation which tries to give advises how to properly inserting
delays or sleeps is outdated. The file name is 'timers-howto.rst' which
might be missleading as it is only about delay and sleep mechanisms and not
how to use timers.

Update the documentation by integrating the important parts from the
related function descriptions and move it all into a self explaining file
with the name "delay_sleep_functions.rst".

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
---
 Documentation/timers/delay_sleep_functions.rst | 122 +++++++++++++++++++++++++
 Documentation/timers/index.rst                 |   2 +-
 Documentation/timers/timers-howto.rst          | 115 -----------------------
 3 files changed, 123 insertions(+), 116 deletions(-)

diff --git a/Documentation/timers/delay_sleep_functions.rst b/Documentation/timers/delay_sleep_functions.rst
new file mode 100644
index 000000000000..05d7c3c8fbe8
--- /dev/null
+++ b/Documentation/timers/delay_sleep_functions.rst
@@ -0,0 +1,122 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+Delay and sleep mechanisms
+==========================
+
+This document seeks to answer the common question: "What is the
+RightWay (TM) to insert a delay?"
+
+This question is most often faced by driver writers who have to
+deal with hardware delays and who may not be the most intimately
+familiar with the inner workings of the Linux Kernel.
+
+The following table gives a rough overview about the existing function
+'families' and their limitations. This overview table does not replace the
+reading of the function description before usage!
+
+.. list-table::
+   :widths: 20 20 20 20 20
+   :header-rows: 2
+
+   * -
+     - `*delay()`
+     - `usleep_range*()`
+     - `*sleep()`
+     - `fsleep()`
+   * -
+     - busy-wait loop
+     - hrtimers based
+     - timer list timers based
+     - combines the others
+   * - Usage in atomic Context
+     - yes
+     - no
+     - no
+     - no
+   * - precise on "short intervals"
+     - yes
+     - yes
+     - depends
+     - yes
+   * - precise on "long intervals"
+     - Do not use!
+     - yes
+     - max 12.5% slack
+     - yes
+   * - interruptible variant
+     - no
+     - yes
+     - yes
+     - no
+
+A generic advice for non atomic contexts could be:
+
+#. Use `fsleep()` whenever unsure (as it combines all the advantages of the
+   others)
+#. Use `*sleep()` whenever possible
+#. Use `usleep_range*()` whenever accuracy of `*sleep()` is not sufficient
+#. Use `*delay()` for very, very short delays
+
+Find some more detailed information about the function 'families' in the next
+sections.
+
+`*delay()` family of functions
+------------------------------
+
+These functions use the jiffy estimation of clock speed and will busy wait for
+enough loop cycles to achieve the desired delay. udelay() is the basic
+implementation and ndelay() as well as mdelay() are variants.
+
+These functions are mainly used to add a delay in atomic context. Please make
+sure to ask yourself before adding a delay in atomic context: Is this really
+required?
+
+.. kernel-doc:: include/asm-generic/delay.h
+	:identifiers: udelay ndelay
+
+.. kernel-doc:: include/linux/delay.h
+	:identifiers: mdelay
+
+
+`usleep_range*()` and `*sleep()` family of functions
+----------------------------------------------------
+
+These functions uses hrtimers or timer list timers to provide the requested
+sleeping duration. For a decision which function is the right one to use, take
+some basic information into account:
+
+#. hrtimers are more expensive as they are using an rb-tree (instead of hashing)
+#. hrtimers are more expensive when the requested sleeping duration is the first
+   timer which means real hardware has to be programmed
+#. timer list timers always providing some sort of slack as they are jiffy
+   based
+
+The generic advice is repeated here:
+
+#. Use `fsleep()` whenever unsure (as it combines all the advantages of the
+   others)
+#. Use `*sleep()` whenever possible
+#. Use `usleep_range*()` whenever accuracy of `*sleep()` is not sufficient
+
+First check fsleep() function description and to learn more about accuracy,
+please check msleep() function description.
+
+
+`usleep_range*()`
+~~~~~~~~~~~~~~~~~
+
+.. kernel-doc:: include/linux/delay.h
+	:identifiers: usleep_range usleep_range_idle
+
+.. kernel-doc:: kernel/time/sleep_timeout.c
+	:identifiers: usleep_range_state
+
+
+`*sleep()`
+~~~~~~~~~~
+
+.. kernel-doc:: kernel/time/sleep_timeout.c
+       :identifiers: msleep msleep_interruptible
+
+.. kernel-doc:: include/linux/delay.h
+	:identifiers: ssleep fsleep
diff --git a/Documentation/timers/index.rst b/Documentation/timers/index.rst
index 983f91f8f023..4e88116e4dcf 100644
--- a/Documentation/timers/index.rst
+++ b/Documentation/timers/index.rst
@@ -12,7 +12,7 @@ Timers
     hrtimers
     no_hz
     timekeeping
-    timers-howto
+    delay_sleep_functions
 
 .. only::  subproject and html
 
diff --git a/Documentation/timers/timers-howto.rst b/Documentation/timers/timers-howto.rst
deleted file mode 100644
index ef7a4652ccc9..000000000000
--- a/Documentation/timers/timers-howto.rst
+++ /dev/null
@@ -1,115 +0,0 @@
-===================================================================
-delays - Information on the various kernel delay / sleep mechanisms
-===================================================================
-
-This document seeks to answer the common question: "What is the
-RightWay (TM) to insert a delay?"
-
-This question is most often faced by driver writers who have to
-deal with hardware delays and who may not be the most intimately
-familiar with the inner workings of the Linux Kernel.
-
-
-Inserting Delays
-----------------
-
-The first, and most important, question you need to ask is "Is my
-code in an atomic context?"  This should be followed closely by "Does
-it really need to delay in atomic context?" If so...
-
-ATOMIC CONTEXT:
-	You must use the `*delay` family of functions. These
-	functions use the jiffy estimation of clock speed
-	and will busy wait for enough loop cycles to achieve
-	the desired delay:
-
-	ndelay(unsigned long nsecs)
-	udelay(unsigned long usecs)
-	mdelay(unsigned long msecs)
-
-	udelay is the generally preferred API; ndelay-level
-	precision may not actually exist on many non-PC devices.
-
-	mdelay is macro wrapper around udelay, to account for
-	possible overflow when passing large arguments to udelay.
-	In general, use of mdelay is discouraged and code should
-	be refactored to allow for the use of msleep.
-
-NON-ATOMIC CONTEXT:
-	You should use the `*sleep[_range]` family of functions.
-	There are a few more options here, while any of them may
-	work correctly, using the "right" sleep function will
-	help the scheduler, power management, and just make your
-	driver better :)
-
-	-- Backed by busy-wait loop:
-
-		udelay(unsigned long usecs)
-
-	-- Backed by hrtimers:
-
-		usleep_range(unsigned long min, unsigned long max)
-
-	-- Backed by jiffies / legacy_timers
-
-		msleep(unsigned long msecs)
-		msleep_interruptible(unsigned long msecs)
-
-	Unlike the `*delay` family, the underlying mechanism
-	driving each of these calls varies, thus there are
-	quirks you should be aware of.
-
-
-	SLEEPING FOR "A FEW" USECS ( < ~10us? ):
-		* Use udelay
-
-		- Why not usleep?
-			On slower systems, (embedded, OR perhaps a speed-
-			stepped PC!) the overhead of setting up the hrtimers
-			for usleep *may* not be worth it. Such an evaluation
-			will obviously depend on your specific situation, but
-			it is something to be aware of.
-
-	SLEEPING FOR ~USECS OR SMALL MSECS ( 10us - 20ms):
-		* Use usleep_range
-
-		- Why not msleep for (1ms - 20ms)?
-			Explained originally here:
-				https://lore.kernel.org/r/15327.1186166232@lwn.net
-
-			msleep(1~20) may not do what the caller intends, and
-			will often sleep longer (~20 ms actual sleep for any
-			value given in the 1~20ms range). In many cases this
-			is not the desired behavior.
-
-		- Why is there no "usleep" / What is a good range?
-			Since usleep_range is built on top of hrtimers, the
-			wakeup will be very precise (ish), thus a simple
-			usleep function would likely introduce a large number
-			of undesired interrupts.
-
-			With the introduction of a range, the scheduler is
-			free to coalesce your wakeup with any other wakeup
-			that may have happened for other reasons, or at the
-			worst case, fire an interrupt for your upper bound.
-
-			The larger a range you supply, the greater a chance
-			that you will not trigger an interrupt; this should
-			be balanced with what is an acceptable upper bound on
-			delay / performance for your specific code path. Exact
-			tolerances here are very situation specific, thus it
-			is left to the caller to determine a reasonable range.
-
-	SLEEPING FOR LARGER MSECS ( 10ms+ )
-		* Use msleep or possibly msleep_interruptible
-
-		- What's the difference?
-			msleep sets the current task to TASK_UNINTERRUPTIBLE
-			whereas msleep_interruptible sets the current task to
-			TASK_INTERRUPTIBLE before scheduling the sleep. In
-			short, the difference is whether the sleep can be ended
-			early by a signal. In general, just use msleep unless
-			you know you have a need for the interruptible variant.
-
-	FLEXIBLE SLEEPING (any delay, uninterruptible)
-		* Use fsleep

-- 
2.39.2


