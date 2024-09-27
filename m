Return-Path: <linux-kernel+bounces-341501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9F509880D9
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 10:54:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A40C282292
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 08:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4DB31B3B3F;
	Fri, 27 Sep 2024 08:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Dcbf3IrY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ww8EUDxS"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B8CB1B3B13
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 08:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727426954; cv=none; b=Dc8aFqH9ySwWVWodqDlLJ5g5mo8rZAbGKN5WihvVcwb7GRFeyjbukwwajAW1vDfK3AWx9SefFGJTkDLt2oDrd+qat+RTqnT47h2lDhZVR44CgKPjE8kzq2FSgFvH0uEmEMpfUgGbX00j4G36czRHiIFev0DPhEQeR6P3e422QQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727426954; c=relaxed/simple;
	bh=7e4v9WkDJuPdohdeoK6mQPaWH99Nff2q7xm62vNvfEU=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=tih/1a/epeXwKkh5aSzQZT5SoRnH6+dhAvkxku5f8/zflmDWRGxiz7Uew+oIIbtlAdDpy0s2pLuAoRXEOT6WTIIZs6Ap1TITAp7LPoP6oX615W59jyTh/Q+XG3pFbLcDLS8zGDPVLqy97lUi6J/B5Nas+L7U8OPma5Eu0hvLl9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Dcbf3IrY; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ww8EUDxS; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240927084818.487794783@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1727426951;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=9D2jiH+/RxRu1E5rzqzRvNNr94gJCBzotdwDIvHO6+s=;
	b=Dcbf3IrYC3MQrC1pVYHVCFkv3AcLHTTiDrPbH0lnukmDCysphwCHaIXTygFN0yg0j36yvL
	K5MTQ4MIcSqBT9buXjoXXS1g+Y9I8AbN53B3GC1g96PfFQYkd5FhPM7zcNXT2sXmIc81g0
	j2WOwCs/OKHOXkdT/d5kID+Yr/o/P3oiJtQ806FeHnn/yUPlLhJaMf3hn3OmebthWDwsIn
	hQRft/AesayizraYXO6eDja7cQ1wMHUfOCo2jTwY0Gm2hwJflrYr+erIOCmmsnJsi2hyp1
	BsmKSnLp5H4UkLEXInUMiOOXKFprOYR98iTw40t9ine5QPe08tlKEbRL2h2Ktw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1727426951;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=9D2jiH+/RxRu1E5rzqzRvNNr94gJCBzotdwDIvHO6+s=;
	b=ww8EUDxSCTh96dsupDOpf5BN55ZMfpvmKideT3lhdgZuy3FF7Z9zSVXg8sYRq5Foi0vWR5
	CaR/tcNSuG2LFDCw==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>,
 John Stultz <jstultz@google.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>,
 Stephen Boyd <sboyd@kernel.org>,
 Eric Biederman <ebiederm@xmission.com>,
 Oleg Nesterov <oleg@redhat.com>
Subject: [patch v4 26/27] alarmtimers: Remove the throttle mechanism from
 alarm_forward_now()
References: <20240927083900.989915582@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Fri, 27 Sep 2024 10:49:11 +0200 (CEST)

From: Thomas Gleixner <tglx@linutronix.de>

Now that ignored posix timer signals are requeued and the timers are
rearmed on signal delivery the workaround to keep such timers alive and
self rearm them is not longer required.

Remove the unused alarm timer parts.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

---
 kernel/time/alarmtimer.c |   28 ++--------------------------
 1 file changed, 2 insertions(+), 26 deletions(-)
---
--- a/kernel/time/alarmtimer.c
+++ b/kernel/time/alarmtimer.c
@@ -467,35 +467,11 @@ u64 alarm_forward(struct alarm *alarm, k
 }
 EXPORT_SYMBOL_GPL(alarm_forward);
 
-static u64 __alarm_forward_now(struct alarm *alarm, ktime_t interval, bool throttle)
+u64 alarm_forward_now(struct alarm *alarm, ktime_t interval)
 {
 	struct alarm_base *base = &alarm_bases[alarm->type];
-	ktime_t now = base->get_ktime();
-
-	if (IS_ENABLED(CONFIG_HIGH_RES_TIMERS) && throttle) {
-		/*
-		 * Same issue as with posix_timer_fn(). Timers which are
-		 * periodic but the signal is ignored can starve the system
-		 * with a very small interval. The real fix which was
-		 * promised in the context of posix_timer_fn() never
-		 * materialized, but someone should really work on it.
-		 *
-		 * To prevent DOS fake @now to be 1 jiffy out which keeps
-		 * the overrun accounting correct but creates an
-		 * inconsistency vs. timer_gettime(2).
-		 */
-		ktime_t kj = NSEC_PER_SEC / HZ;
 
-		if (interval < kj)
-			now = ktime_add(now, kj);
-	}
-
-	return alarm_forward(alarm, now, interval);
-}
-
-u64 alarm_forward_now(struct alarm *alarm, ktime_t interval)
-{
-	return __alarm_forward_now(alarm, interval, false);
+	return alarm_forward(alarm, base->get_ktime(), interval);
 }
 EXPORT_SYMBOL_GPL(alarm_forward_now);
 


