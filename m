Return-Path: <linux-kernel+bounces-315089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8577D96BDDB
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 15:08:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39BE81F26B4B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 13:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21E711DCB25;
	Wed,  4 Sep 2024 13:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nE7oMldu";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JVYH5NQQ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE7681DC190
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 13:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725455139; cv=none; b=dZ8hCtcOLQZBF6/pvLjbTG0r7NKx7AazAtXotikB+XsCoZ+S2e7oQSsCKBN1ea6+FXT+uzNKisJvOUW91q+JVIM2k/MB7B2TLmB6cLAtfihff+3yM+qvmia5QvsagJ4OJ0wMtHMo/Ywjmz1OWP7TMzgqoSJAZ0yBzTx4qMc3vKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725455139; c=relaxed/simple;
	bh=9O92jwveh5iVzWgN1l3Cbbq7pWWFYLxcl+f0fnqDjoU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iqyKIX+TWggQoCyUrAIDYqa/eA+LVcd0bfQkZa6DuGlLeF3EN2N7/k2M61pD0C6iKtHCEJvPcLHViuvpkr+7rWhqIxyltT7kq8ldx1UERcAeM+EvgT6d8EvpoOBT6ePtExLOFWb+ET5UfpOF5l+LA4bpL/Y+IdYUL2tHAW5kcCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nE7oMldu; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JVYH5NQQ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725455136;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rtNvbsuelbk0+4PJUSwQ16v3Vz38xbL3/UvjLhGlwIk=;
	b=nE7oMldu2nWfetQ+sxMrs/59NURPzMfcqI3TaZ7BL7TGcn1MzXkvp3kTGSYEkf3siHecZV
	cf43vfqI50vDV/+IWPmgXM6/1Ltpv3826dY2v06JY1bYmnV1ljagxhUaItdPsDZFZJzlQc
	QZ3ri72YT0SMEPnvzfQEM/gGLGZBwvFWhGTpOCMjTQBVEPeEdBTKtATs7/c/bWs3ZFltaS
	vdWZlR6EMkkksHLeGBu1xMiYQQpeWdT86s55dmundWoar6z9Uj4ojDZKNDjmJiBGoKB/xn
	W96AK58tL7f3xkqd6DQZxXtFK/e1NdsdDK5Ymy+dZZ5UCC1tYePYjdPRxQTXYw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725455136;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rtNvbsuelbk0+4PJUSwQ16v3Vz38xbL3/UvjLhGlwIk=;
	b=JVYH5NQQLMH5sMCQbT+2vpj1ZKtkXWgS5nGPCOxg/Qua+HONrSXt1Q4ONon4fpKmK1kuRX
	HSgSgbVT/mSS56CQ==
Date: Wed, 04 Sep 2024 15:04:58 +0200
Subject: [PATCH 08/15] mm/damon/core: Use generic upper bound
 recommondation for usleep_range()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240904-devel-anna-maria-b4-timers-flseep-v1-8-e98760256370@linutronix.de>
References: <20240904-devel-anna-maria-b4-timers-flseep-v1-0-e98760256370@linutronix.de>
In-Reply-To: <20240904-devel-anna-maria-b4-timers-flseep-v1-0-e98760256370@linutronix.de>
To: Frederic Weisbecker <frederic@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>, 
 SeongJae Park <sj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
 damon@lists.linux.dev, linux-mm@kvack.org

The upper bound for usleep_range_idle() was taken from the outdated
documentation. As a recommondation for the upper bound of usleep_range()
depends on HZ configuration it is not possible to hard code it.

Use the define "USLEEP_RANGE_UPPER_BOUND" instead.

Cc: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: damon@lists.linux.dev
Cc: linux-mm@kvack.org
Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
---
 mm/damon/core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 94fe2f1f9b0e..4b971871da75 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1883,8 +1883,7 @@ static unsigned long damos_wmark_wait_us(struct damos *scheme)
 
 static void kdamond_usleep(unsigned long usecs)
 {
-	/* See Documentation/timers/timers-howto.rst for the thresholds */
-	if (usecs > 20 * USEC_PER_MSEC)
+	if (usecs >= USLEEP_RANGE_UPPER_BOUND)
 		schedule_timeout_idle(usecs_to_jiffies(usecs));
 	else
 		usleep_range_idle(usecs, usecs + 1);

-- 
2.39.2


