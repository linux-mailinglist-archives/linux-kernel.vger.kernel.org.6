Return-Path: <linux-kernel+bounces-363488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AAD899C30E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 10:25:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3C2F28152F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 08:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A44415DBBA;
	Mon, 14 Oct 2024 08:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4Kt4he8d";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ySQYkIKs"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91156156F3A;
	Mon, 14 Oct 2024 08:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728894172; cv=none; b=vDiKeklEO18SV0xUmptUcrs99XtHEOek5D+yJvawIIkzJXPHPRPq7sH0J0ZXef3uvfoFzr9uD2jsjn9cCLj6JozY2Mffz347rHrGGwfAEg2wNArmBJP5o9mS6XDSLvWN8oLGF2m68xX/0L91X5e8bC+8ul2qdI+s2HWe2CgpA8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728894172; c=relaxed/simple;
	bh=jHyF4EaZ4omIC4dMBvbcJ73DQBrzr5Z0mWrxwDrWTX0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MkfEfbcUJc9/yc3XEjECiD3QxmnQi4Ezxu1fDqX+bxLy4+GrZRDuINVlm6N++IrL2A9AYpzD+KDEOP+hYiYXj3D8GjJ5vWxDCMfZl8B4pHLExLUEcvEKHKWdOKcKvUEpKn6Umv2rgzU+g3E0Vxy1svUT1m6iF72ay5QgPj6SDAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4Kt4he8d; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ySQYkIKs; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728894168;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MqgLhEru8vtEo9KRnMpNBZU7wGZ0I2RuJBCZU/XIuwo=;
	b=4Kt4he8dGZ3L9A4R5fKglEtxUcrpLCjgqkeIU9jaDlvUh+xSdhbYVQ90saTdN09bpcQgHW
	OrlYox5+3vuFmWBb2c6f2vvCakk62huVtddDNEVGdWLGk1sgSQjiK9B6QIsU07VHq6E3MM
	0XyjlZcijXZC1n75TkkyrfWNKh3yZyQ+b6yE/PTWTH2/6BTHWzmyVLzojFiM+QqYBcIZDW
	KOwU+t4h681dJt1RF2ug0d4mSQoDNT2LTp6H9GVRB08167QrCLsOeRT/7rH/wc3DHsfIL8
	KxImzn9fMwyZSzVvgXNyLEYJDXbl9n3dzrq/azhrUnFsm8XMEZH9qQ3uQB7tFA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728894168;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MqgLhEru8vtEo9KRnMpNBZU7wGZ0I2RuJBCZU/XIuwo=;
	b=ySQYkIKsdlyi2RIofAwYHs7Bq0+z9JQmSHj/YhRkRoy0EMMGrHInsmhg0QZHLEBExvv6al
	cGr9xt4OGQ5XRSAA==
Date: Mon, 14 Oct 2024 10:22:28 +0200
Subject: [PATCH v3 11/16] regulator: core: Use fsleep() to get best sleep
 mechanism
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241014-devel-anna-maria-b4-timers-flseep-v3-11-dc8b907cb62f@linutronix.de>
References: <20241014-devel-anna-maria-b4-timers-flseep-v3-0-dc8b907cb62f@linutronix.de>
In-Reply-To: <20241014-devel-anna-maria-b4-timers-flseep-v3-0-dc8b907cb62f@linutronix.de>
To: Frederic Weisbecker <frederic@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, rust-for-linux@vger.kernel.org, 
 Alice Ryhl <aliceryhl@google.com>, 
 FUJITA Tomonori <fujita.tomonori@gmail.com>, Andrew Lunn <andrew@lunn.ch>, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>, 
 Miguel Ojeda <ojeda@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>

_regulator_delay_helper() implements the recommondation of the outdated
documentation which sleep mechanism should be used. There is already a
function in place which does everything and also maps to reality called
fsleep().

Use fsleep() directly.

Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
---
v2: Use fsleep() directly
---
 drivers/regulator/core.c | 47 ++++-------------------------------------------
 1 file changed, 4 insertions(+), 43 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 1179766811f5..2605f6e76ea4 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -2642,45 +2642,6 @@ static int regulator_ena_gpio_ctrl(struct regulator_dev *rdev, bool enable)
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
  * _regulator_check_status_enabled - check if regulator status can be
  *				     interpreted as "regulator is enabled"
@@ -2733,7 +2694,7 @@ static int _regulator_do_enable(struct regulator_dev *rdev)
 		s64 remaining = ktime_us_delta(end, ktime_get_boottime());
 
 		if (remaining > 0)
-			_regulator_delay_helper(remaining);
+			fsleep(remaining);
 	}
 
 	if (rdev->ena_pin) {
@@ -2767,7 +2728,7 @@ static int _regulator_do_enable(struct regulator_dev *rdev)
 		int time_remaining = delay;
 
 		while (time_remaining > 0) {
-			_regulator_delay_helper(rdev->desc->poll_enabled_time);
+			fsleep(rdev->desc->poll_enabled_time);
 
 			if (rdev->desc->ops->get_status) {
 				ret = _regulator_check_status_enabled(rdev);
@@ -2786,7 +2747,7 @@ static int _regulator_do_enable(struct regulator_dev *rdev)
 			return -ETIMEDOUT;
 		}
 	} else {
-		_regulator_delay_helper(delay);
+		fsleep(delay);
 	}
 
 	trace_regulator_enable_complete(rdev_get_name(rdev));
@@ -3730,7 +3691,7 @@ static int _regulator_do_set_voltage(struct regulator_dev *rdev,
 	}
 
 	/* Insert any necessary delays */
-	_regulator_delay_helper(delay);
+	fsleep(delay);
 
 	if (best_val >= 0) {
 		unsigned long data = best_val;

-- 
2.39.5


