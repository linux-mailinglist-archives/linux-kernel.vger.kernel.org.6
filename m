Return-Path: <linux-kernel+bounces-315095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1049B96BDE4
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 15:10:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC84F28164E
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 13:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA2961E00AB;
	Wed,  4 Sep 2024 13:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="z4P3q5Oy";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eF3O2ZUl"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E88E1DEFDD
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 13:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725455143; cv=none; b=ZjC5w01JdBsJmMDByf9t6Jhm7Psy27pHzXHpinf3NjUp02yiEPRvxWJZneh3AMt3ex0GZmvRX3Kq+vrSE/9W+ZjMrs0yH2UDHnnDLlX9580SZ+nA9pNxkiwjVR8Xgo6cxL+uVxDttu6a34+2PuPqsvjB6Z+dzb/5B9CD2S9lUgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725455143; c=relaxed/simple;
	bh=8qQChXqfhyyyzG47FL8wei2jgAz4j1vTLzxX5e0laqM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JZYGPd2fH+VCFLXhWi2YulDTVj2m9hphhH7VsACxI4FyXm/oJCKTmDHRJnSkX0LHcxaH3d28gErN1RfP0RpqADimWYcfLV/zBMxnPFYg0TgCFFkwsgiQU5YMKl/uNX4xrBSXCzqFJlo4rH8TcWtWFYwy+Sj+IV6o51jVqQbXE6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=z4P3q5Oy; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eF3O2ZUl; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725455139;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w1hgFVgMLZ521/p+E0dyRVQl2rbyAAPZ0ir+q/NjJSQ=;
	b=z4P3q5OyzPM2OPXYhZTZDs8f4jcuLXx0cBv0nAd6tj54uuDk226NFzqzGYYv+cEf0yNFBv
	2yhEQ5zKBeqeI5WD6+FlldipAPRUQP1Tmuov+v3qNMInz2MxJ459rZB+gmeNHDywYlsJT8
	9XV+cy/iLbLzw/cls81OoMpxQog7EZK0iwd9G8h7Rm38JJwMa028TjJbIpOStnZg1QEDjo
	UzOoayLQcd8JfBUUPQNFdeFMgkjaiE1ibKLtRbUxKtDvMJIKv1HXyldBidorvuDun5piZd
	DFE0s/9jqzZQqXHkluJ2HLAgz3rW0R519TeZ1t6lFHKo9US3BOcDTNRKRtaWpw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725455139;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w1hgFVgMLZ521/p+E0dyRVQl2rbyAAPZ0ir+q/NjJSQ=;
	b=eF3O2ZUlBaIyY4KkXmRltcDq2SpPujm++XqPS46DXxIeh832EzE2Ujm17IhwcLC8u0Sq7Q
	4OVnhvqKgszJr8Aw==
Date: Wed, 04 Sep 2024 15:05:03 +0200
Subject: [PATCH 13/15] powerpc/rtas: Use fsleep() to minimize additional
 sleep duration
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240904-devel-anna-maria-b4-timers-flseep-v1-13-e98760256370@linutronix.de>
References: <20240904-devel-anna-maria-b4-timers-flseep-v1-0-e98760256370@linutronix.de>
In-Reply-To: <20240904-devel-anna-maria-b4-timers-flseep-v1-0-e98760256370@linutronix.de>
To: Frederic Weisbecker <frederic@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nathan Lynch <nathanl@linux.ibm.com>, 
 linuxppc-dev@lists.ozlabs.org

When commit 38f7b7067dae ("powerpc/rtas: rtas_busy_delay() improvements")
was introduced, documentation about proper usage of sleep realted functions
was outdated.

The commit message references the usage of a HZ=100 system. When using a
20ms sleep duration on such a system and therefore using msleep(), the
possible additional slack will be +10ms.

When the system is configured with HZ=100 the granularity of a jiffy and of
a bucket of the lowest timer wheel level is 10ms. To make sure a timer will
not expire early (when queueing of the timer races with an concurrent
update of jiffies), timers are always queued into the next bucket. This is
the reason for the maximal possible slack of 10ms.

fsleep() limits the maximal possible slack to 25% by making threshold
between usleep_range() and msleep() HZ dependent. As soon as the accuracy
of msleep() is sufficient, the less expensive timer list timer based
sleeping function is used instead of the more expensive hrtimer based
usleep_range() function. The udelay() will not be used in this specific
usecase as the lowest sleep length is larger than 1 microsecond.

Use fsleep() directly instead of using an own heuristic for the best
sleeping mechanism to use..

Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nathan Lynch <nathanl@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
---
 arch/powerpc/kernel/rtas.c | 21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/arch/powerpc/kernel/rtas.c b/arch/powerpc/kernel/rtas.c
index f7e86e09c49f..0794ca28e51e 100644
--- a/arch/powerpc/kernel/rtas.c
+++ b/arch/powerpc/kernel/rtas.c
@@ -1390,21 +1390,14 @@ bool __ref rtas_busy_delay(int status)
 		 */
 		ms = clamp(ms, 1U, 1000U);
 		/*
-		 * The delay hint is an order-of-magnitude suggestion, not
-		 * a minimum. It is fine, possibly even advantageous, for
-		 * us to pause for less time than hinted. For small values,
-		 * use usleep_range() to ensure we don't sleep much longer
-		 * than actually needed.
-		 *
-		 * See Documentation/timers/timers-howto.rst for
-		 * explanation of the threshold used here. In effect we use
-		 * usleep_range() for 9900 and 9901, msleep() for
-		 * 9902-9905.
+		 * The delay hint is an order-of-magnitude suggestion, not a
+		 * minimum. It is fine, possibly even advantageous, for us to
+		 * pause for less time than hinted. To make sure pause time will
+		 * not be a way longer than requested independent of HZ
+		 * configuration, use fsleep(). See fsleep() for detailes of
+		 * used sleeping functions.
 		 */
-		if (ms <= 20)
-			usleep_range(ms * 100, ms * 1000);
-		else
-			msleep(ms);
+		fsleep(ms * 1000);
 		break;
 	case RTAS_BUSY:
 		ret = true;

-- 
2.39.2


