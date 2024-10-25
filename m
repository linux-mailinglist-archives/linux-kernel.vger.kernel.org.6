Return-Path: <linux-kernel+bounces-381751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58C2C9B03C8
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 15:19:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C27DCB21F25
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 13:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E5BB212171;
	Fri, 25 Oct 2024 13:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GMgzJIXY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="P1FxEngj"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A191A212167
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 13:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729862375; cv=none; b=LlSt/fxa5gOkkJB3741dsYeYtEnDOugZIwBlsiedF/OQi8y/zikua9FKUwicQJLzHFTF5zcVdCnxAqIgMvop06D1xCsGHJDF/roXcTU2tA2e8ZzA8Wq2DHFKMfdFOkxu/s25GVR2oxd3hoQ5GJRVEGM5wI15W0c8Jmx1//xBSYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729862375; c=relaxed/simple;
	bh=h/nXSoCzi8upY64Z1TXiDZ9JZaa/yNyWfYxebAEpJo0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QfFdXAasvbNfMkdb9jqGGarPONt8l5ZLEs59766LTk3rODmSVsxMftPUhZk8TGzPXdn6rqd+9r/jThhKPJirBKkSUBeTrhMaES18nZF31NELdhab4l2EURbPxgf1F75YH+FxWOqu747p6P2R7aNKa6WcopYnkhKVoSVFZvu2mII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GMgzJIXY; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=P1FxEngj; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 25 Oct 2024 15:19:30 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729862372;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xZzoK6wO/WRgPUCt+z9le+lN0Jra0KXjelgNgcWkVDQ=;
	b=GMgzJIXYyttgAawwDtMWcFw1RQ+DU+cN1jbDGKV/l6P3WBgCLxEtEB1/q12q5BwavKh5qq
	8+e/VTIw++ZT62gZPztqTjqhrVrnsdIDABgvEz+EFv0TN1hA4MiL59HRdxrfLZI/+7XgCx
	LHTs1yHxvGq4AGMkaRZ4YObYaeqxiMVB4PsTIIRzkAm8ggPs15bttAp7obrFJfadA+bSph
	6WJjz8BftDcUBJ1hl/fKzFrKpvobRQqrGkX4k+ba3rxA2aDsh05FimdXzZJXmCDDcZE2tj
	VFiFhHkgJT6RlGmDALVPl1r56V2iFKZ/4eaFCI8BfWumv0IbO8u8FJZm1/3NLw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729862372;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xZzoK6wO/WRgPUCt+z9le+lN0Jra0KXjelgNgcWkVDQ=;
	b=P1FxEngjLVBCZa9nTxTh1zhpxy5n4gXygBCrcMoQm6zsoaJiNdSjupakr64qfHJRY+p99g
	RfmaaGjGnni8KwAQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, ankur.a.arora@oracle.com,
	efault@gmx.de, tglx@linutronix.de, mingo@kernel.org
Subject: Re: [PATCH 2/5] sched: Add Lazy preemption model
Message-ID: <20241025131930.cVOckvQQ@linutronix.de>
References: <20241007074609.447006177@infradead.org>
 <20241007075055.331243614@infradead.org>
 <e334aff9-248c-4a00-98e1-7bcb7cdd5e90@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e334aff9-248c-4a00-98e1-7bcb7cdd5e90@linux.ibm.com>

On 2024-10-22 22:14:41 [+0530], Shrikanth Hegde wrote:
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -1251,7 +1251,7 @@ static void update_curr(struct cfs_rq *c
> >   		return;
> >   	if (resched || did_preempt_short(cfs_rq, curr)) {
> 
> 
> 
> If there is a long running task, only after it is not eligible, LAZY would be set and
> subsequent tick would upgrade it to NR. If one sets sysctl_sched_base_slice to a large
> value (max 4seconds), LAZY would set thereafter(max 4 seconds) if there in no wakeup in
> that CPU.
> 
> If i set sysctl_sched_base_slice=300ms, spawn 2 stress-ng on one CPU, then LAZY bit is
> set usually after 300ms of sched_switch if there are no wakeups. Subsequent tick NR is set.
> Initially I was thinking, if there is a long running process, then LAZY would be set after
> one tick and on subsequent tick NR would set. I was wrong. It might take a long time for LAZY
> to be set, and On subsequent tick NR would be set.
> 
> That would be expected behavior since one setting sysctl_sched_base_slice know what to expect?

I guess so. Once the slice is up then the NEED_RESCHED bit is replaced
with the LAZY bit. That means a return-to-userland (from a syscall) or
the following tick will lead to a scheduling event.

> > -		resched_curr(rq);
> > +		resched_curr_lazy(rq);
> >   		clear_buddies(cfs_rq, curr);
> >   	}
> >   }
> > @@ -5677,7 +5677,7 @@ entity_tick(struct cfs_rq *cfs_rq, struc
> >   	 * validating it and just reschedule.
> >   	 */
> >   	if (queued) {
> 
> What's this queued used for? hrtick seems to set it. I haven't understood how it works.

from 20241009074631.GH17263@noisy.programming.kicks-ass.net:
| hrtick is disabled by default (because expensive) and so it doesn't
| matter much, but it's purpose is to increase accuracy and hence I left
| it untouched for now.

This setups a hrtimer for the (remaining) time slice and invokes the
task_tick from there (instead of the regular tick).

> > -		resched_curr(rq_of(cfs_rq));
> > +		resched_curr_lazy(rq_of(cfs_rq));
> >   		return;
> >   	}
> >   	/*
> > @@ -8832,7 +8832,7 @@ static void check_preempt_wakeup_fair(st
> >   	return;
> >   preempt:
> > -	resched_curr(rq);
> 
> Is it better to call resched_curr here? When the code arrives here, it wants to
> run pse as soon as possible right?

But wouldn't then every try_to_wakeup()/ wake_up() result in immediate
preemption? Letting it run and waiting to give up on its own, having the
preemption on return to userland results usually in better performance.
At least this is what I observed while playing with this.

> > +	resched_curr_lazy(rq);
> >   }
> >   static struct task_struct *pick_task_fair(struct rq *rq)

Sebastian

