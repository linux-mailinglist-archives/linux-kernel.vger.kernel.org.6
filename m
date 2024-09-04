Return-Path: <linux-kernel+bounces-315092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5842996BDE1
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 15:09:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 151F2282A93
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 13:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3901D1DFE09;
	Wed,  4 Sep 2024 13:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZnF669/c";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jePl3NGH"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D797B1DCB15
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 13:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725455141; cv=none; b=elwRLXwgSvjSELZ41caGJHUEIdSC/vWejkPBbcTTfD6psh2Yd8ot8mRAubqah/yeZWwW5zdO4e39GV7fWxgzbiistX1KW5jsAYn140H3UvOPWnuZQIY9jNqOd3iCGS37dN7ldtc4JhEntRAWUv3Sq2X+UXJGH93vTWCS5QdCQ2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725455141; c=relaxed/simple;
	bh=K0E05+A2SNEqI/Ye/Bk6h3XXJnoT8Rxi+IG0Ye2aWTQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HaVSMWDM6/UkDpLYAKACbsCENXTxmEPu7XerbukjdaskyrVlYkH7EJU9FJw9Oz6Kn7WARAJ6lTrwO7ZdFRQ/IK+a4os+skIBWrLgYefRhdBw57U87fIXGP8LsFKXpQbXTSIfUU8slubBWbH+3/AgFpEVHDfp4HjDDUEN8EhwO3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZnF669/c; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jePl3NGH; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725455138;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aApgCIlZz9jOhCumewDeDaW+t/dUKkzZt/+qsZgyD3A=;
	b=ZnF669/ctay0aFqM0brRNubYaI85tzRZGJQtu9C2TpH0ZlmeNX2gGgypczjUuRanXD0aiP
	eiMf0kK3GUdMbG8x3KqxMcQJbiAH7OiSke0Z+PEGYtEcZzXxrbxHUe+euHSdPrlh5slrbg
	/lwBR4ni9UiFMNfdCaf7n6sLyIUMR4Q/Zl7cUo2/F+06YyNTfQq561Kcmq5XUD993J2ps2
	LPoIl9OX2MhH/ZFxDC3EPO9RTsifMbTp0z5hwIoHinLtq6MaoKn3HrNauLzWyawLAaDmc9
	rHK1+V5n7wlyMaHTxBSC39CW81j12r5/0rW5T0F+YS4+OHxfosTH9NKO/cXFJQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725455138;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aApgCIlZz9jOhCumewDeDaW+t/dUKkzZt/+qsZgyD3A=;
	b=jePl3NGHbBDlFRmMVCMzgtXc3o3ilipvEHPrRIWLdwA1QgMQrkaGfUI+l+ihlSzIYrwath
	BcrEZCP8ntWSWnAQ==
Date: Wed, 04 Sep 2024 15:05:01 +0200
Subject: [PATCH 11/15] regulator: core: Use fsleep() to get best sleep
 mechanism
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240904-devel-anna-maria-b4-timers-flseep-v1-11-e98760256370@linutronix.de>
References: <20240904-devel-anna-maria-b4-timers-flseep-v1-0-e98760256370@linutronix.de>
In-Reply-To: <20240904-devel-anna-maria-b4-timers-flseep-v1-0-e98760256370@linutronix.de>
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

Use fsleep() to choose the best mechanism.

Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
---
 drivers/regulator/core.c | 33 ++++-----------------------------
 1 file changed, 4 insertions(+), 29 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 7674b7f2df14..155c3e3ab3f1 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -2671,39 +2671,14 @@ static int regulator_ena_gpio_ctrl(struct regulator_dev *rdev, bool enable)
  * _regulator_delay_helper - a delay helper function
  * @delay: time to delay in microseconds
  *
- * Delay for the requested amount of time as per the guidelines in:
+ * For details please refere to fsleep() function description.
  *
- *     Documentation/timers/timers-howto.rst
- *
- * The assumption here is that these regulator operations will never used in
+ * The assumption here is that these regulator operations are never used in
  * atomic context and therefore sleeping functions can be used.
  */
-static void _regulator_delay_helper(unsigned int delay)
+static inline void _regulator_delay_helper(unsigned int delay)
 {
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
+	fsleep(delay);
 }
 
 /**

-- 
2.39.2


