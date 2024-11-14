Return-Path: <linux-kernel+bounces-409048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 921029C86CE
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 11:03:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 491971F26CE0
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 10:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6EDC1F77A9;
	Thu, 14 Nov 2024 10:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mXI67Sho";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sqcCOslb"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A70B11F81B0
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 10:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731578492; cv=none; b=uF4d3Vt+Fah7jjjsmhbyoxMSNC8WL9wRuFm/qgr5dL2RUsucmqjubNHMvJP8iNgJzX5GKPsuC7z91v/ac0Jh9dKIHdHrO4XFRDwUmZMQHo/87wyL4EGky+eTCqKB4Z5AyeLxqQ10TJZC7A/1eVI3DMJyw9FaLgxX6HUXl402hRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731578492; c=relaxed/simple;
	bh=dhHJl6av9cDkkRH5ZC+F2c2WiggTpCp+fQWsNBDcti0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aRLM3HwJeUqrm93C+UeAD3HnG9WlJehsGr05Z8B0mlGolHPhq7Kwt+NVzk06QUiSkaNZMuFRsYoXgDHnOu0KKwo8MuxAAsCphmk1FP+ruTFHDG/PfBkC9aBbDWD8jiBcKYz7ni+PF2c0twkcTYF/AKJrrlzlhiqZQKCg9zBUlvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mXI67Sho; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sqcCOslb; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 14 Nov 2024 11:01:27 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1731578488;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=L46kT3JQkvuohkZS6z3cLdv4x6ovgH4uNYpQUsVBLl4=;
	b=mXI67Sho52iSfUJeK/vzfUORX8Pfpnm/eLuxL4nk7tS5HGjYpS/F3gklccbuEXSSKJU1wd
	wk1K5oSnPqKF7Q207XO63mxOWhaNrf4NmrTaUYytpsMo5Ib4Cv5mJasDrJvbVKfjy7FSdH
	lHMw4C9UjfniRr77o08He36Upl8t4hv2IgTjvb/dw89LrY9Npc65dE2HTAMfGCUdkcuE1v
	fHulLlqIOmK5JjrQ3x3zIjQFOs4246Gvi7YWs/BiWD84u3E9T6COucT/JtEOGdK4KJQ8xy
	vrKYukYf0zbbnlO7vG46k20MKsoCJEp+NzhJj0Goks3KQbUFmQrLuJ17bFfWoQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1731578488;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=L46kT3JQkvuohkZS6z3cLdv4x6ovgH4uNYpQUsVBLl4=;
	b=sqcCOslbrtwOWRZEU3dkdaZzYLcPPiUGuR1jUDmxREDBb7iTjYaIPBCCQuzsEsVFxf7msG
	ZPw+5Gf3P19PgyCg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Ankur Arora <ankur.a.arora@oracle.com>
Cc: linux-kernel@vger.kernel.org, peterz@infradead.org, tglx@linutronix.de,
	paulmck@kernel.org, mingo@kernel.org, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, frederic@kernel.org, efault@gmx.de,
	sshegde@linux.ibm.com, boris.ostrovsky@oracle.com
Subject: Re: [PATCH v2 0/6] RCU changes for PREEMPT_LAZY
Message-ID: <20241114100127.9xLSy4yq@linutronix.de>
References: <20241106201758.428310-1-ankur.a.arora@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241106201758.428310-1-ankur.a.arora@oracle.com>

On 2024-11-06 12:17:52 [-0800], Ankur Arora wrote:
> This series adds RCU and some leftover scheduler bits for lazy
> preemption.

This is not critical for the current implementation. The way I
understand is that you make a change in 3/6 and then all other patches
in this series are required to deal with this.

For bisect reasons it would make sense to have 3/6 last in the series
and to the "fixes" first before the code is enabled. I mean if you apply
3/6 first then you get build failures without 1/6. But with 3/6 before
5/6 you should get runtime errors, right?

> The main problem addressed in the RCU related patches is that before
> PREEMPT_LAZY, PREEMPTION=y implied PREEMPT_RCU=y. With PREEMPT_LAZY,
> that's no longer true. 

No, you want to make PREEMPTION=y + PREEMPT_RCU=n + PREEMPT_LAZY=y
possible. This is different. Your wording makes it sound like there _is_
an actual problem.

> That's because PREEMPT_RCU makes some trade-offs to optimize for
> latency as opposed to throughput, and configurations with limited
> preemption might prefer the stronger forward-progress guarantees of
> PREEMPT_RCU=n.
> 
> Accordingly, with standalone PREEMPT_LAZY (much like PREEMPT_NONE,
> PREEMPT_VOLUNTARY) we want to use PREEMPT_RCU=n. And, when used in
> conjunction with PREEMPT_DYNAMIC, we continue to use PREEMPT_RCU=y.
> 
> Patches 1 and 2 are cleanup patches:
>   "rcu: fix header guard for rcu_all_qs()"
>   "rcu: rename PREEMPT_AUTO to PREEMPT_LAZY"
> 
> Patch 3, "rcu: limit PREEMPT_RCU configurations", explicitly limits
> PREEMPT_RCU=y to the PREEMPT_DYNAMIC or the latency oriented models.
> 
> Patches 4 and 5,
>   "rcu: handle quiescent states for PREEMPT_RCU=n, PREEMPT_COUNT=y"
>   "osnoise: handle quiescent states for PREEMPT_RCU=n, PREEMPTION=y"
> 
> handle quiescent states for the (PREEMPT_LAZY=y, PREEMPT_RCU=n)
> configuration.

I was briefly thinking about 

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5646,8 +5646,11 @@ void sched_tick(void)
 	hw_pressure = arch_scale_hw_pressure(cpu_of(rq));
 	update_hw_load_avg(rq_clock_task(rq), rq, hw_pressure);
 
-	if (dynamic_preempt_lazy() && tif_test_bit(TIF_NEED_RESCHED_LAZY))
+	if (dynamic_preempt_lazy() && tif_test_bit(TIF_NEED_RESCHED_LAZY)) {
 		resched_curr(rq);
+		if (!IS_ENABLED(CONFIG_PREEMPT_RCU))
+			rcu_all_qs();
+	}
 
 	donor->sched_class->task_tick(rq, donor, 0);
 	if (sched_feat(LATENCY_WARN))

which should make #4+ #5 obsolete. But I think it is nicer to have the
change in #4 since it extends the check to cover all cases. And then
we would do it twice just for osnoise.

Sebastian

