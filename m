Return-Path: <linux-kernel+bounces-381511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5920E9B005E
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 12:43:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 723EE1C21A2A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 10:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 575B21DD54B;
	Fri, 25 Oct 2024 10:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0E/Q5tpL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nT37taNh"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 012E61D54C7
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 10:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729852984; cv=none; b=ePg/gaBHEKEkA3ghd59bLci9BTCR5/ppOdhog+F9eLXMd+0zX5Kf1PcRgJI2Yv8C7JzBO16/upIt0EsGN5k1Rg5dteRvl0TJU3m5Ff19aUV3INXsSbSDAB0xtAC8ig8VTK32cPwKv/UkH3IxijfQY5K5YHbx45gzyNaFIEjEyCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729852984; c=relaxed/simple;
	bh=71h2zGj8MSB25EUuoCbKqGvs4JQnd8MDS/H+TPkMgME=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tYSjtWso4qtoQjIqJR+tJuB3+0r/9UuIDp1+uu2D9BNTa6f4VNQfXmVy0t4LAWbUgYgIp+c2IKIPmyMsDHUVblzkPJ+jBwQjeN82qLs0kTljdzGpeuDvk5x0U/tFAGOuxIXcHImPlBMuoF5/HvatgqgnzomqOAegdqMccUeigj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0E/Q5tpL; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nT37taNh; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 25 Oct 2024 12:42:59 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729852981;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=w5gnA0SXFfhAA89zjSfiyD29XioS7+Tna8l/A0KYLpc=;
	b=0E/Q5tpLHgu+liNB+PYWr8faW1U5zCZxxfxCtblaiuQnNMgkbEyo1GhR4hSo+Yn0U1sEC8
	xaerVyXo/8Y6RjkIlbAsYkI4Aa6+GtFLYq7/L3R+LpD5SHMVy2W432V/Ssr+Y+N7ifuKuR
	Nsu1hYYoJ8mwpB6V5fHoWLgx9Fy4pfvwZWSFgkxy+t+F0nqOa9Xuvc+GVtSwF5KwLVrd7C
	tK7MW1wPiyht4+i9wZ4wSt1AfvF4xor/4X5MTfm7XQuqdu8uS/xZbnNKAgHNcFV/Z+9sJf
	B/14tW8dePhCiGoBZ6v599i0NM0HcRnwZGWJfmerDF3SAxpFMuqvCVLjttXRLw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729852981;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=w5gnA0SXFfhAA89zjSfiyD29XioS7+Tna8l/A0KYLpc=;
	b=nT37taNhKdaelBzlsBiWOb7KX1Z0R07aXUV+igWMpHT3EA9jVYaSjcoo3mDqZER1at7krr
	KX4+gh1uQOP8b+DA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, ankur.a.arora@oracle.com,
	efault@gmx.de, tglx@linutronix.de, mingo@kernel.org
Subject: Re: [PATCH 2/5] sched: Add Lazy preemption model
Message-ID: <20241025104259.NHrExSxO@linutronix.de>
References: <20241007074609.447006177@infradead.org>
 <20241007075055.331243614@infradead.org>
 <c1462c96-2b42-4a57-8560-60066d334248@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c1462c96-2b42-4a57-8560-60066d334248@linux.ibm.com>

On 2024-10-15 20:07:26 [+0530], Shrikanth Hegde wrote:
> 
> 
> On 10/7/24 13:16, Peter Zijlstra wrote:
> > Change fair to use resched_curr_lazy(), which, when the lazy
> > preemption model is selected, will set TIF_NEED_RESCHED_LAZY.
> > 
> > This LAZY bit will be promoted to the full NEED_RESCHED bit on tick.
> > As such, the average delay between setting LAZY and actually
> > rescheduling will be TICK_NSEC/2.
> 
> I didn't understand the math here. How?

If you set the LAZY bit you wait until sched_tick() which fires and this
happens every TICK_NSEC. In extreme case the timer fires either
immediately (right after setting the bit) or after TICK_NSEC (because it
just fired so it takes another TICK_NSEC). Given those two, assuming the
average would be in the middle.

> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -1103,6 +1106,32 @@ void resched_curr(struct rq *rq)
> >   	__resched_curr(rq, TIF_NEED_RESCHED);
> >   }
> > +#ifdef CONFIG_PREEMPT_DYNAMIC
> > +static DEFINE_STATIC_KEY_FALSE(sk_dynamic_preempt_lazy);
> > +static __always_inline bool dynamic_preempt_lazy(void)
> > +{
> > +	return static_branch_unlikely(&sk_dynamic_preempt_lazy);
> > +}
> > +#else
> > +static __always_inline bool dynamic_preempt_lazy(void)
> > +{
> > +	return IS_ENABLED(PREEMPT_LAZY);
> 
> 
> This should be CONFIG_PREEMPT_LAZY no?

Correct.

Sebastian

