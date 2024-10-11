Return-Path: <linux-kernel+bounces-361316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BEE8699A6AC
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 16:43:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C7EC285A30
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 14:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E264A405FB;
	Fri, 11 Oct 2024 14:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MzlqQo4M";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2JFaV+P9"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 651BF184
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 14:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728657827; cv=none; b=USSK0ADpAKjf6lz1Xf3hFXqBVIrIy8MSdHMbi1e9WE+ghqXLZFdR1eFJR05Sr36BJlo3/vNdYcpvffssL6lwCUN3e4yx49yV9Xg3f9MIXVaCyaPgtpbKUiyD2BRb5zN9YWClgpMzMVR/9lDSHoudh2PlaLBVULAqafzlKDvcDNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728657827; c=relaxed/simple;
	bh=rLuAqrHqnQtPiGaaKFJfjGhpL4sBoZp/GQp9+y7dQxY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u3aSCjTnolQZ07q6OWY7Jm6++6UUM+qPm+APWwJaClXkm9VSxLKqFdiQE2IAeq+tAidy08NQzazsh6M4/1BFTcTT74W4uvU12uPmfIplUwYTKv3xhbemIaFLbV1TueMnc5m3NCsF90elAiKgSnL5NMAvyi/NXFhhXHsVTmZhW+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MzlqQo4M; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2JFaV+P9; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 11 Oct 2024 16:43:41 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728657823;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3sWakdeqicNBzwNf41WRrKyfVHSRpNLJGzn8mP5s1Wc=;
	b=MzlqQo4MBPz0WaQ31KkU7+4fmU4wdbtl2e6xubllFmhCqKBybUno0rGpQZ8mj1j6LienLg
	CGJiuXy0zdkTfpErUoT/W0cQ4AXJu0H0v5QU40GAdC1V54cMJNOqfYDTOIAx6zDgFuKigU
	5tieqO2LaJq14UPhrWvkSYz7oKYkc1ppAjVOMUIcFYdbTTQJRE5jLG/Wwe/NrKRR7JEBlc
	/rcQfdXcX6KCRVBjoXOC7e7PTp9AEgjgXI3w3csU0S4skbWd8mibJa1LG7zh3+1zKrZhe9
	wXDP8LOnBo38+T6zPMSi8l6DSkEWRG8zFE4ZpjILsFfRJ9pPa5/AM8z35Mxs/w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728657823;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3sWakdeqicNBzwNf41WRrKyfVHSRpNLJGzn8mP5s1Wc=;
	b=2JFaV+P9pLd/rX1mh3V01eYMo2IWTm4C7ln1B2Axlhsuzzsf0aDflmhuu8dhxroPRO2jNq
	40BYtV2IptvVo2DQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Ankur Arora <ankur.a.arora@oracle.com>,
	linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@kernel.org,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, frederic@kernel.org,
	efault@gmx.de
Subject: Re: [PATCH 2/7] rcu: limit PREEMPT_RCU configurations
Message-ID: <20241011144341.mQKXkGkm@linutronix.de>
References: <37af80bd-a54f-4ee4-9175-6f0f27b685a0@paulmck-laptop>
 <20241010063207.xIrynIqO@linutronix.de>
 <20241010081032.GA17263@noisy.programming.kicks-ass.net>
 <20241010091326.nK71dG4b@linutronix.de>
 <20241010100308.GE17263@noisy.programming.kicks-ass.net>
 <20241010102657.H7HpIbVp@linutronix.de>
 <20241010104438.GJ14587@noisy.programming.kicks-ass.net>
 <c6cbc343-01c3-4a38-8723-cc44e83dedf7@paulmck-laptop>
 <20241011081847.r2x73XIr@linutronix.de>
 <db3b0a4b-bec6-4b2b-bb22-d02179779cf9@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <db3b0a4b-bec6-4b2b-bb22-d02179779cf9@paulmck-laptop>

On 2024-10-11 06:59:44 [-0700], Paul E. McKenney wrote:
> > > If you have PREEMPT_DYNAMIC, presumably you would like to boot with
> > > preemption enabled, and would like it to act as if you had built the
> > > kernel to be unconditionally preemptible, so again you need preemptible
> > > RCU, and so the defaults should supply it.
> > > 
> > > If you started off building a non-preemptible kernel, then you are not
> > > using one of the major distros (last I checked).  There is a good chance
> > > that you have a large number of systems, and are thus deeply interested
> > > in minimizing memory cost.  In which case, you need non-preemptible
> > > RCU in the new-age lazy-preemptible kernel.
> > > 
> > > Hence the choice of non-preemptible RCU as the default in a kernel that,
> > > without lazy preemption, would use non-preemptible RCU.
> > 
> > I *think* I slowly begin to understand. So we have LAZY and DYNAMIC
> > enabled then and PREEMPT_RCU depends on the default choice which is
> > either FULL (yes, please) or NONE/VOLUNTARY (no, thank you). But then if
> > you change the model at runtime (or boottime) from (default) NONE to
> > FULL you don't have preemptible RCU anymore.
> 
> Almost.  If you are able to change the model at boot time or at run time,
> then you *always* have preemptible RCU.

Okay, this eliminates PREEMPT_DYNAMIC then.
With PeterZ current series, PREEMPT_LAZY (without everything else
enabled) behaves as PREEMPT without the "forced" wake up for the fair
class. It is preemptible after all, with preempt_disable() actually
doing something. This might speak for preemptible RCU.
And assuming in this condition you that "low memory overhead RCU" which
is not PREEMPT_RCU. This might require a config option.

> > If you would like to add some relief to memory constrained systems,
> > wouldn't BASE_SMALL be something you could hook to? With EXPERT_RCU to
> > allow to override it?
> 
> Does BASE_SMALL affect anything but log buffer sizes?  Either way, we
> would still need to avoid the larger memory footprint of preemptible
> RCU that shows up due to RCU readers being preempted.

It only reduces data structures where possible. So lower performance is
probably due to things like futex hashmap (and others) are smaller.

> Besides, we are not looking to give up performance vs BASE_SMALL's
> "may reduce performance" help text.
> 
> Yes, yes, it would simplify things to just get rid of non-preemptible RCU,
> but that is simply not in the cards at the moment.

Not sure what the time frame is here. If we go for LAZY and remove NONE
and VOLUNTARY then making PREEMPT_RCU would make sense to lower the
memory footprint (and not attaching to BASE_SMALL).

Is this what you intend or did misunderstand something here?

> 							Thanx, Paul

Sebastian

