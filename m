Return-Path: <linux-kernel+bounces-376369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF0C29AB070
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 16:09:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26BADB21B72
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 14:09:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 980EB19F423;
	Tue, 22 Oct 2024 14:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mWklX2JK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RHX/qFf+"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 001AF19F110
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 14:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729606182; cv=none; b=AVwNjyBB8dO/QbP44iELuIyw22oXmyX95PDSO1/HB2Y4V54GtZtLOo86oijoQWCzXntsrbLxm4rzcka/1qO8L+5LSZSgthY0QS812snb65pAbHU3C+PV3fTJSZzA7UYxtKsre3V9uVXME/Hsz3fViPmy3O8IRD2YV6eyggR7EIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729606182; c=relaxed/simple;
	bh=KePtIfKvz7t5CZSOBjyvIQxNGXZeKIYCh7cY8nEbcUk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q9vZWa4xiwrSwMD3LEmlwltFUwxG/mkPxBxvDpsdxyadQcYtR+I+8GFCWukhRyP4XssHfqrg0dXFV1EzCAzP3RsPUP7VeVe9t45DK6eNYnl/0sQ2U1UDC9iw+exdzY0mup121J2KNdMlhDjkztKWazPweZEjnm9YABq6q34sviY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mWklX2JK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RHX/qFf+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 22 Oct 2024 16:09:33 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729606176;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bjASl/u1BgwU2fmiInGolhgL0iePlqLpC0D1haqbAsw=;
	b=mWklX2JKCBvCdxhnY36hcmGS8ElztkGx7sfl0NR82aIes2D2v2obsDZSZBHfmpzpDmhGjC
	JLCjNJARpEXc7jD3BVRBW/FP2x1/4zPGmkB2GeVxkVHGbAzU0AARoUNZGJv5nxd4z30yEA
	0uF6ShU7ZtVdHNrHSwhUsyDE3ZP9nZN+hXsOahwO8UQ/TaNUKaJpkFlMbY73053tXSh02O
	PAmLeFfesTL6amFvz1RP1Pl7p9aQUUDx6uzYQl/sVrbO8pXOPoVwwAMk/n57/TQ0J8KkVT
	Db8YSfhYjDsNsuiJuna4+ytv8R3gL5OdqZoH2Hr7TZMXCqrxuowTxOq6kxs3MA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729606176;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bjASl/u1BgwU2fmiInGolhgL0iePlqLpC0D1haqbAsw=;
	b=RHX/qFf+u4qIOZu/H0KKQCs1g/iB/rhFlXpOAngAFhHo9aMY4kcrVkA0N3fzD0koSks0uV
	65nIgqB2fpa/dSCA==
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
Message-ID: <20241022140933.XfxSIpDu@linutronix.de>
References: <20241011081847.r2x73XIr@linutronix.de>
 <db3b0a4b-bec6-4b2b-bb22-d02179779cf9@paulmck-laptop>
 <20241011144341.mQKXkGkm@linutronix.de>
 <dcffa722-986a-437b-abb9-af9f4de852df@paulmck-laptop>
 <20241015112224.KdvzKo80@linutronix.de>
 <2a2a3ae6-ed0b-4afe-b48a-489cf19667a3@paulmck-laptop>
 <20241017070710.U9bTJFMS@linutronix.de>
 <0313c8c5-a6a0-4d09-9f85-ac5afa379041@paulmck-laptop>
 <20241021112755.m7dWNbc0@linutronix.de>
 <a71a7154-7cd4-44da-be41-5f2831fbfbbe@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a71a7154-7cd4-44da-be41-5f2831fbfbbe@paulmck-laptop>

On 2024-10-21 09:48:03 [-0700], Paul E. McKenney wrote:
> > We have now NONE, VOLUNTARY, PREEMPT, PREEMPT_RT (as in choose one).
> > 
> > This series changes it to NONE, VOLUNTARY, PREEMPT, LAZY, LAZIEST.
> > Ignore LAZIEST. PREEMPT_RT is a on/ off bool.
> 
> In terms of preemptibility, isn't the order from least to most preemptible
> NONE, VOLUNTARY, LAZIEST, LAZY, PREEMPT, and PREEMPT_RT?  After all,
> PREEMPT will preempt more aggressively than will LAZY which in turn
> preempts more aggressively than LAZIEST.
> 
> And I finally do see the later patch in Peter's series that removes
> PREEMPT_RT from the choice.  Plus I need to look more at LAZIEST in
> order to work out whether Peter's suckage is our robustness.  ;-)

For LAZIEST PeterZ added "do we want this?". I haven't tested this but
since there is no forced preemption at all, it should be what is NONE
without cond_resched() & friends. So I don't know if it stays, I don't
think so.

> > Based on my understanding so far, you have nothing to worry about.
> > 
> > With NONE + VOLUNTARY removed in favor of LAZY or without the removal
> > (yet)  you ask yourself what happens to those using NONE, go to LAZY and
> > want to stay with !PREEMPT_RCU, right?
> > With LAZY and !PREEMPT_DYNAMIC there is still PREEMPT_RCU as of now.
> > And you say people using !PREEMPT_DYNAMIC + LAZY are the old NONE/
> > VOLUNTARY users and want !PREEMPT_RCU.
> 
> Yes.
> 
> > This could be true but it could also attract people from PREEMPT which
> > expect additional performance gain due to LAZY and the same "preemption"
> > level. Additionally if PREEMPT gets removed because LAZY turns out to be
> > superior then PREEMPT_DYNAMIC makes probably no sense since there is
> > nothing to switch from/ to.
> 
> We definitely have users that would migrate from NONE to LAZY.  Shouldn't
> their needs outweigh the possible future users that might (or might not)
> find that (1) LAZY might be preferable to PREEMPT for some users and
> (2) That those users would prefer that RCU be preemptible?

Yes. I have no idea which of those two (PREEMPT_RCU vs !PREEMPT_RCU) is
to be preferred. Therefore I'm suggesting to make configurable here.

If you have a benchmark for memory consumption or anything else of
interest, I could throw it a box or two to get some numbers. I've been
looking at free memory at boot and this was almost the same (+- noise).

> > Therefore I would suggest to make PREEMPT_RCU 
> > - selectable for LAZY && !PREEMPT_DYNAMIC, default yes
> > - selected for LAZY && PREEMPT_DYNAMIC
> > - the current unchanged state for NONE, VOLUNTARY, PREEMPT (with
> >   !PREEMPT_DYNAMIC)
> > 
> > Does this make sense to you?
> 
> Not really.  At the very least, default no.
> 
> Unless LAZIEST makes the most sense for us (which will take time to
> figure out), in which case make PREMPT_RCU:
> 
> - hard-defined =n for LAZIEST.
> - selectable for LAZY && !PREEMPT_DYNAMIC, default yes
> - selected for LAZY && PREEMPT_DYNAMIC
> - the current unchanged state for NONE, VOLUNTARY, PREEMPT (with
>   !PREEMPT_DYNAMIC)
> 
> Or am I still missing some aspect of this series?

no, that is perfect.

> 							Thanx, Paul

Sebastian

