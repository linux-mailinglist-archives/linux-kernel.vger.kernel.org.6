Return-Path: <linux-kernel+bounces-365650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1326799E579
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 13:22:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3C1E284F9F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 11:22:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E73B1D89E5;
	Tue, 15 Oct 2024 11:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lmFYsND+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="51W5OvM4"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C5E189BB2
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 11:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728991350; cv=none; b=bPqc2ZKzwBqG7pmU5rN46puC0Qm0K7xmWs8ROazL9IbBXY+pa2xkAcIq4zMRvFVqw7F6PmQ0sCiOvnwcsewlRNfdGHKQTPwtTTwk6wzVyAF+p5yLHSCG6+yzMEFxl84TsNGxFKYw7E5BVUn7nA7w/5JgUc2xM076/mM+JpVLSIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728991350; c=relaxed/simple;
	bh=l9zixqdbO86f1QDw7qjjC6928Ke1GhUvegfLPFHiGK4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S1c8mBYfGx9A9JBjHB6inGnEFaLHm3dGh1CM47hrWUCM9MisonzwK1CYDxF28aE/JBjwrEtnUzHl5Y38bvSIiNoVPe+ukq0+EE/PDOwoh/4z+wr/i/uG6Aobg/rWi5m0TVC1RwvDToFBQ8cOaiEf7GcM1JbKROo+FUAAQipmJRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lmFYsND+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=51W5OvM4; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 15 Oct 2024 13:22:24 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728991346;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CT+LuH/orq4Ghka+vVwg/J1goxkAahVcU/iAfJ58EJ0=;
	b=lmFYsND+yBtLsc7zoSdf8LcSOSknW3t8FWGTv2Mvh0FffexcXwp75mFck3GlZgGACpIO63
	dAjf+8N5oJLSR5Qg1aeLrKrooVkWd963XAFcVx326ycZSGhpjguKS6/PWQyZ0XiqSK0PbX
	B4lTeMswb3Mn+q7kbhdBkxQj3vQuAyt+sWYjep3B5vkSPWlAYfcX6MnOQanbj3P9WhFLDz
	WceBBTr+M+3F3k4XqkfKl9NtcWjRK904NFYo/4zBs+s1kgnxFfXd7FrQOgxjhdBcTChkeH
	qHYLpCW9vvuUm8CcQ/1F0Y3K7LiHdyQD99OXHkA9xPLRGIBDmr6kC84pfR2KhQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728991346;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CT+LuH/orq4Ghka+vVwg/J1goxkAahVcU/iAfJ58EJ0=;
	b=51W5OvM42OlLgy6x+FOrSZdTalkPSMOvLyWxJm5VXbJ0GswnN0NnKTzY+nw3x/7yWdS6xc
	NaJTyI0AvpsRMBCQ==
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
Message-ID: <20241015112224.KdvzKo80@linutronix.de>
References: <20241010081032.GA17263@noisy.programming.kicks-ass.net>
 <20241010091326.nK71dG4b@linutronix.de>
 <20241010100308.GE17263@noisy.programming.kicks-ass.net>
 <20241010102657.H7HpIbVp@linutronix.de>
 <20241010104438.GJ14587@noisy.programming.kicks-ass.net>
 <c6cbc343-01c3-4a38-8723-cc44e83dedf7@paulmck-laptop>
 <20241011081847.r2x73XIr@linutronix.de>
 <db3b0a4b-bec6-4b2b-bb22-d02179779cf9@paulmck-laptop>
 <20241011144341.mQKXkGkm@linutronix.de>
 <dcffa722-986a-437b-abb9-af9f4de852df@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <dcffa722-986a-437b-abb9-af9f4de852df@paulmck-laptop>

On 2024-10-11 08:59:14 [-0700], Paul E. McKenney wrote:
> On Fri, Oct 11, 2024 at 04:43:41PM +0200, Sebastian Andrzej Siewior wrote:
>
> > Okay, this eliminates PREEMPT_DYNAMIC then.
> > With PeterZ current series, PREEMPT_LAZY (without everything else
> > enabled) behaves as PREEMPT without the "forced" wake up for the fair
> > class. It is preemptible after all, with preempt_disable() actually
> > doing something. This might speak for preemptible RCU.
> > And assuming in this condition you that "low memory overhead RCU" which
> > is not PREEMPT_RCU. This might require a config option.
> 
> The PREEMPT_DYNAMIC case seems to work well as-is for the intended users,
> so I don't see a need to change it.  In particular, we already learned
> that we need to set PREEMPT_DYNAMIC=n.  Yes, had I caught this in time, I
> would have argued against changing the default, but this was successfully
> slid past me.
> 
> As for PREEMPT_LAZY, you seem to be suggesting a more intrusive change
> than just keeping non-preemptible RCU when the Kconfig options are
> consistent with this being expected.  If this is the case, what are the
> benefits of this more-intrusive change?

As far as I understand you are only concerned about PREEMPT_LAZY and
everything else (PREEMPT_LAZY + PREEMPT_DYNAMIC or PREEMPT_DYNAMIC
without PREEMPT_LAZY) is fine. 
In the PREEMPT_LAZY + !PREEMPT_DYNAMIC the suggested change

| config PREEMPT_RCU
| 	bool
| 	default y if (PREEMPT || PREEMPT_RT || PREEMPT_DYNAMIC)
| 	select TREE_RCU
| 	help

would disable PREEMPT_RCU while the default model is PREEMPT. You argue
that only people on small embedded would do such a thing and they would
like to safe additional memory. 
I don't think this is always the case because the "preemptible" users
would also get this and this is an unexpected change for them.

> > > > If you would like to add some relief to memory constrained systems,
> > > > wouldn't BASE_SMALL be something you could hook to? With EXPERT_RCU to
> > > > allow to override it?
> > > 
> > > Does BASE_SMALL affect anything but log buffer sizes?  Either way, we
> > > would still need to avoid the larger memory footprint of preemptible
> > > RCU that shows up due to RCU readers being preempted.
> > 
> > It only reduces data structures where possible. So lower performance is
> > probably due to things like futex hashmap (and others) are smaller.
> 
> Which is still counterproductive for use cases other than small deep
> embedded systems.

Okay, so that option is gone.

> > > Besides, we are not looking to give up performance vs BASE_SMALL's
> > > "may reduce performance" help text.
> > > 
> > > Yes, yes, it would simplify things to just get rid of non-preemptible RCU,
> > > but that is simply not in the cards at the moment.
> > 
> > Not sure what the time frame is here. If we go for LAZY and remove NONE
> > and VOLUNTARY then making PREEMPT_RCU would make sense to lower the
> > memory footprint (and not attaching to BASE_SMALL).
> > 
> > Is this what you intend or did misunderstand something here?
> 
> My requirement is that LAZY not remove/disable/whatever non-preemptible
> RCU.  Those currently using non-preemptible RCU should continue to be able
> to be able to use it, with or without LAZY.  So why is this requirement
> a problem for you?  Or am I missing your point?

Those who were using non-preemptible RCU, whish to use LAZY_PREEPMT +
!PREEMPT_DYNAMIC should be able to disable PREEMPT_RCU only in this case. 
Would the following work?

diff --git a/kernel/Kconfig.preempt b/kernel/Kconfig.preempt
index 8cf8a9a4d868c..2183c775e7808 100644
--- a/kernel/Kconfig.preempt
+++ b/kernel/Kconfig.preempt
@@ -121,6 +121,7 @@ config PREEMPT_COUNT
 config PREEMPTION
        bool
        select PREEMPT_COUNT
+       select PREEMPT_RCU if PREEMPT_DYNAMIC
 
 config PREEMPT_DYNAMIC
 	bool "Preemption behaviour defined on boot"
diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
index 3e079de0f5b43..9e4bdbbca4ff9 100644
--- a/kernel/rcu/Kconfig
+++ b/kernel/rcu/Kconfig
@@ -17,7 +17,7 @@ config TREE_RCU
 	  smaller systems.
 
 config PREEMPT_RCU
-	bool
+	bool "Preemptible RCU"
 	default y if PREEMPTION
 	select TREE_RCU
 	help
@@ -91,7 +91,7 @@ config NEED_TASKS_RCU
 
 config TASKS_RCU
 	bool
-	default NEED_TASKS_RCU && (PREEMPTION || PREEMPT_AUTO)
+	default NEED_TASKS_RCU && PREEMPTION
 	select IRQ_WORK
 
 config FORCE_TASKS_RUDE_RCU

I added TASKS_RCU to the hunk since I am not sure if you wish to follow
PREEMPTION (which is set by LAZY) or PREEMPT_RCU.

> 							Thanx, Paul

Sebastian

