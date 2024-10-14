Return-Path: <linux-kernel+bounces-363491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB5B999C312
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 10:26:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA3FF2846AF
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 08:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B581B18D63E;
	Mon, 14 Oct 2024 08:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SJBhmkIk";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UZnZqTXT"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0627C1581F9;
	Mon, 14 Oct 2024 08:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728894174; cv=none; b=FfjzW1pYpCOTaA33pFE7aqB5jLjG1O8v9VdS5SEtA60i+oX/n9aXacAw5Cn7MM7VuQB3gto5gd4Wm69xPmW3rQFds//SSfrKvd7DCK0Nvuia3Vwdn81/tpSFlWem0fgbr+zrmii+N0fCzzsjWejfby9KOoeN3IpDKgfMtc3NuC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728894174; c=relaxed/simple;
	bh=ZXAYrVZ4w20Nfm7iIvoXhExNTha7O9fJ6fEz0B1hJfQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MitYa0JS6MumHYWV9H2sqoxfSHH0izvtjf0gxKTEzC074AHcWu5SmaCa2CEx/nx1ZZEpeZD3b4dYGCowsy22gIhl4QGZ64p16RdM4jUciMmlu7+/Eaa9eFPxgIX1sS/Ul7YYp/hi49ZwG7i6/tz5th9Gl+PN7kHSCQ7fr2Vh8Fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SJBhmkIk; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UZnZqTXT; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728894170;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=36D4JZFbM4MmKnsf1c64M6HZW4amllGvs/Baa5CaIKo=;
	b=SJBhmkIkHOu9CWK84IdUtmfqb+EdcoM2IoKcNz1jyFoI0+DppRMZmjZy4GSlgpy1jZix5s
	bW11otpF04yvCaL4IhOBRPbXs2EP7/G3CP18CfkOraXBwPxDObOvTV/Mwn3T7tQFplIr21
	xj8/sXF0vFc5P3fPcWXraBnT4G0BuvNzJIcJcUdEEt7uBtC+5C7V0nNWq1BFPprMWzL6Yn
	r99SICyALPZYgEgjxum3BOvUMKnnUJ0uzfkucZPGqScNJCjRUQciPnxCON0htd2l7e7Sgp
	2teSTDzN8aIX1UDrGFVtVpYvrasZxi1boXEWEs6qZQMOjNT0kWmVRMnrxIv4Zw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728894170;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=36D4JZFbM4MmKnsf1c64M6HZW4amllGvs/Baa5CaIKo=;
	b=UZnZqTXT3WVKOuG/92s9qNBLKwnCHO1yiDqhQLp94tHUO7lz4/Th4EtYx/qOfo2ipv1njQ
	mIUUzeyC/iPVSSAQ==
Date: Mon, 14 Oct 2024 10:22:32 +0200
Subject: [PATCH v3 15/16] timers/Documentation: Cleanup delay/sleep
 documentation
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241014-devel-anna-maria-b4-timers-flseep-v3-15-dc8b907cb62f@linutronix.de>
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

The documentation which tries to give advices how to properly inserting
delays or sleeps is outdated. The file name is 'timers-howto.rst' which
might be misleading as it is only about delay and sleep mechanisms and not
how to use timers.

Update the documentation by integrating the important parts from the
related function descriptions and move it all into a self explaining file
with the name "delay_sleep_functions.rst".

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
---
 Documentation/timers/delay_sleep_functions.rst | 121 +++++++++++++++++++++++++
 Documentation/timers/index.rst                 |   2 +-
 Documentation/timers/timers-howto.rst          | 115 -----------------------
 3 files changed, 122 insertions(+), 116 deletions(-)

diff --git a/Documentation/timers/delay_sleep_functions.rst b/Documentation/timers/delay_sleep_functions.rst
new file mode 100644
index 000000000000..49d603a3f113
--- /dev/null
+++ b/Documentation/timers/delay_sleep_functions.rst
@@ -0,0 +1,121 @@
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
+These functions use hrtimers or timer list timers to provide the requested
+sleeping duration. In order to decide which function is the right one to use,
+take some basic information into account:
+
+#. hrtimers are more expensive as they are using an rb-tree (instead of hashing)
+#. hrtimers are more expensive when the requested sleeping duration is the first
+   timer which means real hardware has to be programmed
+#. timer list timers always provide some sort of slack as they are jiffy based
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
2.39.5


