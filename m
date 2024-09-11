Return-Path: <linux-kernel+bounces-324218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14B6B974999
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 07:15:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8964A1F21C2F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 05:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF5BA143C77;
	Wed, 11 Sep 2024 05:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="L9fLRPya";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AFD16mbE"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED8C135A69
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 05:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726031638; cv=none; b=VJeJ4pYWof9Ay7XXbwx+XVIY5IeIJ6pE3D6+HeWKVsHsrvaBNW3iQMNd6a1Nf3SNQlqV12wjbmJyhGhcsvMFW5lnJ2LJjCGjGG/FVOOj4phlCrUkuDqesUidQOaAPJzNpzpHyGbM+gBwIhfPVVRzLX4pq3DKUPJupacWehlEABo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726031638; c=relaxed/simple;
	bh=Iu3t2ZvhGZM9V5B2n78D4EKuKhs3LJgqXVMR5djIgTU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DLKyvoBUtnKeMGZc55NB3hn9iRu8fIKsMqHnBdp3oghpshidygpsS3KhlScwuiMjKcltlu019p6bVKZwXSnD/00fJL9c/GgZSNGDQyDNwO514DZgF+Qlqn372qulSSfpXvoheAJ0v/Ak7AO9r493An4abHT1ftZKLQzO5BquUUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=L9fLRPya; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AFD16mbE; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1726031634;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bSVvJgxFrZ1dz8pJPoMJBQ5YpWwDGPyuOlPl0CM7qhs=;
	b=L9fLRPyaXs4/x11oQ+mv1tmuOekPYxDufkhOvTYTdVprrcsTR/HOEctVjtODtRKclyI4Cc
	BR79NdLGf61GxhVyLZoehzvKI19AFKh5AHGQIuqdz2ZZpC9KaYFYdZSNFbsJlZdoL2wF/5
	Idw2crkmxEx51JS9pCMojsHC7mOPjSNLXaPWlCy3BrSLewewmMic6gJaFkM05QBKWObZoD
	foHL7m7hrBVGm1AzxZdEW+LnMsOKo1HxngIlMWIbtYyElni8HQF2M0QW7avj8P6XtBdBHN
	C4uxUokYv2zcxAuuDHajl7s2vD2G51PwrZzcB2+EMZSHRoYRHE3iov1ky+u6TA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1726031634;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bSVvJgxFrZ1dz8pJPoMJBQ5YpWwDGPyuOlPl0CM7qhs=;
	b=AFD16mbEdPZnlXKye/ZCjg6YOji25EPUgGJdTP2f7huIwQmc7HO+i23XRQFOEwEWFmoR64
	d1ft4kewo31+fqAw==
Date: Wed, 11 Sep 2024 07:13:37 +0200
Subject: [PATCH v2 11/15] regulator: core: Use fsleep() to get best sleep
 mechanism
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240911-devel-anna-maria-b4-timers-flseep-v2-11-b0d3f33ccfe0@linutronix.de>
References: <20240911-devel-anna-maria-b4-timers-flseep-v2-0-b0d3f33ccfe0@linutronix.de>
In-Reply-To: <20240911-devel-anna-maria-b4-timers-flseep-v2-0-b0d3f33ccfe0@linutronix.de>
To: Frederic Weisbecker <frederic@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>

_regulator_delay_helper() implements the recommondation of the outdated
documentation which sleep mechanism should be used. There is already a
function in place which does everything and also maps to reality called
fsleep().

Use fsleep() directly.

Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
---
v2: Use fsleep() directly
---
 drivers/regulator/core.c | 47 ++++-------------------------------------------
 1 file changed, 4 insertions(+), 43 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 7674b7f2df14..5d4cfb14fada 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -2667,45 +2667,6 @@ static int regulator_ena_gpio_ctrl(struct regulator_dev *rdev, bool enable)
 	return 0;
 }
 
-/**
- * _regulator_delay_helper - a delay helper function
- * @delay: time to delay in microseconds
- *
- * Delay for the requested amount of time as per the guidelines in:
- *
- *     Documentation/timers/timers-howto.rst
- *
- * The assumption here is that these regulator operations will never used in
- * atomic context and therefore sleeping functions can be used.
- */
-static void _regulator_delay_helper(unsigned int delay)
-{
-	unsigned int ms = delay / 1000;
-	unsigned int us = delay % 1000;
-
-	if (ms > 0) {
-		/*
-		 * For small enough values, handle super-millisecond
-		 * delays in the usleep_range() call below.
-		 */
-		if (ms < 20)
-			us += ms * 1000;
-		else
-			msleep(ms);
-	}
-
-	/*
-	 * Give the scheduler some room to coalesce with any other
-	 * wakeup sources. For delays shorter than 10 us, don't even
-	 * bother setting up high-resolution timers and just busy-
-	 * loop.
-	 */
-	if (us >= 10)
-		usleep_range(us, us + 100);
-	else
-		udelay(us);
-}
-
 /**
  * _regulator_check_status_enabled
  *
@@ -2760,7 +2721,7 @@ static int _regulator_do_enable(struct regulator_dev *rdev)
 		s64 remaining = ktime_us_delta(end, ktime_get_boottime());
 
 		if (remaining > 0)
-			_regulator_delay_helper(remaining);
+			fsleep(remaining);
 	}
 
 	if (rdev->ena_pin) {
@@ -2794,7 +2755,7 @@ static int _regulator_do_enable(struct regulator_dev *rdev)
 		int time_remaining = delay;
 
 		while (time_remaining > 0) {
-			_regulator_delay_helper(rdev->desc->poll_enabled_time);
+			fsleep(rdev->desc->poll_enabled_time);
 
 			if (rdev->desc->ops->get_status) {
 				ret = _regulator_check_status_enabled(rdev);
@@ -2813,7 +2774,7 @@ static int _regulator_do_enable(struct regulator_dev *rdev)
 			return -ETIMEDOUT;
 		}
 	} else {
-		_regulator_delay_helper(delay);
+		fsleep(delay);
 	}
 
 	trace_regulator_enable_complete(rdev_get_name(rdev));
@@ -3741,7 +3702,7 @@ static int _regulator_do_set_voltage(struct regulator_dev *rdev,
 	}
 
 	/* Insert any necessary delays */
-	_regulator_delay_helper(delay);
+	fsleep(delay);
 
 	if (best_val >= 0) {
 		unsigned long data = best_val;

-- 
2.39.2


