Return-Path: <linux-kernel+bounces-360714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 803C6999E8B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 09:52:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB4C4B22E71
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 07:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD79B20A5E9;
	Fri, 11 Oct 2024 07:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="W82exMp5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1MdLcEGw"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A95BE207217
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 07:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728633140; cv=none; b=gD1Ht6gqhuUYly3kJEsIHEezAsLnEuqhpq0XsHM4voMzeFiVyv2zxqWPPxbMQrJAWT469LjWoGaIqzQx+OVMhNxfCBUrobe7qGNNGgqJb7nRNVuwP2Z8ZlC1/FXuLQA4r+SooGjfL6zqQ4OKTUfduQDPoKZ/O7uMEzkA5LmUN4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728633140; c=relaxed/simple;
	bh=tGpTff6Yl1tcHxLLrL7+BYvKwtngLm0TlhILQ//KWEs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o98f2qLMEDaETOhmyGGJ8dFJQkDgcUMJ2Vq+Gs6NfEH49dalqApN3rvB4eI+vCPeGm33j76EV6d2GoYePTshJQJgf2r/kUXyxHPYLtktREbXK/ntsFtjtbyOnOBrJnKs70p7aw72QCpxXdQMYDUfnD3yZBe6sLLbQadBM5BI8ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=W82exMp5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1MdLcEGw; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 11 Oct 2024 09:52:15 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728633136;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1yW6cQrOAdVKjwA8c6qWqeesCnQ9EMF7JJGm4eWCDgQ=;
	b=W82exMp5Zun3epxF6y9+GQG3Gp4QnNR8C/SU5vZSC1uKA/DQkebr79H9KCaFABDCT8zDBh
	pAzrPhufQgi+S5QScEmuA7+sVtZgRh2r0emoLJH7jSqT2Qqjn8qYig5ZjONobNRcn6CqDv
	xzaQbN0rDtKIp4362La2CzgBY9i35iFuA8ICnxxlXW1KUCbYZxtGW4tMNoKuQaZm0FPuSh
	UbtmHfXpnhckcYo/5cIxjI86z0kTUErktD/NRBLqoE4Eo+zOqeOS8YiyloMdywcBMvOgqK
	pTx2Kl0myDWNYJy+0NhfS4jXcV3TAq0lJbAwknJocvUnUQGJBXLzSjZru8F/FQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728633136;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1yW6cQrOAdVKjwA8c6qWqeesCnQ9EMF7JJGm4eWCDgQ=;
	b=1MdLcEGw7JXiHKeV/o9yH5PoceJrNEfA9jKCdXPloVwhr+TlL/2THbOieo/2+OekDsV3VD
	zVitM+hJ1EvcibCQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Ankur Arora <ankur.a.arora@oracle.com>
Cc: linux-kernel@vger.kernel.org, peterz@infradead.org, tglx@linutronix.de,
	paulmck@kernel.org, mingo@kernel.org, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, frederic@kernel.org, efault@gmx.de
Subject: Re: [PATCH 4/7] rcu: handle quiescent states for PREEMPT_RCU=n,
 PREEMPT_COUNT=y
Message-ID: <20241011075215.rEMWoctS@linutronix.de>
References: <20241009165411.3426937-1-ankur.a.arora@oracle.com>
 <20241009165411.3426937-5-ankur.a.arora@oracle.com>
 <20241010065044.kszYbjKa@linutronix.de>
 <87a5fb96zv.fsf@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87a5fb96zv.fsf@oracle.com>

On 2024-10-10 10:56:36 [-0700], Ankur Arora wrote:
> >
> > PREEMPT_LAZY selects PREEMPT_BUILD which selects PREEMPTION which in
> > turn selects PREEMPT_RCU. So this is not a valid combination. Do you
> > have a different tree than I do? Because maybe I am missing something.
> 
> The second patch in the series?

As long as "PREEMPT_RCU" as no text behind its bool you can't select it
independently.

> >> --- a/kernel/rcu/tree_plugin.h
> >> +++ b/kernel/rcu/tree_plugin.h
> >> @@ -974,13 +974,16 @@ static void rcu_preempt_check_blocked_tasks(struct rcu_node *rnp)
> >>   */
> >>  static void rcu_flavor_sched_clock_irq(int user)
> >>  {
> >> -	if (user || rcu_is_cpu_rrupt_from_idle()) {
> >> +	if (user || rcu_is_cpu_rrupt_from_idle() ||
> >> +	     (IS_ENABLED(CONFIG_PREEMPT_COUNT) &&
> >> +	      !(preempt_count() & (PREEMPT_MASK | SOFTIRQ_MASK)))) {
> >
> > couldn't you use a helper preemptible()?
> 
> Alas no. This check isn't trying to establish preemptibility (this is
> called in irq context so we already know that we aren't preemptible.)
> The check is using the preempt count to see if it can infer the state
> of RCU read side critical section on this CPU.

I see.

Sebastian

